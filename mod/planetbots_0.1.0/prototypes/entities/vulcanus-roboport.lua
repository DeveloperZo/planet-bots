-- prototypes/entities/vulcanus-roboport.lua
-- Vulcanus roboport. Identity: charging throughput for dense industrial hubs.
-- High-volume smelting and foundry layouts generate extreme bot traffic;
-- this port exists to keep that traffic moving without charging queues forming.
--
-- Design levers: charging_energy and charging_station_count (throughput focus).
-- Radius is unchanged from vanilla — identity is throughput, not coverage.
--
-- Vanilla baseline:
--   charging_energy: "1000kW", charging_station_count: 4,
--   robot_slots_count: 50, logistics_radius: 25, construction_radius: 55

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local vanilla = data.raw["roboport"]["roboport"]

local function make_vulcanus_roboport(name, tint, params)
  return {
    type                         = "roboport",
    name                         = name,
    icons                        = sprite_util.planet_icon("__base__/graphics/icons/roboport.png", tint),
    base                         = sprite_util.tinted_copy(vanilla.base, tint),
    base_animation               = sprite_util.tinted_copy(vanilla.base_animation, tint),
    base_patch                   = sprite_util.tinted_copy(vanilla.base_patch, tint),
    door_animation_up            = sprite_util.tinted_copy(vanilla.door_animation_up, tint),
    door_animation_down          = sprite_util.tinted_copy(vanilla.door_animation_down, tint),
    recharging_animation         = sprite_util.tinted_copy(vanilla.recharging_animation, tint),
    recharging_light             = vanilla.recharging_light,
    request_to_open_door_timeout = vanilla.request_to_open_door_timeout,
    spawn_and_station_height     = vanilla.spawn_and_station_height,
    charge_approach_distance     = vanilla.charge_approach_distance,
    collision_box                = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    selection_box                = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    -- Network coverage — vanilla values; radius is not a design lever
    logistics_radius             = 25,
    construction_radius          = 55,
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    charging_energy              = params.charging_energy,
    charging_station_count       = params.charging_station_count,
    robot_slots_count            = params.robot_slots_count,
    material_slots_count         = 7,
    -- Energy
    energy_source = {
      type              = "electric",
      usage_priority    = "secondary-input",
      input_flow_limit  = "5MW",
      buffer_capacity   = "100MJ",
    },
    energy_usage   = "50kW",
    recharge_minimum = "10MJ",
  }
end

data:extend({
  make_vulcanus_roboport("pb-vulcanus-roboport-home", palettes.vulcanus, {
    charging_energy        = "3000kW",  -- 3x vanilla; clears dense hub queues fast
    charging_station_count = 8,         -- 2x vanilla simultaneous slots
    robot_slots_count      = 60,
  }),
  make_vulcanus_roboport("pb-vulcanus-roboport-foreign", palettes.vulcanus_foreign, {
    charging_energy        = "1500kW",  -- 1.5x vanilla; still a good throughput hub off-planet
    charging_station_count = 6,
    robot_slots_count      = 55,
  }),
})
