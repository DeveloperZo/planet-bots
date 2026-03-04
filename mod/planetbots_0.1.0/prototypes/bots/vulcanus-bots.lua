-- prototypes/bots/vulcanus-bots.lua
-- Vulcanus bots. Identity: high payload, hard speed cap.
-- Fewer trips per build or delivery. The tradeoff is real: 3x energy_per_move
-- means range is poor, and the hard max_speed cap means research barely helps
-- with travel time. These bots only make sense inside dense, well-ported networks.
--
-- Primary lever: max_payload_size = 3 (home) / 2 (foreign).
-- Hard speed cap: max_speed = 0.07 — slower than vanilla always.
-- Off-planet: high energy_per_move compounds Aquilo's 5x drain catastrophically.
-- On Fulgora: no electric resistance — not lightning-safe.
--
-- Vanilla baseline:
--   logistic:      speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, max_payload=1
--   construction:  speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local vanilla_lb  = data.raw["logistic-robot"]["logistic-robot"]
local vanilla_cb  = data.raw["construction-robot"]["construction-robot"]

local function make_vulcanus_logistic(name, tint, params)
  return {
    type                                = "logistic-robot",
    name                                = name,
    flags                               = { "placeable-player", "player-creation", "placeable-off-grid", "not-on-map" },
    minable                             = { mining_time = 0.1, result = name },
    icons                               = sprite_util.planet_icon("__base__/graphics/icons/logistic-robot.png", tint),
    idle                                = sprite_util.tinted_copy(vanilla_lb.idle, tint),
    idle_with_cargo                     = sprite_util.tinted_copy(vanilla_lb.idle_with_cargo, tint),
    in_motion                           = sprite_util.tinted_copy(vanilla_lb.in_motion, tint),
    in_motion_with_cargo                = sprite_util.tinted_copy(vanilla_lb.in_motion_with_cargo, tint),
    shadow_idle                         = sprite_util.tinted_copy(vanilla_lb.shadow_idle, tint),
    shadow_idle_with_cargo              = sprite_util.tinted_copy(vanilla_lb.shadow_idle_with_cargo, tint),
    shadow_in_motion                    = sprite_util.tinted_copy(vanilla_lb.shadow_in_motion, tint),
    shadow_in_motion_with_cargo         = sprite_util.tinted_copy(vanilla_lb.shadow_in_motion_with_cargo, tint),
    max_health                          = 100,
    collision_box                       = {{0, 0}, {0, 0}},
    selection_box                       = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    speed                               = params.speed,
    max_speed                           = params.max_speed,
    max_energy                          = params.max_energy,
    energy_per_move                     = params.energy_per_move,
    energy_per_tick                     = params.energy_per_tick,
    max_payload_size                    = params.max_payload_size,
    min_to_charge                       = 0.2,
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                         = {},
    cargo_centered                      = { 0, 0.2 },
  }
end

local function make_vulcanus_construction(name, tint, params)
  return {
    type                                = "construction-robot",
    name                                = name,
    flags                               = { "placeable-player", "player-creation", "placeable-off-grid", "not-on-map" },
    minable                             = { mining_time = 0.1, result = name },
    icons                               = sprite_util.planet_icon("__base__/graphics/icons/construction-robot.png", tint),
    idle                                = sprite_util.tinted_copy(vanilla_cb.idle, tint),
    idle_with_cargo                     = sprite_util.tinted_copy(vanilla_cb.idle_with_cargo, tint),
    in_motion                           = sprite_util.tinted_copy(vanilla_cb.in_motion, tint),
    in_motion_with_cargo                = sprite_util.tinted_copy(vanilla_cb.in_motion_with_cargo, tint),
    shadow_idle                         = sprite_util.tinted_copy(vanilla_cb.shadow_idle, tint),
    shadow_idle_with_cargo              = sprite_util.tinted_copy(vanilla_cb.shadow_idle_with_cargo, tint),
    shadow_in_motion                    = sprite_util.tinted_copy(vanilla_cb.shadow_in_motion, tint),
    shadow_in_motion_with_cargo         = sprite_util.tinted_copy(vanilla_cb.shadow_in_motion_with_cargo, tint),
    working                             = sprite_util.tinted_copy(vanilla_cb.working, tint),
    shadow_working                      = sprite_util.tinted_copy(vanilla_cb.shadow_working, tint),
    max_health                          = 100,
    collision_box                       = {{0, 0}, {0, 0}},
    selection_box                       = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    speed                               = params.speed,
    max_speed                           = params.max_speed,
    max_energy                          = params.max_energy,
    energy_per_move                     = params.energy_per_move,
    energy_per_tick                     = params.energy_per_tick,
    max_payload_size                    = params.max_payload_size,
    min_to_charge                       = 0.2,
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                         = {},
    construction_vector                 = { 0, 0.2 },
  }
end

data:extend({
  -- Logistic
  make_vulcanus_logistic("pb-vulcanus-logistic-robot-home", palettes.vulcanus, {
    speed            = 0.03,   -- below vanilla 0.05
    max_speed        = 0.07,   -- hard cap; research barely moves the needle
    max_energy       = "3MJ",
    energy_per_move  = "15kJ", -- 3x vanilla; range is short by design
    energy_per_tick  = "4.5kW",
    max_payload_size = 3,      -- PRIMARY: 3x vanilla; each trip carries more
  }),
  make_vulcanus_logistic("pb-vulcanus-logistic-robot-foreign", palettes.vulcanus_foreign, {
    speed            = 0.03,
    max_speed        = 0.07,
    max_energy       = "2MJ",
    energy_per_move  = "15kJ",
    energy_per_tick  = "4.5kW",
    max_payload_size = 2,
  }),

  -- Construction
  make_vulcanus_construction("pb-vulcanus-construction-robot-home", palettes.vulcanus, {
    speed            = 0.035,
    max_speed        = 0.07,
    max_energy       = "3MJ",
    energy_per_move  = "15kJ",
    energy_per_tick  = "4.5kW",
    max_payload_size = 3,
  }),
  make_vulcanus_construction("pb-vulcanus-construction-robot-foreign", palettes.vulcanus_foreign, {
    speed            = 0.035,
    max_speed        = 0.07,
    max_energy       = "2MJ",
    energy_per_move  = "15kJ",
    energy_per_tick  = "4.5kW",
    max_payload_size = 2,
  }),
})
