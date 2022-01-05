unit uPoker;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, uBaralho, ImgList, ExtCtrls, ComCtrls;

type
  TPontuation = record
    Hand: string;
    Pontuation: Integer
  end;

  TStage = (stgBet, stgChangeCards, stgResult);

  TFrmPoker = class(TForm)
    pnlJogo3: TPanel;
    imgCard6: TImage;
    btnTroca: TSpeedButton;
    Panel1: TPanel;
    pnlJogo1: TPanel;
    lblCard1: TLabel;
    lblCard2: TLabel;
    lblCard3: TLabel;
    lblCard4: TLabel;
    lblCard5: TLabel;
    btnTroca1: TSpeedButton;
    btnTroca2: TSpeedButton;
    btnTroca3: TSpeedButton;
    btnTroca4: TSpeedButton;
    btnTroca5: TSpeedButton;
    btnTrocaTodas: TSpeedButton;
    imgCard1: TImage;
    imgCard2: TImage;
    imgCard3: TImage;
    imgCard4: TImage;
    imgCard5: TImage;
    btnInverteSelecao: TSpeedButton;
    lblResult: TLabel;
    Score: TPanel;
    lblSaldo2: TLabel;
    lblAposta2: TLabel;
    pnlJogo2: TPanel;
    btnMenos10: TSpeedButton;
    btnMais10: TSpeedButton;
    btnMenos50: TSpeedButton;
    btnMais50: TSpeedButton;
    btnMenos100: TSpeedButton;
    btnMais100: TSpeedButton;
    lblSaldo1: TLabel;
    lblAposta1: TLabel;
    lblNoGame1: TLabel;
    lblNoGame2: TLabel;
    lblNoGame3: TLabel;
    lblNoGame4: TLabel;
    lblNoGame5: TLabel;
    lblNoGame6: TLabel;
    lblNoGame7: TLabel;
    lblNoGame8: TLabel;
    Label9: TLabel;
    lblValGame1: TLabel;
    lblValGame2: TLabel;
    lblValGame3: TLabel;
    lblValGame4: TLabel;
    lblValGame5: TLabel;
    lblValGame6: TLabel;
    lblValGame7: TLabel;
    lblValGame8: TLabel;
    lblValGame9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnTrocaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgCard1Click(Sender: TObject);
    procedure imgCard2Click(Sender: TObject);
    procedure imgCard3Click(Sender: TObject);
    procedure imgCard4Click(Sender: TObject);
    procedure imgCard5Click(Sender: TObject);
    procedure btnTrocaTodasClick(Sender: TObject);
    procedure btnInverteSelecaoClick(Sender: TObject);
    procedure btnTroca1Click(Sender: TObject);
    procedure btnMenos10Click(Sender: TObject);
  private
    FNumCard: Byte;
    FStage: TStage;
    FCardsInHand: array[1..5] of TCards;
    FIdxCardsInHand: array[1..5] of Integer;
    FTotCards: array[TCardValues] of Byte;
    FTotNaipes: array[TCardNaipes] of Byte;
    FTotParesMenores, FTotParesMaiores, FTotTrincas, FTotQuadras, FPontos: Integer;
    FSaldo, FAposta: Integer;
    FMesmoNaipe: Boolean;
    procedure ChangeAll;
    procedure ChangeSelected;
    procedure ShowLabels;
    procedure SelectCards;
    procedure ShowCards;
    procedure ContaCards(Pontua: Boolean);
    procedure ShowScore;
    procedure ShowMemoScores;
    procedure ChangeTag(Button: TSpeedButton);
  public
  end;

var
  FrmPoker: TFrmPoker;

implementation

uses
  uImagens;

{$R *.dfm}

const
  HandResults: array[0..9] of TPontuation = (
    (Hand: 'Nada'; Pontuation: 0),
    (Hand: '1 par'; Pontuation: 1),
    (Hand: '2 pares'; Pontuation: 2),
    (Hand: 'Trinca'; Pontuation: 3),
    (Hand: 'Strait'; Pontuation: 4),
    (Hand: 'Flush'; Pontuation: 6),
    (Hand: 'Full Hand'; Pontuation: 9),
    (Hand: 'Quadra'; Pontuation: 10),
    (Hand: 'Straight Flush'; Pontuation: 15),
    (Hand: 'Royal Straight Flush'; Pontuation: 20)
    );

