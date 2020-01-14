unit uFModeloMDIPDA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloMDI, IBCustomDataSet, IBUpdateSQL, IBQuery, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel,
  kbmMemTable;

type
  TFrmModeloPDA = class(TFrmModelo)
    lblResumida: TLabel;
    edtResumida: TDBEdit;
  private
  public
  end;

var
  FrmModeloPDA: TFrmModeloPDA;

implementation

{$R *.dfm}

end.

