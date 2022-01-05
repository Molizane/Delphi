unit uParking;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FuzzyComp, Grids, StdCtrls, zFuzzy, AlignEdit, Buttons;

type
  TForm1 = class(TForm)
    FuzzyDistancia: TzFuzzyfication;
    FuzzyAngulo: TzFuzzyfication;
    FuzzySolution: TzFuzzySolution;
    GridDefuzzy: TStringGrid;
    btnResult: TButton;
    rbAverage: TRadioButton;
    rbMax: TRadioButton;
    Label3: TLabel;
    lblDistanciaValor: TLabel;
    lblDistanciaLE: TLabel;
    lblDistanciaLC: TLabel;
    lblAnguloValor: TLabel;
    lblAnguloRB: TLabel;
    lblAnguloRU: TLabel;
    EditDistancia: TAlignEdit;
    EditAngulo: TAlignEdit;
    rbMin: TRadioButton;
    btnRegras: TBitBtn;
    Label6: TLabel;
    lblDistanciaCE: TLabel;
    lblDistanciaRC: TLabel;
    lblDistanciaRI: TLabel;
    lblAnguloRV: TLabel;
    lblAnguloVE: TLabel;
    lblAnguloLV: TLabel;
    lblAnguloLU: TLabel;
    lblAnguloLB: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure GridDefuzzyDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnResultClick(Sender: TObject);
    procedure FuzzyDistanciaChange(Sender: TObject);
    procedure FuzzyAnguloChange(Sender: TObject);
    procedure EditDistanciaEnter(Sender: TObject);
    procedure EditDistanciaExit(Sender: TObject);
    procedure btnRegrasClick(Sender: TObject);
  private
    vAnt: string;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Math;

const
  fuzDecl1: array[0..18] of string = (
    'LE', 'LC', 'CE', 'RC', 'RI',
    'RB', 'RU', 'RV', 'VE', 'LV', 'LU', 'LB',
    'NB', 'NM', 'NS', 'ZE', 'PS', 'PM', 'PB'
    );

  fuzDecl2: array[0..18] of string = (
    'Left', 'Left Center', 'Center', 'Right Center', 'Right',
    'Right Bottom', 'Right Under', 'Right Vertical', 'Vertical', 'Left Vertical', 'Left Under', 'Left Bottom',
    'Negative Bottom', 'Negative Middle', 'Negative Superior', 'Zero', 'Positive Superior', 'Positive Middle', 'Positive Bottom'
    );

function To_Str(s: string): string;
var
  i: Integer;
begin
  Result := s;

  Exit;

  for i := Low(fuzDecl1) to High(fuzDecl1) do
    if fuzDecl1[i] = s then
    begin
      Result := fuzDecl2[i];
      Exit;
    end;

  Result := '';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  GridDefuzzy.Cells[00, 00] := 'ø/x';
  GridDefuzzy.Cells[01, 00] := 'LE';
  GridDefuzzy.Cells[02, 00] := 'LC';
  GridDefuzzy.Cells[03, 00] := 'CE';
  GridDefuzzy.Cells[04, 00] := 'RC';
  GridDefuzzy.Cells[05, 00] := 'RI';
  GridDefuzzy.Cells[00, 01] := 'RB';
  GridDefuzzy.Cells[01, 01] := 'PS';
  GridDefuzzy.Cells[02, 01] := 'PM';
  GridDefuzzy.Cells[03, 01] := 'PM';
  GridDefuzzy.Cells[04, 01] := 'PB';
  GridDefuzzy.Cells[05, 01] := 'PB';
  GridDefuzzy.Cells[00, 02] := 'RU';
  GridDefuzzy.Cells[01, 02] := 'NS';
  GridDefuzzy.Cells[02, 02] := 'PS';
  GridDefuzzy.Cells[03, 02] := 'PM';
  GridDefuzzy.Cells[04, 02] := 'PB';
  GridDefuzzy.Cells[05, 02] := 'PB';
  GridDefuzzy.Cells[00, 03] := 'RV';
  GridDefuzzy.Cells[01, 03] := 'NM';
  GridDefuzzy.Cells[02, 03] := 'NS';
  GridDefuzzy.Cells[03, 03] := 'PS';
  GridDefuzzy.Cells[04, 03] := 'PM';
  GridDefuzzy.Cells[05, 03] := 'PB';
  GridDefuzzy.Cells[00, 04] := 'VE';
  GridDefuzzy.Cells[01, 04] := 'NM';
  GridDefuzzy.Cells[02, 04] := 'NM';
  GridDefuzzy.Cells[03, 04] := 'ZE';
  GridDefuzzy.Cells[04, 04] := 'PM';
  GridDefuzzy.Cells[05, 04] := 'PM';
  GridDefuzzy.Cells[00, 05] := 'LV';
  GridDefuzzy.Cells[01, 05] := 'NB';
  GridDefuzzy.Cells[02, 05] := 'NM';
  GridDefuzzy.Cells[03, 05] := 'NS';
  GridDefuzzy.Cells[04, 05] := 'PS';
  GridDefuzzy.Cells[05, 05] := 'PM';
  GridDefuzzy.Cells[00, 06] := 'LU';
  GridDefuzzy.Cells[01, 06] := 'NB';
  GridDefuzzy.Cells[02, 06] := 'NB';
  GridDefuzzy.Cells[03, 06] := 'NM';
  GridDefuzzy.Cells[04, 06] := 'NS';
  GridDefuzzy.Cells[05, 06] := 'PS';
  GridDefuzzy.Cells[00, 07] := 'LB';
  GridDefuzzy.Cells[01, 07] := 'NB';
  GridDefuzzy.Cells[02, 07] := 'NB';
  GridDefuzzy.Cells[03, 07] := 'NM';
  GridDefuzzy.Cells[04, 07] := 'NM';
  GridDefuzzy.Cells[05, 07] := 'NS';

  FuzzyDistancia.RealInput := 65;
  FuzzyAngulo.RealInput := 113;

  EditDistancia.Text := FormatFloat('0.000', FuzzyDistancia.RealInput);
  EditAngulo.Text := FormatFloat('0.000', FuzzyAngulo.RealInput);
