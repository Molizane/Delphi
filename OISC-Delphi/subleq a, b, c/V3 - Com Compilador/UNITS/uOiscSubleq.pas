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
    lblHalt: TLabel;
    lblRunning: TLabel;
    lblPaused: TLabel;
    btnClear: TBitBtn;
    btnStart: TBitBtn;
    btnPause: TBitBtn;
    btnHalt: TBitBtn;
    btnReset: TBitBtn;
    lblError: TLabel;
    btnView: TBitBtn;
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnHaltClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DisplayKeyPress(Sender: TObject; var Key: Char);
    procedure btnStartClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
  private
    FLines: TLinesTokens;
    FLabels: TArrDefs;
    FErrors: TArrErrors;
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
  StrUtils, uShowCompiled, DB;

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
  Progr2: array[0..37] of string = (
    {00}'  BEGIN:',
    {00}'   DC NR -1',
    {00}'   DC PRN $FFFFFFFF',
    {00}'   DC HALT $FFFFFFFF',
    {00}'   ORG 3',
    {00}'   DC ZRO 0',
    {00}'START:',
    {00}'   subleq CHR  CHR         // if {CHR = CHR - CHR) = 0 goto next    // Limpa CHR',
    {03}'   subleq INI  PNT         // if {PNT = PNT - INI) = 0 goto next    // Obtém posição do caracter (-PNT)',
    {06}'   subleq PNT  CHR         // if {CHR = CHR - PNT) = 0 goto next    // Coloca o caracter em CHR',
    {09}'   subleq PNT  PNT         // if {PNT = PNT - PNT) = 0 goto CHR     // Limpa PNT',
    {12}'CHR: subleq ZRO  PRN       // Print PRN (INITXT ~ FIMTXT)',
    {15}'   subleq NEG  INI         // if {INI = INI - NEG) = 0 goto next    // Incrementa INI',
    {18}'   subleq CHR  CHR         // if {CHR = CHR - CHR) = 0 goto next    // Limpa CHR',
    {21}'   subleq FIM  PNT         // if {PNT = PNT - FIMTXT) = 0 goto next // PNT = -FIMTXT = -FIM',
    {24}'   subleq PNT  CHR         // if {CHR = CHR - PNT) = 0 goto next ',
    {27}'   subleq PNT  PNT         // if {PNT = PNT - PNT) = 0 goto next',
    {30}'   subleq INI  CHR  HALT   // if (CHR = CHR - INI) = 0 HALT',
    {33}'   subleq PNT  PNT  START  // if {PNT = PNT - PNT) = 0 goto 0',
    {36}'INI: DD  INITXT',
    {37}'FIM: DD  FIMTXT',
    {38}'PNT: DD  ZRO',
    {39}'NEG: DD  NR',
    {40}'INITXT:',
    {41}'     DD  12 72 101 // CLS "H" "E"',
    {44}'     DD 108  // L',
    {45}'     DD 108  // L',
    {46}'     DD 111  // O',
    {47}'     DD  44  // ',
    {48}'     DD  32  //',
    {49}'     DD  87  // W',
    {50}'     DD 111  // O',
    {51}'     DD 114  // R',
    {52}'     DD 108  // L',
    {53}'     DD 100  // D',
    {54}'     DD  33  // !',
    {55}'     DD  10  // LF',
    {56}'FIMTXT:'
    );

  // Welcome!
  Progr3: array[0..39] of string = (
    {00}'  BEGIN:',
    {00}'   DC NR -1',
    {00}'   DC PRN $FFFFFFFF',
    {00}'   DC HALT $FFFFFFFF',
    {00}'   ORG 3',
    {00}'   DC ZRO 0',
    {00}'START:',
    {00}'   subleq CHR  CHR         // if {CHR = CHR - CHR) = 0 goto next    // Limpa CHR',
    {03}'   subleq INI  PNT         // if {PNT = PNT - INI) = 0 goto next    // Obtém posição do caracter (-PNT)',
    {06}'   subleq PNT  CHR         // if {CHR = CHR - PNT) = 0 goto next    // Coloca o caracter em CHR',
    {09}'   subleq PNT  PNT         // if {PNT = PNT - PNT) = 0 goto CHR     // Limpa PNT',
    {12}'CHR: subleq ZRO  PRN       // Print PRN (INITXT ~ FIMTXT)',
    {15}'   subleq NEG  INI         // if {INI = INI - NEG) = 0 goto next    // Incrementa INI',
    {18}'   subleq CHR  CHR         // if {CHR = CHR - CHR) = 0 goto next    // Limpa CHR',
    {21}'   subleq FIM  PNT         // if {PNT = PNT - FIMTXT) = 0 goto next // PNT = -FIMTXT = -FIM',
    {24}'   subleq PNT  CHR         // if {CHR = CHR - PNT) = 0 goto next ',
    {27}'   subleq PNT  PNT         // if {PNT = PNT - PNT) = 0 goto next',
    {30}'   subleq INI  CHR  HALT   // if (CHR = CHR - INI) = 0 HALT',
    {33}'   subleq PNT  PNT  START  // if {PNT = PNT - PNT) = 0 goto 0',
    {36}'INI: DD  INITXT',
    {37}'FIM: DD  FIMTXT',
    {38}'PNT: DD  ZRO',
    {39}'NEG: DD  NR',
    {40}'INITXT:',
    {41}'	DD  12		// CLS',
    {42}'	DD  79		// O',
    {43}'	DD  73		// I',
    {44}'	DD  83		// S',
    {45}'	DD  67		// C',
    {46}'	DD  32		// SPC',
    {47}'	DD  69		// E',
    {48}'	DD  109		// m',
    {49}'	DD  117		// u',
    {50}'	DD  108		// l',
    {51}'	DD  97		// a',
    {52}'	DD  116		// t',
    {53}'	DD  111		// o',
    {54}'	DD  114		// r',
    {55}'	DD  10		// LF',
    {56}'FIMTXT:'
    );

  //(*
  // Lê o teclado e exibe na tela. ESC para parar.
  Progr4: array[0..27] of string = (
    {00}'   ORG 0',
    {00}'   DC NR -1',
    {00}'   DC PRN $FFFFFFFF',
    {00}'   DC INKEY $FFFFFFFF',
    {00}'   DC HALT $FFFFFFFF',
    {00}'   DC ZR 0',
    {00}'START:',
    {00}'   subleq  KEY  KEY       // if (KEY = KEY - KEY) <= 0 goto 3 --> KEY = 0',
    {03}'   subleq  CLS  KEY       // if (KEY = KEY - CLS) <= 0 goto 3 --> KEY = 0 - (-12) = 12',
    {06}'   subleq  KEY  PRN        // Print Chr(12) = CLS',
    {09}'LOOP:',
    {09}'   subleq  INKEY   KEY       // KEY = InKey',
    {12}'   subleq  ZRO  ZRO       // if (ZRO = ZRO - ZRO) <= 0 goto 15 --> ZRO = 0',
    {15}'   subleq  ESC  ZRO       // if (ZRO = ZRO - ESC) <= 0 goto 18 --> ZRO = 0 - (-27) = 27',
    {18}'   subleq  KEY  ZRO       // if (ZRO = ZRO - KEY) <= 0 goto 21 --> ZRO = 27 - Key',
    {21}'   subleq  ZRO  BUF  HLT  // if (BUF = BUF - ZRO) <= 0 goto 27 --> BUF = 0 - (27 - Key) ==> Se tecla < 27 BUF <= 0; pula para HLT',
    {24}'   subleq  BUF  BUF  PRT  // if (BUF = BUF - BUF) <= 0 goto PRT --> BUF = 0',
    {27}'   subleq  BUF  BUF  HLT  // if (BUF = BUF - BUF) <= 0 goto HLT --> BUF = 0',
    {30}'HLT:',
    {30}'   subleq  BUF  ZRO  HALT   // if (ZRO = ZRO - BUF) <= 0 HALT',
    {33}'PRT:',
    {36}'   subleq  KEY  PRN        // Print KEY',
    {39}'   subleq  BUF  BUF  LOOP // if (BUF = BUF - BUF) <= 0 goto LOOP --> BUF = 0',
    {42}'BUF: DD ZR  // Buffer',
    {43}'KEY: DD ZR  // InKey',
    {44}'ZRO: DD ZR  // Zero Flag',
    {45}'ESC: DD -27 // ESC',
    {46}'CLS: DD -12 // CLS'
    );
  //*)

