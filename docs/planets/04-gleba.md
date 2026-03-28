# Gleba

## Interplanetary Bots scope

Gleba does **not** have a specialty item yet. The current progression is **construction bot
(Vulcanus) → logistic bot (Fulgora) → roboport (Aquilo)**; Gleba's slot is **open and undecided**.

Gleba remains important for **vanilla** Space Age (agricultural science, bio routes, spoilage).
Players use vanilla logistics chests and bots like everywhere else — for now.

---

## Status: open / undecided

The design space for Gleba has not been committed. It is neither closed nor promised — it will be
filled if and when a compelling mechanic is identified that meets these criteria:

1. Stays on the **bot / roboport axis** (consistent with the rest of the mod).
2. Offers **genuinely distinct gameplay**, not just a numeric reskin.
3. Ideally leverages **prototype-only or lightweight scripting** — not fragile `on_nth_tick`
   inventory surgery.

### Candidate under consideration

**Regenerating frontier construction bot** — a Gleba construction bot using `healing_per_tick`
(unused on vanilla bots) and broad acid/explosion resistances. Niche: hostile-environment
construction where vanilla bots die to biters/spitters. Differentiated from Vulcanus construction
bot (throughput via payload + speed) by being a *survival* tool rather than a *throughput* tool.
This is a prototype-only design — no runtime scripting required.

This candidate has not been accepted. It is listed here as a starting point for future design work.

---

## Chest line: closed

The old compost-chest milestone is **permanently dropped** — not on hold, not archived for revival.
See [milestones/02-planet-chests/README.md](../milestones/02-planet-chests/README.md).

Logistic chests were evaluated and found to offer only incremental numeric variants via prototypes,
not a new strategic axis. See the analysis in the milestone archive for details.

---

## Cross-references

- [FRAMEWORK.md — Design philosophy](../FRAMEWORK.md#design-philosophy) — current specialties + field drones
- [FRAMEWORK.md — Research tree](../FRAMEWORK.md#research-tree) — no `pb-gleba-robotics` (yet)
