unit NestorAS80;

interface

uses
  SysUtils, Classes, CheckLst, MemoryZ80;

procedure ReadConfig(var AsmFile, ExePath, Compiler, Parameters: string);
procedure DoDebug(Mem: TMemoryView; ListDebug: TCheckListBox; ListSym: TStrings; FileName: string; Limpa: Boolean);

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

procedure DoDebug(Mem: TMemoryView; ListDebug: TCheckListBox; ListSym: TStrings; FileName: string; Limpa: Boolean);
var
  arq: TextFile;
  l, u: string;
  add, i, v: Integer;
  defs: Boolean;
begin
  if Limpa then
  begin
    ListDebug.Items.Clear;
    ListSym.Clear;
  end;

  defs := False;

  AssignFile(arq, FileName);

  try
    Reset(arq);

    for i := 1 to 4 do
      if not EOF(arq) then
        Readln(arq, l);

    while not EOF(arq) do
    begin
      Readln(arq, l);

      l := Trim(l);

      if (l = '') or ((Length(l) > 1) and ((l[1] < #32) or (l[1] = '-'))) then
        Continue;

      u := '';

      if ((l[6] = '=') or (l[6] = ':')) then // CONST NAME OR LABEL
      begin
        //VALUE = NAME EQU VALUE
        add := StrToInt('$' + LeftStr(l, 4));

        if l[6] = '=' then
        begin
          u := AnsiUpperCase(l);

          if Pos(' ORG ', u) = 0 then // NOT ORG DIRECTIVE
          begin
            i := 25; // NAME, FIRST POSITION
            u := '';

            while (i <= Length(l)) and (l[i] > #32) do
            begin
              if l[i] = #9 then // END OF NAME
                AddTab(u) // SAVE NAME
              else
                u := u + l[i];

              Inc(i);
            end;
          end
          else
            u := '';
        end
        else if l[25] >= 'A' then // LABEL NAME
        begin
          i := 25; // LABEL NAME, FIRST POSITION
          u := '';

          while (i <= Length(l)) and (l[i] in ['0'..'9', 'A'..'Z', 'a'..'z', '_']) do
          begin
            u := u + l[i];
            Inc(i);
          end;
        end;

        if u <> '' then
          ListSym.AddObject(u, TObject(add)); // SAVE LABEL NAME AND ADDRESS
      end;
    end;

    Reset(arq);

    for i := 1 to 4 do
      if not EOF(arq) then
        Readln(arq, l);

    while not EOF(arq) do
    begin
      Readln(arq, l);

      l := Trim(l);

      if (l = '') or ((Length(l) > 1) and ((l[1] < #32) or (l[1] = '-'))) then
        Continue;

      u := '';

      if Pos(#9, l) <> 0 then
      begin
        // NAME <tab> equ <spc> or <tab> VALUE
        i := 1;

        while i <= Length(l) do
        begin
          if l[i] = #9 then
            AddTab(u)
          else
            u := u + l[i];

          Inc(i);
        end;
     end;

      l := u;

      if (Length(l) > 0) and ((l[6] = '=') or (l[6] = ':')) then
      begin
        //VALUE = NAME <tab> EQU <spc> VALUE
        if l[6] = '=' then
          defs := True
        else
        begin
          // INSTRUCTION LINE
          defs := False;
          add := StrToInt('$' + LeftStr(l, 4));
          u := Copy(l, 25, Length(l));

          for i := 0 to ListSym.Count - 1 do
          begin
            v := Pos(ListSym[i], u);

            if (v > 1) and
              (v + Length(ListSym[i]) <= Length(u)) and
              (u[v + Length(ListSym[i])] in ['0'..'9', 'A'..'Z', 'a'..'z', '_']) then
              v := 0;

            if v > 1 then
              u := StringReplace(u, ListSym[i], '$' + IntToHex(Integer(ListSym.Objects[i]), 4) + ' [=' + ListSym[i] + ']', [rfReplaceAll]);
          end;

          ListDebug.AddItem(Format('%0.4x : %s', [add, u]), TObject(add));
        end;
      end
      else if not defs and (Pos('No errors in', l) = 0) then
        ListDebug.AddItem(l, TObject(65536));
    end;
  finally
    CloseFile(arq);
  end;
end;

end.
