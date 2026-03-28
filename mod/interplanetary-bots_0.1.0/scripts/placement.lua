-- scripts/placement.lua
-- Runtime placement checks:
--
--   1. Field Drone Depot cap enforcement (depot-cap.lua).
--   2. Off-Nauvis block for depot and chest — return item, cancel placement.
--   3. Field Chest must be within a depot's construction radius, 1 per depot.
--   4. Flying-text hint when a depot is placed successfully.

local depot_cap = require("scripts.depot-cap")
local placement = {}

local DEPOT_NAME = "pb-field-drone-depot"
local CHEST_NAME = "pb-field-chest"

local NAUVIS_ONLY = {
  [DEPOT_NAME] = DEPOT_NAME,
  [CHEST_NAME] = CHEST_NAME,
}

local function return_item_to_player(entity, item_name)
  local last_user = entity.last_user
  if last_user and last_user.valid then
    last_user.insert({ name = item_name, count = 1 })
  else
    entity.surface.spill_item_stack(
      entity.position, { name = item_name, count = 1 }, true)
  end
  entity.destroy()
end

local function check_nauvis_only(entity)
  local return_item = NAUVIS_ONLY[entity.name]
  if not return_item then return false end
  if entity.surface.name == "nauvis" then return false end

  return_item_to_player(entity, return_item)
  return true
end

local function check_chest_placement(entity)
  if entity.name ~= CHEST_NAME then return false end

  local surface = entity.surface
  local chest_pos = entity.position
  local depots = surface.find_entities_filtered({ name = DEPOT_NAME })

  local any_in_range = false
  for _, depot in pairs(depots) do
    if depot.valid then
      local radius = depot.prototype.construction_radius
      local dp = depot.position
      local dx = chest_pos.x - dp.x
      local dy = chest_pos.y - dp.y
      if (dx * dx + dy * dy) <= (radius * radius) then
        any_in_range = true
        local existing_chests = surface.find_entities_filtered({
          name     = CHEST_NAME,
          position = dp,
          radius   = radius,
        })
        local other_count = 0
        for _, ch in pairs(existing_chests) do
          if ch.valid and ch.unit_number ~= entity.unit_number then
            other_count = other_count + 1
          end
        end
        if other_count == 0 then
          return false
        end
      end
    end
  end

  local last_user = entity.last_user
  if last_user and last_user.valid then
    if any_in_range then
      last_user.print({ "pb-msg.chest-limit-reached" })
    else
      last_user.print({ "pb-msg.chest-no-depot" })
    end
  end
  return_item_to_player(entity, CHEST_NAME)
  return true
end

function placement.on_built(event)
  local entity = event.entity
  if not (entity and entity.valid) then return end

  if depot_cap.check_and_enforce(entity) then return end

  if check_nauvis_only(entity) then return end

  if check_chest_placement(entity) then return end

  if entity.valid and entity.name == DEPOT_NAME then
    entity.surface.create_entity({
      name     = "flying-text",
      position = entity.position,
      text     = { "pb-msg.depot-place-chest-hint" },
      color    = { r = 1, g = 0.8, b = 0.2 },
    })
  end
end

return placement
