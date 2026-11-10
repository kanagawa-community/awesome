#!/usr/bin/env python3
"""Write themes/kanagawa-<variant>/theme.lua from the shared palette.

Usage: scripts/generate.py [path/to/palette.json]   (default: ../.github/palette.json)
"""
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
VARIANTS = ["wave", "dragon", "lotus"]


def roles(variant):
    """Map each role to its hex color; a role missing from the palette raises KeyError later."""
    return {role: c["hex"] for c in variant["colors"].values() for role in c["usage"]}

# beautiful variable -> palette role. Everything else, such as fonts and icons,
# comes from awesome's default theme.
VARS = {
    "bg_normal": "ui.bg_m3",
    "bg_focus": "ui.bg_p2",
    "bg_urgent": "diag.error",
    "bg_minimize": "ui.bg_p1",
    "bg_systray": "ui.bg_m3",
    "fg_normal": "ui.fg_dim",
    "fg_focus": "ui.fg",
    "fg_urgent": "ui.bg",
    "fg_minimize": "ui.fg_dim",
    "border_normal": "ui.bg_m3",
    "border_focus": "syn.fun",
    "border_marked": "syn.constant",
    "taglist_bg_focus": "syn.fun",
    "taglist_fg_focus": "ui.bg",
    "titlebar_bg_normal": "ui.bg_m3",
    "titlebar_bg_focus": "ui.bg_p2",
    "titlebar_fg_normal": "ui.fg_dim",
    "titlebar_fg_focus": "ui.fg",
    "tooltip_bg": "ui.float.bg",
    "tooltip_fg": "ui.float.fg",
    "tooltip_border_color": "ui.float.fg_border",
    "notification_bg": "ui.float.bg",
    "notification_fg": "ui.float.fg",
    "notification_border_color": "ui.float.fg_border",
    "menu_bg_normal": "ui.pmenu.bg",
    "menu_fg_normal": "ui.pmenu.fg",
    "menu_bg_focus": "ui.pmenu.bg_sel",
    "menu_fg_focus": "ui.pmenu.fg",
    "menu_border_color": "ui.float.fg_border",
    "hotkeys_bg": "ui.float.bg",
    "hotkeys_fg": "ui.float.fg",
    "hotkeys_modifiers_fg": "syn.keyword",
    "hotkeys_border_color": "ui.float.fg_border",
    "wallpaper_bg": "ui.bg",
}

LUA = """-- Kanagawa {name}
-- https://github.com/kanagawa-community/awesome
local gfs = require("gears.filesystem")
local gcolor = require("gears.color")
local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi

local theme = dofile(gfs.get_themes_dir() .. "default/theme.lua")

{vars}

-- Icons from the default theme, drawn in this theme's colors.
local size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(size, theme.fg_focus)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(size, theme.fg_normal)
for _, name in ipairs({{ "layout_fairh", "layout_fairv", "layout_floating", "layout_magnifier", "layout_max",
    "layout_fullscreen", "layout_tilebottom", "layout_tileleft", "layout_tile", "layout_tiletop",
    "layout_spiral", "layout_dwindle", "layout_cornernw", "layout_cornerne", "layout_cornersw",
    "layout_cornerse" }}) do
    theme[name] = gcolor.recolor_image(theme[name], theme.fg_normal)
end
theme.awesome_icon = theme_assets.awesome_icon(dpi(16), theme.bg_focus, theme.fg_focus)
theme.wallpaper = function(s)
    return theme_assets.wallpaper(theme.wallpaper_bg, theme.fg_focus, theme.border_focus, s)
end
theme.icon_theme = nil

return theme
"""


def theme(variant, colors):
    lines = "\n".join(f'theme.{k} = "{colors[r]}"' for k, r in VARS.items())
    return LUA.format(name=variant.capitalize(), vars=lines)


def main():
    path = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT.parent / ".github" / "palette.json"
    variants = json.loads(path.read_text())["variants"]
    for v in VARIANTS:
        out = ROOT / "themes" / f"kanagawa-{v}" / "theme.lua"
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(theme(v, roles(variants[v])))
        print(out.relative_to(ROOT))


if __name__ == "__main__":
    main()
