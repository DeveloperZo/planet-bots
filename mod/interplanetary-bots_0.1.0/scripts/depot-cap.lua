-- scripts/depot-cap.lua
-- Enforces a per-force cap on Field Drone Depots.
-- Chests are not capped here; they are limited to 1 per depot area by
-- placement.lua instead.
-- Cap starts at 1 and increases via research up to 5.

local depot_cap = {}

local DEPOT_NAME = "pb-field-drone-depot"

local RESEARCH_CAPS = {
  ["pb-field-depot-capacity-1"] = 2,
  ["pb-field-depot-capacity-2"] = 3,
  ["pb-field-depot-capacity-3"] = 4,
  ["pb-field-depot-capacity-4"] = 5,
}

local DEFAULT_CAP = 1

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

local function count_depots(force)
  local count = 0
  for _, surface in pairs(game.surfaces) do
    local found = surface.find_entities_filtered({ name = DEPOT_NAME, force = force })
    count = count + #found
  end
  return count
end

function depot_cap.check_and_enforce(entity)
  if entity.name ~= DEPOT_NAME then return false end

  local force   = entity.force
  local cap     = get_cap(force)
  local current = count_depots(force)

  if current > cap then
    local player = entity.last_user
    if player and player.valid then
      player.print({ "pb-msg.depot-cap-reached", cap })
      player.insert({ name = DEPOT_NAME, count = 1 })
    else
      entity.surface.spill_item_stack(
        entity.position, { name = DEPOT_NAME, count = 1 }, true)
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
