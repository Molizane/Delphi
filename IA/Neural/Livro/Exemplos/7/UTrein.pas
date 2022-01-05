unit UTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ComCtrls, MLP;

type
  TFrmTrein = class(TForm)
    tblVale5: TTable;
    dsPerfil: TDataSource;
    btnConstruir: TBitBtn;
    btnTreinar: TBitBtn;
    StatusBar1: TStatusBar;
    MLP: TMLP;
    tblVale5IFR: TFloatField;
    tblVale5PERC_D: TFloatField;
    tblVale5PERC_K: TFloatField;
    tblVale5MFI: TFloatField;
    tblVale5UO: TFloatField;
    tblVale5SUPRES: TFloatField;
    tblVale5FUT: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConstruirClick(Sender: TObject);
    procedure btnTreinarClick(Sender: TObject);
  private
  public
  end;

var
  FrmTrein: TFrmTrein;

implementation

uses
  uVale5;

{$R *.DFM}

procedure TFrmTrein.FormCreate(Sender: TObject);
begin
  tblVale5.Open;
end;

procedure TFrmTrein.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblVale5.Close;
  Action := caFree;
  FrmTrein := nil;
end;

procedure TFrmTrein.btnConstruirClick(Sender: TObject);
var
  i: integer;
begin
  btnConstruir.Enabled := False;

  try
    MLP.Build;
    MLP.Learning := FVale5.Aprendizagem;
    MLP.Momentum := FVale5.Inercia;
    MLP.Knowledge := FVale5.Conhecimento;

    { Inserir número de neurônios e camadas }
    MLP.Struct.Clear;
    MLP.Struct.Add('6'); // camada de entrada
    MLP.Struct.Add(IntToStr(FVale5.NeuroniosOcultos)); // camada oculta
    MLP.Struct.Add('3'); // camada de saída

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

    btnTreinar.Enabled := True;
  except
    btnConstruir.Enabled := True;
    raise;
  end;
end;

procedure TFrmTrein.btnTreinarClick(Sender: TObject);
var
  i, k: integer;
begin
  btnTreinar.Enabled := False;

  try
    { Executa treinamento para várias épocas }
    for k := 0 to FVale5.NEpocas do
    begin
      tblVale5.First;

      while not tblVale5.EOF do
      begin
        { Associação dos valores de entrada da amostra }
        with MLP do
        begin
          SetInput(1, tblVale5['IFR']);
          SetInput(2, tblVale5['PERC_D']);
          SetInput(3, tblVale5['PERC_K']);
          SetInput(4, tblVale5['MFI']);
          SetInput(5, tblVale5['UO']);
          SetInput(6, tblVale5['SUPRES']);

          for i := 1 to 3 do
            SetOutput(i, 0); // todas as saídas zeradas

          SetOutput(tblVale5['FUT'], 1); // exceto o neurônio do perfil

          Training;
        end;

        StatusBar1.Panels[0].Text := ' . Épocas: ' + IntToStr(k + 1) + ' de ' + IntToStr(FVale5.NEpocas);
        StatusBar1.Panels[1].Text := Format(' . Erro Total: %2.6f', [MLP.Cost]);
        StatusBar1.Repaint;

        tblVale5.Next;
        Application.ProcessMessages;
      end;
    end;

    { Após treinar guarda o conhecimento acumulado pela rede }
    MLP.Save;
  finally
    btnTreinar.Enabled := True;
  end;
end;

end.

