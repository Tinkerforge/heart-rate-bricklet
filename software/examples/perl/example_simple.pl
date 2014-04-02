#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHeartRate;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'abc'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $hr = Tinkerforge::BrickletHeartRate->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current heart rate (in beats per minute)
my $rate = $hr->get_heart_rate();
print "Heart Rate: $rate bpm\n";

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

