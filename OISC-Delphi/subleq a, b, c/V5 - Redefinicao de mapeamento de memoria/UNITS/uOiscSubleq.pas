unit uOiscSubleq;

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, uThreadOiscSubleq, uCompOiscSubleq, CPortCtl;

type

  { TFrmOISCSubleq }

  TFrmOISCSubleq = class(TForm)
    btnStop: TBitBtn;
    btnGo: TBitBtn;
    btnStep: TBitBtn;
    Display: TComTerminal;
    lblC: TLabel;
    lblCc: TLabel;
    lblSubleq: TLabel;
    lblInB: TLabel;
    lblAddress: TLabel;
    lblAa: TLabel;
    lblA: TLabel;
    lblInA: TLabel;
    lblBb: TLabel;
    lblB: TLabel;
    Panel1: TPanel;
    lblPaused: TLabel;
    lblRunning: TLabel;
    lblHalt: TLabel;
    lblError: TLabel;
    btnStart: TBitBtn;
    btnPause: TBitBtn;
    btnHalt: TBitBtn;
    btnReset: TBitBtn;
    btnView: TBitBtn;
    btnClear: TBitBtn;
    procedure btnGoClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnStepClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHaltClick(Sender: TObject);
    procedure DisplayKeyPress(Sender: TObject; var Key: char);
    procedure btnStartClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPaused: boolean;
    nOrg: longword;
    procedure OnStart(Sender: TObject);
    procedure OnStartDebug(Sender: TObject);
    procedure OnStartStep(Sender: TObject; Addr: longword);
    procedure OnEndStep(Sender: TObject; Addr: longword);
    procedure OnHalt(Sender: TObject);
    procedure OnPause(Sender: TObject; Addr: longword);
    procedure OnReset(Sender: TObject; Addr: longword);
    procedure OnError(Sender: TObject; Addr: longword; Error: integer);
    procedure OnTerminate(Sender: TObject);
    procedure OnWrite(Str: string);
    procedure LoadProgram;
    function OnReadStatusKey: boolean;
    function OnReadKey: char;
    procedure PrgInfo;
  public
    ThreadOisc: TOISCSubleq;
  end;

var
  FrmOISCSubleq: TFrmOISCSubleq;
  AsmOISCKernel, AsmOISCProg: TAsmOISC;

implementation

{$R *.dfm}

uses
  Types, StrUtils, uShowCompiled, uInternalRegs;

var
  OISCKernel, OISCProgr: TArrAssembled;
  KeyBuff: array[0..100] of char;
  AKeyBuff: array[0..100] of byte absolute KeyBuff;
  PosBuf: integer = -1;
  ReadingKey: boolean = False;

procedure TFrmOISCSubleq.btnClearClick(Sender: TObject);
begin
  Display.ClearScreen;
end;

procedure TFrmOISCSubleq.btnGoClick(Sender: TObject);
begin
  btnGo.Enabled := False;

  try
    if Assigned(ThreadOisc) and ThreadOisc.Suspended then
      ThreadOisc.Resume;
  finally
    btnGo.Enabled := True;
  end;
end;

procedure TFrmOISCSubleq.btnStepClick(Sender: TObject);
begin
  if Assigned(ThreadOisc) then
  begin
    ThreadOisc.Terminate;
    Application.ProcessMessages;
    ThreadOisc := nil;
  end;

  if Length(AsmOISCKernel.Errors) <> 0 then
    btnView.Click
  else
  begin
    ThreadOisc := TOISCSubleq.Create(True);
    ThreadOisc.LoadProgr(OISCKernel, True);
    ThreadOisc.OnHalt := OnHalt;
    ThreadOisc.OnPause := OnPause;
    ThreadOisc.OnKeyStatus := OnReadStatusKey;
    ThreadOisc.OnReadKey := OnReadKey;
    ThreadOisc.OnReset := OnReset;
    ThreadOisc.OnError := OnError;
    ThreadOisc.OnStart := OnStart;
    ThreadOisc.OnStartDebug := OnStartDebug;
    ThreadOisc.OnStartStep := OnStartStep;
    ThreadOisc.OnEndStep := OnEndStep;
    ThreadOisc.OnWriteText := OnWrite;
    ThreadOisc.OnTerminate := OnTerminate;
    ThreadOisc.LoadProgram := LoadProgram;
  end;

  btnGo.Enabled := True;
  FrmInternalRegs.Show;
