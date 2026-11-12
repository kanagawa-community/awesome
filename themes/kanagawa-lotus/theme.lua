-- Kanagawa Lotus
-- https://github.com/kanagawa-community/awesome
local gfs = require("gears.filesystem")
local gcolor = require("gears.color")
local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi

local theme = dofile(gfs.get_themes_dir() .. "default/theme.lua")

theme.bg_normal = "#d5cea3"
theme.bg_focus = "#e4d794"
theme.bg_urgent = "#e82424"
theme.bg_minimize = "#e7dba0"
theme.bg_systray = "#d5cea3"
theme.fg_normal = "#43436c"
theme.fg_focus = "#545464"
theme.fg_urgent = "#f2ecbc"
theme.fg_minimize = "#43436c"
theme.border_normal = "#d5cea3"
theme.border_focus = "#4d699b"
theme.border_marked = "#cc6d00"
theme.taglist_bg_focus = "#4d699b"
theme.taglist_fg_focus = "#f2ecbc"
theme.titlebar_bg_normal = "#d5cea3"
theme.titlebar_bg_focus = "#e4d794"
theme.titlebar_fg_normal = "#43436c"
theme.titlebar_fg_focus = "#545464"
theme.tooltip_bg = "#d5cea3"
theme.tooltip_fg = "#43436c"
theme.tooltip_border_color = "#716e61"
theme.notification_bg = "#d5cea3"
theme.notification_fg = "#43436c"
theme.notification_border_color = "#716e61"
theme.menu_bg_normal = "#c7d7e0"
theme.menu_fg_normal = "#43436c"
theme.menu_bg_focus = "#9fb5c9"
theme.menu_fg_focus = "#43436c"
theme.menu_border_color = "#716e61"
theme.hotkeys_bg = "#d5cea3"
theme.hotkeys_fg = "#43436c"
theme.hotkeys_modifiers_fg = "#624c83"
theme.hotkeys_border_color = "#716e61"
theme.wallpaper_bg = "#f2ecbc"

-- Icons from the default theme, drawn in this theme's colors.
local size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(size, theme.fg_focus)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(size, theme.fg_normal)
for _, name in ipairs({ "layout_fairh", "layout_fairv", "layout_floating", "layout_magnifier", "layout_max",
    "layout_fullscreen", "layout_tilebottom", "layout_tileleft", "layout_tile", "layout_tiletop",
    "layout_spiral", "layout_dwindle", "layout_cornernw", "layout_cornerne", "layout_cornersw",
    "layout_cornerse" }) do
    theme[name] = gcolor.recolor_image(theme[name], theme.fg_normal)
end
theme.awesome_icon = theme_assets.awesome_icon(dpi(16), theme.bg_focus, theme.fg_focus)
theme.wallpaper = function(s)
    return theme_assets.wallpaper(theme.wallpaper_bg, theme.fg_focus, theme.border_focus, s)
end
theme.icon_theme = nil

return theme
