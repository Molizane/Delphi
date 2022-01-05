unit uCardsTitle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFTitulo = class(TForm)
    edtTitulo: TEdit;
    lblTitulo: TLabel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    procedure edtTituloChange(Sender: TObject);
  private
  public
  end;

var
  FTitulo: TFTitulo;

implementation

{$R *.dfm}

procedure TFTitulo.edtTituloChange(Sender: TObject);
begin
  lblTitulo.Caption := IntToStr(edtTitulo.MaxLength - Length(edtTitulo.Text));
  btnOk.Enabled := Length(edtTitulo.Text) > 0;
end;

end.

