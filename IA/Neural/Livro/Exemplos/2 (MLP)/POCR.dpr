program POCR;

uses
  Forms,
  UOCR in 'UOCR.pas' {FOCR},
  UParam in 'UParam.pas' {Parametros},
  USobre in 'USobre.pas' {Sobre},
  UConjTeste in 'UConjTeste.pas' {ConjTeste},
  UConjTrein in 'UConjTrein.pas' {ConjTrein},
  UOCRTeste576 in 'UOCRTeste576.pas' {FOCRTeste576},
  UOCRTeste1600 in 'UOCRTeste1600.pas' {FOCRTeste1600},
  UOCRTrein576 in 'UOCRTrein576.pas' {FOCRTrein576},
  UOCRTrein1600 in 'UOCRTrein1600.pas' {FOCRTrein1600};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFOCR, FOCR);
  Application.CreateForm(TParametros, Parametros);
  Application.CreateForm(TSobre, Sobre);
  Application.Run;
end.

