object fmFuzzy: TfmFuzzy
  Left = 387
  Top = 218
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Fuzzy Stock Management'
  ClientHeight = 396
  ClientWidth = 696
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  OnCreate = FormCreate
  DesignSize = (
    696
    396)
  PixelsPerInch = 96
  TextHeight = 13
  object bvlStock: TBevel
    Left = 480
    Top = 265
    Width = 209
    Height = 113
    Anchors = [akTop, akRight]
  end
  object bvlFAM: TBevel
    Left = 208
    Top = 49
    Width = 263
    Height = 329
    Anchors = [akLeft, akTop, akRight, akBottom]
  end
  object lblStockRealInput: TLabel
    Left = 31
    Top = 156
    Width = 55
    Height = 13
    Caption = 'Real Input :'
  end
  object lblDemandRealInput: TLabel
    Left = 31
    Top = 337
    Width = 55
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Real Input :'
  end
  object lblFAM: TLabel
    Left = 217
    Top = 39
    Width = 38
    Height = 20
    Caption = 'FAM'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDemand: TLabel
    Left = 213
    Top = 95
    Width = 40
    Height = 76
    AutoSize = False
    Caption = 'Demand'
    Layout = tlCenter
  end
  object lblStock: TLabel
    Left = 256
    Top = 79
    Width = 202
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Stock'
  end
  object gaugeStockLevel: TGauge
    Left = 608
    Top = 273
    Width = 60
    Height = 89
    Anchors = [akTop, akRight]
    BackColor = clSilver
    Color = clBlack
    ForeColor = clTeal
    Kind = gkVerticalBar
    ParentColor = False
    Progress = 75
  end
  object lblCompatibility: TLabel
    Left = 485
    Top = 208
    Width = 97
    Height = 20
    Anchors = [akTop, akRight]
    Caption = 'Compatibility :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Shape1: TShape
    Left = 0
    Top = 385
    Width = 635
    Height = 9
    Anchors = [akLeft, akRight, akBottom]
    Brush.Color = clNavy
    Pen.Color = clBtnFace
    Pen.Style = psClear
  end
  object Shape2: TShape
    Left = 634
    Top = 361
    Width = 9
    Height = 33
    Anchors = [akTop, akRight]
    Brush.Color = clNavy
    Pen.Color = clBtnFace
    Pen.Style = psClear
  end
  object Shape3: TShape
    Left = 0
    Top = 88
    Width = 9
    Height = 306
    Anchors = [akLeft, akTop, akBottom]
    Brush.Color = clNavy
    Pen.Color = clBtnFace
    Pen.Style = psClear
  end
  object Shape4: TShape
    Left = 0
    Top = 88
    Width = 17
    Height = 9
    Brush.Color = clNavy
    Pen.Color = clBtnFace
    Pen.Style = psClear
  end
  object MultiShapeArrow: TMultiShape
    Left = 13
    Top = 84
    Width = 18
    Height = 15
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Text = 'MultiShapeArrow'
    Angle = 0
    RepeatMode = rpNone
    ShapeType = msTriangle
    ShapeH = 15
    ShapeW = 18
    XMargin = 0
    YMargin = 0
    Border = False
    Shadow = False
  end
  object Label1: TLabel
    Left = 485
    Top = 170
    Width = 90
    Height = 20
    Caption = 'Real Output:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object EditStock: TEdit
    Left = 31
    Top = 172
    Width = 129
    Height = 21
    TabOrder = 0
    Text = '0'
    OnEnter = EditStockEnter
    OnExit = EditStockExit
  end
  object EditDemand: TEdit
    Left = 31
    Top = 353
    Width = 129
    Height = 21
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    Text = '0'
    OnEnter = EditStockEnter
    OnExit = EditStockExit
  end
  object gridFAM: TStringGrid
    Left = 257
    Top = 95
    Width = 209
    Height = 76
    Anchors = [akLeft, akTop, akRight]
    ColCount = 4
    DefaultColWidth = 50
    DefaultRowHeight = 17
    Enabled = False
    RowCount = 4
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goAlwaysShowEditor]
    ScrollBars = ssNone
    TabOrder = 2
    OnDrawCell = gridFAMDrawCell
    RowHeights = (
      17
      17
      17
      17)
  end
  object btnResult: TBitBtn
    Left = 323
    Top = 178
    Width = 75
    Height = 25
    Caption = '&Result --->'
    TabOrder = 3
    OnClick = bGetValueClick
  end
  object edCompatibility: TStaticText
    Left = 632
    Top = 208
    Width = 49
    Height = 19
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '0 '
    TabOrder = 4
  end
  object StaticTextStock1: TStaticText
    Left = 496
    Top = 297
    Width = 83
    Height = 40
    Anchors = [akTop, akRight]
    Caption = 'Stock'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Surreal-Bold'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object pnlInstruction: TPanel
    Left = 0
    Top = 0
    Width = 696
    Height = 25
    Align = alTop
    BevelInner = bvLowered
    Caption = 
      'How To Use: Click on the STOCK graph to fix a value, then fix th' +
      'e DEMAND and click many times on result...'
    TabOrder = 6
  end
  object FuzzyDemand: TFuzzyfication
    Left = 31
    Top = 233
    Width = 170
    Height = 100
    Hint = 'Demand'
    Anchors = [akLeft, akBottom]
    ShowHint = True
    OnChange = FuzzyDemandChange
    Maxi = 200.000000000000000000
    Mini = -20.000000000000000000
    Members = <
      item
        Color = 66
        Name = 'Low'
        MemberType = tmTriangle
        Middle = 40.000000000000000000
      end
      item
        Color = 132
        Name = 'Null'
        MemberType = tmTriangle
        StartMember = 40.000000000000000000
        Middle = 80.000000000000000000
      end
      item
        Color = 198
        Name = 'High'
        MemberType = tmTriangle
        StartMember = 80.000000000000000000
        Middle = 120.000000000000000000
      end>
    RealInput = 1.000000000000000000
  end
  object FuzzyStock: TFuzzyfication
    Left = 31
    Top = 48
    Width = 170
    Height = 100
    Hint = 'Stock'
    ShowHint = True
    OnChange = FuzzyStockChange
    Maxi = 110.000000000000000000
    Mini = -20.000000000000000000
    Members = <
      item
        Color = 66
        Name = 'Low'
        MemberType = tmLInfinity
        StartMember = -20.000000000000000000
      end
      item
        Color = 132
        Name = 'Null'
        MemberType = tmTriangle
        Middle = 50.000000000000000000
      end
      item
        Color = 198
        Name = 'High'
        MemberType = tmRInfinity
        StartMember = 50.000000000000000000
        Middle = 80.000000000000000000
      end>
  end
  object StaticTextStock2: TStaticText
    Left = 31
    Top = 26
    Width = 39
    Height = 20
    Caption = 'Stock'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Surreal-Bold'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    TabOrder = 9
  end
  object StaticTextDemand: TStaticText
    Left = 31
    Top = 208
    Width = 57
    Height = 20
    Anchors = [akLeft, akBottom]
    Caption = 'Demand'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Surreal-Bold'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    TabOrder = 10
  end
  object rbAverage: TRadioButton
    Left = 239
    Top = 229
    Width = 113
    Height = 17
    Caption = '&Average'
    Checked = True
    TabOrder = 11
    TabStop = True
    OnClick = rbAverageClick
  end
  object rbMax: TRadioButton
    Left = 239
    Top = 273
    Width = 113
    Height = 17
    Caption = '&Max'
    TabOrder = 13
    OnClick = rbAverageClick
  end
  object rbMin: TRadioButton
    Left = 239
    Top = 251
    Width = 113
    Height = 17
    Caption = 'Mi&n'
    TabOrder = 12
    OnClick = rbAverageClick
  end
  object edtRealOutput: TStaticText
    Left = 632
    Top = 172
    Width = 49
    Height = 19
    Alignment = taRightJustify
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '0 '
    TabOrder = 14
  end
end
