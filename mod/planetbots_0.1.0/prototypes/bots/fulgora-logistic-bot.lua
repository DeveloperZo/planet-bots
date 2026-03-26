-- prototypes/bots/fulgora-logistic-bot.lua
-- Fulgora specialty: logistic robot — fastest family + 100% electric resistance.
-- The mod's premier logistics bot. Speed = 0.08 (1.6x vanilla), max_speed = 0.25.
-- 5 MJ battery survives a full storm blackout mid-flight without a charge stop.
-- Electric resistance = 100%: immune to lightning strikes and tesla turret fire.
-- Payload = 1 intentionally — this is a fast courier, not a bulk hauler.
-- True lightning immunity also enforced at runtime via scripts/fulgora-hardening.lua.
--
-- Craftable anywhere — gate is the supply chain: supercapacitor and holmium-plate
-- must be shipped from Fulgora.
--
-- Vanilla logistic baseline:
--   speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, payload=1

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local tint    = palettes.fulgora
local vanilla = data.raw["logistic-robot"]["logistic-robot"]

local ICON_BASE  = "__base__/graphics/icons/logistic-robot.png"
local ICON_BADGE = "__base__/graphics/icons/roboport.png"

data:extend({
  {
    type                                = "logistic-robot",
    name                                = "pb-fulgora-logistic-robot",
    flags                               = { "placeable-player", "player-creation", "placeable-off-grid", "not-on-map" },
    minable                             = { mining_time = 0.1, result = "pb-fulgora-logistic-robot" },
    -- Two-layer specialty icon: vanilla base + planet-colored badge (CoVe: scale=0.4 for 32px legibility)
    icons = {
      { icon = ICON_BASE,  icon_size = 64 },
      { icon = ICON_BADGE, icon_size = 64, scale = 0.4, shift = { 8, 8 }, tint = tint },
    },
    idle                                = sprite_util.tinted_copy(vanilla.idle, tint),
    idle_with_cargo                     = sprite_util.tinted_copy(vanilla.idle_with_cargo, tint),
    in_motion                           = sprite_util.tinted_copy(vanilla.in_motion, tint),
    in_motion_with_cargo                = sprite_util.tinted_copy(vanilla.in_motion_with_cargo, tint),
    shadow_idle                         = sprite_util.tinted_copy(vanilla.shadow_idle, tint),
    shadow_idle_with_cargo              = sprite_util.tinted_copy(vanilla.shadow_idle_with_cargo, tint),
    shadow_in_motion                    = sprite_util.tinted_copy(vanilla.shadow_in_motion, tint),
    shadow_in_motion_with_cargo         = sprite_util.tinted_copy(vanilla.shadow_in_motion_with_cargo, tint),
    max_health                          = 100,
    collision_box                       = {{0, 0}, {0, 0}},
    selection_box                       = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    speed                               = 0.08,   -- 1.6x vanilla 0.05 — fastest logistic in mod
    max_speed                           = 0.25,   -- fastest in mod
    max_energy                          = "5MJ",  -- 3.3x vanilla — survives full blackout mid-flight
    -- ── ELECTRIC IMMUNITY ─────────────────────────────────────────────────
    -- Prototype-level resistance handles electric turret/discharge damage.
    -- Runtime script (fulgora-hardening.lua) cancels actual lightning damage
    -- using on_entity_damaged, since lightning is raw double with no type filter.
    resistances = { { type = "electric", percent = 100 } },
    -- ── TRADEOFFS ─────────────────────────────────────────────────────────
    energy_per_move                     = "4kJ",  -- slightly better than vanilla 5kJ
    energy_per_tick                     = "3kW",  -- vanilla idle drain
    max_payload_size                    = 1,      -- courier, not hauler
    -- ── STANDARD ──────────────────────────────────────────────────────────
    min_to_charge                       = 0.12,   -- deep discharge; maximises blackout survival
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    cargo_centered                      = { 0, 0.2 },
  }
})
