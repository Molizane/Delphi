unit uSomaSub8Bits;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    LblSubByte1_b0: TLabel;
    LblSubByte1_b1: TLabel;
    LblSubByte1_b2: TLabel;
    LblSubByte1_b3: TLabel;
    LblSubByte1_b4: TLabel;
    LblSubByte1_b5: TLabel;
    LblSubByte1_b6: TLabel;
    LblSubByte1_b7: TLabel;
    LblSubCy: TLabel;
    LblSubByte2_b0: TLabel;
    LblSubByte2_b1: TLabel;
    LblSubByte2_b2: TLabel;
    LblSubByte2_b3: TLabel;
    LblSubByte2_b4: TLabel;
    LblSubByte2_b5: TLabel;
    LblSubByte2_b6: TLabel;
    LblSubByte2_b7: TLabel;
    LblSubByte3_b0: TLabel;
    LblSubByte3_b1: TLabel;
    LblSubByte3_b2: TLabel;
    LblSubByte3_b3: TLabel;
    LblSubByte3_b4: TLabel;
    LblSubByte3_b5: TLabel;
    LblSubByte3_b6: TLabel;
    LblSubByte3_b7: TLabel;
    LblSubByte3_Cy: TLabel;
    LblSubMenos: TLabel;
    LblSubIgual: TLabel;
    LblSubNum1b: TLabel;
    LblSubNum2b: TLabel;
    LblSubNum3b: TLabel;
    LblSubNum1d: TLabel;
    LblSubNum2d: TLabel;
    LblSubNum3d: TLabel;
    SubByte1_b0: TCheckBox;
    SubByte1_b1: TCheckBox;
    SubByte1_b2: TCheckBox;
    SubByte1_b3: TCheckBox;
    SubByte1_b4: TCheckBox;
    SubByte1_b5: TCheckBox;
    SubByte1_b6: TCheckBox;
    SubByte1_b7: TCheckBox;
    SubCy: TCheckBox;
    SubByte2_b0: TCheckBox;
    SubByte2_b1: TCheckBox;
    SubByte2_b2: TCheckBox;
    SubByte2_b3: TCheckBox;
    SubByte2_b4: TCheckBox;
    SubByte2_b5: TCheckBox;
    SubByte2_b6: TCheckBox;
    SubByte2_b7: TCheckBox;
    SubByte3_b0: TCheckBox;
    SubByte3_b1: TCheckBox;
    SubByte3_b2: TCheckBox;
    SubByte3_b3: TCheckBox;
    SubByte3_b4: TCheckBox;
    SubByte3_b5: TCheckBox;
    SubByte3_b6: TCheckBox;
    SubByte3_b7: TCheckBox;
    SubByte3_Cy: TCheckBox;
    LblAddByte1_b0: TLabel;
    LblAddByte1_b1: TLabel;
    LblAddByte1_b2: TLabel;
    LblAddByte1_b3: TLabel;
    LblAddByte1_b4: TLabel;
    LblAddByte1_b5: TLabel;
    LblAddByte1_b6: TLabel;
    LblAddByte1_b7: TLabel;
    LblAddCy: TLabel;
    LblAddByte2_b0: TLabel;
    LblAddByte2_b1: TLabel;
    LblAddByte2_b2: TLabel;
    LblAddByte2_b3: TLabel;
    LblAddByte2_b4: TLabel;
    LblAddByte2_b5: TLabel;
    LblAddByte2_b6: TLabel;
    LblAddByte2_b7: TLabel;
    LblAddByte3_b0: TLabel;
    LblAddByte3_b1: TLabel;
    LblAddByte3_b2: TLabel;
    LblAddByte3_b3: TLabel;
    LblAddByte3_b4: TLabel;
    LblAddByte3_b5: TLabel;
    LblAddByte3_b6: TLabel;
    LblAddByte3_b7: TLabel;
    LblAddByte3_Cy: TLabel;
    LblAddMais: TLabel;
    LblAddIgual: TLabel;
    LblAddNum1b: TLabel;
    LblAddNum2b: TLabel;
    LblAddNum3b: TLabel;
    LblAddNum1d: TLabel;
    LblAddNum2d: TLabel;
    LblAddNum3d: TLabel;
    AddByte1_b0: TCheckBox;
    AddByte1_b1: TCheckBox;
    AddByte1_b2: TCheckBox;
    AddByte1_b3: TCheckBox;
    AddByte1_b4: TCheckBox;
    AddByte1_b5: TCheckBox;
    AddByte1_b6: TCheckBox;
    AddByte1_b7: TCheckBox;
    AddCy: TCheckBox;
    AddByte2_b0: TCheckBox;
    AddByte2_b1: TCheckBox;
    AddByte2_b2: TCheckBox;
    AddByte2_b3: TCheckBox;
    AddByte2_b4: TCheckBox;
    AddByte2_b5: TCheckBox;
    AddByte2_b6: TCheckBox;
    AddByte2_b7: TCheckBox;
    AddByte3_b0: TCheckBox;
    AddByte3_b1: TCheckBox;
    AddByte3_b2: TCheckBox;
    AddByte3_b3: TCheckBox;
    AddByte3_b4: TCheckBox;
    AddByte3_b5: TCheckBox;
    AddByte3_b6: TCheckBox;
    AddByte3_b7: TCheckBox;
    AddByte3_Cy: TCheckBox;
    procedure SubByte1Click(Sender: TObject);
    procedure SubByte2Click(Sender: TObject);
    procedure AddByte1Click(Sender: TObject);
    procedure AddByte2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SubCyClick(Sender: TObject);
    procedure AddCyClick(Sender: TObject);
  private
    SubByte1, SubByte2: ShortInt;
    AddByte1, AddByte2: ShortInt;
    procedure Subtrai8;
    procedure Soma8;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  StrUtils;

