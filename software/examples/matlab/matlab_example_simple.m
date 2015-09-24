function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletHeartRate;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    hr = BrickletHeartRate(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current heart rate (unit is bpm)
    heartRate = hr.getHeartRate();
    fprintf('Heart Rate: %i bpm\n', heartRate);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
