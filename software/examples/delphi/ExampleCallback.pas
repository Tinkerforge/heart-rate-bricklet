program ExampleCallback;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletHeartRate;

type
  TExample = class
  private
    ipcon: TIPConnection;
    hr: TBrickletHeartRate;
  public
    procedure HeartRateCB(sender: TBrickletHeartRate; const heartRate: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change XYZ to the UID of your Heart Rate Bricklet }

var
  e: TExample;

{ Callback procedure for heart rate callback }
procedure TExample.HeartRateCB(sender: TBrickletHeartRate; const heartRate: word);
begin
  WriteLn(Format('Heart Rate: %d bpm', [heartRate]));
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  hr := TBrickletHeartRate.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Register heart rate callback to procedure HeartRateCB }
  hr.OnHeartRate := {$ifdef FPC}@{$endif}HeartRateCB;

  { Set period for heart rate callback to 1s (1000ms)
    Note: The heart rate callback is only called every second
          if the heart rate has changed since the last call! }
  hr.SetHeartRateCallbackPeriod(1000);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
