unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    chkA: TCheckBox;
    chkB: TCheckBox;
    chkCi: TCheckBox;
    pnlOpers: TPanel;
    chk1: TCheckBox;
    chk2: TCheckBox;
    chk3: TCheckBox;
    chk4: TCheckBox;
    chk5: TCheckBox;
    chk6: TCheckBox;
    chk7: TCheckBox;
    chk8: TCheckBox;
    chk9: TCheckBox;
    chk10: TCheckBox;
    chk11: TCheckBox;
    chk12: TCheckBox;
    chk13: TCheckBox;
    chk14: TCheckBox;
    chk15: TCheckBox;
    pnlResults: TPanel;
    chkS: TCheckBox;
    chkCo: TCheckBox;
    procedure chkAClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure Processa;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.chkAClick(Sender: TObject);
begin
  Processa;
end;

procedure TForm1.Processa;
begin
  chk1.Checked := chkA.Checked and not chkB.Checked;
  chk2.Checked := not chkA.Checked and chkB.Checked;
  chk3.Checked := chk1.Checked or chk2.Checked;
  chk4.Checked := not chkCi.Checked and chk3.Checked;
  chk5.Checked := not chkA.Checked and not chkB.Checked;
  chk6.Checked := chkA.Checked and chkB.Checked;
  chk7.Checked := chk5.Checked or chk6.Checked;
  chk8.Checked := chkCi.Checked and chk7.Checked;
  chk9.Checked := chk4.Checked or chk8.Checked;
  chkS.Checked := chk9.Checked;

  chk10.Checked := chkA.Checked and chkB.Checked;
  chk11.Checked := chkA.Checked and not chkB.Checked;
  chk12.Checked := not chkA.Checked and chkB.Checked;
  chk13.Checked := chk11.Checked or chk12.Checked;
  chk14.Checked := chkCi.Checked and chk13.Checked;
  chk15.Checked := chk10.Checked or chk14.Checked;
  chkCo.Checked := chk15.Checked;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Processa;
end;

end.

