unit uThreadOiscSubleq;

interface

uses
  Classes, Windows, SysUtils;

type
  TLineTokens = record
    Lbl: string;
    Oper: string;
    A: string;
    B: string;
    C: string;
    Comment: string;
    Result: string;
    Address: Integer;
    Error: Boolean;
  end;

  TLinesTokens = array of TLineTokens;

  TError = record
    Line: Integer;
    Error: string;
  end;

  TArrErrors = array of TError;

  TOISCIn = function: Char of object;
  TOISCOut = procedure(str: string) of object;
  THaltEvent = procedure(Sender: TObject; Addr: Longword) of object;
  TPauseEvent = procedure(Sender: TObject; Addr: Longword) of object;
  TResetEvent = procedure(Sender: TObject; Addr: Longword) of object;
  TErrorEvent = procedure(Sender: TObject; Addr: Longword; Err: Integer) of object;

  TDefs = record
    Name: string;
    Content: string;
    Line: Integer;
    ValidNumber: Boolean;
    IsLabel: Boolean;
  end;

  TArrDefs = array of TDefs;

  TIntegerArray = array of Integer;

  TOISCSubleq = class(TThread)
  private
    FAddr: Longword;
    FError: Integer;
    FMemTop: Word;
    FOISCIn: TOISCIn;
    FOISCOut: TOISCOut;
    FMemory: TIntegerArray;
    FIsRunning: Boolean;
    FIsHalted: Boolean;
    FIsPaused: Boolean;
    FIsReset: Boolean;
    FTxtBuff: string;
    FChrBuff: Char;
    FOnHalt: THaltEvent;
    FOnStart: TNotifyEvent;
    FOnPause: TPauseEvent;
    FOnReset: TResetEvent;
    FOnError: TErrorEvent;
  protected
    constructor Create(CreateSuspended: Boolean); overload;
    procedure Execute; override;
    procedure ReadChar;
    procedure WriteChar;
    procedure WriteString;
    procedure GoRunning;
    procedure GoHalted;
    procedure GoPaused;
    procedure ErrorTrap;
    procedure LoadProgr(Progr: array of Integer); overload;
    procedure LoadProgr(Progr: array of string; var pLines: TLinesTokens; var pLabels: TArrDefs; var pErrors: TArrErrors); overload;
  public
    constructor Create(CreateSuspended: Boolean; Progr: array of Integer); overload;
    constructor Create(CreateSuspended: Boolean; Progr: array of string; var pLines: TLinesTokens; var pLabels: TArrDefs; var pErrors: TArrErrors); overload;
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

{ TOISCSubleq }

var
  CS: TRTLCriticalSection;

function GetToken(var str: string; const Tokens: string): string;
var
  n, i: Integer;
