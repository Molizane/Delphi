unit NestorBP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, MemoryZ80;

type
  TFrmBreakPoints = class(TForm)
    ListDebug: TCheckListBox;
    procedure ListDebugClickCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    ListSym: TStrings;
  public
    procedure Debug(Mem: TMemoryView; inicio, fim: Word; Limpa: Boolean); overload;
    procedure Debug(Mem: TMemoryView; FileName: string; Limpa: Boolean); overload;
    procedure AddSym(Name: string; Value: Integer);
    function GetSym(Name: string): Integer;
  end;

var
  FrmBreakPoints: TFrmBreakPoints;

implementation

uses
  StrUtils, EngineZ80, DisassemblyZ80, NestorMain, NestorZMac;

{$R *.dfm}

{ TFrmBreakPoints }

procedure TFrmBreakPoints.ListDebugClickCheck(Sender: TObject);
var
  i: Integer;
begin
  i := Integer(ListDebug.Items.Objects[ListDebug.ItemIndex]);

  if ListDebug.Checked[ListDebug.ItemIndex] and (i = 65536) then
    ListDebug.Checked[ListDebug.ItemIndex] := False;

  FrmMain.Memory.BreakPoint(i, ListDebug.Checked[ListDebug.ItemIndex]);
end;

procedure TFrmBreakPoints.Debug(Mem: TMemoryView; inicio, fim: Word; Limpa: Boolean);
var
  i: Word;
begin
  if Limpa then
  begin
    ListDebug.Items.Clear;
    ListSym.Clear;
  end;

  i := inicio;

  while i <= fim do
    DisasmZ80(ListDebug, Mem, i)
end;

procedure TFrmBreakPoints.Debug(Mem: TMemoryView; FileName: string; Limpa: Boolean);
begin
  DoDebug(Mem, ListDebug, ListSym, FileName, Limpa);
end;

procedure TFrmBreakPoints.FormCreate(Sender: TObject);
begin
  ListSym := TStringList.Create;
end;

procedure TFrmBreakPoints.FormDestroy(Sender: TObject);
begin
  ListSym.Destroy;
end;

procedure TFrmBreakPoints.AddSym(Name: string; Value: Integer);
begin
  ListSym.AddObject(Name, TObject(Value));
end;

function TFrmBreakPoints.GetSym(Name: string): Integer;
var
  i: Integer;
begin
  i := ListSym.IndexOf(Name);

  if i <> -1 then
    Result := Integer(ListSym.Objects[i])
  else
    result := -1;
end;

end.

