object FrmPoker: TFrmPoker
  Left = 378
  Top = 186
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 251
  ClientWidth = 536
  Color = clGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWhite
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlJogo3: TPanel
    Left = 436
    Top = 42
    Width = 100
    Height = 209
    Align = alRight
    BevelOuter = bvNone
    Caption = ' '
    Color = clGreen
    TabOrder = 0
    object imgCard6: TImage
      Left = 14
      Top = 33
      Width = 72
      Height = 96
      Cursor = crHandPoint
      OnClick = btnTrocaClick
    end
    object btnTroca: TSpeedButton
      Left = 9
      Top = 161
      Width = 81
      Height = 32
      Cursor = crHandPoint
      Caption = 'Troca'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnTrocaClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 42
    Width = 436
    Height = 209
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object pnlJogo2: TPanel
      Left = 0
      Top = 0
      Width = 436
      Height = 209
      Align = alClient
      BevelOuter = bvNone
      Color = clGreen
      TabOrder = 1
      object btnMenos10: TSpeedButton
        Tag = -10
        Left = 33
        Top = 169
        Width = 48
        Height = 32
        Caption = '-10'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMenos10Click
      end
      object btnMais10: TSpeedButton
        Tag = 10
        Left = 89
        Top = 169
        Width = 48
        Height = 32
        Caption = '+10'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMenos10Click
      end
      object btnMenos50: TSpeedButton
        Tag = -50
        Left = 145
        Top = 169
        Width = 48
        Height = 32
        Caption = '-50'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMenos10Click
      end
      object btnMais50: TSpeedButton
        Tag = 50
        Left = 201
        Top = 169
        Width = 48
        Height = 32
        Caption = '+50'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMenos10Click
      end
      object btnMenos100: TSpeedButton
        Tag = -100
        Left = 257
        Top = 169
        Width = 48
        Height = 32
        Caption = '-100'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMenos10Click
      end
      object btnMais100: TSpeedButton
        Tag = 100
        Left = 314
        Top = 169
        Width = 48
        Height = 32
        Caption = '+100'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnMenos10Click
      end
      object lblNoGame1: TLabel
        Left = 110
        Top = 1
        Width = 117
        Height = 13
        Caption = 'One Pair (J, Q, K, A)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNoGame2: TLabel
        Left = 110
        Top = 18
        Width = 51
        Height = 13
        Caption = 'Two Pair'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNoGame3: TLabel
        Left = 110
        Top = 36
        Width = 89
        Height = 13
        Caption = 'Three of a Kind'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNoGame4: TLabel
        Left = 110
        Top = 53
        Width = 31
        Height = 13
        Caption = 'Strait'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNoGame5: TLabel
        Left = 110
        Top = 71
        Width = 31
        Height = 13
        Caption = 'Flush'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNoGame6: TLabel
        Left = 110
        Top = 89
        Width = 61
        Height = 13
        Caption = 'Full House'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNoGame7: TLabel
        Left = 110
        Top = 106
        Width = 81
        Height = 13
        Caption = 'Four of a Kind'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNoGame8: TLabel
        Left = 110
        Top = 124
        Width = 65
        Height = 13
        Caption = 'Strait Flush'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 110
        Top = 142
        Width = 101
        Height = 13
        Caption = 'Royal Strait Flush'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValGame1: TLabel
        Left = 237
        Top = 1
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lblValGame1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValGame2: TLabel
        Left = 237
        Top = 18
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lblValGame2'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValGame3: TLabel
        Left = 237
        Top = 36
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lblValGame3'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValGame4: TLabel
        Left = 237
        Top = 53
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lblValGame4'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValGame5: TLabel
        Left = 237
        Top = 71
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lblValGame5'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValGame6: TLabel
        Left = 237
        Top = 89
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lblValGame6'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValGame7: TLabel
        Left = 237
        Top = 106
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lblValGame7'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValGame8: TLabel
        Left = 237
        Top = 124
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lblValGame8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblValGame9: TLabel
        Left = 237
        Top = 142
        Width = 71
        Height = 13
        Alignment = taRightJustify
        Caption = 'lblValGame9'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlJogo1: TPanel
      Left = 0
      Top = 0
      Width = 436
      Height = 209
      Align = alClient
      BevelOuter = bvNone
      Color = clGreen
      TabOrder = 0
      object lblCard1: TLabel
        Left = 4
        Top = 19
        Width = 76
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'lblCard1'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCard2: TLabel
        Left = 93
        Top = 19
        Width = 76
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'lblCard2'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCard3: TLabel
        Left = 182
        Top = 19
        Width = 76
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'lblCard3'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCard4: TLabel
        Left = 271
        Top = 19
        Width = 76
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'lblCard4'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCard5: TLabel
        Left = 361
        Top = 19
        Width = 76
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'lblCard5'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnTroca1: TSpeedButton
        Left = 6
        Top = 132
        Width = 72
        Height = 32
        Cursor = crHandPoint
        AllowAllUp = True
        Caption = 'Troca'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTroca1Click
      end
      object btnTroca2: TSpeedButton
        Left = 95
        Top = 132
        Width = 72
        Height = 32
        Cursor = crHandPoint
        AllowAllUp = True
        Caption = 'Troca'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTroca1Click
      end
      object btnTroca3: TSpeedButton
        Left = 184
        Top = 132
        Width = 72
        Height = 32
        Cursor = crHandPoint
        AllowAllUp = True
        Caption = 'Troca'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTroca1Click
      end
      object btnTroca4: TSpeedButton
        Left = 273
        Top = 132
        Width = 72
        Height = 32
        Cursor = crHandPoint
        AllowAllUp = True
        Caption = 'Troca'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTroca1Click
      end
      object btnTroca5: TSpeedButton
        Left = 363
        Top = 132
        Width = 72
        Height = 32
        Cursor = crHandPoint
        AllowAllUp = True
        Caption = 'Troca'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTroca1Click
      end
      object btnTrocaTodas: TSpeedButton
        Left = 99
        Top = 169
        Width = 94
        Height = 32
        Cursor = crHandPoint
        Caption = 'Troca Todas'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnTrocaTodasClick
      end
      object imgCard1: TImage
        Left = 6
        Top = 33
        Width = 72
        Height = 96
        Cursor = crHandPoint
        OnClick = imgCard1Click
      end
      object imgCard2: TImage
        Left = 95
        Top = 33
        Width = 72
        Height = 96
        Cursor = crHandPoint
        OnClick = imgCard2Click
      end
      object imgCard3: TImage
        Left = 184
        Top = 33
        Width = 72
        Height = 96
        Cursor = crHandPoint
        OnClick = imgCard3Click
      end
      object imgCard4: TImage
        Left = 273
        Top = 33
        Width = 72
        Height = 96
        Cursor = crHandPoint
        OnClick = imgCard4Click
      end
      object imgCard5: TImage
        Left = 363
        Top = 33
        Width = 72
        Height = 96
        Cursor = crHandPoint
        OnClick = imgCard5Click
      end
      object btnInverteSelecao: TSpeedButton
        Left = 202
        Top = 169
        Width = 94
        Height = 32
        Caption = 'Inverte sele'#231#227'o'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = btnInverteSelecaoClick
      end
      object lblResult: TLabel
        Left = 9
        Top = 1
        Width = 49
        Height = 15
        Caption = 'lblResult'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object Score: TPanel
    Left = 0
    Top = 0
    Width = 536
    Height = 42
    Align = alTop
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Color = clGreen
    TabOrder = 2
    object lblSaldo2: TLabel
      Left = 53
      Top = 2
      Width = 52
      Height = 15
      Caption = 'lblSaldo2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAposta2: TLabel
      Left = 53
      Top = 23
      Width = 60
      Height = 15
      Caption = 'lblAposta2'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSaldo1: TLabel
      Left = 6
      Top = 2
      Width = 35
      Height = 15
      Caption = 'Saldo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAposta1: TLabel
      Left = 6
      Top = 23
      Width = 43
      Height = 15
      Caption = 'Aposta:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
