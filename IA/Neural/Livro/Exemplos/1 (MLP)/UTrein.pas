unit UTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  DBTables, StdCtrls, Buttons, ComCtrls, MLP;

type
  TTrein = class(TForm)
    tblPerfil: TTable;
    dsPerfil: TDataSource;
    btnConstruir: TBitBtn;
    btnTreinar: TBitBtn;
    StatusBar1: TStatusBar;
    MLP: TMLP;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConstruirClick(Sender: TObject);
    procedure btnTreinarClick(Sender: TObject);
    procedure tblPerfilBeforeOpen(DataSet: TDataSet);
  private
  public
  end;

var
  Trein: TTrein;

implementation

uses
  UPerfil;

{$R *.DFM}

procedure TTrein.FormCreate(Sender: TObject);
begin
  tblPerfil.Open;
end;

procedure TTrein.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblPerfil.Close;
  Action := caFree;
  Trein := nil;
end;

procedure TTrein.btnConstruirClick(Sender: TObject);
var
  i: integer;
begin
  MLP.Build;
  MLP.Learning := FPerfil.Aprendizagem;
  MLP.Momentum := FPerfil.Inercia;
  MLP.Knowledge := FPerfil.Conhecimento;

  { Inserir número de neurônios e camadas }
  MLP.Struct.Clear;

  MLP.Struct.Add('8'); // camada de entrada
  MLP.Struct.Add(IntToStr(FPerfil.NeuroniosOcultos)); // camada oculta
  MLP.Struct.Add('5'); // camada de saída

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

  btnConstruir.Enabled := False;
  btnTreinar.Enabled := True;
end;

procedure TTrein.btnTreinarClick(Sender: TObject);
var
  i, k: integer;
begin
  btnTreinar.Enabled := False;

  { Executa treinamento para várias épocas }
  try
    for k := 0 to FPerfil.NEpocas do
    begin
      tblPerfil.First;

      while not tblPerfil.Eof do
      begin
        { Associação dos valores de entrada da amostra }
        with MLP do
        begin
          SetInput(1, tblPerfil['NInvAR']);
          SetInput(2, tblPerfil['NInvMR']);
          SetInput(3, tblPerfil['NInvBR']);
          SetInput(4, tblPerfil['Idade']);
          SetInput(5, tblPerfil['Sexo']);
          SetInput(6, tblPerfil['Renda']);
          SetInput(7, tblPerfil['PMI']);
          SetInput(8, tblPerfil['Escolaridade']);

          for i := 1 to 5 do
            SetOutput(i, 0); // todas as saídas zeradas

          SetOutput(tblPerfil['Perfil'], 1); // exceto o neurônio do perfil

          Training;
        end;

        StatusBar1.Panels[0].Text := 'Épocas: ' + IntToStr(k);
        StatusBar1.Panels[1].Text := Format('Erro Total: %2.6f', [MLP.Cost]);
        StatusBar1.Repaint;

        tblPerfil.Next;
      end;
    end;

    { Após treinar guarda o conhecimento acumulado pela rede }
    MLP.Save;
  finally
    btnTreinar.Enabled := True;
  end;
end;

procedure TTrein.tblPerfilBeforeOpen(DataSet: TDataSet);
begin
  tblPerfil.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.

