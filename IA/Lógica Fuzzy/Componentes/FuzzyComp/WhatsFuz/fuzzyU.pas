//*****************************************************************
//   Application : Example of use of Fuzzy Components
//                 Fuzzy Stock Management
//   by Alexandre Beauvois 14/06/1998
//   Advice : If you never heard about Fuzzy Logic you should go
//            to http://www.a-w.de/FOODOPT/ARTIKEL/fnrchp00.htm
//   How to Use : Change the Demand by clicking (at run time)
//                on the demand Component and Click on the
//                the result button many times. The Stock
//                will be stabilized...
//*****************************************************************

unit fuzzyU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Grids, Gauges, ExtCtrls, MShape, FuzzyComp;

type
  TfmFuzzy = class(TForm)
    EditStock: TEdit;
    lblStockRealInput: TLabel;
    lblDemandRealInput: TLabel;
    EditDemand: TEdit;
    gridFAM: TStringGrid;
    lblFAM: TLabel;
    lblDemand: TLabel;
    lblStock: TLabel;
    gaugeStockLevel: TGauge;
    bvlFAM: TBevel;
    btnResult: TBitBtn;
    edCompatibility: TStaticText;
    lblCompatibility: TLabel;
    bvlStock: TBevel;
    StaticTextStock1: TStaticText;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    MultiShapeArrow: TMultiShape;
    pnlInstruction: TPanel;
    FuzzyDemand: TFuzzyfication;
    FuzzyStock: TFuzzyfication;
    StaticTextStock2: TStaticText;
    StaticTextDemand: TStaticText;
    rbAverage: TRadioButton;
    rbMax: TRadioButton;
    rbMin: TRadioButton;
    Label1: TLabel;
    edtRealOutput: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FuzzyStockResultChange(Sender: TObject);
    procedure bGetValueClick(Sender: TObject);
    procedure FuzzyStockChange(Sender: TObject);
    procedure FuzzyDemandChange(Sender: TObject);
    procedure EditStockEnter(Sender: TObject);
    procedure EditStockExit(Sender: TObject);
    procedure gridFAMDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure rbAverageClick(Sender: TObject);
  private
    FProgress: Double;
    ValAnt: string;
    procedure RefreshGrid;
  public
    FuzzyStockResult: TFuzzySolution;
  end;

var
  fmFuzzy: TfmFuzzy;

implementation

uses
  Math, fuzzyDspU;

{$R *.DFM}

procedure TfmFuzzy.FormCreate(Sender: TObject);
var
  i: integer;
begin
  EditStock.Text := FloatToStrF(FuzzyStock.RealInput, ffFixed, 5, 2);
  EditDemand.Text := FloatToStrF(FuzzyDemand.RealInput, ffFixed, 5, 2);

  gridFAM.Cells[0, 0] := 'StkV';
  
  gridFAM.Cells[0, 1] := 'Low';
  gridFAM.Cells[0, 2] := 'Medium';
  gridFAM.Cells[0, 3] := 'Important';

  gridFAM.Cells[1, 0] := 'Low';
  gridFAM.Cells[2, 0] := 'Medium';
  gridFAM.Cells[3, 0] := 'Important';

  {Datas}
  gridFAM.Cells[1, 1] := 'NL';
  gridFAM.Cells[2, 2] := 'NL';
  gridFAM.Cells[3, 3] := 'NL';
  gridFAM.Cells[1, 2] := 'QP';
  gridFAM.Cells[2, 1] := 'QN';
  gridFAM.Cells[2, 3] := 'QP';
  gridFAM.Cells[3, 2] := 'QN';
  gridFAM.Cells[1, 3] := 'VP';
  gridFAM.Cells[3, 1] := 'VN';

  for i := 1 to 3 do
    FuzzyStock.Members[i - 1].Name := gridFAM.Cells[0, i];

  for i := 1 to 3 do
    FuzzyDemand.Members[i - 1].Name := gridFAM.Cells[i, 0];

  FuzzyStockResult := TFuzzySolution.Create(Self);

  with FuzzyStockResult do
  begin
    Left := bvlStock.Left;
    Width := bvlStock.Width;
    Top := 56;
    Hint := 'StockVar';
    ShowHint := True;
    Members.Clear;
    AddMember('VN', -40, -60, tmLInfinity);
    AddMember('QN', -20, -40, tmTriangle);
    AddMember('NL', 0, -20, tmTriangle);
    AddMember('QP', 20, 0, tmTriangle);
    AddMember('VP', 40, 20, tmRInfinity);
    Maxi := 60;
    Anchors := bvlStock.Anchors;
    OnChange := FuzzyStockResultChange;
  end;
