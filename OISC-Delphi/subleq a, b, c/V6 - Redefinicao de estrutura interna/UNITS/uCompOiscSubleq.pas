unit uCompOiscSubleq;

interface

uses
  Classes;

type
  TLineTokens = record
    Lbl: string;
    Oper: string;
    A: string;
    B: string;
    C: string;
    Comment: string;
    Result: string;
    Address: longword;
    IsRelative: boolean;
    Relative: longword;
    Error: boolean;
  end;

  TLinesTokens = array of TLineTokens;

  TError = record
    Line: integer;
    Error: string;
  end;

  TArrErrors = array of TError;

  TDefs = record
    Name: string;
    Content: string;
      Absolute, Relative: longword;
    Line: longword;
    ValidNumber: boolean;
    IsLabel: boolean;
  end;

  TArrDefs = array of TDefs;

  TAssembled = record
    Address: longword;
    case integer of
      0: (Content: integer);
      1: (Cont64: longword);
  end;

  TArrAssembled = array of TAssembled;

  TIntegerArray = array of integer;

  { TAsmOISC }

  TAsmOISC = class(TObject)
  private
    FLines: TLinesTokens;
    FLabels: TArrDefs;
    FErrors: TArrErrors;
    FSource: TStringList;
    function GetToken(var str: string; const Tokens: string): string;
    function Tokenizer(str: string; Token: string): TLineTokens;
    procedure AddError(Line: integer; Error: string);
  public
    constructor Create;
    destructor Destroy; override;
    function ValidLabel(sLabel: string): boolean;
    function ValidNumber(str: string; Base: byte): boolean; overload;
    function ValidNumber(str: string): boolean; overload;
    function BinToInt(bin: string): integer;
    function BinToInt64(bin: string): int64;
    procedure Compile(From: string; var nOrg: longword; var Memory: TArrAssembled);
    property Source: TStringList read FSource;
    property Lines: TLinesTokens read FLines;
    property Labels: TArrDefs read FLabels;
    property Errors: TArrErrors read FErrors;
  end;

implementation

uses
  Math, SysUtils, Dialogs, StrUtils;

{ TAsmOISC }

procedure TAsmOISC.AddError(Line: integer; Error: string);
begin
  SetLength(FErrors, Length(FErrors) + 1);
  FErrors[High(FErrors)].Line := Line;
  FErrors[High(FErrors)].Error := Error;
end;

function TAsmOISC.BinToInt64(bin: string): int64;
var
  i: integer;
  Pwr: integer;
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

procedure TAsmOISC.Compile(From: string; var nOrg: longword; var Memory: TArrAssembled);
const
  Reserved = ';ORG;DA;DC;DD;DS;SUBLEQ;REL;';

var
  Curr, n, c, i: integer;
  nOrdem, nDS, nTstOverFlow, nAdd, FBaseStart, FOffset, FBaseEnd: longword;
  FLabel, FStarted, FORG, FIsRelative: boolean;
  ped, CurrLbl, LblName: string;
  nLabel: int64;
  ValLong: longword;
  ValInt: integer absolute ValLong;
