function octave_example_threshold()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Heart Rate Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    hr = javaObject("com.tinkerforge.BrickletHeartRate", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    hr.setDebouncePeriod(10000);

    % Register heart rate reached callback to function cb_heart_rate_reached
    hr.addHeartRateReachedCallback(@cb_heart_rate_reached);

    % Configure threshold for heart rate "greater than 100 bpm"
    hr.setHeartRateCallbackThreshold(">", 100, 0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for heart rate reached callback
function cb_heart_rate_reached(e)
    fprintf("Heart Rate: %d bpm\n", e.heartRate);
end