procedure TFrmPoker.FormCreate(Sender: TObject);
begin
  Caption := ' Poker';
  DMImagens.imgDecks.GetBitmap(12, imgCard6.Picture.Bitmap);
  btnMenos10.Caption := '-10'^j^m'F1';
  btnMais10.Caption := '+10'^j^m'F2';
  btnMenos50.Caption := '-50'^j^m'F5';
  btnMais50.Caption := '+50'^j^m'F6';
  btnMenos100.Caption := '-100'^j^m'F9';
  btnMais100.Caption := '+100'^j^m'F10';

  lblResult.Caption := '';
  btnTroca1.Caption := 'Troca'^j^m'F1';
  btnTroca2.Caption := 'Troca'^j^m'F2';
  btnTroca3.Caption := 'Troca'^j^m'F3';
  btnTroca4.Caption := 'Troca'^j^m'F4';
  btnTroca5.Caption := 'Troca'^j^m'F5';
  btnTrocaTodas.Caption := 'Marca todas'^j^m'F9';
  btnInverteSelecao.Caption := 'Inverte seleção'^j^m'F10';
  btnTroca.Caption := 'Jogar'^j^m'F11';

  FNumCard := 0;
  FSaldo := 1000;
  FAposta := 50;
  FStage := stgResult;
  Shuffling(flsRandom);
  btnTroca.Click;
  ShowScore;
end;

procedure TFrmPoker.ChangeSelected;
begin
  if btnTroca1.Tag = 1 then
  begin
    btnTroca1.Tag := 0;

    if FromTwoToOne then
      FCardsInHand[1] := FBaralho2[0]
    else
      FCardsInHand[1] := FBaralho1[0];

    Discard(0, False);
    Inc(FNumCard);
  end;

  if btnTroca2.Tag = 1 then
  begin
    btnTroca2.Tag := 0;

    if FromTwoToOne then
      FCardsInHand[2] := FBaralho2[0]
    else
      FCardsInHand[2] := FBaralho1[0];

    Discard(0, False);
    Inc(FNumCard);
  end;

  if btnTroca3.Tag = 1 then
  begin
    btnTroca3.Tag := 0;

    if FromTwoToOne then
      FCardsInHand[3] := FBaralho2[0]
    else
      FCardsInHand[3] := FBaralho1[0];

    Discard(0, False);
    Inc(FNumCard);
  end;

  if btnTroca4.Tag = 1 then
  begin
    btnTroca4.Tag := 0;

    if FromTwoToOne then
      FCardsInHand[4] := FBaralho2[0]
    else
      FCardsInHand[4] := FBaralho1[0];

    Discard(0, False);
    Inc(FNumCard);
  end;

  if btnTroca5.Tag = 1 then
  begin
    btnTroca5.Tag := 0;

    if FromTwoToOne then
      FCardsInHand[5] := FBaralho2[0]
    else
      FCardsInHand[5] := FBaralho1[0];

    Discard(0, False);
    Inc(FNumCard);
  end;

  ShowLabels;
  SelectCards;
  ContaCards(True);
end;

procedure TFrmPoker.ChangeAll;
begin
  btnTroca1.Tag := 0;
  btnTroca2.Tag := 0;
  btnTroca3.Tag := 0;
  btnTroca4.Tag := 0;
  btnTroca5.Tag := 0;

  if FromTwoToOne then
    FCardsInHand[1] := FBaralho2[0]
  else
    FCardsInHand[1] := FBaralho1[0];

  Discard(0, False);

  if FromTwoToOne then
    FCardsInHand[2] := FBaralho2[0]
  else
    FCardsInHand[2] := FBaralho1[0];

  Discard(0, False);

  if FromTwoToOne then
    FCardsInHand[3] := FBaralho2[0]
  else
    FCardsInHand[3] := FBaralho1[0];

  Discard(0, False);

  if FromTwoToOne then
    FCardsInHand[4] := FBaralho2[0]
  else
    FCardsInHand[4] := FBaralho1[0];

  Discard(0, False);

  if FromTwoToOne then
    FCardsInHand[5] := FBaralho2[0]
  else
    FCardsInHand[5] := FBaralho1[0];

  Discard(0, False);
  Inc(FNumCard, 5);
  ShowLabels;
  SelectCards;
  ContaCards(False);

  if lblResult.Caption = HandResults[0].Hand then
    lblResult.Caption := '';
end;

