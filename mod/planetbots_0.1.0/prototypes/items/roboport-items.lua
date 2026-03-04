-- prototypes/items/roboport-items.lua
-- Two items per planet roboport family: home and foreign.
-- Each item's place_result points to its matching entity prototype.
-- The correct variant is produced at the assembler via surface_conditions on recipes.
-- No runtime placement swap needed for roboports.
--
-- Field Drone Depot: single item, single entity, Nauvis only.
-- Off-Nauvis placement blocked at runtime by scripts/placement.lua.

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local ICON = "__base__/graphics/icons/roboport.png"

data:extend({
  {
    type         = "item",
    name         = "pb-field-drone-depot",
    icons        = sprite_util.planet_icon(ICON, palettes.field_drone),
    stack_size   = 10,
    place_result = "pb-field-drone-depot",
    subgroup     = "pb-roboports",
    order        = "a-pb-depot",
  },
})

local FAMILIES = {
  { prefix = "pb-vulcanus-roboport", tint = palettes.vulcanus, order = "b-pb-vulcanus" },
  { prefix = "pb-gleba-roboport",    tint = palettes.gleba,    order = "b-pb-gleba"    },
  { prefix = "pb-fulgora-roboport",  tint = palettes.fulgora,  order = "b-pb-fulgora"  },
  { prefix = "pb-aquilo-roboport",   tint = palettes.aquilo,   order = "b-pb-aquilo"   },
}

local items = {}
for _, f in pairs(FAMILIES) do
  for _, variant in ipairs({ "home", "foreign" }) do
    local name = f.prefix .. "-" .. variant
    table.insert(items, {
      type         = "item",
      name         = name,
      icons        = sprite_util.planet_icon(ICON, f.tint),
      stack_size   = 10,
      place_result = name,
      subgroup     = "pb-roboports",
      order        = f.order .. "-" .. variant,
    })
  end
end

data:extend(items)
