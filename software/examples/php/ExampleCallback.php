<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHeartRate.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHeartRate;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Heart Rate Bricklet

// Callback function for heart rate callback (parameter has unit bpm)
function cb_heartRate($heart_rate)
{
    echo "Heart Rate: $heart_rate bpm\n";
}

$ipcon = new IPConnection(); // Create IP connection
$hr = new BrickletHeartRate(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Register heart rate callback to function cb_heartRate
$hr->registerCallback(BrickletHeartRate::CALLBACK_HEART_RATE, 'cb_heartRate');

// Set period for heart rate callback to 1s (1000ms)
// Note: The heart rate callback is only called every second
//       if the heart rate has changed since the last call!
$hr->setHeartRateCallbackPeriod(1000);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