procedure TFrmPoker.btnTrocaClick(Sender: TObject);
begin
  if FStage = stgBet then
  begin
    if FNumCard > 40 then
    begin
      FNumCard := 0;
      Shuffling(flsRandom);
    end;

    FSaldo := FSaldo - FAposta;

    pnlJogo2.Visible := False;
    pnlJogo1.Visible := True;
    lblResult.Caption := '';
    lblCard1.Caption := '';
    lblCard2.Caption := '';
    lblCard3.Caption := '';
    lblCard4.Caption := '';
    lblCard5.Caption := '';
    lblResult.Visible := True;
    lblCard1.Visible := True;
    lblCard2.Visible := True;
    lblCard3.Visible := True;
    lblCard4.Visible := True;
    lblCard5.Visible := True;
    imgCard1.Visible := True;
    imgCard2.Visible := True;
    imgCard3.Visible := True;
    imgCard4.Visible := True;
    imgCard5.Visible := True;
    btnTroca1.Visible := True;
    btnTroca2.Visible := True;
    btnTroca3.Visible := True;
    btnTroca4.Visible := True;
    btnTroca5.Visible := True;
    btnTrocaTodas.Visible := True;
    btnInverteSelecao.Visible := True;
    Application.ProcessMessages;
    ChangeAll;
    ShowScore;
    btnTroca.Caption := 'Trocar cartas'^j^m'F11';
    FStage := stgChangeCards;
  end
  else if FStage = stgChangeCards then
  begin
    ChangeSelected;
    btnTroca1.Visible := False;
    btnTroca2.Visible := False;
    btnTroca3.Visible := False;
    btnTroca4.Visible := False;
    btnTroca5.Visible := False;
    btnTrocaTodas.Visible := False;
    btnInverteSelecao.Visible := False;
    btnTroca.Caption := 'Apostar'^j^m'F11';
    FStage := stgResult;
  end
  else
  begin
    pnlJogo1.Visible := False;
    pnlJogo2.Visible := True;
    DMImagens.imgDecks.GetBitmap(12, imgCard1.Picture.Bitmap);
    DMImagens.imgDecks.GetBitmap(12, imgCard2.Picture.Bitmap);
    DMImagens.imgDecks.GetBitmap(12, imgCard3.Picture.Bitmap);
    DMImagens.imgDecks.GetBitmap(12, imgCard4.Picture.Bitmap);
    DMImagens.imgDecks.GetBitmap(12, imgCard5.Picture.Bitmap);
    imgCard1.Tag := 1;
    imgCard2.Tag := 1;
    imgCard3.Tag := 1;
    imgCard4.Tag := 1;
    imgCard5.Tag := 1;
    btnTroca.Caption := 'Jogar'^j^m'F11';
    ShowMemoScores;
    FStage := stgBet;
  end;
end;

procedure TFrmPoker.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Shift = [] then
  begin
    if FStage = stgChangeCards then
    begin
      if key = VK_F1 then
      begin
        Key := 0;

        if btnTroca1.Enabled then
        begin
          ChangeTag(btnTroca1);
          ShowCards;
        end;
      end
      else if key = VK_F2 then
      begin
        Key := 0;

        if btnTroca2.Enabled then
        begin
          ChangeTag(btnTroca2);
          ShowCards;
        end;
      end
      else if key = VK_F3 then
      begin
        Key := 0;

        if btnTroca3.Enabled then
        begin
          ChangeTag(btnTroca3);
          ShowCards;
        end;
      end
      else if key = VK_F4 then
      begin
        Key := 0;

        if btnTroca4.Enabled then
        begin
          ChangeTag(btnTroca4);
          ShowCards;
        end;
      end
      else if key = VK_F5 then
      begin
        Key := 0;

        if btnTroca5.Enabled then
        begin
          ChangeTag(btnTroca5);
          ShowCards;
        end;
      end
      else if key = VK_F9 then
      begin
        Key := 0;

        if btnTrocaTodas.Enabled then
          btnTrocaTodas.Click;
      end
      else if key = VK_F10 then
      begin
        Key := 0;

        if btnInverteSelecao.Enabled then
        begin
          ChangeTag(btnTroca1);
          ChangeTag(btnTroca2);
          ChangeTag(btnTroca3);
          ChangeTag(btnTroca4);
          ChangeTag(btnTroca5);
          ShowCards;
        end;
      end;
    end
    else if FStage = stgBet then
    begin
      if key = VK_F1 then
      begin
        Key := 0;

        if btnMenos10.Enabled then
          btnMenos10.Click;
      end
      else if key = VK_F2 then
      begin
        Key := 0;

        if btnMais10.Enabled then
          btnMais10.Click;
      end
      else if key = VK_F5 then
      begin
        Key := 0;

        if btnMenos50.Enabled then
          btnMenos50.Click;
      end
      else if key = VK_F6 then
      begin
        Key := 0;

        if btnMais50.Enabled then
          btnMais50.Click;
      end
      else if key = VK_F9 then
      begin
        Key := 0;

        if btnMenos100.Enabled then
          btnMenos100.Click;
      end
      else if key = VK_F10 then
      begin
        Key := 0;

        if btnMais100.Enabled then
          btnMais100.Click;
      end;
    end;

    if key = VK_F11 then
    begin
      Key := 0;
      btnTroca.Click;
    end;
  end;
