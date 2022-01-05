unit frmChooseTarget;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, NetObj;

type
  TChooseTargetForm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    TargetBox: TComboBox;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChooseTargetForm: TChooseTargetForm;

function ChooseTarget(const Targets:TTargets):integer;

implementation

{$R *.DFM}

function ChooseTarget(const Targets:TTargets):integer;
var I:integer;
begin
With ChooseTargetForm do
 begin
 TargetBox.Items.Clear;
 for I:=1 to Targets.Count do TargetBox.Items.Add(Targets.Table[I].Name);
 if ShowModal=mrOK then Result:=TargetBox.ItemIndex+1
                   else Result:=-1;
 end;
end;
end.
