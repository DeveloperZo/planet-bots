# Interplanetary Bots

Specialty bot and roboport upgrades gated by interplanetary supply chains. Each Space Age planet contributes one best-in-mod item with real mechanical tradeoffs. No universal best — every upgrade excels in one dimension.

---

## What This Mod Adds

### Pre-Vanilla: Field Drone Depot (Nauvis, early game)

A nanobots-style scripted builder available after Automation research — long before real robotics. Place a depot, pair it with a Field Chest, load cheap Field Charges as fuel, and your blueprints build themselves.

- **Field Drone Depot** — Stationary builder with a 30-tile construction radius. Consumes 1 Field Charge per ghost built. Items are pulled from the paired chest (and from player inventory after the final research tier).
- **Field Chest** — Must be placed within depot range. One per depot. Load it with belts, inserters, assemblers — whatever your blueprint needs.
- **Field Charges** — Cheap ammo: 1 iron gear + 1 circuit = 8 charges. Fits in the depot's material slots.
- **Depot cap** — Starts at 1, increases to 5 via four tiers of Field Expansion research. The final tier also lets depots pull directly from your inventory when you're in range.

The depot is deliberately inferior to real robotics: no logistics network, no auto-resupply, manual chest loading. It solves the "I have a complex blueprint but no bots yet" problem for experienced players.

---

### Vulcanus: Payload-3 Construction Bot

The best construction bot in the mod. Carries 3 items per deconstruction trip (vanilla: 1). Slightly slower base speed — this is a hauler, not a sprinter.

**Volcanic Sprint:** When energy drops below 25%, Vulcanus bots *speed up* to 1.5x instead of crawling. Spacing your roboports further apart on perimeters becomes a valid strategy — bots overclock on the final dash to the ghost and sprint back. Experienced players will notice the difference.

**Gate:** Tungsten plate + calcite from Vulcanus.

---

### Fulgora: Fastest Logistic Bot

Speed 0.08 (1.6x vanilla), max speed 0.25 — the fastest logistics bot available. 100% lightning-immune (both prototype resistance and runtime script protection). 5 MJ supercapacitor battery survives a full Fulgora storm blackout mid-flight.

**Hidden depth (supercapacitor courier):**
- Lower energy-per-move than vanilla — long-haul flights are cheap per tile
- Higher energy-per-tick — heavy hover queues and idle bots drain faster
- Charges to 78% instead of 95% — frees roboport pads sooner under saturation
- Runs the battery deeper before recharging (9% vs 20%) — but crawls harsher when empty
- Cargo capped at 3 stacks after research (vanilla: 4) — stays a courier, not a bulk hauler

**Gate:** Supercapacitor + holmium plate from Fulgora.

---

### Aquilo: High-Throughput Roboport

4x charging energy (4,000 kW vs 1,000 kW), 2x charging stations (8 vs 4), 70 robot slots (vs 50). Designed to handle Aquilo's punishing 5x energy drain on all flying robots. The over-engineering required for Aquilo makes it the dominant roboport choice for any serious network anywhere.

**Gate:** Lithium plate + quantum processor from Aquilo. Requires both Vulcanus and Fulgora robotics research — this is the earned capstone.

---

## Design Philosophy

- **No universal best.** Each planet's upgrade is best at one thing and has real tradeoffs.
- **Supply chain is the gate.** All recipes are craftable anywhere — you just need to ship the planet-specific materials. No surface placement restrictions on specialty items.
- **Compatible with vanilla.** All roboports keep vanilla logistics/construction radii (25/55). Blueprints and mixed networks work without modification.
- **Pre-vanilla fills a gap.** The Field Drone tier bridges the "I have blueprints but no bots" phase without undermining the real robotics unlock.

---

## Research Tree

```
Automation
  └── Field Drones (depot + chest + charges)
       └── Field Expansion 1 (2 depots) → 2 (3) → 3 (4) → 4 (5 + player inventory)

Robotics
  ├── Vulcanus Robotics (metallurgic science)
  ├── Fulgora Robotics (electromagnetic science)
  └── Aquilo Robotics (cryogenic science, requires Vulcanus + Fulgora)
```

---

## Compatibility

- **Requires:** Factorio 2.0
- **Optional:** Space Age (planet specialties require Space Age science packs)
- **Works with:** Robot Attrition, Nanobots, and other logistics mods. No prototype conflicts.

---

## Mod Settings

All specialty stats (bot speeds, energies, roboport charging, depot build rate) are exposed as startup settings. Tweak values from the mod settings menu without editing Lua — restart to apply.

---

## FAQ

**Q: Does this replace vanilla bots?**
No. Vanilla bots and roboports still work normally. These are additional options unlocked through planet supply chains.

**Q: Can I use Fulgora bots with Aquilo roboports?**
Yes. All specialty items work everywhere. Mix and match freely.

**Q: What about Gleba?**
Gleba has no specialty yet — the design space is open. The mod stays on the bot/roboport axis; a Gleba specialty may be added in a future update if a mechanically unique concept emerges.

**Q: Is the Field Drone Depot a real roboport?**
It uses the roboport prototype for the construction radius overlay, but has no robots, no logistics network, and no charging. All building is handled by script. It's closer to Nanobots than to a roboport.

---

## Changelog

### 0.1.0

- Initial release
- Pre-vanilla Field Drone Depot with Field Charges, Field Chests, and 1:1 depot-chest pairing
- Vulcanus construction bot (payload 3, volcanic sprint)
- Fulgora logistic bot (fastest, lightning-immune, supercapacitor courier)
- Aquilo roboport (4x charging, 2x stations, 70 robot slots)
- Depot cap system (1→5 via research, final tier unlocks player inventory sourcing)
- Full startup settings for all specialty stats
- UX: placement hints, depot alerts, descriptive tooltips
