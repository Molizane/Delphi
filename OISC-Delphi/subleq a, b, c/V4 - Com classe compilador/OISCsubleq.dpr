program OISCsubleq;

uses
  Forms,
  uOiscSubleq in 'UNITS\uOiscSubleq.pas' {FrmOISCSubleq},
  uThreadOiscSubleq in 'UNITS\uThreadOiscSubleq.pas',
  uShowCompiled in 'UNITS\uShowCompiled.pas' {FrmShowCompiled},
  uCompOiscSubleq in 'UNITS\uCompOiscSubleq.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.Title := 'OISC Emulator';
  Application.CreateForm(TFrmOISCSubleq, FrmOISCSubleq);
  Application.CreateForm(TFrmShowCompiled, FrmShowCompiled);
  Application.Run;
end.
