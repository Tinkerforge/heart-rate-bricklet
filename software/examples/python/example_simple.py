#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "abc" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_heart_rate import HeartRate

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    hr = HeartRate(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current heart rate(in beats per minute)
    hrate = hr.get_heart_rate()

    print('Heart Rate(bpm): ' + str(hrate))
    print('')

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
