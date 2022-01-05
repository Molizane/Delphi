object TargetForm: TTargetForm
  Left = 298
  Top = 237
  BorderStyle = bsDialog
  Caption = 'Target table'
  ClientHeight = 218
  ClientWidth = 291
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel3: TBevel
    Left = 0
    Top = 0
    Width = 291
    Height = 218
    Align = alClient
  end
  object TargetGrid: TStringGrid
    Left = 8
    Top = 9
    Width = 177
    Height = 200
    ColCount = 2
    RowCount = 100
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
    TabOrder = 0
    ColWidths = (
      23
      149)
  end
  object Button1: TButton
    Left = 200
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 200
    Top = 40
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end