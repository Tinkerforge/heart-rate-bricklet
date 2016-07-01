var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change XYZ to the UID of your Heart Rate Bricklet

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var hr = new Tinkerforge.BrickletHeartRate(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Set period for heart rate callback to 1s (1000ms)
        // Note: The heart rate callback is only called every second
        //       if the heart rate has changed since the last call!
        hr.setHeartRateCallbackPeriod(1000);
    }
);

// Register heart rate callback
hr.on(Tinkerforge.BrickletHeartRate.CALLBACK_HEART_RATE,
    // Callback function for heart rate callback (parameter has unit bpm)
    function (heartRate) {
        console.log('Heart Rate: ' + heartRate + ' bpm');
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
