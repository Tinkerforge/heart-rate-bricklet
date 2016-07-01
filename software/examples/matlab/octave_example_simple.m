function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Heart Rate Bricklet

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    hr = java_new("com.tinkerforge.BrickletHeartRate", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current heart rate (unit is bpm)
    heartRate = hr.getHeartRate();
    fprintf("Heart Rate: %d bpm\n", heartRate);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end
