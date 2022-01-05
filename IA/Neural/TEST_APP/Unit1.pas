unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  NeuralNet, NNSignal, StdCtrls;

type
  TForm1 = class(TForm)
    Input1: TNNSignal;
    Input2: TNNSignal;
    Output1: TNNSignal;
    Edit1: TEdit;
    Edit2: TEdit;
    Label11: TLabel;
    Button1: TButton;
    NeuralNet1: TNeuralNet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Output2: TNNSignal;
    Output3: TNNSignal;
    Output4: TNNSignal;
    Output5: TNNSignal;
    Output6: TNNSignal;
    Output7: TNNSignal;
    Output8: TNNSignal;
    Output9: TNNSignal;
    Output10: TNNSignal;
    Label24: TLabel;
    Label23: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var s:string;
begin
Input1.Value:=strtofloat(Edit1.text);
Input2.Value:=strtofloat(Edit2.text);

NeuralNet1.Update;

str(Output1.Value:2:2,s);
Label1.Caption:=s;
str(Output2.Value:2:2,s);
Label2.Caption:=s;
str(Output3.Value:2:2,s);
Label3.Caption:=s;
str(Output4.Value:2:2,s);
Label4.Caption:=s;
str(Output5.Value:2:2,s);
Label5.Caption:=s;
str(Output6.Value:2:2,s);
Label6.Caption:=s;
str(Output7.Value:2:2,s);
Label7.Caption:=s;
str(Output8.Value:2:2,s);
Label8.Caption:=s;
str(Output9.Value:2:2,s);
Label9.Caption:=s;
str(Output10.Value:2:2,s);
Label10.Caption:=s;
end;

end.
