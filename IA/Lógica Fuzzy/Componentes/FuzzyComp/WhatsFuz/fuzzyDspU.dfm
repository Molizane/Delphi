object frmGrid: TfrmGrid
  Left = 774
  Top = 183
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Fuzzy'
  ClientHeight = 223
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GridFuzzy: TStringGrid
    Left = 0
    Top = 0
    Width = 559
    Height = 223
    Align = alClient
    ColCount = 4
    DefaultColWidth = 138
    DefaultRowHeight = 21
    RowCount = 10
    TabOrder = 0
    OnDrawCell = GridFuzzyDrawCell
  end
end
