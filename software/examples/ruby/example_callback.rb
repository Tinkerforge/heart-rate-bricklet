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

# Set Period for heart rate callback to 1s (1000ms)
# Note: The callback is only called every second if the
#       heart rate has changed since the last call!
hr.set_heart_rate_callback_period 1000

# Register heart rate callback
hr.register_callback(BrickletHeartRate::CALLBACK_HEART_RATE) do |hrate|
    puts "Heart Rate(bpm): #{hrate}"
    puts ''
end

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
