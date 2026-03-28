-- prototypes/entities/field-drone-projectile.lua
-- Cosmetic projectile for the Field Drone Depot scripted builder.
-- Flies from depot to ghost position as visual feedback. No damage.

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local tint    = palettes.field_drone
local vanilla = data.raw["construction-robot"]["construction-robot"]

data:extend({
  {
    type         = "projectile",
    name         = "pb-field-drone-projectile",
    acceleration = 0,
    animation    = sprite_util.tinted_copy(vanilla.in_motion, tint),
    shadow       = sprite_util.tinted_copy(vanilla.shadow_in_motion, tint),
    light        = { intensity = 0.5, size = 4, color = tint },
  },
})
