# Interplanetary Bots — Framework Reference

**Sequenced work:** See [docs/roadmap.md](roadmap.md) and [docs/milestones/](milestones/) for milestones and work items one-by-one.

## Design Philosophy

Each Space Age planet with a specialty contributes **one** best-in-mod item: construction bot,
logistic bot, or roboport. Items are craftable anywhere; the gate is the supply chain, not
placement. **Gleba** has no Interplanetary Bots specialty yet (undecided; the mod stays on the bot / roboport axis).

| Planet   | Specialty                                 | Key gate materials               |
| -------- | ----------------------------------------- | -------------------------------- |
| Vulcanus | Construction bot (payload 3)              | tungsten-plate, calcite          |
| Fulgora  | Logistic bot (fastest + lightning-immune) | supercapacitor, holmium-plate    |
| Aquilo   | Roboport (4× charging, 2× stations)       | lithium-plate, quantum-processor |
| Gleba    | *(undecided — see `docs/planets/04-gleba.md`)* | —                           |


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
    └── interplanetary-bots_0.1.0/
        ├── info.json
        ├── data.lua
        ├── data-final-fixes.lua
        ├── control.lua
        ├── settings.lua
        ├── scripts/
        │   ├── placement.lua          — Nauvis-only block + shared depot/chest cap
        │   ├── depot-cap.lua          — per-force cap (depots + chests)
        │   ├── field-drone-builder.lua — scripted ghost builder (on_nth_tick)
        │   └── fulgora-hardening.lua  — electric damage immunity
        ├── prototypes/
        │   ├── shared/
        │   │   ├── palettes.lua       — tint colours
        │   │   └── sprite-util.lua    — tinted copy / icon helpers
        │   ├── items/
        │   │   ├── item-groups.lua
        │   │   ├── roboport-items.lua — depot, field chest, Aquilo roboport
        │   │   └── bot-items.lua      — Vulcanus construction, Fulgora logistic
        │   ├── entities/
        │   │   ├── field-drone-depot.lua
        │   │   ├── field-chest.lua
        │   │   ├── field-drone-projectile.lua
        │   │   ├── aquilo-roboport.lua
        │   │   ├── vulcanus-construction-bot.lua (in bots/)
        │   │   └── fulgora-logistic-bot.lua (in bots/)
        │   ├── recipes/
        │   │   ├── roboports.lua      — depot, field chest, Aquilo roboport
        │   │   └── bots.lua           — Vulcanus construction, Fulgora logistic
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


---

## Planet environment levers (specialty-scoped)

**Design rule:** Planet identity — “what this world does to your automation” — is expressed on **that
planet’s specialty prototype only** (`pb-*` construction bot, logistic bot, roboport, or field-drone
tier). When we talk about a **planet multiplier** or environmental lever in docs or
balance, we mean **fields on that one entity** (or its paired script), not a hidden blanket modifier
on vanilla robots.

**Vanilla engine caveat (Aquilo):** Space Age applies a **global** flying-robot energy penalty on the
Aquilo surface to **all** logistic and construction robots, including vanilla. Interplanetary Bots does not
override that. Our scoped lever is **`pb-aquilo-roboport`**: higher `charging_energy`, more
`charging_station_count`, and larger `robot_slots_count` so networks can **compensate** for the
global drain. We do **not** document an extra “Aquilo tax” that applies only to e.g.
`pb-fulgora-logistic-robot` — that would stack on top of the engine rule and confuse the model.

**Pairing summary**

| Planet              | Specialty prototype              | Type     | Where planet identity lives |
| ------------------- | -------------------------------- | -------- | --------------------------- |
| Nauvis (pre-vanilla)| `pb-field-drone-depot` + `pb-field-chest` | Scripted builder | Depot (roboport for radius) + chest (container) + `field-drone-builder.lua` |
| Vulcanus          | `pb-vulcanus-construction-robot` | Bot      | Construction-robot fields   |
| Fulgora           | `pb-fulgora-logistic-robot`      | Bot      | Logistic-robot fields + `fulgora-hardening.lua` |
| Gleba             | —                                | —        | *(undecided — see `docs/planets/04-gleba.md`)*  |
| Aquilo            | `pb-aquilo-roboport`             | Roboport | Roboport fields (offsets vanilla global bot drain on Aquilo) |

---

### Bot levers (flying / logistics — same field names)

Use these on **`logistic-robot`** or **`construction-robot`** specialty entities. Optional fields
omitted unless the design needs them.

**Motion and energy**

- `speed`, `max_speed`
- `max_energy`
- `energy_per_move`, `energy_per_tick`
- `min_to_charge`, `max_to_charge`
- `speed_multiplier_when_out_of_energy`

**Cargo (logistic bots)**

- `max_payload_size`, `max_payload_size_after_bonus`, `draw_cargo`

**Other bot-relevant**

- `destroy_action`, `charging_sound`
- `max_health`, `resistances` (and other `EntityWithHealthPrototype` fields as needed)

