object frmFZ: TfrmFZ
  Left = 407
  Top = 218
  Width = 397
  Height = 310
  BorderIcons = [biSystemMenu]
  Caption = 'Cobalt A.I. SDK Example'
  Color = clBtnFace
  Constraints.MaxHeight = 310
  Constraints.MaxWidth = 397
  Constraints.MinHeight = 310
  Constraints.MinWidth = 397
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lblCancel: TLabel
    Left = 116
    Top = 64
    Width = 3
    Height = 13
    Caption = ' '
  end
  object lblFZ: TLabel
    Left = 116
    Top = 26
    Width = 3
    Height = 13
    Caption = ' '
  end
  object btnAnalyze: TButton
    Left = 30
    Top = 20
    Width = 75
    Height = 25
    Caption = '&Analyze'
    TabOrder = 0
    OnClick = btnAnalyzeClick
  end
  object btnCancel: TButton
    Left = 30
    Top = 58
    Width = 75
    Height = 25
    Caption = '&Cancel'
    Enabled = False
    TabOrder = 1
  end
  object memFZ: TMemo
    Left = 28
    Top = 146
    Width = 321
    Height = 107
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object FZ1: TFZ
    Left = 270
    Top = 16
    Width = 34
    Height = 34
    ControlData = {
      93B2000048000000030008000BF25747200000005F0065007800740065006E00
      7400780084030000030008000AF25747E0FFFFFF5F0065007800740065006E00
      7400790084030000}
  end
  object OD1: TOpenDialog
    FileName = 'Fuzzy PCA.txt'
    Filter = 'CSV Files|*.csv;*.txt'
    Left = 164
    Top = 20
  end
end
