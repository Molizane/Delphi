program Perfil;

uses
  Forms,
  UPerfil in 'UPerfil.pas' {FPerfil},
  UParam in 'UParam.pas' {Parametros},
  USobre in 'USobre.pas' {Sobre},
  UTrein in 'UTrein.pas' {Trein},
  UConjTrein in 'UConjTrein.pas' {ConjTrein},
  UTeste in 'UTeste.pas' {Teste};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFPerfil, FPerfil);
  Application.Run;
end.

