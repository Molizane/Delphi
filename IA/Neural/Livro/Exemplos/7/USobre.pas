unit USobre;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Buttons,
  ExtCtrls, jpeg;

type
  TFrmSobre = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
  private
  public
  end;

var
  FrmSobre: TFrmSobre;

implementation

{$R *.dfm}

end.

