# Window hook for .github/scripts/capture-windows.sh: awesome runs with each theme and
# two tiled terminal windows, so the wibar, the tag list, focused and unfocused
# borders, titlebars and the wallpaper show. It is a whole desktop, so it gets no
# window frame.
# Requires: awesome, alacritty.
# shellcheck shell=bash
name=awesome
x11=yes
frame=none
size=1200x700
wait=9

launch() {
  local theme="$root/themes/kanagawa-$1/theme.lua"
  # Load the theme, and tile windows so both borders show.
  sed -e "s|^beautiful.init(.*|beautiful.init(\"$theme\")|" \
    -e '0,/awful.layout.suit.floating,/s//awful.layout.suit.tile,/' /etc/xdg/awesome/rc.lua >"$work/rc-$1.lua"
  # The terminals take the theme's own background and foreground.
  local bg fg term
  bg=$(sed -n 's/^theme.wallpaper_bg = "\(.*\)"/\1/p' "$theme")
  fg=$(sed -n 's/^theme.fg_focus = "\(.*\)"/\1/p' "$theme")
  term="env -u WAYLAND_DISPLAY LESS= LESSOPEN= alacritty -o colors.primary.background='\"$bg\"' -o colors.primary.foreground='\"$fg\"'"
  printf 'awesome -c %s & sleep 3; cd %s; %s --title README.md -e less README.md & sleep 2; %s --title theme.lua -e less %s &' \
    "$work/rc-$1.lua" "$root" "$term" "$term" "themes/kanagawa-$1/theme.lua"
}
