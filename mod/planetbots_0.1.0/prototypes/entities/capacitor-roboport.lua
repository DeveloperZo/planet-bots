-- prototypes/entities/capacitor-roboport.lua
-- Fulgora Capacitor Roboport. Massive charging throughput + electric resistance.
-- Survives lightning strikes. Clears charging queues fast after storm blackouts.
-- Design intent: planets/05-fulgora.md
--
-- Identity: the port that keeps working when lightning comes.
-- Primary levers:
--   - charging_energy: 6× vanilla — fastest queue clearance of all families
--   - charging_station_count: 10 — more simultaneous charge slots than anyone else
--   - resistances: electric 100% — structure doesn't take lightning damage
-- Trade-off: standard robot slots, no radius advantage, high recipe cost (supercapacitors)
--
-- Lightning resistance implementation note:
--   Resistances are prototype-level (damage-type keyed). "electric" is used here.
--   Validate against actual Space Age lightning damage type before shipping.
--   See: planets/05-fulgora.md implementation note.

-- Vanilla baseline reference:
--   charging_energy: "1000kW", charging_station_count: 4, robot_slots_count: 50
--   logistics_radius: 25, construction_radius: 55

local ELECTRIC_RESISTANCE = {
  { type = "electric", percent = 100 }
}

local function make_capacitor(name, params)
  return {
    type                   = "roboport",
    name                   = name,
    icons                  = {{ icon = "__planetbots__/graphics/icons/capacitor-roboport.png", icon_size = 64 }},
    -- TODO: sprite tables from vanilla roboport, recolour (yellow/black lightning palette)
    collision_box          = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    selection_box          = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    -- Network coverage — vanilla values; radius is not a design lever
    logistics_radius       = 25,
    construction_radius    = 55,
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    charging_energy        = params.charging_energy,        -- 6× vanilla; fastest queue clear
    charging_station_count = params.charging_station_count, -- 10 home / 7 foreign; most simultaneous charge slots
    robot_slots_count      = params.robot_slots_count,      -- standard; port identity is throughput not fleet size
    material_slots_count   = 7,
    -- ── DEFINING TRAIT ────────────────────────────────────────────────────
    resistances            = ELECTRIC_RESISTANCE,           -- structure survives lightning
    -- Energy
    energy_source          = { type = "electric", usage_priority = "secondary-input" },
    energy_usage           = "50kW",
    recharge_minimum       = "10MJ",
    -- TODO: copy open/close door effects from vanilla roboport
  }
end

data:extend({
  make_capacitor("pb-capacitor-roboport-home", {
    charging_energy        = "6000kW",  -- 6× vanilla; peak throughput
    charging_station_count = 10,        -- most stations in the family
    robot_slots_count      = 60,
  }),
  make_capacitor("pb-capacitor-roboport-foreign", {
    charging_energy        = "3000kW",  -- still 3× vanilla; fast charging travels with the port
    charging_station_count = 7,
    robot_slots_count      = 55,        -- useful for high-throughput hubs anywhere; not dominant
  }),
})
