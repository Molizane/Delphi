program CobaltSDKExampleD5;

uses
  Forms,
  UMain in 'UMain.pas' {mdiMain},
  UGA in 'UGA.pas' {frmGA},
  UFZ in 'UFZ.pas' {frmFZ},
  UNN in 'UNN.pas' {frmNN};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TmdiMain, mdiMain);
  Application.Run;
end.