end;

procedure TFrmOISCSubleq.btnStopClick(Sender: TObject);
begin
  if Assigned(ThreadOisc) then
  begin
    ThreadOisc.Terminate;

    if ThreadOisc.Suspended then
      ThreadOisc.Resume;
  end;
end;

procedure TFrmOISCSubleq.btnHaltClick(Sender: TObject);
begin
  if Assigned(ThreadOisc) then
    ThreadOisc.Halt;
end;

procedure TFrmOISCSubleq.FormCreate(Sender: TObject);
begin
  lblAddress.Caption := '';
  lblSubleq.Caption := '';
  lblAa.Visible := False;
  lblA.Caption := '';
  lblInA.Caption := '';
  lblBb.Visible := False;
  lblB.Caption := '';
  lblInB.Caption := '';
  lblCc.Visible := False;
  lblC.Caption := '';
  Display.ClearScreen;
  lblHalt.Transparent := False;
  lblRunning.Transparent := False;
  lblPaused.Transparent := False;
  lblError.Transparent := False;
  ThreadOisc := nil;
  FPaused := False;
  AsmOISCKernel := TAsmOISC.Create;
  AsmOISCProg := TAsmOISC.Create;
end;

procedure TFrmOISCSubleq.DisplayKeyPress(Sender: TObject; var Key: char);
{$J+}
const
  process: boolean = False;
  {$J-}
