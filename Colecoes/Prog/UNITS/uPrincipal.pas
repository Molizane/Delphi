unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus;

type
  TFPrincipal = class(TForm)
    MainMenu: TMainMenu;
    mnCadastros: TMenuItem;
    smnTipos: TMenuItem;
    smnCategorias: TMenuItem;
    smnEditoras: TMenuItem;
    smnPublicacoes: TMenuItem;
    mnSair: TMenuItem;
    procedure smnCategoriasClick(Sender: TObject);
    procedure smnTiposClick(Sender: TObject);
    procedure smnEditorasClick(Sender: TObject);
    procedure smnPublicacoesClick(Sender: TObject);
    procedure mnSairClick(Sender: TObject);
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
  uTipos, uCategorias, uEditoras, uPublicacoes;

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

  try
    FCategorias.AcessoDireto := Direto;

    if FCategorias.ShowModal = mrOk then
      Result := FCategorias.tblCadastro.FieldByName('CD_CATEGORIA').AsInteger;
  finally
    FCategorias.Release;
  end;
end;

function TFPrincipal.CadEditoras(Direto: Boolean): Integer;
begin
  Result := 0;
  Application.CreateForm(TFEditoras, FEditoras);

  try
    FEditoras.AcessoDireto := Direto;

    if FEditoras.ShowModal = mrOk then
      Result := FEditoras.tblCadastro.FieldByName('CD_EDITORA').AsInteger;
  finally
    FEditoras.Release;
  end;
end;

function TFPrincipal.CadPublicacoes(Direto: Boolean): Integer;
begin
  Result := 0;
  Application.CreateForm(TFPublicacoes, FPublicacoes);

  try
    FPublicacoes.AcessoDireto := Direto;

    if FPublicacoes.ShowModal = mrOk then
      Result := FPublicacoes.tblCadastro.FieldByName('CD_PUBLICACAO').AsInteger;
  finally
    FPublicacoes.Release;
  end;
end;

function TFPrincipal.CadTipos(Direto: Boolean): Integer;
begin
  Result := 0;
  Application.CreateForm(TFTipos, FTipos);

  try
    FTipos.AcessoDireto := Direto;

    if FTipos.ShowModal = mrOk then
      Result := FTipos.tblCadastro.FieldByName('CD_TIPO').AsInteger;
  finally
    FTipos.Release;
  end;
end;

procedure TFPrincipal.mnSairClick(Sender: TObject);
begin
  Close;
end;

end.

