-- scripts/compost-chest.lua
-- Runtime logic for the Gleba Compost Chest (pb-gleba-compost-chest).
--
-- Mechanic:
--   Slot 1 is locked to "nutrient" at build time via LuaInventory.set_filter().
--   Every 60 ticks (1 second) the script checks all registered chests:
--     FUELED (nutrient in slot 1):
--       - 1 nutrient consumed every 3600 ticks (1 minute).
--       - All other stacks: spoil_tick pushed forward 51 ticks per cycle.
--         Net decay: 9 ticks per 60 real ticks = 15% of normal spoil rate.
--     UNFUELED (slot 1 empty):
--       - All other stacks: spoil_tick retracted 18 ticks per cycle.
--         Net decay: 78 ticks per 60 real ticks = 130% of normal spoil rate.
--         (CoVe: softened from 2.0x to 1.3x — 200% was worse than no chest at all)
--
-- Registration:
--   on_built_entity, on_robot_built_entity, script_raised_built:
--     register chest, init state, lock slot 1.
--   on_entity_died, on_player_mined_entity, on_robot_mined_entity:
--     deregister from storage.

local compost = {}

local CHEST_NAME    = "pb-gleba-compost-chest"
local FUEL_ITEM     = "nutrient"
local TICK_INTERVAL = 60      -- run every 1 second
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
  if not (entity and entity.name == CHEST_NAME) then return end
  local unit = entity.unit_number
  if storage.compost_chests then storage.compost_chests[unit] = nil end
  if storage.compost_state  then storage.compost_state[unit]  = nil end
end

-- ─── Core spoilage tick ────────────────────────────────────────────────────

local function tick_all_chests()
  if not storage.compost_chests then return end
  local now = game.tick

  for unit, entity in pairs(storage.compost_chests) do
    if not (entity and entity.valid) then
      storage.compost_chests[unit] = nil
      storage.compost_state[unit]  = nil
    else
      local inv   = entity.get_inventory(defines.inventory.chest)
      if not inv then goto continue end

      local state = storage.compost_state[unit]
      local fuel  = inv[1]
      local fueled = fuel.valid_for_read and fuel.name == FUEL_ITEM

      -- Consume fuel
      if fueled then
        state.ticks_since_consumed = (state.ticks_since_consumed or 0) + TICK_INTERVAL
        if state.ticks_since_consumed >= FUEL_INTERVAL then
          fuel.count = fuel.count - 1
          state.ticks_since_consumed = 0
          -- Re-check: consuming the last nutrient may have emptied the slot
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
            -- Clamp: never push below current tick (would trigger instant spoilage loop)
            stack.spoil_tick = math.max(new_tick, now + 1)
          end
        end
      end

      ::continue::
    end
  end
end

-- ─── Event registration ────────────────────────────────────────────────────

function compost.register_events()
  -- Build events
  local build_handler = function(event)
    register(event.entity or event.created_entity)
  end
  script.on_event(defines.events.on_built_entity,       build_handler)
  script.on_event(defines.events.on_robot_built_entity, build_handler)
  script.on_event(defines.events.script_raised_built,   build_handler)  -- blueprints

  -- Remove events
  local remove_handler = function(event)
    deregister(event.entity)
  end
  script.on_event(defines.events.on_entity_died,           remove_handler)
  script.on_event(defines.events.on_player_mined_entity,   remove_handler)
  script.on_event(defines.events.on_robot_mined_entity,    remove_handler)
  script.on_event(defines.events.script_raised_destroy,    remove_handler)

  -- Periodic spoilage tick
  script.on_nth_tick(TICK_INTERVAL, function() tick_all_chests() end)
end

-- ─── Init / Load ──────────────────────────────────────────────────────────

function compost.init()
  storage.compost_chests = storage.compost_chests or {}
  storage.compost_state  = storage.compost_state  or {}
  -- Scan existing surfaces to pick up chests placed before this mod version
  for _, surface in pairs(game.surfaces) do
    local chests = surface.find_entities_filtered({ name = CHEST_NAME })
    for _, entity in pairs(chests) do
      register(entity)
    end
  end
end

return compost
