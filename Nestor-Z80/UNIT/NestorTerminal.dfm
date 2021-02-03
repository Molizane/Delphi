object FrmTerminal: TFrmTerminal
  Left = 331
  Top = 264
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = '  Terminal'
  ClientHeight = 600
  ClientWidth = 1120
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ComTerminal: TComTerminal
    Left = 0
    Top = 0
    Width = 1120
    Height = 600
    AppendLF = True
    BorderStyle = bsNone
    Color = clBlack
    Emulation = teVT100orANSI
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    Rows = 40
    ScrollBars = ssVertical
    TabOrder = 0
    AutoSize = True
    OnKeyPress = ComTerminalKeyPress
  end
end
