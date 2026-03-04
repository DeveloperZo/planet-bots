-- prototypes/bots/courier-bots.lua
-- Gleba Biobots. Endurance / regenerative identity.
-- Design intent: planets/04-gleba.md
--
-- Identity: "the fleet that keeps going." Not fastest, not heaviest.
-- Primary levers: very low idle drain, strong energy efficiency per move.
-- The swarm can stay airborne longer and operates at sustained scale without
-- constant charge-queuing. Natural pairing with Biostation's fleet-stability focus.
--
-- Bot family entity names: pb-biobot-{logistic,construction}-robot-{home,foreign}

-- Vanilla baseline reference:
--   logistic:      speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, max_payload=1
--   construction:  speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW

local function make_biobot_logistic(name, params)
  return {
    type                               = "logistic-robot",
    name                               = name,
    icons                              = {{ icon = "__planetbots__/graphics/icons/biobot-logistic.png", icon_size = 64 }},
    -- TODO: copy sprite tables from vanilla logistic-robot, recolour (green/yellow organic palette)
    max_health                         = 100,
    collision_box                      = {{0, 0}, {0, 0}},
    selection_box                      = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    speed                              = params.speed,            -- 0.05 — vanilla-equivalent, not a speed bot
    max_speed                          = params.max_speed,        -- 0.15 — moderate cap; research helps but doesn't dominate
    max_energy                         = params.max_energy,       -- 2MJ — decent battery
    energy_per_move                    = params.energy_per_move,  -- 2.5kJ — 0.5× vanilla; the thrift stat
    energy_per_tick                    = params.energy_per_tick,  -- 0.8kW — very low idle drain; KEY identity stat
    max_payload_size                   = params.max_payload_size, -- 1 — no payload advantage; endurance is the win
    min_to_charge                      = 0.15,                    -- stays airborne longer before returning
    max_to_charge                      = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                        = {},
    cargo_centered                     = { 0, 0.2 },
  }
end

local function make_biobot_construction(name, params)
  return {
    type                               = "construction-robot",
    name                               = name,
    icons                              = {{ icon = "__planetbots__/graphics/icons/biobot-construction.png", icon_size = 64 }},
    max_health                         = 100,
    collision_box                      = {{0, 0}, {0, 0}},
    selection_box                      = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    speed                              = params.speed,
    max_speed                          = params.max_speed,
    max_energy                         = params.max_energy,
    energy_per_move                    = params.energy_per_move,
    energy_per_tick                    = params.energy_per_tick,
    max_payload_size                   = params.max_payload_size,
    min_to_charge                      = 0.15,
    max_to_charge                      = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                        = {},
    construction_vector                = { 0, 0.2 },
  }
end

data:extend({
  -- ── Logistic biobots ────────────────────────────────────────────────────
  make_biobot_logistic("pb-biobot-logistic-robot-home", {
    speed            = 0.05,
    max_speed        = 0.15,
    max_energy       = "2MJ",
    energy_per_move  = "2.5kJ",  -- 0.5× vanilla — core efficiency stat
    energy_per_tick  = "0.8kW",  -- 0.27× vanilla — the endurance differentiator
    max_payload_size = 1,
  }),
  make_biobot_logistic("pb-biobot-logistic-robot-foreign", {
    speed            = 0.05,
    max_speed        = 0.15,
    max_energy       = "1.8MJ",  -- slightly less than home
    energy_per_move  = "3kJ",    -- efficiency advantage reduced off Gleba
    energy_per_tick  = "1.5kW",  -- still below vanilla, not as good as home
    max_payload_size = 1,
  }),

  -- ── Construction biobots ────────────────────────────────────────────────
  make_biobot_construction("pb-biobot-construction-robot-home", {
    speed            = 0.055,
    max_speed        = 0.15,
    max_energy       = "2MJ",
    energy_per_move  = "2.5kJ",
    energy_per_tick  = "0.8kW",
    max_payload_size = 1,
  }),
  make_biobot_construction("pb-biobot-construction-robot-foreign", {
    speed            = 0.055,
    max_speed        = 0.15,
    max_energy       = "1.8MJ",
    energy_per_move  = "3kJ",
    energy_per_tick  = "1.5kW",
    max_payload_size = 1,
  }),
})
