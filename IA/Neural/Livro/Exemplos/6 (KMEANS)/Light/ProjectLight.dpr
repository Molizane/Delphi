program ProjectLight;

uses
  Forms,
  UnitLight in 'UnitLight.pas' {CgForm2},
  CgWindow in '..\CgWindow.pas',
  GL in '..\GL.pas',
  CgTypes in '..\CgTypes.pas',
  CgLight in '..\CgLight.pas',
  GLu in '..\GLu.pas',
  Glut in '..\GLut.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TCgForm2, CgForm2);
  Application.Run;
end.

