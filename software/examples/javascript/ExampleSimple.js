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
        // Get current heart rate (in beats per minute)
        hr.getHeartRate(
            function(hrate) {
                console.log('Heart Rate(bpm): '+hrate);
                console.log();
            },
            function(error) {
                console.log('Error: '+error);
            }
        );
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);

