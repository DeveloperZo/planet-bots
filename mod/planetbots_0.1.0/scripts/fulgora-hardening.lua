-- scripts/fulgora-hardening.lua
-- Runtime lightning hardening for Fulgora logistic bots.
--
-- Why needed: Factorio lightning applies raw damage with damage_type = "electric".
-- The prototype-level resistances = { { type = "electric", percent = 100 } }
-- handles electric turret and discharge damage. Lightning also uses "electric" type,
-- so resistance DOES cover lightning at prototype level in Factorio 2.0.
-- This script provides a belt-and-suspenders guarantee by healing back any
-- electric damage that slips through, using the Robot Attrition pattern.
--
-- Pattern source: Robot Attrition by Earendel (526K users) — uses on_entity_damaged
-- to detect and cancel damage on specific entity names. Same mechanism, different use.
--
-- CoVe note: damage_type is NON-OPTIONAL in on_entity_damaged.
-- Filter by damage_type.name == "electric" to avoid healing biters/bullets/etc.

local hardening = {}

-- All entities that should be immune to electric damage.
-- If additional Fulgora entities are added in future, extend this table.
local ELECTRIC_IMMUNE = {
  ["pb-fulgora-logistic-robot"] = true,
}

function hardening.register()
  script.on_event(defines.events.on_entity_damaged, function(event)
    local entity = event.entity
    if not (entity and entity.valid) then return end
    -- Only process our Fulgora bots
    if not ELECTRIC_IMMUNE[entity.name] then return end
    -- Only cancel electric damage (lightning, tesla turrets — thematically correct)
    -- CoVe fix: omitting this check would make bots immune to ALL damage
    if event.damage_type.name ~= "electric" then return end
    -- Restore the damage dealt — net result: no health lost from electric sources
    entity.health = math.min(entity.health + event.final_damage_amount, entity.max_health)
  end)
end

return hardening
