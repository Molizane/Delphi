unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, NNSignal, NeuralNet, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    In01: TNNSignal;
    In02: TNNSignal;
    In03: TNNSignal;
    In04: TNNSignal;
    In05: TNNSignal;
    In06: TNNSignal;
    In07: TNNSignal;
    In08: TNNSignal;
    In09: TNNSignal;
    NeuralNet1: TNeuralNet;
    Out01: TNNSignal;
    Out02: TNNSignal;
    Out03: TNNSignal;
    Out04: TNNSignal;
    Out05: TNNSignal;
    Out06: TNNSignal;
    Out07: TNNSignal;
    Out08: TNNSignal;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image14: TImage;
    Image15: TImage;
    Image16: TImage;
    Image17: TImage;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure clear;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Image1Click(Sender: TObject);
begin
if image1.Canvas.Pixels[12,12]=RGB(0,0,0) then
   begin
   image1.Canvas.brush.Color:=RGB(255,255,255);
   In01.Value:=0;
   end
   else
   begin
   image1.Canvas.brush.Color:=RGB(0,0,0);
   In01.Value:=1;
   end;


image1.Canvas.Rectangle(5,5,46,53);
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
if image2.Canvas.Pixels[12,12]=RGB(0,0,0) then
   begin
   image2.Canvas.brush.Color:=RGB(255,255,255);
   In02.Value:=0;
   end
   else
   begin
   image2.Canvas.brush.Color:=RGB(0,0,0);
   In02.Value:=1;
   end;

image2.Canvas.Rectangle(5,5,46,53);
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
if image3.Canvas.Pixels[12,12]=RGB(0,0,0) then
   begin
   image3.Canvas.brush.Color:=RGB(255,255,255);
   In03.Value:=0;
   end
   else
   begin
   image3.Canvas.brush.Color:=RGB(0,0,0);
   In03.Value:=1;
   end;

image3.Canvas.Rectangle(5,5,46,53);

end;

procedure TForm1.Image4Click(Sender: TObject);
begin
if image4.Canvas.Pixels[12,12]=RGB(0,0,0) then
   begin
   image4.Canvas.brush.Color:=RGB(255,255,255);
   In04.Value:=0;
   end
   else
   begin
   image4.Canvas.brush.Color:=RGB(0,0,0);
   In04.Value:=1;
   end;

image4.Canvas.Rectangle(5,5,46,53);
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
if image5.Canvas.Pixels[12,12]=RGB(0,0,0) then
   begin
   image5.Canvas.brush.Color:=RGB(255,255,255);
   In05.Value:=0;
   end
   else
   begin
   image5.Canvas.brush.Color:=RGB(0,0,0);
   In05.Value:=1;
   end;

image5.Canvas.Rectangle(5,5,46,53);
end;

procedure TForm1.Image6Click(Sender: TObject);
begin
if image6.Canvas.Pixels[12,12]=RGB(0,0,0) then
   begin
   image6.Canvas.brush.Color:=RGB(255,255,255);
   In06.Value:=0;
   end
   else
   begin
   image6.Canvas.brush.Color:=RGB(0,0,0);
   In06.Value:=1;
   end;

image6.Canvas.Rectangle(5,5,46,53);
end;

procedure TForm1.Image7Click(Sender: TObject);
begin
if image7.Canvas.Pixels[12,12]=RGB(0,0,0) then
   begin
   image7.Canvas.brush.Color:=RGB(255,255,255);
   In07.Value:=0;
   end
   else
   begin
   image7.Canvas.brush.Color:=RGB(0,0,0);
   In07.Value:=1;
   end;
image7.Canvas.Rectangle(5,5,46,53);
end;

procedure TForm1.Image8Click(Sender: TObject);
begin
if image8.Canvas.Pixels[12,12]=RGB(0,0,0) then
   begin
   image8.Canvas.brush.Color:=RGB(255,255,255);
   In08.Value:=0;
   end
   else
   begin
   image8.Canvas.brush.Color:=RGB(0,0,0);
   In08.Value:=1;
   end;

image8.Canvas.Rectangle(5,5,46,53);
end;

