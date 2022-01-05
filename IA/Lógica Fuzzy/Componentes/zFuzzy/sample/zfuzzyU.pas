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

unit zfuzzyU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Grids, Gauges, ExtCtrls, MShape, zFuzzy;

type
  TfmFuzzy = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    StockLevel: TGauge;
    edComp: TStaticText;
    Label2: TLabel;
    Bevel2: TBevel;
    StaticText1: TStaticText;
    Shape1: TMultiShape;
    Shape2: TMultiShape;
    Shape3: TMultiShape;
    Shape4: TMultiShape;
    MultiShape1: TMultiShape;
    Panel1: TPanel;
    FuzzyDemand: TzFuzzyfication;
    FuzzyStock: TzFuzzyfication;
    Bevel1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    FAM: TStringGrid;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure StockVarChange(Sender: TObject);
    procedure bGetValueClick(Sender: TObject);
    procedure FuzzyStockChange(Sender: TObject);
    procedure FuzzyDemandChange(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
  private
    ValAnt: Real;
  public
    StockVar: TzFuzzySolution;
  end;

var
  fmFuzzy: TfmFuzzy;

implementation

{$R *.DFM}

procedure TfmFuzzy.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Edit1.Text := FloatToStrF(FuzzyStock.RealInput, ffFixed, 5, 2);
  Edit3.Text := FloatToStrF(FuzzyDemand.RealInput, ffFixed, 5, 2);
  FAM.Cells[0, 0] := 'StkV';
  FAM.Cells[0, 1] := 'Low';
  FAM.Cells[0, 2] := 'Medium';
  FAM.Cells[0, 3] := 'Important';
  FAM.Cells[1, 0] := 'Low';
  FAM.Cells[2, 0] := 'Medium';
  FAM.Cells[3, 0] := 'Important';

  {Datas}
  FAM.Cells[1, 1] := 'NL';
  FAM.Cells[2, 2] := 'NL';
  FAM.Cells[3, 3] := 'NL';
  FAM.Cells[1, 2] := 'QP';
  FAM.Cells[2, 1] := 'QN';
  FAM.Cells[2, 3] := 'QP';
  FAM.Cells[3, 2] := 'QN';
  FAM.Cells[1, 3] := 'VP';
  FAM.Cells[3, 1] := 'VN';

  for i := 1 to 3 do
    FuzzyStock.Members[i - 1].Name := FAM.Cells[0, i];

  for i := 1 to 3 do
    FuzzyDemand.Members[i - 1].Name := FAM.Cells[i, 0];

  StockVar := TzFuzzySolution.Create(Self);

  with StockVar do
  begin
    FuzzyName := 'Stock variation';
    Brush.Color := clBtnface;
    Left := 593;
    Top := 32;
    Width := 269;
    Height := 100;
    Members.Clear;
    AddMember('VN', -60, -40, -20, 0, tmLInfinity);
    AddMember('QN', 0, -20, -40, 0, tmTriangle);
    AddMember('NL', 20, 0, -20, 0, tmTriangle);
    AddMember('QP', 40, 20, 0, 0, tmTriangle);
    AddMember('VP', 60, 40, 20, 0, tmRInfinity);
    Maxi := 60;
    OnChange := StockVarChange;
  end;
end;

procedure TfmFuzzy.StockVarChange(Sender: TObject);
begin
  edComp.Caption := FloatToStrF(StockVar.Compatibility, ffFixed, 5, 2) + ' ';
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

  for StockIdx := 0 to FuzzyStock.Members.Count - 1 do
    for DemandIdx := 0 to FuzzyDemand.Members.Count - 1 do
    begin
      StockOwnerShip := FuzzyStock.OutPuts[StockIdx];
      DemandOwnerShip := FuzzyDemand.OutPuts[DemandIdx];
      AverageOwnerShip := (StockOwnerShip + DemandOwnerShip) / 2;
      // OR AverageOwnerShip := MaxValue([StockOwnerShip, DemandOwnerShip]);

      if AverageOwnerShip > MaxAverage then
        MaxAverage := AverageOwnerShip;

      if (StockOwnerShip > 0) and (DemandOwnerShip > 0) then //launching threshold
      begin
        StockVarFuzzyDescriptor := FAM.Cells[StockIdx + 1, DemandIdx + 1];
        FAM.Row := DemandIdx + 1;
        FAM.Col := StockIdx + 1;
        StockVarIndex := StockVar.Members.GetMemberIndex(StockVarFuzzyDescriptor);
        StockVar.FuzzyAgregate(StockVarIndex, AverageOwnerShip);
      end;
    end;

  StockLevel.Progress := StockLevel.Progress + round(StockVar.RealOutput);
  FuzzyStock.RealInput := StockLevel.Progress;
end;

procedure TfmFuzzy.FuzzyStockChange(Sender: TObject);
begin
  Edit1.Text := FloatToStrF(FuzzyStock.RealInput, ffFixed, 5, 2);
  StockLevel.Progress := Round(FuzzyStock.RealInput);
end;

procedure TfmFuzzy.FuzzyDemandChange(Sender: TObject);
begin
  Edit3.Text := FloatToStrF(FuzzyDemand.RealInput, ffFixed, 5, 2);
end;

procedure TfmFuzzy.Edit1Enter(Sender: TObject);
begin
  ValAnt := StrToFloatDef(TEdit(Sender).Text, 0);
end;

procedure TfmFuzzy.Edit1Exit(Sender: TObject);
var
  ValAtual: Real;
begin
  ValAtual := StrToFloatDef(Edit1.Text, 0);

  if valAnt <> ValAtual then
    FuzzyStock.RealInput := ValAtual;
end;

procedure TfmFuzzy.Edit3Exit(Sender: TObject);
var
  ValAtual: Real;
begin
  ValAtual := StrToFloatDef(Edit3.Text, 0);

  if valAnt <> ValAtual then
    FuzzyDemand.RealInput := ValAtual;
end;

end.

