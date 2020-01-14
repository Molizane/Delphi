unit uEditorasMDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB,
  Dialogs, uFModeloMDIPDA, Grids, DBGrids, IBCustomDataSet, IBUpdateSQL, IBQuery,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls, Menus, DBPanel,
  kbmMemTable;

type
  TFEditoras = class(TFrmModeloPDA)
    tblCadastroCD_EDITORA: TIntegerField;
    tblCadastroNO_EDITORA: TIBStringField;
    tblCadastroNR_EDITORA: TIBStringField;
    tblCadastroDT_CRIACAO: TDateTimeField;
    tblCadastroDT_ALTERACAO: TDateTimeField;
    tblCadastroID: TIntegerField;
    tblCadastroIN_DIRTY: TIBStringField;
    tblCadastroIN_DELETED: TIBStringField;
    tblCadastroIN_PDA: TIBStringField;
  private
  public
  end;

var
  FEditoras: TFEditoras;

implementation

{$R *.dfm}

end.

