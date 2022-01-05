program prFuzzy;

uses
  Forms,
  fuzzyU in 'fuzzyU.pas' {fmFuzzy},
  FuzzyComp in 'FuzzyComp.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmFuzzy, fmFuzzy);
  Application.Run;
end.
