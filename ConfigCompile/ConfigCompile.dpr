program ConfigCompile;

uses
  Forms,
  UConfigCompile in 'UNITS\UConfigCompile.pas' {FrmMain},
  UConfiguracoes in 'UNITS\UConfiguracoes.pas' {FrmConfiguracoes},
  UNomeConfiguracao in 'UNITS\UNomeConfiguracao.pas' {FrmNomeConfiguracao};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmConfiguracoes, FrmConfiguracoes);
  Application.CreateForm(TFrmNomeConfiguracao, FrmNomeConfiguracao);
  Application.Run;
end.
