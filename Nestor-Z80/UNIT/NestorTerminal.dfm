object FrmTerminal: TFrmTerminal
  Left = 365
  Top = 290
  AutoSize = True
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = '  Terminal'
  ClientHeight = 364
  ClientWidth = 880
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
    Width = 880
    Height = 364
    AppendLF = True
    BorderStyle = bsNone
    Color = clBlack
    Emulation = teVT100orANSI
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Noto Mono'
    Font.Style = [fsBold]
    Rows = 26
    ScrollBars = ssVertical
    TabOrder = 0
    AutoSize = True
    OnKeyPress = ComTerminalKeyPress
  end
end
