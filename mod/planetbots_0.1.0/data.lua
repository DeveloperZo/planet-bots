-- data.lua
-- Load order: surface-properties => item-groups => items => entities => bots => recipes => technologies
-- surface-properties must load before recipes so surface_conditions property IDs are valid.

-- ── Surface properties ───────────────────────────────────────────────────────
require("prototypes.surface-properties")

-- ── Item groups / subgroups ─────────────────────────────────────────────────
require("prototypes.items.item-groups")

-- ── Items ───────────────────────────────────────────────────────────────────
require("prototypes.items.roboport-items")
require("prototypes.items.bot-items")

-- ── Entities: roboports ─────────────────────────────────────────────────────
require("prototypes.entities.field-drone-depot")  -- pre-vanilla Nauvis; construction-only, no logistics radius
require("prototypes.entities.vulcanus-roboport")  -- pb-vulcanus-roboport-{home,foreign}
require("prototypes.entities.gleba-roboport")     -- pb-gleba-roboport-{home,foreign}
require("prototypes.entities.fulgora-roboport")   -- pb-fulgora-roboport-{home,foreign}
require("prototypes.entities.aquilo-roboport")    -- pb-aquilo-roboport-{home,foreign}

-- ── Entities: bots ──────────────────────────────────────────────────────────
require("prototypes.bots.field-drones")           -- pre-vanilla Nauvis; construction only, no logistic
require("prototypes.bots.vulcanus-bots")          -- pb-vulcanus-{logistic,construction}-robot-{home,foreign}
require("prototypes.bots.gleba-bots")             -- pb-gleba-{logistic,construction}-robot-{home,foreign}
require("prototypes.bots.fulgora-bots")           -- pb-fulgora-{logistic,construction}-robot-{home,foreign}
require("prototypes.bots.aquilo-bots")            -- pb-aquilo-{logistic,construction}-robot-{home,foreign}

-- ── Recipes ─────────────────────────────────────────────────────────────────
require("prototypes.recipes.roboports")
require("prototypes.recipes.bots")

-- ── Technologies ────────────────────────────────────────────────────────────
require("prototypes.technologies.planetbots-technologies")
