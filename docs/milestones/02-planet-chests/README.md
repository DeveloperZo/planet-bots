# Milestone 2 — Planet Chests

**Goal:** Add the three planet-specific chests from the design docs: Compost (Gleba), Arc Relay (Fulgora), Cryo Seal (Aquilo).

Work through the items below **in order**. Tick when done.

---

## 2.1 Compost Chest (Gleba)

- [ ] **2.1.1** Design: confirm behavior (e.g. converts spoilage to nutrients; see docs/planets/04-gleba.md). Document any recipe/crafting or passive conversion in this folder.
- [ ] **2.1.2** Prototypes: entity (container or custom), item, recipe. Recipe gated by Gleba (surface_conditions or tech). Add to item group/subgroup.
- [ ] **2.1.3** Logic: if passive conversion, implement in control.lua (e.g. on_tick or on_entity tick); if recipe-based, data only. Implement and test.
- [ ] **2.1.4** Locale: name and description for entity and item.

---

## 2.2 Arc Relay Chest (Fulgora)

- [ ] **2.2.1** Design: confirm behavior (low-frequency transfer, lightning-immune, consumes supercapacitors; see docs/planets/05-fulgora.md). Document in this folder.
- [ ] **2.2.2** Prototypes: entity (container, lightning immunity via high health or script), item, recipe. Recipe gated by Fulgora.
- [ ] **2.2.3** Logic: implement supercapacitor consumption (e.g. script on_nth_tick or periodic check) and transfer behavior. Implement and test.
- [ ] **2.2.4** Locale: name and description.

---

## 2.3 Cryo Seal Chest (Aquilo)

- [ ] **2.3.1** Design: confirm behavior (converts spoilables to cryosealed variants; see docs/planets/06-aquilo.md). Document in this folder.
- [ ] **2.3.2** Prototypes: entity, item, recipe. Recipe gated by Aquilo. If new item types (cryosealed), define and wire recipes.
- [ ] **2.3.3** Logic: conversion on insert or on_tick; implement and test.
- [ ] **2.3.4** Locale: name and description.

---

When all items are done, milestone 2 is complete. Then move to [03-content-and-ux](../03-content-and-ux/) or ship and iterate.
