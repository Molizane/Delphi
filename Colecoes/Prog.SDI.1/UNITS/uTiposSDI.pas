unit uTiposSDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModeloSDIPDA, IBCustomDataSet, IBUpdateSQL, DB, IBQuery, StdCtrls,
  Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, uFModeloSDI,
  Menus, DBPanel;

type
  TFTipos = class(TFrmModeloSDIPDA)
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

