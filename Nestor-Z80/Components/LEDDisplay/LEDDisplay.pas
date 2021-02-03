unit LEDDisplay;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TLEDDisplay = class(TGraphicControl)
  private
    FValue: Byte;
    FDigitHeight, FDigitWidth, FLineWidth: Integer;
    FBackGroundColor, FLightOnColor, FLightOffColor: TColor;
    FDigit: TBitmap;
    FsegCl: array[1..8] of TColor;
    FBitmap: TBitmap;
    FActive: Boolean;
    Timer: TTimer;
    procedure setValue(newValue: byte);
    procedure setDigitHeight(newValue: Integer);
    procedure setDigitWidth(newValue: Integer);
    procedure setLineWidth(newValue: Integer);
    procedure setBackgroundColor(newValue: TColor);
    procedure setLightOnColor(newValue: TColor);
    procedure setLightOffColor(newValue: TColor);
    procedure RegenBitmaps;
    procedure assignColors(s1, s2, s3, s4, s5, s6, s7, decimal: Boolean);
    procedure SetActive(const Value: Boolean);
    procedure TimerTimer(Sender: TObject);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SaveToBMP(FileName: string);
    procedure Reset;
  published
    property Active: Boolean read FActive write SetActive default False;
    property Align default alNone;
    property Anchors;
    property Width default 24;
    property Height default 36;
    property Value: byte read FValue write setValue default 0;
    property DigitHeight: Integer read FDigitHeight write setDigitHeight default 30;
    property DigitWidth: Integer read FDigitWidth write setDigitWidth default 20;
    property DigitLineWidth: Integer read FLineWidth write setLineWidth default 5;
    property BackgroundColor: TColor read FBackgroundColor write setBackgroundColor default clOlive;
    property LightOnColor: TColor read FLightOnColor write setLightOnColor default cllime;
    property LightOffColor: TColor read FLightOffColor write setLightOffColor default clGreen;
  end;

procedure Register;

implementation

uses
  Types;

procedure Register;
begin
  RegisterComponents('Samples', [TLEDDisplay]);
end;

procedure TLEDDisplay.assignColors(s1, s2, s3, s4, s5, s6, s7, decimal: Boolean);
var
  LActive: Boolean;
begin
  LActive := FActive or Timer.Enabled;

  if s1 and LActive then
    FSegCl[1] := FLightOnColor
  else
    FSegCl[1] := FLightOffColor;

  if s2 and LActive then
    FSegCl[2] := FLightOnColor
  else
    FSegCl[2] := FLightOffColor;

  if s3 and LActive then
    FSegCl[3] := FLightOnColor
  else
    FSegCl[3] := FLightOffColor;

  if s4 and LActive then
    FSegCl[4] := FLightOnColor
  else
    FSegCl[4] := FLightOffColor;

  if s5 and LActive then
    FSegCl[5] := FLightOnColor
  else
    FSegCl[5] := FLightOffColor;

  if s6 and LActive then
    FSegCl[6] := FLightOnColor
  else
    FSegCl[6] := FLightOffColor;

  if s7 and LActive then
    FSegCl[7] := FLightOnColor
  else
    FSegCl[7] := FLightOffColor;

  if decimal and LActive then
    FSegCl[8] := FLightOnColor
  else
    FSegCl[8] := FLightOffColor;
end;

procedure TLEDDisplay.RegenBitmaps;
var
  FTopTopLeft, FTopTopRight, FTopBottomLeft, FTopBottomRight: TPoint;
  FMiddleLeft, FMiddleRight, FMiddleTopLeft, FMiddleTopRight: TPoint;
  FMiddleBottomLeft, FMiddleBottomRight: TPoint;
  FBottomBottomLeft, FBottomTopLeft, FBottomTopRight, FBottomBottomRight: TPoint;
  FDotLeftTop, FDotRightTop, FDotRightBottom, FDotLeftBottom: TPoint;
  v: array[1..6] of TPoint;
  wAlt: Integer;
