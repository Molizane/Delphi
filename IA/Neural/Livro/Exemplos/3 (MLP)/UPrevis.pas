unit UPrevis;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Db, DBTables;

type
  TFPrevis = class(TForm)
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
    Ciclos: longint;
    Aprendizagem, Inercia: double;
    NeuroniosOcultos: byte;
    Conhecimento: string;
    Minimo, Maximo: double;
  end;

var
  FPrevis: TFPrevis;

implementation

uses
  UConjTrein, UTrein, UParam, USobre, UTeste;

{$R *.DFM}

procedure TFPrevis.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFPrevis.ConjuntodeTreinamento1Click(Sender: TObject);
begin
  if not Assigned(ConjTrein) then
    ConjTrein := TConjTrein.Create(self);

  ConjTrein.Show;
end;

procedure TFPrevis.Treinamento1Click(Sender: TObject);
begin
  if not Assigned(Trein) then
    Trein := TTrein.Create(self);

  Trein.Show;
end;

procedure TFPrevis.Teste1Click(Sender: TObject);
begin
  if not Assigned(Teste) then
    Teste := TTeste.Create(self);

  Teste.Show;
end;

procedure TFPrevis.FormCreate(Sender: TObject);
begin
  Ciclos := 1000;
  Aprendizagem := 0.8;
  Inercia := 0.3;
  NeuroniosOcultos := 0;
  Conhecimento := 'Previs.mlp';
end;

procedure TFPrevis.Parmetros1Click(Sender: TObject);
begin
  if not Assigned(Parametros) then
    Parametros := TParametros.Create(self);

  try
    Parametros.ShowModal;
  finally
    Parametros.Free;
    Parametros := nil;
  end;
end;

procedure TFPrevis.Sobre1Click(Sender: TObject);
begin
  if not Assigned(Sobre) then
    Sobre := TSobre.Create(self);

  try
    Sobre.ShowModal;
  finally
    Sobre.Free;
    Sobre := nil;
  end;
end;

end.

