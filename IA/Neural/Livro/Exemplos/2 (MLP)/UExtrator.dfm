object Form1: TForm1
  Left = 119
  Top = 75
  Width = 636
  Height = 474
  Caption = 'Extrator de D'#236'gitos para Programa OCR'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 14
    Top = 36
    Width = 419
    Height = 359
    Stretch = True
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
  end
  object Image2: TImage
    Left = 480
    Top = 70
    Width = 32
    Height = 32
  end
  object Label1: TLabel
    Left = 16
    Top = 20
    Width = 38
    Height = 13
    Caption = 'Amostra'
  end
  object Label2: TLabel
    Left = 478
    Top = 56
    Width = 33
    Height = 13
    Caption = 'Extrato'
  end
  object Label3: TLabel
    Left = 468
    Top = 126
    Width = 58
    Height = 13
    Caption = 'Centralizado'
  end
  object Image3: TImage
    Left = 480
    Top = 140
    Width = 32
    Height = 32
  end
  object Label4: TLabel
    Left = 444
    Top = 186
    Width = 82
    Height = 13
    Caption = 'Nome do Arquivo'
  end
  object EdNome: TEdit
    Left = 444
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 466
    Top = 238
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 411
    Width = 628
    Height = 36
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object BitBtn2: TBitBtn
    Left = 186
    Top = 6
    Width = 75
    Height = 25
    Caption = 'Carregar'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
end
