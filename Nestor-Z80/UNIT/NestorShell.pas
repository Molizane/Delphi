unit NestorShell;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CPortCtl, ComCtrls, EngineZ80;

type
  TComTerminal = class(CPortCtl.TComTerminal)
  public
    procedure MoveCaret(AColumn, ARow: Integer); override;
  end;

  TFrmShell = class(TForm)
    ComTerminal: TComTerminal;
    procedure ComTerminalKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    Address: Integer;
    KeyBuffer: string;
    Tokens: array of string;
    procedure Tokenize;
    procedure Process;
    //procedure Execute;
  public
    Memory: TMemory;
  end;

var
  FrmShell: TFrmShell;

implementation

uses DisassemblyZ80;

{$R *.dfm}

procedure SplitString(const AStr, AToken: string; var VLeft, VRight: string);
var
  i: Integer;
  LLocalStr: string;
begin
  LLocalStr := AStr;
  i := Pos(AToken, LLocalStr);

  if i = 0 then
  begin
    VLeft := LLocalStr;
    VRight := '';
  end
  else
  begin
    VLeft := Copy(LLocalStr, 1, i - 1);
    VRight := Copy(LLocalStr, i + Length(AToken), Length(LLocalStr));
  end;
end;

procedure TFrmShell.FormCreate(Sender: TObject);
begin
  Address := 0;
  KeyBuffer := '';
  SetLength(Tokens, 0);
  ComTerminal.ClearScreen;
  ComTerminal.WriteStr('Shell'#13#10#10'>');
end;

procedure TFrmShell.ComTerminalKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #12 then
    Exit;

  if Key = #08 then
  begin
    if KeyBuffer <> '' then
    begin
      SetLength(KeyBuffer, Length(KeyBuffer) - 1);
      ComTerminal.WriteStr(#08#32#08);
    end
    else
      Beep;

    Exit;
  end;

  if Key = #13 then
  begin
    Process;
    Exit;
  end;

  if (Key < #32) or (Key = #127) then
    Exit;

  if Length(KeyBuffer) = 79 then
  begin
    Beep;
    Exit;
  end;

  KeyBuffer := KeyBuffer + Key;
  ComTerminal.WriteStr(Key);
end;

procedure TFrmShell.Process;
var
  Add1, Add2: Integer;
  Addr, Lines: Word;
  Brk: Char;
begin
  ComTerminal.WriteStr(#13#10);

  try
    Tokenize;

    if Length(Tokens) = 0 then
      Exit;

    if SameText(Tokens[0], 'cls') then
    begin
      ComTerminal.ClearScreen;
      Exit;
    end;

    if Tokens[0] = '?' then
    begin
      ComTerminal.WriteStr('Commands:'#13#10);
      ComTerminal.WriteStr(#9'L <start> / <$> <finish>'#13#10);
      ComTerminal.WriteStr(#9'B <start> / <$> <finish>'#13#10);
      ComTerminal.WriteStr(#9'H - Help'#13#10);
      Exit;
    end;

    if SameText(Tokens[0], 'L') or SameText(Tokens[0], 'B') then
    begin
      if (Length(Tokens) = 1) or (Tokens[1] = '$') then
        Add1 := Address
      else
        Add1 := StrToIntDef('$' + Tokens[1], -1);

      if Length(Tokens) <= 2 then
      begin
        Add2 := 0;

        if SameText(Tokens[0], 'B') then
          Lines := 1
        else
          Lines := 32;
      end
      else
      begin
        Lines := 0;
        Add2 := StrToIntDef('$' + Tokens[2], -1);
      end;

      if (Add1 = -1) or (Add2 = -1) then
      begin
        ComTerminal.WriteStr('Address error' + #13#10);
        Exit;
      end;

      if Add2 < Add1 then
      begin
        Add2 := 0;

        if SameText(Tokens[0], 'B') then
          Lines := 1
        else
          Lines := 32;
      end;

      Addr := Word(Add1);

      while true do
      begin
        if SameText(Tokens[0], 'B') then
        begin
          Memory.BreakPoint(Addr, not Memory.HasBreak(Addr));
          DisasmZ80(Memory, Addr);
        end
        else
        begin
          if Memory.HasBreak(Addr) then
            Brk := '*'
          else
            Brk := ' ';

          ComTerminal.WriteStr(Format('%s%0.4x : %s', [Brk, Addr, DisasmZ80(Memory, Addr)]) +
            #13#10);
          Application.ProcessMessages;
        end;

        if (Add2 <> 0) and (Addr > Add2) then
          Break
        else
        begin
          Dec(Lines);

          if Lines = 0 then
            Break;
        end;
      end;

      Address := Addr;
    end;
  finally
    KeyBuffer := '';
    ComTerminal.WriteStr('>');
  end;
end;

{ TComTerminal }

procedure TComTerminal.MoveCaret(AColumn, ARow: Integer);
begin
  inherited MoveCaret(AColumn, ARow);
end;

procedure TFrmShell.Tokenize;
var
  Token: string;
begin
  KeyBuffer := Trim(KeyBuffer);
  SetLength(Tokens, 0);

  while KeyBuffer <> '' do
  begin
    SplitString(KeyBuffer, #32, Token, KeyBuffer);
    Token := Trim(Token);

    if Token = '' then
      Continue;

    SetLength(Tokens, Length(Tokens) + 1);
    Tokens[Length(Tokens) - 1] := Token;
  end;
end;

//procedure TFrmShell.Execute;
//begin
//
//end;

end.
