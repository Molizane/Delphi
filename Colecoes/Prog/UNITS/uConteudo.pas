unit uConteudo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModeloPDA, IBCustomDataSet, IBUpdateSQL, DB, IBQuery,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls,
  DBPanel;

type
  TFConteudo = class(TFrmModeloPDA)
    tblCadastroCD_CONTEUDO: TIntegerField;
    tblCadastroNU_PAGINA: TIntegerField;
    tblCadastroCD_EDICAO: TIntegerField;
    tblCadastroTX_CONTEUDO: TIBStringField;
    tblCadastroDT_CRIACAO: TDateTimeField;
    tblCadastroDT_ALTERACAO: TDateTimeField;
    tblCadastroIN_PDA: TIBStringField;
    tblCadastroID: TIntegerField;
    tblCadastroIN_DIRTY: TIBStringField;
    tblCadastroIN_DELETED: TIBStringField;
    procedure FormShow(Sender: TObject);
    procedure tblCadastroAfterEdit(DataSet: TDataSet);
  private
    FCodEdicao: Integer;
  public
    property CodEdicao: Integer read FCodEdicao write FCodEdicao;
  end;

var
  FConteudo: TFConteudo;

implementation

uses
  uFModelo;

{$R *.dfm}

procedure TFConteudo.FormShow(Sender: TObject);
begin
  tblCadastro.Close;
  tblCadastro.ParamByName('CD_EDICAO').AsInteger := FCodEdicao;
  inherited;
end;

procedure TFConteudo.tblCadastroAfterEdit(DataSet: TDataSet);
begin
  inherited;
  tblCadastroCD_EDICAO.AsInteger := FCodEdicao;
end;

end.

