-- prototypes/entities/field-drone-depot.lua
-- Pre-vanilla Nauvis construction-only depot. No logistics radius. No foreign variant.
-- Design intent: planets/01-nauvis-pre-vanilla.md
--
-- Key constraints:
--   - logistics_radius = 1 (functionally zero — no logistics network area)
--   - construction_radius = 30 (smaller coverage than vanilla 55)
--   - Single charge station, low throughput
--   - Hard cap per force enforced at runtime by scripts/depot-cap.lua
--   - Cannot be placed off Nauvis (placement.lua returns item if attempted)

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local tint    = palettes.field_drone
local vanilla = data.raw["roboport"]["roboport"]

local function make_depot(name, params)
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
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    logistics_radius             = 1,    -- functionally no logistics network
    construction_radius          = params.construction_radius,
    charging_energy              = params.charging_energy,
    charging_station_count       = params.stations,
    robot_slots_count            = params.robot_slots,
    material_slots_count         = 4,
    -- Energy
    energy_source = {
      type             = "electric",
      usage_priority   = "secondary-input",
      input_flow_limit = "2MW",
      buffer_capacity  = "50MJ",
    },
    energy_usage     = "30kW",
    recharge_minimum = "5MJ",
  }
end

data:extend({
  make_depot("pb-field-drone-depot", {
    construction_radius = 30,
    charging_energy     = "500kW",
    stations            = 2,
    robot_slots         = 20,
  }),
})
