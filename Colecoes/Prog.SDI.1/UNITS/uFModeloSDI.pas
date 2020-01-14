unit uFModeloSDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, StdCtrls, ComCtrls, IBCustomDataSet, IBTable, DBCtrls, ExtCtrls,
  Grids, DBGrids, Buttons, Mask, IBQuery, IBUpdateSQL, Menus, DBPanel,
  uPrincipalSDI, uDMprincipalSDI;

type
  TFrmModeloSDI = class(TForm)
    pcCadastro: TPageControl;
    tsGrid: TTabSheet;
    tsCadastro: TTabSheet;
    gridCadastro: TDBGrid;
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
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ComboBoxClick(Sender: TObject);
    procedure ComboBoxCloseUp(Sender: TObject);
    procedure ComboBoxDropDown(Sender: TObject);
    procedure ComboBoxEnter(Sender: TObject);
    procedure ComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pcCadastroChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure tblCadastroBeforePost(DataSet: TDataSet);
    procedure gridCadastroDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure smnOKClick(Sender: TObject);
    procedure smnFecharClick(Sender: TObject);
    procedure smnGravarClick(Sender: TObject);
    procedure smnCancelarClick(Sender: TObject);
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
    procedure gridCadastroDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure tblCadastroBeforeInsert(DataSet: TDataSet);
  private
    FDropped, FSelected, FParaCadastro: Boolean;
    FAcessoDireto: Boolean;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure Deletar;
  protected
    procedure MudaTab(NumTab: Integer);
  public
    property AcessoDireto: Boolean read FAcessoDireto write FAcessoDireto;
  end;

var
  FrmModeloSDI: TFrmModeloSDI;

implementation

uses
  uDefs;

{$R *.dfm}

{ TFrmModeloSDI }

procedure TFrmModeloSDI.CMDialogKey(var Message: TCMDialogKey);
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

procedure TFrmModeloSDI.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
  end;
end;

procedure TFrmModeloSDI.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#9, #13] then
    Key := #0;
end;

procedure TFrmModeloSDI.ComboBoxClick(Sender: TObject);
begin
  if FDropped and not FSelected then
    keybd_event(VK_TAB, 0, 0, 0);
end;

procedure TFrmModeloSDI.ComboBoxCloseUp(Sender: TObject);
begin
  FDropped := False;
  FSelected := False;
  keybd_event(VK_TAB, 0, 0, 0);
end;

procedure TFrmModeloSDI.ComboBoxDropDown(Sender: TObject);
begin
  FDropped := True;
end;

procedure TFrmModeloSDI.ComboBoxEnter(Sender: TObject);
begin
  FSelected := False;
  TCustomComboBox(Sender).DroppedDown := True;
end;

procedure TFrmModeloSDI.ComboBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FSelected := True;
end;

procedure TFrmModeloSDI.pcCadastroChanging(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := FParaCadastro;
end;

procedure TFrmModeloSDI.FormCreate(Sender: TObject);
begin
  Menu := nil;
  tsCadastro.TabVisible := False;
  tsCadastro.Visible := True;
  tsGrid.TabVisible := False;
  tsGrid.Visible := True;
  MudaTab(0);
  SetMenuItemRight(smnFechar);
end;

procedure TFrmModeloSDI.MudaTab(NumTab: Integer);
begin
  FParaCadastro := True;

  try
    if NumTab = 0 then
      Menu := MenuGrid
    else
    begin
      Menu := MenuCadastro;
      lblCodigo.Visible := tblCadastro.State <> dsInsert;
      pnlCodigo.Visible := lblCodigo.Visible;
      lblDtCriacao.Visible := lblCodigo.Visible;
      lblDtAlteracao.Visible := lblCodigo.Visible;
      pnlDtCriacao.Visible := lblCodigo.Visible;
      pnlDtAlteracao.Visible := lblCodigo.Visible;

      if edtDescricao.CanFocus then
        edtDescricao.SetFocus;
    end;

    pcCadastro.ActivePageIndex := NumTab;
  finally
    FParaCadastro := False;
  end;
end;

procedure TFrmModeloSDI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if tblCadastro.Active then
    CanClose := pcCadastro.ActivePageIndex = 0;

  if CanClose and (tblCadastro.State in dsEditModes) then
    tblCadastro.Post;
end;

procedure TFrmModeloSDI.tblCadastroBeforePost(DataSet: TDataSet);
var
  DtAtual: TDateTime;
begin
  DtAtual := Now;

  if (DataSet.State = dsInsert) and (DataSet.FindField('DT_CRIACAO') <> nil) then
    DataSet.FieldByName('DT_CRIACAO').AsDateTime := DtAtual;

  if DataSet.FindField('DT_ALTERACAO') <> nil then
    DataSet.FieldByName('DT_ALTERACAO').AsDateTime := DtAtual;
end;

procedure TFrmModeloSDI.gridCadastroDblClick(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.IsEmpty then
    tblCadastro.Edit;
end;

procedure TFrmModeloSDI.FormShow(Sender: TObject);
begin
  FPrincipal.Visible := False;
  smnOK.Visible := FAcessoDireto;

  if tblCadastro.Active then
    tblCadastro.Refresh
  else
    tblCadastro.Open;
end;

procedure TFrmModeloSDI.smnOKClick(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;

procedure TFrmModeloSDI.smnFecharClick(Sender: TObject);
begin
  ModalResult := mrAbort;
  Close;
end;

procedure TFrmModeloSDI.smnGravarClick(Sender: TObject);
begin
  tblCadastro.Post;
  tblCadastro.Refresh;
  MudaTab(0);
end;

procedure TFrmModeloSDI.smnCancelarClick(Sender: TObject);
begin
  tblCadastro.Cancel;
  MudaTab(0);
end;

procedure TFrmModeloSDI.LabelMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline {, fsBold}];
end;

procedure TFrmModeloSDI.LabelMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlack;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline {, fsBold}];
end;

procedure TFrmModeloSDI.lblF2Click(Sender: TObject);
begin
  if tblCadastro.Active and not (tblCadastro.State in dsEditModes) then
    tblCadastro.Insert;
end;

procedure TFrmModeloSDI.lblF3Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.IsEmpty then
    Deletar;
end;

procedure TFrmModeloSDI.lblF4Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.IsEmpty and not (tblCadastro.State in dsEditModes) then
    tblCadastro.Edit;
end;

procedure TFrmModeloSDI.lblF5Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.BOF then
    tblCadastro.First
end;

procedure TFrmModeloSDI.lblF6Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.BOF then
    tblCadastro.Prior;
end;

procedure TFrmModeloSDI.lblF7Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.EOF then
    tblCadastro.Next;
end;

procedure TFrmModeloSDI.lblF8Click(Sender: TObject);
begin
  if tblCadastro.Active and not tblCadastro.EOF then
    tblCadastro.Last;
end;

procedure TFrmModeloSDI.lblF9Click(Sender: TObject);
begin
  if tblCadastro.Active and not (tblCadastro.State in dsEditModes) then
    tblCadastro.Refresh;
end;

procedure TFrmModeloSDI.Deletar;
begin
  if Application.MessageBox('Confirma exclusão...', 'Confirmação', MB_YESNO) = IDYES then
    tblCadastro.Delete;
end;

procedure TFrmModeloSDI.gridCadastroDrawColumnCell(Sender: TObject;
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

procedure TFrmModeloSDI.tblCadastroBeforeInsert(DataSet: TDataSet);
begin
  MudaTab(1);
end;

end.

