using Tinkerforge;

class Example
{
    private static string HOST = "localhost";
    private static int PORT = 4223;
    private static string UID = "abc"; // Change to your UID

    static void Main() 
    {
        IPConnection ipcon = new Tinkerforge.IPConnection(); // Create IP connection
        BrickletHeartRate hr = new Tinkerforge.BrickletHeartRate(UID, ipcon); // Create device object

        ipcon.Connect(HOST, PORT); // Connect to brickd
        // Don't use device before ipcon is connected

        // Get current heart rate (in beats per minute)
        int hrate = hr.GetHeartRate();;

        System.Console.WriteLine("Heart Rate(bpm): " + hrate);
        System.Console.WriteLine("");

        System.Console.WriteLine("Press key to exit");
        System.Console.ReadKey();
        ipcon.Disconnect();
    }
}