begin
  n := 1;

  while n <= Length(str) do
    if ((Tokens = '') and (str[n] > #32)) or ((Tokens <> '') and not IsDelimiter(Tokens, str, n)) then
      Break
    else
      Inc(n);

  i := n;

  while i <= Length(str) do
    if ((Tokens = '') and (str[i] <= #32)) or ((Tokens <> '') and IsDelimiter(Tokens, str, i)) then
      Break
    else
      Inc(i);

  if i > Length(str) then
  begin
    Result := str;
    str := '';
    Exit;
  end;

  Result := Copy(str, n, i - n);

  while i <= Length(str) do
  begin
    if ((Tokens = '') and (str[i] <= #32)) or ((Tokens <> '') and IsDelimiter(Tokens, str, i)) then
    begin
      Inc(i);
      Break;
    end;

    Inc(i);
  end;

  if i > Length(str) then
    str := ''
  else
    str := Copy(str, i, Length(str) - i + 1);
end;

function Tokenizer(str: string; Token: string): TLineTokens;
var
  tk: string;
begin
  Result.Lbl := '';
  Result.Oper := '';
  Result.A := '';
  Result.B := '';
  Result.C := '';
  Result.Comment := '';
  Result.Result := '';
  Result.Address := 0;
  Result.Error := False;

  if Trim(str) = '' then
  begin
    Result.Result := 'EMPTY';
    Exit;
  end
  else if LeftStr(Trim(str), 2) = '//' then
  begin
    Result.Comment := ' ' + Trim(Copy(Trim(str), 3, Length(str)));
    Exit;
  end
  else
    tk := Trim(GetToken(str, Token));

  while tk <> '' do
  begin
    if RightStr(tk, 1) = ':' then
      Result.Lbl := LeftStr(tk, Length(tk) - 1)
    else if SameText(tk, 'ORG') then
    begin
      Result.Oper := tk;

      if LeftStr(Trim(str), 2) <> '//' then
      begin
        tk := Trim(GetToken(str, Token));
        Result.A := tk;
      end;
    end
    else if SameText(tk, 'DC') then
    begin
      Result.Oper := tk;

      if LeftStr(Trim(str), 2) <> '//' then
      begin
        tk := Trim(GetToken(str, Token));
        Result.A := tk;
      end;

      if LeftStr(Trim(str), 2) <> '//' then
      begin
        tk := Trim(GetToken(str, Token));
        Result.B := tk;
      end;
    end
    else if Pos(';' + UpperCase(tk) + ';', ';SUBLEQ;DD;') <> 0 then
    begin
      Result.Oper := tk;

      if LeftStr(Trim(str), 2) <> '//' then
      begin
        tk := Trim(GetToken(str, Token));
        Result.A := tk;
      end;

      if LeftStr(Trim(str), 2) <> '//' then
      begin
        tk := Trim(GetToken(str, Token));
        Result.B := tk;
      end;

      if LeftStr(Trim(str), 2) <> '//' then
      begin
        tk := Trim(GetToken(str, Token));
        Result.C := tk;
      end;
    end;

    if LeftStr(Trim(str), 2) = '//' then
    begin
      Result.Comment := ' ' + Trim(Copy(Trim(str), 3, Length(str)));
      Exit;
    end
    else if Trim(str) = '' then
      Exit
    else
      tk := Trim(GetToken(str, Token));
  end;
end;

procedure AddError(var pErrors: TArrErrors; Line: Integer; Error: string);
begin
  SetLength(pErrors, Length(pErrors) + 1);
  pErrors[High(pErrors)].Line := Line;
  pErrors[High(pErrors)].Error := Error;
end;

function ValidLabel(sLabel: string): Boolean;
var
  i: Integer;
begin
  Result := False;

  if Trim(sLabel) = '' then
    Exit;

  if not ((sLabel[1] in ['A'..'Z', 'a'..'z', '_']) and (sLabel[1] < #128)) then
    Exit;

  for i := 2 to Length(sLabel) do
    if not ((sLabel[1] in ['A'..'Z', 'a'..'z', '0'..'9', '_']) and (sLabel[1] < #128)) then
      Exit;

  Result := True;
end;

function ValidNumber(str: string; Base: Byte): Boolean;
var
  lDig: Char;
  i, n: Integer;
begin
  Result := False;

  if Trim(str) = '' then
    Exit;

  if ((Base = 2) and (str[1] = '&')) or ((Base = 16) and (str[1] = '$')) then
    n := 2
  else
    n := 1;

  if Base <= 10 then
  begin
    lDig := IntToStr(Base - 1)[1];

    for i := n to Length(str) do
      if not (str[i] in ['0'..lDig, '-']) then
        Exit;
  end
  else
  begin
    lDig := Chr(55 + (Base - 1));

    for i := n to Length(str) do
      if not (str[i] in ['0'..'9', 'A'..lDig]) then
        Exit;
  end;

  Result := True;
end;

function BinToInt64(bin: string): Int64;
var
  i: Integer;
  Pwr: Integer;
begin
  Result := 0;
  Pwr := 0;

  for i := Length(bin) to 1 do
  begin
    if bin[i] <> '0' then
      Result := Result + Trunc(Power(2, Pwr));

    Inc(Pwr);
  end;
end;

function CompOISC(Source: array of string; var pLines: TLinesTokens; var pLabels: TArrDefs; var pErrors: TArrErrors; var nOrg: LongWord): TIntegerArray;
const
  Reserved = ';ORG;DD;DC;SUBLEQ;';
var
  i, n, c: Integer;
  nOrdem: Integer;
  FLabel, FORG: Boolean;
  ped, CurrLbl: string;
  nLabel: Int64;
begin
  SetLength(Result, 0);
  SetLength(pErrors, 0);
  SetLength(pLabels, 0);
  SetLength(pLines, Length(Source));

  nOrdem := 0;
  nOrg := 0;
  FORG := False;
  nLabel := 0;
  FLabel := False;
  CurrLbl := '';

  // Passo 1: Labels, constantes e endereço do código
  for i := Low(Source) to High(Source) do
  begin
    pLines[i] := Tokenizer(Source[i], '');
    pLines[i].Address := nOrdem;

    if pLines[i].Result = 'EMPTY' then
      Continue;

    if pLines[i].Lbl <> '' then
    begin
      ped := pLines[i].Lbl;

      if (ped = '') or not ValidLabel(ped) then
      begin
        pLines[i].Error := True;
        AddError(pErrors, i, 'Invalid label "' + ped + '"');
      end
      else if Pos(';' + UpperCase(ped) + ';', Reserved) <> 0 then
      begin
        pLines[i].Error := True;
        AddError(pErrors, i, 'Label "' + ped + '" is reserved word');
      end
      else
      begin
        for n := 0 to Length(pLabels) - 1 do
          if SameText(ped, pLabels[n].Name) then
          begin
            pLines[i].Error := True;
            AddError(pErrors, i, 'Label "' + ped + '" already defined');
            Continue;
          end;

        SetLength(pLabels, Length(pLabels) + 1);
        pLabels[High(pLabels)].Name := ped;
        pLabels[High(pLabels)].Content := IntToStr(nOrdem);
        pLabels[High(pLabels)].ValidNumber := True;
        pLabels[High(pLabels)].Line := i;
        pLabels[High(pLabels)].IsLabel := True;

        if not FLabel then
        begin
          FLabel := True;
          CurrLbl := ped;
          nLabel := i;
        end;
      end;
    end;

    if SameText(pLines[i].Oper, 'DC') then // Define Constant
    begin
      ped := pLines[i].A;

      if ped = '' then
      begin
        pLines[i].Error := True;
        AddError(pErrors, i, 'Constant name misdefined');
      end
      else if not ValidLabel(ped) then
      begin
        pLines[i].Error := True;
        AddError(pErrors, i, 'Invalid constant name "' + ped + '"');
      end
      else if Pos(';' + UpperCase(ped) + ';', Reserved) <> 0 then
      begin
        pLines[i].Error := True;
        AddError(pErrors, i, 'Constant name "' + ped + '" is reserved word');
      end
      else
      begin
        for n := 0 to Length(pLabels) - 1 do
          if SameText(ped, pLabels[n].Name) then
          begin
            pLines[i].Error := True;
            AddError(pErrors, i, 'Constant name "' + ped + '" already defined');
            Break;
          end;

        if pLines[i].B = '' then
        begin
          pLines[i].Error := True;
          AddError(pErrors, i, 'Constant "' + ped + '" misdefined');
        end
        else
        begin
          ped := pLines[i].B;

          SetLength(pLabels, Length(pLabels) + 1);

          pLabels[High(pLabels)].Name := pLines[i].A;
          pLabels[High(pLabels)].Line := i;
          pLabels[High(pLabels)].IsLabel := False;
          pLabels[High(pLabels)].Content := ped; // Valor da constante

          if ped[1] = '$' then
            pLabels[High(pLabels)].ValidNumber := ValidNumber(ped, 16)
          else if ped[1] = '&' then
            pLabels[High(pLabels)].ValidNumber := ValidNumber(ped, 2)
          else
            pLabels[High(pLabels)].ValidNumber := ValidNumber(ped, 10);

          pLabels[High(pLabels)].Content := ped;
        end;
      end;
    end
    else if SameText(pLines[i].Oper, 'DD') then
    begin
      if pLines[i].A = '' then
      begin
        pLines[i].Error := True;
        AddError(pErrors, i, '"DD" without value');
      end
      else
      begin
        Inc(nOrdem);

        if pLines[i].B <> '' then
        begin
          Inc(nOrdem);

          if pLines[i].C <> '' then
            Inc(nOrdem);
        end;
      end;
    end
    else if SameText(pLines[i].Oper, 'ORG') then
    begin
      if FORG then
      begin
        pLines[i].Error := True;
        AddError(pErrors, i, '"ORG" redefined');
      end
      else
      begin
        ped := pLines[i].A;

        if ped[1] = '$' then
          FORG := ValidNumber(ped, 16)
        else if ped[1] = '&' then
          FORG := ValidNumber(ped, 2)
        else
          FORG := ValidNumber(ped, 10);

        if FORG then
          if ped[1] = '&' then
            nOrdem := BinToInt64(ped)
          else
            nOrdem := StrToInt(ped);

        if not FORG then
        begin
          pLines[i].Error := True;
          AddError(pErrors, i, 'Invalid "ORG" address. Must be a valid number');
        end
        else if nOrdem mod 3 <> 0 then
        begin
          nOrdem := 0;
          pLines[i].Error := True;
          AddError(pErrors, i, 'Invalid "ORG" address. Must be a multiple of 3');
        end
        else
        begin
          nOrg := nOrdem;

          if FLabel then // Existe um label pendente; atualiza seu endereço no intervalo
          begin
            // Atualiza os endereços entre o label e a operação
            for n := nLabel to i do
            begin
              pLines[n].Address := nOrdem;

              if pLines[n].Lbl <> '' then
                for c := 0 to Length(pLabels) - 1 do
                  if SameText(pLabels[c].Name, pLines[n].Lbl) then
                  begin
                    pLabels[c].Content := IntToStr(nOrdem);
                    Break;
                  end;
            end;

            FLabel := False;
            FORG := True;
          end
          else
            pLines[i].Address := nOrdem;
        end;
      end
    end
    else if SameText(pLines[i].Oper, 'subleq') then
    begin
      Inc(nOrdem, 3);

      if pLines[i].C = '' then
        pLines[i].C := IntToStr(nOrdem);
    end;
  end;

  // Varre os labels e ajusta as referências nas constantes
  for i := Low(pLabels) to High(pLabels) do
    if not pLabels[i].ValidNumber then
    begin
      for n := Low(pLabels) to High(pLabels) do
        if SameText(pLabels[i].Content, pLabels[n].Name) then
        begin
          pLabels[i].Content := pLabels[n].Content;
          pLabels[i].ValidNumber := True;
          Break;
        end;

      if not pLabels[i].ValidNumber then
      begin
        pLines[i].Error := True;
        AddError(pErrors, pLabels[i].Line, '"' + pLabels[i].Content + '" not defined');
      end;
    end;

  // Faz a substituição das constantes
  for i := Low(pLines) to High(pLines) do
  begin
    CurrLbl := pLines[i].Oper;

    if CurrLbl = '' then
      Continue;

    // A
    if SameText(CurrLbl, 'ORG') or SameText(CurrLbl, 'DD') or SameText(CurrLbl, 'subleq') then
    begin
      // verifica e atualiza a constante com seu valor
      ped := pLines[i].A;

      if ped = '' then
        FLabel := True
      else if ped[1] = '$' then
        FLabel := not ValidNumber(ped, 16)
      else if ped[1] = '&' then
        FLabel := not ValidNumber(ped, 2)
      else if ped[1] in ['0'..'9'] then
        FLabel := not ValidNumber(ped, 10)
      else
        FLabel := True;

      // procura
      if FLabel then
        for n := Low(pLabels) to High(pLabels) do
          if SameText(ped, pLabels[n].Name) then
          begin
            if pLabels[n].ValidNumber then
              pLines[i].A := {pLines[i].A + ' [' +} pLabels[n].Content {+ ']'};

            Break;
          end;
    end;

    // B, C
    if SameText(CurrLbl, 'DD') or SameText(CurrLbl, 'subleq') or SameText(CurrLbl, 'DC') then
    begin
      // B
      ped := pLines[i].B;

      if ped = '' then
        FLabel := True
      else if ped[1] = '$' then
        FLabel := not ValidNumber(ped, 16)
      else if ped[1] = '&' then
        FLabel := not ValidNumber(ped, 2)
      else if ped[1] in ['0'..'9', '-'] then
        FLabel := not ValidNumber(ped, 10)
      else
        FLabel := True;

      // procura
      if FLabel then
        for n := Low(pLabels) to High(pLabels) do
          if SameText(ped, pLabels[n].Name) then
          begin
            if pLabels[n].ValidNumber then
              pLines[i].B := {pLines[i].B + ' [' +} pLabels[n].Content {+ ']'};

            Break;
          end;

      if SameText(CurrLbl, 'DC') then
        pLines[i].Address := StrToInt(pLines[i].B);

      // C
      if SameText(CurrLbl, 'DD') or SameText(CurrLbl, 'subleq') then
      begin
        ped := pLines[i].C;

        if ped = '' then
          FLabel := True
        else if ped[1] = '$' then
          FLabel := not ValidNumber(ped, 16)
        else if ped[1] = '&' then
          FLabel := not ValidNumber(ped, 2)
        else if ped[1] in ['0'..'9'] then
          FLabel := not ValidNumber(ped, 10)
        else
          FLabel := True;

        // procura
        if FLabel then
          for n := Low(pLabels) to High(pLabels) do
            if SameText(ped, pLabels[n].Name) then
            begin
              if pLabels[n].ValidNumber then
                pLines[i].C := {pLines[i].C + ' [' +} pLabels[n].Content {+ ']'};

              Break;
            end;
      end;
    end;
  end;

  if Length(pErrors) = 0 then
  begin
    if nOrg > 0 then
      for i := 1 to (nOrg div 3) do
      begin
        SetLength(Result, Length(Result) + 1);
        Result[High(Result)] := 0;

        SetLength(Result, Length(Result) + 1);
        Result[High(Result)] := 0;

        SetLength(Result, Length(Result) + 1);
        Result[High(Result)] := i * 3;
      end;

    for i := 0 to Length(pLines) - 1 do
      if SameText(pLines[i].Oper, 'DD') or SameText(pLines[i].Oper, 'subleq') then
      begin
        if pLines[i].A <> '' then
        begin
          SetLength(Result, Length(Result) + 1);
          Result[High(Result)] := StrToInt(pLines[i].A);
        end;

        if pLines[i].B <> '' then
        begin
          SetLength(Result, Length(Result) + 1);
          Result[High(Result)] := StrToInt(pLines[i].B);
        end;

        if pLines[i].C <> '' then
        begin
          SetLength(Result, Length(Result) + 1);
          Result[High(Result)] := StrToInt(pLines[i].C);
        end;
      end;
  end;
end;

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
  FAddr := 0;
end;

procedure TOISCSubleq.Execute;
var
  A, B, C: Integer;
  Ax: LongWord absolute A;
  Bx: LongWord absolute B;
  Cx: LongWord absolute C;
begin
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
      FAddr := 0;
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

        while not (FIsHalted or FIsReset or FIsPaused) and (FChrBuff = #0) do
          Synchronize(ReadChar);

        if FIsHalted or FIsReset or FIsPaused then
          Continue;

        FMemory[Bx] := Ord(FChrBuff);
      end
      else
        FMemory[Bx] := 0;
    end
    else if Ax = $FFFFFFFE then // Ler teclado e armazenar em FMemory[Bx] // Não espera tecla ser pressionada
    begin
      Synchronize(ReadChar);
      FMemory[Bx] := Ord(FChrBuff);
    end
    else if Ax > FMemTop then
    begin
      FError := 3;
      Synchronize(ErrorTrap);
      Break;
    end
    else if Bx = $FFFFFFFF then // Exibir conteúdo de FMemory[Ax]
    begin
      FChrBuff := Chr(FMemory[Ax]);
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
    for i := 1 to Length(FTxtBuff) do
      FOISCOut(FTxtBuff[i]);

    FTxtBuff := '';
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
    FChrBuff := FOISCIn()
  else
    FChrBuff := #0;
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
    FOISCOut(FChrBuff);
    FChrBuff := #0;
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

procedure TOISCSubleq.LoadProgr(Progr: array of Integer);
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
    end
    else
      FMemTop := 0;

    FAddr := 0;
  finally
    LeaveCriticalSection(CS);
  end;
end;

procedure TOISCSubleq.LoadProgr(Progr: array of string; var pLines: TLinesTokens; var pLabels: TArrDefs; var pErrors: TArrErrors);
begin
  ExecPause;

  EnterCriticalSection(CS);

  try
    FMemory := CompOISC(Progr, pLines, pLabels, pErrors, FAddr);

    if Length(FMemory) > 0 then
      FMemTop := High(FMemory)
    else
      FMemTop := 0;
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

constructor TOISCSubleq.Create(CreateSuspended: Boolean; Progr: array of Integer);
begin
  Create(CreateSuspended);

  LoadProgr(Progr);
end;

constructor TOISCSubleq.Create(CreateSuspended: Boolean; Progr: array of string; var pLines: TLinesTokens; var pLabels: TArrDefs; var pErrors: TArrErrors);
begin
  Create(CreateSuspended);

  LoadProgr(Progr, pLines, pLabels, pErrors);
end;

initialization
  InitializeCriticalSection(CS);
  //OleInitialize(nil);

finalization
  DeleteCriticalSection(CS);
  //OleUninitialize;

end.

