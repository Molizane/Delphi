program CheckboxGrid;

uses
  Forms,
  uCheckboxGrid in 'UNITS\uCheckboxGrid.pas' {FrmCheckboxGrid};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmCheckboxGrid, FrmCheckboxGrid);
  Application.Run;
end.
