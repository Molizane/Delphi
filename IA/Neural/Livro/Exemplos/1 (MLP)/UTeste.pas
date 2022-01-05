unit UTeste;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, Spin, ExtCtrls, MLP;

type
  TTeste = class(TForm)
    tblPerfil: TTable;
    dsPerfil: TDataSource;
    seNInvAR: TSpinEdit;
    seNInvMR: TSpinEdit;
    seNInvBR: TSpinEdit;
    seIdade: TSpinEdit;
    seSexo: TSpinEdit;
    seRenda: TSpinEdit;
    sePMI: TSpinEdit;
    seEscol: TSpinEdit;
    edAgressivo: TEdit;
    btnTeste: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Bevel1: TBevel;
    MLP: TMLP;
    edArrojado: TEdit;
    edEquilibrado: TEdit;
    edReservado: TEdit;
    edDefensivo: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTesteClick(Sender: TObject);
    procedure tblPerfilBeforeOpen(DataSet: TDataSet);
  private
  public
  end;

var
  Teste: TTeste;

implementation

uses UPerfil;

{$R *.DFM}

procedure TTeste.FormCreate(Sender: TObject);
var
  i: integer;
begin
  tblPerfil.Open;

  MLP.Build;
  MLP.Learning := FPerfil.Aprendizagem;
  MLP.Momentum := FPerfil.Inercia;
  MLP.Knowledge := FPerfil.Conhecimento;

  { Inserir número de neurônios e camadas }
  MLP.Struct.Clear;

  MLP.Struct.Add('8'); // camada de entrada
  MLP.Struct.Add(IntToStr(FPerfil.NeuroniosOcultos)); // camada oculta
  MLP.Struct.Add('5'); // camada de saída

  MLP.Load;

  { Definição da faixa de trabalho dos neurônios de entrada }
  with MLP do
  begin
    // NInvAR
    SetInputMin(1, 0);
    SetInputMax(1, 10);

    // NInvMR
    SetInputMin(2, 0);
    SetInputMax(2, 10);

    // NInvBR
    SetInputMin(3, 0);
    SetInputMax(3, 10);

    // Idade
    SetInputMin(4, 10);
    SetInputMax(4, 60);

    // Sexo
    SetInputMin(5, 0);
    SetInputMax(5, 1);

    // Renda
    SetInputMin(6, 100);
    SetInputMax(6, 10000);

    // Prazo Médio de Investimento (meses)
    SetInputMin(7, 1);
    SetInputMax(7, 12);

    // Escolaridade
    SetInputMin(8, 0);
    SetInputMax(8, 3);
  end;

  { Definição da faixa de trabalho dos neurônios de saída }

  with MLP do
    for i := 1 to 5 do
    begin
      SetOutputMin(i, 0);
      SetOutputMax(i, 1);
    end;

end;

procedure TTeste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblPerfil.Close;
  Action := caFree;
  Teste := nil;
end;

procedure TTeste.btnTesteClick(Sender: TObject);
var i, IMaior: integer;
  k, Maior: double;
begin
  with MLP do
  begin
    SetInput(1, seNInvAR.Value);
    SetInput(2, seNInvMR.Value);
    SetInput(3, seNInvBR.Value);
    SetInput(4, seIdade.Value);
    SetInput(5, seSexo.Value);
    SetInput(6, seRenda.Value);
    SetInput(7, sePMI.Value);
    SetInput(8, seEscol.Value);

    Test;

    Maior := -10;
    for i := 1 to 5 do
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
    edReservado.Text := Format('%2.3f', [GetOutput(4)]);
    edDefensivo.Text := Format('%2.3f', [GetOutput(5)]);

    edAgressivo.Color := clWhite;
    edArrojado.Color := clWhite;
    edEquilibrado.Color := clWhite;
    edReservado.Color := clWhite;
    edDefensivo.Color := clWhite;

    case IMaior of
      1: edAgressivo.Color := clYellow;
      2: edArrojado.Color := clYellow;
      3: edEquilibrado.Color := clYellow;
      4: edReservado.Color := clYellow;
      5: edDefensivo.Color := clYellow;
    end;
  end;
end;

procedure TTeste.tblPerfilBeforeOpen(DataSet: TDataSet);
begin
  tblPerfil.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.

