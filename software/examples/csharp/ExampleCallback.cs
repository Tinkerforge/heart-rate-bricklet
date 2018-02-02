using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Heart Rate Bricklet

	// Callback function for heart rate callback
	static void HeartRateCB(BrickletHeartRate sender, int heartRate)
	{
		Console.WriteLine("Heart Rate: " + heartRate + " bpm");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHeartRate hr = new BrickletHeartRate(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Register heart rate callback to function HeartRateCB
		hr.HeartRateCallback += HeartRateCB;

		// Set period for heart rate callback to 1s (1000ms)
		// Note: The heart rate callback is only called every second
		//       if the heart rate has changed since the last call!
		hr.SetHeartRateCallbackPeriod(1000);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