begin
  while ReadingKey do
    Application.ProcessMessages;

  if not process and not lblHalt.Visible then
  begin
    process := True;

    try
      if (PosBuf = 100) or ((Key = #13) and (PosBuf = 99)) then
        //MessageBeep(MB_ICONASTERISK)
      else
      begin
        Inc(PosBuf);
        KeyBuff[PosBuf] := Key;

        if Key = #13 then
        begin
          Inc(PosBuf);
          KeyBuff[PosBuf] := #10;
        end;
      end;
    finally
      Key := #0;
      process := False;
    end;
  end;
end;

procedure TFrmOISCSubleq.OnWrite(Str: string);
var
  i: integer;
begin
  for i := 1 to Length(Str) do
    if str[i] = #12 then
      Display.ClearScreen
    else if str[i] = #8 then
      Display.WriteStr(#8#32#8)
    else
      Display.WriteStr(str[I]);
end;

function TFrmOISCSubleq.OnReadKey: char;
var
  i: integer;
begin
  ReadingKey := True;

  try
    if PosBuf = -1 then
      Result := #0
    else
    begin
      Result := Chr(AKeyBuff[0]);

      for i := 1 to PosBuf do
        KeyBuff[i - 1] := KeyBuff[i];

      AKeyBuff[PosBuf] := 0;
      Dec(PosBuf);
    end;
  finally
    ReadingKey := False;
  end;
end;

procedure TFrmOISCSubleq.OnHalt(Sender: TObject);
begin
  lblRunning.Visible := False;

  //LblHalt.Caption := ' HALTED at $' + IntToHex(Addr, 8) + ' ';

  LblHalt.Visible := True;

  btnHalt.Enabled := False;
  btnPause.Enabled := False;
  btnReset.Enabled := False;
  btnStart.Enabled := True;
  btnClear.Enabled := True;
  btnStep.Enabled := True;
  btnGo.Enabled := False;
  btnStop.Enabled := False;

  lblA.Visible := False;
  lblB.Visible := False;
  lblC.Visible := False;
  lblAddress.Caption := '';
  lblSubleq.Caption := '';
  lblA.Caption := '';
  lblInA.Caption := '';
  lblB.Caption := '';
  lblInB.Caption := '';
  lblC.Caption := '';

  lblAddress.Visible := False;
  lblSubleq.Visible := False;
  lblA.Visible := False;
  lblAa.Visible := False;
  lblB.Visible := False;
  lblBb.Visible := False;
  lblCc.Visible := False;
end;

procedure TFrmOISCSubleq.OnPause(Sender: TObject; Addr: longword);
begin
  lblRunning.Visible := False;
  LblPaused.Caption := ' PAUSED at $' + IntToHex(Addr, 8) + ' ';
  LblPaused.Visible := True;

  btnHalt.Enabled := False;
  btnPause.Enabled := False;
  btnReset.Enabled := False;
  btnStart.Enabled := True;
end;

procedure TFrmOISCSubleq.OnReset(Sender: TObject; Addr: longword);
begin
  LblHalt.Visible := False;
  LblHalt.Refresh;

  LblPaused.Visible := False;
  LblPaused.Refresh;

  lblRunning.Visible := True;
  lblRunning.Refresh;
end;

procedure TFrmOISCSubleq.OnStart(Sender: TObject);
begin
  LblHalt.Visible := False;
  LblPaused.Visible := False;
  lblError.Visible := False;
  lblRunning.Visible := True;

  btnStart.Enabled := False;
  btnStep.Enabled := False;
  btnClear.Enabled := False;

  FPaused := False;

  btnHalt.Enabled := not TOISCSubleq(Sender).InDebug;
  btnPause.Enabled := btnHalt.Enabled;
  btnReset.Enabled := btnHalt.Enabled;

  btnGo.Enabled := not btnHalt.Enabled;
  btnStop.Enabled := btnGo.Enabled;

  lblAa.Visible := btnGo.Enabled;
  lblBb.Visible := btnGo.Enabled;
  lblCc.Visible := btnGo.Enabled;

  Display.SetFocus;
end;

procedure TFrmOISCSubleq.OnStartDebug(Sender: TObject);
begin
  OnStartStep(Sender, 0);
end;

procedure TFrmOISCSubleq.OnStartStep(Sender: TObject; Addr: longword);
var
  v, x, CSStart, CSEnd, DSStart, DSEnd: longword;
  y: integer absolute x;
  s: string;
begin
  CSStart := 0;
  CSEnd := 0;
  DSStart := 0;
  DSEnd := 0;

  lblSubleq.Caption := 'subleq  ';

  lblAddress.Caption := '$' + ThreadOisc.AdjustHex(IntToHex(Addr, 8));

  if ThreadOisc.Protected then
  begin
    CSStart := ThreadOisc.ReadReg(irCS_Start);
    CSEnd := ThreadOisc.ReadReg(irCS_End);
    DSStart := ThreadOisc.ReadReg(irDS_Start);
    DSEnd := ThreadOisc.ReadReg(irDS_End);

    lblAddress.Caption := lblAddress.Caption + ' ($' +
      ThreadOisc.AdjustHex(IntToHex(CSStart, 8)) + ':' +
      ThreadOisc.AdjustHex(IntToHex(Addr - CSStart, 8)) +
      ')';
  end;

  v := ThreadOisc.Memory.AsLong[Addr + 0];

  if ThreadOisc.Protected and (v < ThreadOisc.ROMIni) and (v + CSStart >= CSStart) and (v + CSStart <= DSEnd) then
  begin
    lblA.Caption := ' ($' +
      ThreadOisc.AdjustHex(IntToHex(CSStart, 8)) + ':' +
      ThreadOisc.AdjustHex(IntToHex(v, 8)) + ')';

    Inc(v, CSStart);
    lblA.Caption := '$' + ThreadOisc.AdjustHex(IntToHex(v, 8)) + lblA.Caption;
  end
  else
    lblA.Caption := '$' + ThreadOisc.AdjustHex(IntToHex(v, 8));

  s := IntToStr(v);

  if FrmShowCompiled.tblLabels.Locate('Absolute', s, []) then
    lblSubleq.Caption := lblSubleq.Caption + FrmShowCompiled.tblLabelsName.AsString + '  '
  else
    lblSubleq.Caption := lblSubleq.Caption + lblA.Caption + '  ';

  v := ThreadOisc.Memory.AsLong[Addr + 1];

  if ThreadOisc.Protected and (v < ThreadOisc.ROMIni) and (v + CSStart >= DSStart) and (v + CSStart <= DSEnd) then
  begin
    lblB.Caption := ' ($' +
      ThreadOisc.AdjustHex(IntToHex(CSStart, 8)) + ':' +
      ThreadOisc.AdjustHex(IntToHex(v, 8)) + ')';

    Inc(v, CSStart);
    lblB.Caption := '$' + ThreadOisc.AdjustHex(IntToHex(v, 8)) + lblB.Caption;
  end
  else
    lblB.Caption := '$' + ThreadOisc.AdjustHex(IntToHex(v, 8));

  s := IntToStr(v);

  if FrmShowCompiled.tblLabels.Locate('Absolute', s, []) then
    lblSubleq.Caption := lblSubleq.Caption + FrmShowCompiled.tblLabelsName.AsString + '  '
  else
    lblSubleq.Caption := lblSubleq.Caption + lblB.Caption + '  ';

  v := ThreadOisc.Memory.AsLong[Addr + 2];

  if ThreadOisc.Protected and (v < ThreadOisc.ROMIni) and (v + CSStart >= CSStart) and (v + CSStart <= CSEnd) then
  begin
    lblC.Caption := ' ($' +
      ThreadOisc.AdjustHex(IntToHex(CSStart, 8)) + ':' +
      ThreadOisc.AdjustHex(IntToHex(v, 8)) + ')';

    Inc(v, CSStart);
    lblC.Caption := '$' + ThreadOisc.AdjustHex(IntToHex(v, 8)) + lblC.Caption;
  end
  else
    lblC.Caption := '$' + ThreadOisc.AdjustHex(IntToHex(v, 8));

  s := IntToStr(v);

  if FrmShowCompiled.tblLabels.Locate('Absolute', s, []) then
    lblSubleq.Caption := lblSubleq.Caption + FrmShowCompiled.tblLabelsName.AsString + '  '
  else
    lblSubleq.Caption := lblSubleq.Caption + lblC.Caption + '  ';

  if Addr + 0 <= ThreadOisc.MemTop then
  begin
    v := ThreadOisc.Memory.AsLong[Addr + 0];

    if ThreadOisc.Protected and (v < ThreadOisc.ROMIni) and (v + CSStart >= CSStart) and (v + CSStart <= DSEnd) then
      Inc(v, CSStart);

    if v <= ThreadOisc.MemTop then
    begin
      x := ThreadOisc.Memory.AsLong[v];
      lblInA.Caption := '$' + ThreadOisc.AdjustHex(IntToHex(x, 8)) + ' (' + IntToStr(y) + ')';
    end
    else
      lblInA.Caption := '';
  end
  else
    lblInA.Caption := '';

  if Addr + 1 <= ThreadOisc.MemTop then
  begin
    v := ThreadOisc.Memory.AsLong[Addr + 1];

    if ThreadOisc.Protected and (v < ThreadOisc.ROMIni) and (v + CSStart >= DSStart) and (v + CSStart <= DSEnd) then
      Inc(v, CSStart);

    if v <= ThreadOisc.MemTop then
    begin
      x := ThreadOisc.Memory.AsLong[v];
      lblInB.Caption := '$' + ThreadOisc.AdjustHex(IntToHex(x, 8)) + ' (' + IntToStr(y) + ')';
    end
    else
      lblInB.Caption := '';
  end
  else
    lblInB.Caption := '';
end;

procedure TFrmOISCSubleq.OnEndStep(Sender: TObject; Addr: longword);
var
  x: longword;
  y: integer absolute x;
begin
  y := ThreadOisc.Acc;

  if lblInB.Caption <> '' then
    lblInB.Caption := lblInB.Caption + ' -';

  lblInB.Caption := lblInB.Caption + ' $' + IntToHex(x, 8) + ' (' + IntToStr(y) + ')';

  FrmInternalRegs.lblPC.Caption := '$' + IntToHex(ThreadOisc.ReadPC, 8);
  FrmInternalRegs.lblError_Line.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irError_Line), 8);
  FrmInternalRegs.lblError_Code.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irError_Code), 8);
  FrmInternalRegs.lblError_Hndr.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irError_Hndr), 8);
  FrmInternalRegs.lblPar0_IRQ.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irPar0_IRQ), 8);
  FrmInternalRegs.lblPar1_IRQ.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irPar1_IRQ), 8);
  FrmInternalRegs.lblPar2_IRQ.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irPar2_IRQ), 8);
  FrmInternalRegs.lblNum_IRQ.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irNum_IRQ), 8);
  FrmInternalRegs.lblHaltSig.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irHaltSig), 8);
  FrmInternalRegs.lblAddHALT.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irAddHALT), 8);
  FrmInternalRegs.lblIRQ_En.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irIRQ_En), 8);
  FrmInternalRegs.lblHard_IRQ.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irHard_IRQ), 8);
  FrmInternalRegs.lblSoft_IRQ.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irSoft_IRQ), 8);
  FrmInternalRegs.lblMemTop.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irMemTop), 8);
  FrmInternalRegs.lblProtected.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irProtected), 8);
  FrmInternalRegs.lblCS_Start.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irCS_Start), 8);
  FrmInternalRegs.lblCS_End.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irCS_End), 8);
  FrmInternalRegs.lblDS_Start.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irDS_Start), 8);
  FrmInternalRegs.lblDS_End.Caption := '$' + IntToHex(ThreadOisc.ReadReg(irDS_End), 8);
