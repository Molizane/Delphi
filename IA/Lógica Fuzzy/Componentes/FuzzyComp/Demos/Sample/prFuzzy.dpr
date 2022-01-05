program prFuzzy;

uses
  Forms,
  fuzzyU in 'fuzzyU.pas' {fmFuzzy};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmFuzzy, fmFuzzy);
  Application.Run;
end.
