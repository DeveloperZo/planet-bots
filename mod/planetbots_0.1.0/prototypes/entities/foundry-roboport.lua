-- prototypes/entities/foundry-roboport.lua
-- Vulcanus roboport. Heavy charging throughput, dense logistics radius.
-- Home variant: full bonuses. Foreign variant: partial bonuses, still above vanilla.
--
-- NUMBERS: marked TODO — fill from per-planet spec doc when finalised.
-- Vanilla baseline reference:
--   logistics_radius: 25, construction_radius: 55
--   charging_energy: "1000kW", charging_station_count: 4, robot_slots_count: 50

local function make_foundry_roboport(name, params)
  -- Start from a deep copy of the vanilla roboport and override what we need.
  -- In production, copy from data.raw["roboport"]["roboport"] and patch.
  -- This scaffold defines the shape; values are params.
  return {
    type                   = "roboport",
    name                   = name,
    -- Visual
    icons                  = {{ icon = "__planetbots__/graphics/foundry-roboport.png", icon_size = 64 }},
    -- TODO: copy full sprite/animation tables from vanilla roboport and recolour
    -- Collision / selection
    collision_box          = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    selection_box          = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    -- Network coverage — fixed at vanilla values, no radius tweaking
    logistics_radius       = 25,   -- displays as 50×50
    construction_radius    = 55,   -- displays as 110×110
    -- ── PRIMARY LEVERS ─────────────────────────────────────────────────────
    charging_energy        = params.charging_energy,        -- TODO: home=3000kW, foreign=TBD
    charging_station_count = params.charging_station_count, -- TODO: home=8,      foreign=TBD
    robot_slots_count      = params.robot_slots_count,      -- TODO: home=60,     foreign=TBD
    material_slots_count   = 7,
    -- Energy
    energy_source          = { type = "electric", usage_priority = "secondary-input" },
    energy_usage           = "50kW",
    recharge_minimum       = "10MJ",
    -- Misc
    open_door_trigger_effect  = data.raw["roboport"]["roboport"].open_door_trigger_effect,
    close_door_trigger_effect = data.raw["roboport"]["roboport"].close_door_trigger_effect,
  }
end

data:extend({
  make_foundry_roboport("pb-foundry-roboport-home", {
    charging_energy        = "3000kW",  -- TODO: confirm
    charging_station_count = 8,         -- TODO: confirm
    robot_slots_count      = 60,        -- TODO: confirm
  }),
  make_foundry_roboport("pb-foundry-roboport-foreign", {
    charging_energy        = "1500kW",  -- TODO: tune — partial bonus
    charging_station_count = 6,         -- TODO: tune
    robot_slots_count      = 55,        -- TODO: tune
  }),
})
