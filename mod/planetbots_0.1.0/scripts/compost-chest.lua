-- scripts/compost-chest.lua
-- Runtime logic for the Gleba Compost Chest (pb-gleba-compost-chest).
--
-- Mechanic:
--   Slot 1 is locked to "nutrient" at build time via LuaInventory.set_filter().
--   Every 60 ticks (1 second) the tick handler checks all registered chests:
--     FUELED (nutrient in slot 1):
--       - 1 nutrient consumed every 3600 ticks (1 minute).
--       - All other stacks: spoil_tick pushed forward 51 ticks per cycle.
--         Net decay: 9 ticks per 60 real ticks = 15% of normal spoil rate.
--     UNFUELED (slot 1 empty):
--       - All other stacks: spoil_tick retracted 18 ticks per cycle.
--         Net decay: 78 ticks per 60 real ticks = 130% of normal spoil rate.
--         (CoVe: softened from 2.0x to 1.3x — 200% was worse than no chest at all)
--
-- IMPORTANT: This module does NOT call script.on_event() or script.on_nth_tick()
-- itself. control.lua owns all event registrations to avoid overwriting other
-- module handlers (Factorio allows only one handler per event per mod).
-- control.lua calls: compost.on_built(event), compost.on_removed(event),
--                    compost.on_tick(event), compost.init().

local compost = {}

local CHEST_NAME    = "pb-gleba-compost-chest"
local FUEL_ITEM     = "nutrients"   -- confirmed: Space Age item name is plural
local TICK_INTERVAL = 60      -- registered in control.lua as on_nth_tick(60)
local FUEL_INTERVAL = 3600    -- consume 1 nutrient per minute
local SLOW_PUSH     = 51      -- ticks pushed forward per cycle when fueled (15% rate)
local FAST_RETRACT  = 18      -- ticks retracted per cycle when unfueled (130% rate)

-- ─── Registration helpers ──────────────────────────────────────────────────

local function register(entity)
  if not (entity and entity.valid and entity.name == CHEST_NAME) then return end
  local unit = entity.unit_number
  storage.compost_chests = storage.compost_chests or {}
  storage.compost_state  = storage.compost_state  or {}
  storage.compost_chests[unit] = entity
  storage.compost_state[unit]  = { ticks_since_consumed = 0 }
  -- Lock slot 1 to nutrient
  local inv = entity.get_inventory(defines.inventory.chest)
  if inv and inv.supports_filters() then
    inv.set_filter(1, FUEL_ITEM)
  end
end

local function deregister(entity)
  if not (entity and entity.valid and entity.name == CHEST_NAME) then return end
  local unit = entity.unit_number
  if storage.compost_chests then storage.compost_chests[unit] = nil end
  if storage.compost_state  then storage.compost_state[unit]  = nil end
end

-- ─── Public event handlers (called from control.lua) ──────────────────────

-- Called from control.lua's on_build dispatcher.
-- Handles on_built_entity, on_robot_built_entity, script_raised_built.
function compost.on_built(event)
  -- Factorio 2.0 uses event.entity for all three build events.
  register(event.entity)
end

-- Called from control.lua's on_remove dispatcher.
-- Handles on_entity_died, on_player_mined_entity, on_robot_mined_entity,
-- script_raised_destroy.
function compost.on_removed(event)
  deregister(event.entity)
end

-- Called from control.lua via script.on_nth_tick(60).
function compost.on_tick()
  if not storage.compost_chests then return end
  local now = game.tick

  for unit, entity in pairs(storage.compost_chests) do
    if not (entity and entity.valid) then
      storage.compost_chests[unit] = nil
      if storage.compost_state then storage.compost_state[unit] = nil end
    else
      local inv = entity.get_inventory(defines.inventory.chest)
      if not inv then goto continue end

      -- Guard: state may be nil for chests placed before this mod version installed
      local state = storage.compost_state[unit]
      if not state then
        storage.compost_state[unit] = { ticks_since_consumed = 0 }
        state = storage.compost_state[unit]
      end
      local fuel  = inv[1]
      local fueled = fuel.valid_for_read and fuel.name == FUEL_ITEM

      -- Consume fuel
      if fueled then
        state.ticks_since_consumed = (state.ticks_since_consumed or 0) + TICK_INTERVAL
        if state.ticks_since_consumed >= FUEL_INTERVAL then
          fuel.count = fuel.count - 1
          state.ticks_since_consumed = 0
          -- Re-check: consuming the last nutrient may have cleared the slot
          fueled = fuel.valid_for_read and fuel.name == FUEL_ITEM
        end
      end

      -- Adjust spoil_tick for storage slots (2 onward)
      for i = 2, #inv do
        local stack = inv[i]
        if stack.valid_for_read and stack.spoil_tick > 0 then
          if fueled then
            -- Push expiry forward: net 9 real ticks decay per 60-tick cycle = 15% rate
            stack.spoil_tick = stack.spoil_tick + SLOW_PUSH
          else
            -- Retract expiry: net 78 real ticks decay per 60-tick cycle = 130% rate
            local new_tick = stack.spoil_tick - FAST_RETRACT
            -- Clamp: never set below current tick (would cause an instant-spoilage loop)
            stack.spoil_tick = math.max(new_tick, now + 1)
          end
        end
      end

      ::continue::
    end
  end
end

-- ─── Init ──────────────────────────────────────────────────────────────────

-- Called from control.lua's on_init handler.
function compost.init()
  storage.compost_chests = storage.compost_chests or {}
  storage.compost_state  = storage.compost_state  or {}
  -- Scan all surfaces: picks up chests placed before this mod version was installed.
  for _, surface in pairs(game.surfaces) do
    local chests = surface.find_entities_filtered({ name = CHEST_NAME })
    for _, entity in pairs(chests) do
      register(entity)
    end
  end
end

return compost
