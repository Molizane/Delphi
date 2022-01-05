program Cards;

uses
  Forms,
  uCardsMain in 'UNITS\uCardsMain.pas' {MainForm},
  uCardsTitle in 'UNITS\uCardsTitle.pas' {FTitulo},
  uCardsAbout in 'UNITS\uCardsAbout.pas' {AboutBox};

{$R Cards.res}

begin
  Application.Initialize;
  Application.Title := 'Cards';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFTitulo, FTitulo);
  Application.Run;
end.

