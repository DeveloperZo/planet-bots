# Aquilo

## Identity

Deep-battery robotics engineered to remain viable under 5× energy drain. Not the fastest, not the heaviest — the only family that feels normal when operating in extreme cold. Everyone else's bots freeze and die. Yours don't.

The 5× multiplier makes vanilla bots cover ~52 tiles before needing a charge on Aquilo. Aquilo bots under the same drain cover ~634 tiles. That gap is the entire point of this family.

Off-planet the foreign variant (6 MJ, 3 kJ/move, 1 kW/tick) is genuinely the best general-purpose bot for energy-sparse situations. This is intentional — Space Age rewards players who reach hard planets with tech that's good everywhere. Other families retain their niches: Vulcanus wins payload, Fulgora wins speed and lightning safety.

**Primary levers:** `max_energy` (9 MJ home — 6× vanilla) + `energy_per_move` (2.5 kJ — 0.5× vanilla) + `energy_per_tick` (0.5 kW — near-zero idle).

---

## Aquilo environment context

All airborne robots on Aquilo operate under a 5× energy drain multiplier:

| Bot | Effective kJ/move | Effective kW/tick | Range at 12% threshold |
|---|---|---|---|
| Vanilla on Aquilo | 25 kJ | 15 kW | ~52 tiles |
| Aquilo home on Aquilo | 12.5 kJ | 2.5 kW | ~634 tiles |
| Aquilo foreign on Aquilo | 15 kJ | 5 kW | ~352 tiles |

---

## Roboport — Aquilo Roboport

**Entities:** `pb-aquilo-roboport-home` / `pb-aquilo-roboport-foreign`

**Purpose:** Make bot networks functional on Aquilo by providing steady charging that keeps up with high-drain recharge cycles. Not peak burst (that's Fulgora) — the goal is sustained throughput so the constant drain doesn't cause a feedback loop where bots queue faster than they charge. Large robot slot count supports the bigger swarms needed to cover ground when drain is severe. Recipe is expensive (lithium + quantum processors) to match the late-game unlock timing.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Charging energy | 4,000 kW | 2,500 kW | 1,000 kW |
| Charging stations | 6 | 5 | 4 |
| Robot slots | **70** | **60** | 50 |
| Logistics radius | 25 | 25 | 25 |
| Construction radius | 55 | 55 | 55 |

**Recipe gate:** vanilla roboport + lithium plate + quantum processor.

---

## Logistic Bot — Aquilo Logistic Robot

**Entities:** `pb-aquilo-logistic-robot-home` / `pb-aquilo-logistic-robot-foreign`

**Purpose:** Long-range delivery under harsh energy conditions without needing a charging port every few tiles. The 9 MJ battery and low energy costs let bots complete long routes that would require multiple charge stops from any other family. Slight payload bonus (2) is secondary to the energy advantage. Speed is slightly below vanilla — the tradeoff for capacity is deliberate.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Speed | 0.04 | 0.04 | 0.05 |
| Max speed | 0.18 | 0.18 | — |
| Max energy | **9 MJ** | **6 MJ** | 1.5 MJ |
| Energy per move | **2.5 kJ** | 3 kJ | 5 kJ |
| Energy per tick | **0.5 kW** | 1 kW | 3 kW |
| Payload | 2 | 2 | 1 |
| Min charge threshold | 12% | 12% | 20% |

---

## Construction Bot — Aquilo Construction Robot

**Entities:** `pb-aquilo-construction-robot-home` / `pb-aquilo-construction-robot-foreign`

**Purpose:** Construction operations that other families can't complete on Aquilo without constant charge interruptions. The deep battery means builds don't stall mid-blueprint. Works off-planet as a general-purpose bot for sparse-port outposts where energy-efficient range matters.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Speed | 0.045 | 0.045 | 0.06 |
| Max speed | 0.18 | 0.18 | — |
| Max energy | **9 MJ** | **6 MJ** | 1.5 MJ |
| Energy per move | **2.5 kJ** | 3 kJ | 5 kJ |
| Energy per tick | **0.5 kW** | 1 kW | 3 kW |
| Payload | 2 | 2 | 1 |
| Min charge threshold | 12% | 12% | 20% |

---

## Non-Home Variant

Foreign variant retains meaningful advantages over vanilla everywhere (4× battery, better efficiency, minor payload bonus). It is intentionally strong off-planet. Coexistence with other families depends on distinct niches, not stat hobbling:

- **Vulcanus** wins payload (3 vs 2) and dense-hub charging pairing.
- **Fulgora** wins speed and lightning immunity.
- **Gleba** wins sustained large-swarm endurance (lower energy_per_tick on home, competitive on foreign).
- **Aquilo foreign** wins for energy-sparse outposts and long-range work.
