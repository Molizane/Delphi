unit UConjTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, Db, DBTables, DBGrids, DBCtrls, StdCtrls, Buttons;

type
  TConjTrein = class(TForm)
    tblOCR: TTable;
    dsOCR: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBImage1: TDBImage;
    OpenDialog1: TOpenDialog;
    btnOk: TBitBtn;
    tblOCRSequencia: TAutoIncField;
    tblOCRID: TStringField;
    tblOCRCaracter: TStringField;
    tblOCRImagem: TGraphicField;
    btnLote: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure DBImage1DblClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnLoteClick(Sender: TObject);
    procedure tblOCRBeforeOpen(DataSet: TDataSet);
  private
  public
  end;

var
  ConjTrein: TConjTrein;

implementation

{$R *.DFM}

procedure TConjTrein.FormCreate(Sender: TObject);
begin
  tblOCR.Open;
end;

procedure TConjTrein.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblOCR.Close;
  Action := caFree;
  ConjTrein := nil;
end;

procedure TConjTrein.FormActivate(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Bitmaps\Treinamento\';
end;

procedure TConjTrein.DBImage1DblClick(Sender: TObject);
begin
  OpenDialog1.FileName := tblOCR['ID'];
  if OpenDialog1.Execute then
  begin
    tblOCR.Edit;
    tblOCRImagem.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TConjTrein.btnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TConjTrein.btnLoteClick(Sender: TObject);
begin
  tblOCR.First;
  while not tblOCR.EOF do
  begin
    tblOCR.Edit;
    tblOCRImagem.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Bitmaps\Treinamento\' + tblOCR['ID'] + '.bmp');
    tblOCR.Next;
  end;
end;

procedure TConjTrein.tblOCRBeforeOpen(DataSet: TDataSet);
begin
  tblOCR.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.
