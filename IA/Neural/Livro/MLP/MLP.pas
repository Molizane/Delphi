{===============================================================================
  Unit.................MLP.pas
  Description..........TMLP component for using classical Multilayer Perceptron
  Accessed Units.......Classes, SysUtils, Dialogs
  Compiler.............Delphi 3,4,5,6,7
  References...........Haykin, Simon. Neural Networks-A Comprehensive Foundation.
                       1994.
  Author...............Luciano F. de Medeiros, lfm@netpar.com.br
  Conditions of usage..Freeware and Open Source, use at own risk. Please report
                       faults or comments to the author, and any modifications
                       in the original source
================================================================================}
unit MLP;

interface

uses
  Classes, SysUtils, Dialogs;

type
  TLayerType = (ltInput, ltHidden, ltOutput);

  PLayer = ^TLayer;
  PNeuron = ^TNeuron;
  PSynapsis = ^TSynapsis;

  TLayer = record
    Number: integer; // identifica��o da camada
    LayerType: TLayerType; // tipo de camada
    LayerNext: PLayer; // aponta para pr�xima camada
    LayerPrior: pointer; // aponta para camada anterior
    NeuronFirst: pointer; // aponta para o primeiro TNeuron da camada
    SynapsisFirst: pointer; // aponta para a primeira TSynapsis da camada
    NeuronCount: integer; // quantidade de neur�nios da camada
  end;

  TNeuron = record
    Number: integer; // identifica��o do neur�nio
    Value: double; // valor assumido pelo neur�nio
    Delta: double; // valor para gradiente descendente
    Target: double; // valor de alvo utilizado somente para �ltima camada
    NeuronNext: pointer; // ponteiro para proximo TNeuron da mesma camada
    MaxValue: double; // valor m�ximo assumido pelo neur�nio
    MinValue: double; // valor m�nimo assumido pelo neur�nio
  end;

  TSynapsis = record
    Number: longint; // identifica��o da sinapse
    Value: double; // valor assumido pela sinapse
    Delta: double; // refere-se ao delta de corre��o dos pesos sin�pticos
    NeuronPrior, NeuronNext: PNeuron; // ponteiros ligando os neur�nios
    SynapsisNext: PSynapsis; // ponteiro para pr�xima TSynapsis
  end;

  TMLP = class(TComponent)
  private
    FStruct: TStrings; // acessa a estrutura de uma lista
    FEpochs: longint; // n�mero de �pocas para o treinamento
    FMomentum: double; // coeficiente de momentum
    FLearning: double; // coeficiente de aprendizado
    FKnowledge: string; // nome do arquivo de pesos
    procedure SetStruct(Value: TStrings);
    procedure SetEpochs(Value: longint);
    procedure SetMomentum(Value: double);
    procedure SetLearning(Value: double);
    procedure SetKnowledge(Value: string);
  protected
    FGamma: double;
    Lista: string;
    Prepared: boolean;
    function GetLayer: PLayer;
    procedure FreeLayer(var Node: PLayer);
    function GetNeuron: PNeuron;
    procedure FreeNeuron(var Node: PNeuron);
    function GetSynapsis: PSynapsis;
    procedure FreeSynapsis(var Node: PSynapsis);
    procedure FeedForward; // avan�a na rede calculando as sa�das
    function Activation(Value: double): double; // fun��o sigm�ide
    procedure BackPropagation; // calcula deltas ap�s feedforward
    procedure CorrectWeight; // corrige pesos ap�s backpropagation
    procedure CorrectWeightPruning;
    function Eliminate: longint; // para ver a quantidade de pesos zerados
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Build; // constr�i a rede (� preciso rodar sempre)
    procedure Training; // executa uma �poca de treinamento da rede
    function TrainingPruning(Epochs: longint): longint;
    procedure SetInput(Neuron: integer; Value: double); // marca entradas na primeira camada
    procedure SetInputMax(Neuron: integer; Value: double); // marca valor m�ximo na primeira camada
    procedure SetInputMin(Neuron: integer; Value: double); // marca valor m�nimo na primeira camada
    procedure SetOutput(Neuron: integer; Value: double); // marca neur�nios na saida
    procedure SetOutputMax(Neuron: integer; Value: double); // valor m�ximo nas sa�das
    procedure SetOutputMin(Neuron: integer; Value: double); // valor m�nimo nas sa�das
    function GetOutput(Neuron: integer): double; // pega valores de sa�da
    procedure Test; // Valores para teste de valores de entrada
    procedure Clear; // zera os valores das sinapses
    procedure Save; // salva sinapses em arquivo
    procedure Load; // carrega sinapses em arquivo, com rede j� constru�da com BUILD
    function Cost: double; // retorna a fun��o custo, ou seja, o erro atual
    function List: string; // m�todo provis�rio, s� para controle
    procedure Purge; // elimina os pesos zerados
  published
    property Struct: TStrings read FStruct write SetStruct; // estrutura da rede
    property Momentum: double read FMomentum write SetMomentum;
    property Learning: double read FLearning write SetLearning;
    property Knowledge: string read FKnowledge write SetKnowledge;
  end;

