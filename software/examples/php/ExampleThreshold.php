<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHeartRate.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHeartRate;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Heart Rate Bricklet

// Callback function for heart rate reached callback (parameter has unit bpm)
function cb_heartRateReached($heart_rate)
{
    echo "Heart Rate: $heart_rate bpm\n";
}

$ipcon = new IPConnection(); // Create IP connection
$hr = new BrickletHeartRate(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$hr->setDebouncePeriod(10000);

// Register heart rate reached callback to function cb_heartRateReached
$hr->registerCallback(BrickletHeartRate::CALLBACK_HEART_RATE_REACHED,
                      'cb_heartRateReached');

// Configure threshold for heart rate "greater than 100 bpm" (unit is bpm)
$hr->setHeartRateCallbackThreshold('>', 100, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
