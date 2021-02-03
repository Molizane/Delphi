object FrmFlags: TFrmFlags
  Left = 5
  Top = 6
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = '  Flags'
  ClientHeight = 187
  ClientWidth = 124
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FGridFlags: TStringGrid
    Left = 14
    Top = 7
    Width = 87
    Height = 173
    ColCount = 3
    DefaultColWidth = 27
    DefaultRowHeight = 20
    RowCount = 8
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goAlwaysShowEditor]
    ScrollBars = ssNone
    TabOrder = 0
    OnDrawCell = FGridFlagsDrawCell
    RowHeights = (
      20
      20
      20
      20
      20
      20
      20
      20)
  end
end
