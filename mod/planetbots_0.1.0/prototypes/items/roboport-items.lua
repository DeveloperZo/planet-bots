-- prototypes/items/roboport-items.lua
-- Specialty roboport and structure items: one item per specialty, no home/foreign variants.
-- Aquilo: roboport (best charging infrastructure)
-- Gleba: compost chest (nutrient-fueled spoilage management)
-- Field Drone Depot: Nauvis pre-vanilla (unchanged).

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

data:extend({
  -- ── Pre-vanilla ──────────────────────────────────────────────────────────
  {
    type         = "item",
    name         = "pb-field-drone-depot",
    icons        = sprite_util.planet_icon("__base__/graphics/icons/roboport.png", palettes.field_drone),
    stack_size   = 10,
    place_result = "pb-field-drone-depot",
    subgroup     = "pb-roboports",
    order        = "a-pb-depot",
  },

  -- ── Aquilo specialty: roboport ────────────────────────────────────────────
  {
    type         = "item",
    name         = "pb-aquilo-roboport",
    icons        = sprite_util.specialty_icon("__base__/graphics/icons/roboport.png", palettes.aquilo),
    stack_size   = 10,
    place_result = "pb-aquilo-roboport",
    subgroup     = "pb-roboports",
    order        = "b-pb-aquilo",
  },

  -- ── Gleba specialty: compost chest ───────────────────────────────────────
  {
    type         = "item",
    name         = "pb-gleba-compost-chest",
    icons        = sprite_util.specialty_icon("__base__/graphics/icons/iron-chest.png", palettes.gleba),
    stack_size   = 10,
    place_result = "pb-gleba-compost-chest",
    subgroup     = "pb-roboports",
    order        = "b-pb-gleba-chest",
  },
})
