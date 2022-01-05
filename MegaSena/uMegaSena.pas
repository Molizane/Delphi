unit uMegaSena;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, Mask, DBCtrls, Buttons, AlignEdit;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  Edit: TComponent;
  x, nLeft, nTop: Integer;
begin
  nTop := 8 - 29;
  nLeft := 0;

  for x := 1 to 60 do
  begin
    if x mod 10 = 1 then
    begin
      nLeft := 4;
      nTop := nTop + 25;
    end;

    Edit := TAlignEdit.Create(Self);

    with TAlignEdit(Edit) do
    begin
      Left := nLeft;
      Top := nTop;
      Height := 21;
      Width := 29;
      Alignment := taCenter;

      if x = 100 then
        Text := '00'
      else
        Text := IntToStr(x);

      ReadOnly := True;
      TabStop := False;
      Ctl3D := False;
      Parent := Panel1;
      Visible := True;
      Name := 'Numero' + Text;
    end;

    Inc(nLeft, 4 + 29);
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  Edit: TComponent;
  x, y: Integer;
begin
  for x := 1 to 60 do
  begin
    Randomize;
    Edit := FindComponent('Numero' + IntToStr(x));

    with TAlignEdit(Edit) do
    begin
      Color := clWindow;
      Font.Color := clWindowText;
      Height := 21;
    end;
  end;

  for x := 1 to 6 do
  begin
    repeat
      y := Random(60) + 1;
      Edit := FindComponent('Numero' + IntToStr(y));

      if Edit <> nil then
        with TAlignEdit(Edit) do
        begin
          if Color = clBlue then
            Continue;

          Color := clBlue;
          Font.Color := clwhite;
          Height := 21;
        end;

      Break;
    until False;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Randomize;
end;

end.

