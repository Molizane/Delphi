//*****************************************************************
//   Unit : 3 Fuzzy Components
//        TCustomFuzzy, TFuzzyfication and TFuzzySolution
//   by Alexandre Beauvois 14/06/1998
//*****************************************************************

unit FuzzyComp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

const
  MaxMembers = 15;
  AxeMargeX = 0;
  AxeMargeY = 20;
  AxeInfinity = 999999999;
  MaxPoints = 100;

type
  TAxe = class
  private
  public
    FMin, FMax: Single;
    FUnite: Integer;
    FWidth: Integer;
    FHomo: Single;
    constructor Create;
    function GetMin: Single;
    function GetMax: Single;
    procedure SetMinMax(A, B: Single);
    procedure SetWidth(W: Integer);
    function Scale(P: Single): Integer;
  end;

  TMemberType = (tmLInfinity, tmTriangle, tmRInfinity);

  TMember = class(TCollectionItem)
  private
    FA, FB: Single;
    FMiddle: Single;
    FColor: TColor;
    FName: string;
    FType: TMemberType;
    procedure SetColor(C: TColor);
    procedure SetName(N: string);
    procedure SetType(T: TMemberType);
    procedure SetMiddle(M: Single);
    procedure SetStartMember(A: Single);
  public
    constructor Create(Collection: TCollection); override;
    function OwnerShip(P: Single): Single;
    procedure Assign(Source: TPersistent); override;
  published
    property Color: TColor read FColor write SetColor;
    property Name: string read FName write SetName;
    property MemberType: TMemberType read FType write SetType;
    property StartMember: Single read FA write SetStartMember;
    property Middle: Single read FMiddle write SetMiddle nodefault;
  end;

  TCustomFuzzy = class;

  TMembers = class(TCollection)
    FFuzzy: TCustomFuzzy;
    function GetItem(Index: Integer): TMember;
    procedure SetItem(Index: Integer; Value: TMember);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Fuzzy: TCustomFuzzy);
    function GetMemberIndex(N: string): Integer;
    function Add: TMember;
    property Items[Index: Integer]: TMember read GetItem write SetItem; default;
  end;

  TFuzzyType = (ftFuzzyfication, ftFuzzySolution);
  TFuzzyResults = array[0..MaxMembers - 1] of Single;

  TCustomFuzzy = class(TCustomControl)
  private
    FOnChange: TNotifyEvent;
    FMembers: TMembers;
    FFuzzyName: string;
    procedure SetMembers(Value: TMembers);
    procedure SetMaxi(X: Single);
    function GetMaxi: Single;
    procedure SetMini(X: Single);
    function GetMini: Single;
    procedure SetFuzzyName(FN: string);
  public
    Axe: TAxe;
    constructor Create(AOwner: TComponent); override;
    procedure AddMember(N: string; M, A: Single; T: TMemberType);
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    function ScaleY(P: Single): Integer;
    destructor Destroy; override;
  protected
    procedure Paint; override;
    procedure UpdateMember(Index: Integer);
    procedure Change; dynamic;
    property Maxi: Single read GetMaxi write SetMaxi;
    property Mini: Single read GetMini write SetMini;
    property Members: TMembers read FMembers write SetMembers;
  published
    property Align;
    property Anchors;
    property Color;
    property ShowHint;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property FuzzyName: string read FFuzzyName write SetFuzzyName;
  end;

  TFuzzyfication = class(TCustomFuzzy)
  private
    FRealInput: Single;
    FOutputs: TFuzzyResults;
    FFuzzyType: TFuzzyType;
    procedure SetRealInput(X: Single);
    procedure SetOutPuts(Index: Integer; Y: Single);
    function GetOutputs(Index: Integer): Single;
  protected
    procedure Paint; override;
    procedure WMMButtonDown(var Msg: TMessage); message WM_LbuttonDown;
  public
    property FuzzyType: TFuzzyType read FFuzzyType write FFuzzyType;
    property Outputs[Index: Integer]: Single read GetOutputs write SetOutputs;
    constructor Create(AOwner: TComponent); override;
  published
    property Maxi;
    property Mini;
    property Members;
    property RealInput: Single read FRealInput write SetRealInput;
    property OnChange;
  end;

  TFuzzySolution = class(TCustomFuzzy)
  private
    FRealOutput: Single;
    FCompatibility: Single;
    FFuzzyType: TFuzzyType;
    FXValues, FYValues: array[0..MaxPoints - 1] of Single;
    FNbPoints: Integer;
    FDeltaX: Single;
    procedure SetDeltaX(D: Single);
    function GetRealOutput: Single;
  protected
    procedure Paint; override;
  public
    property FuzzyType: TFuzzyType read FFuzzyType write FFuzzyType;
    procedure FuzzyAgregate(MemberIndex: Integer; AlphaCut: Single);
    procedure ClearSolution;
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property Color;
    property Maxi;
    property Mini;
    property Members;
    property RealOutput: Single read GetRealOutput write FRealOutput;
    property OnChange;
    property Compatibility: Single read FCompatibility write FCompatibility;
    property DeltaX: Single read FDeltaX write SetDeltaX;
  end;

