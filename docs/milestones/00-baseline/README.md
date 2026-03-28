# Milestone 0 — Baseline (v0.1.0)

**Goal:** Lock what’s shipped as the baseline. No code changes; use this as the reference so we don’t regress.

## Checklist — What’s in 0.1.0

- [ ] **Pre-vanilla:** Field Drone Depot + Field Drone; Nauvis-only (placement script); construction-only; depot cap by research (scripts/depot-cap.lua).
- [ ] **Planet specialties:** Vulcanus construction bot, Fulgora logistic bot, Aquilo roboport; Field Drone tier on Nauvis; **Gleba specialty TBD**.
- [ ] **Recipes:** Home = `surface_conditions` min 1 on that planet’s flag; foreign = max 0. Same tech unlocks both; only the valid one shows per surface.
- [ ] **Items:** Each item has correct `place_result`; each entity has `minable` with correct `result` (field drone entity → `pb-field-drone` item).
- [ ] **Energy:** Roboports have `energy_source` with `buffer_capacity` and `input_flow_limit`; they consume power.
- [ ] **Visuals:** Tinted vanilla sprites/icons; foreign variants use dimmed palette.
- [ ] **Tech tree:** pb-field-drones → pb-field-depot-capacity-1..4; robotics → pb-vulcanus, pb-fulgora, pb-aquilo-robotics (Aquilo after Vulcanus + Fulgora); no pb-gleba-robotics.

Mark these when you’ve verified them (e.g. in-game or via dump-data). No implementation work in this milestone.
