-- prototypes/bots/aquilo-bots.lua
-- Aquilo bots. Identity: deep battery + best energy efficiency in the mod.
-- Aquilo's 5x energy drain makes every other bot family impractical without
-- dense port coverage. These bots are built around that constraint:
-- 9MJ battery and 2.5kJ/move means they cover ~634 tiles under full drain
-- vs ~52 tiles for a vanilla bot in the same conditions.
--
-- Primary levers:
--   max_energy = 9MJ home / 6MJ foreign — 6x and 4x vanilla respectively
--   energy_per_move = 2.5kJ home / 3kJ foreign — 0.5x and 0.6x vanilla
--   energy_per_tick = 0.5kW home / 1kW foreign — near-zero idle drain
--
-- Speed is slightly below vanilla — traded for capacity. No speed advantage.
-- Payload = 2 — minor bonus; not the identity.
-- min_to_charge = 0.12 — deep discharge maximises airborne time.
--
-- Vanilla baseline:
--   logistic:      speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, max_payload=1
--   construction:  speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local vanilla_lb = data.raw["logistic-robot"]["logistic-robot"]
local vanilla_cb = data.raw["construction-robot"]["construction-robot"]

local function make_aquilo_logistic(name, tint, params)
  return {
    type                                = "logistic-robot",
    name                                = name,
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
    min_to_charge                       = 0.12,   -- deep discharge; maximises airborne time under drain
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                         = {},
    cargo_centered                      = { 0, 0.2 },
  }
end

local function make_aquilo_construction(name, tint, params)
  return {
    type                                = "construction-robot",
    name                                = name,
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
    min_to_charge                       = 0.12,
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                         = {},
    construction_vector                 = { 0, 0.2 },
  }
end

data:extend({
  -- Logistic
  make_aquilo_logistic("pb-aquilo-logistic-robot-home", palettes.aquilo, {
    speed            = 0.04,    -- slightly below vanilla; traded for capacity
    max_speed        = 0.18,
    max_energy       = "9MJ",   -- PRIMARY: 6x vanilla
    energy_per_move  = "2.5kJ", -- 0.5x vanilla (12.5kJ effective on Aquilo under 5x drain)
    energy_per_tick  = "0.5kW", -- near-zero idle; crucial under constant drain
    max_payload_size = 2,
  }),
  make_aquilo_logistic("pb-aquilo-logistic-robot-foreign", palettes.aquilo_foreign, {
    speed            = 0.04,
    max_speed        = 0.18,
    max_energy       = "6MJ",   -- 4x vanilla; best general-purpose battery off-planet
    energy_per_move  = "3kJ",
    energy_per_tick  = "1kW",
    max_payload_size = 2,
  }),

  -- Construction
  make_aquilo_construction("pb-aquilo-construction-robot-home", palettes.aquilo, {
    speed            = 0.045,
    max_speed        = 0.18,
    max_energy       = "9MJ",
    energy_per_move  = "2.5kJ",
    energy_per_tick  = "0.5kW",
    max_payload_size = 2,
  }),
  make_aquilo_construction("pb-aquilo-construction-robot-foreign", palettes.aquilo_foreign, {
    speed            = 0.045,
    max_speed        = 0.18,
    max_energy       = "6MJ",
    energy_per_move  = "3kJ",
    energy_per_tick  = "1kW",
    max_payload_size = 2,
  }),
})
