unit uFModeloSDIPDA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloSDI, IBCustomDataSet, IBUpdateSQL, IBQuery, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel,
  kbmMemTable;

type
  TFrmModeloPDA = class(TFrmModelo)
    lblResumida: TLabel;
    edtResumida: TDBEdit;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FrmModeloPDA: TFrmModeloPDA;

implementation

{$R *.dfm}

uses
  uDefs;

procedure TFrmModeloPDA.FormCreate(Sender: TObject);
begin
  inherited;
  SetMenuItemRight(smnFechar);
end;

end.

