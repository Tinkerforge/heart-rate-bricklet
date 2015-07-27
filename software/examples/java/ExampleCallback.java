import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletHeartRate;

public class ExampleCallback {
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

		// Set period for heart rate callback to 1s (1000ms)
		// Note: The heart rate callback is only called every second
		//       if the heart rate has changed since the last call!
		hr.setHeartRateCallbackPeriod(1000);

		// Add heart rate listener (parameter has unit bpm)
		hr.addHeartRateListener(new BrickletHeartRate.HeartRateListener() {
			public void heartRate(int heartRate) {
				System.out.println("Heart Rate: " + heartRate + " bpm");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
