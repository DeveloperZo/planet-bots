-- prototypes/entities/fulgora-roboport.lua
-- Fulgora roboport. Identity: survive lightning, clear the post-storm charging backlog fast.
-- Fulgora's nightly storms black out power and can kill unprotected bots and structures.
-- This port addresses both: 100% electric resistance so the structure survives,
-- and 6x vanilla charging throughput so the queue drains before the next storm hits.
--
-- Lightning note: LightningPrototype.damage is a raw double — it has no damage type, so
-- electric resistance does NOT protect the roboport from lightning strikes.
-- The ELECTRIC_RESISTANCE below protects against electric turret damage only.
-- For true lightning hardening, use very high max_health so 100-damage strikes are negligible,
-- or implement on_entity_damaged script filtering. TODO: decide approach before shipping.
--
-- Vanilla baseline:
--   charging_energy: "1000kW", charging_station_count: 4,
--   robot_slots_count: 50, logistics_radius: 25, construction_radius: 55

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local vanilla = data.raw["roboport"]["roboport"]

local ELECTRIC_RESISTANCE = {
  { type = "electric", percent = 100 }
}

local function make_fulgora_roboport(name, tint, params)
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
    -- Network coverage — vanilla values; radius is not a design lever
    logistics_radius             = 25,
    construction_radius          = 55,
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    charging_energy              = params.charging_energy,        -- PRIMARY: fastest burst in the mod
    charging_station_count       = params.charging_station_count, -- most simultaneous slots
    robot_slots_count            = params.robot_slots_count,
    material_slots_count         = 7,
    -- ── DEFINING TRAIT ────────────────────────────────────────────────────
    resistances                  = ELECTRIC_RESISTANCE,
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
  make_fulgora_roboport("pb-fulgora-roboport-home", palettes.fulgora, {
    charging_energy        = "6000kW",  -- 6x vanilla; fastest queue clearance of all families
    charging_station_count = 10,        -- most stations in the mod
    robot_slots_count      = 60,
  }),
  make_fulgora_roboport("pb-fulgora-roboport-foreign", palettes.fulgora_foreign, {
    charging_energy        = "3000kW",  -- 3x vanilla; fast charging travels with the port
    charging_station_count = 7,
    robot_slots_count      = 55,
  }),
})
