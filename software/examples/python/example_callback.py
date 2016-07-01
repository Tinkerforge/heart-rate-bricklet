#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change XYZ to the UID of your Heart Rate Bricklet

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_heart_rate import BrickletHeartRate

# Callback function for heart rate callback (parameter has unit bpm)
def cb_heart_rate(heart_rate):
    print("Heart Rate: " + str(heart_rate) + " bpm")

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    hr = BrickletHeartRate(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Register heart rate callback to function cb_heart_rate
    hr.register_callback(hr.CALLBACK_HEART_RATE, cb_heart_rate)

    # Set period for heart rate callback to 1s (1000ms)
    # Note: The heart rate callback is only called every second
    #       if the heart rate has changed since the last call!
    hr.set_heart_rate_callback_period(1000)

    raw_input("Press key to exit\n") # Use input() in Python 3
    ipcon.disconnect()
