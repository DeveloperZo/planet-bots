-- prototypes/bots/fulgora-logistic-bot.lua
-- Fulgora specialty: logistic robot — fastest family + 100% electric resistance.
-- The mod's premier logistics bot. Speed = 0.08 (1.6x vanilla), max_speed = 0.25.
-- 5 MJ battery survives a full storm blackout mid-flight without a charge stop.
-- Electric resistance = 100%: immune to lightning strikes and tesla turret fire.
-- True lightning immunity also enforced at runtime via scripts/fulgora-hardening.lua.
--
-- Hidden depth (supercapacitor courier — not obvious from “fast bot” alone):
--   • energy_per_move LOWER than vanilla — long flights are cheap per tile; they are
--     long-haul couriers, not just “faster vanilla.”
--   • energy_per_tick HIGHER than vanilla — self-discharge / active stabilization; heavy
--     bot traffic and long hover queues burn disproportionate power vs vanilla bots.
--   • max_to_charge LOWER than vanilla — they park without insisting on a full top-off,
--     freeing roboport charge pads sooner under saturation (snappier network, more
--     recharge cycles when everyone is busy).
--   • min_to_charge LOWER than vanilla — runs the pack deeper before mandatory charge runs;
--     pairs with 5 MJ so blackouts still work, but empty-bot limp is harsher.
--   • speed_multiplier_when_out_of_energy LOWER than vanilla — when drained, they crawl;
--     rewards keeping a buffer and punishes starving the network.
--   • max_payload_size_after_bonus — caps worker-robot cargo research at 3 stacks (vanilla
--     logistic bots reach 4). Endgame bulk hauls stay on standard bots; Fulgora stays a courier.
--
-- Craftable anywhere — gate is the supply chain: supercapacitor and holmium-plate
-- must be shipped from Fulgora.
--
-- Vanilla logistic baseline:
--   speed=0.05, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, payload=1
--   min_to_charge=0.2, max_to_charge=0.95, speed_multiplier_when_out_of_energy=0.25

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local tint    = palettes.fulgora
local vanilla = data.raw["logistic-robot"]["logistic-robot"]

local S = settings.startup
local function s(name) return S[name].value end

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
    -- ── PRIMARY LEVERS (from mod settings) ─────────────────────────────────
    speed                               = s("pb-fulgora-lbot-speed"),
    max_speed                           = s("pb-fulgora-lbot-max-speed"),
    max_energy                          = s("pb-fulgora-lbot-max-energy-mj") .. "MJ",
    -- ── ELECTRIC IMMUNITY ─────────────────────────────────────────────────
    -- Prototype-level resistance handles electric turret/discharge damage.
    -- Runtime script (fulgora-hardening.lua) cancels actual lightning damage
    -- using on_entity_damaged, since lightning is raw double with no type filter.
    resistances = { { type = "electric", percent = 100 } },
    -- ── TRADEOFFS (supercap courier — see file header) ───────────────────
    energy_per_move                     = s("pb-fulgora-lbot-energy-per-move-kj") .. "kJ",
    energy_per_tick                     = s("pb-fulgora-lbot-energy-per-tick-kw") .. "kW",
    max_payload_size                    = s("pb-fulgora-lbot-max-payload"),
    max_payload_size_after_bonus        = s("pb-fulgora-lbot-max-payload-after-bonus"),
    -- ── CHARGE + EMPTY BEHAVIOUR ──────────────────────────────────────────
    min_to_charge                       = s("pb-fulgora-lbot-min-to-charge"),
    max_to_charge                       = s("pb-fulgora-lbot-max-to-charge"),
    speed_multiplier_when_out_of_energy = s("pb-fulgora-lbot-speed-when-empty"),
    cargo_centered                      = { 0, 0.2 },
  }
})
