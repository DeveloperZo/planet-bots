-- scripts/depot-cap.lua
-- Enforces a per-force cap on Field Drone Depots.
-- Cap starts at 1 and increases via research up to 5.
-- After that, vanilla robotics is available and the cap becomes irrelevant.

local depot_cap = {}

-- Research name → new cap value
-- Define these technology names in prototypes/technologies/
local RESEARCH_CAPS = {
  ["pb-field-depot-capacity-1"] = 2,
  ["pb-field-depot-capacity-2"] = 3,
  ["pb-field-depot-capacity-3"] = 4,
  ["pb-field-depot-capacity-4"] = 5,
}

local DEPOT_NAME = "pb-field-drone-depot"

function depot_cap.init()
  -- storage persists across saves; initialize if first run
  storage.depot_caps = storage.depot_caps or {}
  -- Default cap of 1 for all existing forces
  for _, force in pairs(game.forces) do
    if not storage.depot_caps[force.index] then
      storage.depot_caps[force.index] = 1
    end
  end
end

local function get_cap(force)
  return storage.depot_caps[force.index] or 1
end

local function count_depots(force, surface)
  -- Count across all surfaces for this force
  local count = 0
  for _, s in pairs(game.surfaces) do
    local depots = s.find_entities_filtered({ name = DEPOT_NAME, force = force })
    count = count + #depots
  end
  return count
end

-- Called from placement.on_built BEFORE the entity is finalized.
-- Returns true if placement should be cancelled.
function depot_cap.check_and_enforce(entity)
  if entity.name ~= DEPOT_NAME then return false end

  local force   = entity.force
  local cap     = get_cap(force)
  -- Count includes the entity just placed, so > cap means over limit
  local current = count_depots(force, entity.surface)

  if current > cap then
    local player = entity.last_user
    if player and player.valid then
      player.print({ "pb-msg.depot-cap-reached", cap })
      player.insert({ name = "pb-field-drone-depot", count = 1 })
    else
      -- Robot-built over cap: spill item near the position so bots can recollect
      entity.surface.spill_item_stack(
        entity.position, { name = "pb-field-drone-depot", count = 1 }, true)
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
  -- math.max prevents regression if research events arrive out of order
  -- (e.g. /c force.research_all_technologies() fires events in prototype order)
  storage.depot_caps[force.index] = math.max(
    storage.depot_caps[force.index] or 1,
    new_cap
  )
end

return depot_cap
