object Form1: TForm1
  Left = 253
  Top = 72
  Width = 697
  Height = 610
  Caption = 'Novo Neurônio'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 336
    Top = 368
    Width = 17
    Height = 209
    Style = bsRaised
  end
  object Label2: TLabel
    Left = 80
    Top = 360
    Width = 54
    Height = 13
    Caption = 'Excitatórios'
  end
  object Label1: TLabel
    Left = 416
    Top = 360
    Width = 44
    Height = 13
    Caption = 'Inibitórios'
  end
  object BBStart: TBitBtn
    Left = 253
    Top = 550
    Width = 60
    Height = 20
    Caption = 'Início'
    TabOrder = 0
    OnClick = BBStartClick
  end
  inline FGraPot: TFGra
    Width = 689
    Height = 157
    Align = alTop
    TabOrder = 1
    inherited GB: TGroupBox
      Width = 689
      Height = 157
      inherited Img: TImage
        Width = 685
        Height = 140
      end
      inherited SBCopy: TSpeedButton
        Left = 208
        Width = 19
        Height = 18
      end
      inherited SBCorFre: TSpeedButton
        Left = 150
        Width = 18
        Height = 18
      end
      inherited SBCorFun: TSpeedButton
        Left = 176
        Width = 18
        Height = 18
      end
    end
  end
  inline GauFre: TFrRegua
    Top = 384
    Width = 299
    Height = 52
    TabOrder = 2
    inherited GBRegua: TGroupBox
      Width = 299
      Height = 52
      Caption = 'Freqüência'
      inherited TBRegua: TTrackBar
        Width = 295
        Height = 35
        Max = 50
        Position = 27
      end
    end
  end
  inline GauInt: TFrRegua
    Top = 436
    Width = 300
    Height = 53
    TabOrder = 3
    inherited GBRegua: TGroupBox
      Width = 300
      Height = 53
      Caption = 'Intensidade'
      inherited TBRegua: TTrackBar
        Width = 296
        Height = 36
        Max = 20
        Position = 10
      end
    end
  end
  inline GauDt: TFrRegua
    Top = 498
    Width = 300
    Height = 45
    TabOrder = 4
    inherited GBRegua: TGroupBox
      Width = 300
      Height = 45
      Caption = 'Dt'
      inherited TBRegua: TTrackBar
        Width = 296
        Height = 28
        Max = 20
        Min = 2
        Position = 10
      end
    end
  end
  inline FGraDisp: TFGra
    Top = 157
    Width = 689
    Height = 97
    Align = alTop
    TabOrder = 5
    inherited GB: TGroupBox
      Width = 689
      Height = 97
      inherited Img: TImage
        Width = 685
        Height = 80
      end
      inherited SBCopy: TSpeedButton
        Left = 208
        Width = 19
        Height = 18
      end
      inherited SBCorFre: TSpeedButton
        Left = 150
        Width = 18
        Height = 18
      end
      inherited SBCorFun: TSpeedButton
        Left = 176
        Width = 18
        Height = 18
      end
    end
  end
  inline FGraPotDisp: TFGra
    Top = 254
    Width = 689
    Height = 98
    Align = alTop
    TabOrder = 6
    inherited GB: TGroupBox
      Width = 689
      Height = 98
      inherited Img: TImage
        Width = 685
        Height = 81
      end
      inherited SBCopy: TSpeedButton
        Left = 208
        Width = 19
        Height = 18
      end
      inherited SBCorFre: TSpeedButton
        Left = 150
        Width = 18
        Height = 18
      end
      inherited SBCorFun: TSpeedButton
        Left = 176
        Width = 18
        Height = 18
      end
    end
  end
  inline GauIniFre: TFrRegua
    Left = 360
    Top = 392
    Width = 329
    Height = 57
    TabOrder = 7
    inherited GBRegua: TGroupBox
      Width = 329
      Height = 57
      inherited TBRegua: TTrackBar
        Width = 325
        Height = 40
        Max = 100
        Position = 22
      end
    end
  end
  inline GauIniInt: TFrRegua
    Left = 360
    Top = 456
    Width = 329
    Height = 49
    TabOrder = 8
    inherited GBRegua: TGroupBox
      Width = 329
      Height = 49
      inherited TBRegua: TTrackBar
        Width = 325
        Height = 32
        Max = 40
        Position = 9
      end
    end
  end
  object CBSempre: TCheckBox
    Left = 432
    Top = 520
    Width = 97
    Height = 17
    Caption = 'Sempre'
    TabOrder = 9
  end
end
