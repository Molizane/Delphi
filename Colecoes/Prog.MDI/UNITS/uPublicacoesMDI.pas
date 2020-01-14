unit uPublicacoesMDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloMDIPDA, IBCustomDataSet, IBUpdateSQL, IBQuery, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel,
  kbmMemTable;

type
  TFPublicacoes = class(TFrmModeloPDA)
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
    procedure FormShow(Sender: TObject);
    procedure btnTiposClick(Sender: TObject);
    procedure btnCategoriasClick(Sender: TObject);
    procedure btnEditorasClick(Sender: TObject);
    procedure tblCadastroAfterScroll(DataSet: TDataSet);
    procedure btnEdicoesClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure GetCod(var Msg: TMessage); message WM_USER + 1000;
    procedure Reshow(var Msg: TMessage); message WM_USER + 1001;
  public
  end;

var
  FPublicacoes: TFPublicacoes;

implementation

uses uDefs, uPrincipalMDI, uEdicoesMDI;

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
begin
  FPrincipal.CadTipos(Self, True);
end;

procedure TFPublicacoes.btnCategoriasClick(Sender: TObject);
begin
  FPrincipal.CadCategorias(Self, True);
end;

procedure TFPublicacoes.btnEditorasClick(Sender: TObject);
begin
  FPrincipal.CadEditoras(Self, True);
end;

procedure TFPublicacoes.tblCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnEdicoes.Enabled := not DataSet.IsEmpty;
end;

procedure TFPublicacoes.btnEdicoesClick(Sender: TObject);
begin
  Application.CreateForm(TFEdicoes, FEdicoes);
  FEdicoes.CodPublicacao := tblCadastroCD_PUBLICACAO.AsInteger;
  FEdicoes.Top := ClientHeight - 100;
  FEdicoes.WindowState := wsMaximized;
  FEdicoes.FormStyle := fsMDIChild;
end;

procedure TFPublicacoes.GetCod(var Msg: TMessage);
begin
  FPrincipal.Menu := MenuCadastro;
  WindowState := wsMaximized;

  if Msg.WParam <> 0 then
  begin
    if not (tblCadastro.State in dsEditModes) then
      tblCadastro.Edit;

    case Msg.LParam of
      tpCadCategorias:
        begin
          qryCategorias.Close;
          qryCategorias.Open;
          tblCadastro.FieldByName('CD_CATEGORIA').AsInteger := Msg.WParam;
        end;
      tpCadTipos:
        begin
          qryTipos.Close;
          qryTipos.Open;
          tblCadastro.FieldByName('CD_TIPO').AsInteger := Msg.WParam;
        end;
      tpCadEditoras:
        begin
          qryEditoras.Close;
          qryEditoras.Open;
          tblCadastro.FieldByName('CD_EDITORA').AsInteger := Msg.WParam;
        end;
    end;
  end;

  case Msg.LParam of
    tpCadCategorias:
      cmbCategoria.SetFocus;
    tpCadTipos:
      cmbTipo.SetFocus;
    tpCadEditoras:
      cmbEditora.SetFocus;
  end;
end;

procedure TFPublicacoes.Reshow(var Msg: TMessage);
begin
  MudaTab(0);
  WindowState := wsMaximized;
end;

procedure TFPublicacoes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Shift = []) and (Key = VK_F12)) or ((Shift = [ssAlt]) and (Key = Ord('E'))) then
  begin
    Key := 0;
    btnEdicoesClick(btnEdicoes);
  end
  else
    inherited;
end;

end.

