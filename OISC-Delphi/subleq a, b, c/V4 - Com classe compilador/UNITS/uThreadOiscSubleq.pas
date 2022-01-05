unit uThreadOiscSubleq;

interface

uses
  Classes, Windows, SysUtils, uCompOiscSubleq;

type
  TOISCIn = function: Char of object;
  TOISCOut = procedure(str: string) of object;
  THaltEvent = procedure(Sender: TObject; Addr: Longword) of object;
  TPauseEvent = procedure(Sender: TObject; Addr: Longword) of object;
  TResetEvent = procedure(Sender: TObject; Addr: Longword) of object;
  TErrorEvent = procedure(Sender: TObject; Addr: Longword; Err: Integer) of object;

  TOISCSubleq = class(TThread)
  private
    FAddr: Longword;
    FBase: Longword;
    FError: Integer;
    FMemTop: Word;
    FOISCIn: TOISCIn;
    FOISCOut: TOISCOut;
    FMemory: TIntegerArray;
    FIsRunning: Boolean;
    FIsHalted: Boolean;
    FIsPaused: Boolean;
    FIsReset: Boolean;
    TxtBuff: string;
    ChrBuff: Char;
    FOnHalt: THaltEvent;
    FOnStart: TNotifyEvent;
    FOnPause: TPauseEvent;
    FOnReset: TResetEvent;
    FOnError: TErrorEvent;
  protected
    procedure Execute; override;
    procedure ReadChar;
    procedure WriteChar;
    procedure WriteString;
    procedure GoRunning;
    procedure GoHalted;
    procedure GoPaused;
    procedure ErrorTrap;
  public
    constructor Create(CreateSuspended: Boolean);
    procedure LoadProgr(Progr: TIntegerArray; Start: LongWord);
    procedure ExecPause;
    procedure ExecRun;
    procedure ExecHalt;
    procedure ExecReset;
    function Paused: Boolean;
    property Memory: TIntegerArray read FMemory;
    property OnStart: TNotifyEvent read FOnStart write FOnStart;
    property OnPause: TPauseEvent read FOnPause write FOnPause;
    property OnHalt: THaltEvent read FOnHalt write FOnHalt;
    property OnReset: TResetEvent read FOnReset write FOnReset;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnReadChar: TOISCIn read FOISCIn write FOISCIn;
    property OnWriteText: TOISCOut read FOISCOut write FOISCOut;
  end;

implementation

uses
  StrUtils, Math;

var
  CS: TRTLCriticalSection;

  { TOISCSubleq }

constructor TOISCSubleq.Create(CreateSuspended: Boolean);
begin
  inherited Create(False);

  Priority := tpNormal;
  FreeOnTerminate := True;

  FIsRunning := False;
  FIsHalted := False;
  FIsPaused := True;
  FIsReset := False;

  SetLength(FMemory, 0);
  FBase := 0;
end;

procedure TOISCSubleq.Execute;
var
  A, B, C: Integer;
  Ax: LongWord absolute A;
  Bx: LongWord absolute B;
  Cx: LongWord absolute C;
