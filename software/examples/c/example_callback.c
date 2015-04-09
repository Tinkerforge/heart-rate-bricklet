#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_heart_rate.h"

#define HOST "localhost"
#define PORT 4223
#define UID "abc" // Change to your UID

// Callback for heart rate reached
void cb_heart_rate(uint16_t hrate, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Heart Rate(bpm) = %d.\n", hrate);
	printf("\n");
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

	// Set Period for heart rate callback to 1s (1000ms)
	// Note: The callback is only called every second if the 
	//       heart rate has changed since the last call!
	heart_rate_set_heart_rate_callback_period(&hr, 1000);

	// Register heart rate callback to function cb_heart_rate
	heart_rate_register_callback(&hr,
	                              HEART_RATE_CALLBACK_HEART_RATE, 
	                              (void *)cb_heart_rate,
	                              NULL);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
