program vale5;

uses
  Forms,
  uVale5 in 'uVale5.pas' {FVale5},
  UParam in 'UParam.pas' {FrmParametros},
  USobre in 'USobre.pas' {FrmSobre},
  UConjTrein in 'UConjTrein.pas' {FrmConjTrein},
  UTeste in 'UTeste.pas' {FrmTeste},
  UTrein in 'UTrein.pas' {FrmTrein};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFVale5, FVale5);
  Application.Run;
end.