begin
  FAddr := FBase;

  if Length(FMemory) = 0 then
  begin
    FError := 1;
    Synchronize(ErrorTrap);
    Exit;
  end;

  FError := 0;
  ExecRun;

  while not Terminated do
  begin
    if FAddr + 3 > FMemTop then
    begin
      FError := 2;
      Synchronize(ErrorTrap);
      Break;
    end;

    if FIsReset then
    begin
      FAddr := FBase;
      FIsReset := False;
    end
    else if FIsHalted then
      Break
    else if FIsPaused then
      Continue;

    A := FMemory[FAddr];
    B := FMemory[FAddr + 1];
    C := FMemory[FAddr + 2];

    if Ax = $FFFFFFFF then // Ler teclado e armazenar em FMemory[Bx] // Espera até tecla ser pressionada
    begin
      if Assigned(FOISCIn) then
      begin
        Synchronize(ReadChar);

        while not (FIsHalted or FIsReset or FIsPaused) and (ChrBuff = #0) do
          Synchronize(ReadChar);

        if FIsHalted or FIsReset or FIsPaused then
          Continue;

        FMemory[Bx] := Ord(ChrBuff);
      end
      else
        FMemory[Bx] := 0;
    end
    else if Ax = $FFFFFFFE then // Ler teclado e armazenar em FMemory[Bx] // Não espera tecla ser pressionada
    begin
      Synchronize(ReadChar);
      FMemory[Bx] := Ord(ChrBuff);
    end
    else if Ax > FMemTop then
    begin
      FError := 3;
      Synchronize(ErrorTrap);
      Break;
    end
    else if Bx = $FFFFFFFF then // Exibir conteúdo de FMemory[Ax]
    begin
      ChrBuff := Chr(FMemory[Ax]);
      Synchronize(WriteChar);
    end
    else if Bx > FMemTop then
    begin
      FError := 4;
      Synchronize(ErrorTrap);
      Break;
    end
    else // Executar o processo
    begin
      FMemory[Bx] := FMemory[Bx] - FMemory[Ax];

      if FMemory[Bx] <= 0 then
        if Cx = $FFFFFFFF then // Executa HALT
        begin
          ExecHalt;
          Break;
        end
        else if Cx > FMemTop then
        begin
          FError := 5;
          Synchronize(ErrorTrap);
          Break;
        end
        else
        begin
          FAddr := Cx;
          Continue;
        end;
    end;

    Inc(FAddr, 3);
  end;
end;

procedure TOISCSubleq.WriteString;
var
  i: Integer;
begin
  if Assigned(FOISCOut) then
  begin
    for i := 1 to Length(TxtBuff) do
      FOISCOut(TxtBuff[i]);

    TxtBuff := '';
  end;
end;

procedure TOISCSubleq.GoHalted;
begin
  FIsHalted := True;
  FIsPaused := False;

  if Assigned(FOnHalt) then
    FOnHalt(Self, Self.FAddr);
end;

procedure TOISCSubleq.ReadChar;
begin
  if Assigned(FOISCIn) then
    ChrBuff := FOISCIn()
  else
    ChrBuff := #0;
end;

procedure TOISCSubleq.GoRunning;
begin
  if FIsHalted then
    Exit;

  FIsReset := False;
  FIsHalted := False;
  FIsPaused := False;

  if Assigned(FOnStart) then
    FOnStart(Self);
end;

procedure TOISCSubleq.WriteChar;
begin
  if Assigned(FOISCOut) then
  begin
    FOISCOut(ChrBuff);
    ChrBuff := #0;
  end;
end;

procedure TOISCSubleq.GoPaused;
begin
  FIsPaused := True;

  if Assigned(FOnPause) then
    FOnPause(Self, Self.FAddr);
end;

procedure TOISCSubleq.ExecHalt;
begin
  EnterCriticalSection(CS);

  try
    Synchronize(GoHalted);
  finally
    LeaveCriticalSection(CS);
  end;
end;

procedure TOISCSubleq.ExecPause;
begin
  EnterCriticalSection(CS);

  try
    if not FIsPaused then
    begin
      Synchronize(GoPaused);
    end;
  finally
    LeaveCriticalSection(CS);
  end;
end;

procedure TOISCSubleq.ExecRun;
begin
  EnterCriticalSection(CS);

  try
    if FIsPaused then
      Synchronize(GoRunning);
  finally
    LeaveCriticalSection(CS);
  end;
end;

procedure TOISCSubleq.ExecReset;
begin
  EnterCriticalSection(CS);

  try
    FIsReset := True;
    FIsHalted := False;
    FIsPaused := False;

    if Assigned(FonReset) then
      FOnReset(Self, Self.FAddr);
  finally
    LeaveCriticalSection(CS);
  end;
end;

procedure TOISCSubleq.LoadProgr(Progr: TIntegerArray; Start: LongWord);
var
  i: Longword;
begin
  ExecPause;

  EnterCriticalSection(CS);

  try
    SetLength(FMemory, Length(Progr));

    if Length(Progr) > 0 then
    begin
      for i := 0 to Length(Progr) - 1 do
        FMemory[i] := Progr[i];

      FMemTop := High(FMemory);
      FBase := Start;
    end
    else
    begin
      FMemTop := 0;
      FBase := 0;
    end;

  finally
    LeaveCriticalSection(CS);
  end;
end;

function TOISCSubleq.Paused: Boolean;
begin
  Result := FIsPaused;
end;

procedure TOISCSubleq.ErrorTrap;
begin
  FIsHalted := True;
  FIsPaused := False;

  if Assigned(FOnError) then
    FOnError(Self, Self.FAddr, Self.FError);
end;

initialization
  InitializeCriticalSection(CS);
  //OleInitialize(nil);

finalization
  DeleteCriticalSection(CS);
  //OleUninitialize;

end.

