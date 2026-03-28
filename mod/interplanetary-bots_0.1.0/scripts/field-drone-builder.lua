-- scripts/field-drone-builder.lua
-- Nanobots-style scripted builder for the Field Drone Depot.
--
-- Each tick-call: for every tracked depot, find ghosts within construction
-- radius, pull items from nearby Field Chests, consume a repair pack from the
-- depot's material slots, revive the ghost, and fire a cosmetic projectile.
--
-- No real construction-robot entities are involved.

local builder = {}

local DEPOT_NAME      = "pb-field-drone-depot"
local CHEST_NAME      = "pb-field-chest"
local PROJECTILE_NAME = "pb-field-drone-projectile"
local AMMO_NAME       = "repair-pack"

local BUILD_PER_TICK  = settings.startup["pb-field-depot-build-per-tick"].value

-- ── Depot tracking ──────────────────────────────────────────────────────────

function builder.init()
  storage.field_depots = storage.field_depots or {}
  for _, surface in pairs(game.surfaces) do
    local depots = surface.find_entities_filtered({ name = DEPOT_NAME })
    for _, depot in pairs(depots) do
      storage.field_depots[depot.unit_number] = depot
    end
  end
end

function builder.on_built(event)
  local entity = event.entity
  if not (entity and entity.valid) then return end
  if entity.name == DEPOT_NAME then
    storage.field_depots[entity.unit_number] = entity
  end
end

function builder.on_removed(event)
  local entity = event.entity
  if not (entity and entity.valid) then return end
  if entity.name == DEPOT_NAME then
    storage.field_depots[entity.unit_number] = nil
  end
end

-- ── Item helpers ─────────────────────────────────────────────────────────────

local function depot_has_ammo(depot)
  local inv = depot.get_inventory(defines.inventory.roboport_material)
  if not inv then return false end
  return inv.get_item_count(AMMO_NAME) > 0
end

local function consume_ammo(depot)
  local inv = depot.get_inventory(defines.inventory.roboport_material)
  inv.remove({ name = AMMO_NAME, count = 1 })
end

local function find_chest_with_items(chests, items)
  for _, chest in pairs(chests) do
    if chest.valid then
      local inv = chest.get_inventory(defines.inventory.chest)
      if inv then
        local has_all = true
        for _, item_stack in pairs(items) do
          if inv.get_item_count(item_stack.name) < item_stack.count then
            has_all = false
            break
          end
        end
        if has_all then return chest end
      end
    end
  end
  return nil
end

local function consume_items_from_chest(chest, items)
  local inv = chest.get_inventory(defines.inventory.chest)
  for _, item_stack in pairs(items) do
    inv.remove({ name = item_stack.name, count = item_stack.count })
  end
end

local function spawn_projectile(surface, source_pos, target_pos)
  surface.create_entity({
    name     = PROJECTILE_NAME,
    position = source_pos,
    target   = target_pos,
    speed    = 0.3,
  })
end

-- ── Core build loop ─────────────────────────────────────────────────────────

function builder.on_tick()
  if not storage.field_depots then return end

  for unit_number, depot in pairs(storage.field_depots) do
    if not (depot and depot.valid) then
      storage.field_depots[unit_number] = nil
      goto next_depot
    end

    if not depot_has_ammo(depot) then goto next_depot end

    local surface = depot.surface
    local pos     = depot.position
    local radius  = depot.prototype.construction_radius

    local chests = surface.find_entities_filtered({
      name     = CHEST_NAME,
      position = pos,
      radius   = radius,
    })
    if #chests == 0 then goto next_depot end

    local ghosts = surface.find_entities_filtered({
      type     = "entity-ghost",
      position = pos,
      radius   = radius,
    })

    local tile_ghosts = surface.find_entities_filtered({
      type     = "tile-ghost",
      position = pos,
      radius   = radius,
    })

    -- Merge ghost lists
    for _, tg in pairs(tile_ghosts) do
      ghosts[#ghosts + 1] = tg
    end

    local built = 0
    for _, ghost in pairs(ghosts) do
      if built >= BUILD_PER_TICK then break end
      if not (ghost and ghost.valid) then goto next_ghost end

      local proto = ghost.ghost_prototype
      local items_needed = proto.items_to_place_this
      if not items_needed or #items_needed == 0 then goto next_ghost end

      local chest = find_chest_with_items(chests, items_needed)
      if not chest then goto next_ghost end
      if not depot_has_ammo(depot) then break end

      consume_items_from_chest(chest, items_needed)
      consume_ammo(depot)

      local ghost_pos = ghost.position
      local _, revived = ghost.revive({ raise_revive = true })

      spawn_projectile(surface, pos, ghost_pos)
      built = built + 1

      ::next_ghost::
    end

    ::next_depot::
  end
end

return builder
