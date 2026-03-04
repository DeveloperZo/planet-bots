-- prototypes/surface-properties.lua
-- Custom boolean surface properties — one per planet family.
-- Default value 0 (all surfaces). Each planet is patched to 1 in data-final-fixes.lua.
-- Used in recipe surface_conditions to gate home vs foreign variant production.
--
-- Condition pattern:
--   home recipe:    { property = "pb-vulcanus", min = 1 }  → Vulcanus assemblers only
--   foreign recipe: { property = "pb-vulcanus", max = 0 }  → all other surfaces

data:extend({
  { type = "surface-property", name = "pb-vulcanus", default_value = 0 },
  { type = "surface-property", name = "pb-gleba",    default_value = 0 },
  { type = "surface-property", name = "pb-fulgora",  default_value = 0 },
  { type = "surface-property", name = "pb-aquilo",   default_value = 0 },
})
