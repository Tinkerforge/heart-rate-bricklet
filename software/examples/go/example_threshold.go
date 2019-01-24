package main

import (
	"fmt"
	"github.com/Tinkerforge/go-api-bindings/heart_rate_bricklet"
	"github.com/Tinkerforge/go-api-bindings/ipconnection"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Heart Rate Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	hr, _ := heart_rate_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Get threshold receivers with a debounce time of 10 seconds (10000ms).
	hr.SetDebouncePeriod(10000)

	hr.RegisterHeartRateReachedCallback(func(heartRate uint16) {
		fmt.Printf("Heart Rate: %d bpm\n", heartRate)
	})

	// Configure threshold for heart rate "greater than 100 bpm".
	hr.SetHeartRateCallbackThreshold('>', 100, 0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()
}
