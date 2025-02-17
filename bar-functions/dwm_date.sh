#!/bin/sh

# A dwm_bar function that shows the current date and time
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Date is formatted like like this: "[Mon 01-01-00 00:00:00]"
dwm_date () {
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
        printf " %s  %s" "$(date "+%a %d-%m-%Y")" "$(date "+%T")"
    else
        printf "DAT %s" "$(date "+%a %d-%m-%Y %T")"
    fi
    printf "%s\n" "$SEP2"
}

dwm_date
