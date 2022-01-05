unit UOCR;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Db, DBTables;

type
  TFOCR = class(TForm)
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
    ConjuntodeTeste1: TMenuItem;
    N3: TMenuItem;
    reinamento1600x101: TMenuItem;
    este1600x101: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure ConjuntodeTreinamento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Parmetros1Click(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure Treinamento1Click(Sender: TObject);
    procedure ConjuntodeTeste1Click(Sender: TObject);
    procedure Teste1Click(Sender: TObject);
    procedure reinamento1600x101Click(Sender: TObject);
    procedure este1600x101Click(Sender: TObject);
  private
  public
    NEpocas: longint;
    Aprendizagem, Inercia: double;
    NeuroniosOcultos: byte;
    Conhecimento: string;
  end;

var
  FOCR: TFOCR;

implementation

uses UConjTrein, UParam, USobre, UOCRTrein576, UConjTeste, UOCRTeste576,
  UOCRTrein1600, UOCRTeste1600;

{$R *.DFM}

procedure TFOCR.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFOCR.ConjuntodeTreinamento1Click(Sender: TObject);
begin
  if not Assigned(ConjTrein) then
    ConjTrein := TConjTrein.Create(self);

  ConjTrein.Show;
end;

procedure TFOCR.FormCreate(Sender: TObject);
begin
  NEpocas := 1000;
  Aprendizagem := 0.9;
  Inercia := 0.3;
  NeuroniosOcultos := 5;
  Conhecimento := 'Perfil.mlp';
end;

procedure TFOCR.Parmetros1Click(Sender: TObject);
begin
  if not Assigned(Parametros) then
    Parametros := TParametros.Create(self);

  if Parametros.ShowModal = mrOk then
    ;
  Parametros.Free;
  Parametros := nil;
end;

procedure TFOCR.Sobre1Click(Sender: TObject);
begin
  if not Assigned(Sobre) then
    Sobre := TSobre.Create(self);

  if Sobre.ShowModal = mrOk then
    ;
  Sobre.Free;
  Sobre := nil;
end;

procedure TFOCR.Treinamento1Click(Sender: TObject);
begin
  if not Assigned(FOCRTrein576) then
    FOCRTrein576 := TFOCRTrein576.Create(self);

  FOCRTrein576.Show;
end;

procedure TFOCR.ConjuntodeTeste1Click(Sender: TObject);
begin
  if not Assigned(ConjTeste) then
    ConjTeste := TConjTeste.Create(self);

  ConjTeste.Show;
end;

procedure TFOCR.Teste1Click(Sender: TObject);
begin
  if not Assigned(FOCRTeste576) then
    FOCRTeste576 := TFOCRTeste576.Create(self);

  FOCRTeste576.Show;
end;

procedure TFOCR.reinamento1600x101Click(Sender: TObject);
begin
  if not Assigned(FOCRTrein1600) then
    FOCRTrein1600 := TFOCRTrein1600.Create(self);

  FOCRTrein1600.Show;
end;

procedure TFOCR.este1600x101Click(Sender: TObject);
begin
  if not Assigned(FOCRTeste1600) then
    FOCRTeste1600 := TFOCRTeste1600.Create(self);

  FOCRTeste1600.Show;
end;

end.
