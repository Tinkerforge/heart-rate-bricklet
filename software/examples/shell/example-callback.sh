#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Handle incoming heart rate callbacks (parameter has unit bpm)
tinkerforge dispatch heart-rate-bricklet $uid heart-rate &

# Set period for heart rate callback to 1s (1000ms)
# Note: The heart rate callback is only called every second
#       if the heart rate has changed since the last call!
tinkerforge call heart-rate-bricklet $uid set-heart-rate-callback-period 1000

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
