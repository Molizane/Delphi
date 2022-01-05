object FrmOISCSubleq: TFrmOISCSubleq
  Left = 99
  Top = 204
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'OISC - subleq a, b, c'
  ClientHeight = 362
  ClientWidth = 1017
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    1017
    362)
  PixelsPerInch = 96
  TextHeight = 13
  object Display: TComTerminal
    Left = 8
    Top = 8
    Width = 659
    Height = 346
    Color = clBlack
    Ctl3D = False
    Emulation = teVT100orANSI
    Font.Charset = ANSI_CHARSET
    Font.Color = clYellow
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    ParentCtl3D = False
    ScrollBars = ssBoth
    TabOrder = 0
    Anchors = [akLeft, akTop, akBottom]
    OnKeyPress = DisplayKeyPress
  end
  object Panel1: TPanel
    Left = 674
    Top = 0
    Width = 343
    Height = 362
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    DesignSize = (
      343
      362)
    object lblPaused: TLabel
      Left = 4
      Top = 6
      Width = 109
      Height = 25
      Caption = ' Paused... '
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      Visible = False
    end
    object lblRunning: TLabel
      Left = 4
      Top = 6
      Width = 119
      Height = 25
      Caption = ' Running... '
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      Visible = False
    end
    object lblHalt: TLabel
      Left = 4
      Top = 6
      Width = 96
      Height = 25
      Caption = ' HALTED '
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      ShowAccelChar = False
      Transparent = False
      Layout = tlCenter
    end
    object lblError: TLabel
      Left = 4
      Top = 6
      Width = 86
      Height = 25
      Caption = ' ERROR '
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      Visible = False
    end
    object lblAddress: TLabel
      Left = 4
      Top = 180
      Width = 49
      Height = 13
      Caption = 'lblAddress'
      Color = clBtnFace
      ParentColor = False
    end
    object lblAa: TLabel
      Left = 4
      Top = 240
      Width = 17
      Height = 13
      Caption = 'a ='
      Color = clBtnFace
      ParentColor = False
      Visible = False
    end
    object lblA: TLabel
      Left = 28
      Top = 240
      Width = 17
      Height = 13
      Caption = 'lblA'
      Color = clBtnFace
      ParentColor = False
    end
    object lblInA: TLabel
      Left = 162
      Top = 240
      Width = 27
      Height = 13
      Caption = 'lblInA'
      Color = clBtnFace
      ParentColor = False
    end
    object lblBb: TLabel
      Left = 4
      Top = 267
      Width = 17
      Height = 13
      Caption = 'b ='
      Color = clBtnFace
      ParentColor = False
      Visible = False
    end
    object lblB: TLabel
      Left = 28
      Top = 267
      Width = 16
      Height = 13
      Caption = 'lblB'
      Color = clBtnFace
      ParentColor = False
    end
    object lblInB: TLabel
      Left = 162
      Top = 267
      Width = 26
      Height = 13
      Caption = 'lblInB'
      Color = clBtnFace
      ParentColor = False
    end
    object lblSubleq: TLabel
      Left = 4
      Top = 200
      Width = 42
      Height = 13
      Caption = 'lblSubleq'
      Color = clBtnFace
      ParentColor = False
    end
    object lblCc: TLabel
      Left = 4
      Top = 293
      Width = 16
      Height = 13
      Caption = 'c ='
      Color = clBtnFace
      ParentColor = False
      Visible = False
    end
    object lblC: TLabel
      Left = 28
      Top = 293
      Width = 17
      Height = 13
      Caption = 'lblC'
      Color = clBtnFace
      ParentColor = False
    end
    object btnStart: TBitBtn
      Left = 5
      Top = 62
      Width = 90
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnPause: TBitBtn
      Left = 5
      Top = 101
      Width = 90
      Height = 25
      Anchors = [akTop]
      Caption = 'Pause'
      Enabled = False
      TabOrder = 3
      OnClick = btnPauseClick
    end
    object btnHalt: TBitBtn
      Left = 126
      Top = 101
      Width = 90
      Height = 25
      Anchors = [akTop]
      Caption = 'Halt'
      Enabled = False
      TabOrder = 4
      OnClick = btnHaltClick
    end
    object btnReset: TBitBtn
      Left = 247
      Top = 101
      Width = 90
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Reset'
      Enabled = False
      TabOrder = 5
      OnClick = btnResetClick
    end
    object btnView: TBitBtn
      Left = 126
      Top = 62
      Width = 90
      Height = 25
      Caption = 'View Source'
      TabOrder = 1
      OnClick = btnViewClick
    end
    object btnClear: TBitBtn
      Left = 247
      Top = 62
      Width = 90
      Height = 25
      Caption = 'Clear'
      TabOrder = 2
      Visible = False
      OnClick = btnClearClick
    end
    object btnStep: TBitBtn
      Left = 5
      Top = 145
      Width = 90
      Height = 25
      Caption = 'Step'
      TabOrder = 6
      OnClick = btnStepClick
    end
    object btnGo: TBitBtn
      Left = 126
      Top = 145
      Width = 90
      Height = 25
      Caption = '1 step'
      Enabled = False
      TabOrder = 7
      OnClick = btnGoClick
    end
    object btnStop: TBitBtn
      Left = 247
      Top = 145
      Width = 90
      Height = 25
      Caption = 'Stop'
      Enabled = False
      TabOrder = 8
      OnClick = btnStopClick
    end
  end
end
