program Cadastro;

uses
  Forms,
  uFModelo in 'uFModelo.pas' {FrmModelo},
  uPrincipal in 'uPrincipal.pas' {FPrincipal},
  uCadTipos in 'uCadTipos.pas' {FCadTipos},
  uDMprincipal in 'uDMPrincipal.pas' {DMPrincipal: TDataModule},
  uCadPessoas in 'uCadPessoas.pas' {FCadPessoas};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMPrincipal, DMPrincipal);
  Application.CreateForm(TFPrincipal, FPrincipal);
  Application.Run;
end.

