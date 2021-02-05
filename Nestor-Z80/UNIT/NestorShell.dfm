object FrmShell: TFrmShell
  Left = 331
  Top = 264
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = '  Shell'
  ClientHeight = 600
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyPress = ComTerminalKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object ComTerminal: TComTerminal
    Left = 0
    Top = 0
    Width = 640
    Height = 600
    AppendLF = True
    BorderStyle = bsNone
    Color = clBlack
    Emulation = teVT100orANSI
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Fixedsys'
    Font.Style = []
    Rows = 40
    ScrollBars = ssNone
    TabOrder = 0
    WrapLines = True
    AutoSize = True
    OnKeyPress = ComTerminalKeyPress
  end
end
