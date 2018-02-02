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

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
hr.set_debounce_period 10000

# Register heart rate reached callback
hr.register_callback(BrickletHeartRate::CALLBACK_HEART_RATE_REACHED) do |heart_rate|
  puts "Heart Rate: #{heart_rate} bpm"
end

# Configure threshold for heart rate "greater than 100 bpm"
hr.set_heart_rate_callback_threshold '>', 100, 0

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
