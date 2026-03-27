-- control.lua
-- Runtime scripting for PlanetBots.
--
-- Responsibilities:
--   1. Field Drone Depot placement: off-Nauvis block + depot cap enforcement.
--   2. Fulgora logistic bot: electric damage hardening (lightning immunity).
--   3. Gleba compost chest: nutrient fuel slot + spoilage rate management.
--
-- IMPORTANT — single handler per event rule:
--   Factorio allows exactly one handler per event per mod. Each call to
--   script.on_event() replaces any prior registration for that event.
--   All dispatch is therefore done here; scripts expose handler functions
--   rather than registering events themselves.

local placement = require("scripts.placement")
local depot_cap = require("scripts.depot-cap")
local hardening = require("scripts.fulgora-hardening")
local compost   = require("scripts.compost-chest")

-- ─── Build dispatch ──────────────────────────────────────────────────────────
-- Both placement and compost need on_built_entity / on_robot_built_entity /
-- script_raised_built. A single handler dispatches to both.

local function on_build(event)
  placement.on_built(event)
  compost.on_built(event)
end

script.on_event(defines.events.on_built_entity,       on_build)
script.on_event(defines.events.on_robot_built_entity, on_build)
script.on_event(defines.events.script_raised_built,   on_build)

-- ─── Remove dispatch ────────────────────────────────────────────────────────

local function on_remove(event)
  compost.on_removed(event)
end

script.on_event(defines.events.on_entity_died,          on_remove)
script.on_event(defines.events.on_player_mined_entity,  on_remove)
script.on_event(defines.events.on_robot_mined_entity,   on_remove)
script.on_event(defines.events.script_raised_destroy,   on_remove)

-- ─── Research ───────────────────────────────────────────────────────────────

script.on_event(defines.events.on_research_finished, depot_cap.on_research_finished)

-- ─── Fulgora hardening (electric damage only — no other module uses this) ───

script.on_event(defines.events.on_entity_damaged, hardening.on_entity_damaged)

-- ─── Compost chest tick ──────────────────────────────────────────────────────

script.on_nth_tick(60, compost.on_tick)

-- ─── Init / Load ────────────────────────────────────────────────────────────

script.on_init(function()
  depot_cap.init()
  compost.init()
end)

script.on_load(function()
  -- storage is already populated from on_init; no re-init needed.
  -- on_nth_tick and on_event registrations must NOT be re-registered here:
  -- they are already active from the top of this file (run on every load).
end)
