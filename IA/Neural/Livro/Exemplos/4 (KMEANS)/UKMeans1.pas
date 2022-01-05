unit UKMeans1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, KMeans, ComCtrls;

const
  MAXDIM = 2;
  MAXITEM = 300;
  CLUSTERS = 3;

type
  TClustering = class(TForm)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    KMeans: TKMeans;
    Panel3: TPanel;
    btnStep: TBitBtn;
    btnReset: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Bevel1: TBevel;
    StatusBar1: TStatusBar;
    procedure FormActivate(Sender: TObject);
    procedure ClearPaint;
    procedure PaintBox1Paint(Sender: TObject);
    procedure btnStepClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    function KMeansGetData(Sender: TObject; i, j: longint): double;
    function KMeansGetCluster(Sender: TObject; i: longint): word;
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    x: array[0..MAXITEM - 1, 0..MAXDIM - 1] of double;
    u: array[0..CLUSTERS - 1, 0..MAXDIM - 1] of double;
    Step: Integer;
  end;

var
  Clustering: TClustering;

implementation

{$R *.DFM}

procedure TClustering.FormActivate(Sender: TObject);
begin
  { Força o botão Reset para gerar subconjuntos }
  btnResetClick(Sender);
  { Assimila parâmetros iniciais }
  KMeans.ItemsNum := MAXITEM;
  KMeans.ClusterNum := CLUSTERS;
  KMeans.Dimension := MAXDIM;
end;

procedure TClustering.ClearPaint;
var
  NewRect: TRect;
begin
  NewRect := Rect(0, 0, PaintBox1.Height, PaintBox1.Width);
  PaintBox1.Canvas.Brush.Color := clWhite;
  PaintBox1.Canvas.FillRect(NewRect);
end;

procedure TClustering.PaintBox1Paint(Sender: TObject);
var
  k, m, xx, yy: word;
begin
  { Para todos os ítens na matriz x }
  for k := 0 to MAXITEM - 1 do
  begin
    xx := Round(x[k, 0] * (PaintBox1.Width + 1));
    yy := Round(x[k, 1] * (PaintBox1.Height + 1));

    { Verifica a qual classe pertence }
    m := k div (MAXITEM div CLUSTERS);

    if m = 0 then
    begin
      { Classe 0 - Quadrado }
      PaintBox1.Canvas.Pen.Color := clNavy;
      PaintBox1.Canvas.Rectangle(xx - 3, yy - 3, xx + 3, yy + 3);
    end;

    if m = 1 then
    begin
      { Classe 1 - Cruz }
      PaintBox1.Canvas.Pen.Color := clGreen;
      PaintBox1.Canvas.MoveTo(xx, yy - 4);
      PaintBox1.Canvas.LineTo(xx, yy + 5);
      PaintBox1.Canvas.MoveTo(xx - 4, yy);
      PaintBox1.Canvas.LineTo(xx + 5, yy);
    end;

    if m = 2 then
    begin
      { Classe 2 - Círculo }
      PaintBox1.Canvas.Pen.Color := clRed;
      PaintBox1.Canvas.Ellipse(xx - 3, yy - 3, xx + 3, yy + 3);
    end;
  end;

  { Traçado dos clusters }
  PaintBox1.Canvas.Pen.Color := clBlack;

  for m := 0 to CLUSTERS - 1 do
  begin
    { Lê a posição atual de cada um dos clusters }
    xx := Round(KMeans.Clusters[m, 0] * (PaintBox1.Width + 1));
    yy := Round(KMeans.Clusters[m, 1] * (PaintBox1.Height + 1));

    { Traça um círculo conforme a cor }
    if m = 0 then
      PaintBox1.Canvas.Brush.Color := clBlue
    else if m = 1 then
      PaintBox1.Canvas.Brush.Color := clLime
    else
      PaintBox1.Canvas.Brush.Color := clRed;

    PaintBox1.Canvas.Ellipse(xx - 6, yy - 6, xx + 6, yy + 6);
  end;
end;

function TClustering.KMeansGetData(Sender: TObject; i, j: longint): double;
begin
  { Os dados são fornecidos pela matriz x }
  Result := x[i, j];
end;

function TClustering.KMeansGetCluster(Sender: TObject; i: longint): word;
var
  m: word;
begin
  { Adquire a classe do cluster para rodar o algoritmo internamente }
  m := i div (MAXITEM div CLUSTERS);
  Result := m;
end;

procedure TClustering.btnStepClick(Sender: TObject);
begin
  { Executa um passo do algoritmo }
  KMeans.Step;
  PaintBox1.Refresh;
end;

procedure TClustering.btnResetClick(Sender: TObject);
var
  i, j: integer;
begin
  { Inicializa o objeto }
  KMeans.Initialize;

  { O número de passos dado pela divisão do total de ítens pelo nº de classes }
  Step := MAXITEM div CLUSTERS;
  Randomize;

  { Classe 0 }
  for i := 0 to Step - 1 do
    for j := 0 to MAXDIM - 1 do
      x[i, j] := Random / 2 + 0.1;

  { Classe 1 }
  for i := Step to 2 * Step - 1 do
  begin
    x[i, 0] := Random / 2 + 0.4;
    x[i, 1] := Random / 3 + 0.5;
  end;

  { Classe 2 }
  for i := 2 * Step to 3 * Step - 1 do
  begin
    x[i, 0] := Random / 3 + 0.6;
    x[i, 1] := Random / 2 + 0.1;
  end;

  { Posição inicial dos clusters }
  for j := 0 to MAXDIM - 1 do
  begin
    KMeans.Clusters[0, j] := 0.5;
    KMeans.Clusters[1, j] := 0.5;
    KMeans.Clusters[2, j] := 0.5;
  end;

  PaintBox1.Invalidate;
end;

procedure TClustering.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  m: word;
  Valor: array[0..MAXDIM - 1] of double;
  NewRect: TRect;
begin
  { Nova amostra sendo inserida }
  Valor[1] := Y / (PaintBox1.Height);
  Valor[0] := X / (PaintBox1.Width);

  { Traça como quadrado amarelo }
  PaintBox1.Canvas.Pen.Color := clYellow;
  PaintBox1.Canvas.Rectangle(X - 2, Y - 2, X + 2, Y + 2);
  PaintBox1.Canvas.Brush.Color := clYellow;
  NewRect := Rect(X - 2, Y - 2, X + 2, Y + 2);
  PaintBox1.Canvas.FillRect(NewRect);

  { Verifica qual a classe a que pertence }
  m := KMeans.FindCluster(Valor);
  Edit1.Text := IntToStr(m);
end;

procedure TClustering.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  Clustering := nil;
end;

end.

