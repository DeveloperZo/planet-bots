# PlanetBots — Framework Reference

**Sequenced work:** See [docs/roadmap.md](roadmap.md) and [docs/milestones/](milestones/) for milestones and work items one-by-one.

## Design Philosophy

Each planet produces **one specialty item** — the best of its class in the mod. Items are
craftable anywhere; the gate is the supply chain, not placement. Players who develop all four
planets get the best-in-slot construction bot, logistic bot, roboport, and chest. Players who
skip a planet use vanilla equivalents instead.


| Planet   | Specialty                                        | Key gate materials               |
| -------- | ------------------------------------------------ | -------------------------------- |
| Vulcanus | Construction bot (payload 3)                     | tungsten-plate, calcite          |
| Fulgora  | Logistic bot (fastest + lightning-immune)        | supercapacitor, holmium-plate    |
| Aquilo   | Roboport (4× charging, 2× stations)              | lithium-plate, quantum-processor |
| Gleba    | Compost chest (nutrient-fueled spoilage control) | bioflux                          |


No `surface_conditions` on any specialty recipe. No home/foreign variants. One item per
specialty, universally usable.

---

## Repo Layout

```
planetbots/
├── archive/                         — Factorio API docs (reference only, don't edit)
├── docs/
│   ├── FRAMEWORK.md                 — this file
│   ├── roadmap.md
│   ├── milestones/
│   │   ├── 00-baseline/
│   │   ├── 01-polish-and-robustness/
│   │   ├── 02-planet-chests/
│   │   ├── 03-content-and-ux/
│   │   └── 04-future/
│   └── planets/
│       ├── 01-nauvis-pre-vanilla.md
│       ├── 02-nauvis-vanilla.md
│       ├── 03-vulcanus.md
│       ├── 04-gleba.md
│       ├── 05-fulgora.md
│       └── 06-aquilo.md
└── mod/
    └── planetbots_0.1.0/
        ├── info.json
        ├── data.lua
        ├── data-final-fixes.lua
        ├── control.lua
        ├── scripts/
        │   ├── placement.lua        — Field Drone Depot: Nauvis-only block + depot cap
        │   ├── depot-cap.lua        — Field Drone Depot per-force cap
        │   └── compost-chest.lua    — Compost chest on_nth_tick spoilage logic (TODO)
        ├── prototypes/
        │   ├── shared/
        │   │   └── palettes.lua     — tint colours (kept for Field Drone Depot)
        │   ├── items/
        │   │   ├── item-groups.lua
        │   │   ├── specialty-items.lua   — one item per specialty
        │   │   └── field-drone-items.lua
        │   ├── entities/
        │   │   ├── field-drone-depot.lua
        │   │   ├── vulcanus-construction-bot.lua
        │   │   ├── fulgora-logistic-bot.lua
        │   │   ├── aquilo-roboport.lua
        │   │   └── gleba-compost-chest.lua   (TODO)
        │   ├── recipes/
        │   │   ├── specialty-recipes.lua
        │   │   └── field-drone-recipes.lua
        │   └── technologies/
        │       └── planetbots-technologies.lua
        ├── locale/en/
        │   └── planetbots.cfg
        └── graphics/
            └── icons/
```

> **Note:** The repo currently reflects the v0.1.0 baseline (full families, home/foreign split).
> The file layout above shows the **target state** after the redesign refactor.

---

## Naming Convention

```
pb-{planet}-{type}
```

Examples:

```
pb-vulcanus-construction-robot
pb-fulgora-logistic-robot
pb-aquilo-roboport
pb-gleba-compost-chest
```

**Field Drone exception** — pre-vanilla tier uses `pb-field-drone` and `pb-field-drone-depot`
(no planet prefix; it predates planet travel).


| Planet               | Prefix        |
| -------------------- | ------------- |
| Nauvis (pre-vanilla) | `field-drone` |
| Vulcanus             | `vulcanus`    |
| Fulgora              | `fulgora`     |
| Aquilo               | `aquilo`      |
| Gleba                | `gleba`       |


---

## Recipe Architecture

No surface conditions. No home/foreign variants. One recipe per specialty.

Each specialty recipe requires:

1. The vanilla equivalent as a base ingredient
2. 2–3 planet-specific materials (the supply chain gate)
3. Standard intermediate ingredients


| Specialty item                 | Key planet ingredients           |
| ------------------------------ | -------------------------------- |
| pb-vulcanus-construction-robot | tungsten-plate, calcite          |
| pb-fulgora-logistic-robot      | supercapacitor, holmium-plate    |
| pb-aquilo-roboport             | lithium-plate, quantum-processor |
| pb-gleba-compost-chest         | bioflux                          |


---

## Specialty Stats

### Construction Bot — pb-vulcanus-construction-robot

Vanilla baseline: speed 0.06, max_energy 1.5 MJ, energy_per_move 5 kJ, energy_per_tick 3 kW, payload 1.


| Stat            | pb-vulcanus | Vanilla | Notes                       |
| --------------- | ----------- | ------- | --------------------------- |
| Speed           | 0.05        | 0.06    | Slight tradeoff for payload |
| Max speed       | 0.10        | —       | Hard cap                    |
| Max energy      | 3 MJ        | 1.5 MJ  | 2× battery                  |
| Energy per move | 8 kJ        | 5 kJ    | 1.6× cost                   |
| Energy per tick | 3 kW        | 3 kW    | Vanilla idle                |
| **Payload**     | **3**       | **1**   | **Primary lever**           |


