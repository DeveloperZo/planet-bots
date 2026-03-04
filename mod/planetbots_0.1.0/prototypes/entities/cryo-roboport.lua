-- prototypes/entities/cryo-roboport.lua
-- Aquilo Cryo Roboport. Sustained-operation charging under 5× energy drain.
-- Design intent: planets/06-aquilo.md
--
-- Identity: the only port that makes bot networks viable on Aquilo.
-- Primary levers:
--   - charging_energy: moderate throughput (not peak) — steady, not bursty
--   - charging_station_count: good coverage for spread-out networks
--   - robot_slots_count: large fleet support — Aquilo networks need more bots
--     in the air to compensate for slower recharge cycles under extreme drain
-- Trade-off: expensive recipe (lithium + quantum processors), slower home-surface
--   charging than Capacitor Roboport. Absolutely not cheap to spam.
--
-- Off-planet: still useful for sparse-port outposts where energy efficiency matters,
-- but see planets/06-aquilo.md for off-planet restriction options if it crowds out
-- other families in normal play.
--
-- Vanilla baseline reference:
--   charging_energy: "1000kW", charging_station_count: 4, robot_slots_count: 50

local function make_cryo(name, params)
  return {
    type                   = "roboport",
    name                   = name,
    icons                  = {{ icon = "__planetbots__/graphics/icons/cryo-roboport.png", icon_size = 64 }},
    -- TODO: sprite tables from vanilla roboport, recolour (ice-blue/white Aquilo palette)
    collision_box          = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    selection_box          = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    -- Network coverage — vanilla values; radius is not a design lever
    logistics_radius       = 25,
    construction_radius    = 55,
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    charging_energy        = params.charging_energy,        -- 4× vanilla; sustained, not peak
    charging_station_count = params.charging_station_count, -- 6 home / 5 foreign; steady queue handling
    robot_slots_count      = params.robot_slots_count,      -- 70 home; largest fleet capacity in the family
    material_slots_count   = 7,
    -- Energy
    energy_source          = { type = "electric", usage_priority = "secondary-input" },
    energy_usage           = "50kW",
    recharge_minimum       = "10MJ",
    -- TODO: copy open/close door effects from vanilla roboport
  }
end

data:extend({
  make_cryo("pb-cryo-roboport-home", {
    charging_energy        = "4000kW",  -- 4× vanilla; sustained throughput for drain-heavy environment
    charging_station_count = 6,
    robot_slots_count      = 70,        -- large fleets needed on Aquilo to cover ground efficiently
  }),
  make_cryo("pb-cryo-roboport-foreign", {
    charging_energy        = "2500kW",  -- still 2.5× vanilla; efficient charging travels with the port
    charging_station_count = 5,
    robot_slots_count      = 60,
  }),
})
