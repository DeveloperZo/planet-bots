-- prototypes/recipes/bots.lua
-- Two recipes per planet bot family: home (planet-gated) and foreign (everywhere else).
-- surface_conditions uses custom pb-* surface properties patched in data-final-fixes.lua.
--
--   Home recipe:    { property = "pb-vulcanus", min = 1 } => Vulcanus assemblers only
--   Foreign recipe: { property = "pb-vulcanus", max = 0 } => all other surfaces (default 0)
--
-- Field Drone: single recipe, no surface_conditions (Nauvis-only enforced at runtime).
-- Ingredient quantities: TODO — balance pass.

data:extend({
  {
    type            = "recipe",
    name            = "pb-field-drone",
    enabled         = false,
    ingredients     = {
      { type = "item", name = "iron-plate",         amount = 3 },
      { type = "item", name = "copper-plate",       amount = 2 },
      { type = "item", name = "electronic-circuit", amount = 2 },
    },
    results         = {{ type = "item", name = "pb-field-drone", amount = 1 }},
    energy_required = 3,
  },
})

local FAMILIES = {
  -- Vulcanus
  {
    prefix     = "pb-vulcanus-logistic-robot",
    property   = "pb-vulcanus",
    craft_time = 5,
    ingredients = {
      { type = "item", name = "logistic-robot",  amount = 1 },
      { type = "item", name = "tungsten-plate",  amount = 3 },  -- TODO: tune
    },
  },
  {
    prefix     = "pb-vulcanus-construction-robot",
    property   = "pb-vulcanus",
    craft_time = 5,
    ingredients = {
      { type = "item", name = "construction-robot", amount = 1 },
      { type = "item", name = "tungsten-plate",     amount = 3 },  -- TODO: tune
    },
  },
  -- Gleba
  {
    prefix     = "pb-gleba-logistic-robot",
    property   = "pb-gleba",
    craft_time = 5,
    ingredients = {
      { type = "item", name = "logistic-robot", amount = 1 },
      { type = "item", name = "bioflux",        amount = 3 },  -- TODO: tune
    },
  },
  {
    prefix     = "pb-gleba-construction-robot",
    property   = "pb-gleba",
    craft_time = 5,
    ingredients = {
      { type = "item", name = "construction-robot", amount = 1 },
      { type = "item", name = "bioflux",            amount = 3 },  -- TODO: tune
    },
  },
  -- Fulgora
  {
    prefix     = "pb-fulgora-logistic-robot",
    property   = "pb-fulgora",
    craft_time = 5,
    ingredients = {
      { type = "item", name = "logistic-robot", amount = 1 },
      { type = "item", name = "supercapacitor", amount = 1 },  -- TODO: tune
    },
  },
  {
    prefix     = "pb-fulgora-construction-robot",
    property   = "pb-fulgora",
    craft_time = 5,
    ingredients = {
      { type = "item", name = "construction-robot", amount = 1 },
      { type = "item", name = "supercapacitor",     amount = 1 },  -- TODO: tune
    },
  },
  -- Aquilo
  {
    prefix     = "pb-aquilo-logistic-robot",
    property   = "pb-aquilo",
    craft_time = 8,
    ingredients = {
      { type = "item", name = "logistic-robot",    amount = 1 },
      { type = "item", name = "lithium-plate",     amount = 3 },  -- TODO: tune
      { type = "item", name = "quantum-processor", amount = 1 },
    },
  },
  {
    prefix     = "pb-aquilo-construction-robot",
    property   = "pb-aquilo",
    craft_time = 8,
    ingredients = {
      { type = "item", name = "construction-robot", amount = 1 },
      { type = "item", name = "lithium-plate",      amount = 3 },  -- TODO: tune
      { type = "item", name = "quantum-processor",  amount = 1 },
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
