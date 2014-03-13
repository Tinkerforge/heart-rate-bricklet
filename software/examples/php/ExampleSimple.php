<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletHeartRate.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletHeartRate;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'abc'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$c = new BrickletHeartRate(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current heart rate (in beats per minute)
$hrate = $c->getHeartRate();

echo "Heart Rate(bpm): ".$hrate."\n";
echo "\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
