unit UOCRTeste576;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, ComCtrls, DB, Grids, DBGrids,
  DBTables, MLP;

type
  TFOCRTeste576 = class(TForm)
    tblOCR: TTable;
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
    btnTestar: TBitBtn;
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
    tblOCRSequencia: TIntegerField;
    tblOCRID: TStringField;
    tblOCRCaracter: TStringField;
    tblOCRImagem: TGraphicField;
    tblOCRTeste: TStringField;
    btnParar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Atualiza;
    procedure btnConstruirClick(Sender: TObject);
    procedure btnTestarClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dsOCRDataChange(Sender: TObject; Field: TField);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure tblOCRAfterScroll(DataSet: TDataSet);
    procedure tblOCRBeforeOpen(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnPararClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    Carregado, Testando, Finaliza: Boolean;
    procedure Testar;
  public
    C, S: TBitmap;
    O: array[0..9] of TBitmap;
    InitialDir: string;
  end;

var
  FOCRTeste576: TFOCRTeste576;

implementation

uses
  UOCR;

{$R *.dfm}

procedure TFOCRTeste576.FormCreate(Sender: TObject);
var
  i: integer;
begin
  { Pasta de trabalho }
  InitialDir := ExtractFilePath(Application.ExeName) + 'Bitmaps\';

  { Bitmap de Convolução }
  C := TBitmap.Create;
  C.Width := 32;
  C.Height := 32;

  { Bitmap de Subamostragem }
  S := TBitmap.Create;
  S.Width := 16;
  S.Height := 16;

  { Cria os Ocelos de visão - 9 Ocelos 8x8 }
  for i := 0 to 9 do
  begin
    O[i] := TBitmap.Create;
    O[i].Width := 8;
    O[i].Height := 8;
  end;

  { Atualização da form }
  Atualiza;

  { Arquitetura da rede MLP }
  MLP.Struct.Clear;
  MLP.Struct.Add('576');
  MLP.Struct.Add('10');

  { Parâmetros de Treinamento }
  MLP.Learning := FOCR.Aprendizagem;
  MLP.Momentum := FOCR.Inercia;

  { Evento de atualização }
  dsOCR.OnDataChange := dsOCRDataChange;

  tblOCR.Open;
end;

procedure TFOCRTeste576.Atualiza;
var
  x, y: integer;
  Cor: TColor;
begin
  { Convolução }
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

  { 9 Ocelos de 8x8 deslocados de 4 pixels }
  { Ocelo 11 }
  for x := 0 to 7 do
    for y := 0 to 7 do
      O[0].Canvas.Pixels[x, y] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo11.Picture.Assign(O[0]);

  { Ocelo 21 }
  for x := 4 to 11 do
    for y := 0 to 7 do
      O[1].Canvas.Pixels[x - 4, y] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo12.Picture.Assign(O[1]);

  { Ocelo 31 }
  for x := 8 to 15 do
    for y := 0 to 7 do
      O[2].Canvas.Pixels[x - 8, y] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo13.Picture.Assign(O[2]);

  { Ocelo 12 }
  for x := 0 to 7 do
    for y := 4 to 11 do
      O[3].Canvas.Pixels[x, y - 4] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo21.Picture.Assign(O[3]);

  { Ocelo 22 }
  for x := 4 to 11 do
    for y := 4 to 11 do
      O[4].Canvas.Pixels[x - 4, y - 4] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo22.Picture.Assign(O[4]);

  { Ocelo 32 }
  for x := 8 to 15 do
    for y := 4 to 11 do
      O[5].Canvas.Pixels[x - 8, y - 4] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo23.Picture.Assign(O[5]);

  { Ocelo 11 }
  for x := 0 to 7 do
    for y := 8 to 15 do
      O[6].Canvas.Pixels[x, y - 8] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo31.Picture.Assign(O[6]);

  { Ocelo 21 }
  for x := 4 to 11 do
    for y := 8 to 15 do
      O[7].Canvas.Pixels[x - 4, y - 8] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo32.Picture.Assign(O[7]);

  { Ocelo 31 }
  for x := 8 to 15 do
    for y := 8 to 15 do
      O[8].Canvas.Pixels[x - 8, y - 8] := ImSubAmostra.Canvas.Pixels[x, y];
  ImOcelo33.Picture.Assign(O[8]);

end;

procedure TFOCRTeste576.btnConstruirClick(Sender: TObject);
var
  i: integer;
begin
  { Constrói a rede }
  MLP.Build;

  { Ajusta intervalo das entradas }
  for i := 1 to 576 do
    with MLP do
    begin
      SetInputMin(i, 0);
      SetInputMax(i, 1);
    end;

  { Ajusta intervalo das saídas }
  for i := 1 to 10 do
    with MLP do
    begin
      SetOutputMin(i, 0);
      SetOutputMax(i, 1);
    end;

  btnConstruir.Enabled := False;
  btnCarregar.Enabled := True;
end;

procedure TFOCRTeste576.btnTestarClick(Sender: TObject);
var
  i, j, k, n, SeqAnt: integer;
  Valor, Maior: double;
  IMaior, Erro, Cont: integer;
begin
  Erro := 0;
  Cont := 0;
  SeqAnt := 0;
  Finaliza := False;
  Testando := True;

  btnTestar.Enabled := False;
  btnParar.Enabled := True;
  DBGrid1.Enabled := False;
  tblOCR.AfterScroll := nil;

  try
    { Para cada caracter no arquivo }
    tblOCR.First;

    while not tblOCR.EOF do
    begin
      if Finaliza then
        Break;

      SeqAnt := tblOCRSequencia.AsInteger;

      Testar;

      //Atualiza;
      //Application.ProcessMessages;
      //
      //{ Alimenta a rede com os valores dos Ocelos }
      //for k := 0 to 8 do
      //  for i := 0 to 7 do
      //    for j := 0 to 7 do
      //    begin
      //      n := 64 * k + i * 8 + j + 1; // índice do neurônio de entrada
      //      MLP.SetInput(n, O[k].Canvas.Pixels[i, j] shr 23); // 0 ou 1
      //    end;
      //
      //MLP.Test;
      //
      //ed0.Text := Format('%2.4f', [MLP.GetOutput(1)]);
      //ed1.Text := Format('%2.4f', [MLP.GetOutput(2)]);
      //ed2.Text := Format('%2.4f', [MLP.GetOutput(3)]);
      //ed3.Text := Format('%2.4f', [MLP.GetOutput(4)]);
      //ed4.Text := Format('%2.4f', [MLP.GetOutput(5)]);
      //ed5.Text := Format('%2.4f', [MLP.GetOutput(6)]);
      //ed6.Text := Format('%2.4f', [MLP.GetOutput(7)]);
      //ed7.Text := Format('%2.4f', [MLP.GetOutput(8)]);
      //ed8.Text := Format('%2.4f', [MLP.GetOutput(9)]);
      //ed9.Text := Format('%2.4f', [MLP.GetOutput(10)]);
      //
      //{ Verifica a maior saída para indicação visual }
      //Maior := -10;
      //
      //for i := 1 to 10 do
      //begin
      //  Valor := MLP.GetOutput(i);
      //  if Valor > Maior then
      //  begin
      //    Maior := Valor;
      //    IMaior := i;
      //  end;
      //end;
      //
      //{ Todas com fundo branco }
      //ed0.Color := clWhite;
      //ed1.Color := clWhite;
      //ed2.Color := clWhite;
      //ed3.Color := clWhite;
      //ed4.Color := clWhite;
      //ed5.Color := clWhite;
      //ed6.Color := clWhite;
      //ed7.Color := clWhite;
      //ed8.Color := clWhite;
      //ed9.Color := clWhite;
      //
      //{ Exceto a maior }
      //case IMaior of
      //  1: ed0.Color := clYellow;
      //  2: ed1.Color := clYellow;
      //  3: ed2.Color := clYellow;
      //  4: ed3.Color := clYellow;
      //  5: ed4.Color := clYellow;
      //  6: ed5.Color := clYellow;
      //  7: ed6.Color := clYellow;
      //  8: ed7.Color := clYellow;
      //  9: ed8.Color := clYellow;
      //  10: ed9.Color := clYellow;
      //end;
      //
      //{ Grava o teste na tabela }
      //tblOCR.Edit;
      //tblOCR['Teste'] := IMaior - 1;
      //tblOCR.Post;

      { Incrementa erro de comparação }
      if tblOCR['Caracter'] <> tblOCR['Teste'] then
        Inc(Erro);

      Inc(Cont);
      StatusBar1.Panels[0].Text := 'Erro: ' + IntToStr(Erro) + '/' + IntToStr(Cont);

      tblOCR.Next;

      // Por que no evento afterScroll edita a tabela e tira o EOF após o Post
      if not Finaliza then
        Finaliza := SeqAnt = tblOCRSequencia.AsInteger;

      Application.ProcessMessages;
    end;
  finally
    tblOCR.AfterScroll := tblOCRAfterScroll;
    DBGrid1.Enabled := True;
    btnParar.Enabled := False;
    btnTestar.Enabled := True;
    Testando := False;
    Finaliza := False;
  end;
end;

procedure TFOCRTeste576.btnCarregarClick(Sender: TObject);
begin
  btnCarregar.Enabled := False;
  try
    MLP.Knowledge := ExtractFilePath(Application.ExeName) + '\OCR576.mlp';
    MLP.Load;
    Carregado := True;
  except
    btnCarregar.Enabled := True;
    Carregado := False;
  end;
  btnTestar.Enabled := True;
end;

procedure TFOCRTeste576.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FOCRTeste576 := nil;
end;

procedure TFOCRTeste576.dsOCRDataChange(Sender: TObject; Field: TField);
begin
  Atualiza;
end;

procedure TFOCRTeste576.DBGrid1CellClick(Column: TColumn);
begin
  Testar;
end;

procedure TFOCRTeste576.tblOCRBeforeOpen(DataSet: TDataSet);
begin
  tblOCR.DatabaseName := ExtractFilePath(Application.ExeName);
end;

procedure TFOCRTeste576.tblOCRAfterScroll(DataSet: TDataSet);
begin
  Testar;
end;

procedure TFOCRTeste576.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not Testando;
end;

procedure TFOCRTeste576.btnPararClick(Sender: TObject);
begin
  Finaliza := True;
end;

procedure TFOCRTeste576.Testar;
var
  i, j, k, n: integer;
  Valor, Maior: double;
  IMaior, Erro, Cont: integer;
begin
  if not Carregado then
    Exit;

  Atualiza;
  Application.ProcessMessages;

  { Alimenta a rede com os valores dos Ocelos }
  for k := 0 to 8 do
    for i := 0 to 7 do
      for j := 0 to 7 do
      begin
        n := 64 * k + i * 8 + j + 1; // índice do neurônio de entrada
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

  { Verifica a maior saída para indicação visual }
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

  { Grava o teste na tabela }
  tblOCR.Edit;
  tblOCR['Teste'] := IMaior - 1;
  tblOCR.Post;
end;

procedure TFOCRTeste576.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if (tblOCR['Teste'] <> NULL) and (tblOCR['Caracter'] <> tblOCR['Teste']) then
  begin
    DBGrid1.Canvas.Brush.Color := clRed;
    DBGrid1.Canvas.Font.Color := clWhite;
    DBGrid1.Canvas.FillRect(Rect);
    DBGrid1.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Column.Field.Text);
  end;
end;

end.

