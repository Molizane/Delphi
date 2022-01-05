unit UTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  DBTables, StdCtrls, Buttons, ComCtrls, MLP;

const
  ENTRADAS = 48; // Número de amostras iniciais
  PERIODOS = 10; // Repetições do período de amostras (1 ciclo)

type
  TTrein = class(TForm)
    tblPrevis: TTable;
    dsPrevis: TDataSource;
    btnConstruir: TBitBtn;
    btnTreinar: TBitBtn;
    StatusBar1: TStatusBar;
    tblPrevisID: TIntegerField;
    tblPrevisHora: TFloatField;
    tblPrevisConsultas: TIntegerField;
    MLP: TMLP;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConstruirClick(Sender: TObject);
    procedure btnTreinarClick(Sender: TObject);
    procedure tblPrevisBeforeOpen(DataSet: TDataSet);
  private
  public
    Amostras: array[1..ENTRADAS * PERIODOS] of single;
  end;

var
  Trein: TTrein;

implementation

uses
  UPrevis;

{$R *.DFM}

procedure TTrein.FormCreate(Sender: TObject);
begin
  tblPrevis.Open;
end;

procedure TTrein.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblPrevis.Close;
  Action := caFree;
  Trein := nil;
end;

procedure TTrein.btnConstruirClick(Sender: TObject);
var
  i, j: integer;
  //f: TextFile;
begin
  { Inserir número de neurônios e camadas }
  MLP.Struct.Clear;
  MLP.Struct.Add(IntToStr(ENTRADAS)); // camada de entrada

  if FPrevis.NeuroniosOcultos > 0 then
    MLP.Struct.Add(IntToStr(FPrevis.NeuroniosOcultos)); // camada oculta (24)

  MLP.Struct.Add('1'); // camada de saída

  MLP.Build;
  MLP.Learning := FPrevis.Aprendizagem; // (90)
  MLP.Momentum := FPrevis.Inercia; // (50)
  MLP.Knowledge := FPrevis.Conhecimento; // 'Previs.mlp'

  { Definição dos valores máximo e mínimo do conjunto de treinamento }
  FPrevis.Minimo := 1E9;
  FPrevis.Maximo := -1E9;
  tblPrevis.First;

  while not tblPrevis.EOF do
  begin
    if tblPrevis['Consultas'] > FPrevis.Maximo then
      FPrevis.Maximo := tblPrevis['Consultas'];

    if tblPrevis['Consultas'] < FPrevis.Minimo then
      FPrevis.Minimo := tblPrevis['Consultas'];

    tblPrevis.Next;
  end;

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
  j := 1;

  //AssignFile(F, 'Amostras (base de treinamento).txt');
  //Rewrite(f);

  try
    for i := 1 to PERIODOS do
    begin
      //Writeln(f, 'Período = ', i);

      tblPrevis.First;

      while not tblPrevis.EOF do
      begin
        Amostras[j] := tblPrevis['Consultas'];
        //Writeln(f, '  Amostras[', j, '] = ', tblPrevis['Consultas']);
        Inc(j);
        tblPrevis.Next;
      end;

      //Writeln(f, '');
    end;

    btnConstruir.Enabled := False;
    btnTreinar.Enabled := True;
  finally
    //CloseFile(f);
  end;
end;

procedure TTrein.btnTreinarClick(Sender: TObject);
var
  i, k, j: word;
  m: longint;
  //f: TextFile;
begin
  { Treinamento }
  btnTreinar.Enabled := False;

  //AssignFile(F, 'Amostras (treinamento).txt');
  //Rewrite(f);

  try
    m := 0; // conta o número de épocas

    { Faz para o número de ciclos }
    for j := 0 to FPrevis.Ciclos - 1 do
    begin
      //Writeln(f, 'Ciclo = ', j + 1);

      { O numero de entradas pelos períodos, deslocando-se uma amostra à frente a
        cada treinamento }
      for k := 1 to (PERIODOS * ENTRADAS) - ENTRADAS - 1 do
      begin
        //Writeln(f, '  Período = ', k);

        i := 1;

        while i <= ENTRADAS do
        begin
          //Writeln(f, '    Entrada[', i,'] = Amostras[', k + i - 1, '] = ', FloatToStr(Amostras[k + i - 1]));
          MLP.SetInput(i, Amostras[k + i - 1]);
          Inc(i);
        end;

        //Writeln(f, '    Saída = Amostras[', k + i - 1, ']  = ', FloatToStr(Amostras[k + i - 1]));
        MLP.SetOutput(1, Amostras[k + i - 1]);
        //Writeln(f, '');

        MLP.Training;
        Inc(m);
      end;

      StatusBar1.Panels[0].Text := 'Épocas: ' + IntToStr(m);
      StatusBar1.Panels[1].Text := Format('Erro Total: %2.6f', [MLP.Cost]);
      StatusBar1.Repaint;
      Application.ProcessMessages;
    end;

    { Após treinar guarda o conhecimento acumulado pela rede }
    MLP.Save;
  finally
    btnTreinar.Enabled := True;
    //CloseFile(f);
  end;
end;

procedure TTrein.tblPrevisBeforeOpen(DataSet: TDataSet);
begin
  tblPrevis.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.

