object frmFuzzyMotor: TfrmFuzzyMotor
  Left = 311
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Monitoramento Fuzzy de Motor'
  ClientHeight = 695
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 13
    Top = 142
    Width = 60
    Height = 13
    Caption = 'Entrada real:'
  end
  object Label3: TLabel
    Left = 408
    Top = 142
    Width = 60
    Height = 13
    Caption = 'Entrada real:'
  end
  object Bevel2: TBevel
    Left = 309
    Top = 749
    Width = 209
    Height = 113
  end
  object SpeedLevel: TGauge
    Left = 439
    Top = 757
    Width = 60
    Height = 89
    BackColor = clSilver
    Color = clBlack
    ForeColor = clTeal
    Kind = gkVerticalBar
    ParentColor = False
    Progress = 75
  end
  object Label2: TLabel
    Left = 314
    Top = 717
    Width = 97
    Height = 20
    Caption = 'Compatibility :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Bevel1: TGroupBox
    Left = 12
    Top = 192
    Width = 745
    Height = 341
    Caption = ' FAM '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    object Label5: TLabel
      Left = 10
      Top = 31
      Width = 86
      Height = 268
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Tens'#227'o (Volts)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 102
      Top = 15
      Width = 616
      Height = 13
      Alignment = taCenter
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'Velocidade (rad/s)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentFont = False
      Layout = tlCenter
    end
    object FAM: TStringGrid
      Left = 102
      Top = 31
      Width = 633
      Height = 268
      ColCount = 12
      DefaultColWidth = 50
      DefaultRowHeight = 21
      RowCount = 12
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 0
      OnDrawCell = FAMDrawCell
    end
    object bGetValue: TBitBtn
      Left = 370
      Top = 306
      Width = 79
      Height = 25
      Cursor = crHandPoint
      Caption = 'Resultado --->'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object edtSpeed: TEdit
    Left = 13
    Top = 157
    Width = 129
    Height = 21
    TabOrder = 0
    Text = '0'
    OnEnter = edtSpeedEnter
    OnExit = edtSpeedExit
  end
  object edtVoltage: TEdit
    Left = 408
    Top = 157
    Width = 129
    Height = 21
    TabOrder = 1
    Text = '0'
    OnEnter = edtSpeedEnter
    OnExit = edtVoltageExit
  end
  object edComp: TEdit
    Left = 461
    Top = 717
    Width = 49
    Height = 19
    Color = clBtnFace
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    Text = '0'
  end
  object StaticText1: TStaticText
    Left = 325
    Top = 781
    Width = 83
    Height = 40
    Caption = 'Stock'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Surreal-Bold'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object pnlFuzzySpeed: TPanel
    Left = 13
    Top = 8
    Width = 380
    Height = 133
    AutoSize = True
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    Caption = 'pnlFuzzySpeed'
    TabOrder = 4
    object FuzzySpeed: TzFuzzyfication
      Left = 4
      Top = 4
      Width = 372
      Height = 125
      OnChange = FuzzySpeedChange
      FuzzyName = 'Velocidade (rad/s)'
      FuzzyNameFont.Charset = DEFAULT_CHARSET
      FuzzyNameFont.Color = clWindowText
      FuzzyNameFont.Height = -11
      FuzzyNameFont.Name = 'MS Sans Serif'
      FuzzyNameFont.Style = [fsBold]
      FuzzyNameBrush.Color = clBtnFace
      XAxisColor = clRed
      CursorColor = clYellow
      Maxi = 143.000000000000000000
      Mini = -13.000000000000000000
      Members = <
        item
          Color = clBlack
          Name = 'MI'
          MemberType = tmLInfinity
          StartMember = -13.000000000000000000
          Middle = 5.000000000000000000
          EndMember = 13.000000000000000000
          Length = 0
        end
        item
          Color = clMaroon
          Name = 'MME'
          MemberType = tmTriangle
          Middle = 13.000000000000000000
          EndMember = 26.000000000000000000
          Length = 0
        end
        item
          Color = clGreen
          Name = 'MP'
          MemberType = tmTriangle
          StartMember = 13.000000000000000000
          Middle = 26.000000000000000000
          EndMember = 39.000000000000000000
          Length = 0
        end
        item
          Color = clOlive
          Name = '+/-P'
          MemberType = tmTriangle
          StartMember = 26.000000000000000000
          Middle = 39.000000000000000000
          EndMember = 52.000000000000000000
          Length = 0
        end
        item
          Color = clNavy
          Name = 'PP'
          MemberType = tmTriangle
          StartMember = 39.000000000000000000
          Middle = 52.000000000000000000
          EndMember = 65.000000000000000000
          Length = 0
        end
        item
          Color = clPurple
          Name = 'ME'
          MemberType = tmTriangle
          StartMember = 52.000000000000000000
          Middle = 65.000000000000000000
          EndMember = 78.000000000000000000
          Length = 0
        end
        item
          Color = clTeal
          Name = 'PG'
          MemberType = tmTriangle
          StartMember = 65.000000000000000000
          Middle = 78.000000000000000000
          EndMember = 91.000000000000000000
          Length = 0
        end
        item
          Color = clGray
          Name = '+/-G'
          MemberType = tmTriangle
          StartMember = 78.000000000000000000
          Middle = 91.000000000000000000
          EndMember = 104.000000000000000000
          Length = 0
        end
        item
          Color = clBlue
          Name = 'MG'
          MemberType = tmTriangle
          StartMember = 91.000000000000000000
          Middle = 104.000000000000000000
          EndMember = 117.000000000000000000
          Length = 0
        end
        item
          Color = 4210816
          Name = 'MMA'
          MemberType = tmTriangle
          StartMember = 104.000000000000000000
          Middle = 117.000000000000000000
          EndMember = 130.000000000000000000
          Length = 0
        end
        item
          Color = clFuchsia
          Name = 'MX'
          MemberType = tmRInfinity
          StartMember = 117.000000000000000000
          Middle = 130.000000000000000000
          EndMember = 143.000000000000000000
          Length = 0
        end>
    end
  end
  object Panel2: TPanel
    Left = 408
    Top = 8
    Width = 380
    Height = 133
    AutoSize = True
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 2
    Caption = 'Panel2'
    TabOrder = 5
    object FuzzyVoltage: TzFuzzyfication
      Left = 4
      Top = 4
      Width = 372
      Height = 125
      OnChange = FuzzyVoltageChange
      FuzzyName = 'Tens'#227'o (Volts)'
      FuzzyNameFont.Charset = DEFAULT_CHARSET
      FuzzyNameFont.Color = clWindowText
      FuzzyNameFont.Height = -11
      FuzzyNameFont.Name = 'MS Sans Serif'
      FuzzyNameFont.Style = [fsBold]
      FuzzyNameBrush.Color = clBtnFace
      XAxisColor = clRed
      CursorColor = clYellow
      Maxi = 270.000000000000000000
      Mini = -10.000000000000000000
      Members = <
        item
          Color = clBlack
          Name = 'MI'
          MemberType = tmLInfinity
          Middle = 20.000000000000000000
          EndMember = 42.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = 'MME'
          MemberType = tmTriangle
          StartMember = 20.000000000000000000
          Middle = 42.000000000000000000
          EndMember = 64.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = 'MP'
          MemberType = tmTriangle
          StartMember = 42.000000000000000000
          Middle = 64.000000000000000000
          EndMember = 86.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = '+/-P'
          MemberType = tmTriangle
          StartMember = 64.000000000000000000
          Middle = 86.000000000000000000
          EndMember = 108.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = 'PP'
          MemberType = tmTriangle
          StartMember = 86.000000000000000000
          Middle = 108.000000000000000000
          EndMember = 130.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = 'ME'
          MemberType = tmTriangle
          StartMember = 108.000000000000000000
          Middle = 130.000000000000000000
          EndMember = 152.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = 'PG'
          MemberType = tmTriangle
          StartMember = 130.000000000000000000
          Middle = 152.000000000000000000
          EndMember = 174.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = '+/-G'
          MemberType = tmTriangle
          StartMember = 152.000000000000000000
          Middle = 174.000000000000000000
          EndMember = 196.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = 'MG'
          MemberType = tmTriangle
          StartMember = 174.000000000000000000
          Middle = 196.000000000000000000
          EndMember = 218.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = 'MMA'
          MemberType = tmTriangle
          StartMember = 196.000000000000000000
          Middle = 218.000000000000000000
          EndMember = 240.000000000000000000
          Length = 0
        end
        item
          Color = clBlack
          Name = 'MX'
          MemberType = tmRInfinity
          StartMember = 218.000000000000000000
          Middle = 240.000000000000000000
          EndMember = 250.000000000000000000
          Length = 0
        end>
    end
  end
end
