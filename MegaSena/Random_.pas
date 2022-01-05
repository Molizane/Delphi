unit Random_;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, AlgnEdit, ExtCtrls, Mask, DBCtrls, AlgnDBEd,
  Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
Var
  Edit: TComponent;
  x, nLeft, nTop: Integer;
begin
  nTop := 8 - 29;
  For x := 1 To 60 Do
  Begin
    If x Mod 10 = 1 Then
    Begin
      nLeft := 4;
      nTop := nTop + 25;
    End;
    Edit := TAlignEdit.Create(Self);
    With TAlignEdit(Edit) Do
    Begin
      Left := nLeft;
      Top := nTop;
      Height := 21;
      Width := 29;
      Alignment := taCenter;
      If x = 100 Then Text := '00'
      Else Text := IntToStr(x);
      ReadOnly := True;
      TabStop := False;
      Ctl3D := False;
      Parent := Panel1;
      Visible := True;
      Name := 'Numero'+Text;
    End;
    Inc(nLeft, 4 + 29);
  End;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
Var
  Edit: TComponent;
  x, y: Integer;
begin
  For x := 1 To 60 Do
  Begin
    Randomize;
    Edit := FindComponent('Numero'+IntToStr(x));
    With TAlignEdit(Edit) Do
    Begin
      Color := clWindow;
      Font.Color := clWindowText;
      Height := 21;
    End;
  End;
  For x := 1 To 6 Do
  Begin
    Repeat
      y := Random(60) + 1;
    Edit := FindComponent('Numero'+IntToStr(y));
    If Edit <> nil Then
      With TAlignEdit(Edit) Do
      Begin
        If Color = clBlue Then Continue;
        Color := clBlue;
        Font.Color := clwhite;
        Height := 21;
      End;
      Break;
    Until False;
  End;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Randomize;
end;

end.