procedure TForm1.SubByte1Click(Sender: TObject);
begin
  if SubByte1_b0.Checked then
    SubByte1 := 1
  else
    SubByte1 := 0;

  if SubByte1_b1.Checked then
    SubByte1 := SubByte1 or 2;

  if SubByte1_b2.Checked then
    SubByte1 := SubByte1 or 4;

  if SubByte1_b3.Checked then
    SubByte1 := SubByte1 or 8;

  if SubByte1_b4.Checked then
    SubByte1 := SubByte1 or 16;

  if SubByte1_b5.Checked then
    SubByte1 := SubByte1 or 32;

  if SubByte1_b6.Checked then
    SubByte1 := SubByte1 or 64;

  if SubByte1_b7.Checked then
    SubByte1 := SubByte1 or 128;

  Subtrai8;
end;

procedure TForm1.SubByte2Click(Sender: TObject);
begin
  if SubByte2_b0.Checked then
    SubByte2 := 1
  else
    SubByte2 := 0;

  if SubByte2_b1.Checked then
    SubByte2 := SubByte2 or 2;

  if SubByte2_b2.Checked then
    SubByte2 := SubByte2 or 4;

  if SubByte2_b3.Checked then
    SubByte2 := SubByte2 or 8;

  if SubByte2_b4.Checked then
    SubByte2 := SubByte2 or 16;

  if SubByte2_b5.Checked then
    SubByte2 := SubByte2 or 32;

  if SubByte2_b6.Checked then
    SubByte2 := SubByte2 or 64;

  if SubByte2_b7.Checked then
    SubByte2 := SubByte2 or 128;

  Subtrai8;
end;

procedure TForm1.Subtrai8;
var
  SubByte3: ShortInt;
