//*****************************************************************
//   Unit : 3 Fuzzy Components
//        TzCustomFuzzy, TzFuzzyfication and TzFuzzySolution
//   by Alexandre Beauvois 14/06/1998
//*****************************************************************
unit zFuzzy;

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
  TzAxe = class
  private
  public
    FMin, FMax: Double;
    FUnite: Integer;
    FWidth: Integer;
    FHomo: Double;
    constructor Create;
    function GetMin: Double;
    function GetMax: Double;
    procedure SetMinMax(A, B: Double);
    procedure SetWidth(w: Integer);
    function Scale(P: Double): Integer;
  end;

  TzMemberType = (tmLInfinity, tmTriangle, tmRInfinity, tmTrapezoid);

  TzCustomFuzzy = class;

  TzMember = class(TCollectionItem)
  private
    FStart, FMiddle, FEnd: Double;
    FColor: TColor;
    FName: string;
    FType: TzMemberType;
    FFuzzy: TzCustomFuzzy;
    FLength: Integer;
    procedure SetColor(C: TColor);
    procedure SetName(N: string);
    procedure SetType(T: TzMemberType);
    procedure SetMiddle(M: Double);
    procedure SetStartMember(S: Double);
    procedure SetEndMember(E: Double);
    procedure SetFuzzy(Value: TzCustomFuzzy);
    procedure SetLength(L: Integer);
    property Fuzzy: TzCustomFuzzy read FFuzzy write SetFuzzy;
  public
    constructor Create(Collection: TCollection); override;
    function OwnerShip(P: Double): Double;
    procedure Assign(Source: TPersistent); override;
  published
    property Color: TColor read FColor write SetColor;
    property Name: string read FName write SetName;
    property MemberType: TzMemberType read FType write SetType;
    property StartMember: Double read FStart write SetStartMember;
    property Middle: Double read FMiddle write SetMiddle nodefault;
    property EndMember: Double read FEnd write SetEndMember nodefault;
    property Length: Integer read FLength write SetLength nodefault;
  end;

  TzMembers = class(TCollection)
    FFuzzy: TzCustomFuzzy;
    function GetItem(Index: Integer): TzMember;
    procedure SetItem(Index: Integer; Value: TzMember);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Fuzzy: TzCustomFuzzy);
    function GetMemberIndex(N: string): Integer;
    function Add: TzMember;
    property Items[Index: Integer]: TzMember read GetItem write SetItem; default;
  end;

  TzFuzzyType = (ftFuzzyfication, ftFuzzySolution);
  TzFuzzyResults = array[0..MaxMembers - 1] of Double;

  TzCustomFuzzy = class(TCustomControl)
  private
    FOnChange: TNotifyEvent;
    FMembers: TzMembers;
    FFuzzyName: string;
    FFuzzyNameFont: TFont;
    FFuzzyNameBrush: TBrush;
    FXAxisColor: TColor;
    FCursorColor: TColor;
    procedure SetMembers(Value: TzMembers);
    procedure SetMaxi(X: Double);
    function GetMaxi: Double;
    procedure SetMini(X: Double);
    function GetMini: Double;
    procedure SetFuzzyName(FN: string);
    procedure SetFuzzyNameFont(Value: TFont);
    procedure SetFuzzyNameBrush(Value: TBrush);
    procedure SetXAxisColor(Value: TColor);
    procedure SetCursorColor(const Value: TColor);
  public
    Axe: TzAxe;
    constructor Create(Aowner: TComponent); override;
    procedure AddMember(N: string; E, M, S: Double; L: Integer; T: TzMemberType);
    function ScaleY(P: Double): Integer;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  protected
    procedure Paint; override;
    procedure UpdateMember(Index: Integer);
    procedure Change; dynamic;
    property Maxi: Double read GetMaxi write SetMaxi;
    property Mini: Double read GetMini write SetMini;
    property Members: TzMembers read FMembers write SetMembers;
  published
    property Align;
    property Anchors;
    property Color;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property FuzzyName: string read FFuzzyName write SetFuzzyName;
    property FuzzyNameFont: TFont read FFuzzyNameFont write SetFuzzyNameFont;
    property FuzzyNameBrush: TBrush read FFuzzyNameBrush write SetFuzzyNameBrush;
    property XAxisColor: TColor read FXAxisColor write SetXAxisColor;
    property CursorColor: TColor read FCursorColor write SetCursorColor;
  end;

  TzFuzzyfication = class(TzCustomFuzzy)
  private
    FRealInput: Double;
    FOutputs: TzFuzzyResults;
    FFuzzyType: TzFuzzyType;
    procedure SetRealInput(X: Double);
    procedure SetOutPuts(Index: Integer; y: Double);
    function GetOutputs(Index: Integer): Double;
  protected
    procedure Paint; override;
    procedure WMLBUTTONDOWN(var Msg: TMessage); message WM_LBUTTONDOWN;
  public
    property FuzzyType: TzFuzzyType read FFuzzyType write FFuzzyType;
    constructor Create(Aowner: TComponent); override;
    property Outputs[index: Integer]: Double read GetOutputs write SetOutputs;
  published
    property Align;
    property Anchors;
    property Color;
    property Maxi;
    property Mini;
    property Members;
    property RealInput: Double read FRealInput write SetRealInput;
    property OnChange;
  end;

  TzFuzzySolution = class(TzCustomFuzzy)
  private
    FRealOutput: Double;
    FCompatibility: Double;
    FFuzzyType: TzFuzzyType;
    FXValues, FYValues: array[0..MaxPoints - 1] of Double;
    FNbPoints: Integer;
    FDeltaX: Double;
    procedure SetDeltaX(d: Double);
    function GetRealOutput: Double;
  protected
    procedure Paint; override;
  public
    property FuzzyType: TzFuzzyType read FFuzzyType write FFuzzyType;
    procedure FuzzyAgregate(MemberIndex: Integer; AlphaCut: Double);
    procedure ClearSolution;
    constructor Create(Aowner: TComponent); override;
  published
    property Align;
    property Anchors;
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
  //RegisterComponents('Fuzzy comps', [TzCustomFuzzy]);
  RegisterComponents('Fuzzy comps', [TzFuzzyfication]);
  RegisterComponents('Fuzzy comps', [TzFuzzySolution]);
