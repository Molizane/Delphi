unit uDMPrincipal;

interface

uses
  SysUtils, Classes, IBDatabase, DB;

type
  TDMPrincipal = class(TDataModule)
    DBColecoes: TIBDatabase;
    IBTransaction: TIBTransaction;
    procedure DBColecoesBeforeConnect(Sender: TObject);
  private
  public
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{$R *.dfm}

uses
  Forms;

procedure TDMPrincipal.DBColecoesBeforeConnect(Sender: TObject);
begin
  DBColecoes.DatabaseName := '127.0.0.1:' + ExtractFilePath(Application.ExeName) + 'DB\COLECOES.GDB';
end;

end.

