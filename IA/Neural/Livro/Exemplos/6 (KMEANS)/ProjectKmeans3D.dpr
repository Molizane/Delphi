program ProjectKmeans3D;

uses
  Forms,
  UnitKMeans3D in 'UnitKMeans3D.pas' {CgForm1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TCgForm1, CgForm1);
  Application.Run;
end.

