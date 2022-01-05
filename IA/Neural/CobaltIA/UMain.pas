unit UMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus;

type
  TmdiMain = class(TForm)
    MainMenu1: TMainMenu;
    GA1: TMenuItem;
    menu1: TMenuItem;
    FZ1: TMenuItem;
    NN1: TMenuItem;
    procedure GA1Click(Sender: TObject);
    procedure FZ1Click(Sender: TObject);
    procedure NN1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mdiMain: TmdiMain;

implementation

uses UGA, UFZ, UNN;

{$R *.DFM}

procedure TmdiMain.GA1Click(Sender: TObject);
begin
        Application.CreateForm(TfrmGA,frmGA);
        frmGA.Show;
end;

procedure TmdiMain.FZ1Click(Sender: TObject);
begin
        Application.CreateForm(TfrmFZ,frmFZ);
        frmFZ.Show;
end;

procedure TmdiMain.NN1Click(Sender: TObject);
begin
        Application.CreateForm(TfrmNN,frmNN);
        frmNN.show
end;

end.