begin
  wAlt := FDigitHeight;

  // Asignar los puntos que definen los 7 segmentos
  FTopTopLeft.x := 0;
  FTopTopLeft.y := 0;

  FTopTopRight.x := FDigitWidth - 1 - FLineWidth;
  FTopTopRight.y := 0;

  FTopBottomLeft.x := FLineWidth - 1;
  FTopBottomLeft.y := FLineWidth - 1;

  FTopBottomRight.x := FDigitWidth - (FLineWidth * 2);
  FTopBottomRight.y := FTopBottomLeft.y;

  FMiddleLeft.x := 0;
  FMiddleLeft.y := wAlt div 2;

  FMiddleTopLeft.x := FTopBottomLeft.x;
  FMiddleTopLeft.y := FMiddleLeft.y - (FLineWidth div 2);

  FMiddleTopRight.x := FTopBottomRight.x;
  FMiddleTopRight.y := FMiddleTopLeft.y;

  FMiddleRight.x := FTopTopRight.x;
  FMiddleRight.y := FMiddleLeft.y;

  FMiddleBottomLeft.x := FTopBottomLeft.x;
  FMiddleBottomLeft.y := FMiddleLeft.y + (FLineWidth div 2);

  FMiddleBottomRight.x := FMiddleTopRight.x;
  FMiddleBottomRight.y := FMiddleBottomLeft.y;

  FBottomBottomLeft.x := 0;
  FBottomBottomLeft.y := wAlt - 1;

  FBottomBottomRight.x := FTopTopRight.x;
  FBottomBottomRight.y := FBottomBottomLeft.y;

  FBottomTopLeft.x := FTopBottomLeft.x;
  FBottomTopLeft.y := wAlt - FLineWidth;

  FBottomTopRight.x := FTopBottomRight.x;
  FBottomTopRight.y := FBottomTopLeft.y;

  // Asignar los Colores de cada segmento para cada dígito
  { Identificación de segmentos:
       1
     --1--
    |     |
 2  2     3 4
    |  8  |
     --4--
    |     |
16  5     6 32
    |     |
     --7--  o 128
      64    8
  }

//  assignColors(FValue and 1 = 1, FValue and 32 = 32, FValue and 2 = 2,
//    FValue and 64 = 64, FValue and 16 = 16, FValue and 4 = 4,
//    FValue and 8 = 8, FValue and 128 = 128);

//  assignColors(
//    FValue and 1 = 1,
//    FValue and 2 = 2,
//    FValue and 4 = 4,
//    FValue and 8 = 8,
//    FValue and 16 = 16,
//    FValue and 32 = 32,
//    FValue and 64 = 64,
//    FValue and 128 = 128
//    );

  assignColors(
    FValue and 1 = 1,
    FValue and 32 = 32,
    FValue and 2 = 2,
    FValue and 64 = 64,
    FValue and 16 = 16,
    FValue and 4 = 4,
    FValue and 8 = 8,
    FValue and 128 = 128
    );

  // Gerar cada bitmap
  FDigit.free;
  FDigit := TBitmap.Create;
  FDigit.Width := FDigitWidth;
  FDigit.Height := wAlt;

  with FDigit.Canvas do
  begin
    pen.Width := 1;
    pen.Color := FBackGroundColor;
    Brush.Color := FBackGroundColor;
    Brush.style := bsSolid;
    rectangle(FTopTopLeft.x - 1, FTopTopLeft.y, FBottomBottomRight.x + FLineWidth + 1, FBottomBottomRight.y + 1);

    // Segmento 1
    v[1] := FTopTopLeft;
    v[2] := FTopTopRight;
    v[3] := FTopBottomRight;
    v[4] := FTopBottomLeft;
    Brush.Color := FSegCl[1];
    polygon(slice(v, 4));

    // Segmento 2
    v[1] := FTopTopLeft;
    v[2] := FTopBottomLeft;
    v[3] := FMiddleTopLeft;
    v[4] := FMiddleLeft;
    Brush.Color := FSegCl[2];
    polygon(slice(v, 4));

    // Segmento 3
    v[1] := FTopTopRight;
    v[2] := FMiddleRight;
    v[3] := FMiddleTopRight;
    v[4] := FTopBottomRight;
    Brush.Color := FSegCl[3];
    polygon(slice(v, 4));

    // Segmento 4
    v[1] := FMiddleLeft;
    v[2] := FMiddleTopLeft;
    v[3] := FMiddleTopRight;
    v[4] := FMiddleRight;
    v[5] := FMiddleBottomRight;
    v[6] := FMiddleBottomLeft;
    Brush.Color := FSegCl[4];
    polygon(v);

    // Segmento 5
    v[1] := FMiddleLeft;
    v[2] := FMiddleBottomLeft;
    v[3] := FBottomTopLeft;
    v[4] := FBottomBottomLeft;
    Brush.Color := FSegCl[5];
    polygon(slice(v, 4));

    // Segmento 6
    v[1] := FMiddleRight;
    v[2] := FBottomBottomRight;
    v[3] := FBottomTopRight;
    v[4] := FMiddleBottomRight;
    Brush.Color := FSegCl[6];
    polygon(slice(v, 4));

    // Segmento 7
    v[1] := FBottomBottomLeft;
    v[2] := FBottomTopLeft;
    v[3] := FBottomTopRight;
    v[4] := FBottomBottomRight;
    Brush.Color := FSegCl[7];
    polygon(slice(v, 4));

    // Decimalpoint
    FDotLeftTop.X := FMiddleRight.X + 1;
    FDotLeftTop.Y := FBottomBottomRight.Y - 3;

    FDotRightTop.X := FMiddleRight.X + 3;
    FDotRightTop.Y := FBottomBottomRight.Y - 3;

    FDotRightBottom.X := FMiddleRight.X + 1;
    FDotRightBottom.Y := FBottomBottomRight.Y - 1;

    FDotLeftBottom.X := FMiddleRight.X + 3;
    FDotLeftBottom.Y := FBottomBottomRight.Y - 1;

    v[1] := FDotLeftTop;
    v[2] := FDotLeftBottom;
    v[3] := FDotRightBottom;
    v[4] := FDotRightTop;

    pen.Color := FSegCl[8];
    Brush.Color := FSegCl[8];
    //Ellipse(FDotLeftTop.X, FDotLeftTop.Y, FDotRightBottom.X, FDotRightBottom.Y);
    Polygon(slice(v, 4));

    //FDigit.SaveToFile(Format('DIGIT%d.BMP',[c]));
  end;
