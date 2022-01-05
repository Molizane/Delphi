object FrmCheckboxGrid: TFrmCheckboxGrid
  Left = 499
  Top = 137
  ActiveControl = sgDupes
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Checkbox em Grid'
  ClientHeight = 305
  ClientWidth = 449
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sgDupes: TStringGrid
    Left = 0
    Top = 0
    Width = 449
    Height = 274
    Cursor = crHandPoint
    Align = alClient
    ColCount = 6
    Ctl3D = True
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 2
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goThumbTracking]
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnClick = sgDupesClick
    OnDrawCell = sgDupesDrawCell
    OnKeyDown = sgDupesKeyDown
    OnKeyPress = sgDupesKeyPress
    OnKeyUp = sgDupesKeyUp
    ColWidths = (
      23
      64
      89
      108
      64
      75)
  end
  object Panel1: TPanel
    Left = 0
    Top = 274
    Width = 449
    Height = 31
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 1
      Top = 1
      Width = 447
      Height = 29
      Align = alClient
      Caption = 
        'Clique com o mouse na primeira coluna ou pressione <ESPA'#199'O> na p' +
        'rimeira coluna para marcar/desmarcar'
      Color = clBtnFace
      ParentColor = False
      WordWrap = True
    end
    object imCheck: TImage
      Left = 304
      Top = 15
      Width = 14
      Height = 12
      AutoSize = True
      Picture.Data = {
        07544269746D61706E000000424D6E000000000000003E000000280000000E00
        00000C000000010001000000000030000000120B0000120B0000020000000200
        0000FFFFFF00000000007FF8000040080000440800004E0800005F0800005B88
        000051C8000040E800004068000040280000400800007FF80000}
      Transparent = True
      Visible = False
    end
    object imBlank: TImage
      Left = 320
      Top = 16
      Width = 14
      Height = 12
      AutoSize = True
      Picture.Data = {
        07544269746D61706E000000424D6E000000000000003E000000280000000E00
        00000C000000010001000000000030000000120B0000120B0000020000000200
        0000FFFFFF00000000007FF80000400800004008000040080000400800004008
        000040080000400800004008000040080000400800007FF80000}
      Transparent = True
      Visible = False
    end
    object Image2: TImage
      Left = 340
      Top = 16
      Width = 14
      Height = 12
      AutoSize = True
      Picture.Data = {
        07544269746D61706E000000424D6E000000000000003E000000280000000E00
        00000C0000000100010000000000300000000000000000000000020000000200
        000000000000FFFFFF008004000080040000B3F40000B3340000B8340000BCF4
        0000B8740000B2340000B3340000BFF400008004000080040000}
      Transparent = True
      Visible = False
    end
    object Image1: TImage
      Left = 356
      Top = 16
      Width = 14
      Height = 12
      AutoSize = True
      Picture.Data = {
        07544269746D61706E000000424D6E000000000000003E000000280000000E00
        00000C000000010001000000000030000000120B0000120B0000020000000200
        0000FFFFFF00000000007FFBFFFF7FFBFFFF400BFFFF400BFFFF400BFFFF400B
        FFFF400BFFFF400BFFFF400BFFFF400BFFFF7FFBFFFF7FFBFFFF}
      Transparent = True
      Visible = False
    end
  end
end
