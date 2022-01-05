object Form1: TForm1
  Left = 192
  Top = 113
  Width = 696
  Height = 480
  Caption = 'Form1'
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
  object Label1: TLabel
    Left = 536
    Top = 14
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 536
    Top = 37
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Label3: TLabel
    Left = 536
    Top = 60
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object Label4: TLabel
    Left = 536
    Top = 83
    Width = 32
    Height = 13
    Caption = 'Label4'
  end
  object Label5: TLabel
    Left = 536
    Top = 106
    Width = 32
    Height = 13
    Caption = 'Label5'
  end
  object Label6: TLabel
    Left = 536
    Top = 128
    Width = 32
    Height = 13
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 536
    Top = 151
    Width = 32
    Height = 13
    Caption = 'Label7'
  end
  object Label8: TLabel
    Left = 536
    Top = 174
    Width = 32
    Height = 13
    Caption = 'Label8'
  end
  object Label9: TLabel
    Left = 536
    Top = 197
    Width = 32
    Height = 13
    Caption = 'Label9'
  end
  object Label10: TLabel
    Left = 536
    Top = 220
    Width = 38
    Height = 13
    Caption = 'Label10'
  end
  object BitBtn1: TBitBtn
    Left = 228
    Top = 62
    Width = 75
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 0
    Visible = False
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 342
    Top = 20
    Width = 75
    Height = 25
    Caption = 'BitBtn2'
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object CheckBoxBit0: TCheckBox
    Left = 228
    Top = 14
    Width = 97
    Height = 17
    Caption = 'A'
    TabOrder = 2
  end
  object CheckBoxBit1: TCheckBox
    Left = 228
    Top = 34
    Width = 97
    Height = 17
    Caption = 'B'
    TabOrder = 3
  end
  object CheckBox1: TCheckBox
    Left = 428
    Top = 10
    Width = 97
    Height = 17
    Caption = 'A e B'
    Enabled = False
    TabOrder = 4
  end
  object CheckBox2: TCheckBox
    Left = 428
    Top = 33
    Width = 97
    Height = 17
    Caption = 'A ou B'
    Enabled = False
    TabOrder = 5
  end
  object CheckBox3: TCheckBox
    Left = 428
    Top = 56
    Width = 97
    Height = 17
    Caption = 'CheckBox3'
    Enabled = False
    TabOrder = 6
  end
  object CheckBox4: TCheckBox
    Left = 428
    Top = 79
    Width = 97
    Height = 17
    Caption = 'CheckBox4'
    Enabled = False
    TabOrder = 7
  end
  object CheckBox5: TCheckBox
    Left = 428
    Top = 102
    Width = 97
    Height = 17
    Caption = 'CheckBox5'
    Enabled = False
    TabOrder = 8
  end
  object CheckBox6: TCheckBox
    Left = 428
    Top = 126
    Width = 97
    Height = 17
    Caption = 'CheckBox6'
    Enabled = False
    TabOrder = 9
  end
  object CheckBox7: TCheckBox
    Left = 428
    Top = 149
    Width = 97
    Height = 17
    Caption = 'CheckBox7'
    Enabled = False
    TabOrder = 10
  end
  object CheckBox8: TCheckBox
    Left = 428
    Top = 172
    Width = 97
    Height = 17
    Caption = 'CheckBox8'
    Enabled = False
    TabOrder = 11
  end
  object CheckBox9: TCheckBox
    Left = 428
    Top = 195
    Width = 97
    Height = 17
    Caption = 'CheckBox9'
    Enabled = False
    TabOrder = 12
  end
  object CheckBox10: TCheckBox
    Left = 428
    Top = 218
    Width = 97
    Height = 17
    Caption = 'CheckBox10'
    Enabled = False
    TabOrder = 13
  end
  object inBit0: TNNSignal
    Max = 1
    Limited = False
    Left = 6
    Top = 6
  end
  object inBit1: TNNSignal
    Max = 1
    Limited = False
    Left = 45
    Top = 6
  end
  object NeuralNet1: TNeuralNet
    SignalsInput.Strings = (
      'inBit0'
      'inBit1')
    SignalsOutput.Strings = (
      'outBit0'
      'outBit1'
      'outBit2'
      'outBit3'
      'outBit4'
      'outBit5'
      'outBit6'
      'outBit7'
      'outBit8'
      'outBit9')
    FileName = 'bin.net'
    Active = True
    LayerInputs = 2
    LayerOutputs = 10
    LayerHiden01 = 6
    LayerHiden02 = 0
    LayerHiden03 = 0
    LayerHiden04 = 0
    LayerHiden05 = 0
    LayerHiden06 = 0
    LayerHiden07 = 0
    LayerHiden08 = 0
    LayerHiden09 = 0
    LayerHiden10 = 0
    Ni = 0.25
    Left = 160
    Top = 6
  end
  object outBit0: TNNSignal
    Max = 1
    Limited = False
    Left = 6
    Top = 54
  end
  object outBit1: TNNSignal
    Max = 1
    Limited = False
    Left = 45
    Top = 54
  end
  object outBit2: TNNSignal
    Max = 1
    Limited = False
    Left = 83
    Top = 54
  end
  object outBit3: TNNSignal
    Max = 1
    Limited = False
    Left = 122
    Top = 54
  end
  object outBit4: TNNSignal
    Max = 1
    Limited = False
    Left = 160
    Top = 54
  end
  object outBit5: TNNSignal
    Max = 1
    Limited = False
    Left = 6
    Top = 114
  end
  object outBit6: TNNSignal
    Max = 1
    Limited = False
    Left = 45
    Top = 114
  end
  object outBit7: TNNSignal
    Max = 1
    Limited = False
    Left = 83
    Top = 114
  end
  object outBit8: TNNSignal
    Max = 1
    Limited = False
    Left = 122
    Top = 114
  end
  object outBit9: TNNSignal
    Max = 1
    Limited = False
    Left = 160
    Top = 114
  end
end
