program CheckboxGrid;

{ $MODE Delphi}

{$mode objfpc}{$H+}

uses
  Forms, Interfaces,
  uCheckboxGrid in 'uCheckboxGrid.pas' {FrmCheckboxGrid};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmCheckboxGrid, FrmCheckboxGrid);
  Application.Run;
end.
