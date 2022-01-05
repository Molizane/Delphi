object Teste: TTeste
  Left = 196
  Top = 109
  Width = 570
  Height = 338
  Caption = 'Teste de Perfil'
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
  DesignSize = (
    562
    311)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 16
    Top = 32
    Width = 541
    Height = 267
    Anchors = [akLeft, akTop, akRight, akBottom]
  end
  object Label1: TLabel
    Left = 60
    Top = 40
    Width = 65
    Height = 13
    Caption = 'N'#186' Invest. AR'
  end
  object Label2: TLabel
    Left = 58
    Top = 74
    Width = 67
    Height = 13
    Caption = 'N'#186' Invest. MR'
  end
  object Label3: TLabel
    Left = 60
    Top = 107
    Width = 65
    Height = 13
    Caption = 'N'#186' Invest. BR'
  end
  object Label4: TLabel
    Left = 98
    Top = 141
    Width = 27
    Height = 13
    Caption = 'Idade'
  end
  object Label5: TLabel
    Left = 101
    Top = 175
    Width = 24
    Height = 13
    Caption = 'Sexo'
  end
  object Label6: TLabel
    Left = 93
    Top = 209
    Width = 32
    Height = 13
    Caption = 'Renda'
  end
  object Label7: TLabel
    Left = 106
    Top = 242
    Width = 19
    Height = 13
    Caption = 'PMI'
  end
  object Label8: TLabel
    Left = 64
    Top = 276
    Width = 61
    Height = 13
    Caption = 'Escolaridade'
  end
  object Label9: TLabel
    Left = 408
    Top = 110
    Width = 46
    Height = 13
    Caption = 'Agressivo'
  end
  object Label10: TLabel
    Left = 408
    Top = 138
    Width = 39
    Height = 13
    Caption = 'Arrojado'
  end
  object Label11: TLabel
    Left = 408
    Top = 165
    Width = 52
    Height = 13
    Caption = 'Equilibrado'
  end
  object Label12: TLabel
    Left = 408
    Top = 193
    Width = 52
    Height = 13
    Caption = 'Reservado'
  end
  object Label13: TLabel
    Left = 408
    Top = 220
    Width = 48
    Height = 13
    Caption = 'Defensivo'
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
    Left = 340
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
  object seNInvAR: TSpinEdit
    Left = 128
    Top = 36
    Width = 67
    Height = 22
    MaxValue = 10
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object seNInvMR: TSpinEdit
    Left = 128
    Top = 69
    Width = 67
    Height = 22
    MaxValue = 10
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object seNInvBR: TSpinEdit
    Left = 128
    Top = 103
    Width = 67
    Height = 22
    MaxValue = 10
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object seIdade: TSpinEdit
    Left = 128
    Top = 136
    Width = 67
    Height = 22
    MaxValue = 60
    MinValue = 10
    TabOrder = 3
    Value = 25
  end
  object seSexo: TSpinEdit
    Left = 128
    Top = 170
    Width = 67
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 1
  end
  object seRenda: TSpinEdit
    Left = 128
    Top = 203
    Width = 67
    Height = 22
    Increment = 100
    MaxValue = 10000
    MinValue = 500
    TabOrder = 5
    Value = 1000
  end
  object sePMI: TSpinEdit
    Left = 128
    Top = 237
    Width = 67
    Height = 22
    MaxValue = 12
    MinValue = 1
    TabOrder = 6
    Value = 1
  end
  object seEscol: TSpinEdit
    Left = 128
    Top = 270
    Width = 67
    Height = 22
    MaxValue = 3
    MinValue = 1
    TabOrder = 7
    Value = 2
  end
  object edAgressivo: TEdit
    Left = 352
    Top = 106
    Width = 50
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object btnTeste: TBitBtn
    Left = 210
    Top = 140
    Width = 127
    Height = 69
    Caption = 'Teste'
    TabOrder = 9
    OnClick = btnTesteClick
  end
  object edArrojado: TEdit
    Left = 352
    Top = 134
    Width = 50
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
  end
  object edEquilibrado: TEdit
    Left = 352
    Top = 162
    Width = 50
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
  end
  object edReservado: TEdit
    Left = 352
    Top = 190
    Width = 50
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
  end
  object edDefensivo: TEdit
    Left = 352
    Top = 218
    Width = 50
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
  end
  object tblPerfil: TTable
    BeforeOpen = tblPerfilBeforeOpen
    DatabaseName = 'Perfil'
    TableName = 'Perfil.DB'
    Left = 462
    Top = 26
  end
  object dsPerfil: TDataSource
    DataSet = tblPerfil
    Left = 492
    Top = 26
  end
  object MLP: TMLP
    Struct.Strings = (
      '8'
      '5'
      '5')
    Momentum = 0.500000000000000000
    Learning = 0.900000000000000000
    Knowledge = 'Perfil.mlp'
    Left = 432
    Top = 26
  end
end
