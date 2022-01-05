unit uCompOiscSubleq;

interface

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

  TDefs = record
    Name: string;
    Content: string;
    Line: Integer;
    ValidNumber: Boolean;
    IsLabel: Boolean;
  end;

  TArrDefs = array of TDefs;

  TIntegerArray = array of Integer;

  TAsmOISC = class
  private
    FLines: TLinesTokens;
    FLabels: TArrDefs;
    FErrors: TArrErrors;
    function GetToken(var str: string; const Tokens: string): string;
    function Tokenizer(str: string; Token: string): TLineTokens;
    procedure AddError(Line: Integer; Error: string);
    function ValidLabel(sLabel: string): Boolean;
    function ValidNumber(str: string; Base: Byte): Boolean;
    function BinToInt64(bin: string): Int64;
  public
    constructor Create;
    function CompOISC(Source: array of string; var nOrg: Longword): TIntegerArray;
    property Lines: TLinesTokens read FLines;
    property Labels: TArrDefs read FLabels;
    property Errors: TArrErrors read FErrors;
  end;

implementation

uses
  Math, StrUtils, SysUtils;

{ TAsmOISC }

procedure TAsmOISC.AddError(Line: Integer; Error: string);
begin
  SetLength(FErrors, Length(FErrors) + 1);
  FErrors[High(FErrors)].Line := Line;
  FErrors[High(FErrors)].Error := Error;
end;

function TAsmOISC.BinToInt64(bin: string): Int64;
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

