#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "abc" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_heart_rate import HeartRate

# Callback function for heart rate callback (in beats per minute)
def cb_heart_rate(hrate):
    print('Heart Rate(bpm): ' + str(hrate))
    print('')

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    hr = HeartRate(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected
    # Set Period for heart rate callback to 1s (1000ms)
    # Note: The callback is only called every second if the 
    #       heart rate has changed since the last call!
    hr.set_heart_rate_callback_period(1000)

    # Register heart rate callback to function cb_heart_rate
    hr.register_callback(hr.CALLBACK_HEART_RATE, cb_heart_rate)
    
    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
