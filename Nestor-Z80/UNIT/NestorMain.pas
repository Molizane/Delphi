unit NestorMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ExtCtrls, StdCtrls, StdActns, ActnList, ImgList, ComCtrls,
  ToolWin, Menus, ValEdit, Buttons, DBTables, EngineZ80, MemoryZ80, BSLed,
  LEDDisplay;

type
  TFrmMain = class(TForm)
    MainMenu1: TMainMenu;
    Help1: TMenuItem;
    About1: TMenuItem;
    ImageList1: TImageList;
    ActionList1: TActionList;
    File1: TMenuItem;
    Panel1: TPanel;
    Step: TAction;
    Run: TAction;
    Reset: TAction;
    Open: TAction;
    New: TAction;
    Open1: TMenuItem;
    New1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Timer: TTimer;
    Pause: TAction;
    GroupBox2: TGroupBox;
    btnNMI: TSpeedButton;
    btnINT: TSpeedButton;
    Help: TAction;
    Keyboard_: TPanel;
    btn0: TSpeedButton;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    btn4: TSpeedButton;
    btn5: TSpeedButton;
    btn6: TSpeedButton;
    btn7: TSpeedButton;
    btn8: TSpeedButton;
    btn9: TSpeedButton;
    btnA: TSpeedButton;
    btnB: TSpeedButton;
    btnC: TSpeedButton;
    btnD: TSpeedButton;
    btnE: TSpeedButton;
    btnF: TSpeedButton;
    btnMais1: TSpeedButton;
    btnMenos1: TSpeedButton;
    btnP: TSpeedButton;
    btnL: TSpeedButton;
    btnR: TSpeedButton;
    btnER: TSpeedButton;
    btnIV: TSpeedButton;
    btnLivre: TSpeedButton;
    Panel2: TPanel;
    Panel3: TPanel;
    PS0: TBSLed;
    PS1: TBSLed;
    PS2: TBSLed;
    PS3: TBSLed;
    PS4: TBSLed;
    PS5: TBSLed;
    PS6: TBSLed;
    PS7: TBSLed;
    Disassembler: TEdit;
    ImageList2: TImageList;
    Halt: TAction;
    pnlStatus: TPanel;
    LEDHalt: TBSLed;
    lblHalt: TLabel;
    LEDReset: TBSLed;
    lblReset: TLabel;
    Display1: TLEDDisplay;
    Display2: TLEDDisplay;
    Display3: TLEDDisplay;
    Display4: TLEDDisplay;
    Display5: TLEDDisplay;
    Display6: TLEDDisplay;
    Panel4: TPanel;
    Panel5: TPanel;
    ToolBar2: TToolBar;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    Ver1: TMenuItem;
    opcRegistros: TMenuItem;
    opcFlags: TMenuItem;
    opcMemoria: TMenuItem;
    opcFontes: TMenuItem;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    opcBreakpoints: TMenuItem;
    Settings: TAction;
    DisplayHexa: TCheckBox;
    opcTerminal: TMenuItem;
    Panel6: TPanel;
    PE0: TCheckBox;
    PE1: TCheckBox;
    PE2: TCheckBox;
    PE3: TCheckBox;
    PE4: TCheckBox;
    PE5: TCheckBox;
    PE6: TCheckBox;
    PE7: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure StepExecute(Sender: TObject);
    procedure ResetExecute(Sender: TObject);
    procedure OpenExecute(Sender: TObject);
    procedure NewExecute(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure btnNMIClick(Sender: TObject);
    procedure btnINTClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure RunExecute(Sender: TObject);
    procedure PauseExecute(Sender: TObject);
    procedure AccExit(Sender: TObject);
    procedure HexClick(Sender: TObject);
    procedure HelpExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnMIClick(Sender: TObject);
    procedure HaltExecute(Sender: TObject);
    procedure HaltEvent(Sender: TObject);
    procedure ResetEvent(Sender: TObject);
    procedure StepEvent(Sender: TObject; IsRunning: Boolean);
    procedure StopEvent(Sender: TObject);
    procedure NMIEvent(Sender: TObject; IsRunning: Boolean);
    procedure Col0MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Col0MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Col1MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Col1MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Col2MouseDown(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure Col2MouseUp(Sender: TObject; Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer);
    procedure ResetLEDs;
    procedure opcRegistrosClick(Sender: TObject);
    procedure opcFlagsClick(Sender: TObject);
    procedure opcMemoriaClick(Sender: TObject);
    procedure opcFontesClick(Sender: TObject);
    procedure opcBreakpointsClick(Sender: TObject);
    procedure DisplayHexaClick(Sender: TObject);
    procedure opcTerminalClick(Sender: TObject);
  private
    Flags: TFlagsView;
    IO: TIOView;
    DispSetKbdGet: TPeripheral;
    DispKbdCol: TPeripheral;
    LEDsBuffer: Byte;
    LEDs: TPeripheral;
    Buttons: TPeripheral;
    Terminal: TPeripheral;
    TerminalCtrl: TPeripheral;
    KbdCol: Byte;
    KeyCol: array[1..3] of Byte;
    DispCol: array[1..6] of Boolean;
    DisplayChar: Char;
    fimROM: Word;
    procedure CPUShow;
    procedure WriteChar(Data: Byte);
    function ReadKeyCol: Byte;
    procedure SelectDispKbdCol(Data: Byte);
    procedure RefreshDisplay;
    procedure LEDsWrite(Data: Byte);
    function LEDsRead: Byte;
    function ButtonsRead: Byte;
    procedure LeHexNestorZ80;
    procedure BreakEvent(Sender: TObject; Address: Word; var Go: Boolean);
    procedure Cleardata;
    procedure PosDebug;
    procedure WriteTerminal(Data: Byte);
    function ReadTerminal: Byte;
    function ReadTerminalStatus: Byte;
  public
    CPU: TCPUZ80;
    Memory: TMemoryView;
    AsmFile, Compiler, Parameters: string;
  end;

var
  FrmMain: TFrmMain;
  ExePath: string;
  CompPath: string;

implementation

uses
  Math, StdConvs, XMLIni, StrUtils, HelpUnit, MI, NestorFlags, NestorBP,
  NestorRegistros, NestorTerminal, NestorFonte, Memory, NestorAS80;

{$R *.dfm}

const
  Display_DigitNum = 6;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  ReadConfig(AsmFile, ExePath, Compiler, Parameters);

  FrmFontes := TFrmFontes.Create(Self);

  FrmRegistros := TFrmRegistros.Create(Self);
  FrmRegistros.Show;

  FrmFlags := TFrmFlags.Create(Self);
  FrmFlags.Show;

  FrmTerminal := TFrmTerminal.Create(Self);

  FrmBreakPoints := TFrmBreakPoints.Create(Self);
  FrmBreakPoints.Show;

  FrmMemory := TFrmMemory.Create(Self);

  KeyCol[1] := 0;
  KeyCol[2] := 0;
  KeyCol[3] := 0;

  DispSetKbdGet := TPeripheral.Create;
  DispSetKbdGet.OnRead := ReadKeyCol;
  DispSetKbdGet.OnWrite := WriteChar;

  DispKbdCol := TPeripheral.Create;
  DispKbdCol.OnRead := nil;
  DispKbdCol.OnWrite := SelectDispKbdCol;

  DisplayChar := #0;
  SelectDispKbdCol($FF);
  WriteChar($FF);
  SelectDispKbdCol($00);

  LEDs := TPeripheral.Create;
  LEDs.OnRead := LEDsRead;
  LEDs.OnWrite := LEDsWrite;
  //LEDs.OnReset := ResetLEDs;

  ResetLEDs;

  Buttons := TPeripheral.Create;
  Buttons.OnRead := ButtonsRead;

  Terminal := TPeripheral.Create;
  Terminal.OnRead := ReadTerminal;
  Terminal.OnWrite := WriteTerminal;

  TerminalCtrl := TPeripheral.Create;
  TerminalCtrl.OnRead := ReadTerminalStatus;

  Memory := TMemoryView.Create(FrmMemory.MemGrid, True);
  Flags := TFlagsView.Create(FrmFlags.FGridFlags);

  //IO := IOView.Create(IOGrid, True);
  IO := TIOView.Create(nil, True);
  IO.AssignIOPort($01, DispSetKbdGet);
  IO.AssignIOPort($02, Buttons);
  IO.AssignIOPort($03, DispKbdCol);
  IO.AssignIOPort($04, LEDs);
  IO.AssignIOPort($60, Terminal);
  IO.AssignIOPort($61, TerminalCtrl);

  CPU := TCPUZ80.Create(Memory, IO);
  CPU.ExecMode := exMode1;
  CPU.OnHalt := HaltEvent;
  CPU.OnReset := ResetEvent;
  CPU.OnStep := StepEvent;
  CPU.OnStop := StopEvent;
  CPU.OnBreak := BreakEvent;
  CPU.OnNMI := NMIEvent;

  Run.Enabled := False;
  Step.Enabled := False;
  Reset.Enabled := False;
  Halt.Enabled := False;
  Pause.Enabled := False;

  LeHexNestorZ80;

  CPUShow;
  CPU.SP := MEM_SIZE;

  DisplayHexaClick(DisplayHexa);
end;

procedure TFrmMain.CPUShow;
var
  CPU_PC, CPU_SP: Word;
begin
  CPU_PC := CPU.PC;
  CPU_SP := CPU.SP;

  with FrmRegistros do
    if DisplayHexa.Checked then
    begin
      Acc.Text := IntToHex(CPU.A, 2);
      B.Text := IntToHex(CPU.B, 2);
      C.Text := IntToHex(CPU.C, 2);
      D.Text := IntToHex(CPU.D, 2);
      E.Text := IntToHex(CPU.E, 2);
      H.Text := IntToHex(CPU.H, 2);
      L.Text := IntToHex(CPU.L, 2);
      Acc2.Text := IntToHex(CPU.A2, 2);
      B2.Text := IntToHex(CPU.B2, 2);
      C2.Text := IntToHex(CPU.C2, 2);
      D2.Text := IntToHex(CPU.D2, 2);
      E2.Text := IntToHex(CPU.E2, 2);
      H2.Text := IntToHex(CPU.H2, 2);
      L2.Text := IntToHex(CPU.L2, 2);
      I.Text := IntToHex(CPU.I, 2);
      R.Text := IntToHex(CPU.R, 2);
      IX.Text := IntToHex(CPU.IX, 4);
      IY.Text := IntToHex(CPU.IY, 4);
      SP.Text := IntToHex(CPU_SP, 4);
      PC.Text := IntToHex(CPU_PC, 4);
    end
    else
    begin
      Acc.Text := Inttostr(CPU.A);
      B.Text := Inttostr(CPU.B);
      C.Text := Inttostr(CPU.C);
      D.Text := Inttostr(CPU.D);
      E.Text := Inttostr(CPU.E);
      H.Text := Inttostr(CPU.H);
      L.Text := Inttostr(CPU.L);
      Acc2.Text := Inttostr(CPU.A2);
      B2.Text := Inttostr(CPU.B2);
      C2.Text := Inttostr(CPU.C2);
      D2.Text := Inttostr(CPU.D2);
      E2.Text := Inttostr(CPU.E2);
      H2.Text := Inttostr(CPU.H2);
      L2.Text := Inttostr(CPU.L2);
      I.Text := Inttostr(CPU.I);
      R.Text := Inttostr(CPU.R);
      IX.Text := Inttostr(CPU.IX);
      IY.Text := Inttostr(CPU.IY);
      SP.Text := Inttostr(CPU_SP);
      PC.Text := Inttostr(CPU_PC);
    end;

  Flags.Refresh(CPU.S, CPU.Z, CPU.F5, CPU.HF, CPU.F3, CPU.PV, CPU.N, CPU.CY,
    CPU.SAlt, CPU.ZAlt, CPU.F5Alt, CPU.HFAlt, CPU.F3Alt, CPU.PVAlt, CPU.NAlt,
    CPU.CYAlt);

  {
  try
    Memory.HighLight(CPU_PC);
  except
  end;
  }

  Disassembler.Text := CPU.NextInstr;
end;

procedure TFrmMain.StepExecute(Sender: TObject);
begin
  CPU.Step;
end;

procedure TFrmMain.ResetExecute(Sender: TObject);
begin
  LEDReset.LightOn := True;
  Application.ProcessMessages;
  CPU.Reset;
end;

procedure TFrmMain.OpenExecute(Sender: TObject);
begin
  FrmFontes.Open.Execute;
end;

procedure TFrmMain.NewExecute(Sender: TObject);
begin
  FrmFontes.New.Execute;
end;

procedure TFrmMain.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.btnNMIClick(Sender: TObject);
begin
  CPU.NMI;
end;

procedure TFrmMain.btnINTClick(Sender: TObject);
var
  i: Integer;
begin
  FMI := TFMI.Create(nil);

  try
    i := FMI.ShowModal;
  finally
    FMI.Release;
  end;

  if i <> 255 then
    CPU.MI(i);
end;

procedure TFrmMain.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := not CPU.Stopped;

  if not Timer.Enabled then
  begin
    FrmFontes.Compile.Enabled := True;
    Run.Enabled := not CPU.Halted;
    Step.Enabled := Run.Enabled;
    Halt.Enabled := False;
    Pause.Enabled := False;
    CPUShow;
  end;
end;

procedure TFrmMain.RunExecute(Sender: TObject);
begin
  ClearData;
  FrmFontes.Compile.Enabled := False;
  Run.Enabled := False;
  Step.Enabled := False;
  Timer.Enabled := True;
  Pause.Enabled := True;
  Halt.Enabled := not CPU.Halted;
  CPU.Run;
end;

procedure TFrmMain.PauseExecute(Sender: TObject);
begin
  CPU.Stop;
  FrmFontes.Compile.Enabled := True;
  Run.Enabled := True;
  Step.Enabled := True;
  Pause.Enabled := False;
  CPUShow;
end;

procedure TFrmMain.AccExit(Sender: TObject);
var
  s: integer;
begin
  with FrmRegistros do
    if DisplayHexa.Checked then
    begin
      S := StrToInt('$' + (Sender as TEdit).Text);

      if Sender = Acc then
        CPU.A := S
      else if Sender = B then
        CPU.B := S
      else if Sender = C then
        CPU.C := S
      else if Sender = D then
        CPU.D := S
      else if Sender = E then
        CPU.E := S
      else if Sender = H then
        CPU.H := S
      else if Sender = L then
        CPU.L := S
      else if Sender = I then
        CPU.I := S
      else if Sender = R then
        CPU.R := S
      else if Sender = IX then
        CPU.IX := S
      else if Sender = IY then
        CPU.IY := S
      else if Sender = Acc2 then
        CPU.A2 := S
      else if Sender = B2 then
        CPU.B2 := S
      else if Sender = C2 then
        CPU.C2 := S
      else if Sender = D2 then
        CPU.D2 := S
      else if Sender = E2 then
        CPU.E2 := S
      else if Sender = H2 then
        CPU.H2 := S
      else if Sender = L2 then
        CPU.L2 := S
    end
    else
    begin
      if Sender = Acc then
        CPU.A := StrToInt(Acc.Text)
      else if Sender = B then
        CPU.B := StrToInt(B.Text)
      else if Sender = C then
        CPU.C := StrToInt(C.Text)
      else if Sender = D then
        CPU.D := StrToInt(D.Text)
      else if Sender = E then
        CPU.E := StrToInt(E.Text)
      else if Sender = H then
        CPU.H := StrToInt(H.Text)
      else if Sender = L then
        CPU.L := StrToInt(L.Text)
      else if Sender = I then
        CPU.I := StrToInt(I.Text)
      else if Sender = R then
        CPU.R := StrToInt(R.Text)
      else if Sender = IX then
        CPU.IX := StrToInt(IX.Text)
      else if Sender = IY then
        CPU.HIY := StrToInt(IY.Text)
      else if Sender = Acc2 then
        CPU.A2 := StrToInt(Acc2.Text)
      else if Sender = B2 then
        CPU.B2 := StrToInt(B2.Text)
      else if Sender = C2 then
        CPU.C2 := StrToInt(C2.Text)
      else if Sender = D2 then
        CPU.D2 := StrToInt(D2.Text)
      else if Sender = E2 then
        CPU.E2 := StrToInt(E2.Text)
      else if Sender = H2 then
        CPU.H2 := StrToInt(H2.Text)
      else if Sender = L2 then
        CPU.L2 := StrToInt(L2.Text)
    end;
end;

procedure TFrmMain.HexClick(Sender: TObject);
begin
  Memory.Show(DisplayHexa.Checked);
  IO.Show(DisplayHexa.Checked);
  CPUShow;
end;

procedure TFrmMain.HelpExecute(Sender: TObject);
var
  help: THelpForm;
begin
  Help := THelpForm.Create(self);

  try
    help.WebBrowser1.Navigate(ExePath + 'Help\index.html');
    Help.ShowModal;
  finally
    Help.Release;
  end;
end;

function TFrmMain.ReadKeyCol: Byte;
begin
  if (KbdCol > 0) and (KbdCol < 4) then
    Result := KeyCol[KbdCol]
  else
    Result := 0;
end;

procedure TFrmMain.WriteChar(Data: Byte);
begin
  DisplayChar := Chr(Data xor 255);
  RefreshDisplay;
end;

procedure TFrmMain.SelectDispKbdCol(Data: Byte);
begin
  case Data of
    1: KbdCol := 1;
    2: KbdCol := 2;
    4: KbdCol := 3;
    8: KbdCol := 4;
    16: KbdCol := 5;
    32: KbdCol := 6;
  end;

  DispCol[1] := Data and 1 = 1;
  DispCol[2] := Data and 2 = 2;
  DispCol[3] := Data and 4 = 4;
  DispCol[4] := Data and 8 = 8;
  DispCol[5] := Data and 16 = 16;
  DispCol[6] := Data and 32 = 32;
end;

procedure TFrmMain.RefreshDisplay;
begin
  if DispCol[1] then
    Display1.Value := Ord(DisplayChar);

  if DispCol[2] then
    Display2.Value := Ord(DisplayChar);

  if DispCol[3] then
    Display3.Value := Ord(DisplayChar);

  if DispCol[4] then
    Display4.Value := Ord(DisplayChar);

  if DispCol[5] then
    Display5.Value := Ord(DisplayChar);

  if DispCol[6] then
    Display6.Value := Ord(DisplayChar);

  Display1.Active := DispCol[1];
  Display2.Active := DispCol[2];
  Display3.Active := DispCol[3];
  Display4.Active := DispCol[4];
  Display5.Active := DispCol[5];
  Display6.Active := DispCol[6];
end;

function TFrmMain.LEDsRead: Byte;
begin
  Result := LEDsBuffer;
end;

procedure TFrmMain.LEDsWrite(Data: Byte);
begin
  LEDsBuffer := Data;
  PS0.LightOn := Data and 1 = 1;
  PS1.LightOn := Data and 2 = 2;
  PS2.LightOn := Data and 4 = 4;
  PS3.LightOn := Data and 8 = 8;
  PS4.LightOn := Data and 16 = 16;
  PS5.LightOn := Data and 32 = 32;
  PS6.LightOn := Data and 64 = 64;
  PS7.LightOn := Data and 128 = 128;
end;

procedure TFrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CPU.Stop;
  CPU.Terminate;
  FrmFontes.SaveAll;
end;

procedure TFrmMain.btnMIClick(Sender: TObject);
begin
  CPU.MI(0);
end;

procedure TFrmMain.HaltExecute(Sender: TObject);
begin
  if CPU.Halted then
    Exit;

  CPU.Halt;
  CPUShow;
end;

procedure TFrmMain.HaltEvent(Sender: TObject);
begin
  LEDHalt.LightOn := True;
  Halt.ImageIndex := 16;
  Pause.Enabled := False;
  Reset.Enabled := True;
  Halt.Enabled := False;
end;

procedure TFrmMain.ResetEvent(Sender: TObject);
begin
  LEDReset.LightOn := False;
  LEDHalt.LightOn := False;
  Halt.ImageIndex := 15;
  Halt.Enabled := not (CPU.Halted or CPU.Stopped);
  Pause.Enabled := not CPU.Stopped;
end;

procedure TFrmMain.StepEvent(Sender: TObject; IsRunning: Boolean);
begin
  if not IsRunning then
  begin
    CPUShow;
    PosDebug;
  end;
end;

procedure TFrmMain.Col0MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KeyCol[1] := KeyCol[1] or TSpeedButton(Sender).Tag;
end;

procedure TFrmMain.Col0MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KeyCol[1] := KeyCol[1] and (TSpeedButton(Sender).Tag xor -1);
end;

procedure TFrmMain.Col1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KeyCol[2] := KeyCol[2] or TSpeedButton(Sender).Tag;
end;

procedure TFrmMain.Col1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KeyCol[2] := KeyCol[2] and (TSpeedButton(Sender).Tag xor -1);
end;

procedure TFrmMain.Col2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KeyCol[3] := KeyCol[3] or TSpeedButton(Sender).Tag;
end;

procedure TFrmMain.Col2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  KeyCol[3] := KeyCol[3] and (TSpeedButton(Sender).Tag xor -1);
end;

procedure TFrmMain.LeHexNestorZ80;
var
  f: TextFile;
  command, lstfile, hexfile, asmpath: string;
  elapsed: DWORD;
  MustCompile: Boolean;
begin
  hexfile := ChangeFileExt(AsmFile, '.HEX');
  lstfile := ChangeFileExt(AsmFile, '.LST');
  MustCompile := not (FileExists(hexfile) and FileExists(lstfile));

  if MustCompile and not FileExists(AsmFile) then
    raise Exception.Create('Fonte do programa monitor não existe (' + AsmFile +
      ')');

  if not FileExists(Compiler) then
    raise Exception.Create('Compilador não encontrado: ' + Compiler);

  if MustCompile then
    try
      asmpath := ExtractFilePath(AsmFile);

      DeleteFile(asmpath + 'ok.out');
      AssignFile(f, asmpath + 'compnst.bat');
      Rewrite(f);

      try
        command := '"' + Compiler + '" ' + StringReplace(Parameters, '#ASM', '"'
          + AsmFile + '"', [rfReplaceAll, rfIgnoreCase]);
        command := StringReplace(command, '#LST', '"' + lstfile + '"',
          [rfReplaceAll, rfIgnoreCase]);

        Writeln(f, '@ECHO OFF');
        Writeln(f, 'CD "' + asmpath + '"');
        Writeln(f, 'IF EXIST ok.out DEL ok.out');
        Writeln(f, command);
        Writeln(f, 'IF NOT ERRORLEVEL 1 GOTO FIM');
        Writeln(f, 'IF EXIST "' + hexfile + '" DEL "' + hexfile + '"');
        Writeln(f, ':FIM');
        Writeln(f, 'echo OK > ok.out');
      finally
        CloseFile(f);
      end;

      WinExec(PChar(asmpath + 'compnst.bat'), SW_HIDE);
      elapsed := GetTickCount() + 60000;

      while not FileExists(asmpath + 'ok.out') and (GetTickCount() <= elapsed)
        do
        Application.ProcessMessages;

      if not FileExists(asmpath + 'ok.out') then
        raise
          Exception.Create('Erro de compilação. Tempo de execução ultrapassou limite.');

      if not (FileExists(lstfile) and FileExists(hexfile)) then
        raise
          Exception.Create('Erro de compilação. Programa monitor não foi gerado.');
    finally
      DeleteFile(asmpath + 'ok.out');
      DeleteFile(asmpath + 'compnst.bat');
    end;

  Memory.WriteInROM := True;

  try
    LoadHex(hexfile, FrmMain.Memory);
    FrmBreakPoints.Debug(Memory, lstfile, True);

    Run.Enabled := True;
    Step.Enabled := True;
    Reset.Enabled := True;
    Halt.Enabled := True;
    Pause.Enabled := True;
  finally
    Memory.WriteInROM := False;
    fimROM := 1023;
  end;
end;

procedure TFrmMain.ResetLEDs;
begin
  LEDsWrite($0);
end;

procedure TFrmMain.BreakEvent(Sender: TObject; Address: Word; var Go: Boolean);
begin
  Go := False;
  FrmFontes.Compile.Enabled := True;
  Run.Enabled := True;
  Step.Enabled := True;
  Pause.Enabled := False;
end;

procedure TFrmMain.StopEvent(Sender: TObject);
begin
  CPUShow;
  PosDebug;
end;

procedure TFrmMain.Cleardata;
begin
  with FrmRegistros do
  begin
    Acc.Text := '';
    B.Text := '';
    C.Text := '';
    D.Text := '';
    E.Text := '';
    H.Text := '';
    L.Text := '';
    Acc2.Text := '';
    B2.Text := '';
    C2.Text := '';
    D2.Text := '';
    E2.Text := '';
    H2.Text := '';
    L2.Text := '';
    I.Text := '';
    R.Text := '';
    IX.Text := '';
    IY.Text := '';
    SP.Text := '';
    PC.Text := '';
  end;

  Disassembler.Text := '';
end;

procedure TFrmMain.opcRegistrosClick(Sender: TObject);
begin
  FrmRegistros.Show;
end;

procedure TFrmMain.opcFlagsClick(Sender: TObject);
begin
  FrmFlags.Show;
end;

procedure TFrmMain.opcMemoriaClick(Sender: TObject);
begin
  FrmMemory.Show;
end;

procedure TFrmMain.opcFontesClick(Sender: TObject);
begin
  FrmFontes.Show;
end;

procedure TFrmMain.opcBreakpointsClick(Sender: TObject);
begin
  FrmBreakPoints.Show;
end;

procedure TFrmMain.PosDebug;
var
  i: Integer;
  CPU_PC: Word;
begin
  with FrmBreakPoints.ListDebug do
  begin
    ItemIndex := -1;
    CPU_PC := CPU.PC;

    for i := 0 to Items.Count - 1 do
      if Integer(Items.Objects[i]) = CPU_PC then
      begin
        ItemIndex := i;
        Break;
      end;
  end;
end;

function TFrmMain.ReadTerminal: Byte;
begin
  Result := Byte(FrmTerminal.Read);
end;

procedure TFrmMain.WriteTerminal(Data: Byte);
begin
  if Data = $0C then
    FrmTerminal.ComTerminal.ClearScreen
  else
    FrmTerminal.Write(Char(Data));
end;

function TFrmMain.ReadTerminalStatus: Byte;
begin
  Result := Byte(FrmTerminal.ReadStatus);
end;

procedure TFrmMain.DisplayHexaClick(Sender: TObject);
var
  Alignments: TAlignment;
begin
  if DisplayHexa.Checked then
    Alignments := taCenter
  else
    Alignments := taRightJustify;

  FrmRegistros.Acc.Alignment := Alignments;
  FrmRegistros.B.Alignment := Alignments;
  FrmRegistros.C.Alignment := Alignments;
  FrmRegistros.D.Alignment := Alignments;
  FrmRegistros.E.Alignment := Alignments;
  FrmRegistros.H.Alignment := Alignments;
  FrmRegistros.L.Alignment := Alignments;
  FrmRegistros.I.Alignment := Alignments;
  FrmRegistros.R.Alignment := Alignments;
  FrmRegistros.IX.Alignment := Alignments;
  FrmRegistros.IY.Alignment := Alignments;
  FrmRegistros.PC.Alignment := Alignments;
  FrmRegistros.SP.Alignment := Alignments;
  FrmRegistros.Acc2.Alignment := Alignments;
  FrmRegistros.B2.Alignment := Alignments;
  FrmRegistros.C2.Alignment := Alignments;
  FrmRegistros.D2.Alignment := Alignments;
  FrmRegistros.E2.Alignment := Alignments;
  FrmRegistros.H2.Alignment := Alignments;
  FrmRegistros.L2.Alignment := Alignments;

  CPUShow;
end;

procedure TFrmMain.NMIEvent(Sender: TObject; IsRunning: Boolean);
begin
  LEDReset.LightOn := False;
  LEDHalt.LightOn := False;
  Halt.ImageIndex := 15;
end;

procedure TFrmMain.opcTerminalClick(Sender: TObject);
begin
  FrmTerminal.Show;
end;

function TFrmMain.ButtonsRead: Byte;
begin
  Result := 0;

  if PE0.Checked then
    Result := Result or 1;

  if PE1.Checked then
    Result := Result or 2;

  if PE2.Checked then
    Result := Result or 4;

  if PE3.Checked then
    Result := Result or 8;

  if PE4.Checked then
    Result := Result or 16;

  if PE5.Checked then
    Result := Result or 32;

  if PE6.Checked then
    Result := Result or 64;

  if PE7.Checked then
    Result := Result or 128;
end;

end.
