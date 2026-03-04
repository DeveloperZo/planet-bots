-- prototypes/bots/fulgora-bots.lua
-- Fulgora bots. Identity: fastest family + 100% electric resistance.
-- The storm rolls in and these bots don't care. High speed clears routes quickly;
-- large battery survives flying through a blackout without charge access;
-- electric resistance means lightning doesn't delete them mid-flight.
-- Payload is intentionally low — this is a fast courier, not a bulk mover.
--
-- Primary levers:
--   speed = 0.08 logistic / 0.09 construction — fastest in the mod
--   max_speed = 0.25 — research keeps them the fastest family
--   max_energy = 5MJ home — ~1100 tile range at full drain during blackout
--   resistances: electric 100% (protects against electric turret damage)
--
-- min_to_charge = 0.12 — deep discharge before returning; maximises blackout survival.
--
-- Lightning note: LightningPrototype.damage is a raw double with no damage type.
-- Electric resistance does NOT protect against Fulgora lightning strikes.
-- Vanilla construction bots have 50% electric resist and are still killed by lightning.
-- True lightning immunity requires either very high max_health or an on_entity_damaged
-- script that cancels lightning damage for these entities. This is a TODO for a future pass.
--
-- Vanilla baseline:
--   logistic:      speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, max_payload=1
--   construction:  speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local vanilla_lb = data.raw["logistic-robot"]["logistic-robot"]
local vanilla_cb = data.raw["construction-robot"]["construction-robot"]

local ELECTRIC_RESISTANCE = {
  { type = "electric", percent = 100 }
}

local function make_fulgora_logistic(name, tint, params)
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
    min_to_charge                       = 0.12,   -- deep discharge; stays up through blackouts
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                         = params.resistances,
    cargo_centered                      = { 0, 0.2 },
  }
end

local function make_fulgora_construction(name, tint, params)
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
    min_to_charge                       = 0.12,
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                         = params.resistances,
    construction_vector                 = { 0, 0.2 },
  }
end

data:extend({
  -- Logistic
  make_fulgora_logistic("pb-fulgora-logistic-robot-home", palettes.fulgora, {
    speed            = 0.08,   -- PRIMARY: fastest logistic in the mod (vs vanilla 0.05)
    max_speed        = 0.25,
    max_energy       = "5MJ",  -- ~1100 tile range at 4kJ/tile during a full blackout
    energy_per_move  = "4kJ",  -- near vanilla; speed not efficiency is the identity
    energy_per_tick  = "3kW",
    max_payload_size = 1,      -- intentionally low; not a bulk bot
    resistances      = ELECTRIC_RESISTANCE,
  }),
  make_fulgora_logistic("pb-fulgora-logistic-robot-foreign", palettes.fulgora_foreign, {
    speed            = 0.08,
    max_speed        = 0.25,
    max_energy       = "3MJ",  -- reduced battery off Fulgora; still 2x vanilla
    energy_per_move  = "4kJ",
    energy_per_tick  = "3kW",
    max_payload_size = 1,
    resistances      = ELECTRIC_RESISTANCE,  -- lightning immunity travels with the bot
  }),

  -- Construction
  make_fulgora_construction("pb-fulgora-construction-robot-home", palettes.fulgora, {
    speed            = 0.09,   -- PRIMARY: fastest construction in the mod (vs vanilla 0.06)
    max_speed        = 0.25,
    max_energy       = "5MJ",
    energy_per_move  = "4kJ",
    energy_per_tick  = "3kW",
    max_payload_size = 1,
    resistances      = ELECTRIC_RESISTANCE,
  }),
  make_fulgora_construction("pb-fulgora-construction-robot-foreign", palettes.fulgora_foreign, {
    speed            = 0.09,
    max_speed        = 0.25,
    max_energy       = "3MJ",
    energy_per_move  = "4kJ",
    energy_per_tick  = "3kW",
    max_payload_size = 1,
    resistances      = ELECTRIC_RESISTANCE,
  }),
})
