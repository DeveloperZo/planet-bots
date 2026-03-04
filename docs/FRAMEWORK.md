# PlanetBots — Framework Reference

**Sequenced work:** See [docs/roadmap.md](roadmap.md) and [docs/milestones/](milestones/) for milestones and work items one-by-one.

## Repo Layout

```
planetbots/
├── archive/                         — Factorio API docs (reference only, don't edit)
├── docs/
│   ├── FRAMEWORK.md                 — this file
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
        ├── data-final-fixes.lua     — patches vanilla planet surface_properties (home flags)
        ├── control.lua
        ├── scripts/
        │   ├── placement.lua        — Nauvis-only block + depot cap only
        │   └── depot-cap.lua        — Field Drone Depot per-force cap
        ├── prototypes/
        │   ├── surface-properties.lua   — four custom surface-property prototypes
        │   ├── items/
        │   │   ├── item-groups.lua      — pb-roboports, pb-bots subgroups
        │   │   ├── roboport-items.lua   — home + foreign item per planet roboport family
        │   │   └── bot-items.lua        — home + foreign item per bot type per family
        │   ├── entities/
        │   │   ├── field-drone-depot.lua
        │   │   ├── vulcanus-roboport.lua
        │   │   ├── gleba-roboport.lua
        │   │   ├── fulgora-roboport.lua
        │   │   └── aquilo-roboport.lua
        │   ├── bots/
        │   │   ├── field-drones.lua     — Nauvis pre-vanilla (construction only)
        │   │   ├── vulcanus-bots.lua
        │   │   ├── gleba-bots.lua
        │   │   ├── fulgora-bots.lua
        │   │   └── aquilo-bots.lua
        │   ├── recipes/
        │   │   ├── roboports.lua        — home + foreign recipe per family
        │   │   └── bots.lua             — home + foreign recipe per family
        │   └── technologies/
        │       └── planetbots-technologies.lua
        ├── locale/en/
        │   └── planetbots.cfg
        └── graphics/
            └── icons/
```

---

## Naming Convention

All entity, item, and recipe names follow a single consistent pattern:

```
pb-{planet}-{type}-{variant}
```

Examples:
```
pb-vulcanus-roboport-home
pb-vulcanus-roboport-foreign
pb-gleba-logistic-robot-home
pb-fulgora-construction-robot-foreign
pb-aquilo-roboport-home
```

**Field Drone exception** — pre-vanilla tier uses `pb-field-drone-*` and `pb-field-drone-depot` (no planet prefix; it predates planet travel).

Planet-to-prefix mapping:

| Planet | Prefix |
|---|---|
| Nauvis (pre-vanilla) | `field-drone` |
| Vulcanus | `vulcanus` |
| Gleba | `gleba` |
| Fulgora | `fulgora` |
| Aquilo | `aquilo` |

---

## Variant Architecture — surface_conditions

Variant selection (home vs. foreign) is handled entirely at the **data stage** via `RecipePrototype.surface_conditions`. No runtime swap script is involved.

### How it works

1. **Custom surface properties** (`prototypes/surface-properties.lua`) — one `surface-property` per planet, all defaulting to 0:
   ```lua
   { type = "surface-property", name = "pb-vulcanus", default_value = 0 }
   ```

2. **Patch vanilla planets** (`data-final-fixes.lua`) — sets each planet's flag to 1:
   ```lua
   data.raw["planet"]["vulcanus"].surface_properties["pb-vulcanus"] = 1
   ```

3. **Two recipes per family** — home requires the flag ≥ 1; foreign requires ≤ 0:
   ```lua
   surface_conditions = { { property = "pb-vulcanus", min = 1 } }  -- home: Vulcanus only
   surface_conditions = { { property = "pb-vulcanus", max = 0 } }  -- foreign: everywhere else
   ```

4. **Two items per family** — each item's `place_result` points to its matching entity. The engine spawns the correct entity directly; no runtime swap needed.

The engine enforces `surface_conditions` — a recipe simply doesn't appear in the crafting menu if the condition isn't met. Both recipes are unlocked by the same technology; players see only the one valid on their current surface.

### Field Drone exception

No `surface_conditions`. Single item and recipe. Off-Nauvis placement blocked at runtime by `scripts/placement.lua`.

### Cargo pod deliveries (TODO)

If bots or ports arrive via cargo pod, the delivered items will be whichever variant was crafted at the origin planet. No normalization currently occurs. Fix via `on_cargo_pod_delivered_cargo` — swap items in the spawned container based on destination surface.

---

## Variant Stats

### Roboports

All planet roboports use vanilla logistics_radius (25) and construction_radius (55). Radius is **not** a design lever — blueprint grids and mixed-family networks must remain valid.

| Family | Home kW / stations / slots | Foreign kW / stations / slots | Identity |
|---|---|---|---|
| Field Drone Depot | 500 / 2 / 20 | N/A | Construction-only, pre-vanilla |
| Vulcanus | 3,000 / 8 / 60 | 1,500 / 6 / 55 | Throughput — dense hub charging |
| Gleba | 1,500 / 6 / 80 | 1,200 / 5 / 65 | Fleet capacity — large swarm stability |
| Fulgora | 6,000 / 10 / 60 | 3,000 / 7 / 55 | Burst throughput + lightning immunity |
| Aquilo | 4,000 / 6 / 70 | 2,500 / 5 / 60 | Sustained charging under 5x drain |

