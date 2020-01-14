unit uPrincipalSDI;

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
  public
    function CadCategorias(Direto: Boolean): Integer;
    function CadTipos(Direto: Boolean): Integer;
    function CadEditoras(Direto: Boolean): Integer;
    function CadPublicacoes(Direto: Boolean): Integer;
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  uDefs, uCategoriasSDI, uEditorasSDI, uPublicacoesSDI, uDMprincipalSDI,
  uTiposSDI;

{$R *.dfm}

procedure TFPrincipal.smnCategoriasClick(Sender: TObject);
begin
  CadCategorias(False);
end;

procedure TFPrincipal.smnTiposClick(Sender: TObject);
begin
  CadTipos(False);
end;

procedure TFPrincipal.smnEditorasClick(Sender: TObject);
begin
  CadEditoras(False);
end;

procedure TFPrincipal.smnPublicacoesClick(Sender: TObject);
begin
  CadPublicacoes(False);
end;

function TFPrincipal.CadCategorias(Direto: Boolean): Integer;
begin
  Result := 0;
  Application.CreateForm(TFCategorias, FCategorias);

  if not Direto then
  begin
    Enabled := False;
    Visible := False;
  end;

  try
    FCategorias.Top := Top;
    FCategorias.Left := Left;
    FCategorias.Width := Width;
    FCategorias.Height := Height;

    FCategorias.AcessoDireto := Direto;

    if FCategorias.ShowModal = mrOk then
      Result := FCategorias.tblCadastro.FieldByName('CD_CATEGORIA').AsInteger;
  finally
    try
      FCategorias.Release;
    finally
      if not Direto then
      begin
        Enabled := True;
        Visible := True;
      end;
    end;
  end;
end;

function TFPrincipal.CadEditoras(Direto: Boolean): Integer;
begin
  Result := 0;
  Application.CreateForm(TFEditoras, FEditoras);

  if not Direto then
  begin
    Enabled := False;
    Visible := False;
  end;

  try
    FEditoras.Top := Top;
    FEditoras.Left := Left;
    FEditoras.Width := Width;
    FEditoras.Height := Height;

    FEditoras.AcessoDireto := Direto;

    if FEditoras.ShowModal = mrOk then
      Result := FEditoras.tblCadastro.FieldByName('CD_EDITORA').AsInteger;
  finally
    try
      FEditoras.Release;
    finally
      if not Direto then
      begin
        Enabled := True;
        Visible := True;
      end;
    end;
  end;
end;

function TFPrincipal.CadPublicacoes(Direto: Boolean): Integer;
begin
  Result := 0;
  Application.CreateForm(TFPublicacoes, FPublicacoes);

  if not Direto then
  begin
    Enabled := False;
    Visible := False;
  end;

  try
    FPublicacoes.Top := Top;
    FPublicacoes.Left := Left;
    FPublicacoes.Width := Width;
    FPublicacoes.Height := Height;

    FPublicacoes.AcessoDireto := Direto;

    if FPublicacoes.ShowModal = mrOk then
      Result := FPublicacoes.tblCadastro.FieldByName('CD_PUBLICACAO').AsInteger;
  finally
    try
      FPublicacoes.Release;
    finally
      if not Direto then
      begin
        Enabled := True;
        Visible := True;
      end;
    end;
  end;
end;

function TFPrincipal.CadTipos(Direto: Boolean): Integer;
begin
  Result := 0;
  Application.CreateForm(TFTipos, FTipos);

  if not Direto then
  begin
    Enabled := False;
    Visible := False;
  end;

  try
    FTipos.Top := Top;
    FTipos.Left := Left;
    FTipos.Width := Width;
    FTipos.Height := Height;

    FTipos.AcessoDireto := Direto;

    if FTipos.ShowModal = mrOk then
      Result := FTipos.tblCadastro.FieldByName('CD_TIPO').AsInteger;
  finally
    try
      FTipos.Release;
    finally
      if not Direto then
      begin
        Enabled := True;
        Visible := True;
      end;
    end;
  end;
end;

procedure TFPrincipal.mnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFPrincipal.FormCreate(Sender: TObject);
begin
  SetMenuItemRight(mnSair);
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

