object FrmIO: TFrmIO
  Left = 892
  Top = 5
  Width = 123
  Height = 297
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'I/O'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    115
    263)
  PixelsPerInch = 96
  TextHeight = 13
  object IOGrid: TStringGrid
    Left = 16
    Top = 0
    Width = 82
    Height = 263
    Anchors = [akTop, akBottom]
    ColCount = 2
    Ctl3D = True
    DefaultColWidth = 30
    DefaultRowHeight = 21
    RowCount = 258
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goAlwaysShowEditor]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
end
