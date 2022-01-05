object FrmOISCSubleq: TFrmOISCSubleq
  Left = 116
  Top = 200
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'OISC - subleq a, b, c'
  ClientHeight = 362
  ClientWidth = 1012
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    1012
    362)
  PixelsPerInch = 96
  TextHeight = 13
  object Display: TMemo
    Left = 8
    Top = 8
    Width = 659
    Height = 346
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier'
    Font.Style = []
    Lines.Strings = (
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890'
      
        '1234567890123456789012345678901234567890123456789012345678901234' +
        '5678901234567890')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
    OnChange = DisplayChange
    OnEnter = DisplayEnter
    OnExit = DisplayExit
    OnKeyPress = DisplayKeyPress
  end
  object Panel1: TPanel
    Left = 670
    Top = -1
    Width = 356
    Height = 362
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    object lblPaused: TLabel
      Left = 6
      Top = 8
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
      Layout = tlCenter
      Visible = False
    end
    object lblRunning: TLabel
      Left = 6
      Top = 8
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
      Layout = tlCenter
      Visible = False
    end
    object lblHalt: TLabel
      Left = 6
      Top = 8
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
      Left = 6
      Top = 8
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
      Layout = tlCenter
      Visible = False
    end
    object btnStart: TBitBtn
      Left = 8
      Top = 64
      Width = 85
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnPause: TBitBtn
      Left = 135
      Top = 64
      Width = 85
      Height = 25
      Caption = 'Pause'
      Enabled = False
      TabOrder = 1
      OnClick = btnPauseClick
    end
    object btnHalt: TBitBtn
      Left = 135
      Top = 103
      Width = 85
      Height = 25
      Caption = 'Halt'
      Enabled = False
      TabOrder = 2
      OnClick = btnHaltClick
    end
    object btnReset: TBitBtn
      Left = 250
      Top = 103
      Width = 85
      Height = 25
      Caption = 'Reset'
      Enabled = False
      TabOrder = 3
      OnClick = btnResetClick
    end
    object btnView: TBitBtn
      Left = 8
      Top = 152
      Width = 90
      Height = 25
      Caption = 'View Source'
      TabOrder = 4
      OnClick = btnViewClick
    end
    object btnClear: TBitBtn
      Left = 8
      Top = 206
      Width = 90
      Height = 25
      Caption = 'Clear'
      TabOrder = 5
      Visible = False
      OnClick = btnClearClick
    end
  end
end
