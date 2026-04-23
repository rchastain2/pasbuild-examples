
program PlayMidi;
{$MODE objfpc}{$H+}
{$DEFINE demo}

uses
{$IFDEF unix}
  cThreads,
{$ENDIF}
  SysUtils,
  ptcCrt, { KeyPressed }
  PasFluidSynth;

procedure WaitForKeyPress;
begin
  WriteLn('Press a key...');
  while not KeyPressed do
  begin
    Sleep(500);
  end;
end;

const
  CFont ='SC-55 SoundFont v1.2b.sf2';
  CDemoFile = 'sarabande.mid';

var
  fluidsynth: TFluidSynth = nil;
  player: TFluidSynth.PFluidPlayer = nil;
  soundfontid: longint;
  filepath, fontpath: string;
  
begin
  SetHeapTraceOutput('heaptrc.log');
  
{$IFDEF demo}
  filepath := ExtractFilePath(ParamStr(0)) + CDemoFile;
{$ELSE}
  filepath := ParamStr(1);
{$ENDIF}
  
  if not FileExists(filepath) then
  begin
    WriteLn('Usage: ', ParamStr(0), ' MIDI_FILE');
    Exit;
  end;
  
  WriteLn('[INFO] File: ', filepath);
  
  fontpath := ExtractFilePath(ParamStr(0)) + CFont;
  
  fluidsynth := TFluidSynth.Create();
  try
    WriteLn('[DEBUG] ', fluidsynth.status);
    if not fluidsynth.isLoaded then
      Exit;
    with fluidsynth do
    begin
      settings := new_fluid_settings();
      synth := new_fluid_synth(settings);
      soundfontid := fluid_synth_sfload(synth, pchar(fontpath), 1);
      audioDriver := new_fluid_audio_driver(settings, synth);
      player := new_fluid_player(synth);
      fluid_player_add(player, pchar(filepath));
      fluid_player_play(player);
    end;
    // Let the user listen to the song! Maybe wait for a keypress to exit.
    WaitForKeyPress;
  finally
    fluidsynth.Destroy;
  end;
end.
