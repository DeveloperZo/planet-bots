# Milestone 2 — Gleba Compost Chest

**Goal:** Implement the Compost Chest — Gleba's specialty item and the mod's only spoilage
management structure.

The Arc Relay Chest (Fulgora) and Cryo Seal Chest (Aquilo) from the original design are
**cut**. Fulgora's specialty is the logistic bot; Aquilo's specialty is the roboport. Neither
planet needs a chest.

Full behavior specification: [`compost-chest-design.md`](./compost-chest-design.md)

Work through the items below in order. Tick when done.

---

## 2.1 Compost Chest

- [x] **2.1.1** Design: nutrient fuel-slot mechanic — fueled = 15% spoil rate, unfueled = 200%.
  See [`compost-chest-design.md`](./compost-chest-design.md).
- [ ] **2.1.2** Prototype: `container` entity (`inventory_type = "with_filters_and_bar"`,
  20 slots), item, recipe. No `surface_conditions`. Recipe gated by `pb-gleba-robotics` tech.
- [ ] **2.1.3** Script: `scripts/compost-chest.lua` — `on_built_entity` registers chest + locks
  slot 1 to `nutrient`; `on_nth_tick(60)` runs fuel consumption and `spoil_tick` push/retract.
  Register chest removal (mined, died, robot mined) to clean up `storage`.
- [ ] **2.1.4** Locale: `pb-gleba-compost-chest` name and description. Include fuel mechanic
  note in description.
- [ ] **2.1.5** Wire into `control.lua`: require `scripts/compost-chest.lua`.

---

When all items are done, milestone 2 is complete. Move to
[03-content-and-ux](../03-content-and-ux/) or ship and iterate.
