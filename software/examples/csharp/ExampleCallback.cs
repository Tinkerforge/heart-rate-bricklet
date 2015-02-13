using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "abc"; // Change to your UID

	// Callback function for heart rate callback
	static void HeartRateCB(BrickletHeartRate sender, int hrate)
	{
        System.Console.WriteLine("Heart Rate(bpm): " + hrate);
        System.Console.WriteLine("");
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHeartRate hr = new BrickletHeartRate(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set Period for heart rate callback to 1s (1000ms)
		// Note: The heart rate callback is only called every second if the 
		//       heart rate has changed since the last call!
		hr.SetHeartRateCallbackPeriod(1000);

		// Register heart rate callback to function HeartRateCB
		hr.HeartRate += HeartRateCB;

		System.Console.WriteLine("Press key to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
