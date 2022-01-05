unit UParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, Spin;

type
  TParametros = class(TForm)
    Label1: TLabel;
    seNEpocas: TSpinEdit;
    seAlpha: TSpinEdit;
    Label3: TLabel;
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
  USegment;

{$R *.DFM}

procedure TParametros.FormActivate(Sender: TObject);
begin
  seNEpocas.Value := FSegment.NEpocas;
  seAlpha.Value := Round(100 * (FSegment.Alpha));
  edArquivo.Text := FSegment.Conhecimento;
end;

procedure TParametros.BitBtn1Click(Sender: TObject);
begin
  with FSegment do
  begin
    NEpocas := seNEpocas.Value;
    Alpha := seAlpha.Value / 100;
    Conhecimento := edArquivo.Text;
  end;
end;

end.

