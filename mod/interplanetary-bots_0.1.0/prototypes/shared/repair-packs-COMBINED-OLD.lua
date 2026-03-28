-- prototypes/items/repair-packs.lua
-- Planet repair packs. Each is vanilla repair pack + local planet ingredient.
-- Required in the material slot of the matching roboport to enable full bonuses.
-- Off-planet, the port still operates at foreign-variant stats without the pack.

local packs = {
  {
    name        = "pb-foundry-repair-pack",
    planet      = "Vulcanus",
    ingredient  = "tungsten-plate",
    icon        = "__interplanetary-bots__/graphics/foundry-repair-pack.png",
  },
  {
    name        = "pb-gleba-repair-pack",
    planet      = "Gleba",
    ingredient  = "nutrients",         -- TODO: confirm exact item name from Space Age prototypes
    icon        = "__interplanetary-bots__/graphics/gleba-repair-pack.png",
  },
  {
    name        = "pb-fulgora-repair-pack",
    planet      = "Fulgora",
    ingredient  = "supercapacitor",    -- TODO: confirm exact item name
    icon        = "__interplanetary-bots__/graphics/fulgora-repair-pack.png",
  },
  {
    name        = "pb-cryo-repair-pack",
    planet      = "Aquilo",
    ingredient  = "lithium-plate",     -- TODO: confirm exact item name
    icon        = "__interplanetary-bots__/graphics/cryo-repair-pack.png",
  },
}

local items = {}
local recipes = {}

for _, pack in pairs(packs) do
  -- Item
  table.insert(items, {
    type       = "item",
    name       = pack.name,
    icons      = {{ icon = pack.icon, icon_size = 64 }},
    stack_size = 100,
    subgroup   = "logistic-network",  -- TODO: create custom subgroup
    order      = "z-pb-" .. pack.name,
  })

  -- Recipe: vanilla repair pack + local ingredient → planet repair pack
  -- Quantities and crafting time are TODO — set after balancing.
  table.insert(recipes, {
    type    = "recipe",
    name    = pack.name,
    enabled = false,  -- unlocked by technology
    ingredients = {
      { type = "item", name = "repair-pack",   amount = 1 },  -- TODO: quantity
      { type = "item", name = pack.ingredient, amount = 1 },  -- TODO: quantity
    },
    results = {
      { type = "item", name = pack.name, amount = 1 },
    },
    energy_required = 1,  -- TODO: tune
  })
end

data:extend(items)
data:extend(recipes)
