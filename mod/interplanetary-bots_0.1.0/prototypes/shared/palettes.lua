-- prototypes/shared/palettes.lua
-- Planet color palettes used for tinting vanilla sprites and icons.
-- Each color is a plain RGBA table compatible with Factorio's Color type.
--
-- Home variants: full-brightness planet color — the bot/port is in its element.
-- Foreign variants: dimmed to ~55% brightness — visually "away from home".

local function dim(c, factor)
  return { r = c.r * factor, g = c.g * factor, b = c.b * factor, a = 1.0 }
end

local home = {
  field_drone = { r = 0.75, g = 0.65, b = 0.45, a = 1.0 },  -- iron/rust — pre-vanilla feel
  vulcanus    = { r = 1.00, g = 0.40, b = 0.10, a = 1.0 },  -- orange-red industrial
  gleba       = { r = 0.25, g = 0.80, b = 0.20, a = 1.0 },  -- bio green
  fulgora     = { r = 1.00, g = 0.90, b = 0.10, a = 1.0 },  -- electric yellow
  aquilo      = { r = 0.30, g = 0.70, b = 1.00, a = 1.0 },  -- cryo blue
}

return {
  field_drone         = home.field_drone,
  vulcanus            = home.vulcanus,
  gleba               = home.gleba,
  fulgora             = home.fulgora,
  aquilo              = home.aquilo,
  vulcanus_foreign    = dim(home.vulcanus, 0.55),
  gleba_foreign       = dim(home.gleba,    0.55),
  fulgora_foreign     = dim(home.fulgora,  0.55),
  aquilo_foreign      = dim(home.aquilo,   0.55),
}