var
  Layer, LastLayer: PLayer; // primeira e �ltima camada

procedure Register;

implementation

procedure TMLP.Build;
var
  P, Q: PLayer;
  R, S: PNeuron;
  T, U: PSynapsis;
  i, j: integer;
  k: longint;
  First: boolean;
begin
  if not Prepared then
  begin
    // Cria primeira camada
    Layer := GetLayer; // ponteiro para camada inicial
    Layer.Number := 1;
    Layer.LayerType := ltInput;
    Layer.LayerPrior := nil;

    // Cria neur�nios da primeira camada
    R := GetNeuron;
    R.Number := 1;
    R.Value := 0;
    Layer.NeuronFirst := R;
    Layer.NeuronCount := StrToInt(FStruct[0]);

    for i := 1 to StrToInt(FStruct[0]) - 1 do
    begin
      S := GetNeuron;
      R.NeuronNext := S;
      S.Number := i + 1;
      R := S;
    end;

    R.NeuronNext := nil;

    // Cria pr�ximas camadas
    P := Layer;

    for i := 1 to FStruct.Count - 1 do
    begin
      Q := GetLayer;
      P.LayerNext := Q;
      Q.LayerPrior := P;
      Q.Number := i + 1;
      Q.NeuronCount := StrToInt(FStruct[i]);

      if (i = FStruct.Count - 1) then
        Q.LayerType := ltOutput
      else
        Q.LayerType := ltHidden;

      Q.LayerNext := nil;
      P := Q;

      // Cria neur�nios das camadas
      R := GetNeuron;
      R.Number := 1;
      R.Value := 0;
      R.Delta := 1;
      P.NeuronFirst := R;

      for j := 1 to StrToInt(FStruct[i]) - 1 do
      begin
        S := GetNeuron;
        R.NeuronNext := S;
        S.Number := j + 1;
        S.Value := 0;
        S.Delta := 1;
        R := S;
      end;

      R.NeuronNext := nil;
    end;

    LastLayer := Q; // guarda ponteiro para a �ltima camada

    // Cria sinapses entre neur�nios. A partir daqui n�o � preciso mais a quantidade
    // de cada neur�nio.
    Randomize;
    P := Layer;
    Q := Layer.LayerNext;
    k := 1;

    while Q <> nil do
    begin
      R := P.NeuronFirst;
      S := Q.NeuronFirst;
      First := true;

      while R <> nil do
      begin
        while S <> nil do
        begin
          T := GetSynapsis;

          if not First then
            U.SynapsisNext := T // monta a cadeia com os seguintes
          else
            P.SynapsisFirst := T; // liga a primeira sinapse � camada

          First := false;
          T.Number := k;
          T.Value := Random(1000) / 1000 - 0.5; // come�a com valores aleat�rios
          T.Delta := 0; // come�a com deltas iguais a zero
          T.NeuronPrior := R;
          T.NeuronNext := S;
          U := T;
          S := S.NeuronNext;
          Inc(k);
        end;

        R := R.NeuronNext;
        S := Q.NeuronFirst;
      end;

      P := Q; // Assume P como pr�xima camada e Q como a seguinte
      Q := Q.LayerNext;
      T.SynapsisNext := nil;
    end;

    T.SynapsisNext := nil;
    Prepared := True;
  end
  else
    ShowMessage('Rede n�o constru�da');
