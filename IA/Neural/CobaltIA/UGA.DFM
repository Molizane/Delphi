object frmGA: TfrmGA
  Left = 280
  Top = 320
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
  object lblErr: TLabel
    Left = 116
    Top = 26
    Width = 3
    Height = 13
    Caption = ' '
  end
  object imgErr: TImage
    Left = 34
    Top = 136
    Width = 337
    Height = 127
  end
  object btnRun: TButton
    Left = 30
    Top = 20
    Width = 75
    Height = 25
    Caption = '&Run'
    TabOrder = 0
    OnClick = btnRunClick
  end
  object btnCancel: TButton
    Left = 30
    Top = 58
    Width = 75
    Height = 25
    Caption = '&Cancel'
    Enabled = False
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object GA1: TGA
    Left = 168
    Top = 12
    Width = 35
    Height = 39
    ControlData = {
      93B2000048000000030008000BF25747200000005F0065007800740065006E00
      740078009E030000030008000AF25747E0FFFFFF5F0065007800740065006E00
      7400790008040000}
  end
end
