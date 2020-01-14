unit uCategoriasMDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloMDIPDA, IBCustomDataSet, IBUpdateSQL, IBQuery, StdCtrls, Mask,
  DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus, DBPanel,
  kbmMemTable;

type
  TFCategorias = class(TFrmModeloPDA)
    tblCadastroCD_CATEGORIA: TIntegerField;
    tblCadastroNO_CATEGORIA: TIBStringField;
    tblCadastroNR_CATEGORIA: TIBStringField;
    tblCadastroDT_CRIACAO: TDateTimeField;
    tblCadastroDT_ALTERACAO: TDateTimeField;
    tblCadastroIN_PDA: TIBStringField;
    tblCadastroID: TIntegerField;
    tblCadastroIN_DIRTY: TIBStringField;
    tblCadastroIN_DELETED: TIBStringField;
  private
  public
  end;

var
  FCategorias: TFCategorias;

implementation

{$R *.dfm}

end.

