unit UTeste;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, MLP, ExtCtrls;

type
  TFrmTeste = class(TForm)
    seIFR: TEdit;
    sePERC_D: TEdit;
    sePERC_K: TEdit;
    seMFI: TEdit;
    seUO: TEdit;
    seSUPRES: TEdit;
    edAgressivo: TEdit;
    btnTeste: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel1: TBevel;
    MLP: TMLP;
    edArrojado: TEdit;
    edEquilibrado: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTesteClick(Sender: TObject);
    procedure seIFRKeyPress(Sender: TObject; var Key: Char);
  private
  public
  end;

var
  FrmTeste: TFrmTeste;

implementation

uses
  uVale5;

{$R *.DFM}

procedure TFrmTeste.FormCreate(Sender: TObject);
var
  i: integer;
begin
  MLP.Build;
  MLP.Learning := FVale5.Aprendizagem;
  MLP.Momentum := FVale5.Inercia;
  MLP.Knowledge := FVale5.Conhecimento;

  { Inserir número de neurônios e camadas }
  MLP.Struct.Clear;

  MLP.Struct.Add('6'); // camada de entrada
  MLP.Struct.Add(IntToStr(FVale5.NeuroniosOcultos)); // camada oculta
  MLP.Struct.Add('3'); // camada de saída

  MLP.Load;

  { Definição da faixa de trabalho dos neurônios de entrada }
  with MLP do
  begin
    // IFR
    SetInputMin(1, 0);
    SetInputMax(1, 100);

    // PERC_D
    SetInputMin(2, 0);
    SetInputMax(2, 100);

    // PERC_K
    SetInputMin(3, 0);
    SetInputMax(3, 100);

    // MFI
    SetInputMin(4, 0);
    SetInputMax(4, 100);

    // UO
    SetInputMin(5, 0);
    SetInputMax(5, 100);

    // SUPRES
    SetInputMin(6, 0);
    SetInputMax(6, 100);
  end;

  { Definição da faixa de trabalho dos neurônios de saída }

  with MLP do
    for i := 1 to 3 do
    begin
      SetOutputMin(i, 0);
      SetOutputMax(i, 1);
    end;
end;

procedure TFrmTeste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FrmTeste := nil;
end;

procedure TFrmTeste.btnTesteClick(Sender: TObject);
var
  i, IMaior: integer;
  k, Maior: double;
begin
  with MLP do
  begin
    SetInput(1, StrToFloatDef(seIFR.Text, 0));
    SetInput(2, StrToFloatDef(sePERC_D.Text, 0));
    SetInput(3, StrToFloatDef(sePERC_K.Text, 0));
    SetInput(4, StrToFloatDef(seMFI.Text, 0));
    SetInput(5, StrToFloatDef(seUO.Text, 0));
    SetInput(6, StrToFloatDef(seSUPRES.Text, 0));

    Test;

    Maior := -10;
    IMaior := 0;

    for i := 1 to 3 do
    begin
      k := GetOutput(i);

      if k > Maior then
      begin
        Maior := k;
        IMaior := i;
      end;
    end;

    edAgressivo.Text := Format('%2.3f', [GetOutput(1)]);
    edArrojado.Text := Format('%2.3f', [GetOutput(2)]);
    edEquilibrado.Text := Format('%2.3f', [GetOutput(3)]);

    edAgressivo.Color := clWhite;
    edArrojado.Color := clWhite;
    edEquilibrado.Color := clWhite;

    case IMaior of
      1: edAgressivo.Color := clYellow;
      2: edArrojado.Color := clYellow;
      3: edEquilibrado.Color := clYellow;
    end;
  end;
end;

procedure TFrmTeste.seIFRKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key > #31) and (Key <> #127) and not (Key in ['0'..'9', DecimalSeparator]) then
  begin
    Beep;
    Key := #0;
  end
  else if (Key = DecimalSeparator) and (Pos(DecimalSeparator, TEdit(Sender).Text) <> 0) then
  begin
    Beep;
    Key := #0;
  end;
end;

end.

