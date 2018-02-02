#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Heart Rate Bricklet

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call heart-rate-bricklet $uid set-debounce-period 10000

# Handle incoming heart rate reached callbacks
tinkerforge dispatch heart-rate-bricklet $uid heart-rate-reached &

# Configure threshold for heart rate "greater than 100 bpm"
tinkerforge call heart-rate-bricklet $uid set-heart-rate-callback-threshold threshold-option-greater 100 0

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