procedure Register;

implementation

uses
  Math;

procedure Register;
begin
  RegisterComponents('FuzzyComp', [TCustomFuzzy]);
  RegisterComponents('FuzzyComp', [TFuzzyfication]);
  RegisterComponents('FuzzyComp', [TFuzzySolution]);
end;

{****************** TAxe ********************}

constructor TAxe.Create;
begin
  inherited Create;

  FMin := 0;
  FMax := 0;
  FHomo := 1;
  FUnite := 10;
end;

function TAxe.GetMin: Single;
begin
  Result := FMin;
end;

function TAxe.GetMax: Single;
begin
  Result := FMax;
end;

procedure Taxe.SetMinMax(A, B: Single);
begin
  if A <= B then
  begin
    FMin := A;
    FMax := B;
  end
  else
  begin
    FMin := B;
    FMax := A;
  end;

  if (FMax - FMin) <> 0 then
    FHomo := FWidth / (FMax - FMin)
  else
    FHomo := 0;
end;

procedure TAxe.SetWidth(W: Integer);
begin
  FWidth := W;
end;

function TAxe.Scale(P: Single): Integer;
var
  RUnit: Single;
begin
  RUnit := FMax - FMin;

  if RUnit <> 0 then
    Result := Round((P - FMin) / RUnit * FWidth)
  else
    Result := 0;
end;

{****************** TMember ********************}

constructor TMember.Create(Collection: TCollection);
begin
  FColor := clWhite;
  FName := 'New';
  FType := tmTriangle;
  FA := 0;
  FB := 0;
  FMiddle := 0;

  inherited Create(Collection);
end;

procedure TMember.SetName(N: string);
begin
  FName := N;
  Changed(False);
end;

procedure TMember.SetColor(C: TColor);
begin
  FColor := C;
  Changed(False);
end;

procedure TMember.SetType(T: TMemberType);
begin
  FType := T;
  Changed(True);
end;

procedure TMember.SetMiddle(M: Single);
begin
  //if M <= FA then FA := M;
  FMiddle := M;
  FB := 2 * FMiddle - FA;
  Changed(True);
end;

procedure TMember.SetStartMember(A: Single);
begin
  //if A >= FMiddle then FMiddle := A;
  FA := A;
  FB := 2 * FMiddle - FA;
  Changed(True);
end;

procedure TMember.Assign(Source: TPersistent);
begin
  if Source is TMember then
  begin
    SetMiddle(TMember(Source).FMiddle);
    SetStartMember(TMember(Source).FA);
    FColor := TMember(Source).FColor;
    FName := TMember(Source).FName;
    FType := TMember(Source).FType;
    Exit;
  end;

  inherited Assign(Source);
end;

