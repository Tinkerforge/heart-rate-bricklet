var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'abc'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var hr = new Tinkerforge.BrickletHeartRate(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);
    }
); // Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set Period for heart rate callback to 1s (1000ms)
        // Note: The callback is only called every second if the 
        // heart rate has changed since the last call!
        hr.setHeartRateCallbackPeriod(1000);
    }
);

// Register heart rate callback
hr.on(Tinkerforge.BrickletHeartRate.CALLBACK_HEART_RATE,
    // Callback function for heart rate callback
    function(hrate) {
        console.log('Heart Rate(bpm): '+hrate);
        console.log();
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);

