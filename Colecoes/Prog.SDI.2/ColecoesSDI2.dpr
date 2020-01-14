program ColecoesSDI2;

uses
  Forms,
  uPrincipalSDI in 'UNITS\uPrincipalSDI.pas' {FPrincipal},
  uFModeloSDI in 'UNITS\uFModeloSDI.pas' {FrmModelo},
  uDMPrincipalSDI in 'UNITS\uDMPrincipalSDI.pas' {DMPrincipal: TDataModule},
  uTiposSDI in 'UNITS\uTiposSDI.pas' {FTipos},
  uFModeloSDIPDA in 'UNITS\uFModeloSDIPDA.pas' {FrmModeloPDA},
  uCategoriasSDI in 'UNITS\uCategoriasSDI.pas' {FCategorias},
  uEditorasSDI in 'UNITS\uEditorasSDI.pas' {FEditoras},
  uPublicacoesSDI in 'UNITS\uPublicacoesSDI.pas' {FPublicacoes},
  uEdicoesSDI in 'UNITS\uEdicoesSDI.pas' {FEdicoes},
  uConteudoSDI in 'UNITS\uConteudoSDI.pas' {FConteudo},
  uDefs in '..\Prog.MDI\UNITS\uDefs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.