end;

procedure TFrmOISCSubleq.btnStartClick(Sender: TObject);
begin
  if Length(AsmOISCKernel.Errors) <> 0 then
    btnView.Click
  else if Assigned(ThreadOisc) then
    ThreadOisc.ExecReset
  else
  begin
    ThreadOisc := TOISCSubleq.Create(False);
    ThreadOisc.LoadProgr(OISCKernel, True);
    ThreadOisc.OnHalt := OnHalt;
    ThreadOisc.OnPause := OnPause;
    ThreadOisc.OnKeyStatus := OnReadStatusKey;
    ThreadOisc.OnReadKey := OnReadKey;
    ThreadOisc.OnReset := OnReset;
    ThreadOisc.OnError := OnError;
    ThreadOisc.OnStart := OnStart;
    ThreadOisc.OnStartStep := OnStartStep;
    ThreadOisc.OnEndStep := OnEndStep;
    ThreadOisc.OnWriteText := OnWrite;
  end;
end;

procedure TFrmOISCSubleq.btnPauseClick(Sender: TObject);
begin
  if Assigned(ThreadOisc) then
  begin
    FPaused := True;
    ThreadOisc.ExecPause;
  end;
end;

procedure TFrmOISCSubleq.btnResetClick(Sender: TObject);
begin
  if Assigned(ThreadOisc) then
  begin
    ThreadOisc.ExecReset;
    Display.SetFocus;
  end;
