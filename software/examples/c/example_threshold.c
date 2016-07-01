#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_heart_rate.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change XYZ to the UID of your Heart Rate Bricklet

// Callback function for heart rate reached callback (parameter has unit bpm)
void cb_heart_rate_reached(uint16_t heart_rate, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Heart Rate: %d bpm\n", heart_rate);
}

int main(void) {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	HeartRate hr;
	heart_rate_create(&hr, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		return 1;
	}
	// Don't use device before ipcon is connected

	// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
	heart_rate_set_debounce_period(&hr, 10000);

	// Register heart rate reached callback to function cb_heart_rate_reached
	heart_rate_register_callback(&hr,
	                             HEART_RATE_CALLBACK_HEART_RATE_REACHED,
	                             (void *)cb_heart_rate_reached,
	                             NULL);

	// Configure threshold for heart rate "greater than 100 bpm" (unit is bpm)
	heart_rate_set_heart_rate_callback_threshold(&hr, '>', 100, 0);

	printf("Press key to exit\n");
	getchar();
	heart_rate_destroy(&hr);
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
