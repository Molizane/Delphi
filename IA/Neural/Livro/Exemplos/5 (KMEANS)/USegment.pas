unit USegment;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, DB,
  Menus, DBTables;

const
  MAXDIM = 11;
  MAXITEM = 20;
  CLUSTERS = 3;

type
  TFSegment = class(TForm)
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
    Alpha: double;
    NEpocas: longint;
    Conhecimento: string;
    Minimo, Maximo: array[0..MAXDIM - 1] of double;
  end;

var
  FSegment: TFSegment;

implementation

uses
  UConjTrein, UParam, USobre, UTrein, UTeste;

{$R *.DFM}

procedure TFSegment.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFSegment.ConjuntodeTreinamento1Click(Sender: TObject);
begin
  if not Assigned(ConjTrein) then
    ConjTrein := TConjTrein.Create(self);

  ConjTrein.Show;
end;

procedure TFSegment.Treinamento1Click(Sender: TObject);
begin
  if not Assigned(Trein) then
    Trein := TTrein.Create(self);

  Trein.Show;
end;

procedure TFSegment.Teste1Click(Sender: TObject);
begin
  if not Assigned(Teste) then
    Teste := TTeste.Create(self);

  Teste.Show;
end;

procedure TFSegment.FormCreate(Sender: TObject);
begin
  NEpocas := 1000;
  Alpha := 0.1;
  Conhecimento := 'Previs.mlp';
end;

procedure TFSegment.Parmetros1Click(Sender: TObject);
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

procedure TFSegment.Sobre1Click(Sender: TObject);
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

