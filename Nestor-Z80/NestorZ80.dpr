program NestorZ80;

uses
  Forms,
  SysUtils,
  EngineZ80 in '..\Engines\Z80\EngineZ80.pas',
  DisassemblyZ80 in '..\Engines\Z80\DisassemblyZ80.pas',
  MemoryZ80 in '..\Engines\Z80\MemoryZ80.pas',
  MI in '..\Engines\Z80\MI.pas' {FMI},
  Memory in '..\Engines\Memory.pas' {FrmMemory},
  NestorListagem in 'UNIT\NestorListagem.pas' {LstForm},
  HelpUnit in 'UNIT\HelpUnit.pas' {HelpForm},
  NestorMain in 'UNIT\NestorMain.pas' {FrmMain},
  NestorFonte in 'UNIT\NestorFonte.pas' {FrmFontes},
  NestorRegistros in 'UNIT\NestorRegistros.pas' {FrmRegistros},
  NestorFlags in 'UNIT\NestorFlags.pas' {FrmFlags},
  NestorBP in 'UNIT\NestorBP.pas' {FrmBreakPoints},
  NestorTerminal in 'UNIT\NestorTerminal.pas' {FrmTerminal},
  NestorAS80 in 'UNIT\NestorAS80.pas';

{$R *.res}

begin
  ExePath := ExtractFilePath(Application.Exename);
  CompPath := ExePath + 'TEMP\';
  ForceDirectories(CompPath);

  Application.Initialize;
  Application.Title := 'Nestor Z80 Nova Eletrônica 1984';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TLstForm, LstForm);
  Application.Run;
end.