end;

procedure TFrmPoker.ShowLabels;
begin
  lblCard1.Caption := TStrValues[FCardsInHand[1].CardValue] + ' de ' + TStrNaipes[FCardsInHand[1].CardNaipe];
  lblCard2.Caption := TStrValues[FCardsInHand[2].CardValue] + ' de ' + TStrNaipes[FCardsInHand[2].CardNaipe];
  lblCard3.Caption := TStrValues[FCardsInHand[3].CardValue] + ' de ' + TStrNaipes[FCardsInHand[3].CardNaipe];
  lblCard4.Caption := TStrValues[FCardsInHand[4].CardValue] + ' de ' + TStrNaipes[FCardsInHand[4].CardNaipe];
  lblCard5.Caption := TStrValues
    [FCardsInHand[5].CardValue] + ' de ' + TStrNaipes[FCardsInHand[5].CardNaipe];
end;

procedure TFrmPoker.SelectCards;
begin
  FIdxCardsInHand[1] := (Ord(FCardsInHand[1].CardNaipe) * 13) + Ord(FCardsInHand[1].CardValue);
  FIdxCardsInHand[2] := (Ord(FCardsInHand[2].CardNaipe) * 13) + Ord(FCardsInHand[2].CardValue);
  FIdxCardsInHand[3] := (Ord(FCardsInHand[3].CardNaipe) * 13) + Ord(FCardsInHand[3].CardValue);
  FIdxCardsInHand[4] := (Ord(FCardsInHand[4].CardNaipe) * 13) + Ord(FCardsInHand[4].CardValue);
  FIdxCardsInHand[5] := (Ord(FCardsInHand[5].CardNaipe) * 13) + Ord(FCardsInHand[5].CardValue);
  ShowCards;
end;

procedure TFrmPoker.ShowCards;
begin
  Enabled := False;

  try
    imgCard1.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
    imgCard2.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
    imgCard3.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
    imgCard4.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
    imgCard5.Picture.Bitmap.Canvas.Brush.Style := bsSolid;

    if btnTroca1.Tag = 1 then
    begin
      if imgCard1.Tag = 2 then
      begin
        DMImagens.imgDecks.GetBitmap(12, imgCard1.Picture.Bitmap);
        imgCard1.Tag := -1;
      end
    end
    else if imgCard1.Tag = 1 then
    begin
      DMImagens.imgCards.GetBitmap(FIdxCardsInHand[1], imgCard1.Picture.Bitmap);
      imgCard1.Tag := -2;
    end;

    if imgCard1.Tag < 0 then
    begin
      imgCard1.Refresh;
      Sleep(100);
      imgCard1.Tag := Abs(imgCard1.Tag);
    end;

    if btnTroca2.Tag = 1 then
    begin
      if imgCard2.Tag = 2 then
      begin
        DMImagens.imgDecks.GetBitmap(12, imgCard2.Picture.Bitmap);
        imgCard2.Tag := -1;
      end;
    end
    else if imgCard2.Tag = 1 then
    begin
      DMImagens.imgCards.GetBitmap(FIdxCardsInHand[2], imgCard2.Picture.Bitmap);
      imgCard2.Tag := -2;
    end;

    if imgCard2.Tag < 0 then
    begin
      imgCard2.Refresh;
      Sleep(100);
      imgCard2.Tag := Abs(imgCard2.Tag);
    end;

    if btnTroca3.Tag = 1 then
    begin
      if imgCard3.Tag = 2 then
      begin
        DMImagens.imgDecks.GetBitmap(12, imgCard3.Picture.Bitmap);
        imgCard3.Tag := -1;
      end;
    end
    else if imgCard3.Tag = 1 then
    begin
      DMImagens.imgCards.GetBitmap(FIdxCardsInHand[3], imgCard3.Picture.Bitmap);
      imgCard3.Tag := -2;
    end;

    if imgCard3.Tag < 0 then
    begin
      imgCard3.Refresh;
      Sleep(100);
      imgCard3.Tag := Abs(imgCard3.Tag);
    end;

    if btnTroca4.Tag = 1 then
    begin
      if imgCard4.Tag = 2 then
      begin
        DMImagens.imgDecks.GetBitmap(12, imgCard4.Picture.Bitmap);
        imgCard4.Tag := -1;
      end;
    end
    else if imgCard4.Tag = 1 then
    begin
      DMImagens.imgCards.GetBitmap(FIdxCardsInHand[4], imgCard4.Picture.Bitmap);
      imgCard4.Tag := -2;
    end;

    if imgCard4.Tag < 0 then
    begin
      imgCard4.Refresh;
      Sleep(100);
      imgCard4.Tag := Abs(imgCard4.Tag);
    end;

    if btnTroca5.Tag = 1 then
    begin
      if imgCard5.Tag = 2 then
      begin
        DMImagens.imgDecks.GetBitmap(12, imgCard5.Picture.Bitmap);
        imgCard5.Tag := -1;
      end;
    end
    else if imgCard5.Tag = 1 then
    begin
      DMImagens.imgCards.GetBitmap(FIdxCardsInHand[5], imgCard5.Picture.Bitmap);
      imgCard5.Tag := -2;
    end;

    if imgCard5.Tag < 0 then
    begin
      imgCard5.Refresh;
      Sleep(100);
      imgCard5.Tag := Abs(imgCard5.Tag);
    end;
  finally
    Enabled := True;
  end;
