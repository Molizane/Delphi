unit uCadPessoas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModelo, DB, IBCustomDataSet, IBTable, DBCtrls, ExtCtrls, Grids,
  DBGrids, ComCtrls, StdCtrls, Buttons, Mask, IBQuery, IBUpdateSQL;

type
  TFCadPessoas = class(TFrmModelo)
    tblCadastroID_PESSOA: TIntegerField;
    tblCadastroNO_PESSOA: TIBStringField;
    tblCadastroID_TIPO: TIntegerField;
    tblCadastroIN_FJ: TIBStringField;
    tblCadastroDT_CRIACAO: TDateTimeField;
    tblCadastroDT_ALTERACAO: TDateTimeField;
    DBRadioGroup1: TDBRadioGroup;
    qryTipos: TIBQuery;
    dsTipos: TDataSource;
    cmbTipo: TDBLookupComboBox;
    lblTipo: TLabel;
    tblCadastroNO_TIPO: TIBStringField;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  FCadPessoas: TFCadPessoas;

implementation

uses
  uDMprincipal;

{$R *.dfm}

procedure TFCadPessoas.FormShow(Sender: TObject);
begin
  inherited;

  qryTipos.Close;
  qryTipos.Open;
end;

end.

