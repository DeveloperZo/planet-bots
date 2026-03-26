-- data.lua
-- Load order for PlanetBots prototype definitions.
-- surface-properties.lua removed: no surface_conditions in the new specialty design.
-- Each planet contributes one specialty item, gated by recipe ingredients only.

-- ── Item groups / subgroups ─────────────────────────────────────────────────
require("prototypes.items.item-groups")

-- ── Items ───────────────────────────────────────────────────────────────────
require("prototypes.items.roboport-items")   -- field-drone-depot, pb-aquilo-roboport, pb-gleba-compost-chest
require("prototypes.items.bot-items")        -- pb-field-drone, pb-vulcanus-construction-robot, pb-fulgora-logistic-robot

-- ── Entities: roboports and structures ──────────────────────────────────────
require("prototypes.entities.field-drone-depot")     -- pre-vanilla Nauvis; construction-only
require("prototypes.entities.aquilo-roboport")       -- pb-aquilo-roboport (Aquilo specialty)
require("prototypes.entities.gleba-compost-chest")   -- pb-gleba-compost-chest (Gleba specialty)

-- ── Entities: bots ──────────────────────────────────────────────────────────
require("prototypes.bots.field-drones")              -- pb-field-drone-home (pre-vanilla)
require("prototypes.bots.vulcanus-construction-bot") -- pb-vulcanus-construction-robot (Vulcanus specialty)
require("prototypes.bots.fulgora-logistic-bot")      -- pb-fulgora-logistic-robot (Fulgora specialty)

-- ── Recipes ─────────────────────────────────────────────────────────────────
require("prototypes.recipes.roboports")  -- field-drone-depot, pb-aquilo-roboport, pb-gleba-compost-chest
require("prototypes.recipes.bots")       -- pb-field-drone, pb-vulcanus-construction-robot, pb-fulgora-logistic-robot

-- ── Technologies ────────────────────────────────────────────────────────────
require("prototypes.technologies.planetbots-technologies")
