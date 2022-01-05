unit uJoystick;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, MMSystem, Buttons;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    BoxMira: TScrollBox;
    Mira: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    MinX, MaxX, MinY, MaxY, XPosAcumul, YPosAcumul, Cnt: Integer;
    Fim: Boolean;
    function IntToBin(Int: Integer; Size: Byte): string;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  MinX := 65535;
  MaxX := 0;
  MinY := 65535;
  MaxY := 0;
  Fim := false;
  XPosAcumul := 0;
  YPosAcumul := 0;
  Cnt := 0;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Fim := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  MyJoy: TJoyInfo;
  XCoord, YCoord: Integer;
begin
  Timer1.Enabled := False;

  repeat
    JoyGetPos(JoystickId1, @MyJoy);
    MyJoy.wxpos := MyJoy.wxpos shr 1;
    MyJoy.wypos := MyJoy.wypos shr 1;
    Inc(XPosAcumul, MyJoy.wxpos);
    Inc(YPosAcumul, MyJoy.wypos);
    Inc(Cnt);

    if Cnt = 5 then
    begin
      XPosAcumul := XPosAcumul div 5;
      YPosAcumul := YPosAcumul div 5;

      //if XPosAcumul < MinX then
      //  MinX := XPosAcumul;

      //if XPosAcumul > MaxX then
      //  MaxX := XPosAcumul;

      //if YPosAcumul < MinY then
      //  MinY := YPosAcumul;

      //if YPosAcumul > MaxY then
      //  MaxY := YPosAcumul;

      Label1.Caption := 'X = ' + IntToStr(XPosAcumul);
      Label2.Caption := 'Y = ' + IntToStr(YPosAcumul);

      Label3.Caption := 'MinX = ' + IntToStr(MinX);
      Label4.Caption := 'MaxX = ' + IntToStr(MaxX);

      Label5.Caption := 'MinY = ' + IntToStr(MinY);
      Label6.Caption := 'MaxY = ' + IntToStr(MaxY);
      
      Label7.Caption := IntToBin(MyJoy.wbuttons, 10);

      //XCoord := BoxMira.Width * XPosAcumul div 65535;
      //YCoord := BoxMira.Height * YPosAcumul div 65535;

      XCoord := BoxMira.Width * XPosAcumul div 32767;
      YCoord := BoxMira.Height * YPosAcumul div 32767;

      Mira.Left := XCoord - (Mira.Width div 2);
      Mira.Top := YCoord - (Mira.Height div 2);

      Label8.Caption := 'Left = ' + IntToStr(Mira.Left);
      Label9.Caption := 'Top = ' + IntToStr(Mira.Top);
      XPosAcumul := 0;
      YPosAcumul := 0;
      Cnt := 0;
    end;

    CheckBox1.Checked := (MyJoy.wbuttons and joy_button1) > 0;
    CheckBox2.Checked := (MyJoy.wbuttons and joy_button2) > 0;
    CheckBox3.Checked := (MyJoy.wbuttons and joy_button3) > 0;
    CheckBox4.Checked := (MyJoy.wbuttons and joy_button4) > 0;
    CheckBox5.Checked := (MyJoy.wbuttons and $10) > 0;
    CheckBox6.Checked := (MyJoy.wbuttons and $20) > 0;
    CheckBox7.Checked := (MyJoy.wbuttons and $40) > 0;
    CheckBox8.Checked := (MyJoy.wbuttons and $80) > 0;
    CheckBox9.Checked := (MyJoy.wbuttons and JOY_BUTTON1CHG) > 0;
    CheckBox10.Checked := (MyJoy.wbuttons and JOY_BUTTON2CHG) > 0;

    Application.ProcessMessages;
  until Fim;

  Close;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Fim := True;
end;

function TForm1.IntToBin(Int: Integer; Size: Byte): string;
begin
  Result := '';

  while Int > 0 do
  begin
    Result := IntToStr(Int mod 2) + Result;
    Int := Int div 2;
  end;

  while Length(Result) < Size do
    Result := '0' + Result;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #127 then
  begin
    Key:= #0;
    Fim := true;
  end;
end;

end.

