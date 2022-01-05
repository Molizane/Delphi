unit fuzzyDspU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids;

type
  TfrmGrid = class(TForm)
    GridFuzzy: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GridFuzzyDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
  public
  end;

var
  frmGrid: TfrmGrid;

implementation

{$R *.dfm}

procedure TfrmGrid.FormCreate(Sender: TObject);
begin
  GridFuzzy.Cells[1, 0] := 'Stock OwnerShip';
  GridFuzzy.Cells[2, 0] := 'Demand OwnerShip';
  GridFuzzy.Cells[3, 0] := 'Average OwnerShip';
end;

procedure TfrmGrid.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := False;
end;

procedure TfrmGrid.GridFuzzyDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  nLeft, nTop: Integer;
  Txt: string;
begin
  Txt := GridFuzzy.Cells[ACol, ARow];

  if (ARow = 0) then //or (ACol > 0) then
    nLeft := (Rect.Right - Rect.Left - GridFuzzy.Canvas.TextWidth(Txt)) div 2
  else if ACol = 0 then
    nLeft := 2
  else
    nLeft := (Rect.Right - Rect.Left) - GridFuzzy.Canvas.TextWidth(Txt) - 2;

  nTop := (Rect.Bottom - Rect.Top - GridFuzzy.Canvas.TextHeight('วร')) div 2;
  GridFuzzy.Canvas.FillRect(Rect);
  GridFuzzy.Canvas.TextOut(Rect.Left + nLeft, Rect.Top + nTop, Txt);
end;

end.
