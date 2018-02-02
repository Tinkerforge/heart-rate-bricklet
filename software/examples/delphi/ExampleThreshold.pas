program ExampleThreshold;

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
    procedure HeartRateReachedCB(sender: TBrickletHeartRate; const heartRate: word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change XYZ to the UID of your Heart Rate Bricklet }

var
  e: TExample;

{ Callback procedure for heart rate reached callback }
procedure TExample.HeartRateReachedCB(sender: TBrickletHeartRate; const heartRate: word);
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

  { Get threshold callbacks with a debounce time of 10 seconds (10000ms) }
  hr.SetDebouncePeriod(10000);

  { Register heart rate reached callback to procedure HeartRateReachedCB }
  hr.OnHeartRateReached := {$ifdef FPC}@{$endif}HeartRateReachedCB;

  { Configure threshold for heart rate "greater than 100 bpm" }
  hr.SetHeartRateCallbackThreshold('>', 100, 0);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
