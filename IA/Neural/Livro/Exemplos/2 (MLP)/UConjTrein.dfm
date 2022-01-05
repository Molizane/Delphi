object ConjTrein: TConjTrein
  Left = 542
  Top = 314
  BorderStyle = bsSingle
  Caption = 'Conjunto de Treinamento'
  ClientHeight = 283
  ClientWidth = 271
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 42
    Width = 175
    Height = 205
    DataSource = dsOCR
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Sequencia'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ID'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Caracter'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 12
    Width = 240
    Height = 25
    DataSource = dsOCR
    TabOrder = 1
  end
  object DBImage1: TDBImage
    Left = 194
    Top = 122
    Width = 32
    Height = 32
    DataField = 'Imagem'
    DataSource = dsOCR
    TabOrder = 2
    OnDblClick = DBImage1DblClick
  end
  object btnOk: TBitBtn
    Left = 98
    Top = 257
    Width = 75
    Height = 25
    TabOrder = 3
    OnClick = btnOkClick
    Kind = bkOK
  end
  object btnLote: TBitBtn
    Left = 192
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Lote'
    Enabled = False
    TabOrder = 4
    OnClick = btnLoteClick
  end
  object tblOCR: TTable
    BeforeOpen = tblOCRBeforeOpen
    DatabaseName = 'OCR'
    IndexFieldNames = 'Sequencia'
    TableName = 'OCRTrein.db'
    Left = 190
    Top = 52
    object tblOCRSequencia: TAutoIncField
      FieldName = 'Sequencia'
    end
    object tblOCRID: TStringField
      FieldName = 'ID'
      Size = 4
    end
    object tblOCRCaracter: TStringField
      FieldName = 'Caracter'
      Size = 1
    end
    object tblOCRImagem: TGraphicField
      FieldName = 'Imagem'
      BlobType = ftGraphic
    end
  end
  object dsOCR: TDataSource
    DataSet = tblOCR
    Left = 220
    Top = 52
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '*.BMP'
    Filter = 'Bitmaps (*.BMP)|*.BMP'
    Title = 'Abrir bitmap...'
    Left = 190
    Top = 82
  end
end