procedure TForm1.Image9Click(Sender: TObject);
begin
if image9.Canvas.Pixels[12,12]=RGB(0,0,0) then
   begin
   image9.Canvas.brush.Color:=RGB(255,255,255);
   In09.Value:=0;
   end
   else
   begin
   image9.Canvas.brush.Color:=RGB(0,0,0);
   In09.Value:=1;
   end;

image9.Canvas.Rectangle(5,5,46,53);
end;


Procedure TForm1.Clear;
begin
image1.Canvas.brush.Color:=RGB(255,255,255);
image2.Canvas.brush.Color:=RGB(255,255,255);
image3.Canvas.brush.Color:=RGB(255,255,255);
image4.Canvas.brush.Color:=RGB(255,255,255);
image5.Canvas.brush.Color:=RGB(255,255,255);
image6.Canvas.brush.Color:=RGB(255,255,255);
image7.Canvas.brush.Color:=RGB(255,255,255);
image8.Canvas.brush.Color:=RGB(255,255,255);
image9.Canvas.brush.Color:=RGB(255,255,255);

image1.Canvas.Rectangle(1,1,57,57);
image2.Canvas.Rectangle(1,1,57,57);
image3.Canvas.Rectangle(1,1,57,57);
image4.Canvas.Rectangle(1,1,57,57);
image5.Canvas.Rectangle(1,1,57,57);
image6.Canvas.Rectangle(1,1,57,57);
image7.Canvas.Rectangle(1,1,57,57);
image8.Canvas.Rectangle(1,1,57,57);
image9.Canvas.Rectangle(1,1,57,57);
In01.Value:=0;
In02.Value:=0;
In03.Value:=0;
In04.Value:=0;
In05.Value:=0;
In06.Value:=0;
In07.Value:=0;
In08.Value:=0;
In09.Value:=0;


label1.Caption:='0.00';
label2.Caption:='0.00';

label6.Caption:='0.00';
label7.Caption:='0.00';
label8.Caption:='0.00';
label9.Caption:='0.00';
label10.Caption:='0.00';
label11.Caption:='0.00';
label12.Caption:='0.00';
label13.Caption:='0.00';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
clear;
NeuralNet1.LoadFromFile('paterns.net');
end;

procedure TForm1.Button1Click(Sender: TObject);
var max:real;
    pos:integer;
    smax:string;
begin
NeuralNet1.Update;
max:=Out01.Value;
pos:=1;
if max<Out02.Value then
   begin
   max:=Out02.Value;
   pos:=2;
   end;
if max<Out03.Value then
   begin
   max:=Out03.Value;
   pos:=3;
   end;
if max<Out04.Value then
   begin
   max:=Out04.Value;
   pos:=4;
   end;
if max<Out05.Value then
   begin
   max:=Out05.Value;
   pos:=5;
   end;
if max<Out06.Value then
   begin
   max:=Out06.Value;
   pos:=6;
   end;
if max<Out07.Value then
   begin
   max:=Out07.Value;
   pos:=7;
   end;
if max<Out08.Value then
   begin
   max:=Out08.Value;
   pos:=8;
   end;
Case pos of
     1:label1.caption:='1';
     2:label1.caption:='2';
     3:label1.caption:='3';
     4:label1.caption:='4';
     5:label1.caption:='5';
     6:label1.caption:='6';
     7:label1.caption:='7';
     8:label1.caption:='8';
     9:label1.caption:='9';
   end;
   str(max:4:2,smax);
   label2.Caption:=smax;

   str(Out01.Value:4:2,smax);
   label6.Caption:=smax;
   str(Out02.Value:4:2,smax);
   label7.Caption:=smax;
   str(Out03.Value:4:2,smax);
   label8.Caption:=smax;
   str(Out04.Value:4:2,smax);
   label9.Caption:=smax;
   str(Out05.Value:4:2,smax);
   label10.Caption:=smax;
   str(Out06.Value:4:2,smax);
   label11.Caption:=smax;
   str(Out07.Value:4:2,smax);
   label12.Caption:=smax;
   str(Out08.Value:4:2,smax);
   label13.Caption:=smax;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
clear;
end;

end.
