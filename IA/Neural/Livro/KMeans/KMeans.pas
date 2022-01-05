{===============================================================================
  Unit.................KMeans.pas
  Description..........TKMeans component for using classical Clustering Algorithm
  Accessed Units.......Classes, SysUtils, Dialogs, Windows, Variants
  Compiler.............Delphi 3,4,5,6,7
  References...........Haykin, Simon. Neural Networks-A Comprehensive Foundation.
                       1994.
  Author...............Luciano F. de Medeiros, lfm@netpar.com.br
  Conditions of usage..Freeware and Open Source, use at own risk. Please report
                       faults or comments to the author, and any modifications
                       in the original source
================================================================================}
unit KMeans;

interface

uses Classes, Dialogs, Windows, SysUtils, Variants;

type
  // pega valor pelo nº do item na dimensão especificada
  TGetDataEvent = function(Sender: TObject; i, j: longint): double of object;
  // pega cluster relacionado ao nº do item
  TGetClusterEvent = function(Sender: TObject; i: longint): word of object;

  TKMeans = class(TComponent)
  private
    FAlpha: double;
    FClusterNum: word;
    FDimension: word;
    FItemsNum: longint;
    FKnowledge: string;
    FOnGetData: TGetDataEvent;
    FOnGetCluster: TGetClusterEvent;
    FClusters: array[0..100, 0..100] of double;
    procedure SetAlpha(Value: double);
    procedure SetClusterNum(Value: word);
    procedure SetDimension(Value: word);
    procedure SetItemsNum(Value: longint);
    procedure SetKnowledge(Value: string);
    function GetClusters(i, j: longint): double;
    procedure SetClusters(i, j: longint; Value: double);
  protected
    Summer: array[0..100, 0..100] of double;
    Teste: array of double;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Step;
    procedure Initialize;
    function Cost: double;
    procedure Save;
    procedure Load;
    function FindCluster(var V: array of double): word;
    procedure FindDistance(var V, D: array of double);
    property Clusters[i, j: longint]: double read GetClusters write SetClusters;
  published
    property Alpha: double read FAlpha write SetAlpha;
    property ClusterNum: word read FClusterNum write SetClusterNum;
    property Dimension: word read FDimension write SetDimension;
    property ItemsNum: longint read FItemsNum write SetItemsNum;
    property Knowledge: string read FKnowledge write SetKnowledge;
    property OnGetData: TGetDataEvent read FOnGetData write FOnGetData;
    property OnGetCluster: TGetClusterEvent read FOnGetCluster write FOnGetCluster;
  end;

procedure Register;

implementation

function TKMeans.GetClusters(i, j: longint): double;
begin
  Result := FClusters[i, j];
end;

procedure TKMeans.SetClusters(i, j: longint; Value: double);
begin
  FClusters[i, j] := Value;
end;

procedure TKMeans.SetAlpha(Value: double);
begin
  FAlpha := Value;

  if FAlpha < 0 then FAlpha := 0;

  if FAlpha > 1 then FAlpha := 1;
end;

procedure TKMeans.SetClusterNum(Value: word);
begin
  FClusterNum := Value;

  if FClusterNum < 1 then FClusterNum := 1;
end;

procedure TKMeans.SetDimension(Value: word);
begin
  FDimension := Value;

  if FDimension < 1 then FDimension := 1;
end;

procedure TKMeans.SetKnowledge(Value: string);
begin
  FKnowledge := Value;
end;

procedure TKMeans.SetItemsNum(Value: longint);
begin
  FItemsNum := Value;
end;

procedure TKMeans.Initialize;
var
  m, j: longint;
begin
  Teste := VarArrayCreate([0, FDimension - 1], varDouble);

  for m := 0 to FClusterNum - 1 do
    for j := 0 to FDimension - 1 do
    begin
      Clusters[m, j] := 0;
      Summer[m, j] := 0;
    end;
end;

procedure TKMeans.Step;
var
  i, j: longint;
  m: word;
  Valor: double;
