# Nauvis Pre-Vanilla

## Identity

Early construction assistance before real robotics. Helps you build perimeter and core base faster during the "secure the base" phase. Deliberately inferior in every dimension — players should be glad to have it and equally glad to replace it.

No logistics bot. Logistics stays manual until vanilla robotics unlocks. Giving logistics automation before belts and trains are solved would short-circuit the early-game progression entirely.

---

## Roboport — Field Drone Depot

**Entity:** `pb-field-drone-depot` (Nauvis only, no foreign variant)

**Purpose:** Cover a small zone of ghost-placement so you can queue up walls and structures without placing every entity manually. Single charge station and low throughput mean it stalls visibly if you try to use it like real robotics — that friction is intentional.

| Stat | Value | vs Vanilla |
|---|---|---|
| Construction radius | 30 | 55% of vanilla 55 |
| Logistics radius | 1 (none) | — |
| Charging energy | 500 kW | 0.5× |
| Charging stations | 2 | 0.5× |
| Robot slots | 20 | 0.4× |

**Hard cap per force** enforced by script (`scripts/depot-cap.lua`). Unlocked in tiers via research:

| Research | Cap |
|---|---|
| `pb-field-depot-capacity-1` | 2 |
| `pb-field-depot-capacity-2` | 3 |
| `pb-field-depot-capacity-3` | 4 |
| `pb-field-depot-capacity-4` | 5 |

Final cap (5 depots) arrives at the oil / blue science era. Construction radius at max research targets ~40 tiles — a meaningful step below vanilla's 55 so the upgrade to real robotics still feels like a gear shift.

---

## Logistic Bot — None

Deliberate omission. Adding logistics automation before the belt/train era would eliminate a core progression beat. Players stage materials manually.

---

## Construction Bot — Field Drone

**Entity:** `pb-field-drone-home`

**Purpose:** Place ghosts faster so walling-in and core construction don't feel tedious. Hard speed cap and high energy costs ensure that trying to run a large swarm produces visible feedback — bots stall, builds drag, the player feels pressure to unlock real robotics.

| Stat | Value | vs Vanilla |
|---|---|---|
| Speed | 0.025 | 0.42× |
| Max speed (hard cap) | 0.04 | Research barely matters |
| Max energy | 0.5 MJ | 0.33× |
| Energy per move | 10 kJ | 2× vanilla (worse) |
| Energy per tick (idle) | 6 kW | 2× vanilla (worse) |
| Payload | 1 | Same |
| Health | 60 | 0.6× |
| Min charge threshold | 30% | Returns to depot frequently |
| Out-of-energy speed | 0.1× | Nearly stops — very visible |

---

## Non-Home Variant

None. Placement script returns the item if a Field Drone Depot or Field Drone is placed off Nauvis.
