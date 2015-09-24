function matlab_example_threshold()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletHeartRate;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    hr = BrickletHeartRate(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    hr.setDebouncePeriod(10000);

    % Register heart rate reached callback to function cb_heart_rate_reached
    set(hr, 'HeartRateReachedCallback', @(h, e) cb_heart_rate_reached(e));

    % Configure threshold for heart rate "greater than 100 bpm" (unit is bpm)
    hr.setHeartRateCallbackThreshold('>', 100, 0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for heart rate reached callback (parameter has unit bpm)
function cb_heart_rate_reached(e)
    fprintf('Heart Rate: %i bpm\n', e.heartRate);
end
