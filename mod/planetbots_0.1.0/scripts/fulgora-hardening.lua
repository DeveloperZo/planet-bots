-- scripts/fulgora-hardening.lua
-- Runtime lightning hardening for Fulgora logistic bots.
--
-- Why needed: Factorio lightning applies electric damage (damage_type = "electric").
-- The prototype-level resistances = { { type = "electric", percent = 100 } }
-- handles electric turret and discharge damage at the data stage. Lightning uses
-- the same "electric" damage type, so prototype resistance covers it — but this
-- script provides a belt-and-suspenders guarantee by healing back any electric
-- damage that slips through (e.g. via mods that bypass resistance).
--
-- Pattern: Robot Attrition by Earendel (526K users) — on_entity_damaged to detect
-- and heal damage on specific entity names.
--
-- CoVe note: event.damage_type is LuaDamagePrototype (non-optional — always present).
-- We filter by event.damage_type.name == "electric" to only heal electric damage.
-- Omitting this check would make bots immune to ALL damage types (biters, bullets…).
--
-- IMPORTANT: This module exposes on_entity_damaged as a plain function.
-- control.lua registers it via script.on_event(defines.events.on_entity_damaged, …).
-- This keeps all event registrations in one place, avoiding silent overwrites.

local hardening = {}

-- All entities that should be immune to electric damage.
local ELECTRIC_IMMUNE = {
  ["pb-fulgora-logistic-robot"] = true,
}

-- Called from control.lua for on_entity_damaged events.
function hardening.on_entity_damaged(event)
  local entity = event.entity
  if not (entity and entity.valid) then return end
  if not ELECTRIC_IMMUNE[entity.name] then return end
  -- Only heal electric damage — covers lightning and tesla turrets (both thematic)
  if event.damage_type.name ~= "electric" then return end
  -- Restore the damage dealt; net result: no health lost from electric sources
  entity.health = math.min(entity.health + event.final_damage_amount, entity.max_health)
end

return hardening
