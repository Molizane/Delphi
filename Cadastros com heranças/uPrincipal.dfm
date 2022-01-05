object FPrincipal: TFPrincipal
  Left = 300
  Top = 136
  Width = 696
  Height = 480
  Caption = 'Principal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnTipos: TBitBtn
    Left = 14
    Top = 10
    Width = 75
    Height = 25
    Caption = '&Tipos'
    TabOrder = 0
    OnClick = btnTiposClick
  end
  object btnPessoas: TBitBtn
    Left = 14
    Top = 42
    Width = 75
    Height = 25
    Caption = '&Pessoas'
    TabOrder = 1
    OnClick = btnPessoasClick
  end
end
