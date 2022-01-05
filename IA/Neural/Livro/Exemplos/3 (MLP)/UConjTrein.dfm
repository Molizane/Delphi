object ConjTrein: TConjTrein
  Left = 379
  Top = 347
  Width = 267
  Height = 286
  Caption = 'Conjunto de Treinamento'
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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 11
    Top = 42
    Width = 237
    Height = 213
    DataSource = dsPrevis
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
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Hora'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Consultas'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 9
    Top = 12
    Width = 240
    Height = 25
    DataSource = dsPrevis
    TabOrder = 1
  end
  object tblPrevis: TTable
    BeforeOpen = tblPrevisBeforeOpen
    DatabaseName = 'Previs'
    TableName = 'Previs.db'
    Left = 84
    Top = 108
    object tblPrevisID: TIntegerField
      FieldName = 'ID'
    end
    object tblPrevisHora: TFloatField
      FieldName = 'Hora'
    end
    object tblPrevisConsultas: TIntegerField
      FieldName = 'Consultas'
    end
  end
  object dsPrevis: TDataSource
    DataSet = tblPrevis
    Left = 112
    Top = 108
  end
end
