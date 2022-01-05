unit uMsgEmbaralhando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TFrmMsgEmbaralhando = class(TForm)
    pnlEmbaralhando: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
  public
    Fecha: Boolean;
  end;

var
  FrmMsgEmbaralhando: TFrmMsgEmbaralhando;

implementation

{$R *.dfm}

procedure TFrmMsgEmbaralhando.FormCreate(Sender: TObject);
begin
  Fecha := False;
end;

procedure TFrmMsgEmbaralhando.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := Fecha;
end;

end.

