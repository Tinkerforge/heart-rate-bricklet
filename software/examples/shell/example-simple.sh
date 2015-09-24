#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Get current heart rate (unit is bpm)
tinkerforge call heart-rate-bricklet $uid get-heart-rate