end;

{****************** TzAxe ********************}

constructor TzAxe.Create;
begin
  inherited Create;

  FMin := 0;
  FMax := 0;
  FHomo := 1;
  Funite := 10;
end;

function TzAxe.GetMin: Double;
begin
  GetMin := FMin;
end;

function TzAxe.GetMax: Double;
begin
  GetMax := FMax;
end;

procedure TzAxe.SetMinMax(A, B: Double);
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
    FHomo := FWidth / (Fmax - Fmin)
  else
    FHomo := 0;
end;

procedure TzAxe.SetWidth(W: Integer);
begin
  FWidth := W;
end;

function TzAxe.Scale(P: Double): Integer;
var
  RUnit: Double;
begin
  RUnit := (FMax - FMin);

  if RUnit <> 0 then
    Scale := Round((P - FMin) / RUnit * FWidth)
  else
    Scale := 0;
end;

{****************** TzMember ********************}

constructor TzMember.Create(Collection: TCollection);
begin
  FColor := clBlack;
  FName := 'New';
  FType := tmTriangle;
  FStart := 0;
  FMiddle := 5;
  FEnd := 10;
  FLength := 0;

  inherited Create(Collection);
end;

procedure TzMember.SetName(N: string);
begin
  FName := N;
  Changed(False);

  if Assigned(FFuzzy) then
    FFuzzy.Invalidate
end;

procedure TzMember.SetColor(C: TColor);
begin
  FColor := C;
  Changed(False);

  if Assigned(FFuzzy) then
    FFuzzy.Invalidate
end;

procedure TzMember.SetType(T: TzMemberType);
begin
  FType := T;
  Changed(True);

  if Assigned(FFuzzy) then
    FFuzzy.Invalidate
end;

procedure TzMember.SetMiddle(M: Double);
begin
  FMiddle := M;
  Changed(True);

  if Assigned(FFuzzy) then
    FFuzzy.Invalidate
