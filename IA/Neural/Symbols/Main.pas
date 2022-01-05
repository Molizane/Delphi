unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Grids, ComCtrls, frmTargetTbl, frmChooseTarget, NetObj;

const DIVIDER=32;

type
  TMainForm = class(TForm)
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    NetOpenDialog: TOpenDialog;
    NetSaveDialog: TSaveDialog;
    Network: TBPnet;
    Panel2: TPanel;
    PaintBox: TImage;
    Panels: TNotebook;
    Label1: TLabel;
    Label2: TLabel;
    PatternLabel: TLabel;
    ClearBtn: TButton;
    IdentifyBtn: TButton;
    AddPatternBtn: TButton;
    TrainPanel: TPanel;
    Label4: TLabel;
    Label3: TLabel;
    ErrorLabel: TLabel;
    IterateLabel: TLabel;
    Label5: TLabel;
    LRlabel: TLabel;
    Label6: TLabel;
    MomentumLabel: TLabel;
    Label7: TLabel;
    GroupBox2: TGroupBox;
    TargetTblBtn: TButton;
    SaveTrnBtn: TButton;
    LoadTrnBtn: TButton;
    GroupBox1: TGroupBox;
    TrainBtn: TButton;
    TopologyBtn: TButton;
    SaveBtn: TButton;
    LoadBtn: TButton;
    Panel1: TPanel;
    ProgressBar: TProgressBar;
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
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure TrainBtnClick(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure LoadTrnBtnClick(Sender: TObject);
    procedure TargetTblBtnClick(Sender: TObject);
    procedure AddPatternBtnClick(Sender: TObject);
    procedure SaveTrnBtnClick(Sender: TObject);
    function ProcessImage:boolean;
    procedure SaveBtnClick(Sender: TObject);
    procedure IdentifyBtnClick(Sender: TObject);
    procedure TopologyBtnClick(Sender: TObject);
    function NetworkIteration(Sender: TNetwork): Boolean;
    procedure NetPaintBoxPaint(Sender: TObject);
    procedure GraphTreeViewChange(Sender: TObject; Node: TTreeNode);
  private
    SelLayer:longint;
    SelNode:longint;
    SelLink:longint;
    isStop:boolean;
    TrainFile:TextFile;
    isPaint:boolean;
    OldX:longint;
    OldY:longint;
    CurrentData:array[0..DIVIDER-1] of extended;
   public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure SetBitInMask(BitMap: PChar; Num: word; TurnOn: boolean);
var ByteNum, Bit: byte;
const Bits: array[0..7] of byte = (1, 2, 4, 8, 16, 32, 64, 128);
begin
 ByteNum := Num div 8;
 Bit := Bits[Num - ByteNum * 8];
 if TurnOn then
  BitMap[ByteNum] := char(byte(BitMap[ByteNum]) or Bit)
 else
  BitMap[ByteNum] := char(byte(BitMap[ByteNum]) and not Bit);
end;

procedure TMainForm.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 isPaint:=True;
 OldX:=X;
 OldY:=Y
end;

procedure TMainForm.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 isPaint:=False;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 ClientWidth:=423;
 isPaint:=False;
 SelLayer:=-1;
 SelNode:=0;
 SelLink:=0;
 OpenDialog.InitialDir:=ExtractFilePath(Application.ExeName);
 SaveDialog.InitialDir:=ExtractFilePath(Application.ExeName);
 NetOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName);
 NetSaveDialog.InitialDir:=ExtractFilePath(Application.ExeName);
end;

procedure TMainForm.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if isPaint then
  begin
   PaintBox.Canvas.MoveTo(oldX,oldY);
   PaintBox.Canvas.LineTo(X,Y);
   oldX:=X;
   OldY:=Y;
  end;
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
end;

procedure TMainForm.TrainBtnClick(Sender: TObject);
begin
 if TrainBtn.Caption='Stop' then
  begin
   isStop:=true;
   TrainBtn.Caption:='Train...';
   TrainPanel.Visible:=False;
  end
 else
 if OpenDialog.Execute then
  begin
   TrainBtn.Caption:='Stop';
   isStop:=False;
   TopologyBtn.Enabled:=True;
   IterateLabel.Caption:='0';
   ErrorLabel.Caption:='0.000000';
   TrainPanel.Visible:=True;
   Network.Define(DIVIDER,3,3,[10,8,5],[tfSig,tfSig,tfTSig],tfSig);
   Network.Train(OpenDialog.FileName);
   SaveBtn.Enabled:=True;
   IdentifyBtn.Enabled:=True;
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
 IdentifyBtn.Enabled:=True;
