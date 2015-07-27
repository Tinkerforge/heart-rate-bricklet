#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_heart_rate import HeartRate

# Callback function for heart rate greater than 100 bpm (parameter has unit bpm)
def cb_heart_rate_reached(heart_rate):
    print('Heart Rate: ' + str(heart_rate) + ' bpm')

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    hr = HeartRate(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    hr.set_debounce_period(10000)

    # Register threshold reached callback to function cb_heart_rate_reached
    hr.register_callback(hr.CALLBACK_HEART_RATE_REACHED, cb_heart_rate_reached)

    # Configure threshold for "greater than 100 bpm" (unit is bpm)
    hr.set_heart_rate_callback_threshold('>', 100, 0)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
