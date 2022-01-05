object Form1: TForm1
  Left = 544
  Top = 146
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Subtra'#231#227'o / Soma 8 bits'
  ClientHeight = 186
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LblSubByte1_b0: TLabel
    Left = 195
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b0'
  end
  object LblSubByte1_b1: TLabel
    Tag = 1
    Left = 173
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b1'
  end
  object LblSubByte1_b2: TLabel
    Tag = 2
    Left = 152
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b2'
  end
  object LblSubByte1_b3: TLabel
    Tag = 3
    Left = 132
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b3'
  end
  object LblSubByte1_b4: TLabel
    Tag = 4
    Left = 111
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b4'
  end
  object LblSubByte1_b5: TLabel
    Tag = 5
    Left = 90
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b5'
  end
  object LblSubByte1_b6: TLabel
    Tag = 6
    Left = 70
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b6'
  end
  object LblSubByte1_b7: TLabel
    Tag = 7
    Left = 49
    Top = 13
    Width = 13
    Height = 13
    Caption = 'Sg'
  end
  object LblSubCy: TLabel
    Tag = 8
    Left = 29
    Top = 13
    Width = 12
    Height = 13
    Caption = 'Cy'
  end
  object LblSubByte2_b0: TLabel
    Left = 371
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b0'
  end
  object LblSubByte2_b1: TLabel
    Tag = 1
    Left = 350
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b1'
  end
  object LblSubByte2_b2: TLabel
    Tag = 2
    Left = 329
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b2'
  end
  object LblSubByte2_b3: TLabel
    Tag = 3
    Left = 309
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b3'
  end
  object LblSubByte2_b4: TLabel
    Tag = 4
    Left = 288
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b4'
  end
  object LblSubByte2_b5: TLabel
    Tag = 5
    Left = 267
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b5'
  end
  object LblSubByte2_b6: TLabel
    Tag = 6
    Left = 247
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b6'
  end
  object LblSubByte2_b7: TLabel
    Tag = 7
    Left = 226
    Top = 13
    Width = 13
    Height = 13
    Caption = 'Sg'
  end
  object LblSubByte3_b0: TLabel
    Left = 566
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b0'
  end
  object LblSubByte3_b1: TLabel
    Tag = 1
    Left = 545
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b1'
  end
  object LblSubByte3_b2: TLabel
    Tag = 2
    Left = 524
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b2'
  end
  object LblSubByte3_b3: TLabel
    Tag = 3
    Left = 504
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b3'
  end
  object LblSubByte3_b4: TLabel
    Tag = 4
    Left = 483
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b4'
  end
  object LblSubByte3_b5: TLabel
    Tag = 5
    Left = 462
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b5'
  end
  object LblSubByte3_b6: TLabel
    Tag = 6
    Left = 442
    Top = 13
    Width = 12
    Height = 13
    Caption = 'b6'
  end
  object LblSubByte3_b7: TLabel
    Tag = 7
    Left = 421
    Top = 13
    Width = 13
    Height = 13
    Caption = 'Sg'
  end
  object LblSubByte3_Cy: TLabel
    Tag = 8
    Left = 401
    Top = 13
    Width = 12
    Height = 13
    Caption = 'Cy'
  end
  object LblSubMenos: TLabel
    Left = 214
    Top = 29
    Width = 3
    Height = 13
    Caption = '-'
  end
  object LblSubIgual: TLabel
    Left = 390
    Top = 29
    Width = 6
    Height = 13
    Caption = '='
  end
  object LblSubNum1b: TLabel
    Left = 158
    Top = 47
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum1b'
  end
  object LblSubNum2b: TLabel
    Left = 334
    Top = 47
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum2b'
  end
  object LblSubNum3b: TLabel
    Left = 526
    Top = 47
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum3b'
  end
  object LblSubNum1d: TLabel
    Left = 158
    Top = 63
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum1d'
  end
  object LblSubNum2d: TLabel
    Left = 334
    Top = 63
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum2d'
  end
  object LblSubNum3d: TLabel
    Left = 526
    Top = 63
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum3d'
  end
  object LblAddByte1_b0: TLabel
    Left = 195
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b0'
  end
  object LblAddByte1_b1: TLabel
    Tag = 1
    Left = 174
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b1'
  end
  object LblAddByte1_b2: TLabel
    Tag = 2
    Left = 153
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b2'
  end
  object LblAddByte1_b3: TLabel
    Tag = 3
    Left = 132
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b3'
  end
  object LblAddByte1_b4: TLabel
    Tag = 4
    Left = 112
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b4'
  end
  object LblAddByte1_b5: TLabel
    Tag = 5
    Left = 91
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b5'
  end
  object LblAddByte1_b6: TLabel
    Tag = 6
    Left = 70
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b6'
  end
  object LblAddByte1_b7: TLabel
    Tag = 7
    Left = 49
    Top = 109
    Width = 13
    Height = 13
    Caption = 'Sg'
  end
  object LblAddCy: TLabel
    Tag = 8
    Left = 29
    Top = 109
    Width = 12
    Height = 13
    Caption = 'Cy'
  end
  object LblAddByte2_b0: TLabel
    Left = 370
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b0'
  end
  object LblAddByte2_b1: TLabel
    Tag = 1
    Left = 349
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b1'
  end
  object LblAddByte2_b2: TLabel
    Tag = 2
    Left = 328
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b2'
  end
  object LblAddByte2_b3: TLabel
    Tag = 3
    Left = 308
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b3'
  end
  object LblAddByte2_b4: TLabel
    Tag = 4
    Left = 287
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b4'
  end
  object LblAddByte2_b5: TLabel
    Tag = 5
    Left = 266
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b5'
  end
  object LblAddByte2_b6: TLabel
    Tag = 6
    Left = 246
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b6'
  end
  object LblAddByte2_b7: TLabel
    Tag = 7
    Left = 225
    Top = 109
    Width = 13
    Height = 13
    Caption = 'Sg'
  end
  object LblAddByte3_b0: TLabel
    Left = 565
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b0'
  end
  object LblAddByte3_b1: TLabel
    Tag = 1
    Left = 544
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b1'
  end
  object LblAddByte3_b2: TLabel
    Tag = 2
    Left = 523
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b2'
  end
  object LblAddByte3_b3: TLabel
    Tag = 3
    Left = 503
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b3'
  end
  object LblAddByte3_b4: TLabel
    Tag = 4
    Left = 482
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b4'
  end
  object LblAddByte3_b5: TLabel
    Tag = 5
    Left = 461
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b5'
  end
  object LblAddByte3_b6: TLabel
    Tag = 6
    Left = 441
    Top = 109
    Width = 12
    Height = 13
    Caption = 'b6'
  end
  object LblAddByte3_b7: TLabel
    Tag = 7
    Left = 420
    Top = 109
    Width = 13
    Height = 13
    Caption = 'Sg'
  end
  object LblAddByte3_Cy: TLabel
    Tag = 8
    Left = 400
    Top = 109
    Width = 12
    Height = 13
    Caption = 'Cy'
  end
  object LblAddMais: TLabel
    Left = 213
    Top = 125
    Width = 6
    Height = 13
    Caption = '+'
  end
  object LblAddIgual: TLabel
    Left = 389
    Top = 125
    Width = 6
    Height = 13
    Caption = '='
  end
  object LblAddNum1b: TLabel
    Left = 157
    Top = 143
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum1b'
  end
  object LblAddNum2b: TLabel
    Left = 333
    Top = 143
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum2b'
  end
  object LblAddNum3b: TLabel
    Left = 525
    Top = 143
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum3b'
  end
  object LblAddNum1d: TLabel
    Left = 157
    Top = 159
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum1d'
  end
  object LblAddNum2d: TLabel
    Left = 333
    Top = 159
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum2d'
  end
  object LblAddNum3d: TLabel
    Left = 525
    Top = 159
    Width = 48
    Height = 13
    Alignment = taRightJustify
    Caption = 'LblNum3d'
  end
  object SubByte1_b0: TCheckBox
    Left = 195
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b0'
    TabOrder = 0
    OnClick = SubByte1Click
  end
  object SubByte1_b1: TCheckBox
    Tag = 1
    Left = 173
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b1'
    TabOrder = 1
    OnClick = SubByte1Click
  end
  object SubByte1_b2: TCheckBox
    Tag = 2
    Left = 152
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b2'
    TabOrder = 2
    OnClick = SubByte1Click
  end
  object SubByte1_b3: TCheckBox
    Tag = 3
    Left = 132
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b3'
    TabOrder = 3
    OnClick = SubByte1Click
  end
  object SubByte1_b4: TCheckBox
    Tag = 4
    Left = 111
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b4'
    TabOrder = 4
    OnClick = SubByte1Click
  end
  object SubByte1_b5: TCheckBox
    Tag = 5
    Left = 90
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b5'
    TabOrder = 5
    OnClick = SubByte1Click
  end
  object SubByte1_b6: TCheckBox
    Tag = 6
    Left = 70
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b6'
    TabOrder = 6
    OnClick = SubByte1Click
  end
  object SubByte1_b7: TCheckBox
    Tag = 7
    Left = 49
    Top = 28
    Width = 17
    Height = 17
    Caption = 'Sg'
    TabOrder = 7
    OnClick = SubByte1Click
  end
  object SubCy: TCheckBox
    Tag = 8
    Left = 29
    Top = 28
    Width = 17
    Height = 17
    Caption = 'SubCy'
    TabOrder = 8
    OnClick = SubCyClick
  end
  object SubByte2_b0: TCheckBox
    Left = 371
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b0'
    TabOrder = 9
    OnClick = SubByte2Click
  end
  object SubByte2_b1: TCheckBox
    Tag = 1
    Left = 350
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b1'
    TabOrder = 10
    OnClick = SubByte2Click
  end
  object SubByte2_b2: TCheckBox
    Tag = 2
    Left = 329
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b2'
    TabOrder = 11
    OnClick = SubByte2Click
  end
  object SubByte2_b3: TCheckBox
    Tag = 3
    Left = 309
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b3'
    TabOrder = 12
    OnClick = SubByte2Click
  end
  object SubByte2_b4: TCheckBox
    Tag = 4
    Left = 288
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b4'
    TabOrder = 13
    OnClick = SubByte2Click
  end
  object SubByte2_b5: TCheckBox
    Tag = 5
    Left = 267
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b5'
    TabOrder = 14
    OnClick = SubByte2Click
  end
  object SubByte2_b6: TCheckBox
    Tag = 6
    Left = 247
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b6'
    TabOrder = 15
    OnClick = SubByte2Click
  end
  object SubByte2_b7: TCheckBox
    Tag = 7
    Left = 226
    Top = 28
    Width = 17
    Height = 17
    Caption = 'Sg'
    TabOrder = 16
    OnClick = SubByte2Click
  end
  object SubByte3_b0: TCheckBox
    Left = 566
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b0'
    Enabled = False
    TabOrder = 17
  end
  object SubByte3_b1: TCheckBox
    Tag = 1
    Left = 545
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b1'
    Enabled = False
    TabOrder = 18
  end
  object SubByte3_b2: TCheckBox
    Tag = 2
    Left = 524
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b2'
    Enabled = False
    TabOrder = 19
  end
  object SubByte3_b3: TCheckBox
    Tag = 3
    Left = 504
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b3'
    Enabled = False
    TabOrder = 20
  end
  object SubByte3_b4: TCheckBox
    Tag = 4
    Left = 483
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b4'
    Enabled = False
    TabOrder = 21
  end
  object SubByte3_b5: TCheckBox
    Tag = 5
    Left = 462
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b5'
    Enabled = False
    TabOrder = 22
  end
  object SubByte3_b6: TCheckBox
    Tag = 6
    Left = 442
    Top = 28
    Width = 17
    Height = 17
    Caption = 'b6'
    Enabled = False
    TabOrder = 23
  end
  object SubByte3_b7: TCheckBox
    Tag = 7
    Left = 421
    Top = 28
    Width = 17
    Height = 17
    Caption = 'Sg'
    Enabled = False
    TabOrder = 24
  end
  object SubByte3_Cy: TCheckBox
    Tag = 8
    Left = 401
    Top = 28
    Width = 17
    Height = 17
    Caption = 'Cy'
    Enabled = False
    TabOrder = 25
  end
  object AddByte1_b0: TCheckBox
    Left = 195
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b0'
    TabOrder = 26
    OnClick = AddByte1Click
  end
  object AddByte1_b1: TCheckBox
    Tag = 1
    Left = 172
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b1'
    TabOrder = 27
    OnClick = AddByte1Click
  end
  object AddByte1_b2: TCheckBox
    Tag = 2
    Left = 151
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b2'
    TabOrder = 28
    OnClick = AddByte1Click
  end
  object AddByte1_b3: TCheckBox
    Tag = 3
    Left = 131
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b3'
    TabOrder = 29
    OnClick = AddByte1Click
  end
  object AddByte1_b4: TCheckBox
    Tag = 4
    Left = 110
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b4'
    TabOrder = 30
    OnClick = AddByte1Click
  end
  object AddByte1_b5: TCheckBox
    Tag = 5
    Left = 89
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b5'
    TabOrder = 31
    OnClick = AddByte1Click
  end
  object AddByte1_b6: TCheckBox
    Tag = 6
    Left = 69
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b6'
    TabOrder = 32
    OnClick = AddByte1Click
  end
  object AddByte1_b7: TCheckBox
    Tag = 7
    Left = 49
    Top = 123
    Width = 17
    Height = 17
    Caption = 'Sg'
    TabOrder = 33
    OnClick = AddByte1Click
  end
  object AddCy: TCheckBox
    Tag = 8
    Left = 29
    Top = 124
    Width = 17
    Height = 17
    Caption = 'Cy'
    TabOrder = 34
    OnClick = AddCyClick
  end
  object AddByte2_b0: TCheckBox
    Left = 370
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b0'
    TabOrder = 35
    OnClick = AddByte2Click
  end
  object AddByte2_b1: TCheckBox
    Tag = 1
    Left = 349
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b1'
    TabOrder = 36
    OnClick = AddByte2Click
  end
  object AddByte2_b2: TCheckBox
    Tag = 2
    Left = 328
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b2'
    TabOrder = 37
    OnClick = AddByte2Click
  end
  object AddByte2_b3: TCheckBox
    Tag = 3
    Left = 308
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b3'
    TabOrder = 38
    OnClick = AddByte2Click
  end
  object AddByte2_b4: TCheckBox
    Tag = 4
    Left = 287
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b4'
    TabOrder = 39
    OnClick = AddByte2Click
  end
  object AddByte2_b5: TCheckBox
    Tag = 5
    Left = 266
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b5'
    TabOrder = 40
    OnClick = AddByte2Click
  end
  object AddByte2_b6: TCheckBox
    Tag = 6
    Left = 246
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b6'
    TabOrder = 41
    OnClick = AddByte2Click
  end
  object AddByte2_b7: TCheckBox
    Tag = 7
    Left = 225
    Top = 124
    Width = 17
    Height = 17
    Caption = 'Sg'
    TabOrder = 42
    OnClick = AddByte2Click
  end
  object AddByte3_b0: TCheckBox
    Left = 565
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b0'
    Enabled = False
    TabOrder = 43
  end
  object AddByte3_b1: TCheckBox
    Tag = 1
    Left = 544
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b1'
    Enabled = False
    TabOrder = 44
  end
  object AddByte3_b2: TCheckBox
    Tag = 2
    Left = 523
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b2'
    Enabled = False
    TabOrder = 45
  end
  object AddByte3_b3: TCheckBox
    Tag = 3
    Left = 503
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b3'
    Enabled = False
    TabOrder = 46
  end
  object AddByte3_b4: TCheckBox
    Tag = 4
    Left = 482
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b4'
    Enabled = False
    TabOrder = 47
  end
  object AddByte3_b5: TCheckBox
    Tag = 5
    Left = 461
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b5'
    Enabled = False
    TabOrder = 48
  end
  object AddByte3_b6: TCheckBox
    Tag = 6
    Left = 441
    Top = 124
    Width = 17
    Height = 17
    Caption = 'b6'
    Enabled = False
    TabOrder = 49
  end
  object AddByte3_b7: TCheckBox
    Tag = 7
    Left = 420
    Top = 124
    Width = 17
    Height = 17
    Caption = 'Sg'
    Enabled = False
    TabOrder = 50
  end
  object AddByte3_Cy: TCheckBox
    Tag = 8
    Left = 400
    Top = 124
    Width = 17
    Height = 17
    Caption = 'Cy'
    Enabled = False
    TabOrder = 51
  end
end