end;

procedure TFrmOISCSubleq.OnError(Sender: TObject; Addr: longword; Error: integer);
begin
  lblRunning.Visible := False;
  lblError.Caption := ' ERROR ' + IntToStr(Error) + ' at $' + IntToHex(Addr, 8) + ' ';
  lblError.Visible := True;

  btnHalt.Enabled := True;
  btnPause.Enabled := True;
  btnReset.Enabled := True;
  btnStart.Enabled := False;
  btnClear.Enabled := True;
end;

procedure TFrmOISCSubleq.btnViewClick(Sender: TObject);
begin
  FrmShowCompiled.ShowModal;
  Application.ProcessMessages;
end;

function TFrmOISCSubleq.OnReadStatusKey: boolean;
begin
  Result := PosBuf <> -1;
end;

procedure TFrmOISCSubleq.PrgInfo;
var
  i: integer;
begin
  FrmShowCompiled.tblProgr.Close;
  FrmShowCompiled.tblProgr.Open;

  while not FrmShowCompiled.tblProgr.IsEmpty do
    FrmShowCompiled.tblProgr.Delete;

  for i := 0 to Length(AsmOISCKernel.Lines) - 1 do
  begin
    FrmShowCompiled.tblProgr.Append;

    try
      FrmShowCompiled.tblProgrAddress.AsString := IntToHex(AsmOISCKernel.Lines[i].Address, 8);
      FrmShowCompiled.tblProgrIsRelative.AsBoolean := AsmOISCKernel.Lines[i].IsRelative;

      if AsmOISCKernel.Lines[i].IsRelative then
        FrmShowCompiled.tblProgrAddress.AsString :=
          '$' + IntToHex(AsmOISCKernel.Lines[i].Address, 8) + ':' +
          IntToHex(AsmOISCKernel.Lines[i].Relative, 8)
      else
        FrmShowCompiled.tblProgrAddress.AsString :=
          '$00000000:' + IntToHex(AsmOISCKernel.Lines[i].Address, 8);

      FrmShowCompiled.tblProgrLine.AsInteger := i + 1;
      FrmShowCompiled.tblProgrLabel.AsString := AsmOISCKernel.Lines[i].Lbl;
      FrmShowCompiled.tblProgrOperator.AsString := AsmOISCKernel.Lines[i].Oper;

      if SameText(AsmOISCKernel.Lines[i].Oper, '@REL') then
        if AsmOISCKernel.Lines[i].A[1] = '&' then
          FrmShowCompiled.tblProgrA.AsString :=
            '$' + IntToHex(AsmOISCKernel.BinToInt(AsmOISCKernel.Lines[i].A), 8)
        else if AsmOISCKernel.Lines[i].A[1] = '$' then
          FrmShowCompiled.tblProgrA.AsString := AsmOISCKernel.Lines[i].A
        else
          FrmShowCompiled.tblProgrA.AsString :=
            '$' + IntToHex(StrToInt64(AsmOISCKernel.Lines[i].A), 8)
      else
        FrmShowCompiled.tblProgrA.AsString := AsmOISCKernel.Lines[i].A;

      if SameText(AsmOISCKernel.Lines[i].Oper, 'ORG') and (AsmOISCKernel.Lines[i].B <> '') then
        if AsmOISCKernel.Lines[i].B[1] = '&' then
          FrmShowCompiled.tblProgrB.AsString :=
            IntToStr(AsmOISCKernel.BinToInt(AsmOISCKernel.Lines[i].B))
        else if AsmOISCKernel.Lines[i].B[1] = '$' then
          FrmShowCompiled.tblProgrB.AsString := IntToStr(StrToInt(AsmOISCKernel.Lines[i].B))
        else
          FrmShowCompiled.tblProgrB.AsString := AsmOISCKernel.Lines[i].B
      else
        FrmShowCompiled.tblProgrB.AsString := AsmOISCKernel.Lines[i].B;

      FrmShowCompiled.tblProgrC.AsString := AsmOISCKernel.Lines[i].C;
      FrmShowCompiled.tblProgrObs.AsString := AsmOISCKernel.Lines[i].Comment;
      FrmShowCompiled.tblProgrError.AsBoolean := AsmOISCKernel.Lines[i].Error;
      FrmShowCompiled.tblProgr.Post;
    except
      FrmShowCompiled.tblProgr.Cancel;
      raise;
    end;
  end;

  FrmShowCompiled.tblProgr.First;

  FrmShowCompiled.tblLabels.Close;
  FrmShowCompiled.tblLabels.Open;

  while not FrmShowCompiled.tblLabels.IsEmpty do
    FrmShowCompiled.tblLabels.Delete;

  for i := 0 to Length(AsmOISCKernel.Labels) - 1 do
  begin
    FrmShowCompiled.tblLabels.Append;

    try
      FrmShowCompiled.tblLabelsName.AsString := AsmOISCKernel.Labels[i].Name;
      FrmShowCompiled.tblLabelsContent.AsString := AsmOISCKernel.Labels[i].Content;
      FrmShowCompiled.tblLabelsAbsolute.AsString := IntToStr(AsmOISCKernel.Labels[i].Absolute);
      FrmShowCompiled.tblLabelsRelative.AsInteger := AsmOISCKernel.Labels[i].Relative;
      FrmShowCompiled.tblLabelsLine.AsInteger := AsmOISCKernel.Labels[i].Line + 1;
      FrmShowCompiled.tblLabelsValidNumber.AsBoolean := AsmOISCKernel.Labels[i].ValidNumber;
      FrmShowCompiled.tblLabelsIsLabel.AsBoolean := AsmOISCKernel.Labels[i].IsLabel;
      FrmShowCompiled.tblLabels.Post;
    except
      FrmShowCompiled.tblLabels.Cancel;
      raise;
    end;
  end;

  FrmShowCompiled.tblLabels.First;

  FrmShowCompiled.tblErrors.Close;
  FrmShowCompiled.tblErrors.Open;

  while not FrmShowCompiled.tblErrors.IsEmpty do
    FrmShowCompiled.tblErrors.Delete;

  if Length(AsmOISCKernel.Errors) = 0 then
  begin
    FrmShowCompiled.tblErrors.Append;

    try
      FrmShowCompiled.tblErrorsSeq.AsInteger := 0;
      FrmShowCompiled.tblErrorsError.AsString := 'No Errors';
      FrmShowCompiled.tblErrors.Post;
    except
      FrmShowCompiled.tblErrors.Cancel;
      raise;
    end;
  end
  else
    for i := 0 to Length(AsmOISCKernel.Errors) - 1 do
    begin
      FrmShowCompiled.tblErrors.Append;

      try
        FrmShowCompiled.tblErrorsLine.AsInteger := AsmOISCKernel.Errors[i].Line + 1;
        FrmShowCompiled.tblErrorsSeq.AsInteger := i;
        FrmShowCompiled.tblErrorsError.AsString := AsmOISCKernel.Errors[i].Error;
        FrmShowCompiled.tblErrors.Post;
      except
        FrmShowCompiled.tblErrors.Cancel;
        raise;
      end;
    end;

  FrmShowCompiled.tblErrors.First;