end;

procedure TMLP.FeedForward;
var
  P, Q: PLayer;
  R: PNeuron;
  T: PSynapsis;
begin
  P := Layer;
  Q := P.LayerNext;
  R := P.NeuronFirst;

  while Q <> nil do
  begin
    // Primeira sinapse da camada
    T := P.SynapsisFirst;

    // Acumula valores de w * x na pr�xima camada
    while T <> nil do
    begin
      T.NeuronNext.Value := T.NeuronNext.Value + T.NeuronPrior.Value * T.Value; // acumula v = w * x;
      T := T.SynapsisNext;
    end;

    // Normaliza valores de v, calculando a ativa��o
    R := Q.NeuronFirst;

    while R <> nil do
    begin
      R.Value := Activation(R.Value / P.NeuronCount);
      R := R.NeuronNext;
    end;

    // Pr�xima camada
    P := Q;
    Q := Q.LayerNext;
  end;
end;

procedure TMLP.BackPropagation;
var
  //P,
  Q: PLayer;
  R: PNeuron;
  T: PSynapsis;
begin
  Q := LastLayer;
  R := Q.NeuronFirst;

  // Calcula deltas para camada de sa�da
  while R <> nil do
  begin
    R.Delta := R.Value * (1 - R.Value) * (R.Target - R.Value);
    R := R.NeuronNext;
  end;

  // Calcula deltas para camadas internas
  Q := Q.LayerPrior;

  while Q.LayerPrior <> nil do
  begin
    T := Q.SynapsisFirst;

    while T <> nil do
    begin
      T.NeuronPrior.Delta := T.NeuronPrior.Delta + T.Value * T.NeuronNext.Delta;
      T := T.SynapsisNext;
    end;

    Q := Q.LayerPrior;
  end;

  // Normaliza deltas para camadas ocultas, a de sa�da n�o � preciso
  Q := LastLayer.LayerPrior;

  while Q.LayerPrior <> nil do
  begin
    R := Q.NeuronFirst;

    while R <> nil do
    begin
      R.Delta := R.Value * (1 - R.Value) * R.Delta / Q.LayerNext.NeuronCount;
      R := R.NeuronNext;
    end;

    Q := Q.LayerPrior;
  end;
end;

procedure TMLP.CorrectWeight;
var
  P: PLayer;
  T: PSynapsis;
begin
  P := Layer;

  // Corrige os pesos de cada camada
  while P.LayerNext <> nil do
  begin
    T := P.SynapsisFirst;

    while T <> nil do
    begin
      T.Delta := (FMomentum * T.Delta) - (FLearning * T.NeuronNext.Delta * T.NeuronPrior.Value);
      T.Value := T.Value - T.Delta; // atualiza as sinapses
      T := T.SynapsisNext;
    end;

    P := P.LayerNext;
  end;
end;

procedure TMLP.CorrectWeightPruning;
var
  P: PLayer;
  T: PSynapsis;
  Square: double;
begin
  P := Layer;

  // Corrige os pesos de cada camada
  while P.LayerNext <> nil do
  begin
    T := P.SynapsisFirst;

    while T <> nil do
    begin
      Square := T.Value * T.Value;
      T.Value := T.Value * (1 - (FGamma / ((1 + Square) * (1 + Square))));
      T.Delta := (0.9 * T.Delta) - (T.NeuronNext.Delta * T.NeuronPrior.Value);
      T.Value := T.Value - T.Delta; // atualiza as sinapses
      T := T.SynapsisNext;
    end;

    P := P.LayerNext;
  end;
end;

procedure TMLP.Test;
begin
  FeedForward; // faz somente a passagem dos valores de entrada pelos pesos sin�pticos
end;

procedure TMLP.Clear;
var
  P: PLayer;
  T: PSynapsis;