end;

procedure TfmFuzzy.FuzzyStockResultChange(Sender: TObject);
begin
  edCompatibility.Caption := FloatToStrF(FuzzyStockResult.Compatibility, ffFixed, 5, 2) + ' ';
end;

procedure TfmFuzzy.bGetValueClick(Sender: TObject);
var
  StockIdx, DemandIdx: Integer;
  StockOwnerShip, DemandOwnerShip, ResultOwnerShip: Double;
  StockVarFuzzyDescriptor: string;
  StockVarIndex: integer;
  MaxAverage: single;
begin
  MaxAverage := 0;
  FuzzyStockResult.ClearSolution;
  frmGrid.GridFuzzy.RowCount := 2;
  frmGrid.GridFuzzy.Cells[0, 1] := '';
  frmGrid.GridFuzzy.Cells[1, 1] := '';
  frmGrid.GridFuzzy.Cells[2, 1] := '';
  frmGrid.GridFuzzy.Cells[3, 1] := '';
  frmGrid.Visible := True;

  for StockIdx := 0 to FuzzyStock.Members.Count - 1 do
  begin
    for DemandIdx := 0 to FuzzyDemand.Members.Count - 1 do
    begin
      if (frmGrid.GridFuzzy.RowCount <> 2) or (frmGrid.GridFuzzy.Cells[1, 1] <> '') then
        frmGrid.GridFuzzy.RowCount := frmGrid.GridFuzzy.RowCount + 1;

      frmGrid.GridFuzzy.Cells[0, frmGrid.GridFuzzy.RowCount - 1] := Format('Stock: %d, Demand: %d', [StockIdx, DemandIdx]);

      StockOwnerShip := FuzzyStock.OutPuts[StockIdx];
      DemandOwnerShip := FuzzyDemand.OutPuts[DemandIdx];

      if rbAverage.Checked then
        ResultOwnerShip := (StockOwnerShip + DemandOwnerShip) / 2
      else if rbMin.Checked then
        ResultOwnerShip := MinValue([StockOwnerShip, DemandOwnerShip])
      else
        ResultOwnerShip := MaxValue([StockOwnerShip, DemandOwnerShip]);

      frmGrid.GridFuzzy.Cells[1, frmGrid.GridFuzzy.RowCount - 1] := FloatToStrF(StockOwnerShip, ffFixed, 5, 2);
      frmGrid.GridFuzzy.Cells[2, frmGrid.GridFuzzy.RowCount - 1] := FloatToStrF(DemandOwnerShip, ffFixed, 5, 2);
      frmGrid.GridFuzzy.Cells[3, frmGrid.GridFuzzy.RowCount - 1] := FloatToStrF(ResultOwnerShip, ffFixed, 5, 2);

      if ResultOwnerShip > MaxAverage then
        MaxAverage := ResultOwnerShip;

      //if (StockOwnerShip > 0) and (DemandOwnerShip > 0) then //launching threshold
      if (StockOwnerShip > 0) or (DemandOwnerShip > 0) then //launching threshold
      //if ResultOwnerShip <> 0 then
      begin
        StockVarFuzzyDescriptor := gridFAM.Cells[StockIdx + 1, DemandIdx + 1];
        gridFAM.Row := DemandIdx + 1;
        gridFAM.Col := StockIdx + 1;
        StockVarIndex := FuzzyStockResult.Members.GetMemberIndex(StockVarFuzzyDescriptor);
        FuzzyStockResult.FuzzyAgregate(StockVarIndex, ResultOwnerShip);
        //ShowMessage('Next Rule');
      end;
    end;
  end;

  edtRealOutput.Caption := FloatToStrF(FuzzyStockResult.RealOutput, ffFixed, 5, 2) + ' ';
  FProgress := FProgress + FuzzyStockResult.RealOutput;
  gaugeStockLevel.Progress := Round(FProgress);
  FuzzyStock.RealInput := FProgress;
