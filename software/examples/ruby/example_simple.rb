#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_heart_rate'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'abc' # Change to your UID

ipcon = IPConnection.new # Create IP connection
hr = BrickletHeartRate.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current heart rate (in beats per minute)
hrate = hr.get_heart_rate
puts "Heart Rate(bpm): #{hrate}"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
