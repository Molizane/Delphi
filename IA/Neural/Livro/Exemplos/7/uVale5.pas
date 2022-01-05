unit uVale5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, DB, DBTables;

type
  TFVale5 = class(TForm)
    MainMenu1: TMainMenu;
    Geral1: TMenuItem;
    Sair1: TMenuItem;
    MLP1: TMenuItem;
    ConjuntodeTreinamento1: TMenuItem;
    Treinamento1: TMenuItem;
    Teste1: TMenuItem;
    Sobre1: TMenuItem;
    N2: TMenuItem;
    Database1: TDatabase;
    Parmetros1: TMenuItem;
    N1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure ConjuntodeTreinamento1Click(Sender: TObject);
    procedure Treinamento1Click(Sender: TObject);
    procedure Teste1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Parmetros1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
  private
  public
    NEpocas: longint;
    Aprendizagem, Inercia: double;
    NeuroniosOcultos: byte;
    Conhecimento: string;
  end;

var
  FVale5: TFVale5;

implementation

uses
  UConjTrein, UTrein, UTeste, UParam, USobre;

{$R *.DFM}

procedure TFVale5.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFVale5.ConjuntodeTreinamento1Click(Sender: TObject);
begin
  if not Assigned(FrmConjTrein) then
    FrmConjTrein := TFrmConjTrein.Create(self);

  FrmConjTrein.Show;
end;

procedure TFVale5.Treinamento1Click(Sender: TObject);
begin
  if not Assigned(FrmTrein) then
    FrmTrein := TFrmTrein.Create(self);

  FrmTrein.Show;
end;

procedure TFVale5.Teste1Click(Sender: TObject);
begin
  if not Assigned(FrmTeste) then
    FrmTeste := TFrmTeste.Create(self);

  FrmTeste.Show;
end;

procedure TFVale5.FormCreate(Sender: TObject);
begin
  NEpocas := 1000;
  Aprendizagem := 0.9;
  Inercia := 0.3;
  NeuroniosOcultos := 5;
  Conhecimento := 'Vale5.mlp';
end;

procedure TFVale5.Parmetros1Click(Sender: TObject);
begin
  if not Assigned(FrmParametros) then
    FrmParametros := TFrmParametros.Create(self);

  try
    FrmParametros.ShowModal;
  finally
    FrmParametros.Release;
    FrmParametros := nil;
  end;
end;

procedure TFVale5.Sobre1Click(Sender: TObject);
begin
  if not Assigned(FrmSobre) then
    FrmSobre := TFrmSobre.Create(self);

  try
    FrmSobre.ShowModal;
  finally
    FrmSobre.Release;
    FrmSobre := nil;
  end;
end;

end.