### Bots — Logistic

Vanilla baseline: speed 0.05, max_energy 1.5 MJ, energy_per_move 5 kJ, energy_per_tick 3 kW, payload 1.

| Family | Speed | Max speed | Max energy | kJ/move | kW/tick | Payload | Notes |
|---|---|---|---|---|---|---|---|
| Vanilla | 0.05 | — | 1.5 MJ | 5 kJ | 3 kW | 1 | Baseline |
| Vulcanus home | 0.03 | 0.07 | 3 MJ | 15 kJ | 4.5 kW | 3 | Hard cap; 3x energy cost |
| Vulcanus foreign | 0.03 | 0.07 | 2 MJ | 15 kJ | 4.5 kW | 2 | |
| Gleba home | 0.05 | 0.15 | 2 MJ | 2.5 kJ | 0.8 kW | 1 | Idle drain 0.27x vanilla |
| Gleba foreign | 0.05 | 0.15 | 1.8 MJ | 3 kJ | 1.5 kW | 1 | |
| Fulgora home | 0.08 | 0.25 | 5 MJ | 4 kJ | 3 kW | 1 | Electric immune; fastest |
| Fulgora foreign | 0.08 | 0.25 | 3 MJ | 4 kJ | 3 kW | 1 | Immunity retained |
| Aquilo home | 0.04 | 0.18 | 9 MJ | 2.5 kJ | 0.5 kW | 2 | 6x battery; best efficiency |
| Aquilo foreign | 0.04 | 0.18 | 6 MJ | 3 kJ | 1 kW | 2 | Still 4x vanilla battery |

### Bots — Construction

Vanilla baseline: speed 0.06, max_energy 1.5 MJ, energy_per_move 5 kJ, energy_per_tick 3 kW, payload 1.

| Family | Speed | Max speed | Max energy | kJ/move | kW/tick | Payload | Notes |
|---|---|---|---|---|---|---|---|
| Vanilla | 0.06 | — | 1.5 MJ | 5 kJ | 3 kW | 1 | Baseline |
| Vulcanus home | 0.035 | 0.07 | 3 MJ | 15 kJ | 4.5 kW | 3 | Hard cap |
| Vulcanus foreign | 0.035 | 0.07 | 2 MJ | 15 kJ | 4.5 kW | 2 | |
| Gleba home | 0.055 | 0.15 | 2 MJ | 2.5 kJ | 0.8 kW | 1 | |
| Gleba foreign | 0.055 | 0.15 | 1.8 MJ | 3 kJ | 1.5 kW | 1 | |
| Fulgora home | 0.09 | 0.25 | 5 MJ | 4 kJ | 3 kW | 1 | Electric immune; fastest |
| Fulgora foreign | 0.09 | 0.25 | 3 MJ | 4 kJ | 3 kW | 1 | Immunity retained |
| Aquilo home | 0.045 | 0.18 | 9 MJ | 2.5 kJ | 0.5 kW | 2 | |
| Aquilo foreign | 0.045 | 0.18 | 6 MJ | 3 kJ | 1 kW | 2 | |

---

## Research Tree

```
automation => pb-field-drones
                └=> pb-field-depot-capacity-1 => -2 => -3 => -4

robotics => pb-vulcanus-robotics   (metallurgic science pack)
robotics => pb-gleba-robotics      (agricultural science pack)
robotics => pb-fulgora-robotics    (electromagnetic science pack)
robotics => pb-aquilo-robotics     (cryogenic science pack)
```

Each planet technology unlocks 6 recipes: roboport home + foreign, logistic home + foreign, construction home + foreign.

Technology names `pb-field-depot-capacity-1` through `pb-field-depot-capacity-4` are **referenced by name in scripts/depot-cap.lua**. Do not rename without updating the script.

---

## What Needs Scripting

| Feature | Where | Status |
|---|---|---|
| Variant selection (roboports + bots) | `surface_conditions` on recipes — data stage only | Done |
| Field Drone Depot off-Nauvis block | `scripts/placement.lua` | Done |
| Field Drone off-Nauvis block | `scripts/placement.lua` | Done |
| Field Drone depot cap enforcement | `scripts/depot-cap.lua` | Done |
| Depot cap research upgrades | `scripts/depot-cap.lua` | Done |
| Cargo pod variant normalization | `on_cargo_pod_delivered_cargo` | TODO |

---

## TODO Checklist

### Numbers (balance pass)
- [ ] All recipe ingredient quantities
- [ ] All technology research counts and time values

### Space Age ingredient name confirmation
- [ ] calcite (Vulcanus)
- [ ] bioflux (Gleba)
- [ ] supercapacitor, holmium-plate (Fulgora)
- [ ] lithium-plate, quantum-processor (Aquilo)
- [ ] Science pack names per planet
- [ ] Lightning damage type name (for Fulgora electric resistance)

### Implementation
- [ ] All sprite/animation tables (copy from vanilla, recolour per palette)
- [ ] All graphics icons and technology icons
- [ ] open_door / close_door effects on all roboports (copy from vanilla)
- [ ] Cargo pod variant normalization (`on_cargo_pod_delivered_cargo`)
- [ ] Compost Chest (Gleba)
- [ ] Arc Relay Chest (Fulgora)
- [ ] Cryo Seal Chest (Aquilo)
