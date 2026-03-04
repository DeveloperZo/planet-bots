# Vulcanus — Foundry Bots Spec

## Identity

**Best in class at:** max_payload (3 base — always leads payload research)
**Pays for it with:** Hard speed cap (0.07), high energy_per_move (3×), small logistics area per port (forced hub density via charging bottleneck, not radius)

**Emotional beat:** Swarm shrinks. Throughput holds. Charging queue appears on vanilla ports. Foundry Roboport resolves it. Dense hub feels complete.

---

## Foundry Roboport

| Property | Home (Vulcanus) | Foreign (elsewhere) | Vanilla ref |
|---|---|---|---|
| logistics_radius | 25 | 25 | 25 |
| construction_radius | 55 | 55 | 55 |
| charging_energy | TODO kW | TODO kW | 1,000 kW |
| charging_station_count | TODO | TODO | 4 |
| robot_slots_count | TODO | TODO | 50 |
| material_slots_count | 7 | 7 | 7 |

**Planet repair pack:** Foundry Repair Pack (vanilla repair pack + tungsten-plate)
**Recipe gate:** tungsten-plate (Vulcanus production chain)

---

## Foundry Logistic Robot

| Property | Home | Foreign | Vanilla ref |
|---|---|---|---|
| speed | 0.03 t/t | TODO | 0.05 t/t |
| **max_speed** | **0.07 (hard cap)** | **0.07 (same cap)** | unlimited |
| max_energy | 3 MJ | TODO | 1.5 MJ |
| **energy_per_move** | **15 kJ/tile** | **15 kJ/tile** | 5 kJ/tile |
| energy_per_tick | 4.5 kW | TODO | 3 kW |
| **max_payload_size** | **3** | **TODO** | 1 |
| min_to_charge | 0.2 | 0.2 | 0.2 |
| resistances | none | none | none |

**Note:** energy_per_move stays the same on foreign variant — the cost of using Foundry bots is the point. Foreign variant reduces payload and/or battery, not the fundamental energy burn.

---

## Foundry Construction Robot

| Property | Home | Foreign | Vanilla ref |
|---|---|---|---|
| speed | 0.035 t/t | TODO | 0.06 t/t |
| max_speed | 0.07 (hard cap) | 0.07 | unlimited |
| max_energy | 3 MJ | TODO | 1.5 MJ |
| energy_per_move | 15 kJ/tile | 15 kJ/tile | 5 kJ/tile |
| energy_per_tick | 4.5 kW | TODO | 3 kW |
| max_payload_size | 3 | TODO | 1 |
| min_to_charge | 0.2 | 0.2 | 0.2 |

---

## Recipe Gate

**Foundry Roboport:** tungsten-plate + TODO
**Foundry Logistic Robot:** tungsten-plate + TODO
**Foundry Construction Robot:** tungsten-plate + TODO
**Foundry Repair Pack:** vanilla repair pack (1) + tungsten-plate (TODO qty)

All recipes unlocked by `pb-vulcanus-robotics` technology, requires Vulcanus science pack.

---

## Cross-Planet Notes

**Best on:** Vulcanus dense hubs — payload triples, charging throughput matches
**Hurts on:** Gleba (15 kJ/tile × long farm trips = constant abort-to-charge), Aquilo (5× drain × 15 kJ/tile = 75 kJ effective — barely leaves the port)

---

## Transition Paths

### Bot-first (recommended experience)
1. Vanilla bot + Vanilla port → payload triples, charging bottleneck emerges
2. Foundry bot + Foundry port → bottleneck clears, dense hub complete

### Port-first
1. Vanilla bot + Foundry port → faster charging, must place ports closer (smaller effective coverage from charging investment, not radius)
2. Foundry bot + Foundry port → same endpoint, layout lesson learned first

---

## TODO Checklist

- [ ] Finalise home charging_energy
- [ ] Finalise home charging_station_count
- [ ] Finalise home robot_slots_count
- [ ] Decide foreign stat multipliers (target: meaningfully less than home, clearly better than vanilla)
- [ ] Confirm Space Age item name for tungsten-plate in recipes
- [ ] Set recipe quantities (repair pack, roboport, bots)
- [ ] Set technology prerequisites and science pack type
- [ ] Create graphics (icon recolour from vanilla — orange/amber palette)
