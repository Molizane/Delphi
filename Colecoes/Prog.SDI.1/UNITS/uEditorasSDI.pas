unit uEditorasSDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModeloSDIPDA, Grids, DBGrids, DB, IBCustomDataSet, IBUpdateSQL,
  IBQuery, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, ComCtrls, Menus, DBPanel;

type
  TFEditoras = class(TFrmModeloSDIPDA)
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

