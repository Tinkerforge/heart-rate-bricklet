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
    procedure ReachedCB(sender: TBrickletHeartRate; const hrate: Word);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'abc'; { Change to your UID }

var
  e: TExample;

{ Callback for color threshold reached }
procedure TExample.ReachedCB(sender: TBrickletHeartRate; const hrate: word);
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

  { Get threshold callbacks with a debounce time of 10 seconds (10000ms) }
  hr.SetDebouncePeriod(10000);

  { Register threshold reached callback to procedure ReachedCB }
  hr.OnHeartRateReached := {$ifdef FPC}@{$endif}ReachedCB;

  { Configure threshold for heart rate values,
    Heart Rate  : greater than 70 beats per minute }
  hr.SetHeartRateCallbackThreshold('>', 50, 70);

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
