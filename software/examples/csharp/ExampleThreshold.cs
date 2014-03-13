using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "abc"; // Change to your UID

	// Callback for color threshold reached
	static void ReachedCB(BrickletHeartRate sender, int hrate)
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

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		hr.SetDebouncePeriod(10000);

		// Register threshold reached callback to function ReachedCB
		hr.HeartRateReached += ReachedCB;

        // Configure threshold for heart rate values,
        // Heart Rate : greater than 70 beats per minute
		hr.SetHeartRateCallbackThreshold('>', 50, 70);

		System.Console.WriteLine("Press key to exit");
		System.Console.ReadKey();
		ipcon.Disconnect();
	}
}
