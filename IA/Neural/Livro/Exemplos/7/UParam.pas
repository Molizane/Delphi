unit UParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Spin;

type
  TFrmParametros = class(TForm)
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
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    Panel1: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
  public
  end;

var
  FrmParametros: TFrmParametros;

implementation

uses
  uVale5;

{$R *.DFM}

procedure TFrmParametros.FormActivate(Sender: TObject);
begin
  seNEpocas.Value := FVale5.NEpocas;
  seNeuronios.Value := FVale5.NeuroniosOcultos;
  seAprendizagem.Value := Round(100 * FVale5.Aprendizagem);
  seInercia.Value := Round(100 * FVale5.Inercia);
  edArquivo.Text := FVale5.Conhecimento;
end;

procedure TFrmParametros.btnOkClick(Sender: TObject);
begin
  with FVale5 do
  begin
    NEpocas := seNEpocas.Value;
    NeuroniosOcultos := seNeuronios.Value;
    Aprendizagem := seAprendizagem.Value / 100;
    Inercia := seInercia.Value / 100;
    Conhecimento := edArquivo.Text;
  end;
end;

end.

