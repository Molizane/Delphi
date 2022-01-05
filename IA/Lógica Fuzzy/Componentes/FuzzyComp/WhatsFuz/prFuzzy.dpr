program prFuzzy;

uses
  Forms,
  fuzzyU in 'fuzzyU.pas' {fmFuzzy},
  fuzzyDspU in 'fuzzyDspU.pas' {frmGrid};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Fuzzy';
  Application.CreateForm(TfmFuzzy, fmFuzzy);
  Application.CreateForm(TfrmGrid, frmGrid);
  frmGrid.Left := 10;
  frmGrid.Top := 10;
  Application.Run;
end.
