# Aquilo

## Specialty: Roboport

Aquilo produces the best roboport in the mod. **The infrastructure backbone of any serious
network.** High sustained charging throughput, more charging stations, more robot slots — the
port that scales with large swarms and keeps pace with heavy charge cycles without building a
backlog.

Aquilo's roboport is good everywhere, not just on Aquilo. The planet's extreme 5× energy drain
forced the engineering of a port that can handle constant high-frequency recharge cycles. That
same over-engineering makes it the dominant choice for any base running large bot counts.

The logistical effort is in the supply chain: the recipe requires **lithium plate and quantum
processors**, which only come from Aquilo.

**Why Aquilo?** Bot networks fail on Aquilo because vanilla roboports can't keep up with the
drain-accelerated recharge cycles. Building a roboport that solves this problem means building
the best roboport in existence. Every base in your network benefits from that.

---

## Stats


| Stat                | pb-aquilo-roboport | Vanilla  | Notes                             |
| ------------------- | ------------------ | -------- | --------------------------------- |
| Charging energy     | **4,000 kW**       | 1,000 kW | 4× vanilla — clears queues fast   |
| Charging stations   | **8**              | 4        | 2× stations                       |
| **Robot slots**     | **70**             | 50       | **1.4× — larger swarms per port** |
| Logistics radius    | 25                 | 25       | Unchanged                         |
| Construction radius | 55                 | 55       | Unchanged                         |


---

## Recipe

**Item name:** `pb-aquilo-roboport`

**Ingredients:** roboport × 1 + lithium-plate × 6 + quantum-processor × 4 + ice-platform × 8

No `surface_conditions`. Craftable anywhere. Requires an Aquilo supply line for the lithium
plate and quantum processors.

**Tech gate:** `pb-aquilo-robotics` — requires cryogenic science pack.

---

## Construction Bot

Aquilo does **not** produce a specialty construction bot. Use Vulcanus construction bots for
large builds.

## Logistic Bot

Aquilo does **not** produce a specialty logistic bot. Use Fulgora logistic bots for your
logistics layer.

---

## Aquilo environment note

Vanilla bots on Aquilo operate under a 5× energy drain multiplier and are impractical without
very dense roboport coverage. The Aquilo roboport's 4× charging throughput directly compensates
for this — pair with a tight grid of Aquilo roboports to run any bot family on this planet.


| Bot                      | Effective kJ/move on Aquilo | Viable?                          |
| ------------------------ | --------------------------- | -------------------------------- |
| Vanilla                  | 25 kJ                       | Only with very dense port grid   |
| Any planet specialty bot | Varies                      | Viable with Aquilo roboport grid |


