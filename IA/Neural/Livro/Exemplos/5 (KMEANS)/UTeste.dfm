object Teste: TTeste
  Left = 274
  Top = 378
  Width = 570
  Height = 347
  Caption = 'Teste de Segmenta'#231#227'o'
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
    Left = 16
    Top = 34
    Width = 541
    Height = 281
  end
  object Label1: TLabel
    Left = 96
    Top = 164
    Width = 29
    Height = 13
    Caption = 'V'#237'deo'
  end
  object Label2: TLabel
    Left = 112
    Top = 114
    Width = 14
    Height = 13
    Caption = 'TV'
  end
  object Label3: TLabel
    Left = 98
    Top = 139
    Width = 28
    Height = 13
    Caption = 'R'#225'dio'
  end
  object Label4: TLabel
    Left = 98
    Top = 65
    Width = 27
    Height = 13
    Caption = 'Idade'
  end
  object Label5: TLabel
    Left = 101
    Top = 91
    Width = 24
    Height = 13
    Caption = 'Sexo'
  end
  object Label6: TLabel
    Left = 93
    Top = 39
    Width = 32
    Height = 13
    Caption = 'Renda'
  end
  object Label7: TLabel
    Left = 90
    Top = 190
    Width = 36
    Height = 13
    Caption = 'Internet'
  end
  object Label8: TLabel
    Left = 84
    Top = 214
    Width = 39
    Height = 13
    Caption = 'C'#244'njuge'
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
  object Label12: TLabel
    Left = 414
    Top = 122
    Width = 38
    Height = 13
    Caption = 'Label12'
  end
  object Label13: TLabel
    Left = 414
    Top = 164
    Width = 38
    Height = 13
    Caption = 'Label13'
  end
  object Label16: TLabel
    Left = 414
    Top = 206
    Width = 38
    Height = 13
    Caption = 'Label16'
  end
  object Label18: TLabel
    Left = 480
    Top = 122
    Width = 38
    Height = 13
    Caption = 'Label18'
  end
  object Label19: TLabel
    Left = 480
    Top = 164
    Width = 38
    Height = 13
    Caption = 'Label19'
  end
  object Label20: TLabel
    Left = 480
    Top = 206
    Width = 38
    Height = 13
    Caption = 'Label20'
  end
  object Label17: TLabel
    Left = 398
    Top = 92
    Width = 57
    Height = 13
    Caption = 'DIST'#194'NCIA'
  end
  object Label21: TLabel
    Left = 464
    Top = 92
    Width = 75
    Height = 13
    Caption = 'PROXIMIDADE'
  end
  object Label9: TLabel
    Left = 66
    Top = 240
    Width = 60
    Height = 13
    Caption = 'Faixa Dep. 1'
  end
  object Label10: TLabel
    Left = 66
    Top = 264
    Width = 60
    Height = 13
    Caption = 'Faixa Dep. 2'
  end
  object Label11: TLabel
    Left = 66
    Top = 288
    Width = 60
    Height = 13
    Caption = 'Faixa Dep. 3'
  end
  object seRenda: TSpinEdit
    Left = 128
    Top = 36
    Width = 67
    Height = 22
    Increment = 100
    MaxValue = 10000
    MinValue = 100
    TabOrder = 0
    Value = 3000
  end
  object seIdade: TSpinEdit
    Left = 128
    Top = 61
    Width = 67
    Height = 22
    MaxValue = 60
    MinValue = 18
    TabOrder = 1
    Value = 18
  end
  object seSexo: TSpinEdit
    Left = 128
    Top = 87
    Width = 67
    Height = 22
    MaxValue = 1
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object seTV: TSpinEdit
    Left = 128
    Top = 112
    Width = 67
    Height = 22
    MaxValue = 3
    MinValue = 0
    TabOrder = 3
    Value = 3
  end
  object seRadio: TSpinEdit
    Left = 128
    Top = 136
    Width = 67
    Height = 22
    MaxValue = 2
    MinValue = 0
    TabOrder = 4
    Value = 1
  end
  object seVideo: TSpinEdit
    Left = 128
    Top = 161
    Width = 67
    Height = 22
    MaxValue = 20
    MinValue = 0
    TabOrder = 5
    Value = 20
  end
  object seInternet: TSpinEdit
    Left = 128
    Top = 185
    Width = 67
    Height = 22
    MaxValue = 2
    MinValue = 0
    TabOrder = 6
    Value = 1
  end
  object seConjuge: TSpinEdit
    Left = 128
    Top = 210
    Width = 67
    Height = 22
    MaxValue = 1
    MinValue = 0
    TabOrder = 7
    Value = 1
  end
  object btnTeste: TBitBtn
    Left = 210
    Top = 140
    Width = 127
    Height = 69
    Caption = 'Teste'
    TabOrder = 8
    OnClick = btnTesteClick
  end
  object seFD1: TSpinEdit
    Left = 128
    Top = 235
    Width = 67
    Height = 22
    MaxValue = 5
    MinValue = 0
    TabOrder = 9
    Value = 5
  end
  object seFD2: TSpinEdit
    Left = 128
    Top = 259
    Width = 67
    Height = 22
    MaxValue = 5
    MinValue = 0
    TabOrder = 10
    Value = 1
  end
  object seFD3: TSpinEdit
    Left = 128
    Top = 284
    Width = 67
    Height = 22
    MaxValue = 5
    MinValue = 0
    TabOrder = 11
    Value = 2
  end
  object st1: TStaticText
    Left = 358
    Top = 112
    Width = 35
    Height = 35
    Alignment = taCenter
    AutoSize = False
    Caption = '1'
    Color = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 12
  end
  object st2: TStaticText
    Left = 358
    Top = 152
    Width = 35
    Height = 35
    Alignment = taCenter
    AutoSize = False
    Caption = '2'
    Color = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 13
  end
  object st3: TStaticText
    Left = 358
    Top = 192
    Width = 35
    Height = 35
    Alignment = taCenter
    AutoSize = False
    Caption = '3'
    Color = clBlue
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    TabOrder = 14
  end
  object tblSegment: TTable
    BeforeOpen = tblSegmentBeforeOpen
    DatabaseName = 'Segment'
    TableName = 'Segment.db'
    Left = 462
    Top = 26
  end
  object dsSegment: TDataSource
    DataSet = tblSegment
    Left = 492
    Top = 26
  end
  object KMeans: TKMeans
    Alpha = 0.010000000000000000
    ClusterNum = 3
    Dimension = 2
    ItemsNum = 300
    Knowledge = 'Segment.kme'
    Left = 432
    Top = 26
  end
end
