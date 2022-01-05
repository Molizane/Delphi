object Teste: TTeste
  Left = 346
  Top = 347
  Width = 415
  Height = 329
  Caption = 'Teste de Previs'#227'o'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 18
    Width = 147
    Height = 265
    DataSource = dsPrevis
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hora'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Consultas'
        Width = 50
        Visible = True
      end>
  end
  object btnTeste: TBitBtn
    Left = 162
    Top = 112
    Width = 85
    Height = 73
    Caption = 'Teste'
    TabOrder = 1
    OnClick = btnTesteClick
  end
  object DBGrid2: TDBGrid
    Left = 250
    Top = 20
    Width = 153
    Height = 265
    DataSource = dsPrevisTeste
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hora'
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Consultas'
        Width = 50
        Visible = True
      end>
  end
  object MLP: TMLP
    Struct.Strings = (
      '48'
      '24'
      '1')
    Momentum = 0.500000000000000000
    Learning = 0.899999976158142000
    Knowledge = 'Previs.mlp'
    Left = 190
    Top = 84
  end
  object tblPrevis: TTable
    BeforeOpen = tblPrevisBeforeOpen
    DatabaseName = 'Previs'
    TableName = 'Previs.db'
    Left = 154
    Top = 18
  end
  object dsPrevis: TDataSource
    DataSet = tblPrevis
    Left = 182
    Top = 18
  end
  object tblPrevisTeste: TTable
    BeforeOpen = tblPrevisTesteBeforeOpen
    DatabaseName = 'Previs'
    TableName = 'PrevisTeste.db'
    Left = 180
    Top = 232
  end
  object dsPrevisTeste: TDataSource
    DataSet = tblPrevisTeste
    Left = 208
    Top = 232
  end
end
