unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, NeuralNet, NNSignal;

type
  TForm1 = class(TForm)
    inBit0: TNNSignal;
    inBit1: TNNSignal;
    NeuralNet1: TNeuralNet;
    outBit0: TNNSignal;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    CheckBoxBit0: TCheckBox;
    CheckBoxBit1: TCheckBox;
    CheckBox1: TCheckBox;
    outBit1: TNNSignal;
    outBit2: TNNSignal;
    outBit3: TNNSignal;
    outBit4: TNNSignal;
    outBit5: TNNSignal;
    outBit6: TNNSignal;
    outBit7: TNNSignal;
    outBit8: TNNSignal;
    outBit9: TNNSignal;
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
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
{
  inBit0.Value := 0;
  inBit1.Value := 0;
  outBit.Value := 0;
  NeuralNet1.Learn;
  inBit0.Value := 0;
  inBit1.Value := 1;
  outBit.Value := 1;
  NeuralNet1.Learn;
  inBit0.Value := 1;
  inBit1.Value := 0;
  outBit.Value := 1;
  NeuralNet1.Learn;
  inBit0.Value := 1;
  inBit1.Value := 1;
  outBit.Value := 1;
  NeuralNet1.Learn;
}  
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  if CheckBoxBit0.Checked then inBit0.Value := 1
  else inBit0.Value := 0;
  if CheckBoxBit1.Checked then inBit1.Value := 1
  else inBit1.Value := 0;
  NeuralNet1.Update;
  CheckBox1.Checked := outBit0.Value > 0.4999;
  CheckBox2.Checked := outBit1.Value > 0.4999;
  CheckBox3.Checked := outBit2.Value > 0.4999;
  CheckBox4.Checked := outBit3.Value > 0.4999;
  CheckBox5.Checked := outBit4.Value > 0.4999;
  CheckBox6.Checked := outBit5.Value > 0.4999;
  CheckBox7.Checked := outBit6.Value > 0.4999;
  CheckBox8.Checked := outBit7.Value > 0.4999;
  CheckBox9.Checked := outBit8.Value > 0.4999;
  CheckBox10.Checked := outBit9.Value > 0.4999;
  Label1.Caption := FormatFloat('0.000000', outBit0.Value);
  Label2.Caption := FormatFloat('0.000000', outBit1.Value);
  Label3.Caption := FormatFloat('0.000000', outBit2.Value);
  Label4.Caption := FormatFloat('0.000000', outBit3.Value);
  Label5.Caption := FormatFloat('0.000000', outBit4.Value);
  Label6.Caption := FormatFloat('0.000000', outBit5.Value);
  Label7.Caption := FormatFloat('0.000000', outBit6.Value);
  Label8.Caption := FormatFloat('0.000000', outBit7.Value);
  Label9.Caption := FormatFloat('0.000000', outBit8.Value);
  Label10.Caption := FormatFloat('0.000000', outBit9.Value);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //NeuralNet1.LoadFromFile('bin.net');
  //NeuralNet1.Active := True;
end;

end.
