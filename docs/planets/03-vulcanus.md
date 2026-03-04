# Vulcanus

## Identity

High-payload robotics for dense industrial builds. Fewer trips, heavier hauls. Designed for foundry islands and smelter arrays where raw throughput matters more than speed or range.

The design tension is explicit: payload = 3 is a real advantage for bulk construction and logistics, but the 3× energy_per_move and hard speed cap make these bots expensive and slow. They only make sense inside compact, well-charged networks. Players who try to use them like vanilla bots — spread out, long routes — will find them frustrating. That friction is correct.

**Primary lever:** `max_payload_size`. Everything else is a tradeoff against it.

---

## Roboport — Vulcanus Roboport

**Entities:** `pb-vulcanus-roboport-home` / `pb-vulcanus-roboport-foreign`

**Purpose:** Clear the charging queues that form in dense foundry hubs. High bot traffic in a small area creates charging congestion that vanilla roboports can't handle well — this port's 3× charging energy and 2× station count address that directly. Radius is unchanged; coverage is not the problem, throughput is.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Charging energy | 3,000 kW | 1,500 kW | 1,000 kW |
| Charging stations | 8 | 6 | 4 |
| Robot slots | 60 | 55 | 50 |
| Logistics radius | 25 | 25 | 25 |
| Construction radius | 55 | 55 | 55 |

**Recipe gate:** vanilla roboport + tungsten plate + calcite.

---

## Logistic Bot — Vulcanus Logistic Robot

**Entities:** `pb-vulcanus-logistic-robot-home` / `pb-vulcanus-logistic-robot-foreign`

**Purpose:** Bulk item movement inside compact networks — malls, foundries, smelting blocks. Three items per trip reduces the swarm size needed for high-volume delivery. Pairing with the Vulcanus Roboport's throughput is natural — the bots drain fast and need frequent short charges.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Speed | 0.03 | 0.03 | 0.05 |
| Max speed (hard cap) | 0.07 | 0.07 | — |
| Max energy | 3 MJ | 2 MJ | 1.5 MJ |
| Energy per move | 15 kJ | 15 kJ | 5 kJ |
| Energy per tick | 4.5 kW | 4.5 kW | 3 kW |
| Payload | **3** | **2** | 1 |

---

## Construction Bot — Vulcanus Construction Robot

**Entities:** `pb-vulcanus-construction-robot-home` / `pb-vulcanus-construction-robot-foreign`

**Purpose:** High-material builds — walls, smelter rows, foundry floors — completed in fewer bot-trips. Each bot carries 3 items to the ghost so a single pass places more before returning to recharge.

| Stat | Home | Foreign | Vanilla |
|---|---|---|---|
| Speed | 0.035 | 0.035 | 0.06 |
| Max speed (hard cap) | 0.07 | 0.07 | — |
| Max energy | 3 MJ | 2 MJ | 1.5 MJ |
| Energy per move | 15 kJ | 15 kJ | 5 kJ |
| Energy per tick | 4.5 kW | 4.5 kW | 3 kW |
| Payload | **3** | **2** | 1 |

---

## Non-Home Variant

Foreign variants retain the hard speed cap and high energy cost — the tradeoff travels with the bot. Payload is reduced to 2 (still above vanilla). Useful off Vulcanus for dense hub layouts anywhere, but slow and energy-hungry on spread-out bases.

**On Fulgora:** no electric resistance — not lightning-safe.  
**On Aquilo:** 15 kJ/move × 5× drain = 75 kJ effective per tile. Impractical.
