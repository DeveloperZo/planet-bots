-- prototypes/items/bot-items.lua
-- Specialty bot items: one item per specialty, no home/foreign variants.
-- Vulcanus: construction robot (payload 3)
-- Fulgora: logistic robot (fastest + lightning-immune)

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

data:extend({
  -- ── Vulcanus specialty: construction robot ────────────────────────────────
  {
    type         = "item",
    name         = "pb-vulcanus-construction-robot",
    icons        = sprite_util.specialty_icon("__base__/graphics/icons/construction-robot.png", palettes.vulcanus),
    stack_size   = 50,
    place_result = "pb-vulcanus-construction-robot",
    subgroup     = "pb-bots",
    order        = "b-pb-vulcanus",
  },

  -- ── Fulgora specialty: logistic robot ─────────────────────────────────────
  {
    type         = "item",
    name         = "pb-fulgora-logistic-robot",
    icons        = sprite_util.specialty_icon("__base__/graphics/icons/logistic-robot.png", palettes.fulgora),
    stack_size   = 50,
    place_result = "pb-fulgora-logistic-robot",
    subgroup     = "pb-bots",
    order        = "b-pb-fulgora",
  },
})
