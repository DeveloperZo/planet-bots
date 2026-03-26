-- prototypes/shared/sprite-util.lua
-- Helpers for building tinted copies of vanilla sprites and icons.
-- All entity, bot, item, and technology files use this instead of custom PNG assets.

local util = require("util")
local M    = {}

-- Recursively apply tint to every drawable layer in a sprite/animation table.
-- Handles: layers[], hr_version, sheet, sheets[].
local function apply_tint(obj, tint)
  if type(obj) ~= "table" then return end
  if obj.layers then
    for i = 1, #obj.layers do
      apply_tint(obj.layers[i], tint)
    end
  else
    obj.tint = tint
    obj.apply_runtime_tint = false  -- planet tint replaces force-color tinting
    if obj.hr_version then
      obj.hr_version.tint = tint
      obj.hr_version.apply_runtime_tint = false
    end
    if obj.sheet  then apply_tint(obj.sheet, tint) end
    if obj.sheets then
      for i = 1, #obj.sheets do apply_tint(obj.sheets[i], tint) end
    end
  end
end

-- Deep-copy a vanilla sprite/animation and apply tint to all layers.
-- Returns nil safely when the source field is nil (for optional sprite fields).
function M.tinted_copy(sprite, tint)
  if not sprite then return nil end
  local copy = util.table.deepcopy(sprite)
  apply_tint(copy, tint)
  return copy
end

-- Standard 64x64 icons array using a vanilla icon path with planet tint.
function M.planet_icon(icon_path, tint)
  return { { icon = icon_path, icon_size = 64, tint = tint } }
end

-- Standard 256x256 icons array for technology entries with planet tint.
function M.tech_icon(icon_path, tint)
  return { { icon = icon_path, icon_size = 256, tint = tint } }
end

-- Two-layer specialty icon: full-size untinted base + small planet-colored badge.
-- The badge distinguishes specialty items from vanilla at a glance.
-- scale=0.4 (not 0.3): at 32px inventory size, 0.3 is ~10px and barely visible.
function M.specialty_icon(base_icon, tint)
  return {
    { icon = base_icon,                                  icon_size = 64 },
    { icon = "__base__/graphics/icons/roboport.png",     icon_size = 64,
      scale = 0.4, shift = { 8, 8 }, tint = tint },
  }
end

-- Two-layer specialty icon for technology entries (256px base).
function M.specialty_tech_icon(base_icon, tint)
  return {
    { icon = base_icon,                                  icon_size = 256 },
    { icon = "__base__/graphics/icons/roboport.png",     icon_size = 64,
      scale = 1.6, shift = { 32, 32 }, tint = tint },
  }
end

return M
