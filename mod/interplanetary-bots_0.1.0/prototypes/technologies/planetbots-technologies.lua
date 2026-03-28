-- prototypes/technologies/planetbots-technologies.lua
-- All Interplanetary Bots research.
--
-- Technology tiers:
--   1. Pre-vanilla (Nauvis early) — Field Drones + depot cap unlocks
--   2. Planet tiers — Vulcanus / Fulgora / Aquilo unlock specialty recipes (Gleba: TBD)
-- No home/foreign variants — one recipe per planet.
--
-- Science pack names (Space Age):
--   Nauvis:    automation-science-pack, logistic-science-pack, military-science-pack
--   Vulcanus:  metallurgic-science-pack
--   Fulgora:   electromagnetic-science-pack
--   Aquilo:    cryogenic-science-pack

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local TECH_ICON = "__base__/graphics/technology/robotics.png"

data:extend({

  -- ════════════════════════════════════════════════════════════════════════
  -- PRE-VANILLA TIER
  -- ════════════════════════════════════════════════════════════════════════

  {
    type = "technology",
    name = "pb-field-drones",
    icons = sprite_util.tech_icon(TECH_ICON, palettes.field_drone),
    unit = {
      count = 50,
      ingredients = { { "automation-science-pack", 1 } },
      time = 30,
    },
    prerequisites = { "automation" },
    effects = {
      { type = "unlock-recipe", recipe = "pb-field-drone-depot" },
      { type = "unlock-recipe", recipe = "pb-field-chest" },
    },
  },

  -- Depot cap tiers. Names referenced by scripts/depot-cap.lua — do NOT rename.
  {
    type = "technology", name = "pb-field-depot-capacity-1",
    icons = sprite_util.tech_icon(TECH_ICON, palettes.field_drone),
    unit = { count = 75,  ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 } }, time = 30 },
    prerequisites = { "pb-field-drones" }, effects = {},
  },
  {
    type = "technology", name = "pb-field-depot-capacity-2",
    icons = sprite_util.tech_icon(TECH_ICON, palettes.field_drone),
    unit = { count = 100, ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 } }, time = 30 },
    prerequisites = { "pb-field-depot-capacity-1" }, effects = {},
  },
  {
    type = "technology", name = "pb-field-depot-capacity-3",
    icons = sprite_util.tech_icon(TECH_ICON, palettes.field_drone),
    unit = { count = 150, ingredients = { { "logistic-science-pack", 1 }, { "military-science-pack", 1 } }, time = 45 },
    prerequisites = { "pb-field-depot-capacity-2" }, effects = {},
  },
  {
    type = "technology", name = "pb-field-depot-capacity-4",
    icons = sprite_util.tech_icon(TECH_ICON, palettes.field_drone),
    unit = { count = 200, ingredients = { { "logistic-science-pack", 1 }, { "military-science-pack", 1 }, { "chemical-science-pack", 1 } }, time = 45 },
    prerequisites = { "pb-field-depot-capacity-3" }, effects = {},
  },

  -- ════════════════════════════════════════════════════════════════════════
  -- VULCANUS TIER — specialty: construction robot
  -- ════════════════════════════════════════════════════════════════════════

  {
    type = "technology",
    name = "pb-vulcanus-robotics",
    icons = sprite_util.specialty_tech_icon(TECH_ICON, palettes.vulcanus),
    unit = {
      count = 100,
      ingredients = { { "metallurgic-science-pack", 1 } },
      time = 45,
    },
    prerequisites = { "robotics" },
    effects = {
      { type = "unlock-recipe", recipe = "pb-vulcanus-construction-robot" },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════
  -- FULGORA TIER — specialty: logistic robot
  -- ════════════════════════════════════════════════════════════════════════

  {
    type = "technology",
    name = "pb-fulgora-robotics",
    icons = sprite_util.specialty_tech_icon(TECH_ICON, palettes.fulgora),
    unit = {
      count = 100,
      ingredients = { { "electromagnetic-science-pack", 1 } },
      time = 45,
    },
    prerequisites = { "robotics" },
    effects = {
      { type = "unlock-recipe", recipe = "pb-fulgora-logistic-robot" },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════
  -- AQUILO TIER — specialty: roboport
  -- ════════════════════════════════════════════════════════════════════════

  {
    type = "technology",
    name = "pb-aquilo-robotics",
    icons = sprite_util.specialty_tech_icon(TECH_ICON, palettes.aquilo),
    unit = {
      -- count=300: capstone item (best roboport) should cost more than vanilla robotics (200)
      count = 300,
      ingredients = { { "cryogenic-science-pack", 1 } },
      time = 60,
    },
    -- Requires both specialty bot tiers: Aquilo roboport is the earned capstone.
    prerequisites = { "robotics", "pb-vulcanus-robotics", "pb-fulgora-robotics" },
    effects = {
      { type = "unlock-recipe", recipe = "pb-aquilo-roboport" },
    },
  },

})
