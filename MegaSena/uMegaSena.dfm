object Form1: TForm1
  Left = 200
  Top = 95
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Mega Sena'
  ClientHeight = 157
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'System'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 337
    Height = 157
    Align = alLeft
    BevelOuter = bvLowered
    BorderStyle = bsSingle
    Caption = ' '
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 343
    Top = 4
    Width = 78
    Height = 33
    Caption = '&Gerar'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object Timer1: TTimer
    Interval = 500
    OnTimer = Timer1Timer
    Left = 392
    Top = 64
  end
end