begin
  P := Layer;

  while P.LayerNext <> nil do
  begin
    T := P.SynapsisFirst;

    while T <> nil do
    begin
      T.Value := Random(1000) / 1000 - 0.5;
      T.Delta := 0;
      T := T.SynapsisNext;
    end;

    P := P.LayerNext;
  end;
end;

function TMLP.Activation(Value: double): double;
begin
  Result := 1 / (1 + exp(-Value));
end;

function TMLP.List: string;
var
  P: PLayer;
  R: PNeuron;
  T: PSynapsis;
begin
  Lista := '';
  P := Layer; // pega o apontador do perceptron - 1� camada

  while P <> nil do
  begin
    Lista := Lista + 'C: ' + IntToStr(P.Number);
    R := P.NeuronFirst;

    while R <> nil do
    begin
      Lista := Lista + ' N: ' + IntToStr(R.Number);
      R := R.NeuronNext;
    end;

    P := P.LayerNext;
  end;

  Lista := Lista + ' ##### ';
  P := Layer; // pega o apontador do perceptron - 1� camada

  while P.LayerNext <> nil do
  begin
    Lista := Lista + 'C: ' + IntToStr(P.Number);
    T := P.SynapsisFirst;

    while T <> nil do
    begin
      Lista := Lista + ' S: ' + IntToStr(T.Number) + '/' + IntToStr(T.NeuronPrior.Number) + '-' + IntToStr(T.NeuronNext.Number);
      T := T.SynapsisNext;
    end;

    P := P.LayerNext;
  end;

  Result := Lista;
end;

function TMLP.Eliminate: longint;
var
  Zeros: longint;
  P: PLayer;
  T: PSynapsis;
begin
  Zeros := 0;
  P := Layer; // pega o apontador do perceptron - 1� camada

  while P.LayerNext <> nil do
  begin
    T := P.SynapsisFirst;

    while T <> nil do
    begin
      if Trunc(T.Value * 100) = 0 then Inc(Zeros);

      T := T.SynapsisNext;
    end;

    P := P.LayerNext;
  end;

  Result := Zeros;
end;

procedure TMLP.Training;
begin
  // Presume que os valores de entrada j� estejam colocados, junto com os alvos
  // Executa o processo somente uma vez
  FeedForward;
  BackPropagation;
  CorrectWeight;
end;

function TMLP.TrainingPruning(Epochs: longint): longint;
begin
  // Presume que os valores de entrada j� estejam colocados, junto com os alvos
  // Executa o processo somente uma vez
  FeedForward;
  BackPropagation;
  FGamma := FGamma + (0.1 / Epochs);
  CorrectWeightPruning;
  Result := Eliminate; // conta quantas sinapses foram zeradas pelo processo
end;

function TMLP.Cost: double;
var
  Error: double;
  P: PLayer;
  R: PNeuron;
begin
  P := LastLayer;
  R := P.NeuronFirst;
  Error := 0;

  while R <> nil do
  begin
    Error := Error + (R.Target - R.Value) * (R.Target - R.Value);
    R := R.NeuronNext;
  end;

  Result := 0.5 * Error;
end;

procedure TMLP.SetInput(Neuron: integer; Value: double);
var
  P: PLayer;
  R: PNeuron;
begin
  P := Layer;
  R := P.NeuronFirst;

  while R <> nil do
  begin
    if R.Number = Neuron then
    begin
      // entrada j� transformada
      R.Value := 1 + 2 * (Value - R.MaxValue) / (R.MaxValue - R.MinValue);
      break;
    end;

    R := R.NeuronNext;
  end;
end;

procedure TMLP.SetInputMax(Neuron: integer; Value: double);
var
  P: PLayer;
  R: PNeuron;
begin
  P := Layer;
  R := P.NeuronFirst;

  while R <> nil do
  begin
    if R.Number = Neuron then
    begin
      R.MaxValue := Value;
      break;
    end;

    R := R.NeuronNext;
  end;
end;

procedure TMLP.SetInputMin(Neuron: integer; Value: double);
var
  P: PLayer;
  R: PNeuron;
