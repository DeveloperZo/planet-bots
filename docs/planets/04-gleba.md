# Gleba

## Identity

Endurance robotics for large, persistent swarms. Not the fastest, not the heaviest — the fleet that keeps going. Low idle drain and efficient movement mean hundreds of bots can stay airborne far longer between charges. Gleba's nutrient economy makes maintenance cheap; this family is the expression of that — a swarm that thrives when fed.

The emotional payoff: you have 300 bots and none of them are stalling. That's the Gleba feeling.

**Primary lever:** `energy_per_tick` (0.8 kW home vs vanilla 3 kW — 0.27× idle drain). Speed and payload offer no advantage.

---

## Roboport — Gleba Roboport

**Entities:** `pb-gleba-roboport-home` / `pb-gleba-roboport-foreign`

**Purpose:** Support large persistent bot fleets without charge congestion. The primary lever is `robot_slots_count` (80 home — 1.6× vanilla), which lets a genuinely large swarm sit in one port. Charging is moderate — steady enough to sustain the fleet without bursts, because the bots don't queue as aggressively (low idle drain means they return less often).

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Charging energy | 1,500 kW | 1,200 kW | 1,000 kW |
| Charging stations | 6 | 5 | 4 |
| Robot slots | **80** | **65** | 50 |
| Logistics radius | 25 | 25 | 25 |
| Construction radius | 55 | 55 | 55 |

**Recipe gate:** vanilla roboport + bioflux.

---

## Logistic Bot — Gleba Logistic Robot

**Entities:** `pb-gleba-logistic-robot-home` / `pb-gleba-logistic-robot-foreign`

**Purpose:** Sustained steady-state item movement without extreme charging throughput. The low idle drain means bots spend more time carrying and less time charging. Not fast, not heavy — just persistent. A large fleet of these outperforms a small fleet of specialists in any scenario where uptime matters more than burst speed.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Speed | 0.05 | 0.05 | 0.05 |
| Max speed | 0.15 | 0.15 | — |
| Max energy | 2 MJ | 1.8 MJ | 1.5 MJ |
| Energy per move | 2.5 kJ | 3 kJ | 5 kJ |
| Energy per tick | **0.8 kW** | 1.5 kW | 3 kW |
| Payload | 1 | 1 | 1 |

---

## Construction Bot — Gleba Construction Robot

**Entities:** `pb-gleba-construction-robot-home` / `pb-gleba-construction-robot-foreign`

**Purpose:** Long-running construction operations on large or spread-out sites. Where other families stall mid-build because bots drain and queue up, Gleba bots keep working. The extended airborne time per charge cycle means big blueprint drops complete without constant charging interruptions.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Speed | 0.055 | 0.055 | 0.06 |
| Max speed | 0.15 | 0.15 | — |
| Max energy | 2 MJ | 1.8 MJ | 1.5 MJ |
| Energy per move | 2.5 kJ | 3 kJ | 5 kJ |
| Energy per tick | **0.8 kW** | 1.5 kW | 3 kW |
| Payload | 1 | 1 | 1 |

---

## Non-Home Variant

Foreign variants retain above-vanilla efficiency (3 kJ/move vs 5 kJ vanilla, 1.5 kW/tick vs 3 kW vanilla) but lose the full endurance advantage. Useful for large-fleet setups anywhere.

**On Fulgora:** no electric resistance — not lightning-safe.  
**On Aquilo:** 5× drain reduces the endurance advantage significantly. Aquilo bots are built specifically for this environment and will outperform Gleba bots there.
