#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHeartRate;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Heart Rate Bricklet

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $hr = Tinkerforge::BrickletHeartRate->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current heart rate (unit is bpm)
my $heart_rate = $hr->get_heart_rate();
print "Heart Rate: $heart_rate bpm\n";

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
