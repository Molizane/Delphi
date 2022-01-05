unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Grids, ComCtrls, NetObj;

type
  TMainForm = class(TForm)
    NetOpenDialog: TOpenDialog;
    NetSaveDialog: TSaveDialog;
    Network: TBPnet;
    Panel2: TPanel;
    PaintBox: TImage;
    ClearBtn: TButton;
    TrainPanel: TPanel;
    Label4: TLabel;
    Label3: TLabel;
    ErrorLabel: TLabel;
    IterateLabel: TLabel;
    Label7: TLabel;
    GroupBox1: TGroupBox;
    TrainBtn: TButton;
    TopologyBtn: TButton;
    SaveBtn: TButton;
    LoadBtn: TButton;
    Panel3: TPanel;
    Label8: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    TreeView1: TTreeView;
    TabSheet3: TTabSheet;
    NetPaintBox: TPaintBox;
    GraphTreeView: TTreeView;
    ShowResponseCheck: TCheckBox;
    LRcheck: TCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    MomentumEdit: TEdit;
    LREdit: TEdit;
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure TrainBtnClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure TopologyBtnClick(Sender: TObject);
    function NetworkIteration(Sender: TNetwork): Boolean;
    procedure NetPaintBoxPaint(Sender: TObject);
    procedure GraphTreeViewChange(Sender: TObject; Node: TTreeNode);
  private
    SelLayer:longint;
    SelNode:longint;
    SelLink:longint;
    isStop:boolean;
    isPaint:boolean;
    Count:longint;
    CurrentData:array[0..1024] of record X,Y:longint end;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 isPaint:=True;
 PaintBox.Canvas.Ellipse(X-2,Y-2,X+2,Y+2);
 Inc(Count);
 CurrentData[Count].X:=X;
 CurrentData[Count].Y:=Y;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 ClientWidth:=423;
 isPaint:=False;
 SelLayer:=-1;
 SelNode:=0;
 SelLink:=0;
 NetOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName);
 NetSaveDialog.InitialDir:=ExtractFilePath(Application.ExeName);
 DecimalSeparator:='.';
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
 PaintBox.Canvas.Brush.Color:=clBlack;
 PaintBox.Canvas.Brush.Style:=bsSolid;
 PaintBox.Canvas.Pen.Color:=clYellow;
 PaintBox.Canvas.FillRect(PaintBox.ClientRect);
end;

procedure TMainForm.ClearBtnClick(Sender: TObject);
begin
 PaintBox.Canvas.Brush.Color:=clBlack;
 PaintBox.Canvas.FillRect(PaintBox.ClientRect);
 Count:=0;
end;

procedure TMainForm.TrainBtnClick(Sender: TObject);
var I:longint;
begin
 if Count<2 then
  begin
   MessageDlg('Please, define curve points before NN training',mtWarning,[mbOK],0);
   Exit;
  end; 
 if TrainBtn.Caption='Stop' then
  begin
   isStop:=true;
   TrainBtn.Caption:='Train...';
   TrainPanel.Visible:=False;
   LREdit.Enabled:=True;
   MomentumEdit.Enabled:=True;
  end
 else
  begin
   try
    Network.LearnRate:=StrToFloat(LREdit.Text);
   except
    MessageDlg('Invalid learning rate',mtError,[mbOK],0);
    LREdit.SetFocus;
    exit;
   end;
   try
    Network.Momentum:=StrToFloat(MomentumEdit.Text);
   except
    MessageDlg('Invalid momentum constant',mtError,[mbOK],0);
    LREdit.SetFocus;
    exit;
   end;
   TrainBtn.Caption:='Stop';
   LREdit.Enabled:=False;
   MomentumEdit.Enabled:=False;
   isStop:=False;
   TopologyBtn.Enabled:=True;
   IterateLabel.Caption:='0';
   ErrorLabel.Caption:='0.000000';
   Network.Define(1,3,1,[20,15,5],[tftSig,tftSig,tftSig],tfSig);
   Network.AutoLR:=LRcheck.Checked;

   TrainPanel.Visible:=True;
   With Network do
    begin
     ClearTrainDatabase;
     for I:=1 to Count do AddTrainPattern([CurrentData[I].X/PaintBox.Width],[CurrentData[I].Y/PaintBox.Height]);
     Retrain;
    end;
   TopologyBtn.Enabled:=True;
  end;
