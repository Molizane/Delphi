object Form1: TForm1
  Left = 308
  Top = 209
  Width = 328
  Height = 367
  Caption = 'Simple XOR problem'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  PixelsPerInch = 96
  TextHeight = 13
  object Label6: TLabel
    Left = 0
    Top = 150
    Width = 320
    Height = 13
    Align = alTop
    Alignment = taCenter
    Caption = 'Neural network topology repesentation'
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
    Top = 163
    Width = 320
    Height = 177
    ActivePage = CanvasSheet
    Align = alClient
    TabOrder = 0
    object CanvasSheet: TTabSheet
      Caption = 'Graphic'
      object PaintBox: TPaintBox
        Left = 0
        Top = 0
        Width = 312
        Height = 149
        Align = alClient
        OnPaint = PaintBoxPaint
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TreeView'
      object TreeView1: TTreeView
        Left = 0
        Top = 0
        Width = 312
        Height = 149
        Indent = 19
        Align = alClient
        TabOrder = 0
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Text'
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 312
        Height = 149
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 320
    Height = 150
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 84
      Width = 22
      Height = 13
      Caption = 'Error'
    end
    object Label2: TLabel
      Left = 8
      Top = 98
      Width = 62
      Height = 13
      Caption = 'Learning rate'
    end
    object Label3: TLabel
      Left = 8
      Top = 69
      Width = 38
      Height = 13
      Caption = 'Iteration'
    end
    object IterLbl: TLabel
      Left = 78
      Top = 69
      Width = 6
      Height = 13
      Caption = '0'
    end
    object ErrLbl: TLabel
      Left = 78
      Top = 84
      Width = 27
      Height = 13
      Caption = '0.000'
    end
    object LRlbl: TLabel
      Left = 78
      Top = 98
      Width = 27
      Height = 13
      Caption = '0.000'
    end
    object Label7: TLabel
      Left = 8
      Top = 113
      Width = 52
      Height = 13
      Caption = 'Momentum'
    end
    object Momentlbl: TLabel
      Left = 78
      Top = 113
      Width = 27
      Height = 13
      Caption = '0.000'
    end
    object TrainBtn: TButton
      Left = 6
      Top = 38
      Width = 75
      Height = 25
      Caption = 'XOR Train'
      Enabled = False
      TabOrder = 0
      OnClick = TrainBtnClick
    end
    object GroupBox1: TGroupBox
      Left = 156
      Top = 5
      Width = 157
      Height = 113
      Caption = 'Validation'
      TabOrder = 1
      object Label4: TLabel
        Left = 6
        Top = 22
        Width = 40
        Height = 13
        Caption = 'Input #1'
      end
      object Label5: TLabel
        Left = 6
        Top = 53
        Width = 40
        Height = 13
        Caption = 'Input #2'
      end
      object AnswerLabel: TLabel
        Left = 98
        Top = 86
        Width = 35
        Height = 13
        Caption = 'Answer'
      end
      object Edit1: TEdit
        Left = 51
        Top = 18
        Width = 99
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object Edit2: TEdit
        Left = 51
        Top = 50
        Width = 99
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object AnswerBtn: TButton
        Left = 8
        Top = 80
        Width = 75
        Height = 25
        Caption = 'Answer >>>>'
        Enabled = False
        TabOrder = 2
        OnClick = AnswerBtnClick
      end
    end
    object BuildBtn: TButton
      Left = 6
      Top = 9
      Width = 144
      Height = 25
      Caption = 'Build network'
      TabOrder = 2
      OnClick = BuildBtnClick
    end
    object StopBtn: TButton
      Left = 85
      Top = 38
      Width = 65
      Height = 25
      Caption = 'Stop'
      Enabled = False
      Font.Charset = BALTIC_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = StopBtnClick
    end
  end
  object Net: TBPnet
    AutoLR = False
    NetConnection = ncLayered
    LearningType = ltPattern
    MinLR = 0.000100000000000000
    BackTrackStep = 0.700000000000000000
    ErrorGoal = 0.000100000000000000
    LearnRate = 1.000000000000000000
    Momentum = 0.500000000000000000
    OnIteration = NetIteration
    Left = 12
    Top = 195
  end
end