var
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

  LblHalt.Caption := ' HALTED at ' + IntToStr(Addr) + ' ';
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
  LblPaused.Caption := ' PAUSED at ' + IntToStr(Addr) + ' ';
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
begin
  if Assigned(ThreadOisc) and ThreadOisc.Paused then
    ThreadOisc.ExecRun
  else
  begin
    ThreadOisc := TOISCSubleq.Create(True, Progr3, FLines, FLabels, FErrors);
    ThreadOisc.OnHalt := HaltEvent;
    ThreadOisc.OnPause := PauseEvent;
    ThreadOisc.OnReadChar := Read;
    ThreadOisc.OnReset := ResetEvent;
    ThreadOisc.OnError := ErrorEvent;
    ThreadOisc.OnStart := StartEvent;
    ThreadOisc.OnWriteText := Write;
  end;

  btnView.Enabled := Length(FLines) > 0;

  if btnView.Enabled and (Length(FErrors) > 0) then
    btnView.Click;
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

procedure TFrmOISCSubleq.btnLoadClick(Sender: TObject);
begin
  //ThreadOisc.LoadProgr(Progr2);
  Display.SetFocus;
end;

procedure TFrmOISCSubleq.ErrorEvent(Sender: TObject; Addr: Longword; Error: Integer);
begin
  lblRunning.Visible := False;
  lblError.Caption := ' ERROR ' + IntToStr(Error) + ' at ' + IntToStr(Addr) + ' ';
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

  for i := 0 to Length(FLines) - 1 do
  begin
    FrmShowCompiled.tblProgr.Append;

    try
      FrmShowCompiled.tblProgrAddress.AsInteger := FLines[i].Address;
      FrmShowCompiled.tblProgrLabel.AsString := FLines[i].Lbl;
      FrmShowCompiled.tblProgrOperator.AsString := FLines[i].Oper;
      FrmShowCompiled.tblProgrA.AsString := FLines[i].A;
      FrmShowCompiled.tblProgrB.AsString := FLines[i].B;
      FrmShowCompiled.tblProgrC.AsString := FLines[i].C;
      FrmShowCompiled.tblProgrObs.AsString := FLines[i].Comment;
      FrmShowCompiled.tblProgrError.AsBoolean := FLines[i].Error;
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

  for i := 0 to Length(FLabels) - 1 do
  begin
    FrmShowCompiled.tblLabels.Append;

    try
      FrmShowCompiled.tblLabelsName.AsString := FLabels[i].Name;
      FrmShowCompiled.tblLabelsContent.AsString := FLabels[i].Content;
      FrmShowCompiled.tblLabelsLine.AsInteger := FLabels[i].Line;
      FrmShowCompiled.tblLabelsValidNumber.AsBoolean := FLabels[i].ValidNumber;
      FrmShowCompiled.tblLabelsIsLabel.AsBoolean := FLabels[i].IsLabel;
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

  for i := 0 to Length(FErrors) - 1 do
  begin
    FrmShowCompiled.tblErrors.Append;

    try
      FrmShowCompiled.tblErrorsLine.AsInteger := FErrors[i].Line;
      FrmShowCompiled.tblErrorsSeq.AsInteger := FrmShowCompiled.tblErrors.RecordCount;
      FrmShowCompiled.tblErrorsError.AsString := FErrors[i].Error;
      FrmShowCompiled.tblErrors.Post;
    except
      FrmShowCompiled.tblErrors.Cancel;
      raise;
    end;
  end;

  FrmShowCompiled.tblErrors.First;

  FrmShowCompiled.ShowModal;
end;

end.

