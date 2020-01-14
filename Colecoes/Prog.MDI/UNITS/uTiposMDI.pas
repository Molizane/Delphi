unit uTiposMDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloMDIPDA, IBCustomDataSet, IBUpdateSQL, IBQuery, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel,
  kbmMemTable;

type
  TFTipos = class(TFrmModeloPDA)
    tblCadastroCD_TIPO: TIntegerField;
    tblCadastroNO_TIPO: TIBStringField;
    tblCadastroNR_TIPO: TIBStringField;
    tblCadastroDT_INCLUSAO: TDateTimeField;
    tblCadastroDT_ALTERACAO: TDateTimeField;
    tblCadastroIN_PDA: TIBStringField;
    tblCadastroID: TIntegerField;
    tblCadastroIN_DIRTY: TIBStringField;
    tblCadastroIN_DELETED: TIBStringField;
  private
  public
  end;

var
  FTipos: TFTipos;

implementation

{$R *.dfm}

end.

