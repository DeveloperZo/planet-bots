-- scripts/placement.lua
-- Runtime placement checks. Handles two cases only:
--
--   1. Field Drone Depot cap enforcement (depot-cap.lua).
--   2. Field Drone Depot / Field Drone off-Nauvis block — return item, cancel placement.
--
-- Roboport variant selection is handled at the data stage via surface_conditions on
-- recipes (prototypes/recipes/roboports.lua, prototypes/recipes/bots.lua).
-- The item's place_result points directly to the correct entity; no runtime swap needed.
--
-- Cargo pod variant normalization (home/foreign swap on delivery) is not yet
-- implemented. TODO: on_cargo_pod_delivered_cargo.

local depot_cap = require("scripts.depot-cap")
local placement = {}

-- Entities that are blocked off their home planet entirely (no foreign variant).
-- Maps entity name => item name to return to the player.
local NAUVIS_ONLY = {
  ["pb-field-drone-depot"] = "pb-field-drone-depot",
  ["pb-field-drone-home"]  = "pb-field-drone",
}

function placement.on_built(event)
  local entity = event.entity or event.created_entity
  if not (entity and entity.valid) then return end

  -- Depot cap check runs first — destroys entity and returns item if cap exceeded.
  if depot_cap.check_and_enforce(entity) then return end

  -- Block Nauvis-only entities off Nauvis.
  local return_item = NAUVIS_ONLY[entity.name]
  if return_item and entity.surface.name ~= "nauvis" then
    local last_user = entity.last_user
    if last_user and last_user.valid then
      last_user.insert({ name = return_item, count = 1 })
    end
    entity.destroy()
    return
  end
end

return placement
