# Milestone 0 — Baseline (v0.1.0)

**Goal:** Lock what’s shipped as the baseline. No code changes; use this as the reference so we don’t regress.

## Checklist — What’s in 0.1.0

- [ ] **Pre-vanilla:** Field Drone Depot + Field Drone; Nauvis-only (placement script); construction-only; depot cap by research (scripts/depot-cap.lua).
- [ ] **Planet families:** Vulcanus, Gleba, Fulgora, Aquilo — each with roboport (home/foreign), logistic bot (home/foreign), construction bot (home/foreign).
- [ ] **Recipes:** Home = `surface_conditions` min 1 on that planet’s flag; foreign = max 0. Same tech unlocks both; only the valid one shows per surface.
- [ ] **Items:** Each item has correct `place_result`; each entity has `minable` with correct `result` (field drone entity → `pb-field-drone` item).
- [ ] **Energy:** Roboports have `energy_source` with `buffer_capacity` and `input_flow_limit`; they consume power.
- [ ] **Visuals:** Tinted vanilla sprites/icons; foreign variants use dimmed palette.
- [ ] **Tech tree:** pb-field-drones → pb-field-depot-capacity-1..4; robotics → pb-vulcanus/gleba/fulgora/aquilo-robotics with correct science packs.

Mark these when you’ve verified them (e.g. in-game or via dump-data). No implementation work in this milestone.
