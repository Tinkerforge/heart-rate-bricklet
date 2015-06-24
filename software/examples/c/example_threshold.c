#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_heart_rate.h"

#define HOST "localhost"
#define PORT 4223
#define UID "abc" // Change to your UID

// Callback for heart rate reached
void cb_reached(uint16_t hrate, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Heart Rate: %d bpm\n", hrate);
}

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	HeartRate hr;
	heart_rate_create(&hr, UID, &ipcon); 

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected
	
	// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
	heart_rate_set_debounce_period(&hr, 10000);

	// Register threshold reached callback to function cb_reached
	heart_rate_register_callback(&hr,
	                             HEART_RATE_CALLBACK_HEART_RATE_REACHED,
	                             (void *)cb_reached,
	                             NULL);

	// Configure threshold for heart rate to be greater than 70 beats per minute
	heart_rate_set_heart_rate_callback_threshold(&hr, '>', 50, 70);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
