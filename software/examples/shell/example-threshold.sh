#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=abc

# get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call heart-rate-bricklet $uid set-debounce-period 10000

# Configure threshold for heart rate values,
# Heart Rate  : greater than 70 beats per minute
tinkerforge call heart-rate-bricklet $uid set-heart-rate-callback-threshold greater 50 70

# handle incoming heart-rate-reached callbacks
tinkerforge dispatch heart-rate-bricklet $uid heart-rate-reached\
 --execute "echo 'Heart Rate(bpm): {heart-rate}';
            echo '';"