end;

procedure TzMember.SetStartMember(S: Double);
begin
  FStart := S;
  Changed(True);

  if Assigned(FFuzzy) then
    FFuzzy.Invalidate
end;

procedure TzMember.Assign(Source: TPersistent);
begin
  if Source is TzMember then
  begin
    SetEndMember(TzMember(Source).FEnd);
    SetMiddle(TzMember(Source).FMiddle);
    SetStartMember(TzMember(Source).FStart);
    SetLength(TzMember(Source).FLength);
    FColor := TzMember(Source).FColor;
    FName := TzMember(Source).FName;
    FType := TzMember(Source).FType;
    Exit;
  end;

  inherited Assign(Source);
end;

function TzMember.OwnerShip(P: Double): Double;
var
  FM1, FM2: Double;
begin
  if FType = tmTrapezoid then
  begin
    FM1 := FMiddle - FLength div 2;
    FM2 := FMiddle + FLength div 2;
  end
  else
  begin
    FM1 := FMiddle;
    FM2 := FMiddle;
  end;

  OwnerShip := 0;

  (*
  {si la forme de la fonction d'appartenance est Triangulaire !}
  if ((FMiddle - FStart) <> 0) and (P > FStart) and (P < FEnd) then
  begin
    if P < FMiddle then
      OwnerShip := (P - FStart) / (FMiddle - FStart);

    if P > FMiddle then
      OwnerShip := (FEnd - P) / (FEnd - FMiddle);
  end;
  *)

  {si la forme de la fonction d'appartenance est Triangulaire!}
  if ((FMiddle - FStart) <> 0) and (P > FStart) and (P < FEnd) then
  begin
    if P < FM1 then
      OwnerShip := (P - FStart) / (FM1 - FStart);

    if P > FM2 then
      OwnerShip := (FEnd - P) / (FEnd - FM2);
  end;

  if (P <= FStart) or (P >= FEnd) then
    OwnerShip := 0; {si P est hors du segment...}

  if (FType = tmLInfinity) and (P <= FMiddle) then
    OwnerShip := 1;

  if (FType = tmRInfinity) and (P >= FMiddle) then
    OwnerShip := 1;

  {
  if P = FMiddle then
    OwnerShip := 1;
  }

  if ((FType = tmTrapezoid) and (P >= FM1) and (P <= FM2)) or
    ((FType <> tmTrapezoid) and (P = FMiddle)) then
    OwnerShip := 1;
end;
{****************** TzMembers ********************}

constructor TzMembers.Create(Fuzzy: TzCustomFuzzy);
begin
  inherited Create(TzMember);

  FFuzzy := Fuzzy;
end;

function TzMembers.Add: TzMember;
begin
  Result := TzMember(inherited Add);
  Result.Fuzzy := FFuzzy;

  {
  if Count > 1 then
  begin
    Result.Color := TzMember(Items[Count - 1]).Color;
    Result.StartMember := TzMember(Items[Count - 1]).Middle;
    Result.Middle := TzMember(Items[Count - 1]).EndMember;
    Result.EndMember := Result.Middle + (Result.Middle - Result.StartMember);
  end;
  }
end;

function TzMembers.GetItem(Index: Integer): TzMember;
begin
  Result := TzMember(inherited GetItem(Index));
end;

procedure TzMembers.SetItem(Index: Integer; Value: TzMember);
begin
  inherited SetItem(Index, Value);

  if Assigned(FFuzzy) then
    FFuzzy.Refresh;
end;

function TzMembers.GetOwner: TPersistent;
begin
  Result := FFuzzy;
end;

procedure TzMembers.Update(Item: TCollectionItem);
{
var
  AMember: TzMember;
}
begin
  {
  if Item <> nil then
    FFuzzy.UpdateMember(Item.Index);
  }
  {
  try
    if Assigned(Item) then
    begin
      if TzMember(Item).StartMember < FFuzzy.Mini then
        FFuzzy.Mini := TzMember(Item).StartMember;

      if TzMember(Item).Middle + Abs(TzMember(Item).StartMember) > FFuzzy.Maxi then
        FFuzzy.Maxi := TzMember(Item).Middle + Abs(TzMember(Item).StartMember);
    end;
  except
  end;

  FFuzzy.Invalidate;
  }
  {
  else
    FStatusBar.UpdateMembers;
  }
end;

function TzMembers.GetMemberIndex(N: string): Integer;
var
  i: Integer;
begin
  GetMemberIndex := -1;

  for i := 0 to Count - 1 do
    if TzMember(Items[i]).Name = N then
    begin
      GetMemberIndex := i;
      Exit;
    end;
end;

{*************************** TzCustomFuzzy **************************}

constructor TzCustomFuzzy.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);

  FXAxisColor := clRed;
  FCursorColor := clYellow;
  FFuzzyName := Name;
  FFuzzyNameFont := TFont.Create;
  FFuzzyNameFont.Assign(Font);
  FFuzzyNameFont.Style := FFuzzyNameFont.Style + [fsBold];
  FFuzzyNameBrush := TBrush.Create;
  Parent := TWIncontrol(AOwner);
  FFuzzyNameBrush.Assign(Self.Brush);
  Axe := TzAxe.Create;
  FMembers := TzMembers.Create(Self);
  SetBounds(0, 0, 170, 120);
  AddMember('Low', 50, 0, -20, 0, tmLInfinity);
  AddMember('Mid1', 90, 50, 0, 0, tmTriangle);
  AddMember('Mid2', 100, 80, 50, 15, tmTrapezoid);
  AddMember('High', 120, 100, 80, 0, tmRInfinity);
end;

procedure TzCustomFuzzy.SetFuzzyName(FN: string);
begin
  FFuzzyName := FN;
  Invalidate;
end;

procedure TzCustomFuzzy.SetMembers(Value: TzMembers);
begin
  FMembers.Assign(Value);
  Invalidate;
end;

procedure TzCustomFuzzy.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TzCustomFuzzy.UpdateMember(Index: Integer);
begin
  Invalidate;
end;

procedure TzCustomFuzzy.SetMaxi(X: Double);
begin
  Axe.SetMinMax(Axe.GetMin, X);
  Invalidate;
end;

function TzCustomFuzzy.GetMaxi: Double;
begin
  GetMaxi := Axe.GetMax;
end;

procedure TzCustomFuzzy.SetMini(X: Double);
begin
  Axe.SetMinMax(X, Axe.GetMax);
  Invalidate;
end;

function TzCustomFuzzy.GetMini: Double;
begin
  GetMini := Axe.GetMin;
end;

function TzCustomFuzzy.ScaleY(P: Double): Integer;
//var
//  RUnit: Double;
begin
  if Height <> 0 then
    ScaleY := Round(Height - AxeMargeY - P * (Height - AxeMargeY))
  else
    ScaleY := 0;
end;

procedure TzCustomFuzzy.AddMember(N: string; E, M, S: Double; L: Integer; T: TzMemberType);
var
  NewMember: TzMember;
  FBMax: Double;
  i: Integer;

  procedure SWAP_(var A, B: Double);
  var
    tmp: Double;
  begin
    tmp := A;
    A := B;
    B := tmp;
  end;
begin
  NewMember := FMembers.Add;

  if NewMember <> nil then
    with NewMember do
    begin
      SetType(T);

      while (M < S) or (M > E) or (E < S) do
      begin
        if M < S then
          SWAP_(M, S);

        if M > E then
          SWAP_(M, E);

        if E < S then
          SWAP_(E, S);
      end;

      SetEndMember(E);
      SetMiddle(M);
      SetStartMember(S);
      SetLength(L);

      if FStart < Axe.GetMin then
        Axe.SetMinMax(FStart, Axe.GetMax);

      if FEnd > Axe.GetMax then
        Axe.SetMinMax(Axe.GetMin, FEnd);

      SetName(N);
      SetColor(FMembers.Count * 66);
    end;

  FBmax := 0;

  for i := 0 to FMembers.Count - 1 do
    if FMembers.Items[i].FEnd > FBMax then
      FBMax := FMembers.Items[i].FEnd;

  Maxi := FBMax;
end;

procedure TzCustomFuzzy.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  Axe.SetWidth(AWidth - 2 * AxeMargeX);
end;

(*
procedure TzCustomFuzzy.Paint;
var
  i: Integer;
  OutX: Double;
begin
  inherited Paint;

  with Axe do
  begin
    Canvas.Pen.Color := clRed;
    Canvas.MoveTo(AxeMargeX, Height - AxeMArgeY);
    Canvas.LineTo(Width, Height - AxeMargeY);

    i := 0;

    repeat
      Inc(i);
      Canvas.MoveTo(Scale(Mini + FUnite * i), Height - AxeMArgeY - 2);
      Canvas.LineTo(Scale(Mini + FUnite * i), Height - AxeMargeY + 2);
    until Scale(Mini + FUnite * i) > Width;
  end;

  for i := 0 to FMembers.Count - 1 do
    with TzMember(FMembers.Items[i]) do
    begin
      Canvas.Pen.Color := Color;
      Canvas.MoveTo(Axe.Scale(Middle), 0);

      if FType = tmLInfinity then
        Canvas.LineTo(Axe.Scale(Axe.GetMin), 0)
      else
        Canvas.LineTo(Axe.Scale(FStart), Height - AxeMargeY);

      Canvas.MoveTo(Axe.Scale(Middle), 0);

      if FType = tmRInfinity then
        Canvas.LineTo(Axe.Scale(Axe.GetMax), 0)
      else
        Canvas.LineTo(Axe.Scale(FEnd), Height - AxeMargeY);

      Canvas.Font.Color := Color;
      Canvas.Brush.Color := Self.Color;
      Canvas.TextOut(Axe.Scale(Middle), AxeMargeY + 3 + i * 8, FName);
      {
      Canvas.MoveTo(0, Round((1 - OwnerShip(FRealInput)) * (Height - AxeMargeY)));
      Canvas.LineTo(Width, Round((1 - OwnerShip(FRealInput)) * (Height - AxeMargeY)));
      }
      Canvas.Brush.Color := Self.Color;
      Canvas.Font.Color := clYellow;
      Canvas.TextOut(AxeMargeX + 2, 3, FFuzzyName);
    end;
end;
*)

procedure TzCustomFuzzy.Paint;
var
  i, nh: Integer;
  //OutX: Double;
  s: string;
  f: TFont;
  b: TBrush;
begin
  inherited Paint;

  f := TFont.Create;
  b := TBrush.Create;

  try
    // Draw x line
    with Axe do
    begin
      Canvas.Pen.Color := FXAxisColor;
      Canvas.MoveTo(AxeMargeX, Height - AxeMArgeY);
      Canvas.LineTo(Width, Height - AxeMargeY);
    end;

    Canvas.Brush.Color := Self.Color;

    if FFuzzyName <> '' then
    begin
      f.Assign(Canvas.Font);
      b.Assign(Canvas.Brush);
      Canvas.Brush.Assign(FFuzzyNameBrush);
      Canvas.Font.Assign(FFuzzyNameFont);
      Canvas.TextOut(AxeMargeX + 2, 1, FFuzzyName);
      nh := Canvas.TextHeight('ÇÃ') + 2;
      Canvas.Font.Assign(f);
      Canvas.Brush.Assign(b);
    end
    else
      nh := 0;

    for i := 0 to FMembers.Count - 1 do
      with TzMember(FMembers.Items[i]) do
      begin
        // Draw de X divisions
        Canvas.Pen.Color := FXAxisColor;
        Canvas.MoveTo(Axe.Scale(Middle) - 1, Height - AxeMArgeY);
        Canvas.LineTo(Axe.Scale(Middle) - 1, Height - AxeMargeY + 4);
        Canvas.MoveTo(Axe.Scale(Middle), Height - AxeMArgeY);
        Canvas.LineTo(Axe.Scale(Middle), Height - AxeMargeY + 4);
        Canvas.MoveTo(Axe.Scale(Middle) + 1, Height - AxeMArgeY);
        Canvas.LineTo(Axe.Scale(Middle) + 1, Height - AxeMargeY + 4);

        // Draw de X-values
        Canvas.Font.Color := FXAxisColor;
        s := FloatToStrF(Middle, ffFixed, 5, 0);
        Canvas.TextOut(Axe.Scale(Middle) - Canvas.TextWidth(s) div 2, Height - AxeMargeY + 3, s);

        // posiciona no topo, no ponto definido como médio da curva
        Canvas.Pen.Color := Color;

        if FType = tmTrapezoid then
        begin
          Canvas.MoveTo(Axe.Scale(Middle) + FLength div 2, Canvas.TextHeight('ÇÃ') + 2 + nh);
          Canvas.LineTo(Axe.Scale(Middle) - FLength div 2, Canvas.TextHeight('ÇÃ') + 2 + nh);
        end
        else
          Canvas.MoveTo(Axe.Scale(Middle), Canvas.TextHeight('ÇÃ') + 2 + nh);

        if FType = tmLInfinity then // se for decrescente à esquerda, desenha uma linha reta para a esquerda
          Canvas.LineTo(Axe.Scale(Axe.GetMin), Canvas.TextHeight('ÇÃ') + 2 + nh)
        else // senão, desenha uma linha até o eixo X (triangular ou crescente à direita)
          Canvas.LineTo(Axe.Scale(FStart), Height - AxeMargeY);

        // posiciona no topo, no ponto definido como médio
        if FType = tmTrapezoid then
          Canvas.MoveTo(Axe.Scale(Middle) + FLength div 2, Canvas.TextHeight('ÇÃ') + 2 + nh)
        else
          Canvas.MoveTo(Axe.Scale(Middle), Canvas.TextHeight('ÇÃ') + 2 + nh);

        if FType = tmRInfinity then // se for crescente à direita, desenha uma linha reta para a direita
          Canvas.LineTo(Axe.Scale(Axe.GetMax), Canvas.TextHeight('ÇÃ') + 2 + nh)
        else // senão, desenha uma linha até o eixo X (triangular ou crescente à direita)
          Canvas.LineTo(Axe.Scale(FEnd), Height - AxeMargeY);

        Canvas.Font.Color := Color;
        Canvas.Brush.Color := Self.Color;

        // Draw names
        Canvas.TextOut(Axe.Scale(Middle) - Canvas.TextWidth(FName) div 2, 1 + nh, FName);
      end;
  finally
    f.Free;
    b.Free;
  end;
end;

destructor TzCustomFuzzy.Destroy;
//var
//  i: Integer;
begin
  FMembers.Destroy;
  Axe.Free;
  FFuzzyNameFont.Free;
  FFuzzyNameBrush.Free;

  inherited Destroy;
end;

procedure TzCustomFuzzy.SetFuzzyNameFont(Value: TFont);
begin
  FFuzzyNameFont.Assign(Value);
  Invalidate;
end;

procedure TzCustomFuzzy.SetFuzzyNameBrush(Value: TBrush);
begin
  FFuzzyNameBrush.Assign(Value);
  Invalidate;
end;

procedure TzCustomFuzzy.SetXAxisColor(Value: TColor);
begin
  if FXAxisColor <> Value then
  begin
    FXAxisColor := Value;
    Invalidate;
  end;
end;

procedure TzCustomFuzzy.SetCursorColor(const Value: TColor);
begin
  if FCursorColor <> Value then
  begin
    FCursorColor := Value;
    Invalidate;
  end;
end;

{**************************** TzFuzzyfication *********************************}

procedure TzFuzzyfication.SetOutPuts(Index: Integer; y: Double);
begin
  FOutPuts[index] := y;
end;

function TzFuzzyfication.GetOutputs(Index: Integer): Double;
begin
  GetOutputs := FOutputs[index];
end;

procedure TzFuzzyfication.SetRealInput(X: Double);
var
  i: Integer;
begin
  FRealInput := X;
  Axe.SetMinMax(Axe.GetMin, Axe.GetMax);

  for i := 0 to FMembers.Count - 1 do
    FOutputs[i] := TzMember(FMembers.Items[i]).OwnerShip(FRealInput);

  Change;
  Invalidate;
end;

constructor TzFuzzyfication.Create(Aowner: TComponent);
begin
  inherited Create(AOwner);

  FuzzyType := ftFuzzyfication;
  FRealInput := 0;
end;

procedure TzFuzzyfication.WMLBUTTONDOWN(var Msg: TMessage);
var
  x: Integer;
begin
  x := Msg.LParamLo;

  if Axe.FHomo <> 0 then
    RealInput := (X - axeMargeX) / Axe.Fhomo + Axe.FMin
  else
    RealInput := 0;
end;

procedure TzFuzzyfication.Paint;
var
  //i,
  nh: Integer;
begin
  inherited Paint;

  if (FRealInput >= Axe.FMin) and (FRealInput <= Axe.Fmax) then
  begin
    if FFuzzyName <> '' then
      nh := Canvas.TextHeight('ÇÃ') * 2 + 4
    else
      nh := 0;

    Canvas.Pen.Color := FCursorColor;
    Canvas.MoveTo(Axe.Scale(FRealInput), nh);
    Canvas.LineTo(Axe.Scale(FRealInput), Height - AxeMargeY);
  end;

  Canvas.Font.Color := clBlack;

  {
  for i := 0 to FMembers.Count - 1 do
    with TzMember(FMembers.Items[i]) do
      Canvas.TextOut(AxeMargeX + 2 + i * 50, Height - AxeMargeY + 3, 'Y(' + IntToStr(i) + ')=' + FloatToStrF(OwnerShip(FRealInput), ffFixed, 5, 2));
  }
end;

{************************* TzFuzzySolution ******************************}

constructor TzFuzzySolution.Create(Aowner: TComponent);
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

procedure TzFuzzySolution.SetDeltaX(d: Double);
begin
  FDeltaX := d;

  Invalidate;
  Change;
end;

procedure TzFuzzySolution.ClearSolution;
begin
  FRealOutput := 0;
  FCompatibility := 0;
  System.FillChar(FXValues, SizeOf(FXValues), #0);
  System.FillChar(FYValues, SizeOf(FYValues), #0);
  FNbPoints := 0;

  Invalidate;
  Change;
end;

//Agregation
//Controler que le Member FuzzySet est bien égal à un member de TzFuzzySolution

procedure TzFuzzySolution.FuzzyAgregate(MemberIndex: Integer; AlphaCut: Double);
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
  until (FXValues[FNbPoints] = Axe.GetMax) or (FNbPoints >= MaxPoints);

  Invalidate;
  Change;
end;

// Focalisation

function TzFuzzySolution.GetRealOutput: Double;
var
  i: Integer;
  sum, S: Double;
  //DeltaXValue, Surface,
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

procedure TzFuzzySolution.Paint;
var
  i: Integer;
  x: Double;
  x1, y1, x2, y2, nh: Integer;
begin
  inherited Paint;

  if FFuzzyName <> '' then
    nh := Canvas.TextHeight('ÇÃ') * 2 + 4
  else
    nh := 0;

  for i := 0 to (FNbPoints - 1) - 1 do
  begin
    Canvas.Pen.Color := FCursorColor;
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
    Canvas.Pen.Color := FCursorColor;
    Canvas.MoveTo(Axe.Scale(x), nh);
    Canvas.LineTo(Axe.Scale(x), Height - AxeMargeY);
  end;
end;

procedure TzMember.SetEndMember(E: Double);
begin
  FEnd := E;
  Changed(True);

  if Assigned(FFuzzy) then
    FFuzzy.Invalidate
end;

procedure TzMember.SetLength(L: Integer);
begin
  FLength := L;
  Changed(True);

  if Assigned(FFuzzy) then
    FFuzzy.Invalidate
end;

procedure TzMember.SetFuzzy(Value: TzCustomFuzzy);
begin
  FFuzzy := Value;

  if Assigned(FFuzzy) then
    FFuzzy.Invalidate
end;

end.

