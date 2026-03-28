-- prototypes/items/item-groups.lua
-- Custom item subgroups for Interplanetary Bots.

data:extend({
  {
    type     = "item-subgroup",
    name     = "pb-roboports",
    group    = "logistics",
    order    = "z-pb-a",
  },
  {
    type     = "item-subgroup",
    name     = "pb-bots",
    group    = "logistics",
    order    = "z-pb-b",
  },
})
