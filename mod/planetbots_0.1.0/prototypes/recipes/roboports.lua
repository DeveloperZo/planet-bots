-- prototypes/recipes/roboports.lua
-- Two recipes per planet roboport family: home (planet-gated) and foreign (everywhere else).
-- surface_conditions uses custom pb-* surface properties patched in data-final-fixes.lua.
--
--   Home recipe:    { property = "pb-vulcanus", min = 1 } => Vulcanus assemblers only
--   Foreign recipe: { property = "pb-vulcanus", max = 0 } => all other surfaces (default 0)
--
-- Field Drone Depot: single recipe, no surface_conditions.
-- Off-Nauvis placement blocked at runtime by scripts/placement.lua.
-- Ingredient quantities: TODO — balance pass.

data:extend({
  {
    type            = "recipe",
    name            = "pb-field-drone-depot",
    enabled         = false,
    ingredients     = {
      { type = "item", name = "iron-plate",         amount = 20 },
      { type = "item", name = "copper-plate",       amount = 10 },
      { type = "item", name = "steel-plate",        amount = 5  },
      { type = "item", name = "electronic-circuit", amount = 10 },
    },
    results         = {{ type = "item", name = "pb-field-drone-depot", amount = 1 }},
    energy_required = 5,
  },
})

local FAMILIES = {
  {
    prefix     = "pb-vulcanus-roboport",
    property   = "pb-vulcanus",
    craft_time = 10,
    ingredients = {
      { type = "item", name = "roboport",       amount = 1  },
      { type = "item", name = "tungsten-plate", amount = 10 },  -- TODO: tune
      { type = "item", name = "calcite",        amount = 5  },  -- TODO: tune
    },
  },
  {
    prefix     = "pb-gleba-roboport",
    property   = "pb-gleba",
    craft_time = 10,
    ingredients = {
      { type = "item", name = "roboport", amount = 1 },
      { type = "item", name = "bioflux",  amount = 5 },  -- TODO: tune
    },
  },
  {
    prefix     = "pb-fulgora-roboport",
    property   = "pb-fulgora",
    craft_time = 10,
    ingredients = {
      { type = "item", name = "roboport",       amount = 1 },
      { type = "item", name = "supercapacitor", amount = 5 },  -- TODO: tune
      { type = "item", name = "holmium-plate",  amount = 5 },  -- TODO: tune
    },
  },
  {
    prefix     = "pb-aquilo-roboport",
    property   = "pb-aquilo",
    craft_time = 15,
    ingredients = {
      { type = "item", name = "roboport",          amount = 1  },
      { type = "item", name = "lithium-plate",     amount = 10 },  -- TODO: tune
      { type = "item", name = "quantum-processor", amount = 3  },  -- expensive late-game gate
    },
  },
}

local recipes = {}
for _, f in pairs(FAMILIES) do
  table.insert(recipes, {
    type               = "recipe",
    name               = f.prefix .. "-home",
    enabled            = false,
    surface_conditions = { { property = f.property, min = 1 } },
    ingredients        = f.ingredients,
    results            = {{ type = "item", name = f.prefix .. "-home", amount = 1 }},
    energy_required    = f.craft_time,
  })
  table.insert(recipes, {
    type               = "recipe",
    name               = f.prefix .. "-foreign",
    enabled            = false,
    surface_conditions = { { property = f.property, max = 0 } },
    ingredients        = f.ingredients,
    results            = {{ type = "item", name = f.prefix .. "-foreign", amount = 1 }},
    energy_required    = f.craft_time,
  })
end

data:extend(recipes)
