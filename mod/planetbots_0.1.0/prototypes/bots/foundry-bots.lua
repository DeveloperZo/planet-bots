-- prototypes/bots/foundry-bots.lua
-- Vulcanus bots. Best-in-class payload. Hard speed cap. High energy_per_move.
-- Home variant: full bonuses. Foreign variant: partial bonuses.
--
-- NUMBERS: marked TODO — fill from per-planet spec doc.
-- Vanilla baseline reference:
--   logistic:      speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, max_payload=1
--   construction:  speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ

local function make_foundry_logistic(name, params)
  return {
    type                          = "logistic-robot",
    name                          = name,
    icons                         = {{ icon = "__planetbots__/graphics/foundry-logistic-robot.png", icon_size = 64 }},
    -- TODO: copy full sprite tables from vanilla logistic-robot and recolour
    max_health                    = 100,
    collision_box                 = {{0, 0}, {0, 0}},
    selection_box                 = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    -- ── PRIMARY LEVERS ─────────────────────────────────────────────────────
    speed                         = params.speed,             -- TODO: home=0.03, foreign=TBD
    max_speed                     = params.max_speed,         -- hard cap: home=0.07, foreign=0.07 (same cap)
    max_energy                    = params.max_energy,        -- TODO: home=3MJ,  foreign=TBD
    energy_per_move               = params.energy_per_move,   -- TODO: home=15kJ, foreign=TBD
    energy_per_tick               = params.energy_per_tick,   -- TODO: home=4.5kW,foreign=TBD
    max_payload_size              = params.max_payload_size,  -- TODO: home=3,    foreign=TBD
    min_to_charge                 = 0.2,
    max_to_charge                 = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    -- Resistances: none for Foundry
    resistances                   = {},
    -- Cargo
    cargo_centered                = { 0, 0.2 },
  }
end

local function make_foundry_construction(name, params)
  return {
    type                          = "construction-robot",
    name                          = name,
    icons                         = {{ icon = "__planetbots__/graphics/foundry-construction-robot.png", icon_size = 64 }},
    max_health                    = 100,
    collision_box                 = {{0, 0}, {0, 0}},
    selection_box                 = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    speed                         = params.speed,
    max_speed                     = params.max_speed,
    max_energy                    = params.max_energy,
    energy_per_move               = params.energy_per_move,
    energy_per_tick               = params.energy_per_tick,
    max_payload_size              = params.max_payload_size,
    min_to_charge                 = 0.2,
    max_to_charge                 = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                   = {},
    construction_vector           = { 0, 0.2 },
  }
end

data:extend({
  -- Logistic variants
  make_foundry_logistic("pb-foundry-logistic-robot-home", {
    speed            = 0.03,
    max_speed        = 0.07,   -- hard cap preserved on both variants
    max_energy       = "3MJ",
    energy_per_move  = "15kJ",
    energy_per_tick  = "4.5kW",
    max_payload_size = 3,
  }),
  make_foundry_logistic("pb-foundry-logistic-robot-foreign", {
    speed            = 0.03,   -- TODO: tune
    max_speed        = 0.07,   -- same cap — identity preserved
    max_energy       = "2MJ",  -- TODO: tune
    energy_per_move  = "15kJ", -- same cost — the tradeoff stays
    energy_per_tick  = "4.5kW",
    max_payload_size = 2,      -- TODO: tune — still above vanilla
  }),

  -- Construction variants
  make_foundry_construction("pb-foundry-construction-robot-home", {
    speed            = 0.035,
    max_speed        = 0.07,
    max_energy       = "3MJ",
    energy_per_move  = "15kJ",
    energy_per_tick  = "4.5kW",
    max_payload_size = 3,
  }),
  make_foundry_construction("pb-foundry-construction-robot-foreign", {
    speed            = 0.035,  -- TODO: tune
    max_speed        = 0.07,
    max_energy       = "2MJ",  -- TODO: tune
    energy_per_move  = "15kJ",
    energy_per_tick  = "4.5kW",
    max_payload_size = 2,      -- TODO: tune
  }),
})
