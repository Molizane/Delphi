unit uFModeloSDIPDA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModeloSDI, IBCustomDataSet, IBUpdateSQL, DB, IBQuery, StdCtrls,
  Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus,
  DBPanel;

type
  TFrmModeloSDIPDA = class(TFrmModeloSDI)
    lblResumida: TLabel;
    edtResumida: TDBEdit;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FrmModeloSDIPDA: TFrmModeloSDIPDA;

implementation

uses
  uDefs;

{$R *.dfm}

procedure TFrmModeloSDIPDA.FormCreate(Sender: TObject);
begin
  inherited;
  SetMenuItemRight(smnFechar);
end;

end.

