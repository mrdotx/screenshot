#!/bin/sh

# path:   /home/klassiker/.local/share/repos/screenshot/screenshot.sh
# author: klassiker [mrdotx]
# github: https://github.com/mrdotx/screenshot
# date:   2021-07-16T19:35:19+0200

# config
screenshot_directory="$HOME/Desktop"
screenshot_file="$screenshot_directory/screenshot-$(date +"%FT%T%z").png"
screenshot_command="maim -B -u -q $screenshot_file"
screenshot_preview="sxiv $screenshot_file"

script=$(basename "$0")
help="$script [-h/--help] -- script to make screenshots with maim
  Usage:
    $script [--desktop/--window/--selection] [seconds]

  Settings:
    [--desktop]   = full screen screenshot
    [--window]    = active window screenshot
    [--selection] = selection screenshot
    [seconds]     = the option -desk and -window can be used
                    with delay in seconds to make screenshot

  Examples:
    $script --desktop
    $script --window
    $script --selection
    $script --desktop 5
    $script --window 5"

[ -n "$2" ] \
    && screenshot_command="$screenshot_command -d $2"

case "$1" in
    --desktop)
        $screenshot_command \
            && $screenshot_preview &
        ;;
    --window)
        $screenshot_command --window "$(xdotool getactivewindow)" \
            && $screenshot_preview &
        ;;
    --selection)
        notify-send \
            "maim" \
            "select an area or a window for the screenshot"
        $screenshot_command --select \
            && $screenshot_preview &
        ;;
    *)
        printf "%s\n" "$help"
        exit 1
        ;;
esac
