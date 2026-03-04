# Fulgora

## Identity

Fast, lightning-hardened robotics. The storm rolls in and your bots don't care. This family solves two problems simultaneously: bots and ports that don't get deleted by lightning, and the fastest charging throughput in the mod to clear the backlog that builds up during a storm blackout.

Speed is the primary performance lever. Payload is deliberately low — this is a courier, not a hauler. The large battery on the home variant (~1100 tile range at full drain) is specifically for surviving a blackout mid-flight, not for general range.

**Primary levers:** `speed` (fastest family) + `electric resistance` (100%) + `charging_energy` (6× vanilla burst).

> **Lightning damage type:** Resistance entries are keyed by damage type name exactly. "electric" is used here. Validate against actual Space Age lightning damage type before shipping.

---

## Roboport — Fulgora Roboport

**Entities:** `pb-fulgora-roboport-home` / `pb-fulgora-roboport-foreign`

**Purpose:** Keep bot infrastructure operational during storms and clear the post-storm charge queue fast. 100% electric resistance means the structure survives a lightning strike. 6× vanilla charging energy means when power comes back on, the charging backlog drains before the next storm hits.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Charging energy | **6,000 kW** | **3,000 kW** | 1,000 kW |
| Charging stations | **10** | 7 | 4 |
| Robot slots | 60 | 55 | 50 |
| Logistics radius | 25 | 25 | 25 |
| Construction radius | 55 | 55 | 55 |
| Electric resistance | **100%** | **100%** | None |

**Recipe gate:** vanilla roboport + supercapacitor + holmium plate.

---

## Logistic Bot — Fulgora Logistic Robot

**Entities:** `pb-fulgora-logistic-robot-home` / `pb-fulgora-logistic-robot-foreign`

**Purpose:** Fast short-hop deliveries and burst resupply. Ammo to turrets during a raid, components to assemblers between storms, emergency top-offs. Not a bulk logistics bot — payload = 1 keeps it niche. The 5 MJ battery on the home variant exists specifically to survive flying through a blackout without a charge stop.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Speed | **0.08** | **0.08** | 0.05 |
| Max speed | **0.25** | **0.25** | — |
| Max energy | 5 MJ | 3 MJ | 1.5 MJ |
| Energy per move | 4 kJ | 4 kJ | 5 kJ |
| Energy per tick | 3 kW | 3 kW | 3 kW |
| Payload | 1 | 1 | 1 |
| Electric resistance | **100%** | **100%** | None |
| Min charge threshold | 12% | 12% | 20% |

---

## Construction Bot — Fulgora Construction Robot

**Entities:** `pb-fulgora-construction-robot-home` / `pb-fulgora-construction-robot-foreign`

**Purpose:** Fast short-hop builds and rapid-response repairs in storm zones. Ghosts and damaged structures get addressed quickly because the bots move fast. Not suited for large builds requiring many trips — low payload and modest battery are the limiting factors there.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Speed | **0.09** | **0.09** | 0.06 |
| Max speed | **0.25** | **0.25** | — |
| Max energy | 5 MJ | 3 MJ | 1.5 MJ |
| Energy per move | 4 kJ | 4 kJ | 5 kJ |
| Energy per tick | 3 kW | 3 kW | 3 kW |
| Payload | 1 | 1 | 1 |
| Electric resistance | **100%** | **100%** | None |
| Min charge threshold | 12% | 12% | 20% |

---

## Non-Home Variant

Foreign variants retain full speed and electric immunity — the two core identity stats travel with the bot. Battery is reduced (3 MJ vs 5 MJ). Still the fastest family off-planet and still lightning-safe. Consistent with Space Age's "exported tech can be good everywhere" philosophy.

**On Vulcanus:** speed advantage is less meaningful vs. payload bots for dense hub work.  
**On Gleba:** viable but not optimal — endurance bots suit large persistent swarms better.  
**On Aquilo:** 5× drain degrades effective range significantly even with the 3 MJ battery.
