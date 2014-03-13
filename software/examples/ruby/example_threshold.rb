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

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
hr.set_debounce_period 10000

# Register callback for heart rate reached threshold
hr.register_callback(BrickletHeartRate::CALLBACK_HEART_RATE_REACHED) do |hrate|
    puts "Heart Rate(bpm): #{hrate}"
    puts ''
end

# Configure threshold for heart rate values,
# Heart Rate : greater than 70
hr.set_heart_rate_callback_threshold '>', 50, 70

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
