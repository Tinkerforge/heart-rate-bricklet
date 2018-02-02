Imports System
Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Heart Rate Bricklet

    ' Callback subroutine for heart rate reached callback
    Sub HeartRateReachedCB(ByVal sender As BrickletHeartRate, _
                           ByVal heartRate As Integer)
        Console.WriteLine("Heart Rate: " + heartRate.ToString() + " bpm")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim hr As New BrickletHeartRate(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        hr.SetDebouncePeriod(10000)

        ' Register heart rate reached callback to subroutine HeartRateReachedCB
        AddHandler hr.HeartRateReachedCallback, AddressOf HeartRateReachedCB

        ' Configure threshold for heart_rate "greater than 100 bpm"
        hr.SetHeartRateCallbackThreshold(">"C, 100, 0)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