end;

procedure TFrmPoker.imgCard1Click(Sender: TObject);
begin
  if btnTroca1.Enabled then
  begin
    ChangeTag(btnTroca1);
    ShowCards;
  end;
end;

procedure TFrmPoker.imgCard2Click(Sender: TObject);
begin
  if btnTroca2.Enabled then
  begin
    ChangeTag(btnTroca2);
    ShowCards;
  end;
end;

procedure TFrmPoker.imgCard3Click(Sender: TObject);
begin
  if btnTroca3.Enabled then
  begin
    ChangeTag(btnTroca3);
    ShowCards;
  end;
end;

procedure TFrmPoker.imgCard4Click(Sender: TObject);
begin
  if btnTroca4.Enabled then
  begin
    ChangeTag(btnTroca4);
    ShowCards;
  end;
end;

procedure TFrmPoker.imgCard5Click(Sender: TObject);
begin
  if btnTroca5.Enabled then
  begin
    ChangeTag(btnTroca5);
    ShowCards;
  end;
end;

procedure TFrmPoker.btnTrocaTodasClick(Sender: TObject);
begin
  btnTroca1.Tag := 1;
  btnTroca2.Tag := 1;
  btnTroca3.Tag := 1;
  btnTroca4.Tag := 1;
  btnTroca5.Tag := 1;
  ShowCards;
end;

procedure TFrmPoker.btnInverteSelecaoClick(Sender: TObject);
begin
  btnTroca1.Down := not btnTroca1.Down;
  btnTroca2.Down := not btnTroca2.Down;
  btnTroca3.Down := not btnTroca3.Down;
  btnTroca4.Down := not btnTroca4.Down;
  btnTroca5.Down := not btnTroca5.Down;
  ShowCards;
end;

procedure TFrmPoker.ContaCards(Pontua: Boolean);
var
  i, FIniSeq: TCardValues;
  n: TCardNaipes;
  x, FSeq: Integer;
