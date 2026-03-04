-- prototypes/bots/arc-bots.lua
-- Fulgora Stormproof Couriers. Speed + lightning immunity.
-- Design intent: planets/05-fulgora.md
--
-- Identity: the storm rolls in and your bots don't care.
-- Primary levers: highest speed cap, electric resistance 100%, large battery for storm blackout survival.
-- Payload deliberately low — this is not a bulk delivery bot.
-- Pairs with Capacitor Roboport (high-throughput charging to clear queues fast after storms clear).
--
-- Bot family entity names: pb-courier-{logistic,construction}-robot-{home,foreign}
-- NOTE: "courier" was previously used for Gleba bots. Family reassigned to Fulgora.
--       Gleba bots are now "biobots" (see courier-bots.lua).

-- Vanilla baseline reference:
--   logistic:      speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, max_payload=1
--   construction:  speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW

-- Lightning resistance note:
--   Factorio lightning damage type should be confirmed against Space Age prototype data
--   before shipping. Community reports suggest ~100 AoE electric-type damage.
--   Resistance entry uses "electric" — validate against actual damage type.

local ELECTRIC_RESISTANCE = {
  { type = "electric", percent = 100 }
}

local function make_courier_logistic(name, params)
  return {
    type                               = "logistic-robot",
    name                               = name,
    icons                              = {{ icon = "__planetbots__/graphics/icons/courier-logistic.png", icon_size = 64 }},
    -- TODO: copy sprite tables from vanilla logistic-robot, recolour (yellow/black storm palette)
    max_health                         = 100,
    collision_box                      = {{0, 0}, {0, 0}},
    selection_box                      = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    speed                              = params.speed,            -- 0.08 — fastest bot family
    max_speed                          = params.max_speed,        -- 0.25 — research meaningful; still the fastest
    max_energy                         = params.max_energy,       -- 5MJ — ~1100 tiles range at 4kJ/tile during blackout
    energy_per_move                    = params.energy_per_move,  -- 4kJ — near vanilla; speed, not efficiency
    energy_per_tick                    = params.energy_per_tick,  -- 3kW — vanilla-equivalent
    max_payload_size                   = params.max_payload_size, -- 1 — intentionally not a bulk bot
    min_to_charge                      = 0.12,                    -- deep discharge before returning (storm survival)
    max_to_charge                      = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                        = params.resistances,      -- electric 100%
    cargo_centered                     = { 0, 0.2 },
  }
end

local function make_courier_construction(name, params)
  return {
    type                               = "construction-robot",
    name                               = name,
    icons                              = {{ icon = "__planetbots__/graphics/icons/courier-construction.png", icon_size = 64 }},
    max_health                         = 100,
    collision_box                      = {{0, 0}, {0, 0}},
    selection_box                      = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    speed                              = params.speed,
    max_speed                          = params.max_speed,
    max_energy                         = params.max_energy,
    energy_per_move                    = params.energy_per_move,
    energy_per_tick                    = params.energy_per_tick,
    max_payload_size                   = params.max_payload_size,
    min_to_charge                      = 0.12,
    max_to_charge                      = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                        = params.resistances,
    construction_vector                = { 0, 0.2 },
  }
end

data:extend({
  -- ── Logistic couriers ────────────────────────────────────────────────────
  make_courier_logistic("pb-courier-logistic-robot-home", {
    speed            = 0.08,
    max_speed        = 0.25,
    max_energy       = "5MJ",
    energy_per_move  = "4kJ",
    energy_per_tick  = "3kW",
    max_payload_size = 1,
    resistances      = ELECTRIC_RESISTANCE,
  }),
  make_courier_logistic("pb-courier-logistic-robot-foreign", {
    speed            = 0.08,           -- same speed — the primary stat travels with the bot
    max_speed        = 0.25,
    max_energy       = "3MJ",          -- less battery off Fulgora
    energy_per_move  = "4kJ",
    energy_per_tick  = "3kW",
    max_payload_size = 1,
    resistances      = ELECTRIC_RESISTANCE,  -- immunity stays — the bot is still built to survive lightning
  }),

  -- ── Construction couriers ────────────────────────────────────────────────
  make_courier_construction("pb-courier-construction-robot-home", {
    speed            = 0.09,
    max_speed        = 0.25,
    max_energy       = "5MJ",
    energy_per_move  = "4kJ",
    energy_per_tick  = "3kW",
    max_payload_size = 1,
    resistances      = ELECTRIC_RESISTANCE,
  }),
  make_courier_construction("pb-courier-construction-robot-foreign", {
    speed            = 0.09,
    max_speed        = 0.25,
    max_energy       = "3MJ",
    energy_per_move  = "4kJ",
    energy_per_tick  = "3kW",
    max_payload_size = 1,
    resistances      = ELECTRIC_RESISTANCE,
  }),
})
