unit uConteudoMDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloMDIPDA, IBCustomDataSet, IBUpdateSQL, IBQuery, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel,
  kbmMemTable;

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
    procedure smnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FCodEdicao: Integer;
  public
    property CodEdicao: Integer read FCodEdicao write FCodEdicao;
  end;

var
  FConteudo: TFConteudo;

implementation

uses uEdicoesMDI;

//uses
//  uFModelo, uEdicoes;

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

procedure TFConteudo.smnFecharClick(Sender: TObject);
begin
  PostMessage(FEdicoes.Handle, WM_USER + 1001, 0, 0);
  Close;
end;

procedure TFConteudo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.

