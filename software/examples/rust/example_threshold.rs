use std::{error::Error, io, thread};
use tinkerforge::{heart_rate_bricklet::*, ipconnection::IpConnection};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Heart Rate Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let heart_rate_bricklet = HeartRateBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    // Get threshold listeners with a debounce time of 10 seconds (10000ms)
    heart_rate_bricklet.set_debounce_period(10000);

    //Create listener for heart rate reached events.
    let heart_rate_reached_listener = heart_rate_bricklet.get_heart_rate_reached_receiver();
    // Spawn thread to handle received events. This thread ends when the heart_rate_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in heart_rate_reached_listener {
            println!("Heart Rate: {}{}", event, " bpm");
        }
    });

    // Configure threshold for heart rate "greater than 100 bpm"
    heart_rate_bricklet.set_heart_rate_callback_threshold('>', 100, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
