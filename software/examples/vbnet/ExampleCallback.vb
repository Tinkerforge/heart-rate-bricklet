Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for heart rate callback (parameter has unit bpm)
    Sub HeartRateCB(ByVal sender As BrickletHeartRate, ByVal heartRate As Integer)
        System.Console.WriteLine("Heart Rate: " + heartRate.ToString() + " bpm")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim hr As New BrickletHeartRate(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set period for heart rate callback to 1s (1000ms)
        ' Note: The heart rate callback is only called every second
        '       if the heart rate has changed since the last call!
        hr.SetHeartRateCallbackPeriod(1000)

        ' Register heart rate callback to function HeartRateCB
        AddHandler hr.HeartRate, AddressOf HeartRateCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
