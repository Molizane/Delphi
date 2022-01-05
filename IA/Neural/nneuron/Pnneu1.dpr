program PNNeu1;

uses
  Forms,
  UNNeu3 in 'UNNeu3.pas' {Form1},
  UFGraf in 'UFGraf.pas' {FGra: TFrame},
  UFrRegua in '..\..\heuri\PPRay\UFrRegua.pas' {FrRegua: TFrame};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
