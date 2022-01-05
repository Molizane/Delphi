program Random;

uses
  Forms,
  Random_ in 'RANDOM_.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
