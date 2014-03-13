Imports Tinkerforge

Module Example
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "abc" ' Change to your UID

    ' Callback for heart rate reached
    Sub ReachedCB(ByVal sender As BrickletHeartRate, ByVal hrate As Integer)
        
        System.Console.WriteLine("Heart Rate(bpm): " + hrate.ToString())
        System.Console.WriteLine("")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim hr As New BrickletHeartRate(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        hr.SetDebouncePeriod(10000)

        ' Register threshold reached callback to function ReachedCB
        AddHandler hr.HeartRateReached, AddressOf ReachedCB

        ' Configure threshold for heart rate values,
        ' Heart Rate  : greater than 170 beats per minute
        hr.SetHeartRateCallbackThreshold(">"C, 50, 70)

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadKey()
        ipcon.Disconnect()
    End Sub
End Module
