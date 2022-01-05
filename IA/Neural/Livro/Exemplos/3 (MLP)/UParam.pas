unit UParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Spin;

type
  TParametros = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    seNeuronios: TSpinEdit;
    seNEpocas: TSpinEdit;
    seAprendizagem: TSpinEdit;
    Label3: TLabel;
    seInercia: TSpinEdit;
    Label4: TLabel;
    edArquivo: TEdit;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
  public
  end;

var
  Parametros: TParametros;

implementation

uses
  UPrevis;

{$R *.DFM}

procedure TParametros.FormActivate(Sender: TObject);
begin
  seNEpocas.Value := FPrevis.Ciclos;
  seNeuronios.Value := FPrevis.NeuroniosOcultos;
  seAprendizagem.Value := Round(100 * (FPrevis.Aprendizagem));
  seInercia.Value := Round(100 * (FPrevis.Inercia));
  edArquivo.Text := FPrevis.Conhecimento;
end;

procedure TParametros.BitBtn1Click(Sender: TObject);
begin
  with FPrevis do
  begin
    Ciclos := seNEpocas.Value;
    NeuroniosOcultos := seNeuronios.Value;
    Aprendizagem := seAprendizagem.Value / 100;
    Inercia := seInercia.Value / 100;
    Conhecimento := edArquivo.Text;
  end;
end;

end.

