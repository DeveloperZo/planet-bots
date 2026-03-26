# Vulcanus

## Specialty: Construction Bot

Vulcanus produces the best construction bot in the mod. **Payload = 3** — each bot carries three
items to a ghost per trip. For large builds (walls, smelter rows, foundry floors, megabase
blueprints) this is the single most impactful bot upgrade available. Fewer trips means faster
completion, less charging congestion, and a smaller swarm needed to keep pace with big blueprint
drops.

These bots work anywhere. The logistical effort is in the supply chain: the recipe requires
**tungsten plate and calcite**, which only come from Vulcanus. Once you have a Vulcanus supply
line running to your crafting planet, you can equip every base in your network with them.

**Why Vulcanus?** The planet is defined by raw industrial throughput — foundries, smelters, bulk
processing. A bot that carries 3× per trip is the mechanical expression of that. Building with
Vulcanus bots feels like the planet itself is helping you build.

---

## Stats

| Stat | pb-vulcanus-construction-robot | Vanilla | Notes |
|---|---|---|---|
| Speed | 0.05 | 0.06 | Slightly slower — the tradeoff for payload |
| Max speed | 0.10 | — | Hard cap; dense hub routing |
| Max energy | 3 MJ | 1.5 MJ | 2× battery |
| Energy per move | 8 kJ | 5 kJ | 1.6× cost — manageable everywhere |
| Energy per tick | 3 kW | 3 kW | Vanilla idle |
| **Payload** | **3** | **1** | **The reason you're here** |

---

## Recipe

**Item name:** `pb-vulcanus-construction-robot`

**Ingredients:** construction-robot × 1 + tungsten-plate × 5 + calcite × 3 + steel-plate × 4

No `surface_conditions`. Craftable anywhere. Requires a Vulcanus supply line for the tungsten
and calcite.

**Tech gate:** `pb-vulcanus-robotics` — requires metallurgic science pack.

---

## Roboport

Vulcanus does **not** produce a specialty roboport. Use Aquilo roboports as your network
backbone, or vanilla roboports for local hubs.

## Logistic Bot

Vulcanus does **not** produce a specialty logistic bot. Use Fulgora logistic bots for your
logistics layer.
