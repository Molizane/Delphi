unit uEmbaralhamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, uBaralho;

type
  TFrmEmbaralhamento = class(TForm)
    StringGrid: TStringGrid;
    btnEmbaralhar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure btnEmbaralharClick(Sender: TObject);
  private
    procedure Exibe;
  public
  end;

var
  FrmEmbaralhamento: TFrmEmbaralhamento;

implementation

uses
  Math;

{$R *.dfm}

procedure TFrmEmbaralhamento.FormCreate(Sender: TObject);
begin
  Exibe;
end;

procedure TFrmEmbaralhamento.Exibe;
var
  Row, Col: Integer;
begin
  for Row := 0 to 3 do
    for Col := 0 to 12 do
      StringGrid.Cells[Col, Row] := '';

  StringGrid.Cells[0, 4] := '';

  for Row := 0 to 3 do
    for Col := 0 to 12 do
    begin
      if FromTwoToOne then
        if FBaralho2[0].CardValue = vcJoker then
          StringGrid.Cells[Col, Row] := TStrValues[FBaralho2[0].CardValue]
        else
          StringGrid.Cells[Col, Row] := TStrValues[FBaralho2[0].CardValue] + ' de ' + TStrNaipes[FBaralho2[0].CardNaipe]
      else if FBaralho1[0].CardValue = vcJoker then
        StringGrid.Cells[Col, Row] := TStrValues[FBaralho1[0].CardValue]
      else
        StringGrid.Cells[Col, Row] := TStrValues[FBaralho1[0].CardValue] + ' de ' + TStrNaipes[FBaralho1[0].CardNaipe];

      Discard(0, True);
    end;

  if FromTwoToOne then
    StringGrid.Cells[0, 4] := TStrValues[FBaralho2[0].CardValue] + ' ' + TStrNaipes[FBaralho2[0].CardNaipe]
  else
    StringGrid.Cells[0, 4] := TStrValues[FBaralho1[0].CardValue] + ' ' + TStrNaipes[FBaralho1[0].CardNaipe];

  Discard(0, True);
  FromTwoToOne := not FromTwoToOne;
end;

procedure TFrmEmbaralhamento.btnEmbaralharClick(Sender: TObject);
begin
  Shuffling(flsRandom);
  Exibe;
end;

end.

