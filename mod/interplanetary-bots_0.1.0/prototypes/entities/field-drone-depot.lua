-- prototypes/entities/field-drone-depot.lua
-- Pre-vanilla Nauvis scripted builder. No real robots — construction is handled
-- by scripts/field-drone-builder.lua consuming repair packs (ammo from material
-- slots) and ghost ingredients (from nearby Field Chests).
--
-- Key constraints:
--   - logistics_radius = 1 (functionally zero — no logistics network area)
--   - construction_radius = 30 (build zone for the scripted builder)
--   - robot_slots_count = 0 (no real bots)
--   - material_slots_count = 4 (holds repair packs — the build ammo)
--   - Hard cap per force enforced at runtime by scripts/depot-cap.lua
--   - Cannot be placed off Nauvis (placement.lua returns item if attempted)

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local tint    = palettes.field_drone
local vanilla = data.raw["roboport"]["roboport"]

local S = settings.startup
local function s(name) return S[name].value end

local function make_depot(name, params)
  return {
    type                         = "roboport",
    name                         = name,
    flags                        = { "placeable-player", "player-creation" },
    minable                      = { mining_time = 0.1, result = name },
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
    charging_energy              = "1kW",  -- minimal; no real bots to charge
    charging_station_count       = 0,
    robot_slots_count            = 0,      -- no real bots; building is scripted
    material_slots_count         = 4,      -- holds repair packs (build ammo)
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
    construction_radius = s("pb-field-depot-construction-radius"),
  }),
})
