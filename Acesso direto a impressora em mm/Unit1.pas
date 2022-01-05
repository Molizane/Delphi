unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Printers;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Printer.BeginDoc;

  try
    //Each logical unit is mapped to 0.1 millimeter.
    //Positive x is to the right; positive y is up.
    SetMapMode(Printer.Canvas.Handle, MM_LOMETRIC);

    with Printer.Canvas do
    begin
      //font 5 mm height
      Font.Height := 50;
      Font.Name := 'Verdana';

      TextOut(250, -110, 'SwissDelphiCenter');
      TextOut(250, -180, 'http://www.swissdelphicenter.ch');

      MoveTo(250, -240);

      //Draw a line of 7,5 cm
      LineTo(1000, -240);
    end;

  finally
    Printer.EndDoc;
  end;
end;

end.