begin
  SubByte3 := SubByte1 - SubByte2;

  if SubCy.Checked then
    Dec(SubByte3);

  SubByte3_b0.Checked := SubByte3 and 1 <> 0;
  SubByte3_b1.Checked := SubByte3 and 2 <> 0;
  SubByte3_b2.Checked := SubByte3 and 4 <> 0;
  SubByte3_b3.Checked := SubByte3 and 8 <> 0;
  SubByte3_b4.Checked := SubByte3 and 16 <> 0;
  SubByte3_b5.Checked := SubByte3 and 32 <> 0;
  SubByte3_b6.Checked := SubByte3 and 64 <> 0;
  SubByte3_b7.Checked := SubByte3 and 128 <> 0;
  SubByte3_Cy.Checked := SubByte3 and $100 <> 0;

  LblSubNum1b.Caption := RightStr(IntToHex(SubByte1, 2), 4);
  LblSubNum2b.Caption := RightStr(IntToHex(SubByte2, 2), 4);
  LblSubNum3b.Caption := RightStr(IntToHex(SubByte3, 2), 4);

  LblSubNum1d.Caption := IntToStr(SubByte1);
  LblSubNum2d.Caption := IntToStr(SubByte2);
  LblSubNum3d.Caption := IntToStr(SubByte3);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SubByte1 := 0;
  SubByte2 := 0;
  Subtrai8;

  AddByte1 := 0;
  AddByte2 := 0;
  Soma8;
end;

procedure TForm1.AddByte1Click(Sender: TObject);
begin
  if AddByte1_b0.Checked then
    AddByte1 := 1
  else
    AddByte1 := 0;

  if AddByte1_b1.Checked then
    AddByte1 := AddByte1 or 2;
  if AddByte1_b2.Checked then
    AddByte1 := AddByte1 or 4;
  if AddByte1_b3.Checked then
    AddByte1 := AddByte1 or 8;
  if AddByte1_b4.Checked then
    AddByte1 := AddByte1 or 16;
  if AddByte1_b5.Checked then
    AddByte1 := AddByte1 or 32;
  if AddByte1_b6.Checked then
    AddByte1 := AddByte1 or 64;
  if AddByte1_b7.Checked then
    AddByte1 := AddByte1 or 128;

  Soma8;
end;

procedure TForm1.AddByte2Click(Sender: TObject);
begin
  if AddByte2_b0.Checked then
    AddByte2 := 1
  else
    AddByte2 := 0;

  if AddByte2_b1.Checked then
    AddByte2 := AddByte2 or 2;
  if AddByte2_b2.Checked then
    AddByte2 := AddByte2 or 4;
  if AddByte2_b3.Checked then
    AddByte2 := AddByte2 or 8;
  if AddByte2_b4.Checked then
    AddByte2 := AddByte2 or 16;
  if AddByte2_b5.Checked then
    AddByte2 := AddByte2 or 32;
  if AddByte2_b6.Checked then
    AddByte2 := AddByte2 or 64;
  if AddByte2_b7.Checked then
    AddByte2 := AddByte2 or 128;

  Soma8;
end;

procedure TForm1.Soma8;
var
  AddByte3: Integer;
begin
  AddByte3 := AddByte1 + AddByte2;

  if AddCy.Checked then
    Inc(AddByte3);

  AddByte3_b0.Checked := AddByte3 and 1 <> 0;
  AddByte3_b1.Checked := AddByte3 and 2 <> 0;
  AddByte3_b2.Checked := AddByte3 and 4 <> 0;
  AddByte3_b3.Checked := AddByte3 and 8 <> 0;
  AddByte3_b4.Checked := AddByte3 and 16 <> 0;
  AddByte3_b5.Checked := AddByte3 and 32 <> 0;
  AddByte3_b6.Checked := AddByte3 and 64 <> 0;
  AddByte3_b7.Checked := AddByte3 and 128 <> 0;
  AddByte3_Cy.Checked := AddByte3 and $100 <> 0;

  LblAddNum1b.Caption := RightStr(IntToHex(AddByte1, 2), 4);
  LblAddNum2b.Caption := RightStr(IntToHex(AddByte2, 2), 4);
  LblAddNum3b.Caption := RightStr(IntToHex(AddByte3, 2), 4);

  LblAddNum1d.Caption := IntToStr(AddByte1);
  LblAddNum2d.Caption := IntToStr(AddByte2);
  LblAddNum3d.Caption := IntToStr(AddByte3);
end;

procedure TForm1.SubCyClick(Sender: TObject);
begin
  Subtrai8;
end;

procedure TForm1.AddCyClick(Sender: TObject);
begin
  Soma8;
end;

end.

