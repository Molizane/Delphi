
program ColecoesMDI;

uses
  Forms,
  uPrincipalMDI in 'UNITS\uPrincipalMDI.pas' {FPrincipal},
  uFModeloMDI in 'UNITS\uFModeloMDI.pas' {FrmModelo},
  uDMPrincipalMDI in 'UNITS\uDMPrincipalMDI.pas' {DMPrincipal: TDataModule},
  uTiposMDI in 'UNITS\uTiposMDI.pas' {FTipos},
  uFModeloMDIPDA in 'UNITS\uFModeloMDIPDA.pas' {FrmModeloPDA},
  uCategoriasMDI in 'UNITS\uCategoriasMDI.pas' {FCategorias},
  uEditorasMDI in 'UNITS\uEditorasMDI.pas' {FEditoras},
  uPublicacoesMDI in 'UNITS\uPublicacoesMDI.pas' {FPublicacoes},
  uEdicoesMDI in 'UNITS\uEdicoesMDI.pas' {FEdicoes},
  uConteudoMDI in 'UNITS\uConteudoMDI.pas' {FConteudo},
  uDefs in 'UNITS\uDefs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.

