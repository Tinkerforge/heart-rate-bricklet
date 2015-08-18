Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for heart rate greater than 100 bpm (parameter has unit bpm)
    Sub HeartRateReachedCB(ByVal sender As BrickletHeartRate, ByVal heartRate As Integer)
        System.Console.WriteLine("Heart Rate: " + heartRate.ToString() + " bpm")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim hr As New BrickletHeartRate(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        hr.SetDebouncePeriod(10000)

        ' Register threshold reached callback to function HeartRateReachedCB
        AddHandler hr.HeartRateReached, AddressOf HeartRateReachedCB

        ' Configure threshold for "greater than 100 bpm" (unit is bpm)
        hr.SetHeartRateCallbackThreshold(">"C, 100, 0)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
