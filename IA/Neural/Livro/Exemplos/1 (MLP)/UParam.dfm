object Parametros: TParametros
  Left = 241
  Top = 178
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Par'#226'metros'
  ClientHeight = 230
  ClientWidth = 298
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
    Left = 23
    Top = 10
    Width = 253
    Height = 179
    TabOrder = 0
    object Label1: TLabel
      Left = 92
      Top = 20
      Width = 51
      Height = 13
      Caption = 'N'#186' '#201'pocas'
    end
    object Label2: TLabel
      Left = 20
      Top = 46
      Width = 124
      Height = 13
      Caption = 'Neur'#244'nios Camada Oculta'
    end
    object Label3: TLabel
      Left = 34
      Top = 74
      Width = 109
      Height = 13
      Caption = 'Taxa de Aprendizagem'
    end
    object Label4: TLabel
      Left = 70
      Top = 102
      Width = 74
      Height = 13
      Caption = 'Taxa de In'#233'rcia'
    end
    object Label5: TLabel
      Left = 22
      Top = 130
      Width = 122
      Height = 13
      Caption = 'Arquivo de Conhecimento'
    end
    object seNeuronios: TSpinEdit
      Left = 148
      Top = 42
      Width = 63
      Height = 22
      MaxValue = 8
      MinValue = 1
      TabOrder = 0
      Value = 5
    end
    object seNEpocas: TSpinEdit
      Left = 148
      Top = 14
      Width = 63
      Height = 22
      Increment = 500
      MaxValue = 20000
      MinValue = 100
      TabOrder = 1
      Value = 1000
    end
    object seAprendizagem: TSpinEdit
      Left = 148
      Top = 70
      Width = 63
      Height = 22
      MaxValue = 100
      MinValue = 0
      TabOrder = 2
      Value = 90
    end
    object seInercia: TSpinEdit
      Left = 148
      Top = 98
      Width = 63
      Height = 22
      MaxValue = 100
      MinValue = 0
      TabOrder = 3
      Value = 50
    end
    object edArquivo: TEdit
      Left = 148
      Top = 126
      Width = 91
      Height = 21
      TabOrder = 4
    end
  end
  object BitBtn1: TBitBtn
    Left = 71
    Top = 198
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 153
    Top = 198
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end