begin
  P := Layer;
  R := P.NeuronFirst;

  while R <> nil do
  begin
    if R.Number = Neuron then
    begin
      R.MinValue := Value;
      break;
    end;

    R := R.NeuronNext;
  end;
end;

procedure TMLP.SetOutput(Neuron: integer; Value: double);
var
  P: PLayer;
  R: PNeuron;
begin
  P := LastLayer;
  R := P.NeuronFirst;

  while R <> nil do
  begin
    if R.Number = Neuron then
    begin
      // sa�da j� transformada
//R.Target := 1 + 2 * (Value - R.MaxValue) / (R.MaxValue - R.MinValue); // [-1,1]
      R.Target := 1 + (Value - R.MaxValue) / (R.MaxValue - R.MinValue); // [0,1]
      //         R.Target := Value;
      break;
    end;

    R := R.NeuronNext;
  end;
end;

procedure TMLP.SetOutputMax(Neuron: integer; Value: double);
var
  P: PLayer;
  R: PNeuron;
begin
  P := LastLayer;
  R := P.NeuronFirst;

  while R <> nil do
  begin
    if R.Number = Neuron then
    begin
      R.MaxValue := Value;
      break;
    end;

    R := R.NeuronNext;
  end;
end;

procedure TMLP.SetOutputMin(Neuron: integer; Value: double);
var
  P: PLayer;
  R: PNeuron;
begin
  P := LastLayer;
  R := P.NeuronFirst;

  while R <> nil do
  begin
    if R.Number = Neuron then
    begin
      R.MinValue := Value;
      break;
    end;

    R := R.NeuronNext;
  end;
end;

function TMLP.GetOutput(Neuron: integer): double;
var
  P: PLayer;
  R: PNeuron;
begin
  P := LastLayer;
  R := P.NeuronFirst;
  Result := 0;

  while R <> nil do
  begin
    if R.Number = Neuron then
    begin
      //Result := R.Value;
      //Result := 0.5 * (R.Value - 1) * (R.MaxValue - R.MinValue) + R.MaxValue; // [-1,1]
      Result := (R.Value - 1) * (R.MaxValue - R.MinValue) + R.MaxValue; // [0,1]
      break;
    end;

    R := R.NeuronNext;
  end;
end;

procedure TMLP.Save;
var
  F: TextFile;
  P: PLayer;
  T: PSynapsis;
begin
  AssignFile(F, FKnowledge);
  Rewrite(F);
  P := Layer;

  while P.LayerNext <> nil do
  begin
    T := P.SynapsisFirst;

    while T <> nil do
    begin
      WriteLn(F, Format('%d', [T.Number]));
      WriteLn(F, Format('%d', [T.NeuronPrior.Number]));
      WriteLn(F, Format('%d', [T.NeuronNext.Number]));
      WriteLn(F, Format('%d', [P.Number]));
      WriteLn(F, Format('%4.12f', [T.Value]));
      T := T.SynapsisNext;
    end;

    P := P.LayerNext;
  end;

  CloseFile(F);
end;

procedure TMLP.Load;
var
  F: TextFile;
  P, Q: PLayer;
  R, S: PNeuron;
  T, U: PSynapsis;
  SynValue, SynNumber, SynNeuronPrior, SynNeuronNext, SynLayer, SynLayerAnt: string;
  First: boolean;
label
  1;
