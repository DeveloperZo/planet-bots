-- prototypes/bots/field-drones.lua
-- Pre-vanilla Nauvis construction drones. No logistics bot. Construction only.
-- Design intent: planets/01-nauvis-pre-vanilla.md
--
-- Identity: "training wheels." Faster than doing it yourself. Clearly inferior to real bots.
-- Hard speed cap ensures research barely matters — players should WANT to replace these.
--
-- No foreign variant. Placement script returns the item if placed off Nauvis.
--
-- Vanilla construction robot baseline:
--   speed=0.06, max_energy=1.5MJ, energy_per_move=5kJ, energy_per_tick=3kW

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local tint    = palettes.field_drone
local vanilla = data.raw["construction-robot"]["construction-robot"]

local function make_field_drone(name, params)
  return {
    type                                = "construction-robot",
    name                                = name,
    flags                               = { "placeable-player", "player-creation", "placeable-off-grid", "not-on-map" },
    minable                             = { mining_time = 0.1, result = "pb-field-drone" },  -- item name (entity is pb-field-drone-home)
    icons                               = sprite_util.planet_icon("__base__/graphics/icons/construction-robot.png", tint),
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
    max_health                          = 60,    -- fragile; less than vanilla 100
    collision_box                       = {{0, 0}, {0, 0}},
    selection_box                       = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    speed                               = params.speed,
    max_speed                           = params.max_speed,
    max_energy                          = params.max_energy,
    energy_per_move                     = params.energy_per_move,
    energy_per_tick                     = params.energy_per_tick,
    max_payload_size                    = 1,
    min_to_charge                       = 0.3,   -- returns to depot frequently
    max_to_charge                       = 0.95,
    speed_multiplier_when_out_of_energy = 0.1,   -- nearly stops when low — very visible feedback
    resistances                         = {},
    construction_vector                 = { 0, 0.2 },
  }
end

data:extend({
  make_field_drone("pb-field-drone-home", {
    speed            = 0.025,
    max_speed        = 0.04,    -- hard cap; well below vanilla 0.06+ post-research
    max_energy       = "0.5MJ",
    energy_per_move  = "10kJ",  -- 2x vanilla; range is poor
    energy_per_tick  = "6kW",   -- expensive idle
  }),
})
