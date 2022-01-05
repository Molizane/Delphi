program NetDemo;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  frmTargetTbl in 'frmTargetTbl.pas' {TargetForm},
  frmChooseTarget in 'frmChooseTarget.pas' {ChooseTargetForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TTargetForm, TargetForm);
  Application.CreateForm(TChooseTargetForm, ChooseTargetForm);
  Application.Run;
end.