begin
  // Primeiro destr�i as sinapses
  P := Layer;
  while P.LayerNext <> nil do
  begin
    T := P.SynapsisFirst;

    while T <> nil do
    begin
      P.SynapsisFirst := T.SynapsisNext; // pula o primeiro
      FreeSynapsis(T); // libera o primeiro
      T := P.SynapsisFirst;
    end;

    P := P.LayerNext;
  end;

  // Abre arquivo netfile
  AssignFile(F, FKnowledge);
  Reset(F);

  // Depois, reconstr�i as conex�es sin�pticas
  First := true;

  while not Eof(F) do
  begin
    // L� do arquivo
    ReadLn(F, SynNumber);
    ReadLn(F, SynNeuronPrior);
    ReadLn(F, SynNeuronNext);
    ReadLn(F, SynLayer);
    ReadLn(F, SynValue);

    if (StrToInt(SynLayer) > 1) and (SynLayer <> SynLayerAnt) then
    begin
      T.SynapsisNext := nil;
      First := true;
    end;

    SynLayerAnt := SynLayer;

    P := Layer;
    Q := Layer.LayerNext;

    while Q <> nil do
    begin
      R := P.NeuronFirst;

      while R <> nil do
      begin
        S := Q.NeuronFirst;

        while S <> nil do
        begin
          if (R.Number = StrToInt(SynNeuronPrior)) and (S.Number = StrToInt(SynNeuronNext)) and (P.Number = StrToInt(SynLayer)) then
          begin
            T := GetSynapsis;

            if not First then
              U.SynapsisNext := T // monta a cadeia com os seguintes
            else
              P.SynapsisFirst := T; // liga a primeira sinapse � camada

            First := false;

            T.Number := StrToInt(SynNumber);
            T.Value := StrToFloat(SynValue);
            T.Delta := 0;
            T.NeuronPrior := R;
            T.NeuronNext := S;
            U := T;

            goto 1;
          end;

          S := S.NeuronNext;
        end;

        R := R.NeuronNext;
      end;

      P := Q; // Assume P como pr�xima camada e Q como a seguinte
      Q := Q.LayerNext;
    end;

    1:
  end;

  T.SynapsisNext := nil;
  CloseFile(F);
end;

procedure TMLP.Purge;
var
  P: PLayer;
  T, U, V: PSynapsis;
  k: longint;
begin
  // Expurga os pesos zerados
  P := Layer;

  while P.LayerNext <> nil do
  begin
    T := P.SynapsisFirst;
    U := T;
    T := T.SynapsisNext;

    while T <> nil do
    begin
      if Trunc(T.Value * 100) = 0 then
      begin
        U.SynapsisNext := T.SynapsisNext;
        V := T;
        T := T.SynapsisNext;
        FreeSynapsis(V);
      end
      else
      begin
        U := T;
        T := T.SynapsisNext;
      end;
    end;

    P := P.LayerNext;
  end;

  // Renumera os pesos
  k := 1;
  P := Layer;

  while P.LayerNext <> nil do
  begin
    T := P.SynapsisFirst;

    while T <> nil do
    begin
      T.Number := k;
      Inc(k);
      T := T.SynapsisNext;
    end;

    P := P.LayerNext;
  end;
end;

function TMLP.GetLayer: PLayer;
var
  P: PLayer;
begin
  New(P);
  Result := P;
end;

procedure TMLP.FreeLayer(var Node: PLayer);
begin
  Dispose(Node);
end;

function TMLP.GetNeuron: PNeuron;
var
  P: PNeuron;
begin
  New(P);
  Result := P;
end;

procedure TMLP.FreeNeuron(var Node: PNeuron);
begin
  Dispose(Node);
end;

function TMLP.GetSynapsis: PSynapsis;
var
  P: PSynapsis;
begin
  New(P);
  Result := P;
end;

procedure TMLP.FreeSynapsis(var Node: PSynapsis);
begin
  Dispose(Node);
end;

procedure TMLP.SetStruct(Value: TStrings);
begin
  if Value.Count < 2 then
    ShowMessage('Uma rede MLP deve ter no m�nimo 2 camadas')
  else
    FStruct.Assign(Value);
end;

procedure TMLP.SetEpochs(Value: longint);
begin
  FEpochs := Value;
end;

procedure TMLP.SetMomentum(Value: double);
begin
  FMomentum := Value;
end;

procedure TMLP.SetLearning(Value: double);
begin
  FLearning := Value;
end;

procedure TMLP.SetKnowledge(Value: string);
begin
  FKnowledge := Value;
end;

constructor TMLP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FStruct := TStringList.Create;
  SetMomentum(0.5);
  SetLearning(0.9);
  SetKnowledge('');
  Prepared := false;
  FGamma := 0;
end;

destructor TMLP.Destroy;
begin
  FStruct.Free;

  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Lfm', [TMLP]);
end;

end.

