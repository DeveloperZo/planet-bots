-- data.lua
-- Load order for Interplanetary Bots prototype definitions.
-- surface-properties.lua removed: no surface_conditions in the new specialty design.
-- Each Space Age specialty (Vulcanus / Fulgora / Aquilo) is one item + recipe; Gleba TBD.

-- ── Item groups / subgroups ─────────────────────────────────────────────────
require("prototypes.items.item-groups")

-- ── Items ───────────────────────────────────────────────────────────────────
require("prototypes.items.roboport-items")   -- field-drone-depot, field-chest, pb-aquilo-roboport
require("prototypes.items.bot-items")        -- pb-vulcanus-construction-robot, pb-fulgora-logistic-robot

-- ── Entities: roboports and structures ──────────────────────────────────────
require("prototypes.entities.field-drone-depot")     -- pre-vanilla Nauvis; scripted builder
require("prototypes.entities.field-chest")           -- material chest for field drone depot
require("prototypes.entities.field-drone-projectile") -- cosmetic visual for scripted builds
require("prototypes.entities.aquilo-roboport")       -- pb-aquilo-roboport (Aquilo specialty)

-- ── Entities: bots ──────────────────────────────────────────────────────────
require("prototypes.bots.vulcanus-construction-bot") -- pb-vulcanus-construction-robot (Vulcanus specialty)
require("prototypes.bots.fulgora-logistic-bot")      -- pb-fulgora-logistic-robot (Fulgora specialty)

-- ── Recipes ─────────────────────────────────────────────────────────────────
require("prototypes.recipes.roboports")  -- field-drone-depot, field-chest, pb-aquilo-roboport
require("prototypes.recipes.bots")       -- pb-vulcanus-construction-robot, pb-fulgora-logistic-robot

-- ── Technologies ────────────────────────────────────────────────────────────
require("prototypes.technologies.planetbots-technologies")
