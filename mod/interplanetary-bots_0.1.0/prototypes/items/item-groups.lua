-- prototypes/items/item-groups.lua
-- Custom item subgroup for Interplanetary Bots repair packs.
-- Required by: prototypes/items/repair-packs.lua

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
