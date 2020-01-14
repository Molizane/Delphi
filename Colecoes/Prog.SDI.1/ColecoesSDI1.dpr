program ColecoesSDI1;

uses
  Forms,
  uPrincipalSDI in 'UNITS\uPrincipalSDI.pas' {FPrincipal},
  uDMprincipalSDI in 'UNITS\uDMprincipalSDI.pas' {DMPrincipal: TDataModule},
  uFModeloSDI in 'UNITS\uFModeloSDI.pas' {FrmModeloSDI},
  uTiposSDI in 'UNITS\uTiposSDI.pas' {FTipos},
  uFModeloSDIPDA in 'UNITS\uFModeloSDIPDA.pas' {FrmModeloSDIPDA},
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

