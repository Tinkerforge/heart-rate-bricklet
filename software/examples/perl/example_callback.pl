#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletHeartRate;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $hr = Tinkerforge::BrickletHeartRate->new(&UID, $ipcon); # Create device object

# Callback subroutine for heart rate callback (parameter has unit bpm)
sub cb_heart_rate
{
    my ($heart_rate) = @_;

    print "Heart Rate: " . $heart_rate . " bpm\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set period for heart rate callback to 1s (1000ms)
# Note: The heart rate callback is only called every second
#       if the heart rate has changed since the last call!
$hr->set_heart_rate_callback_period(1000);

# Register heart rate callback to subroutine cb_heart_rate
$hr->register_callback($hr->CALLBACK_HEART_RATE, 'cb_heart_rate');

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
