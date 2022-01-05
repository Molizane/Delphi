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
    FMin, FMax: Double;
    FUnite: integer;
    FWidth: Integer;
    FHomo: Double;
    constructor Create;
    function getmin: Double;
    function getmax: Double;
    procedure SetMinMax(A, B: Double);
    procedure SetWidth(w: integer);
    function Scale(P: Double): integer;
  end;

  TMemberType = (tmLInfinity, tmTriangle, tmRInfinity);

  TMember = class(TCollectionItem)
  private
    FA, FB: Double;
    FMiddle: Double;
    FColor: TColor;
    FName: string;
    FType: TMemberType;
    procedure SetColor(C: TColor);
    procedure SetName(N: string);
    procedure SetType(T: TMemberType);
    procedure SetMiddle(M: Double);
    procedure SetStartMember(A: Double);
  public
    constructor Create(Collection: TCollection); override;
    function OwnerShip(P: Double): Double;
    procedure Assign(Source: TPersistent); override;
  published
    property Color: TColor read FColor write SetColor;
    property Name: string read FName write SetName;
    property MemberType: TMemberType read FType write SetType;
    property StartMember: Double read FA write SetStartMember;
    property Middle: Double read FMiddle write SetMiddle nodefault;
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
    function GetMemberIndex(N: string): integer;
    function Add: TMember;
    property Items[Index: Integer]: TMember read GetItem write SetItem; default;
  end;

  TFuzzyType = (ftFuzzyfication, ftFuzzySolution);
  TFuzzyResults = array[0..MaxMembers - 1] of Double;

  TCustomFuzzy = class(TCustomControl)
  private
    FOnChange: TNotifyEvent;
    FMembers: TMembers;
    FFuzzyName: string;
    procedure SetMembers(Value: TMembers);
    procedure SetMaxi(X: Double);
    function GetMaxi: Double;
    procedure SetMini(X: Double);
    function GetMini: Double;
    procedure SetFuzzyName(FN: string);
  public
    Axe: TAxe;
    constructor Create(Aowner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure AddMember(N: string; M, A: Double; T: TMemberType);
    function ScaleY(P: Double): integer;
    destructor Destroy; override;
  protected
    procedure Paint; override;
    procedure UpdateMember(Index: Integer);
    procedure Change; dynamic;
    property Maxi: Double read GetMaxi write SetMaxi;
    property Mini: Double read GetMini write SetMini;
    property Members: TMembers read FMembers write SetMembers;
  published
    property Align;
    property Color;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property FuzzyName: string read FFuzzyName write SetFuzzyName;
  end;

  TFuzzyfication = class(TCustomFuzzy)
  private
    FRealInput: Double;
    FOutputs: TFuzzyResults;
    FFuzzyType: TFuzzyType;
    procedure SetRealInput(X: Double);
    procedure SetOutPuts(Index: integer; y: Double);
    function GetOutputs(Index: integer): Double;
  protected
    procedure Paint; override;
    procedure WMMbuttonDown(var Msg: TMessage); message WM_LbuttonDown;
  public
    property FuzzyType: TFuzzyType read FFuzzyType write FFuzzyType;
    constructor Create(Aowner: Tcomponent); override;
    property Outputs[index: integer]: Double read GetOutputs write SetOutputs;
  published
    property Align;
    property Anchors;
    property Color;
    property Maxi;
    property Mini;
    property Members;
    property RealInput: Double read FRealInput write SetRealInput;
    property OnChange;
    property ShowHint;
  end;

  TFuzzySolution = class(TCustomFuzzy)
  private
    FRealOutput: Double;
    FCompatibility: Double;
    FFuzzyType: TFuzzyType;
    FXValues, FYValues: array[0..MaxPoints - 1] of Double;
    FNbPoints: Integer;
    FDeltaX: Double;
    procedure SetDeltaX(d: Double);
    function GetRealOutput: Double;
  protected
    procedure Paint; override;
  public
    property FuzzyType: TFuzzyType read FFuzzyType write FFuzzyType;
    procedure FuzzyAgregate(MemberIndex: Integer; AlphaCut: Double);
    procedure ClearSolution;
    constructor Create(Aowner: Tcomponent); override;
  published
    property Align;
    property Color;
    property Maxi;
    property Mini;
    property Members;
    property RealOutput: Double read GetRealOutput write FRealOutput;
    property OnChange;
    property Compatibility: Double read FCompatibility write FCompatibility;
    property DeltaX: Double read FDeltaX write SetDeltaX;
  end;

procedure Register;

implementation

uses
  Math;

procedure Register;
begin
  RegisterComponents('Fuzzy', [TCustomFuzzy]);
  RegisterComponents('Fuzzy', [TFuzzyfication]);
  RegisterComponents('Fuzzy', [TFuzzySolution]);
end;

{****************** TAxe ********************}

constructor TAxe.Create;
begin
  inherited Create;

  FMin := 0;
  FMax := 0;
  FHomo := 1;
  Funite := 10;
end;

function TAxe.getMin: Double;
begin
  GetMin := FMin;
end;

function TAxe.getMax: Double;
begin
  GetMax := FMax;
end;

procedure Taxe.SetMinMax(A, B: Double);
begin
  if A <= B then
  begin
    Fmin := A;
    Fmax := B;
  end
  else
  begin
    Fmin := B;
    Fmax := A;
  end;

  if (Fmax - Fmin) <> 0 then
    FHomo := Fwidth / (Fmax - Fmin)
  else
    FHomo := 0;
end;

procedure TAxe.SetWidth(W: integer);
begin
  FWidth := W;
end;

function TAxe.Scale(P: Double): integer;
var
  RUnit: Double;
begin
  RUnit := (FMax - FMin);

  if RUnit <> 0 then
    Scale := Round((P - FMin) / RUnit * FWidth)
  else
    Scale := 0;
end;

{****************** TMember ********************}

constructor TMember.Create(Collection: TCollection);
begin
  FColor := clwhite;
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

procedure TMember.SetMiddle(M: Double);
begin
  //if M <= FA then FA := M;
  FMiddle := M;
  FB := 2 * FMiddle - FA;
  Changed(True);
end;

procedure TMember.SetStartMember(A: Double);
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

function TMember.OwnerShip(P: Double): Double;
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

  try
    if TMember(Item).StartMember < FFuzzy.Mini then
      FFuzzy.Mini := TMember(Item).StartMember;

    if TMember(Item).Middle + abs(TMember(Item).StartMember) > FFuzzy.Maxi then
      FFuzzy.Maxi := TMember(Item).Middle + abs(TMember(Item).StartMember);
  except
  end;

  FFuzzy.Invalidate;
end;

function TMembers.GetMemberIndex(N: string): integer;
var
  i: integer;
begin
  GetMemberIndex := 0;

  for i := 0 to count - 1 do
    if TMember(Items[i]).Name = N then
    begin
      GetMemberIndex := i;
      Exit;
    end
    else
      GetMemberIndex := -1;
end;

{*************************** TCustomFuzzy **************************}

constructor TCustomFuzzy.Create(Aowner: Tcomponent);
begin
  inherited Create(Aowner);

  Parent := TWinControl(AOwner);
  Axe := TAxe.Create;
  FMembers := TMembers.Create(Self);
  SetBounds(0, 0, 170, 100);
  addMember('Low', 0, -20, tmLInfinity);
  addMember('Nul', 50, 0, tmTriangle);
  addMember('Important', 80, 50, tmRInfinity);
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

procedure TCustomFuzzy.SetMaxi(X: Double);
begin
  Axe.setMinMax(Axe.GetMin, X);
  Invalidate;
end;

function TCustomFuzzy.GetMaxi: Double;
begin
  GetMaxi := Axe.getmax;
end;

procedure TCustomFuzzy.SetMini(X: Double);
begin
  Axe.setMinMax(X, Axe.getmax);
  Invalidate;
end;

function TCustomFuzzy.GetMini: Double;
begin
  GetMini := Axe.getmin;
end;

function TCustomFuzzy.ScaleY(P: Double): integer;
begin
  if Height <> 0 then
    Result := Round(Height - AxeMargeY - P * (Height - AxeMargeY))
  else
    Result := 0;
end;

procedure TCustomFuzzy.AddMember(N: string; M, A: Double; T: TMemberType);
var
  NewMember: TMember;
  FBMax: Double;
  i: integer;
begin
  NewMember := FMembers.Add;

  if NewMember <> nil then
    with NewMember do
    begin
      SetType(T);
      SetMiddle(M);
      SetStartMember(A);

      if FA < Axe.GetMin then
        Axe.setMinMax(FA, Axe.GetMax);

      if FB > Axe.GetMax then
        Axe.setMinMax(Axe.GetMin, FB);

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
  i: integer;
begin
  inherited Paint;

  with Axe do
  begin
    Canvas.Pen.Color := clRed;
    Canvas.MoveTo(AxeMargeX, Height - AxeMArgeY);
    Canvas.LineTo(Width, Height - AxeMargeY);
    i := 0;

    repeat
      inc(i);
      Canvas.MoveTo(Scale(Mini + FUnite * i), Height - AxeMArgeY - 2);
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
      Canvas.Brush.Color := Self.Color;
      Canvas.TextOut(Axe.Scale(Middle), AxeMargeY + 3 + i * 8, FName);

      {
      Canvas.MoveTo(0, Round((1 - OwnerShip(FRealInput)) * (Height - AxeMargeY)));
      Canvas.LineTo(width, Round((1 - OwnerShip(FRealInput)) * (Height - AxeMargeY)));
      }

      Canvas.Brush.Color := Self.Color;
      Canvas.font.Color := clYellow;
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

procedure TFuzzyfication.SetOutPuts(Index: integer; y: Double);
begin
  {   For i:=0 to FMembers.Count-1 do}
  FOutPuts[index] := y; {TMember(FMembers.Items[index]).OwnerShip(FRealInput);}
end;

function TFuzzyfication.GetOutputs(Index: integer): Double;
begin
  GetOutputs := FOutputs[index];
end;

procedure TFuzzyfication.SetRealInput(X: Double);
var
  i: Integer;
begin
  FRealInput := X;
  Axe.setMinMax(Axe.GetMin, Axe.GetMax);

  for i := 0 to FMembers.Count - 1 do
    FOutputs[i] := TMember(FMembers.Items[i]).OwnerShip(FRealInput);

  Change;
  Invalidate;
end;

constructor TFuzzyfication.Create(Aowner: Tcomponent);
begin
  inherited Create(AOwner);

  FuzzyType := ftFuzzyfication;
  FRealInput := 0;
end;

procedure TFuzzyfication.WMMbuttonDown(var Msg: TMessage);
var
  x: integer;
begin
  x := msg.lparamlo;
  if Axe.FHomo <> 0 then
    RealInput := (X - axeMargeX) / Axe.Fhomo + Axe.FMin
  else
    RealInput := 0;
end;

procedure TFuzzyfication.Paint;
var
  i: integer;
begin
  inherited Paint;

  if (FRealInput >= Axe.FMin) and (FRealInput <= Axe.Fmax) then
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

constructor TFuzzySolution.Create(Aowner: Tcomponent);
begin
  inherited Create(AOwner);

  FuzzyType := ftFuzzySolution;
  FRealOutput := 0;
  FCompatibility := 0;
  System.Fillchar(FXValues, sizeof(FXValues), #0);
  System.Fillchar(FYValues, sizeof(FYValues), #0);
  FNbPoints := 0;
  FDeltaX := 2;
end;

procedure TFuzzySolution.SetDeltaX(d: Double);
begin
  FDeltaX := d;
  Invalidate;
  Change;
end;

procedure TFuzzySolution.ClearSolution;
begin
  FRealOutput := 0;
  FCompatibility := 0;
  System.Fillchar(FXValues, sizeof(FXValues), #0);
  System.Fillchar(FYValues, sizeof(FYValues), #0);
  FNbPoints := 0;
  Invalidate;
  Change;
end;

//Agregation
//Controler que le Member FuzzySet est bien égal à un member de TFuzzySolution

procedure TFuzzySolution.FuzzyAgregate(MemberIndex: Integer; AlphaCut: Double);
begin
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
  until (FNbPoints >= MaxPoints) or (FXValues[FNbPoints] = Axe.GetMax);

  Invalidate;
  Change;
end;

// Focalisation

function TFuzzySolution.GetRealOutput: Double;
var
  i: integer;
  sum, S: Double;
  YValue, MaxiValue: Double;
begin
  sum := 0;
  S := 0;
  MaxiValue := 0;

  for i := 0 to (FNbPoints - 1) - 1 do
  begin
    YValue := FYValues[i];

    if YValue > MaxiValue then
      MaxiValue := YValue;

    S := S + FDeltaX * YValue;
    sum := sum + (FDeltaX * YValue) * FXValues[i + 1];
  end;

  if S <> 0 then
    GetRealOutput := Sum / S
  else
    GetRealOutput := 0;

  Compatibility := MaxiValue;
  Change;
end;

procedure TFuzzySolution.Paint;
var
  i: integer;
  x: Double;
  x1, y1, x2, y2: integer;
begin
  inherited Paint;

  for i := 0 to (FNbPoints - 1) - 1 do
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

  if (x >= Axe.FMin) and (x <= Axe.Fmax) then
  begin
    Canvas.Pen.Color := clYellow;
    Canvas.MoveTo(Axe.Scale(x), 0);
    Canvas.LineTo(Axe.Scale(x), Height - AxeMargeY);
  end;
end;

end.

