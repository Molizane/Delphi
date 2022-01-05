unit uFuzzyMotor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, Grids, Gauges, ExtCtrls, MShape, zFuzzy;

type
  TfrmFuzzyMotor = class(TForm)
    edtSpeed: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    edtVoltage: TEdit;
    Bevel2: TBevel;
    Bevel1: TGroupBox;
    SpeedLevel: TGauge;
    Label2: TLabel;
    edComp: TEdit;
    StaticText1: TStaticText;
    FuzzySpeed: TzFuzzyfication;
    FuzzyVoltage: TzFuzzyfication;
    pnlFuzzySpeed: TPanel;
    Panel2: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    FAM: TStringGrid;
    bGetValue: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure SpeedVarChange(Sender: TObject);
    procedure bGetValueClick(Sender: TObject);
    procedure FuzzySpeedChange(Sender: TObject);
    procedure FuzzyVoltageChange(Sender: TObject);
    procedure edtSpeedEnter(Sender: TObject);
    procedure edtSpeedExit(Sender: TObject);
    procedure edtVoltageExit(Sender: TObject);
    procedure FAMDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
  private
    ValAnt: Real;
  public
    MotorVar: TzFuzzySolution;
    pnlMotorVar: TPanel;
  end;

var
  frmFuzzyMotor: TfrmFuzzyMotor;

implementation

uses
  Types;

{$R *.DFM}

