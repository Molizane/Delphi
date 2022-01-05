unit UTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  DBTables, StdCtrls, Buttons, ComCtrls, MLP;

const
  ENTRADAS = 48; // N�mero de amostras iniciais
  PERIODOS = 10; // Repeti��es do per�odo de amostras (1 ciclo)

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
  { Inserir n�mero de neur�nios e camadas }
  MLP.Struct.Clear;
  MLP.Struct.Add(IntToStr(ENTRADAS)); // camada de entrada

  if FPrevis.NeuroniosOcultos > 0 then
    MLP.Struct.Add(IntToStr(FPrevis.NeuroniosOcultos)); // camada oculta (24)

  MLP.Struct.Add('1'); // camada de sa�da

  MLP.Build;
  MLP.Learning := FPrevis.Aprendizagem; // (90)
  MLP.Momentum := FPrevis.Inercia; // (50)
  MLP.Knowledge := FPrevis.Conhecimento; // 'Previs.mlp'

  { Defini��o dos valores m�ximo e m�nimo do conjunto de treinamento }
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

  { Defini��o da faixa de trabalho dos neur�nios de entrada }
  with MLP do
  begin
    { Consultas }
    for i := 1 to ENTRADAS do
    begin
      SetInputMin(i, FPrevis.Minimo);
      SetInputMax(i, FPrevis.Maximo);
    end;

    { Defini��o da faixa de trabalho do neur�nio de sa�da }
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
      //Writeln(f, 'Per�odo = ', i);

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
    m := 0; // conta o n�mero de �pocas

    { Faz para o n�mero de ciclos }
    for j := 0 to FPrevis.Ciclos - 1 do
    begin
      //Writeln(f, 'Ciclo = ', j + 1);

      { O numero de entradas pelos per�odos, deslocando-se uma amostra � frente a
        cada treinamento }
      for k := 1 to (PERIODOS * ENTRADAS) - ENTRADAS - 1 do
      begin
        //Writeln(f, '  Per�odo = ', k);

        i := 1;

        while i <= ENTRADAS do
        begin
          //Writeln(f, '    Entrada[', i,'] = Amostras[', k + i - 1, '] = ', FloatToStr(Amostras[k + i - 1]));
          MLP.SetInput(i, Amostras[k + i - 1]);
          Inc(i);
        end;

        //Writeln(f, '    Sa�da = Amostras[', k + i - 1, ']  = ', FloatToStr(Amostras[k + i - 1]));
        MLP.SetOutput(1, Amostras[k + i - 1]);
        //Writeln(f, '');

        MLP.Training;
        Inc(m);
      end;

      StatusBar1.Panels[0].Text := '�pocas: ' + IntToStr(m);
      StatusBar1.Panels[1].Text := Format('Erro Total: %2.6f', [MLP.Cost]);
      StatusBar1.Repaint;
      Application.ProcessMessages;
    end;

    { Ap�s treinar guarda o conhecimento acumulado pela rede }
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

