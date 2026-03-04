-- prototypes/entities/biostation-roboport.lua
-- Gleba Biostation Roboport. Fleet-stability focus — large bot capacity, steady charging.
-- Design intent: planets/04-gleba.md
--
-- Identity: keeps large bot networks stable over time. Fewer charge-deadlocks,
-- smoother recovery after construction bursts. Not raw throughput (that's Fulgora).
-- Primary levers: large robot_slots_count, steady charging_energy, more stations.
-- Maintenance token: Gleba Repair Pack (bioflux ingredient — natural Gleba loop).

local function make_biostation(name, params)
  return {
    type                   = "roboport",
    name                   = name,
    icons                  = {{ icon = "__planetbots__/graphics/icons/biostation-roboport.png", icon_size = 64 }},
    -- TODO: sprite tables from vanilla roboport, recolour (green/brown organic Gleba palette)
    collision_box          = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    selection_box          = {{ -2.0, -2.0 }, { 2.0, 2.0 }},
    -- Network coverage — vanilla values; radius is not a design lever
    logistics_radius       = 25,
    construction_radius    = 55,
    -- ── PRIMARY LEVERS ────────────────────────────────────────────────────
    charging_energy        = params.charging_energy,        -- moderate, not peak; fleet stability focus
    charging_station_count = params.charging_station_count, -- more stations than vanilla; spread the queue
    robot_slots_count      = params.robot_slots_count,      -- largest slot count in the family; big fleets
    material_slots_count   = 7,
    -- Energy
    energy_source          = { type = "electric", usage_priority = "secondary-input" },
    energy_usage           = "50kW",
    recharge_minimum       = "10MJ",
    -- TODO: copy open/close door effects from vanilla roboport
  }
end

data:extend({
  make_biostation("pb-biostation-roboport-home", {
    charging_energy        = "1500kW",  -- 1.5× vanilla; steady, not overwhelming
    charging_station_count = 6,         -- 1.5× vanilla
    robot_slots_count      = 80,        -- 1.6× vanilla; the meaningful fleet-size lever
  }),
  make_biostation("pb-biostation-roboport-foreign", {
    charging_energy        = "1200kW",  -- still above vanilla; useful for large fleets anywhere
    charging_station_count = 5,
    robot_slots_count      = 65,
  }),
})
