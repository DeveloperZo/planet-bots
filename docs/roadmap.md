# PlanetBots Roadmap

## Current State (v0.1.0)

**Shipped and working:**

- **Pre-vanilla tier:** Field Drone Depot + Field Drone (Nauvis only, construction-only, depot cap via research).
- **Four planet families:** Vulcanus, Gleba, Fulgora, Aquilo — each with roboport (home/foreign), logistic bot (home/foreign), construction bot (home/foreign).
- **Variant system:** `surface_conditions` on recipes; home recipe only on that planet, foreign everywhere else. No runtime swap.
- **Runtime:** Off-Nauvis placement block for Field Drone/Depot; depot cap per force; minable/placeable with correct items.
- **Visuals:** Tinted vanilla sprites and icons (palettes; foreign = dimmer). No custom PNGs yet.
- **Energy:** Roboports use full `energy_source` (buffer + input limit) and consume power; bots have zero collision box and correct flags.

**Known gaps:**

- Cargo pod deliveries don't normalize variant (you can receive home variant items on another planet).
- Fulgora "lightning immunity" is electric resistance only (does not affect actual lightning damage).
- Recipe/tech numbers are placeholder; balance pass not done.
- Planet chests (Compost, Arc Relay, Cryo Seal) not implemented.

---

## Competitive Landscape

### Downloads and overlap

| Mod | Downloads | What they do | Overlap with us | Conflict risk |
|-----|-----------|-------------|-----------------|---------------|
| **Robot Attrition** (Earendel) | **526K** | Logistic bots occasionally crash under heavy congestion. Configurable rate. | None — no new entities, no planet gating | **None. Synergistic.** Attrition penalizes wrong-tool-for-job; PlanetBots rewards picking the right family per planet. Players will run both. |
| **Nanobots 2.0** | **37K** | Personal nanobot gun that auto-builds blueprint ghosts near you, no roboport needed. | Slight — both add early construction help | Low. Nanobots is personal/gun-based; we are roboport-gated. Different install moments. Likely used together. |
| **Extended Vanilla: Modular Logistics** | **8.3K** | Adds logistic booster roboport (unlocked on Fulgora: 96×96 radius, 12 charge stations, configurable via settings). Plans 2 additional robot/roboport tiers. | Moderate — also adds a Fulgora-unlocked roboport. **Planning planet-gated tiers.** | **Closest future threat.** Their booster is radius-focused, ours is identity-stat–focused. Different philosophy. But if they ship planet-gated bot tiers before us, we share the install slot. |
| **Robot World (Space Age)** | **2.4K** | Global sliders for robot speed, battery, radius, charging rate, carry size, health. | High surface overlap — both change bot stats | Philosophically opposite. They give universal sliders; we give fixed planet identities. Most players pick one. Both installed = our stats get overridden by their multipliers (potential conflict). |
| **Rework Combat Bots** | Small | Different combat bot types unlocked per planet (Vulcanus = defender, Gleba = distractor, Fulgora = destroyer with tesla gun). | Planet-gated robots, same design pattern | **None for logistics/construction.** Actually validates the planet-gating pattern as a design choice. |
| **Bob's Logistics** | **307K** | Strict tiers of robots, roboports, belts, inserters, pipes. | Planet-gating is different; their tiers are purely linear upgrades | Low — their audience is overhaul players. We're vanilla+. Compatible if both installed; their tier bots coexist with ours. |

### The direct gap

**There is no mod that does planet-specific logistic and construction robot families with fixed mechanical tradeoffs and home/foreign variants.** Rework Combat Bots validates the pattern for combat bots. Extended Vanilla is the only future threat, and they haven't shipped robot tiers yet.

---

## Code We Can Borrow

### 1. Fulgora lightning hardening → Robot Attrition's `on_entity_damaged` pattern (Milestone 1.2)

Robot Attrition (526K users, by Earendel) registers `on_entity_damaged` to detect heavy congestion, then kills a logistic bot. We need the **same event** to intercept raw lightning damage on Fulgora bots and cancel it. The community issue thread confirms this is the mechanism.

