use std::{error::Error, io, thread};
use tinkerforge::{heart_rate_bricklet::*, ip_connection::IpConnection};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Heart Rate Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let hr = HeartRateBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    let heart_rate_receiver = hr.get_heart_rate_callback_receiver();

    // Spawn thread to handle received callback messages.
    // This thread ends when the `hr` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for heart_rate in heart_rate_receiver {
            println!("Heart Rate: {} bpm", heart_rate);
        }
    });

    // Set period for heart rate receiver to 1s (1000ms).
    // Note: The heart rate callback is only called every second
    //       if the heart rate has changed since the last call!
    hr.set_heart_rate_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
