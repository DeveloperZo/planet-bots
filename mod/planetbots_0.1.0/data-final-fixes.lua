-- data-final-fixes.lua
-- Patches vanilla Space Age planet surface_properties to set PlanetBots home flags.
-- Runs after all data.lua and data-updates.lua, so all planet prototypes are present.
-- The flags are numeric (0 = not home, 1 = home) per SurfacePropertyPrototype.

local function set_planet_flag(planet_name, property_name)
  local planet = data.raw["planet"][planet_name]
  if not planet then
    log("[PlanetBots] WARNING: planet '" .. planet_name .. "' not found — cannot set " .. property_name)
    return
  end
  planet.surface_properties = planet.surface_properties or {}
  planet.surface_properties[property_name] = 1
end

set_planet_flag("vulcanus", "pb-vulcanus")
set_planet_flag("gleba",    "pb-gleba")
set_planet_flag("fulgora",  "pb-fulgora")
set_planet_flag("aquilo",   "pb-aquilo")
