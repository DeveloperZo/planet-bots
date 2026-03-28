-- settings.lua
-- Startup settings for rapid playtesting. Every design lever from the prototype
-- files is exposed here so values can be tweaked from the mod settings screen
-- without editing Lua. Requires map restart (startup settings).

local order_idx = 0
local function next_order()
  order_idx = order_idx + 1
  return string.format("pb-%03d", order_idx)
end

local function double_setting(name, default, min, max)
  return {
    type = "double-setting",
    name = name,
    setting_type = "startup",
    default_value = default,
    minimum_value = min,
    maximum_value = max,
    order = next_order(),
  }
end

local function int_setting(name, default, min, max)
  return {
    type = "int-setting",
    name = name,
    setting_type = "startup",
    default_value = default,
    minimum_value = min,
    maximum_value = max,
    order = next_order(),
  }
end

data:extend({

  -- ═══════════════════════════════════════════════════════════════════════════
  -- FULGORA LOGISTIC BOT
  -- ═══════════════════════════════════════════════════════════════════════════
  double_setting("pb-fulgora-lbot-speed",                   0.08,  0.01,  0.30),
  double_setting("pb-fulgora-lbot-max-speed",               0.25,  0.05,  0.50),
  double_setting("pb-fulgora-lbot-max-energy-mj",           5,     0.5,   20),
  double_setting("pb-fulgora-lbot-energy-per-move-kj",      3,     0.5,   20),
  double_setting("pb-fulgora-lbot-energy-per-tick-kw",      6,     0.5,   20),
  int_setting   ("pb-fulgora-lbot-max-payload",             1,     1,     10),
  int_setting   ("pb-fulgora-lbot-max-payload-after-bonus", 3,     1,     10),
  double_setting("pb-fulgora-lbot-min-to-charge",           0.09,  0.01,  0.50),
  double_setting("pb-fulgora-lbot-max-to-charge",           0.78,  0.50,  1.00),
  double_setting("pb-fulgora-lbot-speed-when-empty",        0.2,   0.01,  2.00),

  -- ═══════════════════════════════════════════════════════════════════════════
  -- VULCANUS CONSTRUCTION BOT
  -- ═══════════════════════════════════════════════════════════════════════════
  double_setting("pb-vulcanus-cbot-speed",                  0.10,  0.01,  0.30),
  double_setting("pb-vulcanus-cbot-max-speed",              0.20,  0.05,  0.50),
  double_setting("pb-vulcanus-cbot-max-energy-mj",          5,     0.5,   20),
  double_setting("pb-vulcanus-cbot-energy-per-move-kj",     8,     0.5,   30),
  double_setting("pb-vulcanus-cbot-energy-per-tick-kw",     3,     0.5,   20),
  int_setting   ("pb-vulcanus-cbot-max-payload",            3,     1,     10),
  double_setting("pb-vulcanus-cbot-min-to-charge",          0.25,  0.01,  0.50),
  double_setting("pb-vulcanus-cbot-max-to-charge",          0.95,  0.50,  1.00),
  double_setting("pb-vulcanus-cbot-speed-when-empty",       1.5,   0.01,  3.00),

  -- ═══════════════════════════════════════════════════════════════════════════
  -- AQUILO ROBOPORT
  -- ═══════════════════════════════════════════════════════════════════════════
  double_setting("pb-aquilo-port-charging-energy-kw",       4000,  500,   20000),
  int_setting   ("pb-aquilo-port-charging-stations",        8,     1,     20),
  int_setting   ("pb-aquilo-port-robot-slots",              70,    10,    200),
  int_setting   ("pb-aquilo-port-material-slots",           7,     1,     20),
  double_setting("pb-aquilo-port-energy-usage-kw",          50,    10,    500),
  double_setting("pb-aquilo-port-buffer-capacity-mj",       100,   10,    500),
  double_setting("pb-aquilo-port-input-flow-mw",            5,     1,     50),
  double_setting("pb-aquilo-port-recharge-minimum-mj",      10,    1,     100),

  -- ═══════════════════════════════════════════════════════════════════════════
  -- FIELD DRONE DEPOT (pre-vanilla Nauvis — scripted builder)
  -- ═══════════════════════════════════════════════════════════════════════════
  int_setting   ("pb-field-depot-construction-radius",      30,    10,    55),
  int_setting   ("pb-field-depot-build-per-tick",           1,     1,     5),
  int_setting   ("pb-field-depot-tick-interval",            20,    5,     60),

  -- ═══════════════════════════════════════════════════════════════════════════
  -- FIELD CHEST (pre-vanilla Nauvis — material storage for depot)
  -- ═══════════════════════════════════════════════════════════════════════════
  int_setting   ("pb-field-chest-inventory-size",           16,    4,     48),
})
