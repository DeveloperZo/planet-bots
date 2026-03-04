-- prototypes/bots/gleba-bots.lua
-- Gleba bots. Identity: endurance. The fleet that keeps going.
-- Not fastest, not heaviest — but hundreds of bots that don't stall.
-- Defining stats are energy_per_tick (idle drain) and energy_per_move:
-- both well below vanilla, so bots stay airborne far longer between charges.
--
-- Primary lever: energy_per_tick = 0.8 kW home (vs vanilla 3 kW) — 0.27x idle drain.
-- Speed is vanilla-equivalent — not a speed bot.
-- Payload = 1 — no advantage; endurance is the only win.
--
-- Vanilla baseline:
--   logistic:      speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, max_payload=1
--   construction:  speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local vanilla_lb = data.raw["logistic-robot"]["logistic-robot"]
local vanilla_cb = data.raw["construction-robot"]["construction-robot"]

local function make_gleba_logistic(name, tint, params)
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
    energy_per_tick                     = params.energy_per_tick,  -- PRIMARY: idle drain stat
    max_payload_size                    = params.max_payload_size,
    min_to_charge                       = 0.15,   -- stays airborne longer before returning
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                         = {},
    cargo_centered                      = { 0, 0.2 },
  }
end

local function make_gleba_construction(name, tint, params)
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
    min_to_charge                       = 0.15,
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                         = {},
    construction_vector                 = { 0, 0.2 },
  }
end

data:extend({
  -- Logistic
  make_gleba_logistic("pb-gleba-logistic-robot-home", palettes.gleba, {
    speed            = 0.05,    -- vanilla-equivalent; not a speed bot
    max_speed        = 0.15,
    max_energy       = "2MJ",
    energy_per_move  = "2.5kJ", -- 0.5x vanilla; efficient per tile
    energy_per_tick  = "0.8kW", -- PRIMARY: 0.27x vanilla idle drain
    max_payload_size = 1,
  }),
  make_gleba_logistic("pb-gleba-logistic-robot-foreign", palettes.gleba_foreign, {
    speed            = 0.05,
    max_speed        = 0.15,
    max_energy       = "1.8MJ",
    energy_per_move  = "3kJ",
    energy_per_tick  = "1.5kW",
    max_payload_size = 1,
  }),

  -- Construction
  make_gleba_construction("pb-gleba-construction-robot-home", palettes.gleba, {
    speed            = 0.055,
    max_speed        = 0.15,
    max_energy       = "2MJ",
    energy_per_move  = "2.5kJ",
    energy_per_tick  = "0.8kW",
    max_payload_size = 1,
  }),
  make_gleba_construction("pb-gleba-construction-robot-foreign", palettes.gleba_foreign, {
    speed            = 0.055,
    max_speed        = 0.15,
    max_energy       = "1.8MJ",
    energy_per_move  = "3kJ",
    energy_per_tick  = "1.5kW",
    max_payload_size = 1,
  }),
})
