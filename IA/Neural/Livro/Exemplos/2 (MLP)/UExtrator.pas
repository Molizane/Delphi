unit UExtrator;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image3: TImage;
    EdNome: TEdit;
    BitBtn1: TBitBtn;
    Label4: TLabel;
    StatusBar1: TStatusBar;
    BitBtn2: TBitBtn;
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
  public
    BmpExt, BmpCen: TBitmap;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  Cor: TColor;
begin
  Cor := GetPixel(Image1.Canvas.Handle, X, Y);
  StatusBar1.Panels[0].Text := 'X = ' + IntToStr(X);
  StatusBar1.Panels[1].Text := 'Y = ' + IntToStr(Y);
  StatusBar1.Panels[2].Text := 'Cor = ' + Format('%6.6x', [Cor]);
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I, J, LE, LD, LS, LI, SI, SJ: Integer;
begin
  { No clique do mouse, transfere o bitmap extrato de 32x32 pixels }
  for I := 0 to 28 do
    for J := 0 to 28 do
      { Transformação de coordenadas }
      BmpExt.Canvas.Pixels[I, J] := Image1.Canvas.Pixels[
        (X + I) * Image1.Picture.Bitmap.Width div Image1.Width,
        (Y + J) * Image1.Picture.Bitmap.Height div Image1.Height];

  Image2.Picture.Assign(BmpExt);
  Image3.Picture.Assign(BmpExt);

  { Faz a centralização do bitmap extraído considerando os limites }
  { Cálculo do Limite esquerdo }
  LE := 32;

  for I := 0 to 31 do
    for J := 0 to 31 do
      if GetPixel(Image2.Canvas.Handle, I, J) <> $FFFFFF then
        if I < LE then
          LE := I;

  { Cálculo do Limite direito }
  LD := 0;

  for I := 0 to 31 do
    for J := 0 to 31 do
      if GetPixel(Image2.Canvas.Handle, I, J) <> $FFFFFF then
        if I > LD then
          LD := I;

  { Cálculo do Limite superior }
  LS := 32;

  for J := 1 to 30 do
    for I := 1 to 30 do
      if GetPixel(Image2.Canvas.Handle, I, J) <> $FFFFFF then
        if J < LS then
          LS := J;

  { Cálculo do Limite inferior }
  LI := 0;

  for J := 1 to 30 do
    for I := 1 to 30 do
      if GetPixel(Image2.Canvas.Handle, I, J) <> $FFFFFF then
        if J > LI then
          LI := J;

  { Centralização do caracter }
  //Image3.Canvas.Brush.Color := clWhite;
  //Image3.Canvas.FillRect(Rect(0,0,31,31));

  SI := 14 - (LD - LE) div 2;
  SJ := 14 - (LI - LS) div 2;

  for I := 0 to (LD - LE) do
    for J := 0 to (LI - LS) do
      //Image3.Canvas.Pixels[SI+I,SJ+J] := Image2.Canvas.Pixels[I,J];

  Image2.Canvas.Brush.Color := clRed;
  Image2.Canvas.FrameRect(Rect(LE, LS, LD, LI));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BmpExt := TBitmap.Create;
  BmpExt.Width := 32;
  BmpExt.Height := 32;

  BmpCen := TBitmap.Create;
  BmpCen.Width := 32;
  BmpCen.Height := 32;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  Path: string;
begin
  if EdNome.Text <> '' then
  begin
    Path := ExtractFilePath(Application.ExeName) + 'Bitmaps\Teste\';
    Image3.Picture.SaveToFile(Path + EdNome.Text + '.BMP');
  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Amostras\ScanTeste.bmp');
end;

end.

