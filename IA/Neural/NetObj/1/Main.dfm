object MainForm: TMainForm
  Left = 269
  Top = 267
  Width = 808
  Height = 430
  Caption = 'Handwritten symbols recognition'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 425
    Height = 403
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object PaintBox: TImage
      Left = 10
      Top = 10
      Width = 256
      Height = 256
      OnMouseDown = PaintBoxMouseDown
      OnMouseMove = PaintBoxMouseMove
      OnMouseUp = PaintBoxMouseUp
    end
    object Panels: TNotebook
      Left = 10
      Top = 272
      Width = 256
      Height = 41
      TabOrder = 0
      object TPage
        Left = 0
        Top = 0
        Caption = 'Empty'
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'Identify'
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 256
          Height = 41
          Align = alClient
          Alignment = taCenter
          Caption = 'Processing...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
        end
      end
      object TPage
        Left = 0
        Top = 0
        Caption = 'AddPattern'
        object Label2: TLabel
          Left = 5
          Top = 4
          Width = 64
          Height = 13
          Caption = 'Pattern count'
        end
        object PatternLabel: TLabel
          Left = 77
          Top = 4
          Width = 6
          Height = 13
          Caption = '0'
        end
      end
    end
    object ClearBtn: TButton
      Left = 10
      Top = 352
      Width = 256
      Height = 28
      Caption = 'Clear paintbox'
      TabOrder = 1
      OnClick = ClearBtnClick
    end
    object IdentifyBtn: TButton
      Left = 139
      Top = 320
      Width = 127
      Height = 25
      Caption = 'Recognize'
      Enabled = False
      TabOrder = 2
      OnClick = IdentifyBtnClick
    end
    object AddPatternBtn: TButton
      Left = 10
      Top = 320
      Width = 129
      Height = 25
      Caption = 'Add to the training data...'
      Enabled = False
      TabOrder = 3
      OnClick = AddPatternBtnClick
    end
    object TrainPanel: TPanel
      Left = 280
      Top = 258
      Width = 137
      Height = 122
      BevelInner = bvLowered
      TabOrder = 4
      Visible = False
      object Label4: TLabel
        Left = 5
        Top = 26
        Width = 38
        Height = 13
        Caption = 'Iteration'
      end
      object Label3: TLabel
        Left = 5
        Top = 49
        Width = 22
        Height = 13
        Caption = 'Error'
      end
      object ErrorLabel: TLabel
        Left = 75
        Top = 50
        Width = 27
        Height = 13
        Caption = '0.000'
      end
      object IterateLabel: TLabel
        Left = 75
        Top = 26
        Width = 6
        Height = 13
        Caption = '0'
      end
      object Label5: TLabel
        Left = 5
        Top = 96
        Width = 62
        Height = 13
        Caption = 'Learning rate'
      end
      object LRlabel: TLabel
        Left = 75
        Top = 97
        Width = 27
        Height = 13
        Caption = '0.000'
      end
      object Label6: TLabel
        Left = 5
        Top = 73
        Width = 52
        Height = 13
        Caption = 'Momentum'
      end
      object MomentumLabel: TLabel
        Left = 75
        Top = 73
        Width = 27
        Height = 13
        Caption = '0.000'
      end
      object Label7: TLabel
        Left = 2
        Top = 2
        Width = 133
        Height = 14
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Training in progress...'
        Color = 10485760
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object GroupBox2: TGroupBox
      Left = 279
      Top = 129
      Width = 137
      Height = 122
      Caption = 'Training data'
      TabOrder = 5
      object TargetTblBtn: TButton
        Left = 12
        Top = 18
        Width = 113
        Height = 25
        Caption = 'Target table...'
        TabOrder = 0
        OnClick = TargetTblBtnClick
      end
      object SaveTrnBtn: TButton
        Left = 12
        Top = 42
        Width = 113
        Height = 25
        Caption = 'Save...'
        Enabled = False
        TabOrder = 2
        OnClick = SaveTrnBtnClick
      end
      object LoadTrnBtn: TButton
        Left = 12
        Top = 66
        Width = 113
        Height = 25
        Caption = 'Load...'
        TabOrder = 1
        OnClick = LoadTrnBtnClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 280
      Top = 3
      Width = 137
      Height = 122
      Caption = 'Neural network'
      TabOrder = 6
      object TrainBtn: TButton
        Left = 11
        Top = 18
        Width = 113
        Height = 25
        Caption = 'Train...'
        TabOrder = 0
        OnClick = TrainBtnClick
      end
      object TopologyBtn: TButton
        Left = 11
        Top = 42
        Width = 113
        Height = 25
        Caption = 'Topology >>>'
        Enabled = False
        TabOrder = 3
        OnClick = TopologyBtnClick
      end
      object SaveBtn: TButton
        Left = 11
        Top = 66
        Width = 113
        Height = 25
        Caption = 'Save...'
        Enabled = False
        TabOrder = 1
        OnClick = SaveBtnClick
      end
      object LoadBtn: TButton
        Left = 11
        Top = 90
        Width = 113
        Height = 25
        Caption = 'Load...'
        TabOrder = 2
        OnClick = LoadBtnClick
      end
    end
    object Panel1: TPanel
      Left = 0
      Top = 389
      Width = 425
      Height = 14
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 7
      object ProgressBar: TProgressBar
        Left = 10
        Top = 1
        Width = 256
        Height = 8
        Min = 0
        Max = 100
        TabOrder = 0
      end
    end
  end
  object Panel3: TPanel
    Left = 425
    Top = 0
    Width = 375
    Height = 403
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Label8: TLabel
      Left = 0
      Top = 0
      Width = 375
      Height = 15
      Align = alTop
      AutoSize = False
      Caption = 'Neural network topology views'
      Color = 10485760
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 15
      Width = 375
      Height = 388
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 0
      object TabSheet1: TTabSheet
        Caption = 'Text'
        object Memo1: TMemo
          Left = 0
          Top = 0
          Width = 367
          Height = 360
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'TreeView'
        object TreeView1: TTreeView
          Left = 0
          Top = 0
          Width = 367
          Height = 360
          Indent = 19
          Align = alClient
          TabOrder = 0
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Graph+TreeView'
        object NetPaintBox: TPaintBox
          Left = 0
          Top = 0
          Width = 367
          Height = 210
          Align = alClient
          OnPaint = NetPaintBoxPaint
        end
        object GraphTreeView: TTreeView
          Left = 0
          Top = -150
          Width = 0
          Height = 150
          Indent = 19
          OnChange = GraphTreeViewChange
          Align = alBottom
          TabOrder = 0
        end
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'lrn'
    Filter = 'Train File (*.lrn)|*.lrn|All Files (*.*)|*.*'
    Left = 104
    Top = 40
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'lrn'
    Filter = 'Train File (*.lrn)|*.lrn|All Files (*.*)|*.*'
    Left = 64
    Top = 40
  end
  object NetOpenDialog: TOpenDialog
    DefaultExt = 'net'
    Filter = 'Network File (*.net)|*.net|All Files (*.*)|*.*'
    Left = 64
    Top = 80
  end
  object NetSaveDialog: TSaveDialog
    DefaultExt = 'net'
    Filter = 'Network File (*.net)|*.net|All Files (*.*)|*.*'
    Left = 104
    Top = 80
  end
  object Network: TBPnet
    AutoLR = True
    NetConnection = ncLayered
    LearningType = ltPattern
    MinLR = 0.000100000000000000
    BackTrackStep = 0.700000000000000000
    ErrorGoal = 0.000100000000000000
    LearnRate = 0.100000000000000000
    Momentum = 0.400000000000000000
    OnIteration = NetworkIteration
    Left = 64
    Top = 128
  end
end