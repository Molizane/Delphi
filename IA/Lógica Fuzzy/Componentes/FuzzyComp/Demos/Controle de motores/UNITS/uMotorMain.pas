unit uMotorMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FuzzyComp, Grids, StdCtrls, AlignEdit;

type
  TForm1 = class(TForm)
    FuzzyVelocidade: TFuzzyfication;
    FuzzyTensao: TFuzzyfication;
    FuzzySolution: TFuzzySolution;
    GridFuzzy: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    btnResult: TButton;
    rbAverage: TRadioButton;
    rbMin: TRadioButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblVelocidade1: TLabel;
    lblTensao1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblVelocidadeMI: TLabel;
    lblVelocidadeMME: TLabel;
    lblVelocidadeMP: TLabel;
    lblVelocidadeMMP: TLabel;
    lblVelocidadePP: TLabel;
    lblVelocidadeME: TLabel;
    lblVelocidadePG: TLabel;
    lblVelocidadeMMG: TLabel;
    lblVelocidadeMG: TLabel;
    lblVelocidadeMMA: TLabel;
    lblVelocidadeMX: TLabel;
    lblTensaoMI: TLabel;
    lblTensaoMME: TLabel;
    lblTensaoMP: TLabel;
    lblTensaoMMP: TLabel;
    lblTensaoPP: TLabel;
    lblTensaoME: TLabel;
    lblTensaoPG: TLabel;
    lblTensaoMMG: TLabel;
    lblTensaoMG: TLabel;
    lblTensaoMMA: TLabel;
    lblTensaoMX: TLabel;
    AlignEdit1: TAlignEdit;
    AlignEdit2: TAlignEdit;
    procedure FormCreate(Sender: TObject);
    procedure GridFuzzyDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnResultClick(Sender: TObject);
    procedure FuzzyVelocidadeChange(Sender: TObject);
    procedure FuzzyTensaoChange(Sender: TObject);
    procedure AlignEdit1Enter(Sender: TObject);
    procedure AlignEdit1Exit(Sender: TObject);
    procedure AlignEdit2Exit(Sender: TObject);
  private
    VAnt: string;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Math;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //GridFuzzy.Cells[00, 00] := 'Ve(d)/Va(p)';
  GridFuzzy.Cells[00, 00] := '';
  GridFuzzy.Cells[01, 00] := 'MI';
  GridFuzzy.Cells[02, 00] := 'MME';
  GridFuzzy.Cells[03, 00] := 'MP';
  GridFuzzy.Cells[04, 00] := '+/-P';
  GridFuzzy.Cells[05, 00] := 'PP';
  GridFuzzy.Cells[06, 00] := 'ME';
  GridFuzzy.Cells[07, 00] := 'PG';
  GridFuzzy.Cells[08, 00] := '+/-G';
  GridFuzzy.Cells[09, 00] := 'MG';
  GridFuzzy.Cells[10, 00] := 'MMA';
  GridFuzzy.Cells[11, 00] := 'MX';
  GridFuzzy.Cells[00, 01] := 'MI';
  GridFuzzy.Cells[01, 01] := 'MI';
  GridFuzzy.Cells[02, 01] := 'MI';
  GridFuzzy.Cells[03, 01] := 'MME';
  GridFuzzy.Cells[04, 01] := 'MME';
  GridFuzzy.Cells[05, 01] := 'MME';
  GridFuzzy.Cells[06, 01] := 'MME';
  GridFuzzy.Cells[07, 01] := 'MP';
  GridFuzzy.Cells[08, 01] := 'MP';
  GridFuzzy.Cells[09, 01] := '+/-P';
  GridFuzzy.Cells[10, 01] := 'PP';
  GridFuzzy.Cells[11, 01] := '+/-G';
  GridFuzzy.Cells[00, 02] := 'MME';
  GridFuzzy.Cells[01, 02] := 'MME';
  GridFuzzy.Cells[02, 02] := 'MME';
  GridFuzzy.Cells[03, 02] := 'MI';
  GridFuzzy.Cells[04, 02] := 'MI';
  GridFuzzy.Cells[05, 02] := 'MI';
  GridFuzzy.Cells[06, 02] := 'MME';
  GridFuzzy.Cells[07, 02] := 'MME';
  GridFuzzy.Cells[08, 02] := 'MME';
  GridFuzzy.Cells[09, 02] := 'MME';
  GridFuzzy.Cells[10, 02] := 'MP';
  GridFuzzy.Cells[11, 02] := 'ME';
  GridFuzzy.Cells[00, 03] := 'MP';
  GridFuzzy.Cells[01, 03] := 'MP';
  GridFuzzy.Cells[02, 03] := 'MP';
  GridFuzzy.Cells[03, 03] := 'MME';
  GridFuzzy.Cells[04, 03] := 'MME';
  GridFuzzy.Cells[05, 03] := 'MME';
  GridFuzzy.Cells[06, 03] := 'MME';
  GridFuzzy.Cells[07, 03] := 'MI';
  GridFuzzy.Cells[08, 03] := 'MI';
  GridFuzzy.Cells[09, 03] := 'MME';
  GridFuzzy.Cells[10, 03] := 'MME';
  GridFuzzy.Cells[11, 03] := 'ME';
  GridFuzzy.Cells[00, 04] := '+/-P';
  GridFuzzy.Cells[01, 04] := '+/-P';
  GridFuzzy.Cells[02, 04] := '+/-P';
  GridFuzzy.Cells[03, 04] := '+/-P';
  GridFuzzy.Cells[04, 04] := 'MP';
  GridFuzzy.Cells[05, 04] := 'MP';
  GridFuzzy.Cells[06, 04] := 'MP';
  GridFuzzy.Cells[07, 04] := 'MME';
  GridFuzzy.Cells[08, 04] := 'MME';
  GridFuzzy.Cells[09, 04] := 'MI';
  GridFuzzy.Cells[10, 04] := 'MME';
  GridFuzzy.Cells[11, 04] := 'PP';
  GridFuzzy.Cells[00, 05] := 'PP';
  GridFuzzy.Cells[01, 05] := 'PP';
  GridFuzzy.Cells[02, 05] := '+/-P';
  GridFuzzy.Cells[03, 05] := '+/-P';
  GridFuzzy.Cells[04, 05] := '+/-P';
  GridFuzzy.Cells[05, 05] := '+/-P';
  GridFuzzy.Cells[06, 05] := '+/-P';
  GridFuzzy.Cells[07, 05] := 'MP';
  GridFuzzy.Cells[08, 05] := 'MP';
  GridFuzzy.Cells[09, 05] := 'MME';
  GridFuzzy.Cells[10, 05] := 'MI';
  GridFuzzy.Cells[11, 05] := '+/-P';
  GridFuzzy.Cells[00, 06] := 'ME';
  GridFuzzy.Cells[01, 06] := 'ME';
  GridFuzzy.Cells[02, 06] := 'PP';
  GridFuzzy.Cells[03, 06] := 'PP';
  GridFuzzy.Cells[04, 06] := 'PP';
  GridFuzzy.Cells[05, 06] := 'PP';
  GridFuzzy.Cells[06, 06] := '+/-P';
  GridFuzzy.Cells[07, 06] := '+/-P';
  GridFuzzy.Cells[08, 06] := '+/-P';
  GridFuzzy.Cells[09, 06] := 'MP';
  GridFuzzy.Cells[10, 06] := 'MP';
  GridFuzzy.Cells[11, 06] := 'MP';
  GridFuzzy.Cells[00, 07] := 'PG';
  GridFuzzy.Cells[01, 07] := 'PG';
  GridFuzzy.Cells[02, 07] := 'PG';
  GridFuzzy.Cells[03, 07] := 'ME';
  GridFuzzy.Cells[04, 07] := 'ME';
  GridFuzzy.Cells[05, 07] := 'ME';
  GridFuzzy.Cells[06, 07] := 'PP';
  GridFuzzy.Cells[07, 07] := 'PP';
  GridFuzzy.Cells[08, 07] := 'PP';
  GridFuzzy.Cells[09, 07] := '+/-P';
  GridFuzzy.Cells[10, 07] := '+/-P';
  GridFuzzy.Cells[11, 07] := 'MME';
  GridFuzzy.Cells[00, 08] := '+/-G';
  GridFuzzy.Cells[01, 08] := 'PG';
  GridFuzzy.Cells[02, 08] := 'PG';
  GridFuzzy.Cells[03, 08] := 'PG';
  GridFuzzy.Cells[04, 08] := 'PG';
  GridFuzzy.Cells[05, 08] := 'ME';
  GridFuzzy.Cells[06, 08] := 'ME';
  GridFuzzy.Cells[07, 08] := 'ME';
  GridFuzzy.Cells[08, 08] := 'PP';
  GridFuzzy.Cells[09, 08] := 'PP';
  GridFuzzy.Cells[10, 08] := '+/-P';
  GridFuzzy.Cells[11, 08] := 'MI';
  GridFuzzy.Cells[00, 09] := 'MG';
  GridFuzzy.Cells[01, 09] := '+/-G';
  GridFuzzy.Cells[02, 09] := '+/-G';
  GridFuzzy.Cells[03, 09] := '+/-G';
  GridFuzzy.Cells[04, 09] := 'PG';
  GridFuzzy.Cells[05, 09] := 'PG';
  GridFuzzy.Cells[06, 09] := 'PG';
  GridFuzzy.Cells[07, 09] := 'PG';
  GridFuzzy.Cells[08, 09] := 'ME';
  GridFuzzy.Cells[09, 09] := 'ME';
  GridFuzzy.Cells[10, 09] := 'PP';
  GridFuzzy.Cells[11, 09] := 'MME';
  GridFuzzy.Cells[00, 10] := 'MMA';
  GridFuzzy.Cells[01, 10] := 'MG';
  GridFuzzy.Cells[02, 10] := 'MG';
  GridFuzzy.Cells[03, 10] := 'MG';
  GridFuzzy.Cells[04, 10] := 'MG';
  GridFuzzy.Cells[05, 10] := '+/-G';
  GridFuzzy.Cells[06, 10] := '+/-G';
  GridFuzzy.Cells[07, 10] := '+/-G';
  GridFuzzy.Cells[08, 10] := 'PG';
  GridFuzzy.Cells[09, 10] := 'PG';
  GridFuzzy.Cells[10, 10] := 'ME';
  GridFuzzy.Cells[11, 10] := 'MP';
  GridFuzzy.Cells[00, 11] := 'MX';
  GridFuzzy.Cells[01, 11] := 'MMA';
  GridFuzzy.Cells[02, 11] := 'MMA';
  GridFuzzy.Cells[03, 11] := 'MMA';
  GridFuzzy.Cells[04, 11] := 'MG';
  GridFuzzy.Cells[05, 11] := 'MG';
  GridFuzzy.Cells[06, 11] := 'MG';
  GridFuzzy.Cells[07, 11] := 'MG';
  GridFuzzy.Cells[08, 11] := '+/-G';
  GridFuzzy.Cells[09, 11] := '+/-G';
  GridFuzzy.Cells[10, 11] := 'PG';
  GridFuzzy.Cells[11, 11] := '+/-P';
  FuzzyVelocidade.RealInput := 105.53;
  FuzzyTensao.RealInput := 55.2;