Pattern to use directly in `scripts/fulgora-hardening.lua`:

```lua
script.on_event(defines.events.on_entity_damaged, function(event)
  local entity = event.entity
  local name = entity.name
  -- only handle our Fulgora bots and roboports
  if FULGORA_ENTITIES[name] then
    -- lightning has no damage_type (raw double); cancel by healing back
    entity.health = math.min(entity.health + event.final_damage_amount, entity.max_health)
  end
end)
```

The key insight from the Attrition community: filter the entity name (not damage type, because lightning has none), then restore health. This is cheap — fires on any damage, but the table lookup is O(1).

### 2. Cargo pod normalization → same event pattern as `on_built_entity` (Milestone 1.1)

Nanobots 2.0 (MIT, source: https://github.com/jackiepmueller/Nanobots2) uses `on_built_entity` + surface check → if invalid, destroy entity and give item back. Our `scripts/placement.lua` already uses this pattern for Field Drone/Depot off Nauvis.

For cargo pod normalization the event is `on_cargo_pod_delivered_cargo`. The pattern is:
```lua
script.on_event(defines.events.on_cargo_pod_delivered_cargo, function(event)
  -- event.cargo_pod is the pod entity; find the attached inventory
  -- swap home<->foreign items based on event.cargo_pod.surface
end)
```

### 3. Recipe procedural generation → Extended Vanilla's loop pattern (already done)

EV Logistics generates its recipes in a loop over a family table (same as our `prototypes/recipes/bots.lua`). Their `settings.lua` startup settings for ingredient amounts and roboport stats are the reference for our **Milestone 3.1 mod settings** work.

### 4. Placement blocking → Nanobots 2.0 (MIT)

We already implement this for Field Drone. Nanobots is the reference if we need to extend placement blocking to planet chests or other entities.

---

## Unique Position

1. **Planet as identity:** Vulcanus = payload/throughput, Gleba = endurance/fleet, Fulgora = speed + storm survival, Aquilo = battery/efficiency under 5× drain. No planet is "best at everything."
2. **Home vs foreign:** Same family, two variants. Only the correct recipe shows on each surface — no UI clutter.
3. **Compatible with vanilla radii:** All roboports keep logistics_radius 25 / construction_radius 55 so blueprints and mixed networks work.
4. **Pre-vanilla tier:** Field Drone is deliberately weak and Nauvis-only — doesn't gut the "unlock real robotics" moment.
5. **Synergistic with Robot Attrition:** The biggest robot mod in the scene adds cost for bad network design. We add value for good planet-aware design. Together they make robot strategy more interesting.

---

## Milestones

Work is split into **milestones**. Each milestone has a folder under `docs/milestones/` with a README that lists **work items one by one**. We implement items in order within each milestone.

| Milestone | Folder | Goal |
|-----------|--------|------|
| **0 — Baseline** | [00-baseline](./milestones/00-baseline/) | Document what's shipped; no code work. |
| **1 — Polish & robustness** | [01-polish-and-robustness](./milestones/01-polish-and-robustness/) | Cargo pod normalization, Fulgora lightning hardening, balance pass. |
| **2 — Planet chests** | [02-planet-chests](./milestones/02-planet-chests/) | Compost Chest (Gleba), Arc Relay Chest (Fulgora), Cryo Seal Chest (Aquilo). |
| **3 — Content & UX** | [03-content-and-ux](./milestones/03-content-and-ux/) | Optional: mod settings, clearer tooltips, custom graphics. |
| **4 — Future** | [04-future](./milestones/04-future/) | Backlog: quality support, extra mechanics, etc. |

---

## How to Use This Roadmap

1. **Pick a milestone** (start with 1).
2. **Open** `docs/milestones/<milestone>/README.md` and work through the listed items in order.
3. **Tick off** items in that README as they're done (or move sub-tasks into the same folder if needed).
4. **Revisit this roadmap** when a milestone is complete or when priorities change.
