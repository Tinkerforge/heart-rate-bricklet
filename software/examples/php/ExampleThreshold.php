<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHeartRate.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHeartRate;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'abc'; // Change to your UID

// Callback for heart rate threshold reached
function cb_reached($hrate)
{
    echo "Heart Rate(bpm): " . $hrate ."\n";
    echo "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$hr = new BrickletHeartRate(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$hr->setDebouncePeriod(10000);

// Register threshold reached callback to function cb_reached
$hr->registerCallback(BrickletHeartRate::CALLBACK_HEART_RATE_REACHED, 'cb_reached');

// Configure threshold for heart rate values,
// Heart Rate  : greater than 70
$hr->setHeartRateCallbackThreshold('>', 50, 70);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
