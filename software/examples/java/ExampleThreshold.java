import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletHeartRate;

public class ExampleThreshold {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletHeartRate hr = new BrickletHeartRate(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		hr.setDebouncePeriod(10000);

		// Configure threshold for "greater than 100 bpm" (unit is bpm)
		hr.setHeartRateCallbackThreshold('>', 100, 0);

		// Add threshold reached listener for heart rate greater than 100 bpm (parameter has unit bpm)
		hr.addHeartRateReachedListener(new BrickletHeartRate.HeartRateReachedListener() {
			public void heartRateReached(int heartRate) {
				System.out.println("Heart Rate: " + heartRate + " bpm");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
