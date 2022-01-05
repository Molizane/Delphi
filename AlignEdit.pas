unit AlignEdit;

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, WinTypes;

type
  TAlignEdit = class(TEdit)
  private
    FEnterColor,
      FEnterFontColor,
      FExitColor,
      FExitFontColor: TColor;
    FIsNumber: Boolean;
    FOnHelp: TNotifyEvent;
    FAlignment: TAlignment;
    FReturnIsTab: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetIsNumber(Value: Boolean);
  protected
    FMouseIn: Boolean;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property EnterColor: TColor read FEnterColor write FEnterColor;
    property EnterFontColor: TColor read FEnterFontColor write FEnterFontColor;
    property IsNumber: Boolean read FIsNumber write SetIsNumber;
    property OnHelp: TNotifyEvent read FOnHelp write FOnHelp;
    property ReturnIsTab: Boolean read FReturnIsTab write FReturnIsTab;
  end;

procedure Register;

implementation

function wwInPaintCopyState(ControlState: TControlState): boolean;
begin
  {$IFDEF WIN32}
  result := (csPaintCopy in ControlState);
  {$ELSE}
  result := False;
  {$ENDIF}
end;

constructor TAlignEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAlignment := taLeftJustify;
  FEnterFontColor := clBlack;
  FEnterColor := $00B9FFFF;
  FIsNumber := False;
  FReturnIsTab := False;
end;

procedure TAlignEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TAlignEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of Longint = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);

  CreateSubClass(Params, 'EDIT');
  Params.Style := Params.Style and not DWORD(ES_AUTOVSCROLL or ES_AUTOHSCROLL) or DWORD(ES_MULTILINE) or DWORD(Alignments[FAlignment]);
end;

procedure TAlignEdit.KeyPress(var Key: Char);
begin
  if FIsNumber then
  begin
    if Key = ThousandSeparator then
      Key := DecimalSeparator;

    if Key = DecimalSeparator then
    begin
      if (Pos(DecimalSeparator, Text) <> 0) and
        (Pos(DecimalSeparator, SelText) = 0) then
        Key := #0;
    end
    else if Key = '-' then
    begin
      if Pos('-', Text) <> 0 then
        Key := #0;
    end
    else if (Key > #31) and ((Key < '0') or (Key > '9')) then
      Key := #0;
  end
  else if (Key = Char(VK_RETURN)) and FReturnIsTab then
  begin
    SelectNext(Self as tWinControl, True, True);
    Key := #0;
  end;

  inherited KeyPress(Key);
end;

procedure TAlignEdit.DoEnter;
begin
  FMouseIn := True;
  FExitColor := Color;
  FExitFontColor := Font.Color;
  Color := FEnterColor;
  Font.Color := FEnterFontColor;
  SelectAll;

  {
  SelStart := 0;
  SelLength := Length(Text);
  }

  if Assigned(FOnHelp) then
    FOnHelp(Self);

  if Assigned(OnEnter) then
    OnEnter(Self);
end;

procedure TAlignEdit.DoExit;
begin
  FMouseIn := False;
  Color := FExitColor;
  Font.Color := FExitFontColor;
  //SelStart := 0;
  //SelLength := 0;

  if Assigned(OnExit) then
    OnExit(Self);
end;

procedure TAlignEdit.SetIsNumber(Value: Boolean);
begin
  if (Value <> FIsNumber) and Value and (Text <> '') then
    Text := '';

  FIsNumber := Value;
end;

procedure Register;
begin
  RegisterComponents('Angelo - Edits', [TAlignEdit]);
end;

end.

