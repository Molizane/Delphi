unit uFModeloPDA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModelo, IBCustomDataSet, IBUpdateSQL, DB, IBQuery, StdCtrls,
  Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, DBPanel;

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