end;

procedure TForm1.GridFuzzyDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  nLeft, nTop: Integer;
  Txt: string;
begin
  Txt := GridFuzzy.Cells[ACol, ARow];

  //if (ARow = 0) or (ACol > 0) then
  nLeft := (Rect.Right - Rect.Left - GridFuzzy.Canvas.TextWidth(Txt)) div 2
    //else
//  nLeft := 2
  ;

  nTop := (Rect.Bottom - Rect.Top - GridFuzzy.Canvas.TextHeight('วร')) div 2;
  GridFuzzy.Canvas.FillRect(Rect);
  GridFuzzy.Canvas.TextOut(Rect.Left + nLeft, Rect.Top + nTop, Txt);
end;

procedure TForm1.btnResultClick(Sender: TObject);
var
  VelocidadeIdx, TensaoIdx: Integer;
  VelocidadeOwnerShip, TensaoOwnerShip, AverageOwnerShip: Double;
  TensaoVarFuzzyDescriptor: string;
  TensaoVarIndex: integer;
begin
  for VelocidadeIdx := 0 to GridFuzzy.ColCount - 1 do
    for TensaoIdx := 0 to GridFuzzy.RowCount - 1 do
      GridFuzzy.Cells[VelocidadeIdx, TensaoIdx] := AnsiUpperCase(GridFuzzy.Cells[VelocidadeIdx, TensaoIdx]);

  FuzzySolution.ClearSolution;

  for VelocidadeIdx := 0 to FuzzyVelocidade.Members.Count - 1 do
  begin
    for TensaoIdx := 0 to FuzzyTensao.Members.Count - 1 do
    begin
      VelocidadeOwnerShip := FuzzyVelocidade.OutPuts[VelocidadeIdx];
      TensaoOwnerShip := FuzzyTensao.OutPuts[TensaoIdx];

      if rbAverage.Checked then
        AverageOwnerShip := (VelocidadeOwnerShip + TensaoOwnerShip) / 2
      else
        AverageOwnerShip := MinValue([VelocidadeOwnerShip, TensaoOwnerShip]);

      if (VelocidadeOwnerShip > 0) and (TensaoOwnerShip > 0) then //launching threshold
      begin
        TensaoVarFuzzyDescriptor := AnsiUpperCase(GridFuzzy.Cells[VelocidadeIdx + 1, TensaoIdx + 1]);
        GridFuzzy.Cells[VelocidadeIdx + 1, TensaoIdx + 1] := AnsiLowerCase(GridFuzzy.Cells[VelocidadeIdx + 1, TensaoIdx + 1]);
        GridFuzzy.Row := TensaoIdx + 1;
        GridFuzzy.Col := VelocidadeIdx + 1;
        TensaoVarIndex := FuzzySolution.Members.GetMemberIndex(TensaoVarFuzzyDescriptor);
        FuzzySolution.FuzzyAgregate(TensaoVarIndex, AverageOwnerShip);
        //ShowMessage('Next Rule');
      end;
    end;
  end;

  Label3.Caption := FormatFloat(',0.00', FuzzySolution.RealOutput) + ' V';

  if FuzzyTensao.RealInput > FuzzySolution.RealOutput then
    FuzzyTensao.RealInput := FuzzyTensao.RealInput + FuzzySolution.RealOutput
  else
    FuzzyTensao.RealInput := FuzzyTensao.RealInput - FuzzySolution.RealOutput;
