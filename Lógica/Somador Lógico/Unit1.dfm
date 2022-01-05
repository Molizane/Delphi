object Form1: TForm1
  Left = 738
  Top = 156
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Somador L'#243'gico'
  ClientHeight = 452
  ClientWidth = 204
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object chkA: TCheckBox
    Left = 6
    Top = 6
    Width = 30
    Height = 15
    Caption = 'A'
    TabOrder = 0
    OnClick = chkAClick
  end
  object chkB: TCheckBox
    Left = 39
    Top = 6
    Width = 28
    Height = 15
    Caption = 'B'
    TabOrder = 1
    OnClick = chkAClick
  end
  object chkCi: TCheckBox
    Left = 69
    Top = 6
    Width = 31
    Height = 15
    Caption = 'Ci'
    TabOrder = 2
    OnClick = chkAClick
  end
  object pnlOpers: TPanel
    Left = 6
    Top = 26
    Width = 191
    Height = 420
    Caption = ' '
    Enabled = False
    TabOrder = 3
    object chk1: TCheckBox
      Left = 6
      Top = 6
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A.B'#39
      TabOrder = 0
    end
    object chk2: TCheckBox
      Left = 6
      Top = 33
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A'#39'.B'
      TabOrder = 1
    end
    object chk3: TCheckBox
      Left = 6
      Top = 61
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A.B'#39' + A'#39'.B'
      TabOrder = 2
    end
    object chk4: TCheckBox
      Left = 6
      Top = 89
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'Ci'#39'.(A.B'#39' + A'#39'.B)'
      TabOrder = 3
    end
    object chk5: TCheckBox
      Left = 6
      Top = 117
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A'#39'.B'#39
      TabOrder = 4
    end
    object chk6: TCheckBox
      Left = 6
      Top = 145
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A.B'
      TabOrder = 5
    end
    object chk7: TCheckBox
      Left = 6
      Top = 173
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A'#39'.B'#39' + A.B'
      TabOrder = 6
    end
    object chk8: TCheckBox
      Left = 6
      Top = 201
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'Ci.(A'#39'.B'#39' + A.B)'
      TabOrder = 7
    end
    object chk9: TCheckBox
      Left = 6
      Top = 229
      Width = 175
      Height = 15
      Alignment = taLeftJustify
      Caption = 'Ci'#39'.(A.B'#39' + A'#39'.B) + Ci.(A'#39'.B'#39' + A.B)'
      TabOrder = 8
    end
    object chk10: TCheckBox
      Left = 6
      Top = 264
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A.B'
      TabOrder = 9
    end
    object chk11: TCheckBox
      Left = 6
      Top = 291
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A.B'#39
      TabOrder = 10
    end
    object chk12: TCheckBox
      Left = 6
      Top = 318
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A'#39'.B'
      TabOrder = 11
    end
    object chk13: TCheckBox
      Left = 6
      Top = 345
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A.B'#39' + A'#39'.B'
      TabOrder = 12
    end
    object chk14: TCheckBox
      Left = 6
      Top = 372
      Width = 92
      Height = 15
      Alignment = taLeftJustify
      Caption = 'Ci.(A.B'#39' + A'#39'.B)'
      TabOrder = 13
    end
    object chk15: TCheckBox
      Left = 6
      Top = 399
      Width = 175
      Height = 15
      Alignment = taLeftJustify
      Caption = 'A.B + Ci.(A.B'#39' + A'#39'.B)'
      TabOrder = 14
    end
  end
  object pnlResults: TPanel
    Left = 115
    Top = 2
    Width = 82
    Height = 23
    Caption = ' '
    Enabled = False
    TabOrder = 4
    object chkS: TCheckBox
      Left = 6
      Top = 4
      Width = 29
      Height = 15
      Caption = 'S'
      TabOrder = 0
      OnClick = chkAClick
    end
    object chkCo: TCheckBox
      Left = 42
      Top = 4
      Width = 35
      Height = 15
      Caption = 'Co'
      TabOrder = 1
      OnClick = chkAClick
    end
  end
end
