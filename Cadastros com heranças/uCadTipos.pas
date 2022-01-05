unit uCadTipos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFModelo, DB, IBCustomDataSet, IBTable, DBCtrls, ExtCtrls, Grids,
  DBGrids, ComCtrls, StdCtrls, Buttons, Mask, IBQuery, IBUpdateSQL;

type
  TFCadTipos = class(TFrmModelo)
    tblCadastroID_TIPO: TIntegerField;
    tblCadastroNO_TIPO: TIBStringField;
    tblCadastroDT_CRIACAO: TDateTimeField;
    tblCadastroDT_ALTERACAO: TDateTimeField;
  private
  public
  end;

var
  FCadTipos: TFCadTipos;

implementation

uses
  uDMprincipal;

{$R *.dfm}

end.

