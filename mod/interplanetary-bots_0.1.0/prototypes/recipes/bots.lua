-- prototypes/recipes/bots.lua
-- Specialty bot recipes. One recipe per specialty — no surface_conditions.
-- Gate is the supply chain: planet materials must be shipped to the crafting location.
--
-- Item name verification (CoVe): supercapacitor confirmed on Fulgora wiki.
-- Ingredient amounts: first-pass values — balance pass in Milestone 1.3.

data:extend({
  -- ── Vulcanus specialty: construction robot ────────────────────────────────
  -- Requires tungsten-plate and calcite from Vulcanus supply line.
  {
    type            = "recipe",
    name            = "pb-vulcanus-construction-robot",
    enabled         = false,
    ingredients     = {
      { type = "item", name = "construction-robot", amount = 1 },
      { type = "item", name = "tungsten-plate",     amount = 5 },  -- TODO: tune in balance pass
      { type = "item", name = "calcite",            amount = 3 },  -- TODO: tune in balance pass
      { type = "item", name = "steel-plate",        amount = 4 },
    },
    results         = {{ type = "item", name = "pb-vulcanus-construction-robot", amount = 1 }},
    energy_required = 5,
  },

  -- ── Fulgora specialty: logistic robot ─────────────────────────────────────
  -- Requires supercapacitor and holmium-plate from Fulgora supply line.
  {
    type            = "recipe",
    name            = "pb-fulgora-logistic-robot",
    enabled         = false,
    ingredients     = {
      { type = "item", name = "logistic-robot",   amount = 1 },
      { type = "item", name = "supercapacitor",   amount = 4 },  -- TODO: verify item name at runtime; tune in balance pass
      { type = "item", name = "holmium-plate",    amount = 3 },  -- TODO: tune in balance pass
      { type = "item", name = "advanced-circuit", amount = 6 },
    },
    results         = {{ type = "item", name = "pb-fulgora-logistic-robot", amount = 1 }},
    energy_required = 5,
  },
})
