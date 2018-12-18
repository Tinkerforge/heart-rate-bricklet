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

	// Get current heart rate.
	heartRate, _ := hr.GetHeartRate()
	fmt.Printf("Heart Rate:  bpm\n", heartRate)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
