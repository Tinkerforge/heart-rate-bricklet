var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change to your UID

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
        // Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        hr.setDebouncePeriod(10000);

        // Configure threshold for heart rate "greater than 100 bpm" (unit is bpm)
        hr.setHeartRateCallbackThreshold('>', 100, 0);
    }
);

// Register heart rate reached callback
hr.on(Tinkerforge.BrickletHeartRate.CALLBACK_HEART_RATE_REACHED,
    // Callback function for heart rate reached callback (parameter has unit bpm)
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
