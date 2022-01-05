unit UNomeConfiguracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmNomeConfiguracao = class(TForm)
    BitBtn1: TSpeedButton;
    BitBtn2: TSpeedButton;
    DBEdit1: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
  public
  end;

var
  FrmNomeConfiguracao: TFrmNomeConfiguracao;

implementation

uses
  UConfiguracoes;

{$R *.dfm}

procedure TFrmNomeConfiguracao.BitBtn1Click(Sender: TObject);
begin
  if Trim(DBEdit1.Text) = '' then
    MessageDlg('Descrição não informada', mtError, [mbOK], 0)
  else if MessageDlg('Confirma o nome', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    ModalResult := mrOk;
end;

procedure TFrmNomeConfiguracao.BitBtn2Click(Sender: TObject);
begin
  if MessageDlg('Confirma o cancelamento', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    ModalResult := mrCancel;
end;

end.
