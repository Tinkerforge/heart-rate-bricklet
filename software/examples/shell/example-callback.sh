#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=abc

# set period for heart rate callback to 1s (1000ms)
# note: the heart rate callback is only called every second if the
#       heart rate has changed since the last call!
tinkerforge call heart-rate-bricklet $uid set-heart-rate-callback-period 1000

# handle incoming color callbacks
tinkerforge dispatch heart-rate-bricklet $uid heart-rate
