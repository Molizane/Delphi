unit uEdicoesSDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloSDIPDA, IBCustomDataSet, IBUpdateSQL, IBQuery, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel;

type
  TFEdicoes = class(TFrmModeloSDIPDA)
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
    btnConteudo: TLabel;
    smnConteudo: TMenuItem;
    procedure tblCadastroAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure btnConteudoClick(Sender: TObject);
    procedure tblCadastroAfterEdit(DataSet: TDataSet);
    procedure smnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure smnConteudoClick(Sender: TObject);
  private
    FCodPublicacao: Integer;
  public
    property CodPublicacao: Integer read FCodPublicacao write FCodPublicacao;
  end;

var
  FEdicoes: TFEdicoes;

implementation

uses uConteudoSDI;

{$R *.dfm}

procedure TFEdicoes.tblCadastroAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnConteudo.Enabled := not DataSet.IsEmpty;
end;

procedure TFEdicoes.FormShow(Sender: TObject);
begin
  tblCadastro.Close;
  tblCadastro.ParamByName('CD_PUBLICACAO').AsInteger := FCodPublicacao;
  inherited;
end;

procedure TFEdicoes.btnConteudoClick(Sender: TObject);
begin
  Application.CreateForm(TFConteudo, FConteudo);

  try
    FConteudo.Caption := Caption + ' - ' + tblCadastroNU_EDICAO.AsString;
    FConteudo.CodEdicao := tblCadastroCD_EDICAO.AsInteger;
    FConteudo.ShowModal;
  finally
    FConteudo.Release;
  end;
end;

procedure TFEdicoes.tblCadastroAfterEdit(DataSet: TDataSet);
begin
  inherited;
  tblCadastroCD_PUBLICACAO.AsInteger := FCodPublicacao;
end;

procedure TFEdicoes.smnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFEdicoes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //  if ((Shift = []) and (Key = VK_F12)) or ((Shift = [ssAlt]) and (Key = Ord('C'))) then
  //  begin
  //    Key := 0;
  //    btnConteudoClick(btnConteudo);
  //  end
  //  else
  inherited;
end;

procedure TFEdicoes.smnConteudoClick(Sender: TObject);
begin
  btnConteudoClick(btnConteudo);
end;

end.

