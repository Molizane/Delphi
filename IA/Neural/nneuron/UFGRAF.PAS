unit UFGraf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TFGra = class(TFrame)
    GB: TGroupBox;
    Img: TImage;
    SBCopy: TSpeedButton;
    ColorDialog: TColorDialog;
    SBCorFre: TSpeedButton;
    SBCorFun: TSpeedButton;
    procedure SBCopyClick(Sender: TObject);
    procedure SBCorFunClick(Sender: TObject);
    procedure SBCorFreClick(Sender: TObject);
  private
    { Private declarations }
    FMargem:word;
    FMin,FMax:Single;
    LastX:Longint;
    CorFrente,CorFundo:TColor;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Clear;
    procedure Put(Y:Single); // [0..1]
    procedure PutMM(Y:Single); // [Min..Max]
    procedure DefineColors(Fre,Fun:TColor);
    procedure DefineMinMax(PMin,PMax:Single);
  end;

implementation
uses ClipBrd;

constructor TFGra.Create(AOwner: TComponent);
begin
inherited Create(AOwner);
CorFrente:=clGreen;
CorFundo:=clBlack;
//CorFrente:=clBlack;//clGreen;
//CorFundo:=clWhite;//clBlack;
FMargem:=10;
FMin:=0;
FMax:=1;
end;

procedure TFGra.DefineColors(Fre,Fun:TColor);
begin
CorFrente:=Fre;
CorFundo:=Fun;
end;

procedure TFGra.Clear;
begin
Img.Canvas.Brush.Color := CorFundo;
Img.Canvas.Brush.Style := bsSolid;
Img.Canvas.Rectangle(0, 0, Img.Width, Img.Height);
LastX:=0;
//Img.Canvas.Ellipse(0, 0, , );
{$R *.DFM}
GB.Caption:=IntToStr(Img.Width)+' x '+ IntToStr(Img.Height);
Img.Canvas.Pen.Color := CorFrente;
Img.Canvas.Brush.Style := bsSolid;
end;

(*procedure TFGra.Put(Y:longint);
begin
if LastX=0
   then Img.Canvas.MoveTo(LastX+1,Y)
   else Img.Canvas.LineTo(LastX+1,Y);
LastX:=LastX+1;
end; *)

procedure TFGra.Put(Y:Single);
begin
Y:=FMargem div 2 + (1-Y)*(Img.Height-FMargem);
if LastX=0
   then Img.Canvas.MoveTo(LastX+1,Round(Y))
   else Img.Canvas.LineTo(LastX+1,Round(Y));
LastX:=LastX+1;
end;

procedure TFGra.PutMM(Y:Single);
begin
Put((Y-FMin)/(FMax-FMin));
end;

procedure TFGra.DefineMinMax(PMin,PMax:Single);
begin
FMin:=PMin;
FMax:=PMax;
end;

procedure TFGra.SBCopyClick(Sender: TObject);
begin
ClipBoard.Assign(Img.Picture);
end;

procedure TFGra.SBCorFunClick(Sender: TObject);
begin
if ColorDialog.Execute
   then begin
        CorFundo:=ColorDialog.Color;
        Clear;
        end;
end;

procedure TFGra.SBCorFreClick(Sender: TObject);
begin
if ColorDialog.Execute
   then begin
        CorFrente:=ColorDialog.Color;
        Clear;
        end;
end;

end.
