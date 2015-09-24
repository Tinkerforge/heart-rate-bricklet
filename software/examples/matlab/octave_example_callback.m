function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    hr = java_new("com.tinkerforge.BrickletHeartRate", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register heart rate callback to function cb_heart_rate
    hr.addHeartRateCallback(@cb_heart_rate);

    % Set period for heart rate callback to 1s (1000ms)
    % Note: The heart rate callback is only called every second
    %       if the heart rate has changed since the last call!
    hr.setHeartRateCallbackPeriod(1000);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for heart rate callback (parameter has unit bpm)
function cb_heart_rate(e)
    fprintf("Heart Rate: %d bpm\n", e.heartRate);
end
