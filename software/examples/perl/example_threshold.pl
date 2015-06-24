#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHeartRate;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'abc'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $hr = Tinkerforge::BrickletHeartRate->new(&UID, $ipcon); # Create device object

# Callback function for heart rate reached callback
sub cb_reached
{
    my ($rate) = @_;

    print "Heart rate: $rate bpm\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$hr->set_debounce_period(10000);

# Register threshold reached callback to function cb_reached
$hr->register_callback($hr->CALLBACK_HEART_RATE_REACHED, 'cb_reached');

# Configure threshold for color values,
# Heart rate(bpm)  : greater than 60 bpm
$hr->set_heart_rate_callback_threshold('>', 50, 60);

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

