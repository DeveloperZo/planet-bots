-- prototypes/bots/cryo-bots.lua
-- Aquilo Cryo Cells. Energy storage + efficiency specialist.
-- Design intent: planets/06-aquilo.md
--
-- Identity: "everyone else's bots freeze and die. Yours don't."
-- Primary levers: highest max_energy of all families (9MJ), best energy_per_move (2.5kJ),
-- near-zero idle drain. Not fastest, not heaviest — built to survive 5× cold energy drain.
--
-- Under Aquilo 5× drain:
--   Effective energy_per_move: 2.5kJ × 5 = 12.5kJ (vs vanilla 5kJ × 5 = 25kJ)
--   Effective range at 0.12 min_to_charge: 9MJ × 0.88 / 12.5kJ ≈ 634 tiles
--   Vanilla on Aquilo:          1.5MJ × 0.88 / 25kJ ≈ 52 tiles
--
-- Recipe gate: quantum processors (expensive post-Aquilo unlock)
-- Off-planet: still useful for sparse-port outposts (9MJ battery is valuable anywhere)
-- but see design doc for off-planet restriction options.

-- Vanilla baseline reference:
--   logistic:      speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, max_payload=1
--   construction:  speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW

local function make_cryo_logistic(name, params)
  return {
    type                               = "logistic-robot",
    name                               = name,
    icons                              = {{ icon = "__planetbots__/graphics/icons/cryo-logistic.png", icon_size = 64 }},
    -- TODO: copy sprite tables from vanilla logistic-robot, recolour (ice-blue/white Aquilo palette)
    max_health                         = 100,
    collision_box                      = {{0, 0}, {0, 0}},
    selection_box                      = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    speed                              = params.speed,            -- 0.04 — slower than vanilla; traded for capacity
    max_speed                          = params.max_speed,        -- 0.18 — moderate cap
    max_energy                         = params.max_energy,       -- 9MJ — 6× vanilla; the defining stat
    energy_per_move                    = params.energy_per_move,  -- 2.5kJ — 0.5× vanilla
    energy_per_tick                    = params.energy_per_tick,  -- 0.5kW — near-zero idle; crucial on Aquilo
    max_payload_size                   = params.max_payload_size, -- 2 — slight payload bonus, not the identity
    min_to_charge                      = 0.12,                    -- deep discharge; maximises airborne time
    max_to_charge                      = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                        = {},
    cargo_centered                     = { 0, 0.2 },
  }
end

local function make_cryo_construction(name, params)
  return {
    type                               = "construction-robot",
    name                               = name,
    icons                              = {{ icon = "__planetbots__/graphics/icons/cryo-construction.png", icon_size = 64 }},
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
    resistances                        = {},
    construction_vector                = { 0, 0.2 },
  }
end

data:extend({
  -- ── Logistic cryo bots ───────────────────────────────────────────────────
  make_cryo_logistic("pb-cryo-logistic-robot-home", {
    speed            = 0.04,
    max_speed        = 0.18,
    max_energy       = "9MJ",     -- best-in-class battery
    energy_per_move  = "2.5kJ",   -- 0.5× vanilla
    energy_per_tick  = "0.5kW",   -- near-zero idle drain
    max_payload_size = 2,
  }),
  make_cryo_logistic("pb-cryo-logistic-robot-foreign", {
    speed            = 0.04,
    max_speed        = 0.18,
    max_energy       = "6MJ",     -- still 4× vanilla; useful for sparse-port outposts
    energy_per_move  = "3kJ",     -- efficiency advantage reduced off Aquilo
    energy_per_tick  = "1kW",     -- still well below vanilla
    max_payload_size = 2,
  }),

  -- ── Construction cryo bots ───────────────────────────────────────────────
  make_cryo_construction("pb-cryo-construction-robot-home", {
    speed            = 0.045,
    max_speed        = 0.18,
    max_energy       = "9MJ",
    energy_per_move  = "2.5kJ",
    energy_per_tick  = "0.5kW",
    max_payload_size = 2,
  }),
  make_cryo_construction("pb-cryo-construction-robot-foreign", {
    speed            = 0.045,
    max_speed        = 0.18,
    max_energy       = "6MJ",
    energy_per_move  = "3kJ",
    energy_per_tick  = "1kW",
    max_payload_size = 2,
  }),
})
