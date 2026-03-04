-- control.lua
-- Runtime scripting for PlanetBots.
-- Two responsibilities only:
--   1. Placement variant swap: on_built_entity checks surface, swaps to home or foreign variant
--   2. Field Drone depot cap: count depots per force, cancel build if over cap

local placement = require("scripts.placement")
local depot_cap  = require("scripts.depot-cap")

-- ─── Event Registration ────────────────────────────────────────────────────

script.on_event(defines.events.on_built_entity,          placement.on_built)
script.on_event(defines.events.on_robot_built_entity,    placement.on_built)
script.on_event(defines.events.script_raised_built,      placement.on_built)

-- Depot cap is checked inside placement.on_built for Field Drone Depots.
-- depot_cap module exposes the cap table and research upgrade hook.

script.on_event(defines.events.on_research_finished,     depot_cap.on_research_finished)

-- ─── Init / Load ──────────────────────────────────────────────────────────

script.on_init(function()
  depot_cap.init()
end)

script.on_load(function()
  -- nothing stateful to restore beyond what storage holds
end)
