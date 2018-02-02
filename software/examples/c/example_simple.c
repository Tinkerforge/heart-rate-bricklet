#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_heart_rate.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change XYZ to the UID of your Heart Rate Bricklet

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

	// Get current heart rate
	uint16_t heart_rate;
	if(heart_rate_get_heart_rate(&hr, &heart_rate) < 0) {
		fprintf(stderr, "Could not get heart rate, probably timeout\n");
		return 1;
	}

	printf("Heart Rate: %u bpm\n", heart_rate);

	printf("Press key to exit\n");
	getchar();
	heart_rate_destroy(&hr);
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
