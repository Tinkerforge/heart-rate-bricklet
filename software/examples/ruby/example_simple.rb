#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_heart_rate'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Heart Rate Bricklet

ipcon = IPConnection.new # Create IP connection
hr = BrickletHeartRate.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current heart rate (unit is bpm)
heart_rate = hr.get_heart_rate
puts "Heart Rate: #{heart_rate} bpm"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