### Logistic Bot — pb-fulgora-logistic-robot

Vanilla baseline: speed 0.05, max_energy 1.5 MJ, energy_per_move 5 kJ, energy_per_tick 3 kW, payload 1.


| Stat                 | pb-fulgora | Vanilla | Notes                    |
| -------------------- | ---------- | ------- | ------------------------ |
| **Speed**            | **0.08**   | 0.05    | **1.6× — primary lever** |
| Max speed            | 0.25       | —       | Fastest in mod           |
| Max energy           | 5 MJ       | 1.5 MJ  | 3.3× — blackout survival |
| Energy per move      | 4 kJ       | 5 kJ    | More efficient           |
| Energy per tick      | 3 kW       | 3 kW    | Vanilla idle             |
| Payload              | 1          | 1       | Courier, not hauler      |
| Electric resistance  | 100%       | None    | Lightning-immune         |
| Min charge threshold | 12%        | 20%     | Returns to charge later  |


### Roboport — pb-aquilo-roboport

Vanilla baseline: charging_energy 1,000 kW, charging_stations 4, robot_slots 50.


| Stat                | pb-aquilo    | Vanilla  | Notes                  |
| ------------------- | ------------ | -------- | ---------------------- |
| Charging energy     | **4,000 kW** | 1,000 kW | **4× — primary lever** |
| Charging stations   | **8**        | 4        | 2× stations            |
| **Robot slots**     | **70**       | 50       | 1.4×                   |
| Logistics radius    | 25           | 25       | Unchanged              |
| Construction radius | 55           | 55       | Unchanged              |


### Compost Chest — pb-gleba-compost-chest

See full specification: `[docs/milestones/02-planet-chests/compost-chest-design.md](milestones/02-planet-chests/compost-chest-design.md)`


| State    | Spoil rate     | Trigger               |
| -------- | -------------- | --------------------- |
| Fueled   | 15% of normal  | Nutrient in fuel slot |
| Unfueled | 200% of normal | Fuel slot empty       |


Fuel consumption: 1 nutrient per minute.

---

## Research Tree

```
automation => pb-field-drones
               └=> pb-field-depot-capacity-1 => -2 => -3 => -4

robotics => pb-vulcanus-robotics   (metallurgic science pack)   => pb-vulcanus-construction-robot
robotics => pb-gleba-robotics      (agricultural science pack)  => pb-gleba-compost-chest
robotics => pb-fulgora-robotics    (electromagnetic science pack) => pb-fulgora-logistic-robot
robotics => pb-aquilo-robotics     (cryogenic science pack)     => pb-aquilo-roboport
```

Each planet technology unlocks **one recipe**: its specialty item.

Technology names `pb-field-depot-capacity-1` through `pb-field-depot-capacity-4` are
**referenced by name in scripts/depot-cap.lua**. Do not rename without updating the script.

---

## What Needs Scripting


| Feature                            | Where                          | Status                                  |
| ---------------------------------- | ------------------------------ | --------------------------------------- |
| Field Drone Depot off-Nauvis block | `scripts/placement.lua`        | Done                                    |
| Field Drone off-Nauvis block       | `scripts/placement.lua`        | Done                                    |
| Field Drone depot cap enforcement  | `scripts/depot-cap.lua`        | Done                                    |
| Depot cap research upgrades        | `scripts/depot-cap.lua`        | Done                                    |
| Compost chest spoilage logic       | `scripts/compost-chest.lua`    | TODO                                    |
| Cargo pod variant normalization    | `on_cargo_pod_delivered_cargo` | TODO (lower priority — no variants now) |


---

## Refactor TODO (v0.1.0 → redesign)

The current codebase has full families (roboport + both bots) per planet with home/foreign
variants. The target design is one specialty per planet, no variants. Before the next game-load
test, remove or replace:

- Delete `prototypes/entities/vulcanus-roboport.lua` and `gleba-roboport.lua` and `fulgora-roboport.lua`
- Delete `prototypes/bots/vulcanus-bots.lua` (logistic + construction → keep only construction)
- Delete `prototypes/bots/gleba-bots.lua` and `fulgora-bots.lua` (both types removed) and `aquilo-bots.lua`
- Delete `prototypes/entities/aquilo-roboport.lua` → replace with specialty roboport
- Rewrite `prototypes/entities/vulcanus-construction-bot.lua` (new file, single variant)
- Rewrite `prototypes/entities/fulgora-logistic-bot.lua` (new file, single variant)
- Rewrite `prototypes/entities/aquilo-roboport.lua` (single variant)
- Rewrite `prototypes/entities/gleba-compost-chest.lua` (new)
- Update `prototypes/items/` — remove home/foreign items, add one item per specialty
- Update `prototypes/recipes/` — remove surface_conditions, one recipe per specialty
- Update `prototypes/technologies/` — each tech unlocks one recipe
- Update `locale/en/planetbots.cfg` — remove foreign/home entries, add specialty entries
- Update `control.lua` / `scripts/` — remove any home/foreign swap logic, add compost chest

---

## TODO Checklist

### Numbers (balance pass)

- All recipe ingredient quantities — first-pass values in planet docs, need in-game test
- All technology research counts and time values

### Space Age ingredient name confirmation

- tungsten-plate (Vulcanus)
- calcite (Vulcanus)
- bioflux (Gleba)
- supercapacitor, holmium-plate (Fulgora)
- lithium-plate, quantum-processor (Aquilo)
- ice-platform (Aquilo) — confirm item name
- Science pack names per planet

