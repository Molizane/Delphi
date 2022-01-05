program FuzzyMotor;

uses
  Forms,
  uFuzzyMotor in 'uFuzzyMotor.pas' {frmFuzzyMotor};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFuzzyMotor, frmFuzzyMotor);
  Application.Run;
end.
