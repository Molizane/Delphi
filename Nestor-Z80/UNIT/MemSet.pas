unit MemSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls;

type
  TMemForm = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    R: TSpinEdit;
    C: TSpinEdit;
    procedure Button2Click(Sender: TObject);
  private
  public
  end;

var
  MemForm: TMemForm;

implementation

uses
  NestorMain, NestorMemoria, NestorRegistros;

{$R *.dfm}

procedure TMemForm.Button2Click(Sender: TObject);
begin
  FrmMemoria.MGrid.ColCount := C.Value * 2;
  FrmMemoria.MGrid.RowCount := R.Value + 1;
  FrmMain.Memory.Show(FrmRegistros.Hex.Checked);
end;

end.
