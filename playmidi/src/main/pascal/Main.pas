
program PlayMidi;
{$MODE objfpc}{$H+}

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

var
  fluidsynth: TFluidSynth = nil;
  player: TFluidSynth.PFluidPlayer = nil;
  soundfontid: longint;
  filepath, fontpath: string;
  
begin
  SetHeapTraceOutput('heaptrc.log');
  
  if FileExists(ParamStr(1)) and (ExtractFileExt(ParamStr(1)) = '.mid') then
  begin
    filepath := ParamStr(1);
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
  end else
    WriteLn('Usage: ', ParamStr(0), ' MIDI_FILE');
end.
