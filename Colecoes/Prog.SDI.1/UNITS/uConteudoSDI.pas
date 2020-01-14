unit uConteudoSDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModeloSDIPDA, IBCustomDataSet, IBUpdateSQL, DB, IBQuery, StdCtrls,
  Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel;

type
  TFConteudo = class(TFrmModeloSDIPDA)
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

