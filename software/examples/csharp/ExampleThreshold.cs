using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for heart rate reached callback (parameter has unit bpm)
	static void HeartRateReachedCB(BrickletHeartRate sender, int heartRate)
	{
		Console.WriteLine("Heart Rate: " + heartRate + " bpm");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHeartRate hr = new BrickletHeartRate(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		hr.SetDebouncePeriod(10000);

		// Register heart rate reached callback to function HeartRateReachedCB
		hr.HeartRateReached += HeartRateReachedCB;

		// Configure threshold for heart rate "greater than 100 bpm" (unit is bpm)
		hr.SetHeartRateCallbackThreshold('>', 100, 0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
