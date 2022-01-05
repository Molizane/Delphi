object ChooseTargetForm: TChooseTargetForm
  Left = 342
  Top = 304
  BorderStyle = bsDialog
  Caption = 'Target selection'
  ClientHeight = 74
  ClientWidth = 239
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 225
    Height = 33
    Shape = bsFrame
  end
  object Label2: TLabel
    Left = 13
    Top = 16
    Width = 39
    Height = 13
    Caption = 'Set as...'
  end
  object OKBtn: TButton
    Left = 7
    Top = 46
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 87
    Top = 46
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object TargetBox: TComboBox
    Left = 64
    Top = 14
    Width = 162
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
  end
end