# Gleba

## Specialty: Compost Chest

Gleba does not produce a specialty robot or roboport. Its contribution to the inter-planetary
robot economy is the **Compost Chest** — the only structure in the mod that actively manages
spoilage for items stored inside it.

Gleba's nutrient economy makes this thematic: the chest is fed nutrients as fuel, and while
fueled it preserves its contents. Let the fuel run out and it punishes you — items spoil faster
than they would outside. The chest integrates into the nutrient pipeline rather than sitting
beside it.

Useful anywhere spoilable items transit through or accumulate: Gleba itself, agricultural
outposts, science pack buffer chests.

**Why Gleba?** The planet is defined by the spoilage clock and the nutrient loop. A chest that
externalizes that loop as a mechanic is the natural Gleba contribution — not faster or heavier
robots, but a structural solution to the problem Gleba creates.

---

## Compost Chest — behavior summary

See full specification: `[docs/milestones/02-planet-chests/compost-chest-design.md](../milestones/02-planet-chests/compost-chest-design.md)`


| State        | Spoil rate inside chest | Condition                      |
| ------------ | ----------------------- | ------------------------------ |
| **Fueled**   | **15% of normal**       | Nutrient in slot 1 (fuel slot) |
| **Unfueled** | **200% of normal**      | Fuel slot empty                |


**Fuel consumption:** 1 nutrient per minute of fueled operation.

Slot 1 is locked to `nutrient` by the script. Slots 2–20 are general storage.

---

## Recipe

**Item name:** `pb-gleba-compost-chest`

**Ingredients:** iron-chest × 1 + bioflux × 3 + nutrients × 10 + wooden-chest × 2

No `surface_conditions`. Craftable anywhere. Requires a Gleba supply line for the bioflux.

**Tech gate:** `pb-gleba-robotics` — requires agricultural science pack.

---

## Robots and Roboports

Gleba does **not** produce specialty robots or roboports. Use:

- **Vulcanus construction bots** for large builds
- **Fulgora logistic bots** for fast delivery
- **Aquilo roboports** as your network backbone

