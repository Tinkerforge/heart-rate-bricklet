<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHeartRate.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHeartRate;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'abc'; // Change to your UID

// Callback function for heart rate (in beats per minute)
function cb_heart_rate($hrate)
{
    echo "Heart Rate(bpm): " . $hrate ."\n";
    echo "\n";
}

$ipcon = new IPConnection(); // Create IP connection
$hr = new BrickletHeartRate(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set Period for heart rate callback to 1s (1000ms)
// Note: The callback is only called every second if the 
//       heart has changed since the last call!
$hr->setHeartRateCallbackPeriod(1000);

// Register heart rate callback to function cb_heart_rate
$hr->registerCallback(BrickletHeartRate::CALLBACK_HEART_RATE, 'cb_heart_rate');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