function TMember.OwnerShip(P: Single): Single;
begin
  Result := 0;

  {si la forme de la fonction d'appartenance est Triangulaire !}
  if ((FMiddle - FA) <> 0) and (P > FA) and (P < FB) then
  begin
    if P < FMiddle then
      Result := (P - FA) / (FMiddle - FA);

    if P > FMiddle then
      Result := (FB - P) / (FB - FMiddle);
  end;

  if (P <= FA) or (P >= FB) then
    Result := 0; {si P est hors du segment...}

  if (FType = tmLInfinity) and (P <= FMiddle) then
    Result := 1;

  if (FType = tmRInfinity) and (P >= FMiddle) then
    Result := 1;

  if P = FMiddle then
    Result := 1;
end;
{****************** TMembers ********************}

constructor TMembers.Create(Fuzzy: TCustomFuzzy);
begin
  inherited Create(TMember);

  FFuzzy := Fuzzy;
end;

function TMembers.Add: TMember;
begin
  Result := TMember(inherited Add);
end;

function TMembers.GetItem(Index: Integer): TMember;
begin
  Result := TMember(inherited GetItem(Index));
end;

procedure TMembers.SetItem(Index: Integer; Value: TMember);
begin
  inherited SetItem(Index, Value);
end;

function TMembers.GetOwner: TPersistent;
begin
  Result := FFuzzy;
end;

procedure TMembers.Update(Item: TCollectionItem);
begin
  if not Assigned(Item) then
    Exit;

  {
  if Item <> nil then
    FFuzzy.UpdateMember(Item.Index);
  }
  try
    if TMember(Item).StartMember < FFuzzy.Mini then
      FFuzzy.Mini := TMember(Item).StartMember;

    if TMember(Item).Middle + Abs(TMember(Item).StartMember) > FFuzzy.Maxi then
      FFuzzy.Maxi := TMember(Item).Middle + Abs(TMember(Item).StartMember);
  except
  end;

  FFuzzy.Invalidate;
  {
  else
    FStatusBar.UpdateMembers;
  }
end;

function TMembers.GetMemberIndex(N: string): Integer;
var
  i: Integer;
begin
  Result := -1;

  for i := 0 to count - 1 do
    if TMember(Items[i]).Name = N then
    begin
      Result := i;
      Exit;
    end;
end;

{*************************** TCustomFuzzy **************************}

constructor TCustomFuzzy.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Parent := TWinControl(AOwner);
  Axe := TAxe.Create;
  FMembers := TMembers.Create(Self);
  SetBounds(0, 0, 170, 100);
  AddMember('Low', 0, -20, tmLInfinity);
  AddMember('Null', 50, 0, tmTriangle);
  AddMember('High', 80, 50, tmRInfinity);
end;

procedure TCustomFuzzy.SetFuzzyName(FN: string);
begin
  FFuzzyName := FN;
  Invalidate;
end;

procedure TCustomFuzzy.SetMembers(Value: TMembers);
begin
  FMembers.Assign(Value);
end;

procedure TCustomfuzzy.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TCustomFuzzy.UpdateMember(Index: Integer);
begin
  Invalidate;
end;

procedure TCustomFuzzy.SetMaxi(X: Single);
begin
  Axe.SetMinMax(Axe.GetMin, X);
  Invalidate;
end;

function TCustomFuzzy.GetMaxi: Single;
begin
  Result := Axe.GetMax;
end;

procedure TCustomFuzzy.SetMini(X: Single);
begin
  Axe.SetMinMax(X, Axe.GetMax);
  Invalidate;
end;

function TCustomFuzzy.GetMini: Single;
begin
  Result := Axe.GetMin;
end;

function TCustomFuzzy.ScaleY(P: Single): Integer;
begin
  if Height <> 0 then
    Result := Round(Height - AxeMargeY - P * (Height - AxeMargeY))
  else
    Result := 0;
end;

procedure TCustomFuzzy.AddMember(N: string; M, A: Single; T: TMemberType);
var
  NewMember: TMember;
  FBMax: Single;
  i: Integer;
begin
  NewMember := FMembers.Add;

  if NewMember <> nil then
    with NewMember do
    begin
      SetType(T);
      SetMiddle(M);
      SetStartMember(A);

      if FA < Axe.GetMin then
        Axe.SetMinMax(FA, Axe.GetMax);

      if FB > Axe.GetMax then
        Axe.SetMinMax(Axe.GetMin, FB);

      SetName(N);
      SetColor(FMembers.Count * 66);
    end;

  FBmax := 0;

  for i := 0 to FMembers.Count - 1 do
    if FMembers.Items[i].FB > FBMax then
      FBMax := FMembers.Items[i].FB;

  Maxi := FBMax;
end;

procedure TCustomFuzzy.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  Axe.SetWidth(AWidth - 2 * AxeMargeX);
end;

procedure TCustomFuzzy.Paint;
var
  i: Integer;
begin
  inherited Paint;

  with Axe do
  begin
    Canvas.Pen.Color := clRed;
    Canvas.MoveTo(AxeMargeX, Height - AxeMargeY);
    Canvas.LineTo(Width, Height - AxeMargeY);
    i := 0;

    repeat
      Inc(i);
      Canvas.MoveTo(Scale(Mini + FUnite * i), Height - AxeMargeY - 2);
      Canvas.LineTo(Scale(Mini + FUnite * i), Height - AxeMargeY + 2);
    until Scale(Mini + FUnite * i) > Width;
  end;

  for i := 0 to FMembers.Count - 1 do
    with TMember(FMembers.Items[i]) do
    begin
      Canvas.Pen.Color := Color;
      Canvas.MoveTo(Axe.Scale(Middle), 0);

      if FType = tmLInfinity then
        Canvas.LineTo(Axe.Scale(Axe.GetMin), 0)
      else
        Canvas.LineTo(Axe.Scale(FA), Height - AxeMargeY);

      Canvas.MoveTo(Axe.Scale(Middle), 0);

      if FType = tmRInfinity then
        Canvas.LineTo(Axe.Scale(Axe.GetMax), 0)
      else
        Canvas.LineTo(Axe.Scale(FB), Height - AxeMargeY);

      Canvas.font.Color := Color;
      Canvas.Brush.Color := self.Color;
      Canvas.TextOut(Axe.Scale(Middle), AxeMargeY + 3 + i * 8, FName);

      {
      Canvas.MoveTo(0, Round((1 - OwnerShip(FRealInput)) * (Height - AxeMargeY)));
      Canvas.LineTo(width, Round((1 - OwnerShip(FRealInput)) * (Height - AxeMargeY)));
      }

      Canvas.Brush.Color := Self.Color;
      Canvas.Font.Color := clYellow;
      Canvas.TextOut(AxeMargeX + 2, 3, FFuzzyName);
    end;
end;

destructor TCustomFuzzy.Destroy;
begin
  FMembers.Destroy;
  Axe.Free;

  inherited Destroy;
end;
{**************************** TFuzzyfication *********************************}

procedure TFuzzyfication.SetOutPuts(Index: Integer; y: Single);
begin
  {For i:=0 to FMembers.Count-1 do}
  FOutPuts[Index] := y; {TMember(FMembers.Items[Index]).OwnerShip(FRealInput);}
end;

function TFuzzyfication.GetOutputs(Index: Integer): Single;
begin
  Result := FOutputs[Index];
end;

procedure TFuzzyfication.SetRealInput(X: Single);
var
  i: Integer;
begin
  FRealInput := X;
  Axe.SetMinMax(Axe.GetMin, Axe.GetMax);

  for i := 0 to FMembers.Count - 1 do
    FOutputs[i] := TMember(FMembers.Items[i]).OwnerShip(FRealInput);

  Change;
  Invalidate;
end;

constructor TFuzzyfication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FuzzyType := ftFuzzyfication;
  FRealInput := 0;
end;

procedure TFuzzyfication.WMMButtonDown(var Msg: TMessage);
var
  x: Integer;
begin
  x := Msg.LParamLo;

  if Axe.FHomo <> 0 then
    RealInput := (X - AxeMargeX) / Axe.FHomo + Axe.FMin
  else
    RealInput := 0;
end;

procedure TFuzzyfication.Paint;
var
  i: Integer;
begin
  inherited Paint;

  if (FRealInput >= Axe.FMin) and (FRealInput <= Axe.FMax) then
  begin
    Canvas.Pen.Color := clYellow;
    Canvas.MoveTo(Axe.Scale(FRealInput), 0);
    Canvas.LineTo(Axe.Scale(FRealInput), Height);
  end;

  Canvas.Font.Color := clBlack;

  for i := 0 to FMembers.Count - 1 do
    with TMember(FMembers.Items[i]) do
      Canvas.TextOut(AxeMargeX + 2 + i * 50, Height - AxeMargeY + 3, 'Y(' + IntToStr(i) + ')=' + FloatToStrF(OwnerShip(FRealInput), ffFixed, 5, 2));
end;

{************************* TFuzzySolution ******************************}

constructor TFuzzySolution.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FuzzyType := ftFuzzySolution;
  FRealOutput := 0;
  FCompatibility := 0;
  System.FillChar(FXValues, SizeOf(FXValues), #0);
  System.FillChar(FYValues, SizeOf(FYValues), #0);
  FNbPoints := 0;
  FDeltaX := 2;
end;

procedure TFuzzySolution.SetDeltaX(d: Single);
begin
  FDeltaX := d;
  Invalidate;
  Change;
end;

procedure TFuzzySolution.ClearSolution;
begin
  FRealOutput := 0;
  FCompatibility := 0;
  System.FillChar(FXValues, SizeOf(FXValues), #0);
  System.FillChar(FYValues, SizeOf(FYValues), #0);
  FNbPoints := 0;
  Invalidate;
  Change;
end;

// Agregation
// Controler que le Member FuzzySet est bien égal à un member de TFuzzySolution

procedure TFuzzySolution.FuzzyAgregate(MemberIndex: Integer; AlphaCut: Single);
begin
  {
  FNbPoints := 0;
  FXValues[FNbPoints] := Axe.GetMin;

  repeat
    Inc(FNbPoints);

    if FXValues[FNbPoints - 1] + FDeltax < Axe.GetMax then
    begin
      FXValues[FNbPoints] := FXValues[FNbPoints - 1] + FDeltax;
      FYValues[FNbPoints] := Math.MaxValue([FYValues[FNbPoints], Math.MinValue([Members[MemberIndex].OwnerShip(FXValues[FNbPoints]), AlphaCut])]);
    end
    else
    begin
      FXValues[FNbPoints] := Axe.GetMax;
      FYValues[FNbPoints] := Math.MaxValue([FYValues[FNbPoints], Math.MinValue([Members[MemberIndex].OwnerShip(FXValues[FNbPoints]), AlphaCut])]);
    end;
  until (FXValues[FNbPoints] = Axe.GetMax) or (FNbPoints >= MaxPoints);
  }

  FXValues[0] := Axe.GetMin;
  FNbPoints := 1;

  repeat
    if FXValues[FNbPoints - 1] + FDeltax < Axe.GetMax then
    begin
      FXValues[FNbPoints] := FXValues[FNbPoints - 1] + FDeltax;
      FYValues[FNbPoints] := Math.MaxValue([FYValues[FNbPoints], Math.MinValue([Members[MemberIndex].OwnerShip(FXValues[FNbPoints]), AlphaCut])]);
    end
    else
    begin
      FXValues[FNbPoints] := Axe.GetMax;
      FYValues[FNbPoints] := Math.MaxValue([FYValues[FNbPoints], Math.MinValue([Members[MemberIndex].OwnerShip(FXValues[FNbPoints]), AlphaCut])]);
    end;

    Inc(FNbPoints);
  until (FNbPoints >= MaxPoints) or (FXValues[FNbPoints] = Axe.GetMax);

  Invalidate;
  Change;
end;

// Focalisation

function TFuzzySolution.GetRealOutput: Single;
var
  i: Integer;
  Sum, S: Single;
  YValue, MaxiValue: Single;
begin
  Sum := 0;
  S := 0;
  MaxiValue := 0;

  for i := 0 to FNbPoints - 2 do
  begin
    YValue := FYValues[i];

    if YValue > MaxiValue then
      MaxiValue := YValue;

    S := S + FDeltaX * YValue;
    Sum := Sum + (FDeltaX * YValue) * FXValues[i + 1];
  end;

  if S <> 0 then
    Result := Sum / S
  else
    Result := 0;

  FCompatibility := MaxiValue;
  Change;
end;

procedure TFuzzySolution.Paint;
var
  i: Integer;
  x: Single;
  x1, y1, x2, y2: Integer;
begin
  inherited Paint;

  for i := 0 to FNbPoints - 2 do
  begin
    Canvas.Pen.Color := clYellow;
    X1 := Axe.Scale(FXValues[i]);
    Y1 := ScaleY(FYValues[i]);
    Canvas.MoveTo(X1, Y1);
    X2 := Axe.Scale(FXValues[i + 1]);
    Y2 := ScaleY(FYValues[i + 1]);
    Canvas.LineTo(X2, Y2);
  end;

  x := RealOutput;

  if (x >= Axe.FMin) and (x <= Axe.FMax) then
  begin
    Canvas.Pen.Color := clYellow;
    Canvas.MoveTo(Axe.Scale(x), 0);
    Canvas.LineTo(Axe.Scale(x), Height - AxeMargeY);
  end;
end;

end.

