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

	hr.RegisterHeartRateCallback(func(heartRate uint16) {
		fmt.Printf("Heart Rate: %d bpm\n", heartRate)
	})

	// Set period for heart rate receiver to 1s (1000ms).
	// Note: The heart rate callback is only called every second
	//       if the heart rate has changed since the last call!
	hr.SetHeartRateCallbackPeriod(1000)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()
}
