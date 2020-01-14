program Colecoes;

uses
  Forms,
  uPrincipal in 'UNITS\uPrincipal.pas' {FPrincipal},
  uFModelo in 'UNITS\uFModelo.pas' {FrmModelo},
  uDMPrincipal in 'UNITS\uDMprincipal.pas' {DMPrincipal: TDataModule},
  uTipos in 'UNITS\uTipos.pas' {FTipos},
  uFModeloPDA in 'UNITS\uFModeloPDA.pas' {FrmModeloPDA},
  uCategorias in 'UNITS\uCategorias.pas' {FCategorias},
  uEditoras in 'UNITS\uEditoras.pas' {FEditoras},
  uPublicacoes in 'UNITS\uPublicacoes.pas' {FPublicacoes},
  uEdicoes in 'UNITS\uEdicoes.pas' {FEdicoes},
  uConteudo in 'UNITS\uConteudo.pas' {FConteudo},
  uDefs in '..\Prog.MDI\UNITS\uDefs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.

