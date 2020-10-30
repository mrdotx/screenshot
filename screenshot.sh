#!/bin/sh

# path:       /home/klassiker/.local/share/repos/screenshot/screenshot.sh
# author:     klassiker [mrdotx]
# github:     https://github.com/mrdotx/screenshot
# date:       2020-10-30T23:12:41+0100

# config
screenshot_directory=$HOME/Schreibtisch
screenshot_file=screenshot-$(date +"%FT%T%z").png
screenshot_command="maim -B -u $screenshot_directory/$screenshot_file"
screenshot_preview="sxiv $screenshot_directory/$screenshot_file"

script=$(basename "$0")
help="$script [-h/--help] -- script to make screenshots with maim
  Usage:
    $script [-desk/-window/-select] [seconds]

  Settings:
    [-desk]   = full screen screenshot
    [-window] = active window screenshot
    [-select] = selection screenshot
    [seconds] = the option -desk and -window can be used
                with delay in seconds to make screenshot

  Examples:
    $script -desk
    $script -desk 5
    $script -window
    $script -window 5
    $script -select"

[ -n "$2" ] \
    && execute="$screenshot_command -d $2" \
    || execute="$screenshot_command"

case "$1" in
    -h | --help)
        printf "%s\n" "$help"
        ;;
    -desk)
        $execute \
            && $screenshot_preview
        ;;
    -window)
        $execute -i "$(xdotool getactivewindow)" \
            && $screenshot_preview
        ;;
    -select)
        notify-send \
            "maim" \
            "select an area or window to screenshot" \
        & $screenshot_command -s \
        && $screenshot_preview
        ;;
    *)
        printf "%s\n" "$help"
        exit 1
        ;;
esac
