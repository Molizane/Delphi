unit UConjTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, Db, DBTables, DBGrids, DBCtrls;

type
  TConjTrein = class(TForm)
    tblSegment: TTable;
    dsSegment: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tblSegmentBeforeOpen(DataSet: TDataSet);
  private
  public
  end;

var
  ConjTrein: TConjTrein;

implementation

{$R *.DFM}

procedure TConjTrein.FormCreate(Sender: TObject);
begin
  tblSegment.Open;
end;

procedure TConjTrein.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblSegment.Refresh;
  tblSegment.Close;
  Action := caFree;
  ConjTrein := nil;
end;

procedure TConjTrein.tblSegmentBeforeOpen(DataSet: TDataSet);
begin
  tblSegment.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.

