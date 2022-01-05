unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  NetObj, StdCtrls, ComCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    TreeView1: TTreeView;
    Label6: TLabel;
    CanvasSheet: TTabSheet;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    IterLbl: TLabel;
    ErrLbl: TLabel;
    LRlbl: TLabel;
    TrainBtn: TButton;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    AnswerLabel: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    AnswerBtn: TButton;
    BuildBtn: TButton;
    StopBtn: TButton;
    PaintBox: TPaintBox;
    Label7: TLabel;
    Momentlbl: TLabel;
    Net: TBPnet;
    procedure TrainBtnClick(Sender: TObject);
    function NetIteration(Sender: TNetwork): Boolean;
    procedure BuildBtnClick(Sender: TObject);
    procedure AnswerBtnClick(Sender: TObject);
    procedure StopBtnClick(Sender: TObject);
    procedure PaintBoxPaint(Sender: TObject);
  private
    isStop:boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.TrainBtnClick(Sender: TObject);
var Pattern:TPatternData;
begin
 isStop:=False;
 StopBtn.Enabled:=True;
 Net.ClearTrainDatabase;
 With Net do
  begin
   AddTrainPattern([0.0,1.0],[1.0]);
   AddTrainPattern([0.0,0.0],[0.0]);
   AddTrainPattern([1.0,0.0],[1.0]);
   AddTrainPattern([1.0,1.0],[0.0]);
   Net.Retrain;
   StopBtn.Enabled:=False;
  end;
end;

function TForm1.NetIteration(Sender: TNetwork): Boolean;
begin
With Sender do
 begin
  IterLbl.Caption:=IntToStr(Epoch);
  ErrLbl.Caption:=FloatToStrF(SSE,ffFixed,1,6);
  LRLbl.Caption:=FloatToStrF(LearnRate,ffFixed,1,6);
  MomentLbl.Caption:=FloatToStrF(Momentum,ffFixed,1,6);
 end;
 Result:=isStop;
end;

procedure TForm1.BuildBtnClick(Sender: TObject);
begin
 Net.Define(2,1,1,[3],[tftSig],tfSig);
 TrainBtn.Enabled:=True;                
 AnswerBtn.Enabled:=True;
 Net.TopologyToTree(TreeView1);
 Net.TopologyToText(Memo1.Lines);
 Net.DrawTopology(PaintBox.Canvas,-1,0,-1);
end;

procedure TForm1.AnswerBtnClick(Sender: TObject);
var ANS:TVector;
begin
 try
  Net.SetInput(1,StrToFloat(Edit1.Text));
  Net.SetInput(2,StrToFloat(Edit2.Text));
 except
  on E:Exception do
   begin
    MessageDlg(E.Message,mtError,[mbOK],0);
    Exit;
   end;
 end;
 ANS:=TVector.Create(Net.OutputCount);
 Net.Answer(ANS);
 AnswerLabel.Caption:=FloatToStrF(ANS[1],ffFixed,1,4);
 ANS.Free;
end;

procedure TForm1.StopBtnClick(Sender: TObject);
begin
 isStop:=True;
end;

procedure TForm1.PaintBoxPaint(Sender: TObject);
begin
 if TrainBtn.Enabled then Net.DrawTopology(PaintBox.Canvas,-1,0,-1);
end;

end.
