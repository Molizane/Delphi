unit UConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, Buttons, DB;

type
  TFrmConfiguracoes = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    DSConfigs: TDataSource;
    BitBtn1: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
  private
  public
  end;

var
  FrmConfiguracoes: TFrmConfiguracoes;

implementation

uses
  UConfigCompile;

{$R *.dfm}

procedure TFrmConfiguracoes.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
