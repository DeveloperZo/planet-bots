-- scripts/depot-cap.lua
-- Enforces a per-force cap on Field Drone Depots AND Field Chests (shared cap).
-- Cap starts at 3 and increases via research up to 14.
-- After that, vanilla robotics is available and the cap becomes irrelevant.

local depot_cap = {}

local RESEARCH_CAPS = {
  ["pb-field-depot-capacity-1"] = 5,
  ["pb-field-depot-capacity-2"] = 7,
  ["pb-field-depot-capacity-3"] = 10,
  ["pb-field-depot-capacity-4"] = 14,
}

local DEFAULT_CAP = 3

local CAPPED_ENTITIES = {
  ["pb-field-drone-depot"] = "pb-field-drone-depot",
  ["pb-field-chest"]       = "pb-field-chest",
}

function depot_cap.init()
  storage.depot_caps = storage.depot_caps or {}
  for _, force in pairs(game.forces) do
    if not storage.depot_caps[force.index] then
      storage.depot_caps[force.index] = DEFAULT_CAP
    end
  end
end

local function get_cap(force)
  return storage.depot_caps[force.index] or DEFAULT_CAP
end

local function count_capped_entities(force)
  local count = 0
  for _, surface in pairs(game.surfaces) do
    for entity_name, _ in pairs(CAPPED_ENTITIES) do
      local found = surface.find_entities_filtered({ name = entity_name, force = force })
      count = count + #found
    end
  end
  return count
end

function depot_cap.check_and_enforce(entity)
  local return_item = CAPPED_ENTITIES[entity.name]
  if not return_item then return false end

  local force   = entity.force
  local cap     = get_cap(force)
  local current = count_capped_entities(force)

  if current > cap then
    local player = entity.last_user
    if player and player.valid then
      player.print({ "pb-msg.depot-cap-reached", cap })
      player.insert({ name = return_item, count = 1 })
    else
      entity.surface.spill_item_stack(
        entity.position, { name = return_item, count = 1 }, true)
    end
    entity.destroy({ raise_destroy = false })
    return true
  end

  return false
end

function depot_cap.on_research_finished(event)
  local tech = event.research
  local new_cap = RESEARCH_CAPS[tech.name]
  if not new_cap then return end

  local force = tech.force
  storage.depot_caps[force.index] = math.max(
    storage.depot_caps[force.index] or DEFAULT_CAP,
    new_cap
  )
end

return depot_cap
