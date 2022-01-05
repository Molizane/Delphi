unit uOiscSubleq;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, uThreadOiscSubleq;

const
  WM_MYMEMO_ENTER = WM_USER + 500;

type
  TFrmOISCSubleq = class(TForm)
    Display: TMemo;
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
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHaltClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DisplayKeyPress(Sender: TObject; var Key: Char);
    procedure DisplayEnter(Sender: TObject);
    procedure DisplayExit(Sender: TObject);
    procedure DisplayChange(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
  private
    ThreadOisc: TOISCSubleq;
    FPaused: Boolean;
    procedure StartEvent(Sender: TObject);
    procedure HaltEvent(Sender: TObject; Addr: Longword);
    procedure PauseEvent(Sender: TObject; Addr: Longword);
    procedure ResetEvent(Sender: TObject; Addr: Longword);
    procedure ErrorEvent(Sender: TObject; Addr: Longword; Error: Integer);
    procedure Write(Str: string);
    function Read: Char;
  public
    procedure WMMYMEMOENTER(var Message: TMessage); message WM_MYMEMO_ENTER;
  end;

var
  FrmOISCSubleq: TFrmOISCSubleq;

implementation

{$R *.dfm}

uses
  StrUtils, uShowCompiled, DB, uCompOiscSubleq;

const
  // OSIC self-interpreter
  Progr1: array[0..53] of string = (
    {000}'   ORG 0',
    {000}'   subleq   15   15    3 // if ([15] = [15] - [15]) <= 0 goto 3',
    {003}'   subleq  148  147    6 // if ([147] = [147] - [148]) <= 0 goto 6',
    {006}'   subleq  147   15    9 // if ([15] = [15] - [147]) <= 0 goto 9',
    {009}'   subleq  147  147   12 // if ([147] = [147] - [147]) <= 0 goto 12',
    {012}'   subleq  117  117   15 // if ([117] = [117] - [117]) <= 0 goto 15',
    {015}'   subleq    0  147   18 // if ([147] = [147] - [0]) <= 0 goto 18',
    {018}'   subleq  147  117   21 // if ([117] = [117] - [147]) <= 0 goto 21',
    {021}'   subleq  147  147   24 // if ([147] = [147] - [147]) <= 0 goto 24',
    {024}'   subleq  152  117   27 // if ([117] = [117] - [152]) <= 0 goto 27',
    {027}'   subleq  151  148   30 // if ([148] = [148] - [151]) <= 0 goto 30',
    {030}'   subleq   45   45   33 // if ([45] = [45] - [45]) <= 0 goto 33',
    {033}'   subleq  148  147   36 // if ([147] = [147] - [148]) <= 0 goto 36',
    {036}'   subleq  147   45   39 // if ([45] = [45] - [147]) <= 0 goto 39',
    {039}'   subleq  147  147   42 // if ([147] = [147] - [147]) <= 0 goto 42',
    {042}'   subleq  118  118   45 // if ([118] = [118] - [118]) <= 0 goto 45',
    {045}'   subleq    0  147   48 // if ([147] = [147] - [0]) <= 0 goto 48',
    {048}'   subleq  147  118   51 // if ([118] = [118] - [147]) <= 0 goto 51',
    {051}'   subleq  147  147   54 // if ([147] = [147] - [147]) <= 0 goto 54',
    {054}'   subleq   15   15   57 // if ([15] = [15] - [15]) <= 0 goto 57',
    {057}'   subleq  150  147   60 // if ([147] = [147] - [150]) <= 0 goto 60',
    {060}'   subleq  147   15   63 // if ([15] = [15] - [147]) <= 0 goto 63',
    {063}'   subleq  147  147   66 // if ([147] = [147] - [147]) <= 0 goto 66',
    {066}'   subleq   45   45   69 // if ([45] = [45] - [45]) <= 0 goto 69',
    {069}'   subleq  118  147   72 // if ([147] = [147] - [118]) <= 0 goto 72',
    {072}'   subleq  147   45   75 // if ([45] = [45] - [147]) <= 0 goto 75',
    {075}'   subleq  147  147   78 // if ([147] = [147] - [147]) <= 0 goto 78',
    {078}'   subleq  150   45   84 // if ([45] = [45] - [150]) <= 0 goto 84',
    {081}'   subleq  147  147   87 // if ([147] = [147] - [147]) <= 0 goto 87',
    {084}'   subleq  118   15   90 // if ([15] = [15] - [118]) <= 0 goto 90',
    {087}'   subleq  152  118   90 // if ([118] = [118] - [152]) <= 0 goto 90',
    {090}'   subleq  151  148   93 // if ([148] = [148] - [151]) <= 0 goto 93',
    {093}'   subleq  108  108   96 // if ([108] = [108] - [108]) <= 0 goto 96',
    {096}'   subleq  148  147   99 // if ([147] = [147] - [148]) <= 0 goto 99',
    {099}'   subleq  147  108  102 // if ([108] = [108] - [147]) <= 0 goto 102',
    {102}'   subleq  147  147  105 // if ([147] = [147] - [147]) <= 0 goto 105',
    {105}'   subleq  149  149  108 // if ([149] = [149] - [149]) <= 0 goto 108',
    {108}'   subleq    0  147  111 // if ([147] = [147] - [0]) <= 0 goto 111',
    {111}'   subleq  147  149  114 // if ([149] = [149] - [147]) <= 0 goto 114',
    {114}'   subleq  147  147  117 // if ([147] = [147] - [147]) <= 0 goto 117',
    {117}'   subleq    0    0  126 // if ([0] = [0] - [0]) <= 0 goto 126',
    {120}'   subleq  151  148  123 // if ([148] = [148] - [151]) <= 0 goto 123',
    {123}'   subleq  147  147    0 // if ([147] = [147] - [147]) <= 0 goto 0',
    {126}'   subleq  148  148  129 // if ([148] = [148] - [148]) <= 0 goto 129',
    {129}'   subleq  149  147  132 // if ([147] = [147] - [149]) <= 0 goto 132',
    {132}'   subleq  147  148  135 // if ([148] = [148] - [147]) <= 0 goto 135',
    {135}'   subleq  147  147  138 // if ([147] = [147] - [147]) <= 0 goto 138',
    {138}'   subleq  151  149   -1 // if ([149] = [149] - [151]) <= 0 goto -1',
    {141}'   subleq  152  148  144 // if ([148] = [148] - [152]) <= 0 goto 144',
    {144}'   subleq  147  147    0 // if ([147] = [147] - [147]) <= 0 goto 0',
    {147}'   DD      0    153    0',
    {150}'   DD  -1',
    {151}'   DD  -1',
    {152}'   DD -153'
    );

  // HELLO, WORLD!
  Progr2: array[0..39] of string = (
    'BEGIN:',
    '   DC NR -1',
    '   DC ZRO 0',
    '   DC PRN $FFFFFFFF',
    '   DC HALT $FFFFFFFF',
    '   ORG 0',
    'START:',
    '   subleq CHR  CHR         // if {CHR = CHR - CHR) = 0 goto next    // Limpa CHR',
    '   subleq INI  PNT         // if {PNT = PNT - INI) = 0 goto next    // Obtém posição do caracter (-PNT)',
    '   subleq PNT  CHR         // if {CHR = CHR - PNT) = 0 goto next    // Coloca o caracter em CHR',
    '   subleq PNT  PNT         // if {PNT = PNT - PNT) = 0 goto CHR     // Limpa PNT',
    'CHR: subleq ZRO  PRN        // Print CHR (INITXT ~ FIMTXT)',
    '   subleq NEG  INI         // if {INI = INI - NEG) = 0 goto next    // Incrementa INI',
    '   subleq CHR  CHR         // if {CHR = CHR - CHR) = 0 goto next    // Limpa CHR',
    '   subleq FIM  PNT         // if {PNT = PNT - FIMTXT) = 0 goto next // PNT = -FIMTXT = -FIM',
    '   subleq PNT  CHR         // if {CHR = CHR - PNT) = 0 goto next ',
    '   subleq PNT  PNT         // if {PNT = PNT - PNT) = 0 goto next',
    '   subleq INI  CHR  HLT    // if (CHR = CHR - INI) = 0 HALT',
    '   subleq PNT  PNT  START  // if {PNT = PNT - PNT) = 0 goto 0',
    'HLT:',
    '   subleq PNT  PNT  HALT',
    'INI: DD  INITXT',
    'FIM: DD  FIMTXT',
    'PNT: DD  ZRO',
    'NEG: DD  NR',
    'INITXT:',
    '   DD  12 72 101 // CLS "H" "E"',
    '   DD 108  // L',
    '   DD 108  // L',
    '   DD 111  // O',
    '   DD  44  // ',
    '   DD  32  //',
    '   DD  87  // W',
    '   DD 111  // O',
    '   DD 114  // R',
    '   DD 108  // L',
    '   DD 100  // D',
    '   DD  33  // !',
    '   DD  10  // LF',
    'FIMTXT:'
    );

  //(*
  // Lê o teclado e exibe na tela. ESC para parar.
  Progr3: array[0..29] of string = (
    '   ORG 0',
    '   DC NR -1',
    '   DC ZR 0',
    '   DC PRN $FFFFFFFF',
    '   DC INKEY $FFFFFFFF',
    '   DC HALT $FFFFFFFF',
    'START:',
    '   subleq  KEY  KEY       // if (KEY = KEY - KEY) <= 0 goto 3 --> KEY = 0',
    '   subleq  CLS  KEY       // if (KEY = KEY - CLS) <= 0 goto 3 --> KEY = 0 - (-12) = 12',
    '   subleq  KEY  PRN        // Print Chr(12) = CLS',
    'LOOP:',
    '   subleq  INKEY   KEY       // KEY = InKey',
    '   subleq  ZRO  ZRO       // if (ZRO = ZRO - ZRO) <= 0 goto 15 --> ZRO = 0',
    '   subleq  ESC  ZRO       // if (ZRO = ZRO - ESC) <= 0 goto 18 --> ZRO = 0 - (-27) = 27',
    '   subleq  KEY  ZRO       // if (ZRO = ZRO - KEY) <= 0 goto 21 --> ZRO = 27 - Key',
    '   subleq  ZRO  BUF  END  // if (BUF = BUF - ZRO) <= 0 goto 27 --> BUF = 0 - (27 - Key) ==> Se tecla < 27 BUF <= 0; pula para END',
    '   subleq  BUF  BUF  PRT  // if (BUF = BUF - BUF) <= 0 goto PRT --> BUF = 0',
    '   subleq  BUF  BUF  END  // if (BUF = BUF - BUF) <= 0 goto END --> BUF = 0',
    'END:',
    '   subleq  BUF  ZRO  HLT   // if (ZRO = ZRO - BUF) <= 0 HALT',
    'PRT:',
    '   subleq  KEY  PRN        // Print KEY',
    '   subleq  BUF  BUF  LOOP // if (BUF = BUF - BUF) <= 0 goto LOOP --> BUF = 0',
    'HLT:',
    '   subleq  BUF  BUF  HALT',
    'BUF: DD ZR  // Buffer',
    'KEY: DD ZR  // InKey',
    'ZRO: DD ZR  // Zero Flag',
    'ESC: DD -27 // ESC',
    'CLS: DD -12 // CLS'
    );
  //*)

var
  Progr: TIntegerArray;
  AsmOISC: TAsmOISC;
  BufKey: array[0..100] of Char;
  ABufKey: array[0..100] of Byte absolute BufKey;
  PosBuf: Integer = -1;
  ReadingKey: Boolean = False;

procedure TFrmOISCSubleq.btnClearClick(Sender: TObject);
begin
  Display.Lines.Clear;
end;

procedure TFrmOISCSubleq.btnHaltClick(Sender: TObject);
begin
  if Assigned(ThreadOisc) then
  begin
    ThreadOisc.ExecHalt;
    ThreadOisc := nil;
  end;
end;

procedure TFrmOISCSubleq.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if btnHalt.Enabled then
    if Assigned(ThreadOisc) then
      ThreadOisc.ExecHalt;
end;

procedure TFrmOISCSubleq.FormCreate(Sender: TObject);
begin
  Display.Lines.Clear;
  lblHalt.Transparent := False;
  lblRunning.Transparent := False;
  lblPaused.Transparent := False;
  lblError.Transparent := False;
  ThreadOisc := nil;
  FPaused := False;
  AsmOISC := TAsmOISC.Create;
end;

procedure TFrmOISCSubleq.DisplayKeyPress(Sender: TObject; var Key: Char);
{$J+}
const
  process: Boolean = false;
{$J-}
begin
  while ReadingKey do
    Application.ProcessMessages;

  if not process and not lblHalt.Visible then
  begin
    process := True;

    try
      if PosBuf = 100 then
        MessageBeep(MB_ICONASTERISK)
      else
      begin
        Inc(PosBuf);
        BufKey[PosBuf] := Key;
      end;
    finally
      Key := #0;
      process := False;
    end;
  end;
end;

procedure TFrmOISCSubleq.WMMYMEMOENTER(var Message: TMessage);
begin
  //CreateCaret(Display.Handle, 0, 0, 0);
end;

procedure TFrmOISCSubleq.DisplayEnter(Sender: TObject);
begin
  //PostMessage(Handle, WM_MYMEMO_ENTER, 0, 0);
end;

procedure TFrmOISCSubleq.DisplayExit(Sender: TObject);
begin
  //CreateCaret(Display.Handle, 1, 1, 1);
end;

procedure TFrmOISCSubleq.DisplayChange(Sender: TObject);
begin
  //CreateCaret(Display.Handle, 0, 0, 0);
end;

procedure TFrmOISCSubleq.Write(Str: string);
var
  i: Integer;
begin
  for i := 1 to Length(Str) do
    if str[i] = #10 then
      Display.Lines.Text := Display.Lines.Text + #13#10
    else if str[i] = #12 then
      Display.Lines.Clear
    else if str[i] = #8 then
    begin
      if Length(Display.Lines.Text) = 0 then
        MessageBeep(MB_ICONASTERISK)
      else if RightStr(Display.Lines.Text, 1) = #10 then
        Display.Lines.Text := LeftStr(Display.Lines.Text, Length(Display.Lines.Text) - 2)
      else
        Display.Lines.Text := LeftStr(Display.Lines.Text, Length(Display.Lines.Text) - 1);
    end
    else
      Display.Lines.Text := Display.Lines.Text + str[i];

  if Display.Lines.Count > 24 then
    Display.Lines.Delete(0);

  Display.Refresh;
  Display.SelStart := Length(Display.Lines.Text);
end;

function TFrmOISCSubleq.Read: Char;
var
  i: Integer;
begin
  ReadingKey := True;

  try
    if PosBuf = -1 then
      Result := #0
    else
    begin
      Result := Chr(ABufKey[0]);

      for i := 1 to PosBuf do
        BufKey[i - 1] := BufKey[i];

      ABufKey[PosBuf] := 0;
      Dec(PosBuf);
    end;
  finally
    ReadingKey := False;
  end;
end;

procedure TFrmOISCSubleq.HaltEvent(Sender: TObject; Addr: Longword);
begin
  lblRunning.Visible := False;

  LblHalt.Caption := ' HALTED at $' + IntToHex(Addr, 8) + ' ';
  LblHalt.Visible := True;

  btnHalt.Enabled := False;
  btnPause.Enabled := False;
  btnReset.Enabled := False;
  btnStart.Enabled := True;
  btnClear.Enabled := True;
end;

procedure TFrmOISCSubleq.PauseEvent(Sender: TObject; Addr: Longword);
begin
  lblRunning.Visible := False;
  LblPaused.Caption := ' PAUSED $' + IntToHex(Addr, 8) + ' ';
  LblPaused.Visible := True;

  btnHalt.Enabled := False;
  btnPause.Enabled := False;
  btnReset.Enabled := False;
  btnStart.Enabled := True;
end;

procedure TFrmOISCSubleq.ResetEvent(Sender: TObject; Addr: Longword);
begin
  LblHalt.Visible := False;
  LblHalt.Refresh;

  LblPaused.Visible := False;
  LblPaused.Refresh;

  lblRunning.Visible := True;
  lblRunning.Refresh;
end;

procedure TFrmOISCSubleq.StartEvent(Sender: TObject);
begin
  LblHalt.Visible := False;
  LblPaused.Visible := False;
  lblError.Visible := False;
  lblRunning.Visible := True;

  btnStart.Enabled := False;
  btnClear.Enabled := False;

  FPaused := False;

  btnHalt.Enabled := True;
  btnPause.Enabled := True;
  btnReset.Enabled := True;
  Display.SetFocus;
end;

procedure TFrmOISCSubleq.btnStartClick(Sender: TObject);
var
  nOrg: Longword;
begin
  if Assigned(ThreadOisc) and ThreadOisc.Paused then
    ThreadOisc.ExecRun
  else
  begin
    Progr := AsmOISC.CompOISC(Progr3, nOrg);

    if Length(AsmOISC.Errors) <> 0 then
      btnView.Click
    else
    begin
      ThreadOisc := TOISCSubleq.Create(True);
      ThreadOisc.LoadProgr(Progr, nOrg);
      ThreadOisc.OnHalt := HaltEvent;
      ThreadOisc.OnPause := PauseEvent;
      ThreadOisc.OnReadChar := Read;
      ThreadOisc.OnReset := ResetEvent;
      ThreadOisc.OnError := ErrorEvent;
      ThreadOisc.OnStart := StartEvent;
      ThreadOisc.OnWriteText := Write;
    end;
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

procedure TFrmOISCSubleq.ErrorEvent(Sender: TObject; Addr: Longword; Error: Integer);
begin
  lblRunning.Visible := False;
  lblError.Caption := ' ERROR $' + IntToHex(Error, 2) + ' $' + IntToHex(Addr, 8) + ' ';
  lblError.Visible := True;

  btnHalt.Enabled := False;
  btnPause.Enabled := False;
  btnReset.Enabled := False;
  btnStart.Enabled := True;
  btnClear.Enabled := True;
end;

procedure TFrmOISCSubleq.btnViewClick(Sender: TObject);
var
  i: Integer;
begin
  FrmShowCompiled.tblProgr.Close;
  FrmShowCompiled.tblProgr.Open;
  FrmShowCompiled.tblProgr.EmptyTable;

  for i := 0 to Length(AsmOISC.Lines) - 1 do
  begin
    FrmShowCompiled.tblProgr.Append;

    try
      if SameText(AsmOISC.Lines[i].Oper, 'DC') then
        FrmShowCompiled.tblProgrAddress.AsInteger := AsmOISC.Lines[i].Address
      else
        FrmShowCompiled.tblProgrAddress.AsString := '$' + IntToHex(AsmOISC.Lines[i].Address, 8);

      FrmShowCompiled.tblProgrLabel.AsString := AsmOISC.Lines[i].Lbl;
      FrmShowCompiled.tblProgrOperator.AsString := AsmOISC.Lines[i].Oper;
      FrmShowCompiled.tblProgrA.AsString := AsmOISC.Lines[i].A;
      FrmShowCompiled.tblProgrB.AsString := AsmOISC.Lines[i].B;
      FrmShowCompiled.tblProgrC.AsString := AsmOISC.Lines[i].C;
      FrmShowCompiled.tblProgrObs.AsString := AsmOISC.Lines[i].Comment;
      FrmShowCompiled.tblProgrError.AsBoolean := AsmOISC.Lines[i].Error;
      FrmShowCompiled.tblProgr.Post;
    except
      FrmShowCompiled.tblProgr.Cancel;
      raise;
    end;
  end;

  FrmShowCompiled.tblProgr.First;

  FrmShowCompiled.tblLabels.Close;
  FrmShowCompiled.tblLabels.Open;
  FrmShowCompiled.tblLabels.EmptyTable;

  for i := 0 to Length(AsmOISC.Labels) - 1 do
  begin
    FrmShowCompiled.tblLabels.Append;

    try
      FrmShowCompiled.tblLabelsName.AsString := AsmOISC.Labels[i].Name;
      FrmShowCompiled.tblLabelsContent.AsString := AsmOISC.Labels[i].Content;
      FrmShowCompiled.tblLabelsLine.AsInteger := AsmOISC.Labels[i].Line;
      FrmShowCompiled.tblLabelsValidNumber.AsBoolean := AsmOISC.Labels[i].ValidNumber;
      FrmShowCompiled.tblLabelsIsLabel.AsBoolean := AsmOISC.Labels[i].IsLabel;
      FrmShowCompiled.tblLabels.Post;
    except
      FrmShowCompiled.tblLabels.Cancel;
      raise;
    end;
  end;

  FrmShowCompiled.tblLabels.First;

  FrmShowCompiled.tblErrors.Close;
  FrmShowCompiled.tblErrors.Open;
  FrmShowCompiled.tblErrors.EmptyTable;

  for i := 0 to Length(AsmOISC.Errors) - 1 do
  begin
    FrmShowCompiled.tblErrors.Append;

    try
      FrmShowCompiled.tblErrorsLine.AsInteger := AsmOISC.Errors[i].Line;
      FrmShowCompiled.tblErrorsSeq.AsInteger := FrmShowCompiled.tblErrors.RecordCount;
      FrmShowCompiled.tblErrorsError.AsString := AsmOISC.Errors[i].Error;
      FrmShowCompiled.tblErrors.Post;
    except
      FrmShowCompiled.tblErrors.Cancel;
      raise;
    end;
  end;

  FrmShowCompiled.tblErrors.First;

  FrmShowCompiled.Show;
end;

end.

