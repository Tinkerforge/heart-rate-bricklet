#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHeartRate;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $hr = Tinkerforge::BrickletHeartRate->new(&UID, $ipcon); # Create device object

# Callback subroutine for heart rate greater than 100 bpm (parameter has unit bpm)
sub cb_heart_rate_reached
{
    my ($heart_rate) = @_;

    print "Heart Rate: " . $heart_rate . " bpm\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$hr->set_debounce_period(10000);

# Register threshold reached callback to subroutine cb_heart_rate_reached
$hr->register_callback($hr->CALLBACK_HEART_RATE_REACHED, 'cb_heart_rate_reached');

# Configure threshold for "greater than 100 bpm" (unit is bpm)
$hr->set_heart_rate_callback_threshold('>', 100, 0);

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