begin
  // Zera acumuladores
  for m := 0 to FClusterNum - 1 do
    for j := 0 to FDimension - 1 do
      Summer[m, j] := 0;

  // Calcula diferenças para o centro
  for i := 0 to FItemsNum - 1 do
  begin
    m := FOnGetCluster(Self, i); // pega o cluster a que pertence o item

    for j := 0 to FDimension - 1 do
    begin
      Valor := FOnGetData(Self, i, j); // pega o valor do item na dimensão
      Summer[m, j] := Summer[m, j] + (Valor - Clusters[m, j]);
    end;
  end;

  // Calcula os deltas para atualização e atualiza clusters
  for m := 0 to FClusterNum - 1 do
    for j := 0 to FDimension - 1 do
      Clusters[m, j] := Clusters[m, j] + FAlpha * Summer[m, j] / (FItemsNum div FClusterNum);
end;

function TKmeans.FindCluster(var V: array of double): word;
var
  S, VMinimo: double;
  m, j, CMinimo: word;
begin
  VMinimo := 1E9;
  CMinimo := 0;

  for m := 0 to FClusterNum - 1 do
  begin
    S := 0;

    for j := 0 to FDimension - 1 do
      S := S + (V[j] - Clusters[m, j]) * (V[j] - Clusters[m, j]);

    if VMinimo > S then
    begin
      VMinimo := S;
      CMinimo := m;
    end;
  end;

  Result := CMinimo;
end;

procedure TKMeans.FindDistance(var V, D: array of double);
var
  m, j: word;
begin
  for m := 0 to FClusterNum - 1 do
  begin
    D[m] := 0;

    for j := 0 to FDimension - 1 do
      D[m] := D[m] + (V[j] - Clusters[m, j]) * (V[j] - Clusters[m, j]);

    D[m] := Sqrt(D[m]);
  end;
end;

function TKMeans.Cost: double;
var
  i, j: integer;
  m, n: word;
  //Valor,
  Erro: double;
begin
  Erro := 0;

  for i := 0 to FItemsNum - 1 do
  begin
    { Pega o cluster a que pertence o item }
    m := FOnGetCluster(Self, i);

    for j := 0 to FDimension - 1 do
      Teste[j] := FOnGetData(Self, i, j); // pega o valor do item na dimensão

    { Testa os valores deste item e obtém o cluster }
    n := FindCluster(Teste);

    Erro := Erro + (n - m) * (n - m);
  end;

  Result := 0.5 * Sqrt(Erro) / FItemsNum;
end;

procedure TKMeans.Save;
var
  j: integer;
  m: word;
  F: TextFile;
begin
  AssignFile(F, FKnowledge);
  Rewrite(F);

  { Armazena número de clusters e dimensões }
  WriteLn(F, Format('%d', [FDimension]));
  WriteLn(F, Format('%d', [FClusterNum]));

  { Armazena valores dos clusters }
  for m := 0 to FClusterNum - 1 do
    for j := 0 to FDimension - 1 do
      WriteLn(F, Format('%4.12f', [Clusters[m, j]]));

  CloseFile(F);
end;

procedure TKMeans.Load;
var
  j: integer;
  m: word;
  Temp: string;
  F: TextFile;
begin
  AssignFile(F, FKnowledge);

  if FileExists(FKnowledge) then
  begin
    Reset(F);

    { Lê parâmetros iniciais }
    ReadLn(F, Temp);
    FDimension := StrToIntDef(Temp, 0);
    ReadLn(F, Temp);
    FClusterNum := StrToIntDef(Temp, 0);

    { Lê valores dos clusters }
    for m := 0 to FClusterNum - 1 do
      for j := 0 to FDimension - 1 do
      begin
        ReadLn(F, Temp);
        Clusters[m, j] := StrToFloat(Temp);
      end;

    CloseFile(F);
  end;
end;

constructor TKMeans.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  SetAlpha(0.3);
  SetItemsNum(300);
  SetDimension(2);
  SetClusterNum(3);
  SetKnowledge('');
end;

destructor TKMeans.Destroy;
begin
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Lfm', [TKMeans]);
end;

end.

