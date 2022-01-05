unit UOCRTrein1600;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, ComCtrls, DB, Grids, DBGrids,
  DBTables, MLP, kbmMemTable;

type
  TFOCRTrein1600 = class(TForm)
    tblPdxOCR: TTable;
    DBGrid1: TDBGrid;
    dsOCR: TDataSource;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    DBImCaracter: TDBImage;
    Label2: TLabel;
    Label3: TLabel;
    ImConvol: TImage;
    Label4: TLabel;
    ImSubAmostra: TImage;
    ImOcelo11: TImage;
    ImOcelo12: TImage;
    ImOcelo13: TImage;
    ImOcelo21: TImage;
    ImOcelo22: TImage;
    ImOcelo23: TImage;
    ImOcelo31: TImage;
    ImOcelo32: TImage;
    ImOcelo33: TImage;
    Label5: TLabel;
    btnConstruir: TBitBtn;
    btnTreinar: TBitBtn;
    btnTestar: TBitBtn;
    btnSalvar: TBitBtn;
    btnCarregar: TBitBtn;
    Label6: TLabel;
    ed0: TEdit;
    Label7: TLabel;
    ed1: TEdit;
    ed2: TEdit;
    ed3: TEdit;
    ed4: TEdit;
    ed5: TEdit;
    ed6: TEdit;
    ed7: TEdit;
    ed8: TEdit;
    ed9: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    MLP: TMLP;
    tblPdxOCRSequencia: TIntegerField;
    tblPdxOCRID: TStringField;
    tblPdxOCRCaracter: TStringField;
    tblPdxOCRImagem: TGraphicField;
    ImOcelo41: TImage;
    ImOcelo42: TImage;
    ImOcelo43: TImage;
    ImOcelo14: TImage;
    ImOcelo24: TImage;
    ImOcelo34: TImage;
    ImOcelo44: TImage;
    ImOcelo15: TImage;
    ImOcelo25: TImage;
    ImOcelo35: TImage;
    ImOcelo45: TImage;
    ImOcelo51: TImage;
    ImOcelo52: TImage;
    ImOcelo53: TImage;
    ImOcelo54: TImage;
    ImOcelo55: TImage;
    btnParar: TBitBtn;
    tblMemOCR: TkbmMemTable;
    tblMemOCRSequencia: TIntegerField;
    tblMemOCRID: TStringField;
    tblMemOCRCaracter: TStringField;
    tblMemOCRImagem: TGraphicField;
    procedure FormCreate(Sender: TObject);
    procedure Atualiza;
    procedure btnConstruirClick(Sender: TObject);
    procedure btnTreinarClick(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsOCRDataChange(Sender: TObject; Field: TField);
    procedure tblPdxOCRBeforeOpen(DataSet: TDataSet);
    procedure btnPararClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tblPdxOCRAfterOpen(DataSet: TDataSet);
  private
    Parar, Processando: Boolean;
  public
    C, S: TBitmap;
    O: array[0..24] of TBitmap;
    InitialDir: string;
  end;

var
  FOCRTrein1600: TFOCRTrein1600;

implementation

uses UOCR;

{$R *.dfm}

procedure TFOCRTrein1600.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Processando := False;

  { Pasta de trabalho }
  InitialDir := ExtractFilePath(Application.ExeName) + 'Bitmaps\';

  { Bitmap de Convolu��o }
  C := TBitmap.Create;
  C.Width := 32;
  C.Height := 32;

  { Bitmap de Subamostragem }
  S := TBitmap.Create;
  S.Width := 16;
  S.Height := 16;

  { Cria os Ocelos de vis�o - 24 Ocelos 8x8 }
  for i := 0 to 24 do
  begin
    O[i] := TBitmap.Create;
    O[i].Width := 8;
    O[i].Height := 8;
  end;

  { Atualiza��o da form }
  Atualiza;

  { Arquitetura da rede MLP }
  MLP.Struct.Clear;
  MLP.Struct.Add('1600');
  MLP.Struct.Add('10');

  { Par�metros de Treinamento }
  MLP.Learning := FOCR.Aprendizagem;
  MLP.Momentum := FOCR.Inercia;

  { Evento de atualiza��o }
  dsOCR.OnDataChange := dsOCRDataChange;

  tblPdxOCR.Open;
end;

procedure TFOCRTrein1600.Atualiza;
var
  x, y: integer;
  Cor: TColor;
begin
  { Convolu��o }
  for x := 1 to 30 do
    for y := 1 to 30 do
    begin
      Cor := (DBImCaracter.Picture.Bitmap.Canvas.Pixels[x - 1, y - 1] shr 23);
      Cor := Cor + (DBImCaracter.Picture.Bitmap.Canvas.Pixels[x, y - 1] shr 23);
      Cor := Cor + (DBImCaracter.Picture.Bitmap.Canvas.Pixels[x + 1, y - 1] shr 23);
      Cor := Cor + (DBImCaracter.Picture.Bitmap.Canvas.Pixels[x - 1, y] shr 23);
      Cor := Cor + (DBImCaracter.Picture.Bitmap.Canvas.Pixels[x, y] shr 23);
      Cor := Cor + (DBImCaracter.Picture.Bitmap.Canvas.Pixels[x + 1, y] shr 23);
      Cor := Cor + (DBImCaracter.Picture.Bitmap.Canvas.Pixels[x - 1, y + 1] shr 23);
      Cor := Cor + (DBImCaracter.Picture.Bitmap.Canvas.Pixels[x, y + 1] shr 23);
      Cor := Cor + (DBImCaracter.Picture.Bitmap.Canvas.Pixels[x + 1, y + 1] shr 23);
      Cor := Cor div 9;
      if Cor = 1 then
        Cor := $FFFFFF
      else
        Cor := 0;
      C.Canvas.Pixels[x, y] := Cor;
    end;

  ImConvol.Picture.Assign(C);

  { Subamostragem }
  for x := 0 to 31 do
    for y := 0 to 31 do
      S.Canvas.Pixels[x, y] := C.Canvas.Pixels[x * 2, y * 2];

  ImSubAmostra.Picture.Assign(S);

  { 25 Ocelos de 8x8 deslocados de 2 pixels }
  { 1� LINHA }
  { Ocelo 11 }
  for x := 0 to 7 do
    for y := 0 to 7 do
      O[0].Canvas.Pixels[x, y] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo11.Picture.Assign(O[0]);

  { Ocelo 12 }
  for x := 2 to 9 do
    for y := 0 to 7 do
      O[1].Canvas.Pixels[x - 2, y] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo12.Picture.Assign(O[1]);

  { Ocelo 13 }
  for x := 4 to 11 do
    for y := 0 to 7 do
      O[2].Canvas.Pixels[x - 4, y] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo13.Picture.Assign(O[2]);

  { Ocelo 14 }
  for x := 6 to 13 do
    for y := 0 to 7 do
      O[3].Canvas.Pixels[x - 6, y] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo14.Picture.Assign(O[3]);

  { Ocelo 15 }
  for x := 8 to 15 do
    for y := 0 to 7 do
      O[4].Canvas.Pixels[x - 8, y] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo15.Picture.Assign(O[4]);

  { 2� LINHA }
  { Ocelo 21 }
  for x := 0 to 7 do
    for y := 2 to 9 do
      O[5].Canvas.Pixels[x, y - 2] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo21.Picture.Assign(O[5]);

  { Ocelo 22 }
  for x := 2 to 9 do
    for y := 2 to 9 do
      O[6].Canvas.Pixels[x - 2, y - 2] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo22.Picture.Assign(O[6]);

  { Ocelo 23 }
  for x := 4 to 11 do
    for y := 2 to 9 do
      O[7].Canvas.Pixels[x - 4, y - 2] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo23.Picture.Assign(O[7]);

  { Ocelo 24 }
  for x := 6 to 13 do
    for y := 2 to 9 do
      O[8].Canvas.Pixels[x - 6, y - 2] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo24.Picture.Assign(O[8]);

  { Ocelo 25 }
  for x := 8 to 15 do
    for y := 2 to 9 do
      O[9].Canvas.Pixels[x - 8, y - 2] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo25.Picture.Assign(O[9]);

  { 3� LINHA }
  { Ocelo 31 }
  for x := 0 to 7 do
    for y := 4 to 11 do
      O[10].Canvas.Pixels[x, y - 4] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo31.Picture.Assign(O[10]);

  { Ocelo 23 }
  for x := 2 to 9 do
    for y := 4 to 11 do
      O[11].Canvas.Pixels[x - 2, y - 4] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo32.Picture.Assign(O[11]);

  { Ocelo 33 }
  for x := 4 to 11 do
    for y := 4 to 11 do
      O[12].Canvas.Pixels[x - 4, y - 4] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo33.Picture.Assign(O[12]);

  { Ocelo 33 }
  for x := 6 to 13 do
    for y := 4 to 11 do
      O[13].Canvas.Pixels[x - 6, y - 4] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo34.Picture.Assign(O[13]);

  { Ocelo 33 }
  for x := 8 to 15 do
    for y := 4 to 11 do
      O[14].Canvas.Pixels[x - 8, y - 4] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo35.Picture.Assign(O[14]);

  { 4� LINHA }
  { Ocelo 41 }
  for x := 0 to 7 do
    for y := 6 to 13 do
      O[15].Canvas.Pixels[x, y - 6] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo41.Picture.Assign(O[15]);

  { Ocelo 42 }
  for x := 2 to 9 do
    for y := 6 to 13 do
      O[16].Canvas.Pixels[x - 2, y - 6] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo42.Picture.Assign(O[16]);

  { Ocelo 43 }
  for x := 4 to 11 do
    for y := 6 to 13 do
      O[17].Canvas.Pixels[x - 4, y - 6] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo43.Picture.Assign(O[17]);

  { Ocelo 44 }
  for x := 6 to 13 do
    for y := 6 to 13 do
      O[18].Canvas.Pixels[x - 6, y - 6] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo44.Picture.Assign(O[18]);

  { Ocelo 45 }
  for x := 8 to 15 do
    for y := 6 to 13 do
      O[19].Canvas.Pixels[x - 8, y - 6] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo45.Picture.Assign(O[19]);

  { 5� LINHA }
  { Ocelo 51 }
  for x := 0 to 7 do
    for y := 8 to 15 do
      O[20].Canvas.Pixels[x, y - 8] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo51.Picture.Assign(O[20]);

  { Ocelo 52 }
  for x := 2 to 9 do
    for y := 8 to 15 do
      O[21].Canvas.Pixels[x - 2, y - 8] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo52.Picture.Assign(O[21]);

  { Ocelo 53 }
  for x := 4 to 11 do
    for y := 8 to 15 do
      O[22].Canvas.Pixels[x - 4, y - 8] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo53.Picture.Assign(O[22]);

  { Ocelo 54 }
  for x := 6 to 13 do
    for y := 8 to 15 do
      O[23].Canvas.Pixels[x - 6, y - 8] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo54.Picture.Assign(O[23]);

  { Ocelo 55 }
  for x := 8 to 15 do
    for y := 8 to 15 do
      O[24].Canvas.Pixels[x - 8, y - 8] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo55.Picture.Assign(O[24]);
end;

procedure TFOCRTrein1600.btnConstruirClick(Sender: TObject);
var
  i: integer;
begin
  { Constr�i a rede }
  MLP.Build;

  { Ajusta intervalo das entradas }
  for i := 1 to 1600 do
  begin
    with MLP do
    begin
      SetInputMin(i, 0);
      SetInputMax(i, 1);
    end;
  end;

  { Ajusta intervalo das sa�das }
  for i := 1 to 10 do
  begin
    with MLP do
    begin
      SetOutputMin(i, 0);
      SetOutputMax(i, 1);
    end;
  end;

  btnTreinar.Enabled := True;
  btnCarregar.Enabled := True;
end;

procedure TFOCRTrein1600.btnTreinarClick(Sender: TObject);
var
  i, j, k: byte;
  m, n: word;
begin
  btnTreinar.Enabled := False;
  btnCarregar.Enabled := False;
  btnParar.Enabled := True;
  Parar := False;
  Processando := True;

  try
    { Faz o treinamento conforme o n�mero de �pocas }
    for m := 0 to FOCR.NEpocas do
    begin
      if Parar then
        Break;

      { Para cada caracter no arquivo }
      tblMemOCR.First;

      while not tblMemOCR.EOF do
      begin
        if Parar then
          Break;

        Atualiza;
        Application.ProcessMessages;

        { Alimenta a rede com os valores dos Ocelos de vis�o }
        for k := 0 to 24 do
          for i := 0 to 7 do
            for j := 0 to 7 do
            begin
              n := 64 * k + i * 8 + j + 1; // �ndice do neur�nio de entrada
              MLP.SetInput(n, O[k].Canvas.Pixels[i, j] shr 23); // 0 ou 1
            end;

        { Alimenta a rede com sa�das esperadas }
        for i := 0 to 9 do
          MLP.SetOutput(i + 1, 0);
        MLP.SetOutput(tblMemOCRCaracter.AsInteger + 1, 1);

        { Executa o treinamento }
        MLP.Training;

        { Atualiza barra de status }
        StatusBar1.Panels[0].Text := '�pocas: ' + IntToStr(m);
        StatusBar1.Panels[1].Text := 'Erro: ' + Format('%2.8f', [MLP.Cost]);

        { Pr�ximo caracter no arquivo }
        tblMemOCR.Next;
        Application.ProcessMessages;
      end;
    end;

    MLP.Save;
  finally
    Processando := False;
    btnParar.Enabled := False;
    btnTreinar.Enabled := True;
    btnCarregar.Enabled := True;

    if not Parar then
    begin
      btnTreinar.Enabled := False;
      btnCarregar.Enabled := False;
      btnTestar.Enabled := True;
      btnSalvar.Enabled := True;
    end;
  end;
end;

procedure TFOCRTrein1600.btnTestarClick(Sender: TObject);
var
  i, j, k, n: integer;
  Valor, Maior: double;
  IMaior: integer;
begin
  { Alimenta a rede com os valores dos Ocelos }
  for k := 0 to 24 do
    for i := 0 to 7 do
      for j := 0 to 7 do
      begin
        n := 64 * k + i * 8 + j + 1; // �ndice do neur�nio de entrada
        MLP.SetInput(n, O[k].Canvas.Pixels[i, j] shr 23); // 0 ou 1
      end;

  MLP.Test;

  ed0.Text := Format('%2.4f', [MLP.GetOutput(1)]);
  ed1.Text := Format('%2.4f', [MLP.GetOutput(2)]);
  ed2.Text := Format('%2.4f', [MLP.GetOutput(3)]);
  ed3.Text := Format('%2.4f', [MLP.GetOutput(4)]);
  ed4.Text := Format('%2.4f', [MLP.GetOutput(5)]);
  ed5.Text := Format('%2.4f', [MLP.GetOutput(6)]);
  ed6.Text := Format('%2.4f', [MLP.GetOutput(7)]);
  ed7.Text := Format('%2.4f', [MLP.GetOutput(8)]);
  ed8.Text := Format('%2.4f', [MLP.GetOutput(9)]);
  ed9.Text := Format('%2.4f', [MLP.GetOutput(10)]);

  { Verifica a maior sa�da para indica��o visual }
  Maior := -10;
  for i := 1 to 10 do
  begin
    Valor := MLP.GetOutput(i);
    if Valor > Maior then
    begin
      Maior := Valor;
      IMaior := i;
    end;
  end;

  { Todas com fundo branco }
  ed0.Color := clWhite;
  ed1.Color := clWhite;
  ed2.Color := clWhite;
  ed3.Color := clWhite;
  ed4.Color := clWhite;
  ed5.Color := clWhite;
  ed6.Color := clWhite;
  ed7.Color := clWhite;
  ed8.Color := clWhite;
  ed9.Color := clWhite;

  { Exceto a maior }
  case IMaior of
    1: ed0.Color := clYellow;
    2: ed1.Color := clYellow;
    3: ed2.Color := clYellow;
    4: ed3.Color := clYellow;
    5: ed4.Color := clYellow;
    6: ed5.Color := clYellow;
    7: ed6.Color := clYellow;
    8: ed7.Color := clYellow;
    9: ed8.Color := clYellow;
    10: ed9.Color := clYellow;
  end;
end;

procedure TFOCRTrein1600.btnSalvarClick(Sender: TObject);
begin
  Mlp.Save;
end;

procedure TFOCRTrein1600.btnCarregarClick(Sender: TObject);
begin
  MLP.Load;
end;

procedure TFOCRTrein1600.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FOCRTrein1600 := nil;
end;

procedure TFOCRTrein1600.dsOCRDataChange(Sender: TObject; Field: TField);
begin
  Atualiza;
end;

procedure TFOCRTrein1600.btnPararClick(Sender: TObject);
begin
  Parar := True;
end;

procedure TFOCRTrein1600.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not Processando;
end;

procedure TFOCRTrein1600.tblPdxOCRBeforeOpen(DataSet: TDataSet);
begin
  tblPdxOCR.DatabaseName := ExtractFilePath(Application.ExeName);
end;

procedure TFOCRTrein1600.tblPdxOCRAfterOpen(DataSet: TDataSet);
begin
  tblMemOCR.Open;
  tblMemOCR.EmptyTable;
  tblMemOCR.LoadFromDataSet(tblPdxOCR, [mtcpoAppend]);
  tblPdxOCR.Close;
end;

end.
