unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EditIdade: TEdit;
    EditPeso: TEdit;
    RBMasculino: TRadioButton;
    RBFeminino: TRadioButton;
    Label4: TLabel;
    EditResultado: TEdit;
    BtnProcessar: TButton;
    RdGrpDecisao: TRadioGroup;
    BtnCorrigir: TButton;
    Panel1: TPanel;
    LblMuitoBaixo: TLabel;
    LblBaixo: TLabel;
    LblNormal: TLabel;
    LblPoucoAlto: TLabel;
    LblAlto: TLabel;
    LblMuitoAlto: TLabel;
    TblNet: TTable;
    TblNetIdExame: TSmallintField;
    TblNetIdade: TFloatField;
    TblNetPeso: TFloatField;
    TblNetSexo: TSmallintField;
    TblNetResultado: TFloatField;
    TblNetMuitoBaixo: TSmallintField;
    TblNetBaixo: TSmallintField;
    TblNetNormal: TSmallintField;
    TblNetPoucoAlto: TSmallintField;
    TblNetAlto: TSmallintField;
    TblNetMuitoAlto: TSmallintField;
    procedure FormCreate(Sender: TObject);
    procedure EditIdadeChange(Sender: TObject);
    procedure BtnProcessarClick(Sender: TObject);
    procedure BtnCorrigirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm2.FormCreate(Sender: TObject);
var
  vliCnt: Integer;
begin
  for vliCnt := 0 to ComponentCount - 1 do
    if Components[vliCnt] is TEdit then
      TEdit(Components[vliCnt]).Text := '';
end;

procedure TForm2.EditIdadeChange(Sender: TObject);
begin
  RdGrpDecisao.Enabled := False;
  BtnCorrigir.Enabled := False;
end;

procedure TForm2.BtnProcessarClick(Sender: TObject);
var
  vlrMaior, vlrMenor: Real;
  vliItemIndex: Integer;
begin
  if RBMasculino.Checked then Form1.inpSexo.Value := 1
  else Form1.inpSexo.Value := 0;

  Form1.inpIdade.Value := StrToFloat(EditIdade.Text);
  Form1.inpPeso.Value := StrToFloat(EditPeso.Text);
  Form1.inpExame.Value := 1;
  Form1.inpResultado.Value := StrToFloat(EditResultado.Text);
  Form1.NeuralNet1.Update;

  vlrMaior := Form1.outMuitoBaixo.Value;
  vlrMenor := Form1.outMuitoBaixo.Value;
  vliItemIndex := 0;

  if Form1.outBaixo.Value > vlrMaior then
  begin
    vlrMaior := Form1.outBaixo.Value;
    vliItemIndex := 1;
  end;
  if Form1.outNormal.Value > vlrMaior then
  begin
    vlrMaior := Form1.outNormal.Value;
    vliItemIndex := 2;
  end;
  if Form1.outPoucoAlto.Value > vlrMaior then
  begin
    vlrMaior := Form1.outPoucoAlto.Value;
    vliItemIndex := 3;
  end;
  if Form1.outAlto.Value > vlrMaior then
  begin
    vlrMaior := Form1.outAlto.Value;
    vliItemIndex := 4;
  end;
  if Form1.outMuitoAlto.Value > vlrMaior then
  begin
    vlrMaior := Form1.outMuitoAlto.Value;
    vliItemIndex := 5;
  end;

  RdGrpDecisao.ItemIndex := vliItemIndex;

  LblMuitoBaixo.Caption := FloatToStr(Form1.outMuitoBaixo.Value);
  LblBaixo.Caption := FloatToStr(Form1.outBaixo.Value);
  LblNormal.Caption := FloatToStr(Form1.outNormal.Value);
  LblPoucoAlto.Caption := FloatToStr(Form1.outPoucoAlto.Value);
  LblAlto.Caption := FloatToStr(Form1.outAlto.Value);
  LblMuitoAlto.Caption := FloatToStr(Form1.outMuitoAlto.Value);
  RdGrpDecisao.Enabled := True;
  BtnCorrigir.Enabled := True;
end;

procedure TForm2.BtnCorrigirClick(Sender: TObject);
var
  vliCnt, vliSexo, vliItemIndex: Integer;
  vlrIdade, vlrPeso, vlrResultado, vlrMaior, vlrMenor: Real;
