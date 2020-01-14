unit uFModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, IBCustomDataSet, IBTable, DBCtrls, ExtCtrls,
  Grids, DBGrids, Buttons, Mask, IBQuery, IBUpdateSQL, DBPanel;

type
  TFrmModelo = class(TForm)
    pcCadastro: TPageControl;
    tsGrid: TTabSheet;
    tsCadastro: TTabSheet;
    gridCadastro: TDBGrid;
    pnlNavegador: TPanel;
    Navegador: TDBNavigator;
    tblCadastro: TIBQuery;
    dsCadastro: TDataSource;
    lblCodigo: TLabel;
    pnlCodigo: TDBPanel;
    lblDescricao: TLabel;
    edtDescricao: TDBEdit;
    pnlBotoesCadastro: TPanel;
    pnlBotoesGrid: TPanel;
    btnFechar: TBitBtn;
    CadUpdate: TIBUpdateSQL;
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    lblDtCriacao: TLabel;
    pnlDtCriacao: TDBPanel;
    lblDtAlteracao: TLabel;
    pnlDtAlteracao: TDBPanel;
    btnAceitar: TBitBtn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxClick(Sender: TObject);
    procedure ComboBoxCloseUp(Sender: TObject);
    procedure ComboBoxDropDown(Sender: TObject);
    procedure ComboBoxEnter(Sender: TObject);
    procedure ComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pcCadastroChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure tblCadastroAfterEdit(DataSet: TDataSet);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tblCadastroBeforePost(DataSet: TDataSet);
    procedure gridCadastroDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tblCadastroAfterInsert(DataSet: TDataSet);
    procedure tblCadastroBeforeInsert(DataSet: TDataSet);
    procedure tblCadastroAfterCancel(DataSet: TDataSet);
    procedure gridCadastroDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    Dropped, Selected, ParaCadastro: Boolean;
    FAcessoDireto: Boolean;
    FBookmark: string;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure MudaTab(NumTab: Integer);
  public
    property AcessoDireto: Boolean read FAcessoDireto write FAcessoDireto;
  end;

var
  FrmModelo: TFrmModelo;

implementation

uses
  uDMprincipal, uPrincipal;

{$R *.dfm}

{ TFrmModelo }

procedure TFrmModelo.CMDialogKey(var Message: TCMDialogKey);
begin
  if GetKeyState(VK_MENU) >= 0 then
    with Message do
      case CharCode of
        VK_TAB:
          if GetKeyState(VK_CONTROL) >= 0 then
          begin
            Result := 0;
            Exit;
          end;
      else
        inherited;
      end;
end;

procedure TFrmModelo.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [9, 13] then
  begin
    Key := 0;

    if not (ssCtrl in Shift) then
      SelectNext(ActiveControl, not (ssShift in Shift), True);
  end;
end;

procedure TFrmModelo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#9, #13] then
    Key := #0;
end;

procedure TFrmModelo.ComboBoxClick(Sender: TObject);
begin
  if Dropped and not Selected then
    keybd_event(VK_TAB, 0, 0, 0);
end;

procedure TFrmModelo.ComboBoxCloseUp(Sender: TObject);
begin
  Dropped := False;
  Selected := False;
  keybd_event(VK_TAB, 0, 0, 0);
end;

procedure TFrmModelo.ComboBoxDropDown(Sender: TObject);
begin
  Dropped := True;
end;

procedure TFrmModelo.ComboBoxEnter(Sender: TObject);
begin
  Selected := False;
  TCustomComboBox(Sender).DroppedDown := True;
end;

procedure TFrmModelo.ComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Selected := True;
end;

procedure TFrmModelo.pcCadastroChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := ParaCadastro;
end;

procedure TFrmModelo.FormCreate(Sender: TObject);
begin
  FBookmark := '';
  tsCadastro.TabVisible := False;
  tsCadastro.Visible := True;
  tsGrid.TabVisible := False;
  tsGrid.Visible := True;
  MudaTab(0);
end;

procedure TFrmModelo.tblCadastroAfterEdit(DataSet: TDataSet);
begin
  FBookmark := '';
  MudaTab(1);
end;

