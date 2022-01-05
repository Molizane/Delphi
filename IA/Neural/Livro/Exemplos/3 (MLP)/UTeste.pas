unit UTeste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, MLP, StdCtrls, Buttons, Grids, DBGrids;

const
  ENTRADAS = 48; // Número de amostras iniciais
  PERIODOS = 10; // Repetições do período de amostras (1 ciclo)

type
  TTeste = class(TForm)
    DBGrid1: TDBGrid;
    btnTeste: TBitBtn;
    MLP: TMLP;
    tblPrevis: TTable;
    dsPrevis: TDataSource;
    tblPrevisTeste: TTable;
    dsPrevisTeste: TDataSource;
    DBGrid2: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnTesteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tblPrevisBeforeOpen(DataSet: TDataSet);
    procedure tblPrevisTesteBeforeOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
  public
    Amostras: array[1..ENTRADAS * PERIODOS] of double;
  end;

var
  Teste: TTeste;

implementation

uses
  UPrevis;

{$R *.dfm}

procedure TTeste.FormCreate(Sender: TObject);
var
  i, j: integer;
begin
  { Abertura dos arquivos }
  tblPrevis.Open;
  tblPrevisTeste.Open;

  { Apaga conteúdo da tabela de teste }
  tblPrevisTeste.First;

  while not tblPrevisTeste.Eof do
    tblPrevisTeste.Delete;

  { Inserir número de neurônios e camadas }
  MLP.Struct.Clear;
  MLP.Struct.Add(IntToStr(ENTRADAS)); // camada de entrada

  if FPrevis.NeuroniosOcultos > 0 then
    MLP.Struct.Add(IntToStr(FPrevis.NeuroniosOcultos)); // camada oculta

  MLP.Struct.Add('1'); // camada de saída

  { Construção da rede }
  MLP.Build;
  MLP.Learning := FPrevis.Aprendizagem;
  MLP.Momentum := FPrevis.Inercia;
  MLP.Knowledge := FPrevis.Conhecimento;

  MLP.Load;

  { Definição da faixa de trabalho dos neurônios de entrada }
  with MLP do
  begin
    { Consultas }
    for i := 1 to ENTRADAS do
    begin
      SetInputMin(i, FPrevis.Minimo);
      SetInputMax(i, FPrevis.Maximo);
    end;

    { Definição da faixa de trabalho do neurônio de saída }
    SetOutputMin(1, FPrevis.Minimo);
    SetOutputMax(1, FPrevis.Maximo);
  end;

  { Preenche o vetor de amostras }
  j := 0;
  tblPrevis.First;

  while not tblPrevis.Eof do
  begin
    Amostras[j] := tblPrevis['Consultas'];
    Inc(j);
    tblPrevis.Next;
  end;
end;

procedure TTeste.btnTesteClick(Sender: TObject);
var
  i, k: integer;
  //f: TextFile;
begin
   while not tblPrevisTeste.IsEmpty do
     tblPrevisTeste.Delete;

  //AssignFile(F, 'Amostras (teste).txt');
  //Rewrite(f);

  try
    { Associação dos valores de entrada da amostra }
    for k := 1 to ENTRADAS do
    begin
      //Writeln(f, 'k = ', k);

      i := 1;

      while i <= ENTRADAS do
      begin
        MLP.SetInput(i, Amostras[k + i - 1]);
        //Writeln(f, '  Amostras[', k + i - 1, '] = ', FloatToStr(Amostras[k + i - 1]));
        Inc(i);
      end;

      MLP.Test;

      Amostras[k + i - 1] := MLP.GetOutput(1);

      //Writeln(f, '    Amostras*[', k + i - 1, '] = ', FloatToStr(Amostras[k + i - 1]));
      //Writeln(f, '');

      tblPrevisTeste.Append;
      tblPrevisTeste['ID'] := k;
      tblPrevisTeste['Hora'] := k / 2;
      tblPrevisTeste['Consultas'] := Amostras[k + i - 1];
      tblPrevisTeste.Post;
    end;

    tblPrevisTeste.Refresh;
    tblPrevisTeste.First;
  finally
    //CloseFile(f);
  end;
end;

procedure TTeste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Teste := nil;
end;

procedure TTeste.tblPrevisBeforeOpen(DataSet: TDataSet);
begin
  tblPrevis.DatabaseName := ExtractFilePath(Application.ExeName);
end;

procedure TTeste.tblPrevisTesteBeforeOpen(DataSet: TDataSet);
begin
  tblPrevisTeste.DatabaseName := ExtractFilePath(Application.ExeName);
end;

procedure TTeste.FormShow(Sender: TObject);
begin
  tblPrevis.First;
end;

end.

