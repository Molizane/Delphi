unit uSomaSub16Bits;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
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
    LblSubByte1_b15: TLabel;
    SubByte1_b15: TCheckBox;
    LblSubByte1_b14: TLabel;
    SubByte1_b14: TCheckBox;
    LblSubByte1_b13: TLabel;
    SubByte1_b13: TCheckBox;
    LblSubByte1_b12: TLabel;
    SubByte1_b12: TCheckBox;
    LblSubByte1_b11: TLabel;
    SubByte1_b11: TCheckBox;
    LblSubByte1_b10: TLabel;
    SubByte1_b10: TCheckBox;
    LblSubByte1_b9: TLabel;
    SubByte1_b9: TCheckBox;
    LblSubByte1_b8: TLabel;
    SubByte1_b8: TCheckBox;
    LblSubByte2_b15: TLabel;
    SubByte2_b15: TCheckBox;
    LblSubByte2_b14: TLabel;
    SubByte2_b14: TCheckBox;
    LblSubByte2_b13: TLabel;
    SubByte2_b13: TCheckBox;
    LblSubByte2_b12: TLabel;
    SubByte2_b12: TCheckBox;
    LblSubByte2_b11: TLabel;
    SubByte2_b11: TCheckBox;
    LblSubByte2_b10: TLabel;
    SubByte2_b10: TCheckBox;
    LblSubByte2_b9: TLabel;
    SubByte2_b9: TCheckBox;
    LblSubByte2_b8: TLabel;
    SubByte2_b8: TCheckBox;
    LblSubByte3_b15: TLabel;
    SubByte3_b15: TCheckBox;
    LblSubByte3_b14: TLabel;
    SubByte3_b14: TCheckBox;
    LblSubByte3_b13: TLabel;
    SubByte3_b13: TCheckBox;
    LblSubByte3_b12: TLabel;
    SubByte3_b12: TCheckBox;
    LblSubByte3_b11: TLabel;
    SubByte3_b11: TCheckBox;
    LblSubByte3_b10: TLabel;
    SubByte3_b10: TCheckBox;
    LblSubByte3_b9: TLabel;
    SubByte3_b9: TCheckBox;
    LblSubByte3_b8: TLabel;
    SubByte3_b8: TCheckBox;
    LblAddByte1_b8: TLabel;
    LblAddByte1_b9: TLabel;
    LblAddByte1_b10: TLabel;
    LblAddByte1_b11: TLabel;
    LblAddByte1_b12: TLabel;
    LblAddByte1_b13: TLabel;
    LblAddByte1_b14: TLabel;
    LblAddByte1_b15: TLabel;
    AddByte1_b8: TCheckBox;
    AddByte1_b9: TCheckBox;
    AddByte1_b10: TCheckBox;
    AddByte1_b11: TCheckBox;
    AddByte1_b12: TCheckBox;
    AddByte1_b13: TCheckBox;
    AddByte1_b14: TCheckBox;
    AddByte1_b15: TCheckBox;
    LblAddByte2_b8: TLabel;
    LblAddByte2_b9: TLabel;
    LblAddByte2_b10: TLabel;
    LblAddByte2_b11: TLabel;
    LblAddByte2_b12: TLabel;
    LblAddByte2_b13: TLabel;
    LblAddByte2_b14: TLabel;
    LblAddByte2_b15: TLabel;
    AddByte2_b8: TCheckBox;
    AddByte2_b9: TCheckBox;
    AddByte2_b10: TCheckBox;
    AddByte2_b11: TCheckBox;
    AddByte2_b12: TCheckBox;
    AddByte2_b13: TCheckBox;
    AddByte2_b14: TCheckBox;
    AddByte2_b15: TCheckBox;
    LblAddByte3_b8: TLabel;
    LblAddByte3_b9: TLabel;
    LblAddByte3_b10: TLabel;
    LblAddByte3_b11: TLabel;
    LblAddByte3_b12: TLabel;
    LblAddByte3_b13: TLabel;
    LblAddByte3_b14: TLabel;
    LblAddByte3_b15: TLabel;
    AddByte3_b8: TCheckBox;
    AddByte3_b9: TCheckBox;
    AddByte3_b10: TCheckBox;
    AddByte3_b11: TCheckBox;
    AddByte3_b12: TCheckBox;
    AddByte3_b13: TCheckBox;
    AddByte3_b14: TCheckBox;
    AddByte3_b15: TCheckBox;
    procedure SubByte1Click(Sender: TObject);
    procedure SubByte2Click(Sender: TObject);
    procedure AddByte1Click(Sender: TObject);
    procedure AddByte2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SubCyClick(Sender: TObject);
    procedure AddCyClick(Sender: TObject);
  private
    SubByte1, SubByte2: SmallInt;
    AddByte1, AddByte2: SmallInt;
    procedure Subtrai16;
    procedure Soma16;
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

  if SubByte1_b8.Checked then
    SubByte1 := SubByte1 or 256;

  if SubByte1_b9.Checked then
    SubByte1 := SubByte1 or 512;

  if SubByte1_b10.Checked then
    SubByte1 := SubByte1 or 1024;

  if SubByte1_b11.Checked then
    SubByte1 := SubByte1 or 2048;

  if SubByte1_b12.Checked then
    SubByte1 := SubByte1 or 4096;

  if SubByte1_b13.Checked then
    SubByte1 := SubByte1 or 8192;

  if SubByte1_b14.Checked then
    SubByte1 := SubByte1 or 16384;

  if SubByte1_b15.Checked then
    SubByte1 := SubByte1 or 32768;

  Subtrai16;
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

  if SubByte2_b8.Checked then
    SubByte2 := SubByte2 or 256;

  if SubByte2_b9.Checked then
    SubByte2 := SubByte2 or 512;

  if SubByte2_b10.Checked then
    SubByte2 := SubByte2 or 1024;

  if SubByte2_b11.Checked then
    SubByte2 := SubByte2 or 2048;

  if SubByte2_b12.Checked then
    SubByte2 := SubByte2 or 4096;

  if SubByte2_b13.Checked then
    SubByte2 := SubByte2 or 8192;

  if SubByte2_b14.Checked then
    SubByte2 := SubByte2 or 16384;

  if SubByte2_b15.Checked then
    SubByte2 := SubByte2 or 32768;

  Subtrai16;
