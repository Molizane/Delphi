program SomaSub8Bits;

uses
  Forms,
  uSomaSub8Bits in 'UNITS\uSomaSub8Bits.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
