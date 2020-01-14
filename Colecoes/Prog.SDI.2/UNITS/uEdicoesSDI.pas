unit uEdicoesSDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloSDIPDA, IBCustomDataSet, IBUpdateSQL, IBQuery, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel,
  kbmMemTable;

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
    tblMultiploNU_EDICAO: TIntegerField;
    tblMultiploAN_EDICAO: TIntegerField;
    smnConteudo: TMenuItem;
    procedure tblCadastroAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure smnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tblCadastroAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure smnConteudoClick(Sender: TObject);
  private
    FCodPublicacao: Integer;
    procedure Reshow(var Msg: TMessage); message WM_USER + 1001;
  public
    property CodPublicacao: Integer read FCodPublicacao write FCodPublicacao;
    procedure GravaMultiplo; override;
  end;

var
  FEdicoes: TFEdicoes;

implementation

uses
  uConteudoSDI, uPublicacoesSDI;

{$R *.dfm}

procedure TFEdicoes.tblCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  smnConteudo.Enabled := not DataSet.IsEmpty;
end;

procedure TFEdicoes.FormShow(Sender: TObject);
begin
  tblCadastro.Close;
  tblCadastro.ParamByName('CD_PUBLICACAO').AsInteger := FCodPublicacao;
  inherited;
end;

procedure TFEdicoes.smnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFEdicoes.Reshow(var Msg: TMessage);
begin
  MudaTab(0);
end;

procedure TFEdicoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFEdicoes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ((Shift = []) and (Key = VK_F12) and (pcCadastro.ActivePageIndex = 0)) or ((Shift = [ssAlt]) and (Key = Ord('C'))) then
  begin
    Key := 0;
    smnConteudo.Click;
  end
  else
    inherited;
end;

procedure TFEdicoes.tblCadastroAfterInsert(DataSet: TDataSet);
begin
  inherited;
  tblCadastroCD_PUBLICACAO.AsInteger := FCodPublicacao;
end;

procedure TFEdicoes.GravaMultiplo;
begin
  inherited;

  if tblMultiplo.State in dsEditModes then
    tblMultiplo.Post;

  tblMultiplo.First;

  while not tblMultiplo.IsEmpty do
  begin
    if tblCadastro.State <> dsInsert then
      tblCadastro.Append;

    try
      tblCadastroNU_EDICAO.AsInteger := tblMultiploNU_EDICAO.AsInteger;
      tblCadastroAN_EDICAO.AsInteger := tblMultiploAN_EDICAO.AsInteger;
      tblCadastro.Post;
    except
      tblCadastro.Cancel;
      raise;
    end;

    tblMultiplo.Delete;
  end;
end;

procedure TFEdicoes.FormCreate(Sender: TObject);
begin
  inherited;
  tblMultiplo.Open;
  tblMultiplo.EmptyTable;
end;

procedure TFEdicoes.smnConteudoClick(Sender: TObject);
begin
  Application.CreateForm(TFConteudo, FConteudo);
  FConteudo.CodEdicao := tblCadastroCD_EDICAO.AsInteger;
  Visible := False;

  try
    FConteudo.Top := Top;
    FConteudo.Left := Left;
    FConteudo.Width := Width;
    FConteudo.Height := Height;
    FConteudo.ShowModal;
  finally
    Visible := True;
  end;
end;

end.