end;

procedure TForm1.GridDefuzzyDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  nLeft, nTop: Integer;
  Txt: string;
begin
  if (ARow > 0) and (ACol > 0) then
  begin
    GridDefuzzy.Canvas.Brush.Color := GridDefuzzy.Color;
    GridDefuzzy.Canvas.Font.Color := clBlack;
  end;

  Txt := GridDefuzzy.Cells[ACol, ARow];

  //if (ARow = 0) or (ACol > 0) then
  nLeft := (Rect.Right - Rect.Left - GridDefuzzy.Canvas.TextWidth(Txt)) div 2
    //else
//  nLeft := 2
  ;

  nTop := (Rect.Bottom - Rect.Top - GridDefuzzy.Canvas.TextHeight('ÇÃ')) div 2;
  GridDefuzzy.Canvas.FillRect(Rect);
  GridDefuzzy.Canvas.TextOut(Rect.Left + nLeft, Rect.Top + nTop, Txt);
end;

procedure TForm1.btnResultClick(Sender: TObject);
var
  DistanciaIdx, AnguloIdx: Integer;
  DistanciaOwnerShip, AnguloOwnerShip, ResultOwnerShip: Double;
  AnguloVarFuzzyDescriptor: string;
  AnguloVarIndex: integer;
begin
  for DistanciaIdx := 1 to GridDefuzzy.ColCount - 1 do
    for AnguloIdx := 1 to GridDefuzzy.RowCount - 1 do
      GridDefuzzy.Cells[DistanciaIdx, AnguloIdx] := AnsiUpperCase(GridDefuzzy.Cells[DistanciaIdx, AnguloIdx]);

  FuzzySolution.ClearSolution;

  for DistanciaIdx := 0 to FuzzyDistancia.Members.Count - 1 do
  begin
    for AnguloIdx := 0 to FuzzyAngulo.Members.Count - 1 do
    begin
      DistanciaOwnerShip := FuzzyDistancia.OutPuts[DistanciaIdx];
      AnguloOwnerShip := FuzzyAngulo.OutPuts[AnguloIdx];

      if (DistanciaOwnerShip <> 0) and (AnguloOwnerShip <> 0) then //launching threshold
      begin
        if rbAverage.Checked then
          ResultOwnerShip := (DistanciaOwnerShip + AnguloOwnerShip) / 2
        else if rbMax.Checked then
          ResultOwnerShip := MaxValue([DistanciaOwnerShip, AnguloOwnerShip])
        else
          ResultOwnerShip := MinValue([DistanciaOwnerShip, AnguloOwnerShip]);

        AnguloVarFuzzyDescriptor := AnsiUpperCase(GridDefuzzy.Cells[DistanciaIdx + 1, AnguloIdx + 1]);
        GridDefuzzy.Cells[DistanciaIdx + 1, AnguloIdx + 1] := AnsiLowerCase(GridDefuzzy.Cells[DistanciaIdx + 1, AnguloIdx + 1]);
        GridDefuzzy.Row := AnguloIdx + 1;
        GridDefuzzy.Col := DistanciaIdx + 1;
        AnguloVarIndex := FuzzySolution.Members.GetMemberIndex(AnguloVarFuzzyDescriptor);
        FuzzySolution.FuzzyAgregate(AnguloVarIndex, ResultOwnerShip);
      end;
    end;
  end;

  Label3.Caption := FormatFloat(',0.00', FuzzySolution.RealOutput) + ' °';
  FuzzyAngulo.RealInput := FuzzyAngulo.RealInput + FuzzySolution.RealOutput;