end;

procedure TForm1.Subtrai16;
var
  SubByte3: SmallInt;
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
  SubByte3_b8.Checked := SubByte3 and 256 <> 0;
  SubByte3_b9.Checked := SubByte3 and 512 <> 0;
  SubByte3_b10.Checked := SubByte3 and 1024 <> 0;
  SubByte3_b11.Checked := SubByte3 and 2048 <> 0;
  SubByte3_b12.Checked := SubByte3 and 4096 <> 0;
  SubByte3_b13.Checked := SubByte3 and 8192 <> 0;
  SubByte3_b14.Checked := SubByte3 and 16384 <> 0;
  SubByte3_b15.Checked := SubByte3 and 32768 <> 0;

  SubByte3_Cy.Checked := SubByte3 and $10000 <> 0;

  LblSubNum1b.Caption := RightStr(IntToHex(SubByte1, 4), 8);
  LblSubNum2b.Caption := RightStr(IntToHex(SubByte2, 4), 8);
  LblSubNum3b.Caption := RightStr(IntToHex(SubByte3, 4), 8);

  LblSubNum1d.Caption := IntToStr(SubByte1);
  LblSubNum2d.Caption := IntToStr(SubByte2);
  LblSubNum3d.Caption := IntToStr(SubByte3);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SubByte1 := 0;
  SubByte2 := 0;
  Subtrai16;

  AddByte1 := 0;
  AddByte2 := 0;
  Soma16;
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

  if AddByte1_b8.Checked then
    AddByte1 := AddByte1 or 256;

  if AddByte1_b9.Checked then
    AddByte1 := AddByte1 or 512;

  if AddByte1_b10.Checked then
    AddByte1 := AddByte1 or 1024;

  if AddByte1_b11.Checked then
    AddByte1 := AddByte1 or 2048;

  if AddByte1_b12.Checked then
    AddByte1 := AddByte1 or 4096;

  if AddByte1_b13.Checked then
    AddByte1 := AddByte1 or 8192;

  if AddByte1_b14.Checked then
    AddByte1 := AddByte1 or 16384;

  if AddByte1_b15.Checked then
    AddByte1 := AddByte1 or 32768;

  Soma16;
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

  if AddByte2_b8.Checked then
    AddByte2 := AddByte2 or 256;

  if AddByte2_b9.Checked then
    AddByte2 := AddByte2 or 512;

  if AddByte2_b10.Checked then
    AddByte2 := AddByte2 or 1024;

  if AddByte2_b11.Checked then
    AddByte2 := AddByte2 or 2048;

  if AddByte2_b12.Checked then
    AddByte2 := AddByte2 or 4096;

  if AddByte2_b13.Checked then
    AddByte2 := AddByte2 or 8192;

  if AddByte2_b14.Checked then
    AddByte2 := AddByte2 or 16384;

  if AddByte2_b15.Checked then
    AddByte2 := AddByte2 or 32768;

  Soma16;
end;

procedure TForm1.Soma16;
var
  AddByte3: SmallInt;
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
  AddByte3_b8.Checked := AddByte3 and 256 <> 0;
  AddByte3_b9.Checked := AddByte3 and 512 <> 0;
  AddByte3_b10.Checked := AddByte3 and 1024 <> 0;
  AddByte3_b11.Checked := AddByte3 and 2048 <> 0;
  AddByte3_b12.Checked := AddByte3 and 4096 <> 0;
  AddByte3_b13.Checked := AddByte3 and 8192 <> 0;
  AddByte3_b14.Checked := AddByte3 and 16384 <> 0;
  AddByte3_b15.Checked := AddByte3 and 32768 <> 0;

  AddByte3_Cy.Checked := AddByte3 and $10000 <> 0;

  LblAddNum1b.Caption := RightStr(IntToHex(AddByte1, 4), 8);
  LblAddNum2b.Caption := RightStr(IntToHex(AddByte2, 4), 8);
  LblAddNum3b.Caption := RightStr(IntToHex(AddByte3, 4), 8);

  LblAddNum1d.Caption := IntToStr(AddByte1);
  LblAddNum2d.Caption := IntToStr(AddByte2);
  LblAddNum3d.Caption := IntToStr(AddByte3);
end;

procedure TForm1.SubCyClick(Sender: TObject);
begin
  Subtrai16;
end;

procedure TForm1.AddCyClick(Sender: TObject);
begin
  Soma16;
end;

end.
