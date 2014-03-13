var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'abc';// Change to your UID

var ipcon = new Tinkerforge.IPConnection();// Create IP connection
var hr = new Tinkerforge.BrickletHeartRate(UID, ipcon);// Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);        
    }
);// Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set threshold callbacks with a debounce time of 10 seconds (10000ms)
        hr.setDebouncePeriod(10000);
        // Configure threshold for heart rate values,
        // Heart Rate  : greater than 70 beats per minute
        hr.setHeartRateCallbackThreshold('>', 50, 70);       
    }
);

// Register threshold reached callback
hr.on(Tinkerforge.BrickletHeartRate.CALLBACK_HEART_RATE_REACHED,
    // Callback for heart rate threshold reached
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

