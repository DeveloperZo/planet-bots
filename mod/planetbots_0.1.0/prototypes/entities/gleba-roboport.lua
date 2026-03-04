-- prototypes/entities/gleba-roboport.lua
-- Gleba roboport. Identity: fleet capacity and charge stability for large persistent swarms.
--
-- Design levers: robot_slots_count (primary — the fleet size lever) and
-- charging_station_count (secondary — distributes the queue). charging_energy
-- is moderate, intentionally below Fulgora; burst throughput is not the identity.
--
-- Vanilla baseline:
--   charging_energy: "1000kW", charging_station_count: 4,
--   robot_slots_count: 50, logistics_radius: 25, construction_radius: 55

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local vanilla = data.raw["roboport"]["roboport"]

local function make_gleba_roboport(name, tint, params)
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
    robot_slots_count            = params.robot_slots_count,   -- PRIMARY: largest fleet capacity
    material_slots_count         = 7,
    -- Energy
    energy_source = {
      type             = "electric",
      usage_priority   = "secondary-input",
      input_flow_limit = "5MW",
      buffer_capacity  = "100MJ",
    },
    energy_usage     = "50kW",
    recharge_minimum = "10MJ",
  }
end

data:extend({
  make_gleba_roboport("pb-gleba-roboport-home", palettes.gleba, {
    charging_energy        = "1500kW",  -- 1.5x vanilla; steady, not overwhelming
    charging_station_count = 6,         -- 1.5x vanilla; spreads the queue
    robot_slots_count      = 80,        -- 1.6x vanilla; the defining stat
  }),
  make_gleba_roboport("pb-gleba-roboport-foreign", palettes.gleba_foreign, {
    charging_energy        = "1200kW",
    charging_station_count = 5,
    robot_slots_count      = 65,
  }),
})
