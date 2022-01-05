unit uCheckboxGrid;

interface

uses
  SysUtils, Types, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Grids,
  ExtCtrls;

const
  BOXBLANK = '-';
  BOXCHECK = 'X';

type
  TFrmCheckboxGrid = class(TForm)
    sgDupes: TStringGrid;
    Panel1: TPanel;
    imCheck: TImage;
    imBlank: TImage;
    Image2: TImage;
    Image1: TImage;
    Label1: TLabel;
    procedure sgDupesDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure sgDupesClick(Sender: TObject);
    procedure sgDupesKeyPress(Sender: TObject; var Key: Char);
    procedure sgDupesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgDupesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    PopCol, PopRow: Integer;
    Clicou: Boolean;
    procedure UpdateRowCol;
  public
  end;

var
  FrmCheckboxGrid: TFrmCheckboxGrid;

implementation

{$R *.dfm}

uses
  Windows, Math;

procedure TFrmCheckboxGrid.sgDupesDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  nLeft, nTop, nTopGr: Integer;
  cAlign: string;
begin
  with Sender as TStringGrid, Canvas do
  begin
    //if (ARow = 0) or (Cells[1, ARow] = '') then
    //  Exit;

    if ARow = 0 then
    begin
      Font.Style := Font.Style + [fsBold];
    end
    else
    begin
      if Odd(Integer(Objects[1, ARow])) then
      begin
        Brush.Color := clYellow;
        Font.Style := Font.Style + [fsItalic];
      end
      else
      begin
        Brush.Color := clWhite;
        Font.Style := Font.Style - [fsItalic];
      end;

      if gdSelected in State then
        Font.Style := Font.Style + [fsBold]
      else
        Font.Style := Font.Style - [fsBold];
    end;

    Font.Color := clBlack;
    FillRect(Rect);
    nTop := (Rect.Bottom - Rect.Top - TextHeight('วร')) div 2;

    if ARow = 0 then
    begin
      if ACol = 0 then
        cAlign := 'X'
      else
        cAlign := IntToStr(ACol);

      TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(cAlign)) div 2, Rect.Top + nTop, cAlign);
    end
    else if ACol = 0 then
      if Cells[ACol, ARow] = BOXCHECK then
      begin
        nTopGr := (Rect.Bottom - Rect.Top - imCheck.Picture.Bitmap.Height) div 2;
        nLeft := (Rect.Right - Rect.Left - imCheck.Picture.Bitmap.Width) div 2;
        Canvas.Draw(Rect.Left + nLeft, Rect.Top + nTopGr, imCheck.Picture.Bitmap);
      end
      else
      begin
        nTopGr := (Rect.Bottom - Rect.Top - imBlank.Picture.Bitmap.Height) div 2;
        nLeft := (Rect.Right - Rect.Left - imBlank.Picture.Bitmap.Width) div 2;
        Canvas.Draw(Rect.Left + nLeft, Rect.Top + nTopGr, imBlank.Picture.Bitmap);
      end
    else if ACol = 2 then // Central
      TextRect(Rect, Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(Cells[ACol, ARow])) div 2, Rect.Top + nTop, Cells[ACol, ARow])
    else if ACol in [1, 4] then // Direita
      TextRect(Rect, Rect.Right - Canvas.TextWidth(Cells[ACol, ARow]) - 5, Rect.Top + nTop, Cells[ACol, ARow])
    else if ACol = 5 then
    begin
      nLeft := Rect.Left + 1;
      cAlign := Cells[ACol, ARow];

      if cAlign <> '' then
        if cAlign[1] = '#' then // Direita
        begin
          cAlign := Copy(cAlign, 2, Length(cAlign));
          nLeft := Rect.Right - Canvas.TextWidth(cAlign) - 2;
        end
        else if cAlign[1] = '@' then // Centralizado
        begin
          cAlign := Copy(cAlign, 2, Length(cAlign));
          nLeft := Rect.Left + (Rect.Right - Rect.Left - Canvas.TextWidth(cAlign)) div 2;
        end;

      TextRect(Rect, nLeft, Rect.Top + nTop, cAlign);
    end
    else
      TextRect(Rect, Rect.Left + 5, Rect.Top + nTop, Cells[ACol, ARow]);
  end;
end;

procedure TFrmCheckboxGrid.FormCreate(Sender: TObject);
var
  i, f: Integer;
begin
  Clicou := True;

  Randomize;

  f := Random(20) + 15;
  sgDupes.RowCount := f + 1;

  for i := 1 to f do
  begin
    if Random(10) mod 2 = 0 then
    begin
      sgDupes.Cells[0, i] := BOXCHECK;
      sgDupes.Objects[1, i] := TObject(1);
    end
    else
    begin
      sgDupes.Cells[0, i] := BOXBLANK;
      sgDupes.Objects[1, i] := nil;
    end;

    sgDupes.Cells[1, i] := IntToStr(i);
    sgDupes.Cells[2, i] := 'Teste ' + IntToStr(i);
    sgDupes.Cells[3, i] := 'C:\teste' + IntToStr(i) + '.txt';
    sgDupes.Cells[4, i] := IntToStr(Random(50) + 1);
  end;
end;

procedure TFrmCheckboxGrid.sgDupesClick(Sender: TObject);
begin
  UpdateRowCol;

  if (PopCol < 0) or (PopRow < 0) then
    Exit;

  if Clicou then
  begin
    if (PopCol = 0) and (PopRow > 0) then
      if sgDupes.Cells[0, PopRow] = BOXBLANK then
        sgDupes.Cells[0, PopRow] := BOXCHECK
      else
        sgDupes.Cells[0, PopRow] := BOXBLANK;

    if sgDupes.Cells[0, PopRow] = BOXBLANK then
      sgDupes.Objects[1, PopRow] := nil
    else
      sgDupes.Objects[1, PopRow] := TObject(1);

    sgDupes.Invalidate;
  end
  else
    Clicou := True;
end;

procedure TFrmCheckboxGrid.sgDupesKeyPress(Sender: TObject; var Key: Char);
begin
  UpdateRowCol;

  if (Key = #32) and (PopCol = 0) then
  begin
    Clicou := True;
    Key := #0;
    sgDupesClick(sgDupes);
    Clicou := False;
  end;
end;

procedure TFrmCheckboxGrid.sgDupesKeyDown(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN, VK_LEFT, VK_RIGHT, VK_RETURN:
      Clicou := False;
  end;
end;

procedure TFrmCheckboxGrid.sgDupesKeyUp(Sender: TObject; var Key: Word; Shift:
  TShiftState);
begin
  UpdateRowCol;
  Clicou := True;
end;

procedure TFrmCheckboxGrid.UpdateRowCol;
begin
  PopCol := sgDupes.Col;
  PopRow := sgDupes.Row;

  if (PopRow > 0) and (PopCol = 5) then
  begin
    if not (goEditing in sgDupes.Options) then
      sgDupes.Options := sgDupes.Options + [goEditing];
  end
  else if goEditing in sgDupes.Options then
    sgDupes.Options := sgDupes.Options - [goEditing];
end;

end.

