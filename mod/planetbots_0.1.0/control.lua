-- control.lua
-- Runtime scripting for PlanetBots.
--
-- Responsibilities:
--   1. Field Drone Depot placement: off-Nauvis block + depot cap enforcement.
--   2. Fulgora logistic bot: electric damage hardening (lightning immunity).
--   3. Gleba compost chest: nutrient fuel slot + spoilage rate management.
--
-- Cargo pod variant normalization removed: no home/foreign variants in this design.

local placement = require("scripts.placement")
local depot_cap = require("scripts.depot-cap")
local hardening = require("scripts.fulgora-hardening")
local compost   = require("scripts.compost-chest")

-- ─── Build / placement events ────────────────────────────────────────────────

script.on_event(defines.events.on_built_entity,       placement.on_built)
script.on_event(defines.events.on_robot_built_entity, placement.on_built)
script.on_event(defines.events.script_raised_built,   placement.on_built)

-- ─── Research ───────────────────────────────────────────────────────────────

script.on_event(defines.events.on_research_finished, depot_cap.on_research_finished)

-- ─── Fulgora hardening ──────────────────────────────────────────────────────

hardening.register()

-- ─── Compost chest ──────────────────────────────────────────────────────────

compost.register_events()

-- ─── Init / Load ────────────────────────────────────────────────────────────

script.on_init(function()
  depot_cap.init()
  compost.init()
end)

script.on_load(function()
  -- storage is already populated; no re-init needed
end)
