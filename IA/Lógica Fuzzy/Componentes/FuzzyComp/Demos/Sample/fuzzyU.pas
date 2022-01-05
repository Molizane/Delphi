//*****************************************************************
//   Application : Example of use of Fuzzy Components
//                 Fuzzy Stock Management
//   by Alexandre Beauvois 14/06/1998
//   Advice : If you never heard about Fuzzy Logic you should go
//            to http://www.a-w.de/FOODOPT/ARTIKEL/fnrchp00.htm
//   How to Use : Change the Demand by clicking(at run time)
//                on the demand Component and Click on the
//                the result button many times. The Stock
//                will be stabilized...
//*****************************************************************

unit fuzzyU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FuzzyComp, StdCtrls, ComCtrls, Buttons, Grids, Gauges, ExtCtrls, MShape;

type
  TfmFuzzy = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    FAM: TStringGrid;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    StockLevel: TGauge;
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    edComp: TEdit;
    Label2: TLabel;
    Bevel2: TBevel;
    StaticText1: TStaticText;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    MultiShape1: TMultiShape;
    Panel1: TPanel;
    FuzzyDemand: TFuzzyfication;
    FuzzyStock: TFuzzyfication;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure StockVarChange(Sender: TObject);
    procedure bGetValueClick(Sender: TObject);
    procedure FuzzyStockChange(Sender: TObject);
    procedure FuzzyDemandChange(Sender: TObject);
  private
  public
    StockVar: TFuzzySolution;
  end;

var
  fmFuzzy: TfmFuzzy;

implementation

{$R *.DFM}

procedure TfmFuzzy.FormCreate(Sender: TObject);
var
  i: integer;
begin
  {
  Fuzzy3 := TDefuzzyfication.create(Self);
  }
  Edit1.Text := FloatToStrF(FuzzyStock.RealInput, ffFixed, 5, 2);
  Edit3.Text := FloatToStrF(FuzzyDemand.RealInput, ffFixed, 5, 2);
  FAM.cells[0, 0] := 'StkV';
  FAM.cells[0, 1] := 'Low';
  FAM.cells[0, 2] := 'Medium';
  FAM.cells[0, 3] := 'Important';
  FAM.cells[1, 0] := 'Low';
  FAM.cells[2, 0] := 'Medium';
  FAM.cells[3, 0] := 'Important';
  {Datas}
  FAM.cells[1, 1] := 'NL';
  FAM.cells[2, 2] := 'NL';
  FAM.cells[3, 3] := 'NL';
  FAM.cells[1, 2] := 'QP';
  FAM.cells[2, 1] := 'QN';
  FAM.cells[2, 3] := 'QP';
  FAM.cells[3, 2] := 'QN';
  FAM.cells[1, 3] := 'VP';
  FAM.cells[3, 1] := 'VN';

  for i := 1 to 3 do
    FuzzyStock.Members[i - 1].Name := FAM.cells[0, i];

  for i := 1 to 3 do
    FuzzyDemand.Members[i - 1].Name := FAM.cells[i, 0];

  StockVar := TFuzzySolution.Create(Self);

  with StockVar do
  begin
    Left := 514;
    Top := 53;
    Members.Clear;
    addMember('VN', -40, -60, tmLInfinity);
    addMember('QN', -20, -40, tmTriangle);
    addMember('NL', 0, -20, tmTriangle);
    addMember('QP', 20, 0, tmTriangle);
    addMember('VP', 40, 20, tmRInfinity);
    Maxi := 60;
    OnChange := StockVarChange;
  end;
end;

procedure TfmFuzzy.StockVarChange(Sender: TObject);
begin
  edComp.text := FloatToStrF(StockVar.Compatibility, ffFixed, 5, 2);
end;

procedure TfmFuzzy.bGetValueClick(Sender: TObject);
var
  StockIdx, DemandIdx: Integer;
  StockOwnerShip, DemandOwnerShip, AverageOwnerShip: Single;
  StockVarFuzzyDescriptor: string;
  StockVarIndex: integer;
  MaxAverage: single;
begin
  MaxAverage := 0;
  StockVar.ClearSolution;

  for StockIdx := 0 to FuzzyStock.Members.count - 1 do
    for DemandIdx := 0 to FuzzyDemand.Members.Count - 1 do
    begin
      StockOwnerShip := FuzzyStock.OutPuts[StockIdx];
      DemandOwnerShip := FuzzyDemand.OutPuts[DemandIdx];
      AverageOwnerShip := (StockOwnerShip + DemandOwnerShip) / 2;
      // OR AverageOwnerShip:=MaxValue([StockOwnerShip,DemandOwnerShip]);

      if AverageOwnerShip > MaxAverage then MaxAverage := AverageOwnerShip;

      if (StockOwnerShip > 0) and (DemandOwnerShip > 0) then //launching threshold
      begin
        StockVarFuzzyDescriptor := FAM.Cells[StockIdx + 1, DemandIdx + 1];
        FAM.row := DemandIdx + 1;
        FAM.col := StockIdx + 1;
        StockVarIndex := StockVar.Members.GetMemberIndex(StockVarFuzzyDescriptor);
        StockVar.FuzzyAgregate(StockVarIndex, AverageOwnerShip);
        //showmessage('Next Rule');
      end;
    end;

  StockLevel.Progress := StockLevel.Progress + round(StockVar.RealOutput);
  FuzzyStock.RealInput := StockLevel.Progress;
end;

procedure TfmFuzzy.FuzzyStockChange(Sender: TObject);
begin
  Edit1.Text := FloatToStrF(FuzzyStock.RealInput, ffFixed, 5, 2);
  StockLevel.Progress := round(FuzzyStock.RealInput);
  {
  bGetValueClick(self);
  }
end;

procedure TfmFuzzy.FuzzyDemandChange(Sender: TObject);
begin
  Edit3.Text := FloatToStrF(FuzzyDemand.RealInput, ffFixed, 5, 2);
  {
  bGetValueClick(self);
  }
end;

end.