function TAsmOISC.CompOISC(Source: array of string; var nOrg: Longword): TIntegerArray;
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
  SetLength(FErrors, 0);
  SetLength(FLabels, 0);
  SetLength(FLines, Length(Source));

  nOrdem := 0;
  FORG := False;
  nLabel := 0;
  FLabel := False;
  CurrLbl := '';
  nOrg := 0;

  // Passo 1: Labels, constantes e endereço do código
  for i := Low(Source) to High(Source) do
  begin
    FLines[i] := Tokenizer(Source[i], '');
    FLines[i].Address := nOrdem;

    if FLines[i].Result = 'EMPTY' then
      Continue;

    if FLines[i].Lbl <> '' then
    begin
      ped := FLines[i].Lbl;

      if (ped = '') or not ValidLabel(ped) then
      begin
        FLines[i].Error := True;
        AddError(i, 'Invalid label "' + ped + '"');
      end
      else if Pos(';' + UpperCase(ped) + ';', Reserved) <> 0 then
      begin
        FLines[i].Error := True;
        AddError(i, 'Label "' + ped + '" is reserved word');
      end
      else
      begin
        for n := 0 to Length(FLabels) - 1 do
          if SameText(ped, FLabels[n].Name) then
          begin
            FLines[i].Error := True;
            AddError(i, 'Label "' + ped + '" already defined');
            Continue;
          end;

        SetLength(FLabels, Length(FLabels) + 1);
        FLabels[High(FLabels)].Name := ped;
        FLabels[High(FLabels)].Content := IntToStr(nOrdem);
        FLabels[High(FLabels)].ValidNumber := True;
        FLabels[High(FLabels)].Line := i;
        FLabels[High(FLabels)].IsLabel := True;

        if not FLabel then
        begin
          FLabel := True;
          CurrLbl := ped;
          nLabel := i;
        end;
      end;
    end;

    if SameText(FLines[i].Oper, 'DC') then // Define Constant
    begin
      ped := FLines[i].A;

      if ped = '' then
      begin
        FLines[i].Error := True;
        AddError(i, 'Constant name misdefined');
      end
      else if not ValidLabel(ped) then
      begin
        FLines[i].Error := True;
        AddError(i, 'Invalid constant name "' + ped + '"');
      end
      else if Pos(';' + UpperCase(ped) + ';', Reserved) <> 0 then
      begin
        FLines[i].Error := True;
        AddError(i, 'Constant name "' + ped + '" is reserved word');
      end
      else
      begin
        for n := 0 to Length(FLabels) - 1 do
          if SameText(ped, FLabels[n].Name) then
          begin
            FLines[i].Error := True;
            AddError(i, 'Constant name "' + ped + '" already defined');
            Break;
          end;

        if FLines[i].B = '' then
        begin
          FLines[i].Error := True;
          AddError(i, 'Constant "' + ped + '" misdefined');
        end
        else
        begin
          ped := FLines[i].B;

          SetLength(FLabels, Length(FLabels) + 1);

          FLabels[High(FLabels)].Name := FLines[i].A;
          FLabels[High(FLabels)].Line := i;
          FLabels[High(FLabels)].IsLabel := False;
          FLabels[High(FLabels)].Content := ped; // Valor da constante

          if ped[1] = '$' then
            FLabels[High(FLabels)].ValidNumber := ValidNumber(ped, 16)
          else if ped[1] = '&' then
            FLabels[High(FLabels)].ValidNumber := ValidNumber(ped, 2)
          else
            FLabels[High(FLabels)].ValidNumber := ValidNumber(ped, 10);

          FLabels[High(FLabels)].Content := ped;
        end;
      end;
    end
    else if SameText(FLines[i].Oper, 'DD') then
    begin
      if FLines[i].A = '' then
      begin
        FLines[i].Error := True;
        AddError(i, '"DD" without value');
      end
      else
      begin
        Inc(nOrdem);

        if FLines[i].B <> '' then
        begin
          Inc(nOrdem);

          if FLines[i].C <> '' then
            Inc(nOrdem);
        end;
      end;
    end
    else if SameText(FLines[i].Oper, 'ORG') then
    begin
      if FORG then
      begin
        FLines[i].Error := True;
        AddError(i, '"ORG" redefined');
      end
      else
      begin
        ped := FLines[i].A;

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
          FLines[i].Error := True;
          AddError(i, 'Invalid "ORG" address. Must be a valid number');
        end
        else if nOrdem mod 3 <> 0 then
        begin
          nOrdem := 0;
          FLines[i].Error := True;
          AddError(i, 'Invalid "ORG" address. Must be a multiple of 3');
        end
        else
        begin
          nOrg := nOrdem;

          if FLabel then // Existe um label pendente; atualiza seu endereço no intervalo
          begin
            // Atualiza os endereços entre o label e a operação
            for n := nLabel to i do
            begin
              FLines[n].Address := nOrdem;

              if FLines[n].Lbl <> '' then
                for c := 0 to Length(FLabels) - 1 do
                  if SameText(FLabels[c].Name, FLines[n].Lbl) then
                  begin
                    FLabels[c].Content := IntToStr(nOrdem);
                    Break;
                  end;
            end;

            FLabel := False;
            FORG := True;
          end
          else
            FLines[i].Address := nOrdem;
        end;
      end;
    end
    else if SameText(FLines[i].Oper, 'subleq') then
    begin
      Inc(nOrdem, 3);

      if FLines[i].C = '' then
        FLines[i].C := IntToStr(nOrdem);
    end;
  end;

  // Varre os labels e ajusta as referências nas constantes
  for i := Low(FLabels) to High(FLabels) do
    if not FLabels[i].ValidNumber then
    begin
      for n := Low(FLabels) to High(FLabels) do
        if SameText(FLabels[i].Content, FLabels[n].Name) then
        begin
          FLabels[i].Content := FLabels[n].Content;
          FLabels[i].ValidNumber := True;
          Break;
        end;

      if not FLabels[i].ValidNumber then
      begin
        FLines[i].Error := True;
        AddError(FLabels[i].Line, '"' + FLabels[i].Content + '" not defined');
      end;
    end;

  // Faz a substituição das constantes
  for i := Low(FLines) to High(FLines) do
  begin
    CurrLbl := FLines[i].Oper;

    if CurrLbl = '' then
      Continue;

    // A
    if SameText(CurrLbl, 'ORG') or SameText(CurrLbl, 'DD') or SameText(CurrLbl, 'subleq') then
    begin
      // verifica e atualiza a constante com seu valor
      ped := FLines[i].A;

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
        for n := Low(FLabels) to High(FLabels) do
          if SameText(ped, FLabels[n].Name) then
          begin
            if FLabels[n].ValidNumber then
              FLines[i].A := {FLines[i].A + ' [' +} FLabels[n].Content {+ ']'};

            Break;
          end;
    end;

    // B, C
    if SameText(CurrLbl, 'DD') or SameText(CurrLbl, 'subleq') or SameText(CurrLbl, 'DC') then
    begin
      // B
      ped := FLines[i].B;

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
        for n := Low(FLabels) to High(FLabels) do
          if SameText(ped, FLabels[n].Name) then
          begin
            if FLabels[n].ValidNumber then
              FLines[i].B := {FLines[i].B + ' [' +} FLabels[n].Content {+ ']'};

            Break;
          end;

      if SameText(CurrLbl, 'DC') then
        FLines[i].Address := StrToInt(FLines[i].B);

      // C
      if SameText(CurrLbl, 'DD') or SameText(CurrLbl, 'subleq') then
      begin
        ped := FLines[i].C;

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
          for n := Low(FLabels) to High(FLabels) do
            if SameText(ped, FLabels[n].Name) then
            begin
              if FLabels[n].ValidNumber then
                FLines[i].C := {FLines[i].C + ' [' +} FLabels[n].Content {+ ']'};

              Break;
            end;
      end;
    end;
  end;

  if Length(FErrors) = 0 then
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

    for i := 0 to Length(FLines) - 1 do
      if SameText(FLines[i].Oper, 'DD') or SameText(FLines[i].Oper, 'subleq') then
      begin
        if FLines[i].A <> '' then
        begin
          SetLength(Result, Length(Result) + 1);
          Result[High(Result)] := StrToInt(FLines[i].A);
        end;

        if FLines[i].B <> '' then
        begin
          SetLength(Result, Length(Result) + 1);
          Result[High(Result)] := StrToInt(FLines[i].B);
        end;

        if FLines[i].C <> '' then
        begin
          SetLength(Result, Length(Result) + 1);
          Result[High(Result)] := StrToInt(FLines[i].C);
        end;
      end;
  end;
end;

constructor TAsmOISC.Create;
begin
  inherited Create;

  SetLength(FErrors, 0);
  SetLength(FLabels, 0);
  SetLength(FLines, 0);
end;

function TAsmOISC.GetToken(var str: string; const Tokens: string): string;
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

function TAsmOISC.Tokenizer(str, Token: string): TLineTokens;
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

function TAsmOISC.ValidLabel(sLabel: string): Boolean;
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

function TAsmOISC.ValidNumber(str: string; Base: Byte): Boolean;
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

end.

