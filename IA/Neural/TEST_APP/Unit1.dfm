object Form1: TForm1
  Left = 182
  Top = 174
  BorderStyle = bsDialog
  Caption = 'NeuroVCL - binary function example'
  ClientHeight = 230
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label11: TLabel
    Left = 8
    Top = 8
    Width = 8
    Height = 16
    Caption = 'x'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label12: TLabel
    Left = 8
    Top = 32
    Width = 7
    Height = 16
    Caption = 'y'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label13: TLabel
    Left = 8
    Top = 64
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'x AND y'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label14: TLabel
    Left = 8
    Top = 80
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'x OR y'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label15: TLabel
    Left = 8
    Top = 96
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'x XOR Y'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label16: TLabel
    Left = 8
    Top = 112
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'x => y'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label17: TLabel
    Left = 8
    Top = 128
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'x <=> y'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label18: TLabel
    Left = 8
    Top = 144
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'NOT(x XOR y)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label19: TLabel
    Left = 8
    Top = 160
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'NOT(x)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label20: TLabel
    Left = 8
    Top = 176
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'NOT(y)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label21: TLabel
    Left = 8
    Top = 192
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'NOT(x AND y)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label22: TLabel
    Left = 8
    Top = 208
    Width = 85
    Height = 16
    AutoSize = False
    Caption = 'NOT(x =>y)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 104
    Top = 64
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 104
    Top = 80
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 104
    Top = 96
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 104
    Top = 112
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 104
    Top = 128
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 104
    Top = 144
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 104
    Top = 160
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 104
    Top = 176
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 104
    Top = 192
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 104
    Top = 208
    Width = 25
    Height = 16
    Caption = '0.00'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label24: TLabel
    Left = 136
    Top = 112
    Width = 61
    Height = 13
    Caption = '<- implication'
  end
  object Label23: TLabel
    Left = 136
    Top = 208
    Width = 59
    Height = 13
    Caption = '<- implicaton'
  end
  object Edit1: TEdit
    Left = 24
    Top = 8
    Width = 33
    Height = 21
    BiDiMode = bdRightToLeftNoAlign
    ParentBiDiMode = False
    TabOrder = 0
    Text = '1'
  end
  object Edit2: TEdit
    Left = 24
    Top = 32
    Width = 33
    Height = 21
    BiDiMode = bdRightToLeftNoAlign
    ParentBiDiMode = False
    TabOrder = 1
    Text = '1'
  end
  object Button1: TButton
    Left = 64
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Calculate'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Input1: TNNSignal
    Max = 1
    Limited = False
    Left = 152
    Top = 40
  end
  object Input2: TNNSignal
    Max = 1
    Limited = False
    Left = 152
    Top = 72
  end
  object Output1: TNNSignal
    Max = 1
    Limited = False
    Left = 216
  end
  object NeuralNet1: TNeuralNet
    SignalsInput.Strings = (
      'Input1'
      'Input2')
    SignalsOutput.Strings = (
      'Output1'
      'Output2'
      'Output3'
      'Output4'
      'Output5'
      'Output6'
      'Output7'
      'Output8'
      'Output9'
      'Output10')
    FileName = 'bin.net'
    Active = True
    LayerInputs = 2
    LayerOutputs = 10
    LayerHiden01 = 4
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
    Left = 184
    Top = 56
  end
  object Output2: TNNSignal
    Max = 1
    Limited = False
    Left = 216
    Top = 32
  end
  object Output3: TNNSignal
    Max = 1
    Limited = False
    Left = 216
    Top = 64
  end
  object Output4: TNNSignal
    Max = 1
    Limited = False
    Left = 216
    Top = 96
  end
  object Output5: TNNSignal
    Max = 1
    Limited = False
    Left = 216
    Top = 128
  end
  object Output6: TNNSignal
    Max = 1
    Limited = False
    Left = 256
  end
  object Output7: TNNSignal
    Max = 1
    Limited = False
    Left = 256
    Top = 32
  end
  object Output8: TNNSignal
    Max = 1
    Limited = False
    Left = 256
    Top = 64
  end
  object Output9: TNNSignal
    Max = 1
    Limited = False
    Left = 256
    Top = 96
  end
  object Output10: TNNSignal
    Max = 1
    Limited = False
    Left = 256
    Top = 128
  end
end
