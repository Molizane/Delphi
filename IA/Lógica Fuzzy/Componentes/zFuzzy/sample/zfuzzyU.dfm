object fmFuzzy: TfmFuzzy
  Left = 85
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Fuzzy Stock Management (Z)'
  ClientHeight = 371
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    870
    371)
  PixelsPerInch = 96
  TextHeight = 13
  object Shape4: TMultiShape
    Left = 3
    Top = 64
    Width = 15
    Height = 11
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Angle = 0
    RepeatMode = rpNone
    ShapeType = msRectangle
    ShapeH = 9
    ShapeW = 13
    XMargin = 0
    YMargin = 0
    Border = False
    Shadow = True
  end
  object Bevel2: TBevel
    Left = 657
    Top = 240
    Width = 209
    Height = 113
    Anchors = [akTop, akRight]
  end
  object Label1: TLabel
    Left = 35
    Top = 136
    Width = 55
    Height = 13
    Caption = 'Real Input :'
  end
  object Label3: TLabel
    Left = 313
    Top = 136
    Width = 55
    Height = 13
    Caption = 'Real Input :'
  end
  object StockLevel: TGauge
    Left = 787
    Top = 248
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
  object Label2: TLabel
    Left = 662
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
  object MultiShape1: TMultiShape
    Left = 16
    Top = 61
    Width = 20
    Height = 17
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Text = 'MultiShape1'
    Angle = 0
    RepeatMode = rpNone
    ShapeType = msTriangle
    ShapeH = 15
    ShapeW = 18
    XMargin = 0
    YMargin = 0
    Border = False
    Shadow = True
  end
  object Shape3: TMultiShape
    Left = 3
    Top = 73
    Width = 11
    Height = 289
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Angle = 0
    RepeatMode = rpNone
    ShapeType = msRectangle
    ShapeH = 287
    ShapeW = 9
    XMargin = 0
    YMargin = 0
    Border = False
    Shadow = True
  end
  object Shape1: TMultiShape
    Left = 3
    Top = 360
    Width = 812
    Height = 11
    Anchors = [akLeft, akTop, akRight]
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Angle = 0
    RepeatMode = rpNone
    ShapeType = msRectangle
    ShapeH = 9
    ShapeW = 810
    XMargin = 0
    YMargin = 0
    Border = False
    Shadow = True
  end
  object Shape2: TMultiShape
    Left = 813
    Top = 336
    Width = 11
    Height = 35
    Anchors = [akTop, akRight]
    Color = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Angle = 0
    RepeatMode = rpNone
    ShapeType = msRectangle
    ShapeH = 33
    ShapeW = 9
    XMargin = 0
    YMargin = 0
    Border = False
    Shadow = True
  end
  object Edit1: TEdit
    Left = 35
    Top = 152
    Width = 129
    Height = 21
    TabOrder = 0
    Text = '0'
    OnEnter = Edit1Enter
    OnExit = Edit1Exit
  end
  object Edit3: TEdit
    Left = 313
    Top = 152
    Width = 129
    Height = 21
    TabOrder = 1
    Text = '0'
    OnEnter = Edit1Enter
    OnExit = Edit3Exit
  end
  object edComp: TStaticText
    Left = 776
    Top = 211
    Width = 43
    Height = 17
    Alignment = taRightJustify
    Anchors = [akTop, akRight]
    AutoSize = False
    BorderStyle = sbsSingle
    Caption = '0 '
    TabOrder = 2
  end
  object StaticText1: TStaticText
    Left = 673
    Top = 272
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
    TabOrder = 3
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 870
    Height = 25
    Align = alTop
    BevelInner = bvLowered
    Caption = 
      'How To Use : Click on the STOCK graph to fix a value, then fix t' +
      'he DEMAND and click many times on result...'
    TabOrder = 4
  end
  object FuzzyDemand: TzFuzzyfication
    Left = 313
    Top = 32
    Width = 269
    Height = 100
    OnChange = FuzzyDemandChange
    FuzzyName = 'Demand'
    FuzzyNameFont.Charset = DEFAULT_CHARSET
    FuzzyNameFont.Color = clWindowText
    FuzzyNameFont.Height = -11
    FuzzyNameFont.Name = 'MS Sans Serif'
    FuzzyNameFont.Style = [fsBold]
    FuzzyNameBrush.Color = clBtnFace
    XAxisColor = clRed
    CursorColor = clYellow
    Maxi = 200.000000000000000000
    Mini = -20.000000000000000000
    Members = <
      item
        Color = 66
        Name = 'Low'
        MemberType = tmTriangle
        Middle = 40.000000000000000000
        EndMember = 80.000000000000000000
        Length = 0
      end
      item
        Color = 132
        Name = 'Nul'
        MemberType = tmTriangle
        StartMember = 40.000000000000000000
        Middle = 80.000000000000000000
        EndMember = 120.000000000000000000
        Length = 0
      end
      item
        Color = 198
        Name = 'Important'
        MemberType = tmTriangle
        StartMember = 80.000000000000000000
        Middle = 120.000000000000000000
        EndMember = 160.000000000000000000
        Length = 0
      end>
  end
  object FuzzyStock: TzFuzzyfication
    Left = 35
    Top = 32
    Width = 269
    Height = 100
    OnChange = FuzzyStockChange
    FuzzyName = 'Stock'
    FuzzyNameFont.Charset = DEFAULT_CHARSET
    FuzzyNameFont.Color = clWindowText
    FuzzyNameFont.Height = -11
    FuzzyNameFont.Name = 'MS Sans Serif'
    FuzzyNameFont.Style = [fsBold]
    FuzzyNameBrush.Color = clBtnFace
    XAxisColor = clRed
    CursorColor = clYellow
    Maxi = 110.000000000000000000
    Mini = -20.000000000000000000
    Members = <
      item
        Color = 66
        Name = 'Low'
        MemberType = tmLInfinity
        StartMember = -20.000000000000000000
        Middle = 5.000000000000000000
        EndMember = 20.000000000000000000
        Length = 0
      end
      item
        Color = 132
        Name = 'Nul'
        MemberType = tmTriangle
        Middle = 50.000000000000000000
        EndMember = 100.000000000000000000
        Length = 0
      end
      item
        Color = 198
        Name = 'Important'
        MemberType = tmRInfinity
        StartMember = 50.000000000000000000
        Middle = 80.000000000000000000
        EndMember = 110.000000000000000000
        Length = 0
      end>
  end
  object Bevel1: TGroupBox
    Left = 300
    Top = 181
    Width = 269
    Height = 171
    Caption = ' FAM '
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 7
    object Label5: TLabel
      Left = 8
      Top = 34
      Width = 40
      Height = 91
      AutoSize = False
      Caption = 'Demand'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 52
      Top = 18
      Width = 208
      Height = 13
      Alignment = taCenter
      AutoSize = False
      BiDiMode = bdLeftToRight
      Caption = 'Stock'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBiDiMode = False
      ParentFont = False
      Layout = tlCenter
    end
    object FAM: TStringGrid
      Left = 52
      Top = 34
      Width = 205
      Height = 89
      ColCount = 4
      DefaultColWidth = 50
      DefaultRowHeight = 21
      RowCount = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 0
      ColWidths = (
        50
        50
        50
        50)
      RowHeights = (
        21
        21
        21
        21)
    end
    object BitBtn1: TBitBtn
      Left = 97
      Top = 137
      Width = 75
      Height = 25
      Caption = 'Result --->'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = bGetValueClick
    end
  end
end