end;

procedure TForm1.FuzzyVelocidadeChange(Sender: TObject);
begin
  lblVelocidade1.Caption := 'Valor=' + FloatToStrF(FuzzyVelocidade.RealInput, ffFixed, 5, 3);
  AlignEdit1.Text := FloatToStrF(FuzzyVelocidade.RealInput, ffFixed, 5, 3);
  lblVelocidadeMI.Caption := 'MI=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[00]);
  lblVelocidadeMME.Caption := 'MME=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[01]);
  lblVelocidadeMP.Caption := 'MP=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[02]);
  lblVelocidadeMMP.Caption := 'MMP=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[03]);
  lblVelocidadePP.Caption := 'PP=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[04]);
  lblVelocidadeME.Caption := 'ME=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[05]);
  lblVelocidadePG.Caption := 'PG=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[06]);
  lblVelocidadeMMG.Caption := 'MMG=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[07]);
  lblVelocidadeMG.Caption := 'MG=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[08]);
  lblVelocidadeMMA.Caption := 'MMA=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[09]);
  lblVelocidadeMX.Caption := 'MX=' + FormatFloat(',0.0000', FuzzyVelocidade.OutPuts[10]);
end;

procedure TForm1.FuzzyTensaoChange(Sender: TObject);
begin
  lblTensao1.Caption := 'Valor=' + FloatToStrF(FuzzyTensao.RealInput, ffFixed, 5, 3);
  AlignEdit2.Text := FloatToStrF(FuzzyTensao.RealInput, ffFixed, 5, 3);
  lblTensaoMI.Caption := 'MI=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[00]);
  lblTensaoMME.Caption := 'MME=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[01]);
  lblTensaoMP.Caption := 'MP=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[02]);
  lblTensaoMMP.Caption := 'MMP=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[03]);
  lblTensaoPP.Caption := 'PP=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[04]);
  lblTensaoME.Caption := 'ME=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[05]);
  lblTensaoPG.Caption := 'PG=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[06]);
  lblTensaoMMG.Caption := 'MMG=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[07]);
  lblTensaoMG.Caption := 'MG=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[08]);
  lblTensaoMMA.Caption := 'MMA=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[09]);
  lblTensaoMX.Caption := 'MX=' + FormatFloat(',0.0000', FuzzyTensao.OutPuts[10]);
end;

procedure TForm1.AlignEdit1Enter(Sender: TObject);
begin
  VAnt := TAlignEdit(Sender).Text;
end;

procedure TForm1.AlignEdit1Exit(Sender: TObject);
begin
  if VAnt <> TAlignEdit(Sender).Text then
    FuzzyVelocidade.RealInput := StrToFloatDef(TAlignEdit(Sender).Text, 0);
end;

procedure TForm1.AlignEdit2Exit(Sender: TObject);
begin
  if VAnt <> TAlignEdit(Sender).Text then
    FuzzyTensao.RealInput := StrToFloatDef(TAlignEdit(Sender).Text, 0);
end;

end.

