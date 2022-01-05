{$R-}
unit crt32;

{# freeware}
{# version 1.0.0127}
{# Date 18.01.1997}
{# Author Frank Zimmer}
{# description
 CopyRight © 1997, Frank Zimmer, 100703.1602@compuserve.com
 Fixes CopyRight © 2001 Juancarlo Añez, juanco@suigeneris.org
 Version: 1.0.0119
 Date:    18.01.1997

 an Implementation of Turbo Pascal CRT-Unit for Win32 Console Subsystem
 tested with Windows NT 4.0
 At Startup you get the Focus to the Console!!!!

 ( with * are not in the original Crt-Unit):
 Procedure and Function:
   ClrScr
   ClrEol
   WhereX
   WhereY
   GotoXY
   InsLine
   DelLine
   HighVideo
   LowVideo
   NormVideo
   TextBackground
   TextColor
   Delay             // use no processtime
   KeyPressed
   ReadKey           // use no processtime
   Sound             // with Windows NT your could use the Variables SoundFrequenz, SoundDuration
   NoSound
   *TextAttribut     // Set TextBackground and TextColor at the same time, usefull for Lastmode
   *FlushInputBuffer // Flush the Keyboard and all other Events
   *ConsoleEnd       // output of 'Press any key' and wait for key input when not pipe
   *Pipe             // True when the output is redirected to a pipe or a file

 Variables:
   WindMin           // the min. WindowRect
   WindMax           // the max. WindowRect
   *ViewMax          // the max. ConsoleBuffer start at (1,1);
   TextAttr          // Actual Attributes only by changing with this Routines
   LastMode          // Last Attributes only by changing with this Routines
   *SoundFrequenz    // with Windows NT your could use these Variables
   *SoundDuration    // how long bells the speaker  -1 until ??, default = -1
   *HConsoleInput    // the Input-handle;
   *HConsoleOutput   // the Output-handle;
   *HConsoleError    // the Error-handle;

 This Source is freeware, have fun :-)

 History
   18.01.97   the first implementation
   23.01.97   Sound, delay, Codepage inserted and setfocus to the console
   24.01.97   Redirected status
}

interface

uses
  Windows, Messages;

{$IFDEF win32}

type
  Registers = record
    ax: LongWord;
    bx: LongWord;
    cx: LongWord;
    dx: LongWord;
  end;

const
  Intense = FOREGROUND_INTENSITY or BACKGROUND_INTENSITY;
  Black = 0;
  Blue = FOREGROUND_BLUE or BACKGROUND_BLUE;
  Green = FOREGROUND_GREEN or BACKGROUND_GREEN;
  Cyan = Blue and Green;
  Red = FOREGROUND_RED or BACKGROUND_RED;
  Magenta = Blue or Red;
  Brown = Green or Red;
  LightGray = Blue or Green or Red;
  DarkGray = LightGray;
  LightBlue = Blue or Intense;
  LightGreen = Green or Intense;
  LightCyan = Cyan or Intense;
  LightRed = Red or Intense;
  LightMagenta = Magenta or Intense;
  Yellow = Brown or Intense;
  White = LightGray or Intense;
  Blink = 0;

  BackgroundMask = BACKGROUND_BLUE or BACKGROUND_GREEN or BACKGROUND_RED or BACKGROUND_INTENSITY;
  ForegroundMask = FOREGROUND_BLUE or FOREGROUND_GREEN or FOREGROUND_RED or FOREGROUND_INTENSITY;

function WhereX: Integer;
function WhereY: Integer;
procedure ClrEol;
procedure ClrScr;
procedure InsLine;
procedure DelLine;
procedure GotoXY(const x, y: Integer);
procedure HighVideo;
procedure LowVideo;
procedure NormVideo;
procedure TextBackground(const Color: Word);
procedure TextColor(const Color: Word);
procedure TextAttribut(const Color, Background: Word);
procedure Delay(const ms: Integer);
function KeyPressed: Boolean;
function ReadKey: Char;
procedure Sound;
procedure NoSound;
procedure ConsoleEnd;
procedure FlushInputBuffer;
function Pipe: Boolean;

procedure Restore;

procedure SetWindowTo(R: TSmallRect);

procedure More(const Text: string);

procedure intr(Addr: Word; regs: Registers);

procedure OutTextXY(x, y: Integer; s: string);
function TextWidth(Text: string): Integer;
function TextHeight(Text: string): Integer;

procedure SetColor(const Color: Word);

var
  HConsoleInput: THandle;
  HConsoleOutput: THandle;
  HConsoleError: THandle;
  WindMin: TCoord;
  WindMax: TCoord;
  ViewMax: TCoord;
  TextAttr: Word;
  LastMode: Word;
  SoundFrequenz: Integer;
  SoundDuration: Integer;

type
  PD3InputRecord = ^TD3InputRecord;
  TD3InputRecord = record
    EventType: Word;
    case Integer of
      0: (KeyEvent: TKeyEventRecord);
      1: (MouseEvent: TMouseEventRecord);
      2: (WindowBufferSizeEvent: TWindowBufferSizeRecord);
      3: (MenuEvent: TMenuEventRecord);
      4: (FocusEvent: TFocusEventRecord);
  end;

  {$ENDIF win32}

implementation

{$IFDEF win32}

uses
  Classes, SysUtils;

var
  StartAttr: Word;
  OldCP: Integer;
  CrtPipe: Boolean;
  German: Boolean;

procedure ClrEol;
var
  tC: TCoord;
  Len, Nw: LongWord;
  Cbi: TConsoleScreenBufferInfo;
begin
  GetConsoleScreenBufferInfo(HConsoleOutput, cbi);
  len := cbi.dwSize.X - cbi.dwCursorPosition.X;
  tC.X := cbi.dwCursorPosition.X;
  tC.Y := cbi.dwCursorPosition.Y;
  FillConsoleOutputAttribute(HConsoleOutput, TextAttr, len, tC, nw);
  FillConsoleOutputCharacter(HConsoleOutput, #32, len, tC, nw);
end;

procedure ClrScr;
var
  tC: TCoord;
  nw: LongWord;
  cbi: TConsoleScreenBufferInfo;
begin
  GetConsoleScreenBufferInfo(HConsoleOutput, cbi);
  tC.X := 0;
  tC.Y := 0;
  FillConsoleOutputAttribute(HConsoleOutput, TextAttr, cbi.dwSize.X * cbi.dwSize.Y, tC, nw);
  FillConsoleOutputCharacter(HConsoleOutput, #32, cbi.dwSize.X * cbi.dwSize.Y, tC, nw);
  SetConsoleCursorPosition(HConsoleOutput, tC);
end;

function WhereX: Integer;
var
  cbi: TConsoleScreenBufferInfo;
begin
  GetConsoleScreenBufferInfo(HConsoleOutput, cbi);
  result := TCoord(cbi.dwCursorPosition).X + 1
end;

function WhereY: Integer;
var
  cbi: TConsoleScreenBufferInfo;
begin
  GetConsoleScreenBufferInfo(HConsoleOutput, cbi);
  result := TCoord(cbi.dwCursorPosition).Y + 1
end;

procedure GotoXY(const x, y: Integer);
var
  Coord: TCoord;
begin
  Coord.X := x - 1;
  Coord.Y := y - 1;
  SetConsoleCursorPosition(HConsoleOutput, Coord);
end;

procedure InsLine;
var
  cbi: TConsoleScreenBufferInfo;
  ssr: tsmallrect;
  Coord: TCoord;
  ci: tcharinfo;
  nw: LongWord;
begin
  GetConsoleScreenBufferInfo(HConsoleOutput, cbi);
  Coord := cbi.dwCursorPosition;
  ssr.Left := 0;
  ssr.Top := Coord.Y;
  ssr.Right := cbi.srWindow.Right;
  ssr.Bottom := cbi.srWindow.Bottom;
  ci.AsciiChar := #32;
  ci.Attributes := cbi.wAttributes;
  Coord.X := 0;
  Coord.Y := Coord.Y + 1;
  ScrollConsoleScreenBuffer(HConsoleOutput, ssr, nil, Coord, ci);
  Coord.Y := Coord.Y - 1;
  FillConsoleOutputAttribute(HConsoleOutput, TextAttr, cbi.dwSize.X * cbi.dwSize.Y, Coord, nw);
end;

procedure DelLine;
var
  cbi: TConsoleScreenBufferInfo;
  ssr: tsmallrect;
  Coord: TCoord;
  ci: tcharinfo;
  nw: LongWord;
begin
  GetConsoleScreenBufferInfo(HConsoleOutput, cbi);
  Coord := cbi.dwCursorPosition;
  ssr.Left := 0;
  ssr.Top := Coord.Y + 1;
  ssr.Right := cbi.srWindow.Right;
  ssr.Bottom := cbi.srWindow.Bottom;
  ci.AsciiChar := #32;
  ci.Attributes := cbi.wAttributes;
  Coord.X := 0;
  Coord.Y := Coord.Y;
  ScrollConsoleScreenBuffer(HConsoleOutput, ssr, nil, Coord, ci);
  FillConsoleOutputAttribute(HConsoleOutput, TextAttr, cbi.dwSize.X * cbi.dwSize.Y, Coord, nw);
end;

procedure TextBackground(const Color: Word);
begin
  LastMode := TextAttr;
  TextAttr := Color and BackgroundMask;
  SetConsoleTextAttribute(HConsoleOutput, TextAttr);
end;

procedure TextColor(const Color: Word);
begin
  LastMode := TextAttr;
  TextAttr := Color and ForegroundMask;
  SetConsoleTextAttribute(HConsoleOutput, TextAttr);
end;

procedure TextAttribut(const Color, Background: Word);
begin
  LastMode := TextAttr;
  TextAttr := (color and ForegroundMask) or (Background and BackgroundMask);
  SetConsoleTextAttribute(HConsoleOutput, TextAttr);
end;

procedure Restore;
begin
  SetConsoleTextAttribute(HConsoleOutput, LastMode);
  TextAttr := LastMode;
end;

procedure HighVideo;
begin
  LastMode := TextAttr;
  TextAttr := TextAttr or $8;
  SetConsoleTextAttribute(HConsoleOutput, TextAttr);
end;

procedure LowVideo;
begin
  LastMode := TextAttr;
  TextAttr := TextAttr and $F7;
  SetConsoleTextAttribute(HConsoleOutput, TextAttr);
end;

procedure NormVideo;
begin
  LastMode := TextAttr;
  TextAttr := startAttr;
  SetConsoleTextAttribute(HConsoleOutput, TextAttr);
end;

procedure FlushInputBuffer;
begin
  FlushConsoleInputBuffer(hconsoleinput)
end;

function KeyPressed: Boolean;
var
  InputRec: array[1..32] of TInputRecord;
  i,
    NumRead: LongWord;
  NEvents: DWORD;
begin
  Result := False;
  if GetNumberOfConsoleInputEvents(HConsoleInput, NEvents)
    and (NEvents > 0)
    and PeekConsoleInput(HConsoleInput, InputRec[1], 32, NumRead)
    and (NumRead > 0) then
    for i := 1 to NumRead do
      if (InputRec[i].EventType = KEY_EVENT)
        and (PD3InputRecord(@InputRec[i]).KeyEvent.bKeyDown) then
      begin
        Result := True;
        Exit
      end
end;

function ReadKey: Char;
var
  NumRead: DWORD;
  InputRec: TInputRecord;
begin
  while not ReadConsoleInput(HConsoleInput, InputRec, 1, NumRead)
    or (InputRec.EventType <> KEY_EVENT)
    or (not PD3InputRecord(@InputRec).KeyEvent.bKeyDown) do
  begin
  end;
  Result := PD3InputRecord(@InputRec).KeyEvent.AsciiChar
end;

procedure delay(const ms: Integer);
begin
  sleep(ms);
end;

procedure Sound;
begin
  windows.beep(SoundFrequenz, soundduration);
end;

procedure NoSound;
begin
  windows.beep(soundfrequenz, 0);
end;

procedure ConsoleEnd;
begin
  if isconsole and not CrtPipe then
  begin
    if wherex > 1 then
      writeln;
    textcolor(green);
    setfocus(GetCurrentProcess);
    if german then
      write('Bitte eine Taste drücken!')
    else
      write('Press any key!');
    normvideo;
    FlushInputBuffer;
    ReadKey;
    FlushInputBuffer;
  end;
end;

function Pipe: Boolean;
begin
  result := CrtPipe;
end;

procedure Init;
var
  cbi: TConsoleScreenBufferInfo;
  tC: TCoord;
begin
  SetActiveWindow(0);
  HConsoleInput := GetStdHandle(STD_InPUT_HANDLE);

  if (HConsoleInput = INVALID_HANDLE_VALUE) or (HConsoleInput = 0) then
  begin
    AllocConsole;
    HConsoleInput := GetStdHandle(STD_InPUT_HANDLE);
  end;

  HConsoleOutput := GetStdHandle(STD_OUTPUT_HANDLE);
  HConsoleError := GetStdHandle(STD_Error_HANDLE);

  if GetConsoleScreenBufferInfo(HConsoleOutput, cbi) then
  begin
    TextAttr := cbi.wAttributes;
    StartAttr := cbi.wAttributes;
    lastmode := cbi.wAttributes;
    tC.X := cbi.srWindow.Left + 1;
    tC.Y := cbi.srWindow.Top + 1;
    windmin := tC;
    ViewMax := cbi.dwSize;
    tC.X := cbi.srWindow.Right + 1;
    tC.Y := cbi.srWindow.Bottom + 1;
    windmax := tC;
    CrtPipe := False;
  end
  else
    CrtPipe := True;

  SoundFrequenz := 1000;
  SoundDuration := -1;
  OldCP := GetConsoleoutputCP;
  //SetConsoleoutputCP(1252);
  german := $07 = (LoWord(GetUserDefaultLangID) and $3FF);
end;

procedure SetWindowTo(R: TSmallRect);
begin
  SetConsoleWindowInfo(HConsoleOutput, True, R)
end;

procedure More(const Text: string);
var
  S: TStrings;
  i: Integer;
begin
  S := TStringList.Create;
  try
    S.Text := Text;
    i := 0;
    while i < S.Count do
    begin
      if (Pos('---', S[i]) <> 1) then
      begin
        Writeln(S[i]);
        Inc(i);
      end
      else
      begin
        Write(Format('-- More (%d%%) --'#13, [100 * (i + 2) div S.Count]));
        Inc(i);
        repeat until ReadKey in [' ', #13, #10, 'q'];
        Writeln(#13' ': 70);
      end;
    end;
  finally
    S.Free;
  end;
end;

procedure intr(Addr: Word; regs: Registers);
begin
end;

procedure OutTextXY(x, y: Integer; s: string);
begin
  GotoXY(x, y);
  Write(s);
end;

function TextWidth(Text: string): Integer;
begin
  Result := Length(Text);
end;

function TextHeight(Text: string): Integer;
begin
  Result := 1;
end;

procedure SetColor(const Color: Word);
begin
  TextColor(Color);
end;

initialization
  Init;

finalization
  SetConsoleoutputCP(OldCP);

  {$ENDIF win32}
end.

