#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=abc

# get current heart rate (in beats per minute)
tinkerforge call heart-rate-bricklet $uid get-heart-rate