procedure TfrmFuzzyMotor.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  edtSpeed.Text := FloatToStrF(FuzzySpeed.RealInput, ffFixed, 5, 2);
  edtVoltage.Text := FloatToStrF(FuzzyVoltage.RealInput, ffFixed, 5, 2);

  FAM.Cells[0, 0] := 'Ve(d)/Va(p)';
  FAM.Cells[1, 0] := 'MI';
  FAM.Cells[2, 0] := 'MME';
  FAM.Cells[3, 0] := 'MP';
  FAM.Cells[4, 0] := '+/-P';
  FAM.Cells[5, 0] := 'PP';
  FAM.Cells[6, 0] := 'ME';
  FAM.Cells[7, 0] := 'PG';
  FAM.Cells[8, 0] := '+/-G';
  FAM.Cells[9, 0] := 'MG';
  FAM.Cells[10, 0] := 'MMA';
  FAM.Cells[11, 0] := 'MX';

  FAM.Cells[0, 1] := 'MI';
  FAM.Cells[1, 1] := 'MI';
  FAM.Cells[2, 1] := 'MI';
  FAM.Cells[3, 1] := 'MME';
  FAM.Cells[4, 1] := 'MME';
  FAM.Cells[5, 1] := 'MME';
  FAM.Cells[6, 1] := 'MME';
  FAM.Cells[7, 1] := 'MP';
  FAM.Cells[8, 1] := 'MP';
  FAM.Cells[9, 1] := '+/-P';
  FAM.Cells[10, 1] := 'PP';
  FAM.Cells[11, 1] := '+/-G';

  FAM.Cells[0, 2] := 'MME';
  FAM.Cells[1, 2] := 'MME';
  FAM.Cells[2, 2] := 'MME';
  FAM.Cells[3, 2] := 'MI';
  FAM.Cells[4, 2] := 'MI';
  FAM.Cells[5, 2] := 'MI';
  FAM.Cells[6, 2] := 'MME';
  FAM.Cells[7, 2] := 'MME';
  FAM.Cells[8, 2] := 'MME';
  FAM.Cells[9, 2] := 'MME';
  FAM.Cells[10, 2] := 'MP';
  FAM.Cells[11, 2] := 'ME';

  FAM.Cells[0, 3] := 'MP';
  FAM.Cells[1, 3] := 'MP';
  FAM.Cells[2, 3] := 'MP';
  FAM.Cells[3, 3] := 'MME';
  FAM.Cells[4, 3] := 'MME';
  FAM.Cells[5, 3] := 'MME';
  FAM.Cells[6, 3] := 'MME';
  FAM.Cells[7, 3] := 'MI';
  FAM.Cells[8, 3] := 'MI';
  FAM.Cells[9, 3] := 'MME';
  FAM.Cells[10, 3] := 'MME';
  FAM.Cells[11, 3] := 'ME';

  FAM.Cells[0, 4] := '+/-P';
  FAM.Cells[1, 4] := '+/-P';
  FAM.Cells[2, 4] := '+/-P';
  FAM.Cells[3, 4] := '+/-P';
  FAM.Cells[4, 4] := 'MP';
  FAM.Cells[5, 4] := 'MP';
  FAM.Cells[6, 4] := 'MP';
  FAM.Cells[7, 4] := 'MME';
  FAM.Cells[8, 4] := 'MME';
  FAM.Cells[9, 4] := 'MI';
  FAM.Cells[10, 4] := 'MME';
  FAM.Cells[11, 4] := 'MP';

  FAM.Cells[0, 5] := 'PP';
  FAM.Cells[1, 5] := 'PP';
  FAM.Cells[2, 5] := '+/-P';
  FAM.Cells[3, 5] := '+/-P';
  FAM.Cells[4, 5] := '+/-P';
  FAM.Cells[5, 5] := '+/-P';
  FAM.Cells[6, 5] := '+/-P';
  FAM.Cells[7, 5] := 'MP';
  FAM.Cells[8, 5] := 'MP';
  FAM.Cells[9, 5] := 'MME';
  FAM.Cells[10, 5] := 'MI';
  FAM.Cells[11, 5] := '+/-P';

  FAM.Cells[0, 6] := 'ME';
  FAM.Cells[1, 6] := 'ME';
  FAM.Cells[2, 6] := 'PP';
  FAM.Cells[3, 6] := 'PP';
  FAM.Cells[4, 6] := 'PP';
  FAM.Cells[5, 6] := 'PP';
  FAM.Cells[6, 6] := '+/-P';
  FAM.Cells[7, 6] := '+/-P';
  FAM.Cells[8, 6] := '+/-P';
  FAM.Cells[9, 6] := 'MP';
  FAM.Cells[10, 6] := 'MP';
  FAM.Cells[11, 6] := 'MP';

  FAM.Cells[0, 7] := 'PG';
  FAM.Cells[1, 7] := 'PG';
  FAM.Cells[2, 7] := 'PG';
  FAM.Cells[3, 7] := 'ME';
  FAM.Cells[4, 7] := 'ME';
  FAM.Cells[5, 7] := 'ME';
  FAM.Cells[6, 7] := 'PP';
  FAM.Cells[7, 7] := 'PP';
  FAM.Cells[8, 7] := 'PP';
  FAM.Cells[9, 7] := '+/-P';
  FAM.Cells[10, 7] := '+/-P';
  FAM.Cells[11, 7] := 'MME';

  FAM.Cells[0, 8] := '+/-G';
  FAM.Cells[1, 8] := 'PG';
  FAM.Cells[2, 8] := 'PG';
  FAM.Cells[3, 8] := 'PG';
  FAM.Cells[4, 8] := 'PG';
  FAM.Cells[5, 8] := 'ME';
  FAM.Cells[6, 8] := 'ME';
  FAM.Cells[7, 8] := 'ME';
  FAM.Cells[8, 8] := 'PP';
  FAM.Cells[9, 8] := 'PP';
  FAM.Cells[10, 8] := '+/-P';
  FAM.Cells[11, 8] := 'MI';

  FAM.Cells[0, 9] := 'MG';
  FAM.Cells[1, 9] := '+/-G';
  FAM.Cells[2, 9] := '+/-G';
  FAM.Cells[3, 9] := '+/-G';
  FAM.Cells[4, 9] := 'PG';
  FAM.Cells[5, 9] := 'PG';
  FAM.Cells[6, 9] := 'PG';
  FAM.Cells[7, 9] := 'PG';
  FAM.Cells[8, 9] := 'ME';
  FAM.Cells[9, 9] := 'ME';
  FAM.Cells[10, 9] := 'PP';
  FAM.Cells[11, 9] := 'MME';

  FAM.Cells[0, 10] := 'MMA';
  FAM.Cells[1, 10] := 'MG';
  FAM.Cells[2, 10] := 'MG';
  FAM.Cells[3, 10] := 'MG';
  FAM.Cells[4, 10] := 'MG';
  FAM.Cells[5, 10] := '+/-G';
  FAM.Cells[6, 10] := '+/-G';
  FAM.Cells[7, 10] := '+/-G';
  FAM.Cells[8, 10] := 'PG';
  FAM.Cells[9, 10] := 'PG';
  FAM.Cells[10, 10] := 'ME';
  FAM.Cells[11, 10] := 'MP';

  FAM.Cells[0, 11] := 'MX';
  FAM.Cells[1, 11] := 'MMA';
  FAM.Cells[2, 11] := 'MMA';
  FAM.Cells[3, 11] := 'MMA';
  FAM.Cells[4, 11] := 'MG';
  FAM.Cells[5, 11] := 'MG';
  FAM.Cells[6, 11] := 'MG';
  FAM.Cells[7, 11] := 'MG';
  FAM.Cells[8, 11] := '+/-G';
  FAM.Cells[9, 11] := '+/-G';
  FAM.Cells[10, 11] := 'PG';
  FAM.Cells[11, 11] := '+/-P';

  FAM.ColWidths[0] := FAM.Canvas.TextWidth(FAM.Cells[0, 0] + '    ');

  pnlMotorVar :=  TPanel.Create(Self);

  with pnlMotorVar do
  begin
    Parent := Self;
    Left := pnlFuzzySpeed.Left;
    Top := Bevel1.Top + Bevel1.Height + 15;
    AutoSize := true;
    BevelInner := bvRaised;
    BevelOuter := bvLowered;
    BevelWidth := 2;
    Caption := ' ';
  end;

  MotorVar := TzFuzzySolution.Create(Self);

  with MotorVar do
  begin
    Parent := pnlMotorVar;
    FuzzyName := 'Acréscimo de Tensão (Volts)';
    Left := 0;
    Top := 0;
    Width := FuzzySpeed.Width;
    Height := FuzzySpeed.Height;
    Members.Clear;
    Mini := -24;
    Maxi := 264;
    AddMember('MI', -24, 0, 24, 0, tmLInfinity);
    AddMember('MME', 0, 24, 48, 0, tmTriangle);
    AddMember('MP', 24, 48, 72, 0, tmTriangle);
    AddMember('+/-P', 48, 72, 96, 0, tmTriangle);
    AddMember('PP', 72, 96, 120, 0, tmTriangle);
    AddMember('ME', 96, 120, 144, 0, tmTriangle);
    AddMember('PG', 120, 144, 168, 0, tmTriangle);
    AddMember('+/-G', 144, 168, 192, 0, tmTriangle);
    AddMember('MG', 168, 192, 216, 0, tmTriangle);
    AddMember('MMA', 192, 216, 240, 0, tmTriangle);
    AddMember('MX', 216, 240, 264, 0, tmRInfinity);
    OnChange := SpeedVarChange;
  end;
