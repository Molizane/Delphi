unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFPrincipal = class(TForm)
    btnTipos: TBitBtn;
    btnPessoas: TBitBtn;
    procedure btnTiposClick(Sender: TObject);
    procedure btnPessoasClick(Sender: TObject);
  private
  public
  end;

var
  FPrincipal: TFPrincipal;

implementation

uses
  uCadPessoas, uCadTipos;

{$R *.dfm}

procedure TFPrincipal.btnTiposClick(Sender: TObject);
begin
  Application.CreateForm(TFCadTipos, FCadTipos);

  try
    FCadTipos.ShowModal;
  finally
    FCadTipos.Release;
  end;
end;

procedure TFPrincipal.btnPessoasClick(Sender: TObject);
begin
  Application.CreateForm(TFCadPessoas, FCadPessoas);

  try
    FCadPessoas.ShowModal;
  finally
    FCadPessoas.Release;
  end;
end;

end.

