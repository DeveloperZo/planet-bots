-- prototypes/items/roboport-items.lua
-- Specialty roboport items: one item per specialty, no home/foreign variants.
-- Aquilo: roboport (best charging infrastructure)
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
  {
    type         = "item",
    name         = "pb-field-chest",
    icons        = sprite_util.planet_icon("__base__/graphics/icons/iron-chest.png", palettes.field_drone),
    stack_size   = 50,
    place_result = "pb-field-chest",
    subgroup     = "pb-roboports",
    order        = "a-pb-chest",
  },
  {
    type         = "repair-tool",
    name         = "pb-field-charge",
    speed        = 1,
    durability   = 1,
    icons        = sprite_util.planet_icon("__base__/graphics/icons/repair-pack.png", palettes.field_drone),
    stack_size   = 100,
    subgroup     = "pb-roboports",
    order        = "a-pb-charge",
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
})
