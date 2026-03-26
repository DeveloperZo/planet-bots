-- prototypes/entities/aquilo-roboport.lua
-- Aquilo specialty: the best roboport in the mod.
-- 4x vanilla charging energy, 2x charging stations, 1.4x robot slots.
-- Designed to handle Aquilo's 5x energy drain forcing constant high-frequency
-- recharge cycles — the over-engineering required for Aquilo makes it the
-- dominant roboport choice for any serious network anywhere.
--
-- Craftable anywhere — gate is the supply chain: lithium-plate and
-- quantum-processor must be shipped from Aquilo.
--
-- Vanilla baseline:
--   charging_energy: "1000kW", charging_station_count: 4, robot_slots_count: 50

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local tint    = palettes.aquilo
local vanilla = data.raw["roboport"]["roboport"]

local ICON_BASE  = "__base__/graphics/icons/roboport.png"
local ICON_BADGE = "__base__/graphics/icons/roboport.png"

data:extend({
  {
    type                         = "roboport",
    name                         = "pb-aquilo-roboport",
    flags                        = { "placeable-player", "player-creation" },
    minable                      = { mining_time = 0.1, result = "pb-aquilo-roboport" },
    -- Two-layer specialty icon: vanilla base + cryo-blue badge (CoVe: scale=0.4 for 32px legibility)
    icons = {
      { icon = ICON_BASE,  icon_size = 64 },
      { icon = ICON_BADGE, icon_size = 64, scale = 0.4, shift = { 8, 8 }, tint = tint },
    },
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
    charging_energy              = "4000kW",  -- 4x vanilla; sustained throughput not burst
    charging_station_count       = 8,         -- 2x vanilla simultaneous charge slots
    robot_slots_count            = 70,        -- 1.4x vanilla; large fleets for drain-heavy networks
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
})
