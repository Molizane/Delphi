unit UConjTeste;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, Db, DBTables, DBGrids, DBCtrls, StdCtrls, Buttons;

type
  TConjTeste = class(TForm)
    tblOCR: TTable;
    dsOCR: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBImage1: TDBImage;
    OpenDialog1: TOpenDialog;
    BitBtn1: TBitBtn;
    tblOCRSequencia: TAutoIncField;
    tblOCRID: TStringField;
    tblOCRCaracter: TStringField;
    tblOCRImagem: TGraphicField;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure DBImage1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure tblOCRBeforeOpen(DataSet: TDataSet);
  private
  public
  end;

var
  ConjTeste: TConjTeste;

implementation

uses UOCR;

{$R *.DFM}

procedure TConjTeste.FormCreate(Sender: TObject);
begin
  tblOCR.Open;
end;

procedure TConjTeste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblOCR.Close;
  Action := caFree;
  ConjTeste := nil;
end;

procedure TConjTeste.FormActivate(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFilePath(Application.ExeName) + 'Bitmaps\Teste\';
end;

procedure TConjTeste.DBImage1DblClick(Sender: TObject);
begin
  OpenDialog1.FileName := tblOCR['ID'];
  if OpenDialog1.Execute then
  begin
    tblOCR.Edit;
    tblOCRImagem.LoadFromFile(OpenDialog1.FileName);
  end;
end;

procedure TConjTeste.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TConjTeste.BitBtn2Click(Sender: TObject);
begin
  tblOCR.First;
  while not tblOCR.EOF do
  begin
    tblOCR.Edit;
    tblOCRImagem.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Bitmaps\Teste\' + tblOCR['ID'] + '.bmp');
    tblOCR.Next;
  end;
end;

procedure TConjTeste.tblOCRBeforeOpen(DataSet: TDataSet);
begin
  tblOCR.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.
