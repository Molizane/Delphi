unit UTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  DBTables, StdCtrls, Buttons, ComCtrls, KMeans;

const
  MAXDIM = 11;
  MAXITEM = 20;
  CLUSTERS = 3;

type
  TTrein = class(TForm)
    tblSegment: TTable;
    dsSegment: TDataSource;
    btnConstruir: TBitBtn;
    btnTreinar: TBitBtn;
    StatusBar1: TStatusBar;
    KMeans: TKMeans;
    tblSegmentID: TIntegerField;
    tblSegmentRenda: TIntegerField;
    tblSegmentIdade: TIntegerField;
    tblSegmentSexo: TIntegerField;
    tblSegmentTV: TIntegerField;
    tblSegmentRadio: TIntegerField;
    tblSegmentVideo: TIntegerField;
    tblSegmentInternet: TIntegerField;
    tblSegmentConjuge: TIntegerField;
    tblSegmentFaixa1: TIntegerField;
    tblSegmentFaixa2: TIntegerField;
    tblSegmentFaixa3: TIntegerField;
    tblSegmentClasse: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConstruirClick(Sender: TObject);
    procedure btnTreinarClick(Sender: TObject);
    function KMeansGetCluster(Sender: TObject; i: Integer): Word;
    function KMeansGetData(Sender: TObject; i, j: Integer): Double;
    procedure tblSegmentBeforeOpen(DataSet: TDataSet);
  private
    Classe: array[0..MAXITEM - 1] of integer;
    Amostras: array[0..MAXITEM - 1, 0..MAXDIM - 1] of double;
  public
  end;

var
  Trein: TTrein;

implementation

uses
  USegment;

{$R *.DFM}

procedure TTrein.FormCreate(Sender: TObject);
begin
  tblSegment.Open;
end;

procedure TTrein.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblSegment.Close;
  Action := caFree;
  Trein := nil;
end;

procedure TTrein.btnConstruirClick(Sender: TObject);
var
  i, j: integer;
begin
  { Assimila parâmetros iniciais }
  KMeans.ItemsNum := MAXITEM;
  KMeans.ClusterNum := CLUSTERS;
  KMeans.Dimension := MAXDIM;
  KMeans.Knowledge := FSegment.Conhecimento;

  { Inicializa a estrutura }
  KMeans.Initialize;

  { Leitura dos valores da tabela }
  tblSegment.First;

  while not tblSegment.Eof do
  begin
    { Cada registro corresponde a uma amostra }
    i := tblSegment['ID'] - 1;

    for j := 1 to tblSegment.FieldCount - 2 do
      { Cada atributo da amostra }
      Amostras[i, j - 1] := tblSegment.Fields[j].Value;

    { Guarda a classe correspondente }
    Classe[i] := tblSegment['Classe'];

    { Próxima amostra }
    tblSegment.Next;
  end;

  { Definição da faixa de trabalho }
  with FSegment do
  begin
    // Renda
    Minimo[0] := 1000;
    Maximo[0] := 6000;

    // Idade
    Minimo[1] := 18;
    Maximo[1] := 60;

    // Sexo
    Minimo[2] := 0;
    Maximo[2] := 1;

    // TV
    Minimo[3] := 0;
    Maximo[3] := 3;

    // Radio
    Minimo[4] := 0;
    Maximo[4] := 2;

    // Videos
    Minimo[5] := 0;
    Maximo[5] := 20;

    // Internet
    Minimo[6] := 0;
    Maximo[6] := 2;

    // Cônjuge
    Minimo[7] := 0;
    Maximo[7] := 1;

    // Faixa de dependentes 0-7 anos
    Minimo[8] := 0;
    Maximo[8] := 5;

    // Faixa de dependentes 8-15 anos
    Minimo[9] := 0;
    Maximo[9] := 5;

    // Faixa de dependentes 16 anos para cima
    Minimo[10] := 0;
    Maximo[10] := 5;
  end;

  btnConstruir.Enabled := False;
  btnTreinar.Enabled := True;
end;

procedure TTrein.btnTreinarClick(Sender: TObject);
var
  i, k, j: word;
  m: longint;
begin
  btnTreinar.Enabled := False;

  try
    { Executa treinamento para várias épocas }
    for k := 0 to FSegment.NEpocas do
    begin
      KMeans.Step;
      StatusBar1.Panels[0].Text := 'Épocas: ' + IntToStr(k);
      StatusBar1.Panels[1].Text := 'Erro Total: ' + Format('%2.10f', [KMeans.Cost]);
      StatusBar1.Repaint;
    end;

    KMeans.Save;
  finally
    btnTreinar.Enabled := True;
  end;
end;

function TTrein.KMeansGetCluster(Sender: TObject; i: Integer): Word;
begin
  { Adquire a classe do cluster para rodar o algoritmo internamente }
  Result := Classe[i] - 1;
end;

function TTrein.KMeansGetData(Sender: TObject; i, j: Integer): Double;
begin
  { Os dados são fornecidos pela matriz Amostras e normalizados }
  with FSegment do
    Result := (Amostras[i, j] - Minimo[j]) / (Maximo[j] - Minimo[j]);
end;

procedure TTrein.tblSegmentBeforeOpen(DataSet: TDataSet);
begin
  tblSegment.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.