end;

procedure TMainForm.LoadTrnBtnClick(Sender: TObject);
begin
 if OpenDialog.Execute then
  begin
   Network.AssignLRN(OpenDialog.FileName, False);
   AddPatternBtn.Enabled:=True;
   TargetTblBtn.Enabled:=True;
  end;
end;


procedure TMainForm.TargetTblBtnClick(Sender: TObject);
var T:TTargets;
begin
 T:=Network.Targets;
 EditTargetTable(T);
 Network.Targets:=T;
 SaveTrnBtn.Enabled:=Network.Targets.Count>0;
 AddPatternBtn.Enabled:=Network.Targets.Count>0;
end;

function TMainForm.ProcessImage:boolean;
var X0,Y0,X1,Y1,XSize,YSize,I,J:integer;
    Row,Column:integer;
    dX,dY:double;
    DataWord:longint;
    I1,J1,I2,J2,I3,J3,I4,J4:integer;
begin
   Result:=False;
   for I1:=0 to PaintBox.ClientWidth do
    for J1:=0 to PaintBox.ClientHeight do
     if PaintBox.Canvas.Pixels[I1,J1]=clYellow then
      begin
       X0:=I1;
   for I2:=PaintBox.ClientWidth downto 0 do
    for J2:=0 to PaintBox.ClientHeight do
     if PaintBox.Canvas.Pixels[I2,J2]=clYellow then
      begin
       X1:=I2;

   for J3:=0 to PaintBox.ClientHeight do
    for I3:=0 to PaintBox.ClientWidth do
     if PaintBox.Canvas.Pixels[I3,J3]=clYellow then
      begin
       Y0:=J3;

   for J4:=PaintBox.ClientHeight downto 0 do
    for I4:=0 to PaintBox.ClientWidth do
     if PaintBox.Canvas.Pixels[I4,J4]=clYellow then
      begin
       Y1:=J4;
       Xsize:=X1-X0;
       Ysize:=Y1-Y0;
       dX:=Xsize/DIVIDER;
       dY:=Ysize/DIVIDER;
       FillChar(CurrentData,SizeOf(CurrentData),#0);
       ProgressBar.Position:=0;
       ProgressBar.Max:=(DIVIDER-1)*(DIVIDER-1);
       for Row:=0 to DIVIDER-1 do
        begin
         DataWord:=0;
         for Column:=0 to DIVIDER-1 do
          begin
           for I:=Round(X0+Row*dX) to Round(X0+(Row+1)*dX) do
            for J:=Round(Y0+Column*dY) to Round(Y0+(Column+1)*dY) do
             if PaintBox.Canvas.Pixels[I,J]=clYellow then SetBitInMask(@DataWord,Column,True);
           ProgressBar.Position:=ProgressBar.Position+1;
          end;
          CurrentData[Row]:=DataWord/MAXLONGINT;
        end;
       Result:=True;
       ProgressBar.Position:=0;
       Exit;
      end;
      end;
      end;
      end;
end;

procedure TMainForm.AddPatternBtnClick(Sender: TObject);
var I:integer;
    PatternData:TPatternData;
    TargetNum:integer;
begin
 if not ProcessImage then Exit;
 TargetNum:=ChooseTarget(Network.Targets);
 Panels.PageIndex:=2;
 if TargetNum>0 then
 With Network do
  begin
   AddTrainPattern(CurrentData,Targets.Table[TargetNum].Vector.Data^);
   PatternLabel.Caption:=IntToStr(Network.Targets.Count);
   SaveTrnBtn.Enabled:=True;
  end;
end;

procedure TMainForm.SaveTrnBtnClick(Sender: TObject);
begin
 if SaveDialog.Execute then Network.SaveToLRN(SaveDialog.FileName);
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

procedure TMainForm.IdentifyBtnClick(Sender: TObject);
var I:integer;
begin
 ProgressBar.Position:=0;
 if not ProcessImage then Exit;
 for I:=1 to Network.InputCount do Network.SetInput(I,CurrentData[I-1]);
 ShowMessage('Answer - "'+Network.AnswerStr+'"');
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
begin
 IterateLabel.Caption:=IntToStr(Sender.Epoch);
 ErrorLabel.Caption:=FloatToStrF(Sender.SSE,ffFixed,10,6);
 LRLabel.Caption:=FloatToStrF(Sender.LearnRate,ffFixed,10,6);
 MomentumLabel.Caption:=FloatToStrF(Sender.Momentum,ffFixed,10,6);
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

