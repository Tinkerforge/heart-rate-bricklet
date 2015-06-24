#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_heart_rate.h"

#define HOST "localhost"
#define PORT 4223
#define UID "abc" // Change to your UID

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

	// Get current heart rate in beats per minute
	uint16_t hrate;
    if(heart_rate_get_heart_rate(&hr, &hrate) < 0) {
		fprintf(stderr, "Could not get value, probably timeout\n");
		exit(1);
	}

	printf("Heart Rate: %d bpm\n", hrate);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
