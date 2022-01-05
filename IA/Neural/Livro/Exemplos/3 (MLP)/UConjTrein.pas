unit UConjTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Db,
  ExtCtrls, Grids, DBTables, DBGrids, DBCtrls;

type
  TConjTrein = class(TForm)
    tblPrevis: TTable;
    dsPrevis: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    tblPrevisID: TIntegerField;
    tblPrevisHora: TFloatField;
    tblPrevisConsultas: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tblPrevisBeforeOpen(DataSet: TDataSet);
  private
  public
  end;

var
  ConjTrein: TConjTrein;

implementation

{$R *.DFM}

procedure TConjTrein.FormCreate(Sender: TObject);
begin
  tblPrevis.Open;
end;

procedure TConjTrein.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblPrevis.Close;
  Action := caFree;
  ConjTrein := nil;
end;

procedure TConjTrein.tblPrevisBeforeOpen(DataSet: TDataSet);
begin
  tblPrevis.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.

