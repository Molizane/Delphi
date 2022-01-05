program Previs;

uses
  Forms,
  UPrevis in 'UPrevis.pas' {FPrevis},
  UTrein in 'UTrein.pas' {Trein},
  UConjTrein in 'UConjTrein.pas' {ConjTrein},
  UParam in 'UParam.pas' {Parametros},
  USobre in 'USobre.pas' {Sobre},
  UTeste in 'UTeste.pas' {Teste};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFPrevis, FPrevis);
  Application.Run;
end.

