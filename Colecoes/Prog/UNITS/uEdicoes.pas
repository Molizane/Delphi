unit uEdicoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModeloPDA, IBCustomDataSet, IBUpdateSQL, DB, IBQuery,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls,
  DBPanel;

type
  TFEdicoes = class(TFrmModeloPDA)
    tblCadastroCD_EDICAO: TIntegerField;
    tblCadastroCD_PUBLICACAO: TIntegerField;
    tblCadastroAN_EDICAO: TIntegerField;
    tblCadastroNU_EDICAO: TIntegerField;
    tblCadastroDT_CRIACAO: TDateTimeField;
    tblCadastroDT_ALTERACAO: TDateTimeField;
    tblCadastroIN_PDA: TIBStringField;
    tblCadastroID: TIntegerField;
    tblCadastroIN_DIRTY: TIBStringField;
    tblCadastroIN_DELETED: TIBStringField;
    btnConteudo: TBitBtn;
    procedure tblCadastroAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnConteudoClick(Sender: TObject);
    procedure tblCadastroAfterInsert(DataSet: TDataSet);
  private
    FCodPublicacao: Integer;
  public
    property CodPublicacao: Integer read FCodPublicacao write FCodPublicacao;
  end;

var
  FEdicoes: TFEdicoes;

implementation

uses
  uFModelo, uConteudo;

{$R *.dfm}

procedure TFEdicoes.tblCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnConteudo.Enabled := not DataSet.IsEmpty;
end;

procedure TFEdicoes.FormShow(Sender: TObject);
begin
  tblCadastro.Close;
  tblCadastro.ParamByName('CD_PUBLICACAO').AsInteger := FCodPublicacao;
  inherited;
end;

procedure TFEdicoes.btnConteudoClick(Sender: TObject);
begin
  Application.CreateForm(TFConteudo, FConteudo);

  try
    FConteudo.CodEdicao := tblCadastroCD_EDICAO.AsInteger;
    FConteudo.ShowModal;
  finally
    FConteudo.Release;
  end;
end;

procedure TFEdicoes.tblCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  tblCadastroCD_PUBLICACAO.AsInteger := FCodPublicacao;
end;

end.

