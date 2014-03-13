import com.tinkerforge.BrickletHeartRate;
import com.tinkerforge.IPConnection;

public class ExampleSimple {
    private static final String host = "localhost";
    private static final int port = 4223;
    private static final String UID = "abc"; // Change to your UID
    
    // Note: To make the example code cleaner we do not handle exceptions. Exceptions you
    //       might normally want to catch are described in the documentation
    public static void main(String args[]) throws Exception {
        IPConnection ipcon = new IPConnection(); // Create IP connection
        BrickletHeartRate hr = new BrickletHeartRate(UID, ipcon); // Create device object

        ipcon.connect(host, port); // Connect to brickd
        // Don't use device before ipcon is connected

        // Get current heart rate (in beats per minute)
        int hrate = hr.getHeartRate(); // Can throw com.tinkerforge.TimeoutException

        System.out.println("Heart Rate(bpm): " + hrate);
        System.out.println("");
        
        System.console().readLine("Press key to exit\n");
        ipcon.disconnect();
    }
}
