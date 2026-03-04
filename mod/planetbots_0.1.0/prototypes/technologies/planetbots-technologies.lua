-- prototypes/technologies/planetbots-technologies.lua
-- All PlanetBots research.
--
-- Technology tiers:
--   1. Pre-vanilla (Nauvis early) — iron/copper era; Field Drones + depot cap unlocks
--   2. Planet tiers — one per planet; gated by planet science packs
--
-- Each planet tech unlocks BOTH home and foreign recipe variants (6 effects per tech).
-- The engine enforces surface_conditions; players only see the variant valid on their surface.
--
-- Science pack names (Space Age) — confirmed against data.raw wiki:
--   Nauvis:    automation-science-pack, logistic-science-pack, military-science-pack
--   Vulcanus:  metallurgic-science-pack
--   Gleba:     agricultural-science-pack
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
      { type = "unlock-recipe", recipe = "pb-field-drone" },
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
  -- VULCANUS TIER
  -- ════════════════════════════════════════════════════════════════════════

  {
    type = "technology",
    name = "pb-vulcanus-robotics",
    icons = sprite_util.tech_icon(TECH_ICON, palettes.vulcanus),
    unit = {
      count = 100,
      ingredients = { { "metallurgic-science-pack", 1 } },
      time = 45,
    },
    prerequisites = { "robotics" },
    effects = {
      { type = "unlock-recipe", recipe = "pb-vulcanus-roboport-home" },
      { type = "unlock-recipe", recipe = "pb-vulcanus-roboport-foreign" },
      { type = "unlock-recipe", recipe = "pb-vulcanus-logistic-robot-home" },
      { type = "unlock-recipe", recipe = "pb-vulcanus-logistic-robot-foreign" },
      { type = "unlock-recipe", recipe = "pb-vulcanus-construction-robot-home" },
      { type = "unlock-recipe", recipe = "pb-vulcanus-construction-robot-foreign" },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════
  -- GLEBA TIER
  -- ════════════════════════════════════════════════════════════════════════

  {
    type = "technology",
    name = "pb-gleba-robotics",
    icons = sprite_util.tech_icon(TECH_ICON, palettes.gleba),
    unit = {
      count = 100,
      ingredients = { { "agricultural-science-pack", 1 } },
      time = 45,
    },
    prerequisites = { "robotics" },
    effects = {
      { type = "unlock-recipe", recipe = "pb-gleba-roboport-home" },
      { type = "unlock-recipe", recipe = "pb-gleba-roboport-foreign" },
      { type = "unlock-recipe", recipe = "pb-gleba-logistic-robot-home" },
      { type = "unlock-recipe", recipe = "pb-gleba-logistic-robot-foreign" },
      { type = "unlock-recipe", recipe = "pb-gleba-construction-robot-home" },
      { type = "unlock-recipe", recipe = "pb-gleba-construction-robot-foreign" },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════
  -- FULGORA TIER
  -- ════════════════════════════════════════════════════════════════════════

  {
    type = "technology",
    name = "pb-fulgora-robotics",
    icons = sprite_util.tech_icon(TECH_ICON, palettes.fulgora),
    unit = {
      count = 100,
      ingredients = { { "electromagnetic-science-pack", 1 } },
      time = 45,
    },
    prerequisites = { "robotics" },
    effects = {
      { type = "unlock-recipe", recipe = "pb-fulgora-roboport-home" },
      { type = "unlock-recipe", recipe = "pb-fulgora-roboport-foreign" },
      { type = "unlock-recipe", recipe = "pb-fulgora-logistic-robot-home" },
      { type = "unlock-recipe", recipe = "pb-fulgora-logistic-robot-foreign" },
      { type = "unlock-recipe", recipe = "pb-fulgora-construction-robot-home" },
      { type = "unlock-recipe", recipe = "pb-fulgora-construction-robot-foreign" },
    },
  },

  -- ════════════════════════════════════════════════════════════════════════
  -- AQUILO TIER
  -- ════════════════════════════════════════════════════════════════════════

  {
    type = "technology",
    name = "pb-aquilo-robotics",
    icons = sprite_util.tech_icon(TECH_ICON, palettes.aquilo),
    unit = {
      count = 200,
      ingredients = { { "cryogenic-science-pack", 1 } },
      time = 60,
    },
    prerequisites = { "robotics" },
    effects = {
      { type = "unlock-recipe", recipe = "pb-aquilo-roboport-home" },
      { type = "unlock-recipe", recipe = "pb-aquilo-roboport-foreign" },
      { type = "unlock-recipe", recipe = "pb-aquilo-logistic-robot-home" },
      { type = "unlock-recipe", recipe = "pb-aquilo-logistic-robot-foreign" },
      { type = "unlock-recipe", recipe = "pb-aquilo-construction-robot-home" },
      { type = "unlock-recipe", recipe = "pb-aquilo-construction-robot-foreign" },
    },
  },

})
