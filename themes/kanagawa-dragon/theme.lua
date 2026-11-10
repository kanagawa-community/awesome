-- Kanagawa Dragon
-- https://github.com/kanagawa-community/awesome
local gfs = require("gears.filesystem")
local gcolor = require("gears.color")
local theme_assets = require("beautiful.theme_assets")
local dpi = require("beautiful.xresources").apply_dpi

local theme = dofile(gfs.get_themes_dir() .. "default/theme.lua")

theme.bg_normal = "#0d0c0c"
theme.bg_focus = "#393836"
theme.bg_urgent = "#e82424"
theme.bg_minimize = "#282727"
theme.bg_systray = "#0d0c0c"
theme.fg_normal = "#c8c093"
theme.fg_focus = "#c5c9c5"
theme.fg_urgent = "#181616"
theme.fg_minimize = "#c8c093"
theme.border_normal = "#0d0c0c"
theme.border_focus = "#8ba4b0"
theme.border_marked = "#b6927b"
theme.taglist_bg_focus = "#8ba4b0"
theme.taglist_fg_focus = "#181616"
theme.titlebar_bg_normal = "#0d0c0c"
theme.titlebar_bg_focus = "#393836"
theme.titlebar_fg_normal = "#c8c093"
theme.titlebar_fg_focus = "#c5c9c5"
theme.tooltip_bg = "#0d0c0c"
theme.tooltip_fg = "#c8c093"
theme.tooltip_border_color = "#54546d"
theme.notification_bg = "#0d0c0c"
theme.notification_fg = "#c8c093"
theme.notification_border_color = "#54546d"
theme.menu_bg_normal = "#223249"
theme.menu_fg_normal = "#dcd7ba"
theme.menu_bg_focus = "#2d4f67"
theme.menu_fg_focus = "#dcd7ba"
theme.menu_border_color = "#54546d"
theme.hotkeys_bg = "#0d0c0c"
theme.hotkeys_fg = "#c8c093"
theme.hotkeys_modifiers_fg = "#8992a7"
theme.hotkeys_border_color = "#54546d"
theme.wallpaper_bg = "#181616"

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
