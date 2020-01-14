unit HelpUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw;

type
  THelpForm = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  HelpForm: THelpForm;

implementation

{$R *.dfm}

procedure THelpForm.FormCreate(Sender: TObject);
begin
  WebBrowser1.Navigate('help/index.html');
end;

end.