---

### Roboport levers (when the specialty is a roboport)

Use on **`pb-aquilo-roboport`** (or field depot): `charging_energy`, `charging_station_count`,
`robot_slots_count`, `material_slots_count`, `energy_source`, `energy_usage`, `logistics_radius`,
`construction_radius`, resistances, slot/animation fields as needed. **Design rule:** keep
logistics/construction radius aligned with vanilla unless a milestone explicitly changes it.

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

Vanilla baseline: speed 0.05, max_energy 1.5 MJ, energy_per_move 5 kJ, energy_per_tick 3 kW, payload 1. Charge: min_to_charge 0.2, max_to_charge 0.95, speed_multiplier_when_out_of_energy 0.25.


| Stat                      | pb-fulgora | Vanilla | Notes                                      |
| ------------------------- | ---------- | ------- | ------------------------------------------ |
| **Speed**                 | **0.08**   | 0.05    | **1.6× — primary lever**                   |
| Max speed                 | 0.25       | —       | Fastest in mod                             |
| Max energy                | 5 MJ       | 1.5 MJ  | 3.3× — blackout survival                   |
| Energy per move           | 3 kJ       | 5 kJ    | Long-haul efficient                        |
| Energy per tick           | 6 kW       | 3 kW    | Higher hover / queue drain                 |
| Payload                   | 1          | 1       | Courier base                               |
| Max payload w/ research | **3**      | **4**   | `max_payload_size_after_bonus` courier cap |
| Electric resistance       | 100%       | None    | Lightning-immune                           |
| Min charge threshold      | 9%         | 20%     | Deeper discharge before seeking charge     |
| Max charge (park)         | 78%        | 95%     | Partial top-off — snappier roboport churn  |
| Speed mult. when empty    | 0.2        | 0.25    | Harsher limp-home                          |


### Roboport — pb-aquilo-roboport

Vanilla baseline: charging_energy 1,000 kW, charging_stations 4, robot_slots 50.


| Stat                | pb-aquilo    | Vanilla  | Notes                  |
| ------------------- | ------------ | -------- | ---------------------- |
| Charging energy     | **4,000 kW** | 1,000 kW | **4× — primary lever** |
| Charging stations   | **8**        | 4        | 2× stations            |
| **Robot slots**     | **70**       | 50       | 1.4×                   |
| Logistics radius    | 25           | 25       | Unchanged              |
| Construction radius | 55           | 55       | Unchanged              |

---

## Research Tree

```
automation => pb-field-drones (depot + chest)
               └=> pb-field-depot-capacity-1 => -2 => -3 => -4  (shared cap)

robotics => pb-vulcanus-robotics   (metallurgic science pack)       => pb-vulcanus-construction-robot
robotics => pb-fulgora-robotics    (electromagnetic science pack)   => pb-fulgora-logistic-robot
robotics => pb-aquilo-robotics     (cryogenic science pack)         => pb-aquilo-roboport
             (prereq: Vulcanus + Fulgora robotics; Gleba TBD)
```

Each planet technology unlocks **one recipe** for its specialty item (Gleba: TBD).

Technology names `pb-field-depot-capacity-1` through `pb-field-depot-capacity-4` are
**referenced by name in scripts/depot-cap.lua**. Do not rename without updating the script.

---

## What Needs Scripting


| Feature                            | Where                          | Status                                  |
| ---------------------------------- | ------------------------------ | --------------------------------------- |
| Field Drone Depot off-Nauvis block | `scripts/placement.lua`           | Done                                    |
| Field Chest off-Nauvis block       | `scripts/placement.lua`           | Done                                    |
| Shared depot/chest cap enforcement | `scripts/depot-cap.lua`           | Done                                    |
| Cap research upgrades              | `scripts/depot-cap.lua`           | Done                                    |
| Scripted ghost builder             | `scripts/field-drone-builder.lua` | Done                                    |
| Depot entity tracking              | `control.lua` + builder script    | Done                                    |
| Cargo pod variant normalization    | `on_cargo_pod_delivered_cargo`    | TODO (lower priority — no variants now) |


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
- Update `prototypes/items/` — remove home/foreign items, add one item per specialty
- Update `prototypes/recipes/` — remove surface_conditions, one recipe per specialty
- Update `prototypes/technologies/` — each tech unlocks one recipe
- Update `locale/en/planetbots.cfg` — remove foreign/home entries, add specialty entries
- Update `control.lua` / `scripts/` — remove any home/foreign swap logic

---

## TODO Checklist

### Numbers (balance pass)

- All recipe ingredient quantities — first-pass values in planet docs, need in-game test
- All technology research counts and time values

### Space Age ingredient name confirmation

- tungsten-plate (Vulcanus)
- calcite (Vulcanus)
- supercapacitor, holmium-plate (Fulgora)
- lithium-plate, quantum-processor (Aquilo)
- ice-platform (Aquilo) — confirm item name
- Science pack names per planet

