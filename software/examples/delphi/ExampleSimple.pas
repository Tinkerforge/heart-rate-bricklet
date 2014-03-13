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
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'abc'; { Change to your UID }

var
  e: TExample;

procedure TExample.Execute;
var hrate: word;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  hr := TBrickletHeartRate.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Get current heart rate (in beats per minute) }
  hrate := hr.GetHeartRate;
  WriteLn(Format('Heart Rate(bpm): %d', [hrate]));

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