begin
  if RdGrpDecisao.ItemIndex >= 0 then
  begin
    vlrIdade := StrToFloat(EditIdade.Text);
    vlrPeso := StrToFloat(EditPeso.Text);
    vlrResultado := StrToFloat(EditResultado.Text);

    if RBMasculino.Checked then vliSexo := 1
    else vliSexo := 0;

    if not TblNet.FindKey([1, vlrIdade, vlrPeso, vliSexo, vlrResultado]) then
    begin
      TblNet.Append;
      TblNetIdExame.AsInteger := 1;
      TblNetIdade.AsFloat := vlrIdade;
      TblNetPeso.AsFloat := vlrPeso;
      TblNetSexo.AsInteger := vliSexo;
      TblNetResultado.AsFloat := vlrResultado;
    end
    else
      TblNet.Edit;

    TblNetMuitoBaixo.AsInteger := 0;
    TblNetBaixo.AsInteger := 0;
    TblNetNormal.AsInteger := 0;
    TblNetPoucoAlto.AsInteger := 0;
    TblNetAlto.AsInteger := 0;
    TblNetMuitoAlto.AsInteger := 0;

    if RdGrpDecisao.ItemIndex = 0 then TblNetMuitoBaixo.AsInteger := 1
    else if RdGrpDecisao.ItemIndex = 1 then TblNetBaixo.AsInteger := 1
    else if RdGrpDecisao.ItemIndex = 2 then TblNetNormal.AsInteger := 1
    else if RdGrpDecisao.ItemIndex = 3 then TblNetPoucoAlto.AsInteger := 1
    else if RdGrpDecisao.ItemIndex = 4 then TblNetAlto.AsInteger := 1
    else if RdGrpDecisao.ItemIndex = 5 then TblNetMuitoAlto.AsInteger := 1;

    TblNet.Post;

    for vliCnt := 1 to 2000 do
    begin
      TblNet.First;
      while not TblNet.EOF do
      begin
        Form1.inpIdade.Value := TblNetIdade.AsFloat;
        Form1.inpPeso.Value := TblNetPeso.AsFloat;
        Form1.inpSexo.Value := TblNetSexo.AsInteger;
        Form1.inpExame.Value := TblNetIdExame.AsInteger;
        Form1.inpResultado.Value := TblNetResultado.AsFloat;
        Form1.outMuitoBaixo.Value := TblNetMuitoBaixo.AsInteger;
        Form1.outBaixo.Value := TblNetBaixo.AsInteger;
        Form1.outNormal.Value := TblNetNormal.AsInteger;
        Form1.outPoucoAlto.Value := TblNetPoucoAlto.AsInteger;
        Form1.outAlto.Value := TblNetAlto.AsInteger;
        Form1.outMuitoAlto.Value := TblNetMuitoAlto.AsInteger;

        Form1.NeuralNet1.Learn;
        Form1.NeuralNet1.SaveToFile('exames.net');

        Form1.inpIdade.Value := TblNetIdade.AsFloat;
        Form1.inpPeso.Value := TblNetPeso.AsFloat;
        Form1.inpSexo.Value := TblNetSexo.AsInteger;
        Form1.inpExame.Value := TblNetIdExame.AsInteger;
        Form1.inpResultado.Value := TblNetResultado.AsFloat;
        Form1.NeuralNet1.Update;

        vlrMaior := Form1.outMuitoBaixo.Value;
        vlrMenor := Form1.outMuitoBaixo.Value;
        vliItemIndex := 0;

        if Form1.outBaixo.Value > vlrMaior then
        begin
          vlrMaior := Form1.outBaixo.Value;
          vliItemIndex := 1;
        end;
        if Form1.outNormal.Value > vlrMaior then
        begin
          vlrMaior := Form1.outNormal.Value;
          vliItemIndex := 2;
        end;
        if Form1.outPoucoAlto.Value > vlrMaior then
        begin
          vlrMaior := Form1.outPoucoAlto.Value;
          vliItemIndex := 3;
        end;
        if Form1.outAlto.Value > vlrMaior then
        begin
          vlrMaior := Form1.outAlto.Value;
          vliItemIndex := 4;
        end;
        if Form1.outMuitoAlto.Value > vlrMaior then
        begin
          vlrMaior := Form1.outMuitoAlto.Value;
          vliItemIndex := 5;
        end;

        RdGrpDecisao.ItemIndex := vliItemIndex;

        LblMuitoBaixo.Caption := FloatToStr(Form1.outMuitoBaixo.Value);
        LblBaixo.Caption := FloatToStr(Form1.outBaixo.Value);
        LblNormal.Caption := FloatToStr(Form1.outNormal.Value);
        LblPoucoAlto.Caption := FloatToStr(Form1.outPoucoAlto.Value);
        LblAlto.Caption := FloatToStr(Form1.outAlto.Value);
        LblMuitoAlto.Caption := FloatToStr(Form1.outMuitoAlto.Value);

        TblNet.Next;
        
        Application.ProcessMessages;
      end;
    end;
  end;
end;

end.
