function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletHeartRate;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Heart Rate Bricklet

    ipcon = IPConnection(); % Create IP connection
    hr = handle(BrickletHeartRate(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register heart rate callback to function cb_heart_rate
    set(hr, 'HeartRateCallback', @(h, e) cb_heart_rate(e));

    % Set period for heart rate callback to 1s (1000ms)
    % Note: The heart rate callback is only called every second
    %       if the heart rate has changed since the last call!
    hr.setHeartRateCallbackPeriod(1000);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for heart rate callback (parameter has unit bpm)
function cb_heart_rate(e)
    fprintf('Heart Rate: %i bpm\n', e.heartRate);
end