begin
  SetLength(Memory, 0);
  SetLength(FErrors, 0);
  SetLength(FLabels, 0);
  SetLength(FLines, 0);

  nOrdem := 0;
  nLabel := 0;
  FLabel := False;
  CurrLbl := '';
  nOrg := 0;
  FStarted := False;
  nAdd := 0;

  try
    FSource.Text := From;
    SetLength(FLines, FSource.Count);

    // Passo 1: Labels, constantes e endereço do código
    for i := 0 to FSource.Count - 1 do
    begin
      FLines[i] := Tokenizer(FSource[i], '');
      FLines[i].Address := nOrdem;

      if (Trim(FSource[i]) = '') or ((FLines[i].Lbl = '') and (FLines[i].Oper = '')) then
        Continue;

      if FLines[i].Lbl <> '' then
      begin
        LblName := FLines[i].Lbl;

        if (LblName = '') or not ValidLabel(LblName) then
        begin
          FLines[i].Error := True;
          AddError(i, 'Invalid label "' + LblName + '".');
        end
        else if Pos(';' + UpperCase(LblName) + ';', Reserved) <> 0 then
        begin
          FLines[i].Error := True;
          AddError(i, 'Label "' + LblName + '" is a reserved word.');
        end
        else
        begin
          for n := 0 to Length(FLabels) - 1 do
            if SameText(LblName, FLabels[n].Name) then
            begin
              FLines[i].Error := True;
              AddError(i, 'Label "' + LblName + '" already defined.');
              Continue;
            end;

          ped := '$' + IntToHex(nOrdem, 8);

          SetLength(FLabels, Length(FLabels) + 1);
          FLabels[High(FLabels)].Name := LblName;
          FLabels[High(FLabels)].Content := ped;
          FLabels[High(FLabels)].Absolute := nOrdem;
          FLabels[High(FLabels)].ValidNumber := True;
          FLabels[High(FLabels)].Line := i;
          FLabels[High(FLabels)].IsLabel := True;

          // Se já ocorreu geração de código (DA, DD, DS, SUBLEQ), não pode mais ajustar labels
          if not FStarted then
          begin
            FLabel := True;
            CurrLbl := LblName;
            nLabel := i;
          end;
        end;
      end;

      if SameText(FLines[i].Oper, 'SUBLEQ') then // subleq statement
      begin
        FStarted := True;

        if nOrdem mod 3 <> 0 then
        begin
          FLines[i].Error := True;
          AddError(i, 'Invalid command address. It must be a multiple of 3.');
        end
        else if nOrdem > $FFFFFFFD then
        begin
          FLines[i].Error := True;
          AddError(i, 'Address overflow');
        end
        else
        begin
          Inc(nOrdem, 3);

          if FLines[i].C = '' then
            FLines[i].C := IntToStr(nOrdem);
        end;
      end
      else if SameText(FLines[i].Oper, 'DC') then // Define Constant
      begin
        // Nome da constante
        ped := FLines[i].A;

        if ped = '' then
        begin
          FLines[i].Error := True;
          AddError(i, 'Constant name misdefined.');
        end
        else if not ValidLabel(ped) then
        begin
          FLines[i].Error := True;
          AddError(i, 'Invalid constant name "' + ped + '".');
        end
        else if Pos(';' + UpperCase(ped) + ';', Reserved) <> 0 then
        begin
          FLines[i].Error := True;
          AddError(i, 'Constant name "' + ped + '" is a reserved word.');
        end
        else
        begin
          for n := 0 to Length(FLabels) - 1 do
            if SameText(ped, FLabels[n].Name) then
            begin
              FLines[i].Error := True;
              AddError(i, 'Constant name "' + ped + '" already defined.');
              Break;
            end;

          if FLines[i].B = '' then // Valor da constante
          begin
            FLines[i].Error := True;
            AddError(i, 'Constant "' + ped + '" misdefined.');
          end
          else
          begin
            LblName := FLines[i].A;
            ped := FLines[i].B;

            SetLength(FLabels, Length(FLabels) + 1);
            FLabels[High(FLabels)].Name := LblName;
            FLabels[High(FLabels)].Content := ped;
            FLabels[High(FLabels)].Line := i;
            FLabels[High(FLabels)].IsLabel := False;
            FLabels[High(FLabels)].ValidNumber := ValidNumber(ped);

            if FLabels[High(FLabels)].ValidNumber and (ped[1] <> '$') and
              (ped[1] <> '&') then
            begin
              FLabels[High(FLabels)].Content := '$' + IntToHex(StrToInt64(ped), 8);
              FLabels[High(FLabels)].Absolute := StrToInt64(ped);
            end
            else
            begin
              FLabels[High(FLabels)].Absolute := StrToInt64(ped);
              FLabels[High(FLabels)].Content := '$' + IntToHex(FLabels[High(FLabels)].Absolute, 8);
            end;
          end;
        end;
      end
      else if SameText(FLines[i].Oper, 'DS') then
      begin
        FStarted := True;

        // Conteúdo da posição de memória
        if FLines[i].A = '' then
        begin
          FLines[i].Error := True;
          AddError(i, '"' + FLines[i].Oper + '" without values.');
        end
        else
        begin
          ped := FLines[i].A;
          FORG := ValidNumber(ped);

          if FORG then
          begin
            if ped[1] = '&' then
              nDS := BinToInt64(ped)
            else
              nDS := StrToInt64(ped);

            nTstOverFlow := nOrdem;

            // Verifica se vai dar overflow
            while nDS > 0 do
            begin
              Inc(nTstOverFlow);
              Dec(nDS);

              if (nTstOverFlow = $FFFFFFFF) and (nDS > 0) then
              begin
                FLines[i].Error := True;
                nTstOverFlow := 0;
                AddError(i, ' Invalid ' + FLines[i].Oper + ' value (' + ped + '). Overflow');
                Break;
              end;
            end;

            if nTstOverFlow > 0 then
              nOrdem := nTstOverFlow
          end
          else
          begin
            FLines[i].Error := True;
            AddError(i, ' Invalid ' + FLines[i].Oper + ' value (' + ped + ').');
          end;
        end;
      end
      else if SameText(FLines[i].Oper, 'DA') or SameText(FLines[i].Oper, 'DD') then
        // Define Absolute Data/Define Data
      begin
        FStarted := True;

        // Conteúdo da posição de memória
        if FLines[i].A = '' then
        begin
          FLines[i].Error := True;
          AddError(i, '"' + FLines[i].Oper + '" without values.');
        end
        else
        begin
          if nOrdem < $FFFFFFFF then
            Inc(nOrdem)
          else if FLines[i].B <> '' then
          begin
            FLines[i].Error := True;
            AddError(i, 'Address overflow');
          end;

          if not FLines[i].Error then
            if FLines[i].B <> '' then // Conteúdo da posição de memória
            begin
              if nOrdem < $FFFFFFFF then
                Inc(nOrdem)
              else if FLines[i].C <> '' then
              begin
                FLines[i].Error := True;
                AddError(i, 'Address overflow');
              end;

              if not FLines[i].Error then
              begin
                Inc(nOrdem);

                // Conteúdo da posição de memória
                if FLines[i].C <> '' then
                  if nOrdem < $FFFFFFFF then
                    Inc(nOrdem);
              end;
            end;
        end;
      end
      else if SameText(FLines[i].Oper, 'ORG') then // "ORG" address
      begin
        // Novo endereço
        ped := FLines[i].A;
        FORG := ValidNumber(ped);

        if FORG then
        try
          if ped[1] = '&' then
            nAdd := BinToInt64(ped)
          else
            nAdd := StrToInt64(ped);
        except
          FORG := False;
        end;

        if not FORG then
        begin
          FLines[i].Error := True;
          AddError(i, 'Invalid "ORG" address (' + ped + ').');
        end
        else if nAdd < nOrdem then
        begin
          FLines[i].Error := True;
          AddError(i, 'Invalid "ORG" address. Address (' + ped + ') lesser than current (' + IntToStr(nOrdem) + ').');
        end
        else
        begin
          nOrdem := nAdd;

          // Se não ocorreu geração de código (DA, DD, SUBLEQ), pode ajustar labels pendentes
          if not FStarted and FLabel then
          begin
            // Atualiza os endereços entre o label e a operação
            for n := nLabel to i do
            begin
              FLines[n].Address := nOrdem;

              if FLines[n].Lbl <> '' then
                for c := 0 to Length(FLabels) - 1 do
                  if SameText(FLabels[c].Name, FLines[n].Lbl) then
                  begin
                    FLabels[c].Content := '$' + IntToHex(nOrdem, 8);
                    FLabels[c].Absolute := nOrdem;
                    Break;
                  end;
            end;

            FLabel := False;
            FStarted := True;
          end
          else
            FLines[i].Address := nOrdem;

          if not FStarted then
            nOrg := nAdd;

          nOrdem := nAdd;
        end;
      end
      else if SameText(FLines[i].Oper, 'REL') then // Relative block
      begin
      end
      else if SameText(FLines[i].Oper, 'STOP') then // Não gera alocação de memória a partir daqui
      begin
      end
      else if Trim(FLines[i].Oper) <> '' then // Erro!!!
      begin
        FLines[i].Error := True;
        AddError(i, 'Invalid statement: "' + FLines[i].Oper + '".');
      end;
    end;

    // Passo 2: Varre os labels e ajusta as referências nas constantes
    for i := Low(FLabels) to High(FLabels) do
      if not FLabels[i].ValidNumber then
      begin
        for n := Low(FLabels) to High(FLabels) do
          if SameText(FLabels[i].Content, FLabels[n].Name) then
          begin
            FLabels[i].Content := FLabels[n].Content;
            FLabels[i].Absolute := FLabels[n].Absolute;
            FLabels[i].ValidNumber := True;
            Break;
          end;

        if not FLabels[i].ValidNumber then
        begin
          FLines[i].Error := True;
          AddError(FLabels[i].Line, 'Label "' + FLabels[i].Content + '" not defined.');
        end;
      end;

    Curr := 0;
    FIsRelative := False;
    FBaseStart := 0;
    FOffset := 0;
    FBaseEnd := 0;

    // Passo 3: Faz a substituição das constantes e ajusta os endereços relativos
    for i := Low(FLines) to High(FLines) do
    try
      if FIsRelative then
      begin
        if FLines[i].Address = FBaseEnd then
          FIsRelative := False;

        FLines[i].Address := FBaseStart;
        FLines[i].Relative := FOffset;
        FLines[i].IsRelative := True;
      end;

      Curr := i;
      CurrLbl := FLines[i].Oper;

      if CurrLbl = '' then
        Continue;

      // A
      if SameText(CurrLbl, 'ORG') or SameText(CurrLbl, 'DA') or
        SameText(CurrLbl, 'DD') or SameText(CurrLbl, 'subleq') or
        SameText(CurrLbl, 'REL') then
      begin
        // verifica e atualiza a constante com seu valor
        ped := FLines[i].A;

        if (ped <> '') and (ped[1] = '-') and SameText(CurrLbl, 'ORG') then
        begin
          FLines[i].Error := True;
          AddError(i, 'Invalid "ORG" address. Must be an value greater than or equal to zero.');
        end
        else
        begin
          if ped = '' then
            FLabel := True
          else
            FLabel := not ValidNumber(ped);

          // Procura Labels caso o valor não seja válido
          if FLabel then
            for n := Low(FLabels) to High(FLabels) do
              if SameText(ped, FLabels[n].Name) then
              begin
                if FLabels[n].ValidNumber then
                begin
                  ped := FLabels[n].Content;
                  FLines[i].A := ped;
                  FLabel := False;
                end;

                Break;
              end;

          if FLabel then
          begin
            FLines[i].Error := True;
            AddError(i, 'Undefined label "' + ped + '".');
          end
          else
          begin
            if FIsRelative and (SameText(CurrLbl, 'subleq') or SameText(CurrLbl, 'DD')) then
            begin
              if ped[1] = '&' then
                ValLong := BinToInt64(ped)
              else
                ValLong := StrToInt64(ped);

              if (ValLong >= FBaseStart) and (ValLong <= FBaseEnd) then
              begin
                ped := '$' + IntToHex(ValLong - FBaseStart, 8);
                FLines[i].A := ped;
              end;
            end;

            if SameText(CurrLbl, 'REL') then
            begin
              FIsRelative := True;
              FBaseStart := FLines[i].Address;
              FOffset := 0;

              FLines[i].IsRelative := True;
              FLines[i].Address := FBaseStart;
              FLines[i].Relative := FOffset;

              if ped[1] = '&' then
                FBaseEnd := BinToInt64(ped)
              else
                FBaseEnd := StrToInt64(ped);
            end
            else
            begin
              if SameText(CurrLbl, 'ORG') and (ped = '@') then
                FLines[i].A := '$' + IntToHex(FLines[i].Address, 8)
              else if (ped[1] <> '$') and (ped[1] <> '&') then
                FLines[i].A := '$' + IntToHex(StrToInt(FLines[i].A), 8);

              if FIsRelative then
                Inc(FOffset);
            end;
          end;
        end;
      end;

      // B, C
      if SameText(CurrLbl, 'DA') or SameText(CurrLbl, 'DC') or
        SameText(CurrLbl, 'DD') or SameText(CurrLbl, 'subleq') then
      begin
        // B
        ped := FLines[i].B;

        if SameText(CurrLbl, 'subleq') and (ped = '') then
          ped := FLines[i].A;

        if ped <> '' then
        begin
          FLabel := not ValidNumber(ped);

          // procura
          if FLabel then
            for n := Low(FLabels) to High(FLabels) do
              if SameText(ped, FLabels[n].Name) then
              begin
                if FLabels[n].ValidNumber then
                begin
                  ped := FLabels[n].Content;
                  FLines[i].B := ped;
                  FLabel := False;
                end;

                Break;
              end;

          if FLabel then
          begin
            FLines[i].Error := True;
            AddError(i, 'Undefined label "' + ped + '".');
          end
          else
          begin
            if FIsRelative and (SameText(CurrLbl, 'subleq') or SameText(CurrLbl, 'DD')) then
            begin
              if ped[1] = '&' then
                ValLong := BinToInt64(ped)
              else
                ValLong := StrToInt64(ped);

              if (ValLong >= FBaseStart) and (ValLong <= FBaseEnd) then
                ped := '$' + IntToHex(ValLong - FBaseStart, 8);
            end;

            if ped <> '' then
              if (ped[1] <> '$') and (ped[1] <> '&') then
                FLines[i].B := '$' + IntToHex(StrToInt(FLines[i].B), 8)
              else
                FLines[i].B := ped;

            if SameText(CurrLbl, 'DC') then
              if (FLines[i].B <> '') and (FLines[i].B[1] = '$') then
                FLines[i].Address := StrToInt64(FLines[i].B)
              else
                FLines[i].Address := StrToInt(FLines[i].B);

            if FIsRelative then
              Inc(FOffset);
          end;
        end;

        // C
        if SameText(CurrLbl, 'DA') or SameText(CurrLbl, 'DD') or
          SameText(CurrLbl, 'subleq') then
        begin
          ped := FLines[i].C;

          if ped <> '' then
          begin
            FLabel := not ValidNumber(ped);

            // procura
            if FLabel then
              for n := Low(FLabels) to High(FLabels) do
                if SameText(ped, FLabels[n].Name) then
                begin
                  if FLabels[n].ValidNumber then
                  begin
                    ped := FLabels[n].Content;
                    FLines[i].C := ped;
                    FLabel := False;
                  end;

                  Break;
                end;

            if FLabel then
            begin
              FLines[i].Error := True;
              AddError(i, 'Undefined label "' + ped + '".');
            end
            else
            begin
              if FIsRelative and (SameText(CurrLbl, 'subleq') or SameText(CurrLbl, 'DD')) then
              begin
                if ped[1] = '&' then
                  ValLong := BinToInt64(ped)
                else
                  ValLong := StrToInt64(ped);

                if (ValLong >= FBaseStart) and (ValLong <= FBaseEnd) then
                  ped := '$' + IntToHex(ValLong - FBaseStart, 8);
              end;

              if (ped <> '') and (ped[1] <> '$') and (ped[1] <> '&') then
                FLines[i].C := '$' + IntToHex(StrToInt(FLines[i].C), 8)
              else
                FLines[i].C := ped;

              if FIsRelative then
                Inc(FOffset);
            end;
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        ShowMessage('Error:'#13#10 + E.Message + #13#10'At line ' + IntToStr(Curr));
      end;
    end;

    // Passo 4: Gera código binário
    if Length(FErrors) = 0 then
    begin
      for i := 0 to Length(FLines) - 1 do
      try
        Curr := i + 1;

        if SameText(FLines[i].Oper, 'STOP') then
          Break
        else if SameText(FLines[i].Oper, 'DS') then
        begin
          ped := FLines[i].A;

          if ped[1] = '&' then
            nDS := BinToInt64(ped)
          else
            nDS := StrToInt64(ped);

          // Verifica se vai dar overflow
          while nDS > 0 do
          begin
            Inc(nAdd);
            SetLength(Memory, Length(Memory) + 1);
            Memory[High(Memory)].Address := nAdd;
            Dec(nDS);
          end;
        end
        else if SameText(FLines[i].Oper, 'DA') or SameText(FLines[i].Oper, 'DD') or SameText(FLines[i].Oper, 'subleq') then
        begin
          nAdd := FLines[i].Address + FLines[i].Relative;

          if FLines[i].A <> '' then
          begin
            SetLength(Memory, Length(Memory) + 1);
            Memory[High(Memory)].Address := nAdd;

            if FLines[i].A[1] = '-' then
              Memory[High(Memory)].Content := StrToInt(FLines[i].A)
            else
              Memory[High(Memory)].Cont64 := StrToInt64(FLines[i].A);
          end;

          if FLines[i].B <> '' then
          begin
            Inc(nAdd);

            SetLength(Memory, Length(Memory) + 1);
            Memory[High(Memory)].Address := nAdd;

            if FLines[i].B[1] = '-' then
              Memory[High(Memory)].Content := StrToInt(FLines[i].B)
            else
            begin
              ValLong := StrToInt64(FLines[i].B);
              Memory[High(Memory)].Content := ValInt;
            end;
          end;

          if FLines[i].C <> '' then
          begin
            Inc(nAdd);

            SetLength(Memory, Length(Memory) + 1);
            Memory[High(Memory)].Address := nAdd;

            if FLines[i].C[1] = '-' then
              Memory[High(Memory)].Content := StrToInt(FLines[i].C)
            else
            begin
              ValLong := StrToInt64(FLines[i].C);
              Memory[High(Memory)].Content := ValInt;
            end;
          end;
        end;
      except
        on E: Exception do
          ShowMessage('Error:'#13#10 + E.Message + #13#10'At line ' + IntToStr(Curr));
      end;
    end;
  finally
  end;
end;

constructor TAsmOISC.Create;
begin
  inherited Create;

  FSource := TStringList.Create;

  SetLength(FErrors, 0);
  SetLength(FLabels, 0);
  SetLength(FLines, 0);
end;

destructor TAsmOISC.Destroy;
begin
  inherited; // Destroy;

  FSource.Free;
end;

function TAsmOISC.GetToken(var str: string; const Tokens: string): string;
var
  n: integer;
begin
  n := 1;

  if Tokens = '' then
    while n <= Length(str) do
      if str[n] <= #32 then
        Inc(n)
      else
        Break;

  while n <= Length(str) do
    if ((Tokens = '') and (str[n] <= #32)) or ((Tokens <> '') and
      IsDelimiter(Tokens, str, n)) then
      Break
    else
      Inc(n);

  if n >= Length(str) then
  begin
    Result := str;
    str := '';
    Exit;
  end;

  if n - 1 = 0 then
    Result := ''
  else
    Result := LeftStr(str, n - 1);

  if Tokens = '' then
    Inc(n)
  else
    Inc(n, Length(Tokens));

  str := Copy(str, n, Length(str));
end;

function TAsmOISC.Tokenizer(str: string; Token: string): TLineTokens;
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
  Result.IsRelative := False;
  Result.Relative := 0;

  if Trim(str) = '' then
    Exit
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

      if (str = '') or (LeftStr(Trim(str), 2) = '//') then
        Result.Result :=
          'Too few parameters for the operand "' + UpperCase(Result.Oper) + '"'
      else
      begin
        if LeftStr(Trim(str), 2) <> '//' then
        begin
          tk := Trim(GetToken(str, Token));
          Result.A := tk;
        end;

        if (str <> '') and (LeftStr(Trim(str), 2) <> '//') then
        begin
          Result.Result := 'Too many parameters for the operand "' +
            UpperCase(Result.Oper) + '"';

          while (str <> '') and (LeftStr(Trim(str), 2) <> '//') do
            GetToken(str, Token);
        end;
      end;
    end
    else if Pos(';' + UpperCase(tk) + ';', ';SUBLEQ;DA;DC;DD;') <> 0 then
    begin
      Result.Oper := tk;

      if (str = '') or (LeftStr(Trim(str), 2) = '//') then
        Result.Result := 'Too few parameters for the operand "' +
          UpperCase(Result.Oper) + '"'
      else
      begin
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

        if (str <> '') and (LeftStr(Trim(str), 2) <> '//') then
        begin
          Result.Result := 'Too many parameters for the operand "' +
            UpperCase(Result.Oper) + '"';

          while (str <> '') and (LeftStr(Trim(str), 2) <> '//') do
            GetToken(str, Token);
        end;
      end;
    end
    else if SameText(tk, 'REL') then
    begin
      Result.Oper := tk;

      if (str = '') or (LeftStr(Trim(str), 2) = '//') then
        Result.Result :=
          'Too few parameters for the operand "' + UpperCase(Result.Oper) + '"'
      else
      begin
        if LeftStr(Trim(str), 2) <> '//' then
        begin
          tk := Trim(GetToken(str, Token));
          Result.A := tk;
        end;

        if (str <> '') and (LeftStr(Trim(str), 2) <> '//') then
        begin
          Result.Result := 'Too many parameters for the operand "' +
            UpperCase(Result.Oper) + '"';

          while (str <> '') and (LeftStr(Trim(str), 2) <> '//') do
            GetToken(str, Token);
        end;
      end;
    end
    else
    begin
      Result.Oper := tk;
      Result.Result := 'Invalid statement';

      while (str <> '') and (LeftStr(Trim(str), 2) <> '//') do
      begin
        tk := Trim(GetToken(str, Token));
        Result.A := Result.A + ' ' + tk;
      end;

      Result.A := TrimLeft(Result.A);
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

function TAsmOISC.ValidLabel(sLabel: string): boolean;
var
  i: integer;
begin
  Result := False;

  if Trim(sLabel) = '' then
    Exit;

  if not ((sLabel[1] in ['A'..'Z', 'a'..'z', '_']) and (sLabel[1] < #128)) then
    Exit;

  for i := 2 to Length(sLabel) do
    if not ((sLabel[1] in ['A'..'Z', 'a'..'z', '0'..'9', '_']) and
      (sLabel[1] < #128)) then
      Exit;

  Result := True;
end;

function TAsmOISC.ValidNumber(str: string; Base: byte): boolean;
var
  lDig: char;
  i, n: integer;
begin
  if Base = 0 then
  begin
    Result := ValidNumber(str);
    Exit;
  end
  else
    Result := False;

  if (Length(str) = 0) or (Base < 1) then
    Exit;

  if ((Base = 2) and (str[1] = '&')) or ((Base = 16) and (str[1] = '$')) then
    n := 2
  else
    n := 1;

  if base = 10 then
  begin
    for i := 1 to Length(str) do
      if not (str[i] in ['0'..'9', '-']) then
        Exit;
  end
  else if Base < 10 then
  begin
    lDig := IntToStr(Base - 1)[1];

    for i := n to Length(str) do
      if not (str[i] in ['0'..lDig, '-']) then
        Exit;
  end
  else
  begin
    lDig := Chr(55 + Base - 1);

    for i := n to Length(str) do
      if not (str[i] in ['0'..'9', 'A'..lDig]) then
        Exit;
  end;

  Result := True;
end;

function TAsmOISC.ValidNumber(str: string): boolean;
var
  lDig: char;
  i, n: integer;
  Base: byte;
begin
  Result := False;

  if Length(str) = 0 then
    Exit;

  if str[1] = '&' then
    Base := 2
  else if str[1] = '$' then
    Base := 16
  else if str[1] in ['0'..'9', '-'] then
    Base := 10
  else
    Exit;

  if Base <> 10 then
    n := 2
  else
    n := 1;

  if base = 10 then
  begin
    for i := 1 to Length(str) do
      if not (str[i] in ['0'..'9', '-']) then
        Exit;
  end
  else if Base < 10 then
  begin
    lDig := IntToStr(Base - 1)[1];

    for i := n to Length(str) do
      if not (str[i] in ['0'..lDig]) then
        Exit;
  end
  else
  begin
    lDig := Chr(55 + Base - 1);

    for i := n to Length(str) do
      if not (str[i] in ['0'..'9', 'A'..lDig]) then
        Exit;
  end;

  Result := True;
end;

function TAsmOISC.BinToInt(bin: string): integer;

var
  i: integer;
  Pwr: integer;
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

end.

