unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  NeuralNet, NNSignal;

type
  TForm1 = class(TForm)
    inpIdade: TNNSignal;
    inpPeso: TNNSignal;
    inpSexo: TNNSignal;
    inpExame: TNNSignal;
    NeuralNet1: TNeuralNet;
    outMuitoBaixo: TNNSignal;
    outBaixo: TNNSignal;
    outNormal: TNNSignal;
    outPoucoAlto: TNNSignal;
    outAlto: TNNSignal;
    outMuitoAlto: TNNSignal;
    inpResultado: TNNSignal;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
