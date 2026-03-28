-- prototypes/entities/field-chest.lua
-- Material storage chest for the Field Drone Depot scripted builder.
-- Place within depot construction radius. The builder script pulls ghost
-- ingredients from Field Chests. Shares placement cap with depots.
-- Nauvis only (placement.lua blocks off-Nauvis).

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")
local util        = require("util")

local tint    = palettes.field_drone
local vanilla = data.raw["container"]["iron-chest"]

local S = settings.startup
local function s(name) return S[name].value end

data:extend({
  {
    type           = "container",
    name           = "pb-field-chest",
    flags          = { "placeable-player", "player-creation" },
    minable        = { mining_time = 0.1, result = "pb-field-chest" },
    icons          = sprite_util.planet_icon("__base__/graphics/icons/iron-chest.png", tint),
    picture        = sprite_util.tinted_copy(vanilla.picture, tint),
    max_health     = 100,
    collision_box  = {{ -0.35, -0.35 }, { 0.35, 0.35 }},
    selection_box  = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    inventory_size = s("pb-field-chest-inventory-size"),
    open_sound     = vanilla.open_sound,
    close_sound    = vanilla.close_sound,
  },
})
