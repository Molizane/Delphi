unit UConjTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, Db, DBTables, DBGrids, DBCtrls;

type
  TFrmConjTrein = class(TForm)
    tblVale5: TTable;
    dsPerfil: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    tblVale5IFR: TFloatField;
    tblVale5PERC_D: TFloatField;
    tblVale5PERC_K: TFloatField;
    tblVale5MFI: TFloatField;
    tblVale5UO: TFloatField;
    tblVale5SUPRES: TFloatField;
    tblVale5FUT: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  FrmConjTrein: TFrmConjTrein;

implementation

{$R *.DFM}

procedure TFrmConjTrein.FormCreate(Sender: TObject);
begin
  tblVale5.Open;
end;

procedure TFrmConjTrein.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblVale5.Close;
  Action := caFree;
  FrmConjTrein := nil;
end;

procedure TFrmConjTrein.FormActivate(Sender: TObject);
begin
  Exit;
  
  DBGrid1.Columns[0].Width := 55;
  DBGrid1.Columns[1].Width := 55;
  DBGrid1.Columns[2].Width := 55;
  DBGrid1.Columns[3].Width := 55;
  DBGrid1.Columns[4].Width := 55;
  DBGrid1.Columns[5].Width := 55;
  DBGrid1.Columns[6].Width := 55;
end;

end.

