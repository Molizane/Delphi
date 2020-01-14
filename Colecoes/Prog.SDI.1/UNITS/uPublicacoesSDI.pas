unit uPublicacoesSDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloSDIPDA, IBCustomDataSet, IBUpdateSQL, IBQuery, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel;

type
  TFPublicacoes = class(TFrmModeloSDIPDA)
    tblCadastroCD_PUBLICACAO: TIntegerField;
    tblCadastroCD_EDITORA: TIntegerField;
    tblCadastroCD_TIPO: TIntegerField;
    tblCadastroCD_CATEGORIA: TIntegerField;
    tblCadastroNO_PUBLICACAO: TIBStringField;
    tblCadastroNR_PUBLICACAO: TIBStringField;
    tblCadastroDT_CRIACAO: TDateTimeField;
    tblCadastroDT_ALTERACAO: TDateTimeField;
    tblCadastroIN_PDA: TIBStringField;
    tblCadastroID: TIntegerField;
    tblCadastroIN_DIRTY: TIBStringField;
    tblCadastroIN_DELETED: TIBStringField;
    tblCadastroNO_TIPO: TIBStringField;
    tblCadastroNO_CATEGORIA: TIBStringField;
    tblCadastroNO_EDITORA: TIBStringField;
    lblTipo: TLabel;
    lblCategoria: TLabel;
    lblEditora: TLabel;
    cmbTipo: TDBLookupComboBox;
    cmbCategoria: TDBLookupComboBox;
    cmbEditora: TDBLookupComboBox;
    qryTipos: TIBQuery;
    qryCategorias: TIBQuery;
    qryEditoras: TIBQuery;
    dsTipo: TDataSource;
    dsCategoria: TDataSource;
    dsEditora: TDataSource;
    btnTipos: TSpeedButton;
    btnCategorias: TSpeedButton;
    btnEditoras: TSpeedButton;
    btnEdicoes: TLabel;
    smnEdicoes: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnTiposClick(Sender: TObject);
    procedure btnCategoriasClick(Sender: TObject);
    procedure btnEditorasClick(Sender: TObject);
    procedure tblCadastroAfterScroll(DataSet: TDataSet);
    procedure btnEdicoesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure smnEdicoesClick(Sender: TObject);
  private
  public
  end;

var
  FPublicacoes: TFPublicacoes;

implementation

uses uPrincipalSDI, uEdicoesSDI;

{$R *.dfm}

procedure TFPublicacoes.FormShow(Sender: TObject);
begin
  inherited;
  qryTipos.Close;
  qryTipos.Open;
  qryCategorias.Close;
  qryCategorias.Open;
  qryEditoras.Close;
  qryEditoras.Open;
end;

procedure TFPublicacoes.btnTiposClick(Sender: TObject);
var
  codigo: Integer;
begin
  codigo := FPrincipal.CadTipos(True);
  SetFocus;
  qryTipos.Close;
  qryTipos.Open;

  if codigo <> 0 then
  begin
    if not (tblCadastro.State in dsEditModes) then
      tblCadastro.Edit;

    tblCadastro.FieldByName('CD_TIPO').AsInteger := codigo;
  end;
end;

procedure TFPublicacoes.btnCategoriasClick(Sender: TObject);
var
  codigo: Integer;
begin
  codigo := FPrincipal.CadCategorias(True);
  SetFocus;
  qryCategorias.Close;
  qryCategorias.Open;

  if codigo <> 0 then
  begin
    if not (tblCadastro.State in dsEditModes) then
      tblCadastro.Edit;

    tblCadastro.FieldByName('CD_CATEGORIA').AsInteger := codigo;
  end;
end;

procedure TFPublicacoes.btnEditorasClick(Sender: TObject);
var
  codigo: Integer;
begin
  codigo := FPrincipal.CadEditoras(True);
  SetFocus;
  qryEditoras.Close;
  qryEditoras.Open;

  if codigo <> 0 then
  begin
    if not (tblCadastro.State in dsEditModes) then
      tblCadastro.Edit;

    tblCadastro.FieldByName('CD_EDITORA').AsInteger := codigo;
  end;
end;

procedure TFPublicacoes.tblCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnEdicoes.Enabled := not DataSet.IsEmpty;
end;

procedure TFPublicacoes.btnEdicoesClick(Sender: TObject);
begin
  Application.CreateForm(TFEdicoes, FEdicoes);

  try
    FEdicoes.Caption := FEdicoes.Caption + ' - ' + tblCadastroNO_PUBLICACAO.AsString;
    FEdicoes.CodPublicacao := tblCadastroCD_PUBLICACAO.AsInteger;
    FEdicoes.ShowModal;
  finally
    FEdicoes.Release;
  end;
end;

procedure TFPublicacoes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //  if ((Shift = []) and (Key = VK_F12)) or ((Shift = [ssAlt]) and (Key = Ord('E'))) then
  //  begin
  //    Key := 0;
  //    btnEdicoesClick(btnEdicoes);
  //  end
  //  else
  inherited;
end;

procedure TFPublicacoes.smnEdicoesClick(Sender: TObject);
begin
  btnEdicoesClick(btnEdicoes);
end;

end.

