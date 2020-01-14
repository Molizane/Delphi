unit uFModeloSDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, StdCtrls, ComCtrls, IBCustomDataSet, IBTable, DBCtrls, ExtCtrls,
  Grids, DBGrids, Buttons, Mask, IBQuery, IBUpdateSQL, Menus, DBPanel,
  kbmMemTable;

type
  TFrmModelo = class(TForm)
    pcCadastro: TPageControl;
    tsGrid: TTabSheet;
    tsCadastro: TTabSheet;
    grdCadastro: TDBGrid;
    pnlNavegador: TPanel;
    Navegador: TDBNavigator;
    tblCadastro: TIBQuery;
    dsCadastro: TDataSource;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    edtDescricao: TDBEdit;
    CadUpdate: TIBUpdateSQL;
    lblDtCriacao: TLabel;
    pnlDtCriacao: TDBPanel;
    lblDtAlteracao: TLabel;
    pnlDtAlteracao: TDBPanel;
    MenuGrid: TMainMenu;
    smnOK: TMenuItem;
    smnFechar: TMenuItem;
    MenuCadastro: TMainMenu;
    smnGravar: TMenuItem;
    smnCancelar: TMenuItem;
    pnlCodigo: TDBPanel;
    lblF2: TLabel;
    lblF3: TLabel;
    lblF4: TLabel;
    lblF5: TLabel;
    lblF6: TLabel;
    lblF7: TLabel;
    lblF8: TLabel;
    lblF9: TLabel;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    tsMultiplos: TTabSheet;
    dsMultiplo: TDataSource;
    grdMultiplo: TDBGrid;
    tblMultiplo: TkbmMemTable;
    btnMultiplo: TLabel;
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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tblCadastroBeforePost(DataSet: TDataSet);
    procedure grdCadastroDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure smnOKClick(Sender: TObject);
    procedure smnFecharClick(Sender: TObject);
    procedure smnGravarClick(Sender: TObject);
    procedure smnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabelMouseEnter(Sender: TObject);
    procedure LabelMouseLeave(Sender: TObject);
    procedure lblF2Click(Sender: TObject);
    procedure lblF3Click(Sender: TObject);
    procedure lblF4Click(Sender: TObject);
    procedure lblF5Click(Sender: TObject);
    procedure lblF6Click(Sender: TObject);
    procedure lblF7Click(Sender: TObject);
    procedure lblF8Click(Sender: TObject);
    procedure lblF9Click(Sender: TObject);
    procedure tblCadastroAfterInsert(DataSet: TDataSet);
    procedure tblCadastroBeforeInsert(DataSet: TDataSet);
    procedure tblCadastroAfterCancel(DataSet: TDataSet);
    procedure btnMultiploClick(Sender: TObject);
    procedure grdCadastroDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    Dropped, Selected, ParaCadastro: Boolean;
    FAcessoDireto: Boolean;
    FBookmark: string;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure Deletar;
  protected
    procedure MudaTab(NumTab: Integer);
  public
    property AcessoDireto: Boolean read FAcessoDireto write FAcessoDireto;
    procedure GravaMultiplo; virtual;
  end;

var
  FrmModelo: TFrmModelo;

implementation

uses
  uDefs, uPrincipalSDI;

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
  if (Shift = []) and
    (Key in [VK_F2, VK_F3, VK_F4, VK_F5, VK_F6, VK_F7, VK_F8, VK_F9]) then
  begin
    if tblCadastro.Active then
      if (Key = VK_F2) and not (tblCadastro.State in dsEditModes) then
        tblCadastro.Append
      else if (Key = VK_F3) and not tblCadastro.IsEmpty then
        Deletar
      else if (Key = VK_F4) and not tblCadastro.IsEmpty then
        tblCadastro.Edit
      else if (Key = VK_F5) and not tblCadastro.BOF then
        tblCadastro.First
      else if (Key = VK_F6) and not tblCadastro.BOF then
        tblCadastro.Prior
      else if (Key = VK_F7) and not tblCadastro.EOF then
        tblCadastro.Next
      else if (Key = VK_F8) and not tblCadastro.EOF then
        tblCadastro.Last
      else if (Key = VK_F9) and not (tblCadastro.State in dsEditModes) then
        tblCadastro.Refresh;

    Key := 0;
  end
  else if Key in [9, 13] then
  begin
    Key := 0;

    if not (ssCtrl in Shift) then
      SelectNext(ActiveControl, not (ssShift in Shift), True);
  end
  else if (Key = VK_F2) and (pcCadastro.ActivePageIndex = 1) and btnMultiplo.Enabled then
  begin
    Key := 0;
    Mudatab(2);
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
  Menu := MenuCadastro;
  tsCadastro.TabVisible := False;
  tsCadastro.Visible := True;
  tsGrid.TabVisible := False;
  tsGrid.Visible := True;
  tsMultiplos.TabVisible := False;
  tsMultiplos.Visible := True;
  SetMenuItemRight(smnFechar);
end;