procedure TFrmModelo.MudaTab(NumTab: Integer);
begin
  ParaCadastro := True;

  try
    if NumTab = 1 then
    begin
      gridCadastro.DataSource := nil;
      lblCodigo.Visible := tblCadastro.State <> dsInsert;
      pnlCodigo.Visible := lblCodigo.Visible;
      lblDtCriacao.Visible := lblCodigo.Visible;
      lblDtAlteracao.Visible := lblCodigo.Visible;
      pnlDtCriacao.Visible := lblCodigo.Visible;
      pnlDtAlteracao.Visible := lblCodigo.Visible;

      {
      if pnlDtCriacao.Visible then
      begin
        pnlCodigo.Caption := tblCadastro.Fields[0].AsString + ' ';
        pnlDtCriacao.Caption := DateTimeToStr(tblCadastro.FieldByName('DT_CRIACAO').AsDateTime);
        pnlDtAlteracao.Caption := DateTimeToStr(tblCadastro.FieldByName('DT_ALTERACAO').AsDateTime);
      end;
      }

      if edtDescricao.CanFocus then
        edtDescricao.SetFocus;
    end
    else
      gridCadastro.DataSource := dsCadastro;

    pcCadastro.ActivePageIndex := NumTab;
  finally
    ParaCadastro := False;
  end;
end;

procedure TFrmModelo.btnGravarClick(Sender: TObject);
begin
  tblCadastro.Post;
  tblCadastro.Refresh;
  MudaTab(0);
end;

procedure TFrmModelo.btnCancelarClick(Sender: TObject);
begin
  tblCadastro.Cancel;
  MudaTab(0);
end;

procedure TFrmModelo.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if tblCadastro.Active then
    CanClose := pcCadastro.ActivePageIndex = 0;

  if CanClose and (tblCadastro.State in dsEditModes) then
    tblCadastro.Post;
end;

procedure TFrmModelo.tblCadastroBeforePost(DataSet: TDataSet);
var
  DtAtual: TDateTime;
begin
  DtAtual := Now;

  if (DataSet.State = dsInsert) and (DataSet.FindField('DT_CRIACAO') <> nil) then
    DataSet.FieldByName('DT_CRIACAO').AsDateTime := DtAtual;

  if DataSet.FindField('DT_ALTERACAO') <> nil then
    DataSet.FieldByName('DT_ALTERACAO').AsDateTime := DtAtual;
end;

procedure TFrmModelo.gridCadastroDblClick(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.IsEmpty then
    tblCadastro.Edit;
end;

procedure TFrmModelo.FormShow(Sender: TObject);
begin
  //FPrincipal.Visible := False;
  btnAceitar.Visible := FAcessoDireto;

  if tblCadastro.Active then
    tblCadastro.Refresh
  else
    tblCadastro.Open;
end;

procedure TFrmModelo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //FPrincipal.Visible := True;
end;

procedure TFrmModelo.tblCadastroAfterInsert(DataSet: TDataSet);
begin
  MudaTab(1);
end;

procedure TFrmModelo.tblCadastroBeforeInsert(DataSet: TDataSet);
begin
  if Assigned(DataSet) then
  begin
    if DataSet.IsEmpty then
      FBookmark := ''
    else
      FBookmark := DataSet.Bookmark;

    DataSet.Last;
  end;
end;

procedure TFrmModelo.tblCadastroAfterCancel(DataSet: TDataSet);
begin
  if FBookmark <> '' then
    DataSet.Bookmark := FBookmark;
end;

procedure TFrmModelo.gridCadastroDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  nTop, nLeft: Integer;
  Txt: string;
begin
  if (Column.Field.Size = 1) and ((Column.Field.AsString = 'T') or (Column.Field.AsString = 'F')) then
  begin
    if Column.Field.AsString = 'T' then
      Txt := 'S'
    else
      Txt := 'N';

    nLeft := (Rect.Right - Rect.Left - gridCadastro.Canvas.TextWidth(Txt)) div 2;
    nTop := (Rect.Bottom - Rect.Top - gridCadastro.Canvas.TextHeight(Txt)) div 2;
    gridCadastro.Canvas.FillRect(Rect);
    gridCadastro.Canvas.TextOut(Rect.Left + nLeft, Rect.Top + nTop, Txt);
  end
end;

end.