end;

procedure TForm1.FuzzyDistanciaChange(Sender: TObject);
begin
  lblDistanciaValor.Caption := 'Valor=' + FloatToStrF(FuzzyDistancia.RealInput, ffFixed, 5, 3);
  lblDistanciaLE.Caption := 'LE=' + FloatToStrF(FuzzyDistancia.Outputs[0], ffFixed, 5, 3);
  lblDistanciaLC.Caption := 'LC=' + FloatToStrF(FuzzyDistancia.Outputs[1], ffFixed, 5, 3);
  lblDistanciaCE.Caption := 'CE=' + FloatToStrF(FuzzyDistancia.Outputs[2], ffFixed, 5, 3);
  lblDistanciaRC.Caption := 'RC=' + FloatToStrF(FuzzyDistancia.Outputs[3], ffFixed, 5, 3);
  lblDistanciaRI.Caption := 'RI=' + FloatToStrF(FuzzyDistancia.Outputs[4], ffFixed, 5, 3);
end;

procedure TForm1.FuzzyAnguloChange(Sender: TObject);
begin
  lblAnguloValor.Caption := 'Valor=' + FloatToStrF(FuzzyAngulo.RealInput, ffFixed, 5, 3);
  lblAnguloRB.Caption := 'RB=' + FloatToStrF(FuzzyAngulo.Outputs[0], ffFixed, 5, 3);
  lblAnguloRU.Caption := 'RU=' + FloatToStrF(FuzzyAngulo.Outputs[1], ffFixed, 5, 3);
  lblAnguloRV.Caption := 'RV=' + FloatToStrF(FuzzyAngulo.Outputs[2], ffFixed, 5, 3);
  lblAnguloVE.Caption := 'VE=' + FloatToStrF(FuzzyAngulo.Outputs[3], ffFixed, 5, 3);
  lblAnguloLV.Caption := 'LV=' + FloatToStrF(FuzzyAngulo.Outputs[4], ffFixed, 5, 3);
  lblAnguloLU.Caption := 'LU=' + FloatToStrF(FuzzyAngulo.Outputs[5], ffFixed, 5, 3);
  lblAnguloLB.Caption := 'LB=' + FloatToStrF(FuzzyAngulo.Outputs[6], ffFixed, 5, 3);
end;

procedure TForm1.EditDistanciaEnter(Sender: TObject);
begin
  vAnt := TAlignEdit(Sender).Text;
end;

procedure TForm1.EditDistanciaExit(Sender: TObject);
var
  v: Double;
begin
  v := RoundVal(StrToFloat(TAlignEdit(Sender).Text), 3);
  TAlignEdit(Sender).Text := FormatFloat('0.000', v);

  //if vAnt <> TAlignEdit(Sender).Text then
  if Sender = EditDistancia then
    if FuzzyDistancia.RealInput <> v then
      FuzzyDistancia.RealInput := v
    else
  else if FuzzyAngulo.RealInput <> v then
    FuzzyAngulo.RealInput := v;
end;

procedure TForm1.btnRegrasClick(Sender: TObject);
var
  DistanciaIdx, AnguloIdx: Integer;
  F: TextFile;
begin
  AssignFile(F, 'Regras.txt');
  Rewrite(F);

  try
    for AnguloIdx := 1 to GridDefuzzy.RowCount - 1 do
      for DistanciaIdx := 1 to GridDefuzzy.ColCount - 1 do
      begin
        Write(F, 'Se angulo ø = "' + To_Str(GridDefuzzy.Cells[0, AnguloIdx]));
        Write(F, '" e distancia x = "' + To_Str(GridDefuzzy.Cells[DistanciaIdx, 0]));
        WriteLn(F, '", então angulo Ø = "' + To_Str(AnsiUpperCase(GridDefuzzy.Cells[DistanciaIdx, AnguloIdx])) + '"');
      end;
  finally
    CloseFile(F);
  end;
end;

end.

