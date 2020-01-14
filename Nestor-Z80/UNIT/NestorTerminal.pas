unit NestorTerminal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CPortCtl;

type
  TFrmTerminal = class(TForm)
    ComTerminal: TComTerminal;
    procedure FormCreate(Sender: TObject);
    procedure ComTerminalKeyPress(Sender: TObject; var Key: Char);
  private
    KeysPressed: TStrings;
    Busy: Boolean;
  public
    function Read: Char;
    procedure Write(Chr: Char); overload;
    procedure Write(Str: string); overload;
    function ReadStatus: Byte;
  end;

var
  FrmTerminal: TFrmTerminal;

implementation

{$R *.dfm}

procedure TFrmTerminal.FormCreate(Sender: TObject);
begin
  KeysPressed := TStringList.Create;
  Busy := false;
end;

function TFrmTerminal.Read: Char;
begin
  Result := #0;

  if KeysPressed.Count > 59 then
    Exit;

  if KeysPressed.Count > 0 then
  begin
    while Busy do
      ;

    Busy := True;

    try
      Result := KeysPressed[0][1];
      KeysPressed.Delete(0);
    finally
      Busy := False;
    end;
  end;
end;

function TFrmTerminal.ReadStatus: Byte;
begin
  Result := 0;

  if KeysPressed.Count <> 0 then
    Result := Result or 2;

  Result := Result or 1;
end;

procedure TFrmTerminal.Write(Str: string);
begin
  while Busy do
    ;

  Busy := True;

  try
    ComTerminal.WriteStr(Str);
  finally
    Busy := False;
  end;
end;

procedure TFrmTerminal.Write(Chr: Char);
begin
  while Busy do
    ;

  Busy := True;

  try
    ComTerminal.WriteStr(Chr);
  finally
    Busy := False;
  end;
end;

procedure TFrmTerminal.ComTerminalKeyPress(Sender: TObject; var Key: Char);
begin
  while Busy do
    ;

  Busy := True;

  try
    KeysPressed.Add(Key);
  finally
    Busy := False;
  end;
end;

end.