end;

procedure TfrmFuzzyMotor.SpeedVarChange(Sender: TObject);
begin
  edComp.Text := FloatToStrF(MotorVar.Compatibility, ffFixed, 5, 2);
end;

procedure TfrmFuzzyMotor.bGetValueClick(Sender: TObject);
var
  SpeedIdx, VoltageIdx: Integer;
  SpeedOwnerShip, VoltageOwnerShip, AverageOwnerShip: Single;
  SpeedVarFuzzyDescriptor: string;
  SpeedVarIndex: Integer;
  MaxAverage: single;
begin
  MaxAverage := 0;
  MotorVar.ClearSolution;

  for SpeedIdx := 0 to FuzzySpeed.Members.Count - 1 do
    for VoltageIdx := 0 to FuzzyVoltage.Members.Count - 1 do
    begin
      SpeedOwnerShip := FuzzySpeed.OutPuts[SpeedIdx];
      VoltageOwnerShip := FuzzyVoltage.OutPuts[VoltageIdx];
      AverageOwnerShip := (SpeedOwnerShip + VoltageOwnerShip) / 2;
      // OR AverageOwnerShip := MaxValue([SpeedOwnerShip, VoltageOwnerShip]);
      
      if AverageOwnerShip > MaxAverage then
        MaxAverage := AverageOwnerShip;

      if (SpeedOwnerShip > 0) and (VoltageOwnerShip > 0) then //launching threshold
      begin
        SpeedVarFuzzyDescriptor := FAM.Cells[SpeedIdx + 1, VoltageIdx + 1];
        FAM.Row := VoltageIdx + 1;
        FAM.Col := SpeedIdx + 1;
        SpeedVarIndex := MotorVar.Members.GetMemberIndex(SpeedVarFuzzyDescriptor);
        MotorVar.FuzzyAgregate(SpeedVarIndex, AverageOwnerShip);
      end;
    end;

  SpeedLevel.Progress := SpeedLevel.Progress + round(MotorVar.RealOutput);
  FuzzySpeed.RealInput := SpeedLevel.Progress;
end;

procedure TfrmFuzzyMotor.FuzzySpeedChange(Sender: TObject);
begin
  edtSpeed.Text := FloatToStrF(FuzzySpeed.RealInput, ffFixed, 5, 2);
  SpeedLevel.Progress := Round(FuzzySpeed.RealInput);
end;

procedure TfrmFuzzyMotor.FuzzyVoltageChange(Sender: TObject);
begin
  edtVoltage.Text := FloatToStrF(FuzzyVoltage.RealInput, ffFixed, 5, 2);
end;

procedure TfrmFuzzyMotor.edtSpeedEnter(Sender: TObject);
begin
  ValAnt := StrToFloatDef(TEdit(Sender).Text, 0);
end;

procedure TfrmFuzzyMotor.edtSpeedExit(Sender: TObject);
var
  ValAtual: Real;
begin
  ValAtual := StrToFloatDef(edtSpeed.Text, 0);

  if ValAnt <> ValAtual then
    FuzzySpeed.RealInput := ValAtual;
end;

procedure TfrmFuzzyMotor.edtVoltageExit(Sender: TObject);
var
  ValAtual: Real;
begin
  ValAtual := StrToFloatDef(edtVoltage.Text, 0);

  if ValAnt <> ValAtual then
    FuzzyVoltage.RealInput := ValAtual;
end;

procedure TfrmFuzzyMotor.FAMDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  nTop, nLeft: Integer;
begin
  if FAM.Cells[ACol, ARow] = '' then
    Exit;

  nTop := (Rect.Bottom - Rect.Top - FAM.Canvas.TextHeight(FAM.Cells[ACol, ARow])) div 2;
  nLeft := (Rect.Right - Rect.Left - FAM.Canvas.TextWidth(FAM.Cells[ACol, ARow])) div 2;

  FAM.Canvas.FillRect(Rect);
  FAM.Canvas.TextOut(Rect.Left + nLeft, Rect.Top + nTop, FAM.Cells[ACol, ARow]);
end;

end.

