program przFuzzy;

uses
  Forms,
  zfuzzyU in 'zfuzzyU.pas' {fmFuzzy};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfmFuzzy, fmFuzzy);
  Application.Run;
end.
