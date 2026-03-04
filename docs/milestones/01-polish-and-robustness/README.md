# Milestone 1 — Polish & Robustness

**Goal:** Fix known gaps so the mod is robust and balanced: cargo pod behavior, Fulgora lightning, and a first balance pass.

Work through the items below **in order**. Tick when done.

---

## 1.1 Cargo pod variant normalization

- [ ] **1.1.1** Register `on_cargo_pod_delivered_cargo` in `control.lua`.
- [ ] **1.1.2** In handler: detect destination surface and its planet (via surface_properties or surface name).
- [ ] **1.1.3** For each PlanetBots item in the delivered container (roboports, logistic bots, construction bots): if item is “home” variant and destination is a different planet, replace with corresponding “foreign” variant (same family); if item is “foreign” and destination is that family’s planet, replace with “home” variant. Leave Field Drone/Depot unchanged (Nauvis-only).
- [ ] **1.1.4** Test: send home variant to another planet via cargo pod and confirm foreign variant in container; and the reverse.

---

## 1.2 Fulgora lightning hardening

- [ ] **1.2.1** Decide approach: (A) very high `max_health` on Fulgora roboport + bots so lightning strikes are negligible, or (B) `on_entity_damaged` script that cancels/reduces damage when source is lightning and entity is Fulgora. Document choice in this folder or in code comment.
- [ ] **1.2.2** Implement: either raise health in fulgora-roboport.lua and fulgora-bots.lua, or add script and wire in control.lua.
- [ ] **1.2.3** Update Fulgora planet doc and any in-game tooltip/locale so “lightning” behavior is accurate.

---

## 1.3 Balance pass

- [ ] **1.3.1** Recipe ingredients: set final amounts for all roboport and bot recipes (tungsten, calcite, bioflux, supercapacitor, holmium-plate, lithium-plate, quantum-processor). Remove or replace any `-- TODO: tune` with chosen values.
- [ ] **1.3.2** Technology: set unit count and time for each planet robotics tech and for pb-field-depot-capacity-1..4 so progression feels right (playtest or document targets).
- [ ] **1.3.3** Optional: one in-game pass on Vulcanus/Gleba/Fulgora/Aquilo to confirm no family is obviously “always best” or “never worth it.”

---

When all items are done, milestone 1 is complete. Then move to [02-planet-chests](../02-planet-chests/).
