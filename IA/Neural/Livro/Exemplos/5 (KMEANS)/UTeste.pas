unit UTeste;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  DBTables, StdCtrls, Buttons, Spin, ExtCtrls, KMeans;

const
  MAXDIM = 11;
  MAXITEM = 20;
  CLUSTERS = 3;

type
  TTeste = class(TForm)
    tblSegment: TTable;
    dsSegment: TDataSource;
    seRenda: TSpinEdit;
    seIdade: TSpinEdit;
    seSexo: TSpinEdit;
    seTV: TSpinEdit;
    seRadio: TSpinEdit;
    seVideo: TSpinEdit;
    seInternet: TSpinEdit;
    seConjuge: TSpinEdit;
    btnTeste: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel1: TBevel;
    Label14: TLabel;
    Label15: TLabel;
    KMeans: TKMeans;
    seFD1: TSpinEdit;
    seFD2: TSpinEdit;
    seFD3: TSpinEdit;
    st1: TStaticText;
    st2: TStaticText;
    st3: TStaticText;
    Label12: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label17: TLabel;
    Label21: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTesteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tblSegmentBeforeOpen(DataSet: TDataSet);
  private
  public
    Valor: array[0..MAXDIM - 1] of double;
    Distancia: array[0..CLUSTERS - 1] of double;
  end;

var
  Teste: TTeste;

implementation

uses
  USegment;

{$R *.DFM}

procedure TTeste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblSegment.Close;
  Action := caFree;
  Teste := nil;
end;

procedure TTeste.btnTesteClick(Sender: TObject);
var
  //i, IMaior: integer;
  k {, Maior}: double;
begin
  { Nova amostra sendo normalizada e testada }
  with FSegment do
  begin
    Valor[0] := (seRenda.Value - Minimo[0]) / (Maximo[0] - Minimo[0]);
    Valor[1] := (seIdade.Value - Minimo[1]) / (Maximo[1] - Minimo[1]);
    Valor[2] := (seSexo.Value - Minimo[2]) / (Maximo[2] - Minimo[2]);
    Valor[3] := (seTV.Value - Minimo[3]) / (Maximo[3] - Minimo[3]);
    Valor[4] := (seRadio.Value - Minimo[4]) / (Maximo[4] - Minimo[4]);
    Valor[5] := (seVideo.Value - Minimo[5]) / (Maximo[5] - Minimo[5]);
    Valor[6] := (seInternet.Value - Minimo[6]) / (Maximo[6] - Minimo[6]);
    Valor[7] := (seConjuge.Value - Minimo[7]) / (Maximo[7] - Minimo[7]);
    Valor[8] := (seFD1.Value - Minimo[8]) / (Maximo[8] - Minimo[8]);
    Valor[9] := (seFD2.Value - Minimo[9]) / (Maximo[9] - Minimo[9]);
    Valor[10] := (seFD3.Value - Minimo[10]) / (Maximo[10] - Minimo[10]);
  end;

  { Insere e verifica a qual cluster pertence }
  k := KMeans.FindCluster(Valor);

  { Mostra visualmente a classe }
  if k = 0 then
    st1.Color := clRed
  else
    st1.Color := clBlue;

  if k = 1 then
    st2.Color := clRed
  else
    st2.Color := clBlue;

  if k = 2 then
    st3.Color := clRed
  else
    st3.Color := clBlue;

  KMeans.FindDistance(Valor, Distancia);

  { Mostra as distâncias em relação aos clusters }
  Label12.Caption := Format('%2.4f', [Distancia[0]]);
  Label13.Caption := Format('%2.4f', [Distancia[1]]);
  Label16.Caption := Format('%2.4f', [Distancia[2]]);

  if k = 0 then
  begin
    Label18.Caption := '';
    Label19.Caption := Format('%2.2f', [Abs(Distancia[0] - Distancia[1]) / Distancia[1]]);
    Label20.Caption := Format('%2.2f', [Abs(Distancia[0] - Distancia[2]) / Distancia[2]]);
  end;

  if k = 1 then
  begin
    Label18.Caption := Format('%2.2f', [Abs(Distancia[1] - Distancia[0]) / Distancia[0]]);
    Label19.Caption := '';
    Label20.Caption := Format('%2.2f', [Abs(Distancia[1] - Distancia[2]) / Distancia[2]]);
  end;

  if k = 2 then
  begin
    Label18.Caption := Format('%2.2f', [Abs(Distancia[2] - Distancia[0]) / Distancia[0]]);
    Label19.Caption := Format('%2.2f', [Abs(Distancia[2] - DIstancia[1]) / Distancia[1]]);
    Label20.Caption := '';
  end;
end;

procedure TTeste.FormCreate(Sender: TObject);
begin
  tblSegment.Open;

  { Assimila parâmetros iniciais }
  KMeans.ItemsNum := MAXITEM;
  KMeans.ClusterNum := CLUSTERS;
  KMeans.Dimension := MAXDIM;
  KMeans.Knowledge := FSegment.Conhecimento;

  { Inicializa a estrutura }
  KMeans.Initialize;

  { Carrega atributos dos clusters previamente salvos }
  KMeans.Load;

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

    // Faixa de dependentes de 16 anos acima
    Minimo[10] := 0;
    Maximo[10] := 5;

    { Associação às propriedades dos objetos SpinEdit }
    seRenda.MinValue := Round(Minimo[0]);
    seRenda.MaxValue := Round(Maximo[0]);

    seIdade.MinValue := Round(Minimo[1]);
    seIdade.MaxValue := Round(Maximo[1]);

    seSexo.MinValue := Round(Minimo[2]);
    seSexo.MaxValue := Round(Maximo[2]);

    seTV.MinValue := Round(Minimo[3]);
    seTV.MaxValue := Round(Maximo[3]);

    seRadio.MinValue := Round(Minimo[4]);
    seRadio.MaxValue := Round(Maximo[4]);

    seVideo.MinValue := Round(Minimo[5]);
    seVideo.MaxValue := Round(Maximo[5]);

    seInternet.MinValue := Round(Minimo[6]);
    seInternet.MaxValue := Round(Maximo[6]);

    seConjuge.MinValue := Round(Minimo[7]);
    seConjuge.MaxValue := Round(Maximo[7]);

    seFD1.MinValue := Round(Minimo[8]);
    seFD1.MaxValue := Round(Maximo[8]);

    seFD2.MinValue := Round(Minimo[9]);
    seFD2.MaxValue := Round(Maximo[9]);

    seFD3.MinValue := Round(Minimo[10]);
    seFD3.MaxValue := Round(Maximo[10]);

    seRenda.Value := Round((Minimo[0] + Maximo[0]) / 2);
    seIdade.Value := Round((Minimo[1] + Maximo[1]) / 2);
    seSexo.Value := Round((Minimo[2] + Maximo[2]) / 2);
    seTV.Value := Round((Minimo[3] + Maximo[3]) / 2);
    seRadio.Value := Round((Minimo[4] + Maximo[4]) / 2);
    seVideo.Value := Round((Minimo[5] + Maximo[5]) / 2);
    seInternet.Value := Round((Minimo[6] + Maximo[6]) / 2);
    seConjuge.Value := Round((Minimo[7] + Maximo[7]) / 2);
    seFD1.Value := Round((Minimo[8] + Maximo[8]) / 2);
    seFD2.Value := Round((Minimo[9] + Maximo[9]) / 2);
    seFD3.Value := Round((Minimo[10] + Maximo[10]) / 2);
  end;
end;

procedure TTeste.tblSegmentBeforeOpen(DataSet: TDataSet);
begin
  tblSegment.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.

