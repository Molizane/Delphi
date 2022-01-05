object FrmTeste: TFrmTeste
  Left = 556
  Top = 231
  Width = 570
  Height = 269
  Caption = 'Teste de Comportamento'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 11
    Top = 32
    Width = 541
    Height = 201
  end
  object Label1: TLabel
    Left = 60
    Top = 40
    Width = 17
    Height = 13
    Caption = 'IFR'
  end
  object Label2: TLabel
    Left = 60
    Top = 74
    Width = 16
    Height = 13
    Caption = '%D'
  end
  object Label3: TLabel
    Left = 60
    Top = 107
    Width = 15
    Height = 13
    Caption = '%K'
  end
  object Label4: TLabel
    Left = 60
    Top = 141
    Width = 18
    Height = 13
    Caption = 'MFI'
  end
  object Label5: TLabel
    Left = 60
    Top = 175
    Width = 16
    Height = 13
    Caption = 'UO'
  end
  object Label6: TLabel
    Left = 60
    Top = 209
    Width = 44
    Height = 13
    Caption = 'SUPRES'
  end
  object Label9: TLabel
    Left = 415
    Top = 98
    Width = 6
    Height = 13
    Caption = '1'
  end
  object Label10: TLabel
    Left = 415
    Top = 126
    Width = 6
    Height = 13
    Caption = '2'
  end
  object Label11: TLabel
    Left = 415
    Top = 153
    Width = 6
    Height = 13
    Caption = '3'
  end
  object Label14: TLabel
    Left = 114
    Top = 6
    Width = 101
    Height = 21
    AutoSize = False
    Caption = 'ENTRADAS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label15: TLabel
    Left = 347
    Top = 6
    Width = 68
    Height = 20
    Caption = 'SA'#205'DAS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object seIFR: TEdit
    Left = 128
    Top = 36
    Width = 67
    Height = 21
    TabOrder = 0
    OnKeyPress = seIFRKeyPress
  end
  object sePERC_D: TEdit
    Left = 128
    Top = 69
    Width = 67
    Height = 21
    TabOrder = 1
    OnKeyPress = seIFRKeyPress
  end
  object sePERC_K: TEdit
    Left = 128
    Top = 103
    Width = 67
    Height = 21
    TabOrder = 2
    OnKeyPress = seIFRKeyPress
  end
  object seMFI: TEdit
    Left = 128
    Top = 136
    Width = 67
    Height = 21
    TabOrder = 3
    OnKeyPress = seIFRKeyPress
  end
  object seUO: TEdit
    Left = 128
    Top = 170
    Width = 67
    Height = 21
    TabOrder = 4
    OnKeyPress = seIFRKeyPress
  end
  object seSUPRES: TEdit
    Left = 128
    Top = 203
    Width = 67
    Height = 21
    TabOrder = 5
    OnKeyPress = seIFRKeyPress
  end
  object edAgressivo: TEdit
    Left = 359
    Top = 94
    Width = 50
    Height = 21
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 7
  end
  object btnTeste: TBitBtn
    Left = 217
    Top = 97
    Width = 127
    Height = 69
    Caption = 'Teste'
    TabOrder = 6
    OnClick = btnTesteClick
  end
  object edArrojado: TEdit
    Left = 359
    Top = 122
    Width = 50
    Height = 21
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
  end
  object edEquilibrado: TEdit
    Left = 359
    Top = 150
    Width = 50
    Height = 21
    TabStop = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 9
  end
  object MLP: TMLP
    Struct.Strings = (
      '6'
      '5'
      '3')
    Momentum = 0.500000000000000000
    Learning = 0.900000000000000000
    Knowledge = 'Vale5.mlp'
    Left = 490
    Top = 3
  end
end