procedure TFrmModelo.tblCadastroAfterEdit(DataSet: TDataSet);
begin
  MudaTab(1);
end;

procedure TFrmModelo.MudaTab(NumTab: Integer);
begin
  ParaCadastro := True;

  try
    if NumTab = 0 then
    begin
      Menu := MenuGrid;
      grdCadastro.DataSource := dsCadastro;
    end
    else if NumTab = 1 then
    begin
      grdCadastro.DataSource := nil;
      Menu := MenuCadastro;
      lblCodigo.Visible := tblCadastro.State <> dsInsert;
      pnlCodigo.Visible := lblCodigo.Visible;
      lblDtCriacao.Visible := lblCodigo.Visible;
      lblDtAlteracao.Visible := lblCodigo.Visible;
      pnlDtCriacao.Visible := lblCodigo.Visible;
      pnlDtAlteracao.Visible := lblCodigo.Visible;
      btnMultiplo.Enabled := tblCadastro.State = dsInsert;
    end;

    pcCadastro.ActivePageIndex := NumTab;
    Application.ProcessMessages;

    if NumTab = 0 then
    begin
      if grdCadastro.CanFocus then
        grdCadastro.SetFocus;
    end
    else if NumTab = 1 then
    begin
      if edtDescricao.CanFocus then
        edtDescricao.SetFocus;
    end
    else if NumTab = 2 then
      if grdMultiplo.CanFocus then
        grdMultiplo.SetFocus;
  finally
    ParaCadastro := False;
  end;
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

procedure TFrmModelo.grdCadastroDblClick(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.IsEmpty then
    tblCadastro.Edit;
end;

procedure TFrmModelo.FormShow(Sender: TObject);
begin
  MudaTab(0);

  smnOK.Visible := FAcessoDireto;

  if tblCadastro.Active then
    tblCadastro.Refresh
  else
    tblCadastro.Open;
end;

procedure TFrmModelo.smnOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmModelo.smnFecharClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TFrmModelo.smnGravarClick(Sender: TObject);
begin
  if pcCadastro.ActivePageIndex = 2 then
    GravaMultiplo
  else
  begin
    tblCadastro.Post;
    tblCadastro.Refresh;
  end;

  MudaTab(0);
end;

procedure TFrmModelo.smnCancelarClick(Sender: TObject);
begin
  tblCadastro.Cancel;
  MudaTab(0);
end;

procedure TFrmModelo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmModelo.LabelMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline {, fsBold}];
end;

procedure TFrmModelo.LabelMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlack;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline {, fsBold}];
end;

procedure TFrmModelo.lblF2Click(Sender: TObject);
begin
  if tblCadastro.Active and not (tblCadastro.State in dsEditModes) then
    tblCadastro.Append;
end;

procedure TFrmModelo.lblF3Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.IsEmpty then
    Deletar;
end;

procedure TFrmModelo.lblF4Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.IsEmpty and not (tblCadastro.State in dsEditModes) then
    tblCadastro.Edit;
end;

procedure TFrmModelo.lblF5Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.BOF then
    tblCadastro.First
end;

procedure TFrmModelo.lblF6Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.BOF then
    tblCadastro.Prior;
end;

procedure TFrmModelo.lblF7Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.EOF then
    tblCadastro.Next;
end;

procedure TFrmModelo.lblF8Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.EOF then
    tblCadastro.Last;
end;

procedure TFrmModelo.lblF9Click(Sender: TObject);
begin
  if tblCadastro.Active and not (tblCadastro.State in dsEditModes) then
    tblCadastro.Refresh;
end;

procedure TFrmModelo.Deletar;
begin
  if Application.MessageBox('Confirma exclusão...', 'Confirmação', MB_YESNO) = IDYES then
    tblCadastro.Delete;
end;

procedure TFrmModelo.tblCadastroAfterInsert(DataSet: TDataSet);
begin
  if pcCadastro.ActivePageIndex <> 2 then
    MudaTab(1);
end;

procedure TFrmModelo.tblCadastroBeforeInsert(DataSet: TDataSet);
begin
  if DataSet.IsEmpty then
    FBookmark := ''
  else
    FBookmark := DataSet.Bookmark;

  DataSet.Last;
end;

procedure TFrmModelo.tblCadastroAfterCancel(DataSet: TDataSet);
begin
  if FBookmark <> '' then
    DataSet.Bookmark := FBookmark;
end;

procedure TFrmModelo.GravaMultiplo;
begin

end;

procedure TFrmModelo.btnMultiploClick(Sender: TObject);
begin
  MudaTab(2);
end;

procedure TFrmModelo.grdCadastroDrawColumnCell(Sender: TObject;
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

    nLeft := (Rect.Right - Rect.Left - grdCadastro.Canvas.TextWidth(Txt)) div 2;
    nTop := (Rect.Bottom - Rect.Top - grdCadastro.Canvas.TextHeight(Txt)) div 2;
    grdCadastro.Canvas.FillRect(Rect);
    grdCadastro.Canvas.TextOut(Rect.Left + nLeft, Rect.Top + nTop, Txt);
  end
end;

end.

