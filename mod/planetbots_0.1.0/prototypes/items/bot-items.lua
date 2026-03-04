-- prototypes/items/bot-items.lua
-- Two items per planet bot family: home and foreign.
-- Each item's place_result points to its matching entity prototype.
-- The correct variant is produced at the assembler via surface_conditions on recipes.
--
-- Field Drone: single item (Nauvis only, no foreign variant).
-- All other families: logistic + construction, each with home + foreign item.

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local LOGISTIC_ICON     = "__base__/graphics/icons/logistic-robot.png"
local CONSTRUCTION_ICON = "__base__/graphics/icons/construction-robot.png"

data:extend({
  {
    type         = "item",
    name         = "pb-field-drone",
    icons        = sprite_util.planet_icon(CONSTRUCTION_ICON, palettes.field_drone),
    stack_size   = 50,
    place_result = "pb-field-drone-home",
    subgroup     = "pb-bots",
    order        = "a-pb-drone",
  },
})

local FAMILIES = {
  -- Vulcanus
  { prefix = "pb-vulcanus-logistic-robot",     icon = LOGISTIC_ICON,     tint = palettes.vulcanus, order = "b-pb-vulcanus-l" },
  { prefix = "pb-vulcanus-construction-robot", icon = CONSTRUCTION_ICON, tint = palettes.vulcanus, order = "b-pb-vulcanus-c" },
  -- Gleba
  { prefix = "pb-gleba-logistic-robot",        icon = LOGISTIC_ICON,     tint = palettes.gleba,    order = "b-pb-gleba-l"    },
  { prefix = "pb-gleba-construction-robot",    icon = CONSTRUCTION_ICON, tint = palettes.gleba,    order = "b-pb-gleba-c"    },
  -- Fulgora
  { prefix = "pb-fulgora-logistic-robot",      icon = LOGISTIC_ICON,     tint = palettes.fulgora,  order = "b-pb-fulgora-l"  },
  { prefix = "pb-fulgora-construction-robot",  icon = CONSTRUCTION_ICON, tint = palettes.fulgora,  order = "b-pb-fulgora-c"  },
  -- Aquilo
  { prefix = "pb-aquilo-logistic-robot",       icon = LOGISTIC_ICON,     tint = palettes.aquilo,   order = "b-pb-aquilo-l"   },
  { prefix = "pb-aquilo-construction-robot",   icon = CONSTRUCTION_ICON, tint = palettes.aquilo,   order = "b-pb-aquilo-c"   },
}

local items = {}
for _, f in pairs(FAMILIES) do
  for _, variant in ipairs({ "home", "foreign" }) do
    local name = f.prefix .. "-" .. variant
    table.insert(items, {
      type         = "item",
      name         = name,
      icons        = sprite_util.planet_icon(f.icon, f.tint),
      stack_size   = 50,
      place_result = name,
      subgroup     = "pb-bots",
      order        = f.order .. "-" .. variant,
    })
  end
end

data:extend(items)
