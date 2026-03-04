-- prototypes/entities/aquilo-roboport.lua
-- Aquilo roboport. Identity: sustained charging under Aquilo's 5x energy drain.
-- All airborne robots on Aquilo consume 5x normal energy. Without a port designed
-- for this, networks stall: bots deplete, queues back up, builds never finish.
--
-- Design levers: charging_energy (moderate sustained, not peak burst — that's Fulgora),
-- charging_station_count (steady queue handling), robot_slots_count (large — Aquilo
-- networks need more bots in the air to compensate for slow drain-heavy cycles).
-- Recipe is expensive (lithium + quantum processors) — gated behind Aquilo production.
--
-- Vanilla baseline:
--   charging_energy: "1000kW", charging_station_count: 4,
--   robot_slots_count: 50, logistics_radius: 25, construction_radius: 55

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local vanilla = data.raw["roboport"]["roboport"]

local function make_aquilo_roboport(name, tint, params)
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
    robot_slots_count            = params.robot_slots_count,      -- PRIMARY: large fleet for drain-heavy cycles
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
  make_aquilo_roboport("pb-aquilo-roboport-home", palettes.aquilo, {
    charging_energy        = "4000kW",  -- 4x vanilla; sustained, not peak burst
    charging_station_count = 6,
    robot_slots_count      = 70,        -- large fleets cover ground efficiently under drain
  }),
  make_aquilo_roboport("pb-aquilo-roboport-foreign", palettes.aquilo_foreign, {
    charging_energy        = "2500kW",  -- 2.5x vanilla; efficient charging travels with the port
    charging_station_count = 5,
    robot_slots_count      = 60,
  }),
})
