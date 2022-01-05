unit UNN;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, OleCtrls, CobaltSDK_TLB;

type
  TfrmNN = class(TForm)
    imgRMSE: TImage;
    btnTrain: TButton;
    btnCancel: TButton;
    lblCancel: TLabel;
    lblEpoch: TLabel;
    OD1: TOpenDialog;
    btnPredict: TButton;
    btnbatchPredict: TButton;
    lblPrediction: TLabel;
    lblBatchPredict: TLabel;
    NN1: TNN;
    procedure NN1Epoch(Sender: TObject; var Epoch: Integer);
    procedure btnTrainClick(Sender: TObject);
    procedure NN1RMSError(Sender: TObject; var RMSError: Double);
    procedure btnPredictClick(Sender: TObject);
    procedure btnbatchPredictClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Graph : Tpoint;
  public
    { Public declarations }
  end;

var
  frmNN: TfrmNN;

implementation

{$R *.DFM}

procedure TfrmNN.NN1Epoch(Sender: TObject; var Epoch: Integer);
begin
 lblEpoch.Caption := 'Epoch: ' + inttostr(Epoch);
end;

procedure TfrmNN.btnTrainClick(Sender: TObject);
    var FileName : wideString;
var Epochs: Integer;
LearningRate: Double;
Momentum: Double;
MaxNeurons,ResetWeights,DataOption: Smallint;

begin

    lblCancel.Caption := '';
    btnTrain.Enabled := True;
    btnPredict.Enabled := False;
    btnBatchPredict.Enabled := False;
    btnCancel.Enabled := true;

    //Get a filename
    OD1.Filter := 'CSV Files|*.csv;*.txt';
    OD1.FileName := 'NN Train.txt'; //Default filename
    if OD1.Execute then
    begin
      FileName := OD1.FileName;
      If ExtractFilePath(FileName) = '' Then
      begin
        ShowMessage('Please locate the NN Train.txt file');
        abort;
    End;
    //Clear graph
     Graph.X := 0;


     btnCancel.Enabled := True;

      //Epochs, learning rate and momentum are set arbitrarily in this example.
      Epochs:=5000;
      LearningRate:=2;
      Momentum:=0.7;
      MaxNeurons:=50;
      ResetWeights:=1;
      DataOption:=1;
      NN1.Train(FileName,DataOption, Epochs, LearningRate, Momentum, MaxNeurons, ResetWeights);   //Train the neural network.
      lblEpoch.Caption := 'Neural network trained';
      btnPredict.Enabled := true;
      btnBatchPredict.Enabled := False;
    end;

end;

procedure TfrmNN.NN1RMSError(Sender: TObject; var RMSError: Double);
var ErrorInt : integer;
begin
   //Display the RMSE graph
    Graph.X := Graph.X + 6;
    ErrorInt:= Round (RMSError * 100);
    Graph.Y := imgRMSE.Height - ErrorInt - 500;
    imgRMSE.canvas.Pen.Color:=clblue;
    imgRMSE.Canvas.Lineto(Graph.X, Graph.Y);
    imgRMSE.Canvas.MoveTo(Graph.x,Graph.Y);

end;

procedure TfrmNN.btnPredictClick(Sender: TObject);
    var Prediction,LearningRate,Momentum : Double;
    FileName : WideString;
    DataOption:smallint;
begin

    //This routine will predict one ASCII CSV record in a file.
    //If the ASCII file contains more than one record, only the last
    //record will be predicted.


    //Get a filename
    OD1.Filter := 'CSV Files|*.csv;*.txt';
    OD1.FileName:='NN Predict.txt';
    if OD1.Execute then
    begin
      FileName := OD1.FileName;
      If ExtractFilePath(FileName) = '' Then
      begin
        ShowMessage('Please locate the NN Predict.txt file');
        abort;
      end;
    End;

    //Learning rate and momentum must be the same
    //as when the neural network was trained.
    LearningRate:=2;
    Momentum:=0.7;
    //FileNameOrData argument is a file name
    DataOption:=1;
    Prediction := NN1.Predict(FileName,DataOption, LearningRate, Momentum);

    lblPrediction.Caption := FloatToStr(Prediction);
    btnBatchPredict.enabled:=true;
end;

procedure TfrmNN.btnbatchPredictClick(Sender: TObject);
    var LearningRate,Momentum : Double;
    OutFile,FileName : WideString;
    DataOption:smallint;
begin

    //This routine will predict many ASCII CSV records in a file

    //Get a filename
    OD1.Filter := 'CSV Files|*.csv;*.txt';
    OD1.FileName:='NN Batch Predict.txt';
    if OD1.Execute then
    begin
      FileName := OD1.FileName;
      If ExtractFilePath(FileName) = '' Then
      begin
        ShowMessage('Please locate the NN Batch Predict.txt file');
        abort;
      end;
    End;
    //Get another filename
    OD1.Filter := 'CSV Files|*.csv;*.txt';
    OD1.FileName:='NN Batch Predict Output.txt';
    if OD1.Execute then
    begin
      OutFile := OD1.FileName;
      If ExtractFilePath(FileName) = '' Then
      begin
        ShowMessage('Please locate the NN Batch Predict Output.txt file');
        abort;
      end;
    End;
    //FileNameOrData argument is a file name
    DataOption:=1;
    //Learning rate and momentum must be the same
    //as when the neural network was trained.
    NN1.BatchPredict(FileName, DataOption, OutFile, LearningRate,Momentum);
    lblBatchPredict.Caption := 'Predictions save to ' + ExtractFileName(OD1.FileName);

end;

procedure TfrmNN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        //free form
        frmNN:=nil;
        Action:=caFree;
end;

end.
