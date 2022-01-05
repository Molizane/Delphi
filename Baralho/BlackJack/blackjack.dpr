program blackjack;

uses
  Forms,
  Unit1 in 'UNITS\Unit1.pas' {Form1},
  Unit2 in 'UNITS\Unit2.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

