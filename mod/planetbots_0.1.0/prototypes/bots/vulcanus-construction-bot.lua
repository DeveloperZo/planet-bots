-- prototypes/bots/vulcanus-construction-bot.lua
-- Vulcanus specialty: fastest construction robot in the mod.
--
-- MECHANICS (what actually moves the needle for blueprint building):
--   1. speed                         — flight time per ghost trip. The primary lever.
--   2. range (max_energy/energy_per_move) — how far from a roboport the bot can work.
--   3. speed_multiplier_when_out_of_energy — the "volcanic sprint" identity stat (see below).
--
-- max_payload_size does NOT affect ghost-building: each bot handles exactly 1 ghost per trip.
-- Payload only helps deconstruction (collecting items). Kept at 3 for that use case.
--
-- VOLCANIC SPRINT (depth mechanic):
--   When energy drops below min_to_charge (25% of 5MJ = 1.25MJ), the bot enters
--   overclock mode: speed_multiplier_when_out_of_energy = 1.5 → effective speed 0.15.
--   Vanilla bots in the same state crawl at 0.25× speed (punished). Vulcanus bots sprint.
--
--   Design reward: intentionally spacing roboports further apart on a perimeter is valid
--   strategy. Bots run low mid-crossing, overclock for the final dash to the ghost and
--   the sprint back to the roboport. Round-trip time at low energy is SHORTER than at
--   normal energy for a vanilla bot. Perimeter building has depth, not just cost.
--
-- Craftable anywhere — gate is the supply chain: tungsten-plate and calcite from Vulcanus.
--
-- Vanilla construction baseline:
--   speed=0.06, max_energy=3MJ, energy_per_move=5kJ, energy_per_tick=0.05kJ, payload=1
--   speed_multiplier_when_out_of_energy=0.25 (punishing)

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local tint    = palettes.vulcanus
local vanilla = data.raw["construction-robot"]["construction-robot"]

local ICON_BASE  = "__base__/graphics/icons/construction-robot.png"
local ICON_BADGE = "__base__/graphics/icons/roboport.png"

data:extend({
  {
    type                                = "construction-robot",
    name                                = "pb-vulcanus-construction-robot",
    flags                               = { "placeable-player", "player-creation", "placeable-off-grid", "not-on-map" },
    minable                             = { mining_time = 0.1, result = "pb-vulcanus-construction-robot" },
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
    working                             = sprite_util.tinted_copy(vanilla.working, tint),
    shadow_working                      = sprite_util.tinted_copy(vanilla.shadow_working, tint),
    max_health                          = 100,
    collision_box                       = {{0, 0}, {0, 0}},
    selection_box                       = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    -- ── SPEED ─────────────────────────────────────────────────────────────
    speed                               = 0.10,   -- 1.67× vanilla 0.06 — faster on every blueprint
    max_speed                           = 0.20,   -- research cap; accommodates 0.15 sprint too
    -- ── DECONSTRUCTION BONUS ──────────────────────────────────────────────
    max_payload_size                    = 3,      -- 3× vanilla; items swept per deconstruction trip
    -- ── ENERGY / RANGE ────────────────────────────────────────────────────
    max_energy                          = "5MJ",  -- 625-tile range at 8kJ/tile; funds sprint reserve
    energy_per_move                     = "8kJ",  -- 1.6× vanilla; shorter uninterrupted range
    energy_per_tick                     = "3kW",  -- vanilla idle drain
    -- ── VOLCANIC SPRINT ───────────────────────────────────────────────────
    -- energy < 25% → overclock at 1.5× base speed (0.15 effective).
    -- Vanilla at same state = 0.25× (crawls). This bot sprints.
    -- Wider roboport spacing on perimeters is a valid strategy, not a mistake.
    min_to_charge                       = 0.25,  -- overclock triggers at 25% (vs vanilla 20%)
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 1.5,   -- 1.5× base = 0.15 sprint (vs vanilla 0.25×)
    resistances                         = {},
    construction_vector                 = { 0, 0.2 },
  }
})
