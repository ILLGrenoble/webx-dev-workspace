#!/bin/bash

cleanup() {
    echo -e "\nContainer stopped, performing cleanup..."
    /usr/bin/run_wm.sh -s
}

trap 'cleanup' SIGTERM
trap 'cleanup' SIGINT

export XCURSOR_SIZE=24

# Run using Xvfb with a large framebuffer
/usr/bin/run_wm.sh -w 8192 -h 8192 -x Xvfb $@ &

sleep 5
DISPLAY=:20 xrandr --fb 1920x1080

wait $!

