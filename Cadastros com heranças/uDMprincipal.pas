unit uDMPrincipal;

interface

uses
  SysUtils, Classes, IBDatabase, DB;

type
  TDMPrincipal = class(TDataModule)
    DBCadastro: TIBDatabase;
    IBTransaction: TIBTransaction;
    procedure DBCadastroBeforeConnect(Sender: TObject);
  private
  public
  end;

var
  DMPrincipal: TDMPrincipal;

implementation

{$R *.dfm}

uses
  Forms;

procedure TDMPrincipal.DBCadastroBeforeConnect(Sender: TObject);
begin
  // 127.0.0.1:D:\Trabalho\Delphi\Cadastros com heranças\DB\CADASTRO.GDB
  DBCadastro.DatabaseName := '127.0.0.1:' + ExtractFilePath(Application.ExeName) + 'DB\CADASTRO.GDB';
end;

end.

