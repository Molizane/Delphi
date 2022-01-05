unit NestorZmac;

interface

uses
  SysUtils, Classes, CheckLst, MemoryZ80;

procedure ReadConfig(var AsmFile, ExePath, Compiler, Parameters: string);
procedure DoDebug(Mem: TMemoryView; ListDebug: TCheckListBox; ListSym: TStrings; FileName: string;
  Limpa: Boolean);

implementation

uses
  StrUtils, XMLIni;

function AddTab(var text: string): string;
var
  v: Integer;
begin
  text := text + '        ';
  v := (Length(text) div 8) * 8;
  SetLength(text, v);
end;

procedure ReadConfig(var AsmFile, ExePath, Compiler, Parameters: string);
var
  XML: TXMLConfig;
  Save: Boolean;
begin
  XML := TXMLConfig.Create;
  Save := False;

  try
    AsmFile := XML.ReadString('Nestor', 'Source', '');

    if AsmFile = '' then
    begin
      AsmFile := '.\SRC\NESTORNE.ASM';
      XML.WriteString('Nestor', 'Source', AsmFile);
      Save := True;
    end;

    if AsmFile[1] = '.' then
      if AsmFile[2] = '.' then
        AsmFile := ExePath + Copy(AsmFile, 4, Length(AsmFile))
      else
        AsmFile := ExePath + Copy(AsmFile, 3, Length(AsmFile));

    Compiler := XML.ReadString('Compiler', 'Command', '');

    if Compiler = '' then
    begin
      Compiler := '.\TOOLS\AS80.EXE';
      XML.WriteString('Compiler', 'Command', Compiler);
      Save := True;
    end;

    if Compiler[1] = '.' then
      if Compiler[2] = '.' then
        Compiler := ExePath + Copy(Compiler, 4, Length(Compiler))
      else
        Compiler := ExePath + Copy(Compiler, 3, Length(Compiler));

    Parameters := XML.ReadString('Compiler', 'Parameters', '');

    if Parameters = '' then
    begin
      //Parameters := '#ASM -nzis2xl#LST';
      Parameters := '-c -i -p -t -s2 -x3 -w180 #ASM';
      XML.WriteString('Compiler', 'Parameters', Parameters);
      Save := True;
    end;
  finally
    if Save then
      XML.Save;

    XML.Destroy;
  end;
end;

procedure DoDebug(Mem: TMemoryView; ListDebug: TCheckListBox; ListSym: TStrings; FileName: string;
  Limpa: Boolean);
var
  arq: TextFile;
  L, U, Lbl: string;
  add, i: Integer;
begin
  if Limpa then
  begin
    ListDebug.Items.Clear;
    ListSym.Clear;
  end;

  AssignFile(arq, FileName);

  try
    Reset(arq);

    while not EOF(arq) do
    begin
      Readln(arq, L);

      L := StringReplace(Trim(L), #9, #32, [rfReplaceAll]);

      if (L = '') or (L[1] < '0') then
        Continue;

      if Pos('Statistics:', L) = 1 then
        Break;

      add := StrToIntDef('$' + LeftStr(L, 4), -1);

      if add = -1 then
        Continue;

      if (AnsiPos(' equ ', L) <> 0) and (Copy(L, 5, 10) = '          ') then // CONST NAME OR LABEL
      begin
        //VALUE <spaces> NAME <spaces> EQU <spaces> VALUE
        L := Trim(Copy(L, 15, Length(L)));
        U := '';

        if (L <> '') and (L[1] >= 'A') then // LABEL NAME
        begin
          i := 1; // LABEL NAME, FIRST POSITION

          while (i <= Length(L)) and (L[i] in ['0'..'9', 'A'..'Z', 'a'..'z', '_']) do
          begin
            U := U + L[i];
            Inc(i);
          end;
        end;

        if U <> '' then
          ListSym.AddObject(U, TObject(add)); // SAVE LABEL NAME AND ADDRESS

        Continue;
      end;

      L := Copy(L, 16, Length(L));

      if Trim(L) = '' then
        Continue;

      // Label
      Lbl := '';
      i := 1;

      if L[1] > #32 then
      begin
        while (i <= Length(L)) and (L[i] > #32) do
        begin
          Lbl := Lbl + L[i];
          Inc(i);
        end;
      end;

      AddTab(Lbl);

      U := Lbl + Copy(L, i, Length(L));
      ListDebug.AddItem(Format('%0.4x : %s', [add, U]), TObject(add));
    end;

    while not EOF(arq) do
    begin
      Readln(arq, L);

      if L = 'Symbol Table:' then
        Break;
    end;

    while not EOF(arq) do
    begin
      Readln(arq, L);

      L := StringReplace(Trim(L), #9, #32, [rfReplaceAll]);

      if L = '' then
        Continue;

      Lbl := '';
      i := 1;

      while (i <= Length(L)) and (L[i] > #32) do
      begin
        Lbl := Lbl + L[i];
        Inc(i);
      end;

      while (i <= Length(L)) and (L[i] in [#32, '=']) do
        Inc(i);

      L := Copy(L, i, Length(L));
      add := StrToInt('$' + LeftStr(L, 4));

      ListDebug.AddItem(Format('%0.4x : %s', [add, Lbl]), TObject(add));
    end;

    ListDebug.AddItem(L, TObject(65536));
  finally
    CloseFile(arq);
  end;
end;

end.
