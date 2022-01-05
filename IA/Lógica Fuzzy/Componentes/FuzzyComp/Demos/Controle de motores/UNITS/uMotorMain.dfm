object Form1: TForm1
  Left = 369
  Top = 265
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Controle de velocidade de motores'
  ClientHeight = 503
  ClientWidth = 998
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 569
    Top = 7
    Width = 375
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Ve(d)'
  end
  object Label2: TLabel
    Left = 537
    Top = 21
    Width = 32
    Height = 267
    AutoSize = False
    Caption = 'Va(p)'
    Layout = tlCenter
  end
  object Label3: TLabel
    Left = 607
    Top = 450
    Width = 209
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0.00 V'
  end
  object Label4: TLabel
    Left = 17
    Top = 228
    Width = 31
    Height = 13
    Caption = 'Va(p)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 17
    Top = 3
    Width = 31
    Height = 13
    Caption = 'Ve(p)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object lblVelocidade1: TLabel
    Left = 17
    Top = 155
    Width = 44
    Height = 13
    Caption = 'Valor=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensao1: TLabel
    Left = 16
    Top = 381
    Width = 44
    Height = 13
    Caption = 'Valor=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 74
    Top = 3
    Width = 87
    Height = 13
    Caption = 'Velocidade (rad/s)'
  end
  object Label7: TLabel
    Left = 73
    Top = 228
    Width = 68
    Height = 13
    Caption = 'Tens'#227'o (Volts)'
  end
  object Label8: TLabel
    Left = 531
    Top = 296
    Width = 31
    Height = 13
    Caption = 'Ve(d)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 586
    Top = 296
    Width = 131
    Height = 13
    Caption = 'Acr'#233'scimo de tens'#227'o (Volts)'
  end
  object lblVelocidadeMI: TLabel
    Left = 17
    Top = 171
    Width = 29
    Height = 13
    Caption = 'MI=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadeMME: TLabel
    Left = 17
    Top = 190
    Width = 43
    Height = 13
    Caption = 'MME=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadeMP: TLabel
    Left = 94
    Top = 171
    Width = 33
    Height = 13
    Caption = 'MP=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadeMMP: TLabel
    Left = 94
    Top = 190
    Width = 40
    Height = 13
    Caption = '+/-P=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadePP: TLabel
    Left = 172
    Top = 171
    Width = 31
    Height = 13
    Caption = 'PP=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadeME: TLabel
    Left = 172
    Top = 190
    Width = 33
    Height = 13
    Caption = 'ME=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadePG: TLabel
    Left = 250
    Top = 171
    Width = 32
    Height = 13
    Caption = 'PG=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadeMMG: TLabel
    Left = 250
    Top = 190
    Width = 41
    Height = 13
    Caption = '+/-G=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadeMG: TLabel
    Left = 328
    Top = 171
    Width = 34
    Height = 13
    Caption = 'MG=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadeMMA: TLabel
    Left = 328
    Top = 190
    Width = 43
    Height = 13
    Caption = 'MMA=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVelocidadeMX: TLabel
    Left = 406
    Top = 171
    Width = 33
    Height = 13
    Caption = 'MX=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoMI: TLabel
    Left = 17
    Top = 398
    Width = 29
    Height = 13
    Caption = 'MI=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoMME: TLabel
    Left = 17
    Top = 415
    Width = 43
    Height = 13
    Caption = 'MME=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoMP: TLabel
    Left = 94
    Top = 398
    Width = 33
    Height = 13
    Caption = 'MP=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoMMP: TLabel
    Left = 94
    Top = 415
    Width = 40
    Height = 13
    Caption = '+/-P=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoPP: TLabel
    Left = 172
    Top = 398
    Width = 31
    Height = 13
    Caption = 'PP=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoME: TLabel
    Left = 172
    Top = 415
    Width = 33
    Height = 13
    Caption = 'ME=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoPG: TLabel
    Left = 250
    Top = 398
    Width = 32
    Height = 13
    Caption = 'PG=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoMMG: TLabel
    Left = 250
    Top = 415
    Width = 41
    Height = 13
    Caption = '+/-G=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoMG: TLabel
    Left = 328
    Top = 398
    Width = 34
    Height = 13
    Caption = 'MG=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoMMA: TLabel
    Left = 328
    Top = 415
    Width = 43
    Height = 13
    Caption = 'MMA=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTensaoMX: TLabel
    Left = 406
    Top = 398
    Width = 33
    Height = 13
    Caption = 'MX=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object FuzzyVelocidade: TFuzzyfication
    Left = 17
    Top = 20
    Width = 450
    Height = 131
    OnChange = FuzzyVelocidadeChange
    Maxi = 143.000000000000000000
    Mini = -13.000000000000000000
    Members = <
      item
        Color = clBlack
        Name = 'MI'
        MemberType = tmLInfinity
        StartMember = -13.000000000000000000
      end
      item
        Color = clMaroon
        Name = 'MME'
        MemberType = tmTriangle
        Middle = 13.000000000000000000
      end
      item
        Color = clGreen
        Name = 'MP'
        MemberType = tmTriangle
        StartMember = 13.000000000000000000
        Middle = 26.000000000000000000
      end
      item
        Color = clNavy
        Name = '+/-P'
        MemberType = tmTriangle
        StartMember = 26.000000000000000000
        Middle = 39.000000000000000000
      end
      item
        Color = clPurple
        Name = 'PP'
        MemberType = tmTriangle
        StartMember = 39.000000000000000000
        Middle = 52.000000000000000000
      end
      item
        Color = clTeal
        Name = 'ME'
        MemberType = tmTriangle
        StartMember = 52.000000000000000000
        Middle = 65.000000000000000000
      end
      item
        Color = clGray
        Name = 'PG'
        MemberType = tmTriangle
        StartMember = 65.000000000000000000
        Middle = 78.000000000000000000
      end
      item
        Color = clRed
        Name = '+/-G'
        MemberType = tmTriangle
        StartMember = 78.000000000000000000
        Middle = 91.000000000000000000
      end
      item
        Color = clLime
        Name = 'MG'
        MemberType = tmTriangle
        StartMember = 91.000000000000000000
        Middle = 104.000000000000000000
      end
      item
        Color = clOlive
        Name = 'MMA'
        MemberType = tmTriangle
        StartMember = 104.000000000000000000
        Middle = 117.000000000000000000
      end
      item
        Color = clBlue
        Name = 'MX'
        MemberType = tmRInfinity
        StartMember = 117.000000000000000000
        Middle = 130.000000000000000000
      end>
  end
  object FuzzyTensao: TFuzzyfication
    Left = 17
    Top = 244
    Width = 450
    Height = 131
    OnChange = FuzzyTensaoChange
    Maxi = 266.000000000000000000
    Mini = -2.000000000000000000
    Members = <
      item
        Color = clBlack
        Name = 'MI'
        MemberType = tmLInfinity
        StartMember = -2.000000000000000000
        Middle = 20.000000000000000000
      end
      item
        Color = clMaroon
        Name = 'MME'
        MemberType = tmTriangle
        StartMember = 20.000000000000000000
        Middle = 42.000000000000000000
      end
      item
        Color = clGreen
        Name = 'MP'
        MemberType = tmTriangle
        StartMember = 42.000000000000000000
        Middle = 64.000000000000000000
      end
      item
        Color = clNavy
        Name = '+/-P'
        MemberType = tmTriangle
        StartMember = 64.000000000000000000
        Middle = 86.000000000000000000
      end
      item
        Color = clPurple
        Name = 'PP'
        MemberType = tmTriangle
        StartMember = 86.000000000000000000
        Middle = 108.000000000000000000
      end
      item
        Color = clTeal
        Name = 'ME'
        MemberType = tmTriangle
        StartMember = 108.000000000000000000
        Middle = 130.000000000000000000
      end
      item
        Color = clGray
        Name = 'PG'
        MemberType = tmTriangle
        StartMember = 130.000000000000000000
        Middle = 152.000000000000000000
      end
      item
        Color = clRed
        Name = '+/-G'
        MemberType = tmTriangle
        StartMember = 152.000000000000000000
        Middle = 174.000000000000000000
      end
      item
        Color = clLime
        Name = 'MG'
        MemberType = tmTriangle
        StartMember = 174.000000000000000000
        Middle = 196.000000000000000000
      end
      item
        Color = clOlive
        Name = 'MMA'
        MemberType = tmTriangle
        StartMember = 196.000000000000000000
        Middle = 218.000000000000000000
      end
      item
        Color = clBlue
        Name = 'MX'
        MemberType = tmRInfinity
        StartMember = 218.000000000000000000
        Middle = 240.000000000000000000
      end>
    RealInput = 20.000000000000000000
  end
  object FuzzySolution: TFuzzySolution
    Left = 531
    Top = 312
    Width = 450
    Height = 131
    Maxi = 264.000000000000000000
    Mini = -24.000000000000000000
    Members = <
      item
        Color = clBlack
        Name = 'MI'
        MemberType = tmLInfinity
        StartMember = -24.000000000000000000
      end
      item
        Color = clMaroon
        Name = 'MME'
        MemberType = tmTriangle
        Middle = 24.000000000000000000
      end
      item
        Color = clGreen
        Name = 'MP'
        MemberType = tmTriangle
        StartMember = 24.000000000000000000
        Middle = 48.000000000000000000
      end
      item
        Color = clNavy
        Name = '+/-P'
        MemberType = tmTriangle
        StartMember = 48.000000000000000000
        Middle = 72.000000000000000000
      end
      item
        Color = clPurple
        Name = 'PP'
        MemberType = tmTriangle
        StartMember = 72.000000000000000000
        Middle = 96.000000000000000000
      end
      item
        Color = clTeal
        Name = 'ME'
        MemberType = tmTriangle
        StartMember = 96.000000000000000000
        Middle = 120.000000000000000000
      end
      item
        Color = clGray
        Name = 'PG'
        MemberType = tmTriangle
        StartMember = 120.000000000000000000
        Middle = 144.000000000000000000
      end
      item
        Color = clRed
        Name = '+/-G'
        MemberType = tmTriangle
        StartMember = 144.000000000000000000
        Middle = 168.000000000000000000
      end
      item
        Color = clLime
        Name = 'MG'
        MemberType = tmTriangle
        StartMember = 168.000000000000000000
        Middle = 192.000000000000000000
      end
      item
        Color = clOlive
        Name = 'MMA'
        MemberType = tmTriangle
        StartMember = 192.000000000000000000
        Middle = 216.000000000000000000
      end
      item
        Color = clBlue
        Name = 'MX'
        MemberType = tmRInfinity
        StartMember = 216.000000000000000000
        Middle = 240.000000000000000000
      end>
    DeltaX = 1.000000000000000000
  end
  object GridFuzzy: TStringGrid
    Left = 569
    Top = 21
    Width = 375
    Height = 267
    ColCount = 12
    DefaultColWidth = 30
    DefaultRowHeight = 21
    Enabled = False
    RowCount = 12
    TabOrder = 3
    OnDrawCell = GridFuzzyDrawCell
  end
  object btnResult: TButton
    Left = 172
    Top = 453
    Width = 75
    Height = 25
    Caption = 'Resultado -->'
    TabOrder = 4
    OnClick = btnResultClick
  end
  object rbAverage: TRadioButton
    Left = 16
    Top = 450
    Width = 113
    Height = 17
    Caption = '&Average'
    TabOrder = 5
  end
  object rbMin: TRadioButton
    Left = 16
    Top = 472
    Width = 113
    Height = 17
    Caption = '&Min'
    Checked = True
    TabOrder = 6
    TabStop = True
  end
  object AlignEdit1: TAlignEdit
    Left = 475
    Top = 20
    Width = 83
    Height = 21
    TabOrder = 7
    OnEnter = AlignEdit1Enter
    OnExit = AlignEdit1Exit
    Alignment = taRightJustify
    EnterColor = 12189695
    EnterFontColor = clBlack
    IsNumber = True
    ReturnIsTab = True
  end
  object AlignEdit2: TAlignEdit
    Left = 475
    Top = 244
    Width = 83
    Height = 21
    TabOrder = 8
    OnEnter = AlignEdit1Enter
    OnExit = AlignEdit2Exit
    Alignment = taRightJustify
    EnterColor = 12189695
    EnterFontColor = clBlack
    IsNumber = True
    ReturnIsTab = True
  end
end
