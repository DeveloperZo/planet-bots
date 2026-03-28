# Nauvis Pre-Vanilla

## Identity

Early construction assistance before real robotics — a nanobots-style scripted builder. The player places a **Field Drone Depot** (roboport for the build-zone overlay), loads it with **Field Charges** (cheap ammo), and places one **Field Chest** (container) within range loaded with construction materials. The depot auto-builds ghosts in its radius, consuming one Field Charge and the ghost's ingredients per build. A cosmetic projectile flies from depot to ghost for visual feedback.

Deliberately inferior to real robotics in every dimension. No logistics network, no real bots, manual chest loading. Players should be glad to have it and equally glad to replace it.

---

## Three-entity system

### Field Drone Depot (`pb-field-drone-depot`)

**Type:** `roboport` (for construction_radius overlay). No real robots.

| Stat | Value | Notes |
|---|---|---|
| Construction radius | 30 | Build zone (from settings) |
| Logistics radius | 1 (none) | No logistics network |
| Robot slots | 0 | No real bots |
| Material slots | 4 | Holds Field Charges (build ammo) |
| Charging | minimal | No bots to charge |

**Scripted building:** `scripts/field-drone-builder.lua` runs on `on_nth_tick`. Scans for ghosts in construction radius, pulls ingredients from the paired Field Chest (and player inventory after final research), consumes one Field Charge from material slots per ghost built, revives the ghost, fires a cosmetic projectile.

**Build rate:** ~2-3 ghosts/second per depot (configurable via startup settings).

**UX alerts:** If a depot has charges loaded but no chest in range, a custom alert appears on the minimap (similar to "not connected to logistic network"). On placement, a flying-text hint reminds the player to place a chest.

### Field Chest (`pb-field-chest`)

**Type:** `container`. 16 slots (configurable).

Must be placed within a depot's construction radius. One chest per depot (enforced at placement). Load with construction materials (iron plates, belts, inserters, etc.). The depot's script pulls items exclusively from Field Chests — and from player inventory after the final capacity research.

Simple recipe: iron-plate (8) + wood (4).

### Field Charge (`pb-field-charge`)

**Type:** `repair-tool` (fits in roboport material slots). Cheap ammo consumed 1 per ghost built.

Recipe: iron-gear-wheel (1) + electronic-circuit (1) → 8 Field Charges. Cost per charge is comparable to nanobots ammo.

---

## Depot cap (depot-only)

Only depots are capped. Chests are implicitly limited to 1 per depot area. Enforced by `scripts/depot-cap.lua` and `scripts/placement.lua`.

| Research | Depot limit | Notes |
|---|---|---|
| Base (pb-field-drones) | 1 | 1 depot + 1 chest |
| pb-field-depot-capacity-1 | 2 | |
| pb-field-depot-capacity-2 | 3 | |
| pb-field-depot-capacity-3 | 4 | |
| pb-field-depot-capacity-4 | 5 | Also unlocks player inventory as material source |

---

## Gameplay loop

1. Research `pb-field-drones` (automation science, 50 packs)
2. Craft and place a Field Drone Depot
3. Craft and place one Field Chest within the depot's blue radius
4. Craft Field Charges and load them into the depot (material slots)
5. Load construction materials into the chest
6. Blueprint something in range — depot auto-builds
7. Refill chest and charges as needed

**Player inventory source (final research):** After researching `pb-field-depot-capacity-4`, the depot can also pull items directly from any player standing within its range. This removes the chest-loading bottleneck for experienced players while keeping the early game constrained.

**Key difference from real robotics:** Manual loading. No logistics network to auto-resupply. When materials run out, building stops. This makes real robotics a genuine upgrade, not just "more of the same."

---

## Non-Home Variant

None. Placement script returns the item if a Field Drone Depot or Field Chest is placed off Nauvis.
