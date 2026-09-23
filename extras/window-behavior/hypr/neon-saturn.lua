-- Neon Saturn window behavior. Installed and removed by
-- extras/window-behavior/install.sh from the omarchy-neon-saturn-theme repo.

local paths = require("default.hypr.paths")

-- Every theme: windows stay fully opaque, focused or not, and unfocused windows
-- are never dimmed. Omarchy's default rule sets 0.985 / 0.96 opacity; this runs
-- after it, so it wins.
o.window(".*", { tag = "-default-opacity", opacity = "1 1" })

hl.config({
  decoration = {
    dim_inactive = false,
  },
})

-- Neon Saturn only: the neon glow and motion. Any other theme keeps its own look.
local function active_theme()
  local file = io.open(paths.home .. "/.local/state/omarchy/current/theme.name", "r")
  if not file then
    return nil
  end

  local name = file:read("*l")
  file:close()
  return name
end

if active_theme() ~= "neon-saturn" then
  return
end

local active_border_color = { colors = { "rgba(8b44f0ee)", "rgba(c85ffbee)" }, angle = 45 }
local inactive_border_color = "rgba(25263b99)"

hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 8,
    border_size = 1,

    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  decoration = {
    rounding = 4,
    -- The focused window glows violet; unfocused windows cast no shadow.
    shadow = { enabled = true, range = 10, render_power = 3, color = "rgba(8b44f055)", color_inactive = "rgba(00000000)" },
    blur = { enabled = true, size = 5, passes = 3, noise = 0.02, brightness = 0.9, vibrancy = 0.3 },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },
})

-- The focused border's gradient sweeps slowly around the window, like a light streak.
hl.animation({ leaf = "borderangle", enabled = true, speed = 60, bezier = "linear", style = "loop" })
-- Short slide transitions: motion without chaos.
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.2, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.0, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.4, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.6, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.4, bezier = "easeOutQuint", style = "slide" })