end;

procedure TfmFuzzy.FuzzyStockChange(Sender: TObject);
begin
  EditStock.Text := FloatToStrF(FuzzyStock.RealInput, ffFixed, 5, 2);
  FProgress := FuzzyStock.RealInput;
  gaugeStockLevel.Progress := Round(FProgress);
  RefreshGrid;
end;

procedure TfmFuzzy.FuzzyDemandChange(Sender: TObject);
begin
  EditDemand.Text := FloatToStrF(FuzzyDemand.RealInput, ffFixed, 5, 2);
  RefreshGrid;
end;

procedure TfmFuzzy.EditStockEnter(Sender: TObject);
begin
  ValAnt := TEdit(Sender).Text;
end;

procedure TfmFuzzy.EditStockExit(Sender: TObject);
begin
  if ValAnt <> TEdit(Sender).Text then
  begin
    if Sender = EditStock then
    begin
      FuzzyStock.RealInput := StrToFloatDef(EditStock.Text, 0);
      FProgress := FuzzyStock.RealInput;
      gaugeStockLevel.Progress := Round(FProgress);
    end
    else
      FuzzyDemand.RealInput := StrToFloatDef(EditDemand.Text, 0);
  end;
end;

procedure TfmFuzzy.gridFAMDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  nLeft, nTop: Integer;
  Txt: string;
begin
  Txt := gridFAM.Cells[ACol, ARow];

  if (ARow = 0) or (ACol > 0) then
    nLeft := (Rect.Right - Rect.Left - gridFAM.Canvas.TextWidth(Txt)) div 2
  else
    nLeft := 2;

  nTop := (Rect.Bottom - Rect.Top - gridFAM.Canvas.TextHeight('วร')) div 2;
  gridFAM.Canvas.FillRect(Rect);
  gridFAM.Canvas.TextOut(Rect.Left + nLeft, Rect.Top + nTop, Txt);
end;

procedure TfmFuzzy.RefreshGrid;
var
  StockIdx, DemandIdx: Integer;
  StockOwnerShip, DemandOwnerShip, ResultOwnerShip: Double;
begin
  if not Assigned(frmGrid) then
    Exit;

  frmGrid.GridFuzzy.RowCount := 2;
  frmGrid.GridFuzzy.Cells[0, 1] := '';
  frmGrid.GridFuzzy.Cells[1, 1] := '';
  frmGrid.GridFuzzy.Cells[2, 1] := '';
  frmGrid.GridFuzzy.Cells[3, 1] := '';
  frmGrid.Visible := True;

  for StockIdx := 0 to FuzzyStock.Members.Count - 1 do
    for DemandIdx := 0 to FuzzyDemand.Members.Count - 1 do
    begin
      if (frmGrid.GridFuzzy.RowCount <> 2) or (frmGrid.GridFuzzy.Cells[1, 1] <> '') then
        frmGrid.GridFuzzy.RowCount := frmGrid.GridFuzzy.RowCount + 1;

      frmGrid.GridFuzzy.Cells[0, frmGrid.GridFuzzy.RowCount - 1] := Format('Stock: %d, Demand: %d', [StockIdx, DemandIdx]);

      StockOwnerShip := FuzzyStock.OutPuts[StockIdx];
      DemandOwnerShip := FuzzyDemand.OutPuts[DemandIdx];

      if rbAverage.Checked then
        ResultOwnerShip := (StockOwnerShip + DemandOwnerShip) / 2
      else
        ResultOwnerShip := MaxValue([StockOwnerShip, DemandOwnerShip]);

      frmGrid.GridFuzzy.Cells[1, frmGrid.GridFuzzy.RowCount - 1] := FloatToStrF(StockOwnerShip, ffFixed, 5, 2);
      frmGrid.GridFuzzy.Cells[2, frmGrid.GridFuzzy.RowCount - 1] := FloatToStrF(DemandOwnerShip, ffFixed, 5, 2);
      frmGrid.GridFuzzy.Cells[3, frmGrid.GridFuzzy.RowCount - 1] := FloatToStrF(ResultOwnerShip, ffFixed, 5, 2);
    end;
end;

procedure TfmFuzzy.rbAverageClick(Sender: TObject);
begin
  RefreshGrid;
end;

end.

