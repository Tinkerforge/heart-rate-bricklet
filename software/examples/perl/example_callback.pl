#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHeartRate;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'abc'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $hr = Tinkerforge::BrickletHeartRate->new(&UID, $ipcon); # Create device object

# Callback function for heart rate callback
sub cb_heart_rate
{
    my ($hrate) = @_;
    print "\nHeart Rate(bpm): ".$hrate."\n";
    print "\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for heart rate callback to 1s (1000ms)
# Note: The callback is only called every second if the 
#       heart rate has changed since the last call!
$hr->set_heart_rate_callback_period(1000);

# Register heart rate callback to function cb_heart_rate
$hr->register_callback($hr->CALLBACK_HEART_RATE, 'cb_heart_rate');

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

