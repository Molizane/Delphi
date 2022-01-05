object Form1: TForm1
  Left = 254
  Top = 106
  BorderStyle = bsDialog
  Caption = 'Joystick'
  ClientHeight = 140
  ClientWidth = 456
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 277
    Top = 4
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 369
    Top = 4
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 277
    Top = 23
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label5: TLabel
    Left = 369
    Top = 23
    Width = 32
    Height = 13
    Caption = 'Label5'
  end
  object Label4: TLabel
    Left = 277
    Top = 43
    Width = 32
    Height = 13
    Caption = 'Label4'
  end
  object Label6: TLabel
    Left = 369
    Top = 43
    Width = 32
    Height = 13
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 10
    Top = 118
    Width = 32
    Height = 13
    Caption = 'Label7'
  end
  object Label8: TLabel
    Left = 277
    Top = 62
    Width = 32
    Height = 13
    Caption = 'Label8'
  end
  object Label9: TLabel
    Left = 277
    Top = 82
    Width = 32
    Height = 13
    Caption = 'Label9'
  end
  object Panel1: TPanel
    Left = 4
    Top = 4
    Width = 142
    Height = 107
    BevelOuter = bvNone
    Caption = ' '
    Enabled = False
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 6
      Top = 4
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 1'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 6
      Top = 25
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 2'
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 6
      Top = 46
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 3'
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 6
      Top = 67
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 4'
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 6
      Top = 88
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 5'
      TabOrder = 4
    end
    object CheckBox6: TCheckBox
      Left = 78
      Top = 4
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 6'
      TabOrder = 5
    end
    object CheckBox7: TCheckBox
      Left = 78
      Top = 25
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 7'
      TabOrder = 6
    end
    object CheckBox8: TCheckBox
      Left = 78
      Top = 46
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 8'
      TabOrder = 7
    end
    object CheckBox9: TCheckBox
      Left = 78
      Top = 67
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 9'
      TabOrder = 8
    end
    object CheckBox10: TCheckBox
      Left = 78
      Top = 88
      Width = 65
      Height = 17
      Caption = 'Bot'#227'o 10'
      TabOrder = 9
    end
  end
  object BoxMira: TScrollBox
    Left = 164
    Top = 4
    Width = 94
    Height = 94
    HorzScrollBar.Visible = False
    VertScrollBar.Visible = False
    Color = clWindow
    ParentColor = False
    TabOrder = 1
    object Mira: TImage
      Left = 10
      Top = 12
      Width = 14
      Height = 14
      Center = True
      Picture.Data = {
        07544269746D617076000000424D76000000000000003E000000280000000E00
        00000E000000010001000000000038000000C40E0000C40E0000020000000000
        000000000000FFFFFF00FEFC0000FEFC0000FEFC0000FEFC0000FEFC0000FEFC
        000080000000FEFC0000FEFC0000FEFC0000FEFC0000FEFC0000FEFC0000FFFC
        0000}
      Transparent = True
    end
  end
  object BitBtn1: TBitBtn
    Left = 375
    Top = 111
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 325
    Top = 6
  end
end
