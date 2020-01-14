unit uCategoriasSDI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModeloSDIPDA, DB, IBCustomDataSet, IBUpdateSQL, IBQuery, Menus,
  StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, DBPanel;

type
  TFCategorias = class(TFrmModeloSDIPDA)
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

