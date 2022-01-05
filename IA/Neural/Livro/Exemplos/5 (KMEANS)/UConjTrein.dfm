object ConjTrein: TConjTrein
  Left = 444
  Top = 404
  Width = 482
  Height = 282
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
    Width = 453
    Height = 205
    DataSource = dsSegment
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
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Renda'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Idade'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Sexo'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TV'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Radio'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Video'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Internet'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Conjuge'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Faixa1'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Faixa2'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Faixa3'
        Width = 31
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Classe'
        Width = 31
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 12
    Width = 240
    Height = 25
    DataSource = dsSegment
    TabOrder = 1
  end
  object tblSegment: TTable
    BeforeOpen = tblSegmentBeforeOpen
    DatabaseName = 'Segment'
    TableName = 'Segment.db'
    Left = 414
    Top = 6
  end
  object dsSegment: TDataSource
    DataSet = tblSegment
    Left = 442
    Top = 6
  end
end
