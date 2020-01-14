unit NestorFlags;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TFrmFlags = class(TForm)
    FGridFlags: TStringGrid;
    procedure FGridFlagsDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
  public
  end;

var
  FrmFlags: TFrmFlags;

implementation

{$R *.dfm}

procedure TFrmFlags.FGridFlagsDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Offset, Altura: Integer;
  Texto: string;
begin
  with (Sender as TStringGrid).Canvas do { draw on the control canvas, not on the form }
  begin
    Texto := (Sender as TStringGrid).Cells[ACol, ARow];
    FillRect(Rect);
    OffSet := (Rect.Right - Rect.Left - TextWidth(Texto)) div 2;
    Altura := (Rect.Bottom - Rect.Top - TextHeight(Texto)) div 2;
    TextOut(Rect.Left + Offset, Rect.Top + Altura, Texto); { display the text }
  end;
end;

end.

