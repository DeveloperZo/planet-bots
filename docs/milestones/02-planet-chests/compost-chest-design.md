# Compost Chest — Design Specification

**Status:** Designed, not yet implemented  
**Milestone:** 2.1  
**Planet:** Gleba

---

## Concept

A chest with a dedicated fuel slot. While nutrients are loaded into the fuel slot, the chest
actively slows spoilage on all other items inside it. When the fuel runs out, the chest punishes
you — items spoil *faster* than they would outside. The nutrient is consumed rapidly, as if being
burned as a preservation medium.

This fits the Gleba identity: the nutrient pipeline isn't optional on Gleba, it's structural.
This chest makes that loop mechanical — maintain the feed or pay the penalty.

---

## State Machine

```
  ┌────────────────────────────────────────────────────┐
  │  FUELED                                            │
  │  Fuel slot has ≥ 1 nutrient                        │
  │  → spoil_tick pushed forward each cycle (×SLOW)    │
  │  → 1 nutrient consumed every FUEL_INTERVAL ticks   │
  └──────────────┬─────────────────────────────────────┘
                 │ fuel slot empties
                 ▼
  ┌────────────────────────────────────────────────────┐
  │  UNFUELED                                          │
  │  Fuel slot empty                                   │
  │  → spoil_tick pushed backward each cycle (×FAST)   │
  │  → spoilage accelerates until fuel is restored     │
  └──────────────┬─────────────────────────────────────┘
                 │ nutrient inserted into fuel slot
                 └──────────────────────────────────────▶ FUELED
```

---

## Tuning Parameters

| Parameter | Value | Notes |
|---|---|---|
| `TICK_INTERVAL` | 60 ticks (1 second) | How often the script runs for this chest |
| `FUEL_INTERVAL` | 3,600 ticks (1 min) | 1 nutrient consumed per minute of operation |
| `SLOW_FACTOR` | 0.15 | Items spoil at 15% of normal rate while fueled |
| `FAST_FACTOR` | 2.0 | Items spoil at 200% of normal rate when unfueled |

**SLOW math:** each cycle (60 ticks), push `spoil_tick` forward by `60 × (1 - 0.15) = 51 ticks`.
Net decay: 9 ticks per 60 real ticks → ~15% normal rate.

**FAST math:** each cycle, push `spoil_tick` backward by `60 × (2.0 - 1) = 60 ticks`.
Net decay: 120 ticks per 60 real ticks → 200% normal rate.

These are first-pass values — balance pass in Milestone 1.3 should revisit.

---

## Inventory Layout

```
Slot 0:  FUEL SLOT — locked to "nutrient" via script set_filter
Slots 1–N:  General storage (up to N = inventory_size - 1)
```

Implemented as `ContainerPrototype` with `inventory_type = "with_filters_and_bar"`.
This is the same type as cargo wagons — slots can be filtered.

At `on_built_entity`, the script calls:
```lua
entity.get_inventory(defines.inventory.chest).set_filter(1, "nutrient")
```
Slot 1 is Lua-indexed (1-based); visually it appears as the top-left slot in the UI.

---

## Script Logic (pseudocode)

```lua
-- on_nth_tick(60):
for each compost_chest in storage.compost_chests:
  local inv = chest.get_inventory(defines.inventory.chest)
  local fuel_stack = inv[1]

  -- Consume fuel
  local fueled = false
  if fuel_stack.valid_for_read and fuel_stack.name == "nutrient" then
    -- Track ticks since last fuel consumption
    local state = storage.compost_state[chest.unit_number]
    state.ticks_since_consumed = (state.ticks_since_consumed or 0) + 60
    if state.ticks_since_consumed >= FUEL_INTERVAL then
      fuel_stack.count = fuel_stack.count - 1  -- consumes 1 nutrient
      state.ticks_since_consumed = 0
    end
    fueled = true
  end

  -- Adjust spoil_tick for all non-fuel slots
  for i = 2, #inv do
    local stack = inv[i]
    if stack.valid_for_read and stack.spoil_tick > 0 then
      if fueled then
        stack.spoil_tick = stack.spoil_tick + math.floor(60 * (1 - SLOW_FACTOR))
        -- net: only 9 ticks of real time consumed per cycle
      else
        stack.spoil_tick = stack.spoil_tick - math.floor(60 * (FAST_FACTOR - 1))
        -- net: 120 ticks consumed per 60-tick cycle
        -- clamp: don't go below current_tick (instant spoil)
        if stack.spoil_tick < game.tick then
          stack.spoil_tick = game.tick
          -- item will spoil on next game update naturally
        end
      end
    end
  end
```

---

## Entity Registration

Register on build, blueprint, and undo (same pattern as `placement.lua`):

```lua
local COMPOST_NAME = "pb-compost-chest"

local function on_built(event)
  local entity = event.entity or event.created_entity
  if entity and entity.name == COMPOST_NAME then
    storage.compost_chests[entity.unit_number] = entity
    storage.compost_state[entity.unit_number] = { ticks_since_consumed = 0 }
    entity.get_inventory(defines.inventory.chest).set_filter(1, "nutrient")
  end
end

script.on_event(defines.events.on_built_entity, on_built)
script.on_event(defines.events.on_robot_built_entity, on_built)

script.on_event(defines.events.on_entity_died, function(event)
  if event.entity.name == COMPOST_NAME then
    storage.compost_chests[event.entity.unit_number] = nil
    storage.compost_state[event.entity.unit_number] = nil
  end
end)
-- same for on_player_mined_entity, on_robot_mined_entity
```

---

## Prototype Definition (sketch)

```lua
-- prototypes/gleba/compost-chest.lua
{
  type = "container",
  name = "pb-compost-chest",
  inventory_size = 20,           -- 1 fuel slot + 19 storage slots
  inventory_type = "with_filters_and_bar",
  -- energy_source = none — passive, no power drain
  -- picture = tinted vanilla iron-chest or custom
}
```

---

## Recipe Gate

Gleba tech tree — requires:
- Gleba roboport research (already exists in mod)
- 2× bioflux + iron chest + 5× nutrient

Recipe has `surface_conditions` requiring Gleba (or just gated by tech that requires Gleba arrival).

---

## Player Feedback / UX

- Fuel slot is visually the first slot — labeled via `entity_description` locale with a note.
- When unfueled, entity `status` can be set to a warning state via circuit output or a `render_extra_details_gui` locale note.
- Future (Milestone 3): add a small indicator overlay (green/red light) using `LuaRendering` to show fueled state.

---

## Open Questions

- [ ] Should the fuel slot accept spoiled nutrients too, or only fresh? (Current design: accepts any nutrient stack regardless of `spoil_percent`, burns through them quickly anyway.)
- [ ] Should the chest show its FUELED/UNFUELED state on the map (entity status light)? Defer to Milestone 3.
- [ ] Inventory size: 20 slots total (1 fuel + 19 storage) — verify this feels right at 1× quality.
