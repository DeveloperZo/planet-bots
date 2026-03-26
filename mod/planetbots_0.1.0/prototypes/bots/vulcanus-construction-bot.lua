-- prototypes/bots/vulcanus-construction-bot.lua
-- Vulcanus specialty: construction robot with payload = 3.
-- The best construction bot in the mod. Three items per ghost per trip — for large
-- builds (megabase blueprints, smelter rows, wall sections) this cuts completion
-- time dramatically. The tradeoff: slightly slower than vanilla and 1.6x energy_per_move,
-- meaning range is shorter in energy-sparse grids. Pair with Aquilo roboports.
--
-- Craftable anywhere — the gate is the supply chain: tungsten-plate and calcite
-- must be shipped from Vulcanus.
--
-- Vanilla construction baseline:
--   speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW, payload=1

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
    -- ── PRIMARY LEVER ─────────────────────────────────────────────────────
    max_payload_size                    = 3,      -- 3x vanilla; each trip to a ghost places 3 items
    -- ── TRADEOFFS ─────────────────────────────────────────────────────────
    speed                               = 0.05,   -- slightly below vanilla 0.06 — the price of payload
    max_speed                           = 0.10,   -- hard cap; not a speed bot
    max_energy                          = "3MJ",  -- 2x vanilla battery
    energy_per_move                     = "8kJ",  -- 1.6x vanilla; range shorter than vanilla in sparse grids
    energy_per_tick                     = "3kW",  -- vanilla idle drain
    -- ── STANDARD ──────────────────────────────────────────────────────────
    min_to_charge                       = 0.2,
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.25,
    resistances                         = {},
    construction_vector                 = { 0, 0.2 },
  }
})
