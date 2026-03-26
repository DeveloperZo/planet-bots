# Fulgora

## Specialty: Logistic Bot

Fulgora produces the best logistic bot in the mod. **Fastest family, lightning-immune, deep
battery for blackout survival.** These are the couriers that run your empire — fast enough that
delivery latency stops being a bottleneck, and resilient enough to keep flying when the lights go
out or a storm rolls in.

Payload stays at 1. This is a courier, not a hauler — Vulcanus handles bulk. What Fulgora gives
you is speed and reliability. The 5 MJ battery exists specifically so a bot that launched during
a power-stable window can complete its route through a full storm blackout without a charge stop.

These bots work anywhere. The logistical effort is in the supply chain: the recipe requires
**supercapacitors and holmium plate**, which only come from Fulgora.

**Why Fulgora?** The planet is defined by electrical extremes — constant lightning, huge capacitor
banks, energy scarcity between strikes. A bot built here is hardened against everything the
electromagnetic environment can throw at it. Ship these to every base and stop worrying about
logistics latency or storm damage.

---

## Stats

| Stat | pb-fulgora-logistic-robot | Vanilla | Notes |
|---|---|---|---|
| **Speed** | **0.08** | 0.05 | **1.6× vanilla** |
| Max speed | 0.25 | — | Fastest in mod |
| Max energy | 5 MJ | 1.5 MJ | 3.3× — blackout range |
| Energy per move | 4 kJ | 5 kJ | 0.8× vanilla — more efficient |
| Energy per tick | 3 kW | 3 kW | Vanilla idle |
| Payload | 1 | 1 | Courier, not hauler |
| **Electric resistance** | **100%** | None | **Lightning-immune** |
| Min charge threshold | 12% | 20% | Returns to charge later |

---

## Recipe

**Item name:** `pb-fulgora-logistic-robot`

**Ingredients:** logistic-robot × 1 + supercapacitor × 4 + holmium-plate × 3 + advanced-circuit × 6

No `surface_conditions`. Craftable anywhere. Requires a Fulgora supply line for the
supercapacitors and holmium plate.

**Tech gate:** `pb-fulgora-robotics` — requires electromagnetic science pack.

---

## Roboport

Fulgora does **not** produce a specialty roboport. Use Aquilo roboports as your network backbone.

## Construction Bot

Fulgora does **not** produce a specialty construction bot. Use Vulcanus construction bots for
large builds.