begin
  for i := Low(TCardValues) to High(TCardValues) do
    FTotCards[i] := 0;

  for n := Low(TCardNaipes) to High(TCardNaipes) do
    FTotNaipes[n] := 0;

  FTotParesMenores := 0;
  FTotParesMaiores := 0;
  FTotTrincas := 0;
  FTotQuadras := 0;
  FPontos := 0;
  FMesmoNaipe := False;

  for x := Low(FCardsInHand) to High(FCardsInHand) do
  begin
    Inc(FTotCards[FCardsInHand[x].CardValue]);
    Inc(FTotNaipes[FCardsInHand[x].CardNaipe]);
  end;

  for n := Low(TCardNaipes) to High(TCardNaipes) do
    if FTotNaipes[n] = 5 then
    begin
      FMesmoNaipe := True;
      Break;
    end;

  for i := Low(TCardValues) to High(TCardValues) do
  begin
    if FTotCards[i] = 2 then
    begin
      if (i >= vcJack) or (i = vcAce) then
        Inc(FTotParesMaiores)
      else
        Inc(FTotParesMenores);
    end
    else if FTotCards[i] = 3 then
      Inc(FTotTrincas)
    else if FTotCards[i] = 4 then
      Inc(FTotQuadras);
  end;

  if FMesmoNaipe then
  begin
    FIniSeq := Succ(Low(TCardValues));

    for i := Succ(Low(TCardValues)) to High(TCardValues) do
      if FTotCards[i] > 0 then
      begin
        FIniSeq := i;
        Break
      end;

    FSeq := 0;

    for i := FIniSeq to High(TCardValues) do
      if FTotCards[i] > 0 then
        Inc(FSeq)
      else
        Break;

    if FSeq = 5 then
      FPontos := 5 // Flush
    else if (FSeq = 4) and (FTotCards[Low(TCardValues)] > 0) then
      FPontos := 8 // Royal Straight Flush
    else
      FPontos := 9; // Straight Flush
  end
  else if (FTotParesMaiores + FTotParesMenores) = 2 then
    FPontos := 2 // Dois pares
  else if (FTotParesMaiores = 1) and (FTotTrincas = 0) then
    FPontos := 1 // Um par
  else if ((FTotParesMaiores + FTotParesMenores) = 1) and (FTotTrincas = 1) then
    FPontos := 6 // Full hand
  else if FTotTrincas = 1 then
    FPontos := 3 // Trinca
  else if FTotQuadras = 1 then
    FPontos := 7 // Quadra
  else
  begin
    FIniSeq := Succ(Low(TCardValues));

    for i := Succ(Low(TCardValues)) to High(TCardValues) do
      if FTotCards[i] > 0 then
      begin
        FIniSeq := i;
        Break
      end;

    FSeq := 0;

    for i := FIniSeq to High(TCardValues) do
      if FTotCards[i] > 0 then
        Inc(FSeq)
      else
        Break;

    if FSeq = 5 then
      FPontos := 4 // Strait
  end;

  lblResult.Caption := HandResults[FPontos].Hand;

  if Pontua then
    if FPontos > 0 then
    begin
      FSaldo := FSaldo + FAposta * HandResults[FPontos].Pontuation;
      lblResult.Caption := lblResult.Caption +
        Format(' ($%d)', [FAposta * HandResults[FPontos].Pontuation]);

      {
       + Format(' ($%d * %d = $%d)', [FAposta,
       HandResults[FPontos].Pontos,
         FAposta * HandResults[FPontos].Pontos]);
      }
    end;

  ShowScore;
end;

procedure TFrmPoker.ShowScore;
begin
  lblSaldo2.Caption := Format('$%d', [FSaldo]);
  lblAposta2.Caption := Format('$%d', [FAposta]);
end;

procedure TFrmPoker.btnTroca1Click(Sender: TObject);
begin
  with TSpeedButton(Sender) do
    if Tag = 0 then
      Tag := 1
    else
      Tag := 0;

  ShowCards;
end;

procedure TFrmPoker.btnMenos10Click(Sender: TObject);
begin
  with TSpeedButton(Sender) do
  begin
    if (FSaldo - Tag >= 0) and (FAposta + Tag > 0) and (FSaldo - (FAposta + Tag) >= 0) then
    begin
      Inc(FAposta, Tag);
      ShowScore;
    end;
  end;

  ShowMemoScores;
end;

procedure TFrmPoker.ShowMemoScores;
begin
  lblValGame1.Caption := IntToStr(HandResults[1].Pontuation * FAposta);
  lblValGame2.Caption := IntToStr(HandResults[2].Pontuation * FAposta);
  lblValGame3.Caption := IntToStr(HandResults[3].Pontuation * FAposta);
  lblValGame4.Caption := IntToStr(HandResults[4].Pontuation * FAposta);
  lblValGame5.Caption := IntToStr(HandResults[5].Pontuation * FAposta);
  lblValGame6.Caption := IntToStr(HandResults[6].Pontuation * FAposta);
  lblValGame7.Caption := IntToStr(HandResults[7].Pontuation * FAposta);
  lblValGame8.Caption := IntToStr(HandResults[8].Pontuation * FAposta);
  lblValGame9.Caption := IntToStr(HandResults[9].Pontuation * FAposta);
end;

procedure TFrmPoker.ChangeTag(Button: TSpeedButton);
begin
  if Button.Tag = 0 then
    Button.Tag := 1
  else
    Button.Tag := 0;
end;

end.