end;

constructor TLEDDisplay.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Timer := TTimer.Create(Self);
  Timer.Enabled := False;
  Timer.Interval := 50;
  Timer.OnTimer := TimerTimer;
  controlStyle := [csOpaque];
  FBitmap := TBitmap.Create;
  Width := 24;
  Height := 36;
  Value := 0;
  DigitHeight := 30;
  DigitWidth := 20;
  DigitLineWidth := 5;
  BackgroundColor := clBlack;
  FActive := False;
  LightOnColor := clRed;
  LightOffColor := clMaroon;
end;

destructor TLEDDisplay.Destroy;
begin
  FDigit.free;
  FBitmap.free;
  Timer.Destroy;
  inherited destroy;
end;

procedure TLEDDisplay.setValue(newValue: byte);
begin
  FValue := NewValue;
  invalidate;
end;

procedure TLEDDisplay.setDigitHeight(newValue: Integer);
begin
  FDigitHeight := newValue;
  invalidate;
end;

procedure TLEDDisplay.setDigitWidth(newValue: Integer);
begin
  FDigitWidth := newValue;
  invalidate;
end;

procedure TLEDDisplay.setLineWidth(newValue: Integer);
begin
  FLineWidth := newValue;
  invalidate;
end;

procedure TLEDDisplay.setBackgroundColor(newValue: TColor);
begin
  FBackgroundColor := NewValue;
  invalidate;
end;

procedure TLEDDisplay.setLightOnColor(newValue: TColor);
begin
  FLightOnColor := newValue;
  invalidate;
end;

procedure TLEDDisplay.setLightOffColor(newValue: TColor);
begin
  FLightOffColor := newValue;
  invalidate;
end;

procedure TLEDDisplay.Paint;
var
  area: TRect;
  anchoPosi, posiLeft, PosiTop: Integer;
begin
  area := getClientRect;
  RegenBitmaps;
  FBitmap.Height := Height;
  FBitmap.Width := Width;
  with FBitmap.Canvas do
  begin
    Brush.Color := FBackgroundColor;
    FillRect(area);
    anchoPosi := self.Width;
    PosiTop := (self.Height - FDigitHeight) div 2;
    posiLeft := (anchoPosi - FDigitWidth) div 2;
    Draw(posiLeft, posiTop, FDigit);
  end;
  Canvas.Draw(0, 0, FBitmap);
end;

procedure TLEDDisplay.SaveToBMP(FileName: string);
var
  area: TRect;
  anchoPosi, posiLeft, PosiTop: Integer;
begin
  area := getClientRect;
  RegenBitmaps;
  FBitmap.Height := Height;
  FBitmap.Width := Width;

  with FBitmap.Canvas do
  begin
    Brush.Color := FBackgroundColor;
    FillRect(area);
    anchoPosi := self.Width;
    PosiTop := (self.Height - FDigitHeight) div 2;
    posiLeft := (anchoPosi - FDigitWidth) div 2;
    Draw(posiLeft, posiTop, FDigit);
  end;

  FBitmap.SaveToFile(FileName);
end;

procedure TLEDDisplay.SetActive(const Value: Boolean);
begin
  FActive := Value;
  Timer.Enabled := not FActive;
  Invalidate;
end;

procedure TLEDDisplay.Reset;
begin
  Value := 0;
  Active := False;
end;

procedure TLEDDisplay.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  Invalidate;
end;

end.

