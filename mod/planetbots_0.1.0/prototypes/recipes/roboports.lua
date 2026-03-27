-- prototypes/recipes/roboports.lua
-- Specialty roboport and structure recipes. One recipe per specialty — no surface_conditions.
-- Gate is the supply chain: planet materials must be shipped to the crafting location.
--
-- Field Drone Depot: single recipe, no surface_conditions (Nauvis-only enforced at runtime).
--
-- Item name verification (CoVe): ice-platform confirmed on Aquilo wiki.
-- Ingredient amounts: first-pass values — balance pass in Milestone 1.3.

data:extend({
  -- ── Pre-vanilla ──────────────────────────────────────────────────────────
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

  -- ── Aquilo specialty: roboport ────────────────────────────────────────────
  -- Requires lithium-plate and quantum-processor from Aquilo supply line.
  {
    type            = "recipe",
    name            = "pb-aquilo-roboport",
    enabled         = false,
    ingredients     = {
      { type = "item", name = "roboport",          amount = 1  },
      { type = "item", name = "lithium-plate",     amount = 6  },  -- TODO: tune in balance pass
      { type = "item", name = "quantum-processor", amount = 4  },  -- TODO: tune in balance pass
      { type = "item", name = "ice-platform",      amount = 8  },  -- VERIFY IN-GAME: "ice-platform" unconfirmed; check /editor or data-raw-dump if recipe fails to load
    },
    results         = {{ type = "item", name = "pb-aquilo-roboport", amount = 1 }},
    energy_required = 15,
  },

  -- ── Gleba specialty: compost chest ───────────────────────────────────────
  -- Requires bioflux from Gleba supply line.
  {
    type            = "recipe",
    name            = "pb-gleba-compost-chest",
    enabled         = false,
    ingredients     = {
      { type = "item", name = "iron-chest",   amount = 1  },
      { type = "item", name = "bioflux",      amount = 3  },  -- TODO: tune in balance pass
      { type = "item", name = "nutrients",    amount = 10 },  -- TODO: tune in balance pass
      { type = "item", name = "wooden-chest", amount = 2  },
    },
    results         = {{ type = "item", name = "pb-gleba-compost-chest", amount = 1 }},
    energy_required = 5,
  },
})
