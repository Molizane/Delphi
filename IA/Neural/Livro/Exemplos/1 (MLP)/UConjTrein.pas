unit UConjTrein;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Grids, Db, DBTables, DBGrids, DBCtrls;

type
  TConjTrein = class(TForm)
    tblPerfil: TTable;
    dsPerfil: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    tblPerfilID: TIntegerField;
    tblPerfilNInvAR: TIntegerField;
    tblPerfilNInvMR: TIntegerField;
    tblPerfilNInvBR: TIntegerField;
    tblPerfilIdade: TIntegerField;
    tblPerfilSexo: TIntegerField;
    tblPerfilRenda: TFloatField;
    tblPerfilPMI: TFloatField;
    tblPerfilEscolaridade: TIntegerField;
    tblPerfilPerfil: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure tblPerfilBeforeOpen(DataSet: TDataSet);
  private
  public
  end;

var
  ConjTrein: TConjTrein;

implementation

{$R *.DFM}

procedure TConjTrein.FormCreate(Sender: TObject);
begin
  tblPerfil.Open;
end;

procedure TConjTrein.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  tblPerfil.Close;
  Action := caFree;
  ConjTrein := nil;
end;

procedure TConjTrein.FormActivate(Sender: TObject);
begin
  DBGrid1.Columns[0].Width := 25;
  DBGrid1.Columns[1].Width := 44;
  DBGrid1.Columns[2].Width := 44;
  DBGrid1.Columns[3].Width := 44;
  DBGrid1.Columns[4].Width := 30;
  DBGrid1.Columns[5].Width := 30;
  DBGrid1.Columns[6].Width := 55;
  DBGrid1.Columns[7].Width := 30;
  DBGrid1.Columns[8].Width := 30;
  DBGrid1.Columns[9].Width := 30;
end;

procedure TConjTrein.tblPerfilBeforeOpen(DataSet: TDataSet);
begin
  tblPerfil.DatabaseName := ExtractFilePath(Application.ExeName);
end;

end.