end;

procedure TMainForm.LoadBtnClick(Sender: TObject);
begin
 if not NetOpenDialog.Execute then Exit;
 try
  Network.Load(NetopenDialog.FileName);
 except  MessageDlg('NN file reading error',mtError,[mbOK],0) end;
 TopologyBtn.Enabled:=True;
end;


procedure TMainForm.SaveBtnClick(Sender: TObject);
begin
 if not NetSaveDialog.Execute then Exit;
  try
   Network.Save(NetSaveDialog.Filename);
  except
   MessageDlg('NN file saving error',mtError,[mbOK],0);
  end;
end;

procedure TMainForm.TopologyBtnClick(Sender: TObject);
begin
case TopologyBtn.Tag of
 0: begin
     Network.TopologyToTree(TreeView1);
     Network.TopologyToTree(GraphTreeView);
     Network.TopologyToText(Memo1.Lines);
     Network.DrawTopology(NetPaintBox.Canvas,-1,0,0);
     ClientWidth:=800;
     TopologyBtn.Caption:='Topology <<<';
     TopologyBtn.Tag:=1;
    end;
 1: begin
     ClientWidth:=423;
     TopologyBtn.Caption:='Topology >>>';
     TopologyBtn.Tag:=0;
    end;
 end;
end;

function TMainForm.NetworkIteration(Sender: TNetwork): Boolean;
var AnsSet:TVector;
    X,Y,I:longint;
begin
 IterateLabel.Caption:=IntToStr(Sender.Epoch);
 ErrorLabel.Caption:=FloatToStrF(Sender.SSE,ffFixed,10,6);
 LREdit.Text:=FloatToStrF(Sender.LearnRate,ffFixed,10,6);
 MomentumEdit.Text:=FloatToStrF(Sender.Momentum,ffFixed,10,6);
 Network.AutoLR:=LRcheck.Checked;
 if ShowResponseCheck.Checked then
  With PaintBox.Canvas do
  begin
   try
    Brush.Color:=clBlack;
    FillRect(PaintBox.ClientRect);
    AnsSet:=TVector.Create(1);
    for I:=CurrentData[1].X to CurrentData[Count].X do
     begin
      Network.SetInput(1,I/PaintBox.Width);
      Network.Answer(AnsSet);
      Pixels[I,Round(AnsSet[1]*PaintBox.Height)]:=clBlue;
     end;

    Pen.Color:=clYellow;
    for I:=1 to Count do
     Ellipse(CurrentData[I].X-2,CurrentData[I].Y-2,CurrentData[I].X+2,CurrentData[I].Y+2);
    finally
     AnsSet.Free;
    end;
  end;
 Result:=isStop;
end;

procedure TMainForm.NetPaintBoxPaint(Sender: TObject);
begin
 Network.DrawTopology(NetPaintBox.Canvas,SelLayer,SelNode,SelLink);
end;

procedure TMainForm.GraphTreeViewChange(Sender: TObject; Node: TTreeNode);
begin
 SelLayer:=-1;
 SelNode:=0;
 SelLink:=-1;
 case Node.Level of
 0: SelLayer:=TNeuron(Node.Data).Layer;
 1: begin
     SelLayer:=TNeuron(Node.Data).Layer;
     SelNode:=TNeuron(Node.Data).Number;
    end;
 2: begin
     SelLayer:=TNeuron(Node.Parent.Data).Layer;
     SelNode:=TNeuron(Node.Parent.Data).Number;
     SelLink:=Node.Index;
    end;
  end;
  NetPaintBox.Refresh;
end;

end.

