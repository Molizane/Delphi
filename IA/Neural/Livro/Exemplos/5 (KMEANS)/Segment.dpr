program Segment;

uses
  Forms,
  USegment in 'USegment.pas' {FSegment},
  UTrein in 'UTrein.pas' {Trein},
  UConjTrein in 'UConjTrein.pas' {ConjTrein},
  UParam in 'UParam.pas' {Parametros},
  USobre in 'USobre.pas' {Sobre},
  UTeste in 'UTeste.pas' {Teste};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFSegment, FSegment);
  Application.Run;
end.

