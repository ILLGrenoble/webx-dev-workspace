#!/bin/bash

cleanup() {
    echo -e "\nContainer stopped, performing cleanup..."
    /usr/bin/run_wm.sh -s
}

trap 'cleanup' SIGTERM
trap 'cleanup' SIGINT

export XCURSOR_SIZE=24

# # Use standard xrdp-xorg
# /usr/bin/run_wm.sh -w 1920 -h 1080 $@ &

# Run using Xvfb with a large framebuffer
/usr/bin/run_wm.sh -w 8192 -h 8192 -x Xvfb $@ &

sleep 5
export DISPLAY=:20
WIDTH=1920
HEIGHT=1080

OUTPUT=$(xrandr --query | awk '/ connected/{print $1; exit}')
MODE_DETAILS=$(cvt $WIDTH $HEIGHT 60.0 | sed -n 's/Modeline "\(.*\)_.*"\(.*\)/\1\2/p')
xrandr --newmode $MODE_DETAILS
xrandr --addmode $OUTPUT ${WIDTH}x${HEIGHT}
xrandr --output $OUTPUT --mode ${WIDTH}x${HEIGHT}

# # Use standard Xvfb
# /usr/bin/run_wm.sh -x Xvfb $@ &

wait $!

