-- control.lua
-- Runtime scripting for Interplanetary Bots.
--
-- Responsibilities:
--   1. Field Drone Depot: placement checks (Nauvis-only, shared cap), scripted
--      builder loop (on_nth_tick), depot entity tracking.
--   2. Fulgora logistic bot: electric damage hardening (lightning immunity).
--
-- IMPORTANT — single handler per event rule:
--   Factorio allows exactly one handler per event per mod. Each call to
--   script.on_event() replaces any prior registration for that event.
--   All dispatch is therefore done here; scripts expose handler functions
--   rather than registering events themselves.

local placement = require("scripts.placement")
local depot_cap = require("scripts.depot-cap")
local hardening = require("scripts.fulgora-hardening")
local builder   = require("scripts.field-drone-builder")

local TICK_INTERVAL = settings.startup["pb-field-depot-tick-interval"].value

-- ── Build events ────────────────────────────────────────────────────────────

local function on_build(event)
  local entity = event.entity
  if not (entity and entity.valid) then return end
  placement.on_built(event)
  if entity.valid then
    builder.on_built(event)
  end
end

script.on_event(defines.events.on_built_entity,       on_build)
script.on_event(defines.events.on_robot_built_entity,  on_build)
script.on_event(defines.events.script_raised_built,    on_build)

-- ── Remove events ───────────────────────────────────────────────────────────

local function on_remove(event)
  builder.on_removed(event)
end

script.on_event(defines.events.on_player_mined_entity, on_remove)
script.on_event(defines.events.on_robot_mined_entity,  on_remove)
script.on_event(defines.events.on_entity_died,         on_remove)
script.on_event(defines.events.script_raised_destroy,   on_remove)

-- ── Research ────────────────────────────────────────────────────────────────

script.on_event(defines.events.on_research_finished, depot_cap.on_research_finished)

-- ── Damage ──────────────────────────────────────────────────────────────────

script.on_event(defines.events.on_entity_damaged, hardening.on_entity_damaged)

-- ── Periodic: builder tick ──────────────────────────────────────────────────

script.on_nth_tick(TICK_INTERVAL, builder.on_tick)

-- ── Lifecycle ───────────────────────────────────────────────────────────────

script.on_init(function()
  depot_cap.init()
  builder.init()
end)

script.on_configuration_changed(function()
  depot_cap.init()
  builder.init()
end)

script.on_load(function()
  -- storage is already populated; event registrations are set above.
end)
