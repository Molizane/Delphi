object MemForm: TMemForm
  Left = 339
  Top = 169
  Width = 232
  Height = 165
  Caption = 'Memory View Setting'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 96
    Width = 209
    Height = 9
    Shape = bsTopLine
  end
  object Label1: TLabel
    Left = 24
    Top = 28
    Width = 53
    Height = 13
    Caption = 'Row Count'
  end
  object Label2: TLabel
    Left = 24
    Top = 52
    Width = 66
    Height = 13
    Caption = 'Column Count'
  end
  object Button1: TButton
    Left = 136
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
  end
  object Button2: TButton
    Left = 56
    Top = 104
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button2Click
  end
  object R: TSpinEdit
    Left = 136
    Top = 24
    Width = 73
    Height = 22
    MaxValue = 16000
    MinValue = 1
    TabOrder = 2
    Value = 10
  end
  object C: TSpinEdit
    Left = 136
    Top = 48
    Width = 73
    Height = 22
    MaxValue = 16000
    MinValue = 1
    TabOrder = 3
    Value = 3
  end
end
