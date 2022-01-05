object FrmEmbaralhamento: TFrmEmbaralhamento
  Left = -5
  Top = 181
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Embaralhamento'
  ClientHeight = 137
  ClientWidth = 1015
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    1015
    137)
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid: TStringGrid
    Left = 3
    Top = 3
    Width = 1007
    Height = 97
    Anchors = [akLeft, akTop, akRight]
    ColCount = 13
    DefaultColWidth = 76
    DefaultRowHeight = 17
    FixedCols = 0
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -8
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 0
  end
  object btnEmbaralhar: TBitBtn
    Left = 6
    Top = 104
    Width = 75
    Height = 25
    Caption = '&Embaralhar'
    TabOrder = 1
    OnClick = btnEmbaralharClick
  end
end