end;

procedure TFrmOISCSubleq.FormShow(Sender: TObject);
var
  stream: TResourceStream;
  strStream: TStringStream;
  KernelSrc: string;
begin
  stream := TResourceStream.Create(hinstance, 'Kernel', RT_RCDATA);

  try
    strStream := TStringStream.Create('');

    try
      strStream.CopyFrom(stream, stream.Size);
      KernelSrc := strStream.DataString;
      KernelSrc := StringReplace(KernelSrc, '<MEMTOP>', '$' + IntToHex(uThreadOiscSubleq.EndOfMemory, 8), [rfReplaceAll, rfIgnoreCase]);
    finally
      strStream.Destroy;
    end;
  finally
    stream.Destroy;
  end;

  AsmOISCKernel.Compile(KernelSrc, nOrg, OISCKernel);

  PrgInfo;
end;

procedure TFrmOISCSubleq.FormDestroy(Sender: TObject);
begin
  if Assigned(AsmOISCKernel) then
    AsmOISCKernel.Destroy;

  if Assigned(AsmOISCProg) then
    AsmOISCProg.Destroy;

  if Assigned(ThreadOisc) then
    ThreadOisc.Terminate;
end;

procedure TFrmOISCSubleq.OnTerminate(Sender: TObject);
begin
  ThreadOisc := nil;
  OnHalt(Sender);
end;

procedure TFrmOISCSubleq.LoadProgram;
var
  stream: TResourceStream;
  strStream: TStringStream;
  ProgSrc: string;
begin
  Exit;
  
  stream := TResourceStream.Create(hinstance, 'Prog1', RT_RCDATA);

  try
    strStream := TStringStream.Create('');

    try
      strStream.CopyFrom(stream, stream.Size);
      ProgSrc := strStream.DataString;
    finally
      strStream.Destroy;
    end;
  finally
    stream.Destroy;
  end;

  AsmOISCProg.Compile(ProgSrc, nOrg, OISCProgr);
  ThreadOisc.LoadProgr(OISCProgr, False);
end;

end.

