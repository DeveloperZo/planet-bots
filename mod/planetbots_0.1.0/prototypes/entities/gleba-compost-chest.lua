-- prototypes/entities/gleba-compost-chest.lua
-- Gleba specialty: the compost chest.
-- A container with a nutrient fuel slot (slot 1, locked by script).
-- While fueled: items inside spoil at 15% of normal rate.
-- When unfueled: items spoil at 130% of normal rate (mild penalty, not catastrophic).
-- Fuel consumption: 1 nutrient per minute.
--
-- This is a plain container, NOT a logistic-container. Players feed nutrients
-- via a filtered inserter. Items are extracted via a separate inserter.
-- inventory_type = "with_filters_and_bar" enables per-slot filtering so the script
-- can lock slot 1 to nutrients via LuaInventory.set_filter().
--
-- Runtime logic: scripts/compost-chest.lua
-- Craftable anywhere — gate is the supply chain: bioflux from Gleba.

local palettes    = require("prototypes.shared.palettes")
local sprite_util = require("prototypes.shared.sprite-util")

local tint    = palettes.gleba
local vanilla = data.raw["container"]["iron-chest"]

local ICON_BASE  = "__base__/graphics/icons/iron-chest.png"
local ICON_BADGE = "__base__/graphics/icons/roboport.png"

data:extend({
  {
    type          = "container",
    name          = "pb-gleba-compost-chest",
    flags         = { "placeable-player", "player-creation" },
    minable       = { mining_time = 0.1, result = "pb-gleba-compost-chest" },
    -- Two-layer specialty icon: iron-chest base + bio-green badge
    icons = {
      { icon = ICON_BASE,  icon_size = 64 },
      { icon = ICON_BADGE, icon_size = 64, scale = 0.4, shift = { 8, 8 }, tint = tint },
    },
    picture              = sprite_util.tinted_copy(vanilla.picture, tint),
    -- Match vanilla iron-chest footprint exactly: 1×1 tile, same as wooden/iron/steel chest
    collision_box        = {{ -0.35, -0.35 }, { 0.35, 0.35 }},
    selection_box        = {{ -0.5, -0.5 }, { 0.5, 0.5 }},
    fast_replaceable_group = "container",
    -- 30 slots: slot 1 = nutrient fuel (locked by script), slots 2-30 = storage.
    -- quality_affects_inventory_size scales this with quality tiers.
    inventory_size              = 30,
    inventory_type              = "with_filters_and_bar",
    quality_affects_inventory_size = true,
    -- Circuit connector: allows players to read chest contents / fuel state
    circuit_wire_max_distance   = 9,
    max_health                  = 150,
  }
})
