import com.tinkerforge.BrickletHeartRate;
import com.tinkerforge.IPConnection;

public class ExampleThreshold {
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

        // Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        hr.setDebouncePeriod(10000);

        // Add and implement heart rate reached listener 
        // Configure threshold for heart rate values,
        // Heart Rate(in beats per minute)  : greater than 70
        hr.setHeartRateCallbackThreshold('>', (int)(50), (int)(70));

        hr.addHeartRateReachedListener(new BrickletHeartRate.HeartRateReachedListener() {
            public void heartRateReached(int hrate) {
                System.out.println("Heart Rate(bpm): " + hrate);
                System.out.println("");
            }
        });

        System.console().readLine("Press key to exit\n");
        ipcon.disconnect();
    }
}
