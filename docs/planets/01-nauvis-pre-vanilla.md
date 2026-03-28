# Nauvis Pre-Vanilla

## Identity

Early construction assistance before real robotics — a nanobots-style scripted builder. The player places a **Field Drone Depot** (roboport for the build-zone overlay), loads it with repair packs (ammo), and places **Field Chests** (containers) nearby loaded with construction materials. The depot auto-builds ghosts in its radius, consuming one repair pack and the ghost's ingredients per build. A cosmetic projectile flies from depot to ghost for visual feedback.

Deliberately inferior to real robotics in every dimension. No logistics network, no real bots, manual chest loading. Players should be glad to have it and equally glad to replace it.

---

## Two-entity system

### Field Drone Depot (`pb-field-drone-depot`)

**Type:** `roboport` (for construction_radius overlay). No real robots.

| Stat | Value | Notes |
|---|---|---|
| Construction radius | 30 | Build zone (from settings) |
| Logistics radius | 1 (none) | No logistics network |
| Robot slots | 0 | No real bots |
| Material slots | 4 | Holds repair packs (build ammo) |
| Charging | minimal | No bots to charge |

**Scripted building:** `scripts/field-drone-builder.lua` runs on `on_nth_tick`. Scans for ghosts in construction radius, pulls ingredients from nearby Field Chests, consumes one repair pack from material slots per ghost built, revives the ghost, fires a cosmetic projectile.

**Build rate:** ~2-3 ghosts/second per depot (configurable via startup settings).

### Field Chest (`pb-field-chest`)

**Type:** `container`. 16 slots (configurable).

Place within depot construction radius. Load with construction materials (iron plates, belts, inserters, etc.). The depot's script pulls items exclusively from Field Chests — never from the player's inventory.

Simple recipe: iron-plate (8) + wood (4).

---

## Shared placement cap

Both depots and Field Chests count toward one per-force cap. Enforced by `scripts/depot-cap.lua`.

| Research | Cap | Typical layout |
|---|---|---|
| Base (pb-field-drones) | 3 | 1 depot + 2 chests |
| pb-field-depot-capacity-1 | 5 | 1 depot + 4 chests |
| pb-field-depot-capacity-2 | 7 | 2 depots + 5 chests |
| pb-field-depot-capacity-3 | 10 | 2-3 depots + chests |
| pb-field-depot-capacity-4 | 14 | 3-4 depots + chests |

---

## Gameplay loop

1. Research `pb-field-drones` (automation science, 50 packs)
2. Craft and place a Field Drone Depot
3. Craft and place 1-2 Field Chests within the depot's blue radius
4. Load repair packs into the depot (material slots)
5. Load construction materials into the chests
6. Blueprint something in range — depot auto-builds
7. Refill chests and repair packs as needed

**Key difference from real robotics:** manual loading. No logistics network to auto-resupply. When materials run out, building stops. This makes real robotics a genuine upgrade, not just "more of the same."

---

## Non-Home Variant

None. Placement script returns the item if a Field Drone Depot or Field Chest is placed off Nauvis.
