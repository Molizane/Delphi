object Parametros: TParametros
  Left = 423
  Top = 379
  Width = 311
  Height = 182
  Caption = 'Par'#226'metros'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 26
    Top = 10
    Width = 253
    Height = 103
    TabOrder = 0
    object Label1: TLabel
      Left = 92
      Top = 20
      Width = 51
      Height = 13
      Caption = 'N'#186' '#201'pocas'
    end
    object Label3: TLabel
      Left = 8
      Top = 44
      Width = 136
      Height = 13
      Caption = 'Taxa de Aprendizagem (Alfa)'
    end
    object Label5: TLabel
      Left = 22
      Top = 68
      Width = 122
      Height = 13
      Caption = 'Arquivo de Conhecimento'
    end
    object seNEpocas: TSpinEdit
      Left = 148
      Top = 16
      Width = 63
      Height = 22
      Increment = 500
      MaxValue = 1000
      MinValue = 1
      TabOrder = 0
      Value = 50
    end
    object seAlpha: TSpinEdit
      Left = 148
      Top = 40
      Width = 63
      Height = 22
      MaxValue = 100
      MinValue = 0
      TabOrder = 1
      Value = 10
    end
    object edArquivo: TEdit
      Left = 148
      Top = 64
      Width = 91
      Height = 21
      TabOrder = 2
      Text = 'Segment.kme'
    end
  end
  object BitBtn1: TBitBtn
    Left = 72
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 154
    Top = 120
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
