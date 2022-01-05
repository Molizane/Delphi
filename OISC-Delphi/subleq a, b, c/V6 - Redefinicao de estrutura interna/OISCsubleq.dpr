program OISCsubleq;

uses
  Forms,
  uOiscSubleq in 'UNITS\uOiscSubleq.pas' {FrmOISCSubleq},
  uThreadOiscSubleq in 'UNITS\uThreadOiscSubleq.pas',
  uShowCompiled in 'UNITS\uShowCompiled.pas' {FrmShowCompiled},
  uCompOiscSubleq in 'UNITS\uCompOiscSubleq.pas',
  uInternalRegs in 'UNITS\uInternalRegs.pas' {FrmInternalRegs};

{$R *.res}
{$R Kernel.RES}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.Title := 'OISC Emulator';
  Application.CreateForm(TFrmOISCSubleq, FrmOISCSubleq);
  Application.CreateForm(TFrmShowCompiled, FrmShowCompiled);
  Application.CreateForm(TFrmInternalRegs, FrmInternalRegs);
  Application.Run;
end.

