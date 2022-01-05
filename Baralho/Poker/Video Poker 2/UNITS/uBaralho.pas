unit uBaralho;

interface

uses
  SysUtils;

type
  TCardNaipes = (npOuros, npEspadas, npPaus, npCopas, npNone);
  TCardValues = (vcAce, vcTwo, vcThree, vcFour, vcFive, vcSix, vcSeven,
    vcEight, vcNine, vcTem, vcJack, vcQuenn, vcKing, vcJoker, vcNone);
  TFlushingMode = (flsRandom, flsBetween);

  TCards = record
    CardValue: TCardValues;
    CardNaipe: TCardNaipes;
  end;

const
  TStrNaipes: array[TCardNaipes] of string = ('Ouros', 'Espadas', 'Paus', 'Copas', '');
  TStrValues: array[TCardValues] of string = ('A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'Jk', '');

var
  FValuesCards: array[TCardValues] of Byte;
  FNaipesCards: array[TCardNaipes] of Byte;
  FBaralho1, FBaralho2, FBaralho3: array of TCards;
  FromTwoToOne: Boolean;

procedure Shuffling(FlushingMode: TFlushingMode);
procedure Discard(NumCard: Byte; FJoker: Boolean);

implementation

procedure ShufflingTwoToOne;
begin
  Randomize;

  if Length(FBaralho2) > 0 then
    while Length(FBaralho1) > 0 do
    begin
      SetLength(FBaralho2, Length(FBaralho2) + 1);
      FBaralho2[High(FBaralho2)] := FBaralho1[High(FBaralho1)];
      SetLength(FBaralho1, Length(FBaralho1) - 1);
    end;

  while Length(FBaralho2) > 0 do
    Discard(Random(Length(FBaralho2)), True);
end;

procedure ShufflingOneToTwo;
begin
  Randomize;

  if Length(FBaralho1) > 0 then
    while Length(FBaralho2) > 0 do
    begin
      SetLength(FBaralho1, Length(FBaralho1) + 1);
      FBaralho1[High(FBaralho1)] := FBaralho2[High(FBaralho2)];
      SetLength(FBaralho2, Length(FBaralho2) - 1);
    end;

  while Length(FBaralho1) > 0 do
    Discard(Random(Length(FBaralho1)), True);
end;

procedure Shuffling3;
var
  v, i, n: Integer;
begin
  if FromTwoToOne then
  begin
    if Length(FBaralho2) > 0 then
      while Length(FBaralho1) > 0 do
      begin
        SetLength(FBaralho2, Length(FBaralho2) + 1);
        FBaralho2[High(FBaralho2)] := FBaralho1[High(FBaralho1)];
        SetLength(FBaralho1, Length(FBaralho1) - 1);
      end;

    SetLength(FBaralho1, Length(FBaralho2));

    for i := Low(FBaralho2) to High(FBaralho2) do
      FBaralho1[i] := FBaralho2[i];

    SetLength(FBaralho2, 0);
    FromTwoToOne := False;
  end;

  Randomize;
  v := Random(4) + 1;

  for i := 0 to v do
  begin
    SetLength(FBaralho3, 1);
    FBaralho3[0] := FBaralho1[0];

    for n := 1 to (Length(FBaralho1) - 1) div 2 do
    begin
      SetLength(FBaralho3, Length(FBaralho3) + 1);
      FBaralho3[High(FBaralho3)] := Fbaralho1[n];
      SetLength(FBaralho3, Length(FBaralho3) + 1);
      FBaralho3[High(FBaralho3)] := Fbaralho1[n + 26];
    end;

    for n := Low(FBaralho1) to High(FBaralho1) do
      FBaralho1[n] := FBaralho3[n];
  end;

  SetLength(FBaralho3, 0);
end;

procedure Shuffling(FlushingMode: TFlushingMode);
begin
  if FlushingMode = flsRandom then
  begin
    if FromTwoToOne then
      ShufflingTwoToOne
    else
      ShufflingOneToTwo;

    FromTwoToOne := not FromTwoToOne;
  end
  else
    Shuffling3;
end;

procedure Discard(NumCard: Byte; FJoker: Boolean);
var
  i: Integer;
begin
  if FromTwoToOne then
  begin
    if Length(FBaralho2) = 0 then
      raise Exception.Create('No more cards available');

    if NumCard >= Length(FBaralho2) then
      raise Exception.Create('Invalid card');

    SetLength(FBaralho1, Length(FBaralho1) + 1);
    FBaralho1[High(FBaralho1)] := FBaralho2[NumCard];

    if NumCard < Length(FBaralho2) - 1 then
      for i := NumCard to Length(FBaralho2) - 2 do
        FBaralho2[i] := FBaralho2[i + 1];

    SetLength(FBaralho2, Length(FBaralho2) - 1);

    if Length(FBaralho2) = 0 then
      Exit;

    if NumCard = Length(FBaralho2) then
      Dec(NumCard);

    if (FBaralho2[NumCard].CardValue = vcJoker) and not FJoker then
      Discard(NumCard, True);
  end
  else
  begin
    if Length(FBaralho1) = 0 then
      raise Exception.Create('No more cards available');

    if NumCard >= Length(FBaralho1) then
      raise Exception.Create('Invalid card');

    SetLength(FBaralho2, Length(FBaralho2) + 1);
    FBaralho2[High(FBaralho2)] := FBaralho1[NumCard];

    if NumCard < Length(FBaralho1) - 1 then
      for i := NumCard to Length(FBaralho1) - 2 do
        FBaralho1[i] := FBaralho1[i + 1];

    SetLength(FBaralho1, Length(FBaralho1) - 1);

    if Length(FBaralho1) = 0 then
      Exit;

    if NumCard = Length(FBaralho1) then
      Dec(NumCard);

    if (FBaralho1[NumCard].CardValue = vcJoker) and not FJoker then
      Discard(NumCard, True)
  end
end;

procedure inicializa;
var
  valor: TCardValues;
  naipe: TCardNaipes;
begin
  SetLength(FBaralho1, 0);
  SetLength(FBaralho2, 0);

  for naipe := npOuros to npCopas do
    for valor := vcAce to vcKing do
    begin
      SetLength(FBaralho1, Length(FBaralho1) + 1);
      FBaralho1[High(FBaralho1)].CardValue := valor;
      FBaralho1[High(FBaralho1)].CardNaipe := naipe;
    end;

  SetLength(FBaralho1, Length(FBaralho1) + 1);
  FBaralho1[High(FBaralho1)].CardNaipe := npNone;
  FBaralho1[High(FBaralho1)].CardValue := vcJoker;
  FromTwoToOne := False;
  SetLength(FBaralho3, Length(FBaralho1));
end;

initialization
  inicializa;

end.

