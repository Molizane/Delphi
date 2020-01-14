unit uPrincipalMDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, ExtCtrls;

type
  TFPrincipal = class(TForm)
    MainMenu: TMainMenu;
    mnCadastros: TMenuItem;
    smnTipos: TMenuItem;
    smnCategorias: TMenuItem;
    smnEditoras: TMenuItem;
    smnPublicacoes: TMenuItem;
    mnSair: TMenuItem;
    pnlBotoes: TPanel;
    btnCategorias: TLabel;
    btnTipos: TLabel;
    btnEditoras: TLabel;
    btnPublicacoes: TLabel;
    procedure smnCategoriasClick(Sender: TObject);
    procedure smnTiposClick(Sender: TObject);
    procedure smnEditorasClick(Sender: TObject);
    procedure smnPublicacoesClick(Sender: TObject);
    procedure mnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCategoriasClick(Sender: TObject);
    procedure btnTiposClick(Sender: TObject);
    procedure btnEditorasClick(Sender: TObject);
    procedure btnPublicacoesClick(Sender: TObject);
    procedure LabelMouseEnter(Sender: TObject);
    procedure LabelMouseLeave(Sender: TObject);
  private
    FCadOrig: TForm;
    FTpCad: Integer;
    procedure CreateMDIChild(Orig, Form: TForm; Idx: Integer; Direto: Boolean);
    procedure SendCod(var Msg: TMessage); message WM_USER + 1000;
  public
    procedure CadCategorias(Orig: TForm; Direto: Boolean);
    procedure CadTipos(Orig: TForm; Direto: Boolean);
    procedure CadEditoras(Orig: TForm; Direto: Boolean);
    procedure CadPublicacoes(Orig: TForm; Direto: Boolean);
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  uDefs, uPublicacoesMDI, uDMPrincipalMDI, uCategoriasMDI, uConteudoMDI,
  uEdicoesMDI, uEditorasMDI, uTiposMDI, uFModeloMDI;

//uses
//  uTipos, uCategorias, uEditoras, uPublicacoes, uFModelo, uDefs, uDMPrincipal;

{$R *.dfm}

procedure TFPrincipal.smnCategoriasClick(Sender: TObject);
begin
  pnlBotoes.Visible := False;
  CadCategorias(Self, False);
end;

procedure TFPrincipal.smnTiposClick(Sender: TObject);
begin
  pnlBotoes.Visible := False;
  CadTipos(Self, False);
end;

procedure TFPrincipal.smnEditorasClick(Sender: TObject);
begin
  pnlBotoes.Visible := False;
  CadEditoras(Self, False);
end;

procedure TFPrincipal.smnPublicacoesClick(Sender: TObject);
begin
  pnlBotoes.Visible := False;
  CadPublicacoes(Self, False);
end;

procedure TFPrincipal.CadCategorias(Orig: TForm; Direto: Boolean);
begin
  //Application.CreateForm(TFCategorias, FCategorias);
  CreateMDIChild(Orig, TFCategorias.Create(self), tpCadCategorias, Direto);
end;

procedure TFPrincipal.CadEditoras(Orig: TForm; Direto: Boolean);
begin
  //Application.CreateForm(TFEditoras, FEditoras);
  CreateMDIChild(Orig, TFEditoras.Create(self), tpCadEditoras, Direto);
end;

procedure TFPrincipal.CadPublicacoes(Orig: TForm; Direto: Boolean);
begin
  Application.CreateForm(TFPublicacoes, FPublicacoes);
  CreateMDIChild(Orig, FPublicacoes, tpCadPublicacoes, Direto);
end;

procedure TFPrincipal.CadTipos(Orig: TForm; Direto: Boolean);
begin
  //Application.CreateForm(TFTipos, FTipos);
  CreateMDIChild(Orig, TFTipos.Create(self), tpCadTipos, Direto);
end;

procedure TFPrincipal.CreateMDIChild(Orig, Form: TForm; Idx: Integer; Direto: Boolean);
begin
  TFrmModelo(Form).AcessoDireto := Direto;

  if Direto and Assigned(Orig) then
    FCadOrig := Orig
  else
    FCadOrig := nil;

  FTpCad := Idx;

  Form.Top := ClientHeight - 100;
  Form.WindowState := wsMaximized;
  Form.FormStyle := fsMDIChild;
end;

procedure TFPrincipal.SendCod(var Msg: TMessage);
begin
  if Assigned(FCadOrig) then
    PostMessage(FCadOrig.Handle, WM_USER + 1000, Msg.WParam, FTpCad);
end;

procedure TFPrincipal.mnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  DMPrincipal.DBColecoes.Open;
end;

procedure TFPrincipal.btnCategoriasClick(Sender: TObject);
begin
  smnCategorias.Click;
end;

procedure TFPrincipal.btnTiposClick(Sender: TObject);
begin
  smnTipos.Click;
end;

procedure TFPrincipal.btnEditorasClick(Sender: TObject);
begin
  smnEditoras.Click;
end;

procedure TFPrincipal.btnPublicacoesClick(Sender: TObject);
begin
  smnPublicacoes.Click;
end;

procedure TFPrincipal.LabelMouseEnter(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlue;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline {, fsBold}];
end;

procedure TFPrincipal.LabelMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Color := clBlack;
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline {, fsBold}];
end;

end.

