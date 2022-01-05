unit UPerfil;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Db, DBTables;

type
  TFPerfil = class(TForm)
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
  FPerfil: TFPerfil;

implementation

uses UConjTrein, UTrein, UTeste, UParam, USobre;

{$R *.DFM}

procedure TFPerfil.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFPerfil.ConjuntodeTreinamento1Click(Sender: TObject);
begin
  if not Assigned(ConjTrein) then
    ConjTrein := TConjTrein.Create(self);

  ConjTrein.Show;
end;

procedure TFPerfil.Treinamento1Click(Sender: TObject);
begin
  if not Assigned(Trein) then
    Trein := TTrein.Create(self);

  Trein.Show;
end;

procedure TFPerfil.Teste1Click(Sender: TObject);
begin
  if not Assigned(Teste) then
    Teste := TTeste.Create(self);

  Teste.Show;
end;

procedure TFPerfil.FormCreate(Sender: TObject);
begin
  NEpocas := 1000;
  Aprendizagem := 0.9;
  Inercia := 0.3;
  NeuroniosOcultos := 5;
  Conhecimento := 'Perfil.mlp';
end;

procedure TFPerfil.Parmetros1Click(Sender: TObject);
begin
  if not Assigned(Parametros) then
    Parametros := TParametros.Create(self);

  if Parametros.ShowModal = mrOk then
    ;
  Parametros.Free;
  Parametros := nil;
end;

procedure TFPerfil.Sobre1Click(Sender: TObject);
begin
  if not Assigned(Sobre) then
    Sobre := TSobre.Create(self);

  if Sobre.ShowModal = mrOk then
    ;
  Sobre.Free;
  Sobre := nil;
end;

end.

