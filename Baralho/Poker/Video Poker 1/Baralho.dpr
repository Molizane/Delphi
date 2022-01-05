program Baralho;

uses
  Forms,
  uBaralho in 'UNITS\uBaralho.pas',
  uPoker in 'UNITS\uPoker.pas' {FrmPoker},
  uImagens in 'UNITS\uImagens.pas' {DMImagens: TDataModule},
  uEmbaralhamento in 'UNITS\uEmbaralhamento.pas' {FrmEmbaralhamento};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMImagens, DMImagens);
  Application.CreateForm(TFrmPoker, FrmPoker);
  Application.Run;
end.

