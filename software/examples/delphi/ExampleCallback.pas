program Example;

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
    procedure HeartRateCB(sender: TBrickletHeartRate;
                      const hrate: Word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'abc'; { Change to your UID }

var
  e: TExample;

{ Callback function for heart rate callback }
procedure TExample.HeartRateCB(sender: TBrickletHeartRate;
                           const hrate: Word);
begin
    WriteLn(Format('Heart Rate(bpm): %u', [hrate]));
    WriteLn('');
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

  { Set Period for heart rate callback to 1s (1000ms)
    Note: The callback is only called every second if the
          heart has changed since the last call! }
  hr.SetHeartRateCallbackPeriod(1000);

  { Register heart callback to procedure HeartRateCB }
  hr.OnHeartRate := {$ifdef FPC}@{$endif}HeartRateCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
