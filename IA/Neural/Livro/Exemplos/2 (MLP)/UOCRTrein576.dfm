object FOCRTrein576: TFOCRTrein576
  Left = 286
  Top = 330
  BorderStyle = bsSingle
  Caption = 'OCR Experimental - Treinamento (576x10)'
  ClientHeight = 286
  ClientWidth = 663
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 8
    Width = 98
    Height = 13
    Caption = 'Amostras de Entrada'
  end
  object Label2: TLabel
    Left = 194
    Top = 52
    Width = 78
    Height = 13
    Caption = 'Caracter (32x32)'
  end
  object Label3: TLabel
    Left = 186
    Top = 108
    Width = 95
    Height = 13
    Caption = 'Convolu'#231#227'o (32x32)'
  end
  object Label4: TLabel
    Left = 180
    Top = 166
    Width = 114
    Height = 13
    Caption = 'Subamostragem (16x16)'
  end
  object Label5: TLabel
    Left = 322
    Top = 54
    Width = 70
    Height = 13
    Caption = 'Ocelos (9x8x8)'
  end
  object Label6: TLabel
    Left = 446
    Top = 36
    Width = 95
    Height = 13
    Caption = 'Rede MLP (576x10)'
  end
  object Label7: TLabel
    Left = 592
    Top = 6
    Width = 34
    Height = 13
    Caption = 'Sa'#237'das'
  end
  object Label8: TLabel
    Left = 562
    Top = 26
    Width = 6
    Height = 13
    Caption = '0'
  end
  object Label9: TLabel
    Left = 562
    Top = 49
    Width = 6
    Height = 13
    Caption = '1'
  end
  object Label10: TLabel
    Left = 562
    Top = 73
    Width = 6
    Height = 13
    Caption = '2'
  end
  object Label11: TLabel
    Left = 562
    Top = 96
    Width = 6
    Height = 13
    Caption = '3'
  end
  object Label12: TLabel
    Left = 562
    Top = 120
    Width = 6
    Height = 13
    Caption = '4'
  end
  object Label13: TLabel
    Left = 562
    Top = 143
    Width = 6
    Height = 13
    Caption = '5'
  end
  object Label14: TLabel
    Left = 562
    Top = 167
    Width = 6
    Height = 13
    Caption = '6'
  end
  object Label15: TLabel
    Left = 562
    Top = 190
    Width = 6
    Height = 13
    Caption = '7'
  end
  object Label16: TLabel
    Left = 562
    Top = 214
    Width = 6
    Height = 13
    Caption = '8'
  end
  object Label17: TLabel
    Left = 562
    Top = 238
    Width = 6
    Height = 13
    Caption = '9'
  end
  object ImOcelo11: TImage
    Left = 312
    Top = 72
    Width = 32
    Height = 32
    Stretch = True
  end
  object ImOcelo12: TImage
    Left = 346
    Top = 72
    Width = 32
    Height = 32
    Stretch = True
  end
  object ImOcelo13: TImage
    Left = 380
    Top = 72
    Width = 32
    Height = 32
    Stretch = True
  end
  object ImOcelo21: TImage
    Left = 312
    Top = 106
    Width = 32
    Height = 32
    Stretch = True
  end
  object ImOcelo22: TImage
    Left = 346
    Top = 106
    Width = 32
    Height = 32
    Stretch = True
  end
  object ImOcelo23: TImage
    Left = 380
    Top = 106
    Width = 32
    Height = 32
    Stretch = True
  end
  object ImOcelo31: TImage
    Left = 312
    Top = 140
    Width = 32
    Height = 32
    Stretch = True
  end
  object ImOcelo32: TImage
    Left = 346
    Top = 140
    Width = 32
    Height = 32
    Stretch = True
  end
  object ImOcelo33: TImage
    Left = 380
    Top = 140
    Width = 32
    Height = 32
    Stretch = True
  end
  object ImConvol: TImage
    Left = 216
    Top = 122
    Width = 32
    Height = 32
  end
  object ImSubAmostra: TImage
    Left = 218
    Top = 180
    Width = 32
    Height = 32
    Stretch = True
  end
  object DBGrid1: TDBGrid
    Left = 50
    Top = 24
    Width = 113
    Height = 231
    DataSource = dsOCR
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
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Caracter'
        Visible = True
      end>
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 261
    Width = 663
    Height = 25
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object DBImCaracter: TDBImage
    Left = 216
    Top = 66
    Width = 31
    Height = 31
    DataField = 'Imagem'
    DataSource = dsOCR
    TabOrder = 2
  end
  object btnConstruir: TBitBtn
    Left = 456
    Top = 58
    Width = 75
    Height = 25
    Caption = 'Construir'
    TabOrder = 3
    OnClick = btnConstruirClick
  end
  object btnTreinar: TBitBtn
    Left = 456
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Treinar'
    Enabled = False
    TabOrder = 4
    OnClick = btnTreinarClick
  end
  object btnTestar: TBitBtn
    Left = 456
    Top = 118
    Width = 75
    Height = 25
    Caption = 'Testar'
    Enabled = False
    TabOrder = 5
    OnClick = btnTestarClick
  end
  object btnSalvar: TBitBtn
    Left = 456
    Top = 148
    Width = 75
    Height = 25
    Caption = 'Salvar'
    Enabled = False
    TabOrder = 6
    OnClick = btnSalvarClick
  end
  object btnCarregar: TBitBtn
    Left = 456
    Top = 178
    Width = 75
    Height = 25
    Caption = 'Carregar'
    Enabled = False
    TabOrder = 7
    OnClick = btnCarregarClick
  end
  object ed0: TEdit
    Left = 576
    Top = 22
    Width = 69
    Height = 21
    TabOrder = 8
  end
  object ed1: TEdit
    Left = 576
    Top = 45
    Width = 69
    Height = 21
    TabOrder = 9
  end
  object ed2: TEdit
    Left = 576
    Top = 69
    Width = 69
    Height = 21
    TabOrder = 10
  end
  object ed3: TEdit
    Left = 576
    Top = 92
    Width = 69
    Height = 21
    TabOrder = 11
  end
  object ed4: TEdit
    Left = 576
    Top = 116
    Width = 69
    Height = 21
    TabOrder = 12
  end
  object ed5: TEdit
    Left = 576
    Top = 139
    Width = 69
    Height = 21
    TabOrder = 13
  end
  object ed6: TEdit
    Left = 576
    Top = 163
    Width = 69
    Height = 21
    TabOrder = 14
  end
  object ed7: TEdit
    Left = 576
    Top = 186
    Width = 69
    Height = 21
    TabOrder = 15
  end
  object ed8: TEdit
    Left = 576
    Top = 210
    Width = 69
    Height = 21
    TabOrder = 16
  end
  object ed9: TEdit
    Left = 576
    Top = 234
    Width = 69
    Height = 21
    TabOrder = 17
  end
  object btnParar: TBitBtn
    Left = 456
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Parar'
    Enabled = False
    TabOrder = 18
    OnClick = btnPararClick
  end
  object tblPdxOCR: TTable
    BeforeOpen = tblPdxOCRBeforeOpen
    AfterOpen = tblPdxOCRAfterOpen
    DatabaseName = 'OCR'
    IndexFieldNames = 'Sequencia'
    TableName = 'OCRTrein.DB'
    Left = 206
    Top = 2
    object tblPdxOCRSequencia: TIntegerField
      FieldName = 'Sequencia'
    end
    object tblPdxOCRID: TStringField
      FieldName = 'ID'
      Size = 4
    end
    object tblPdxOCRCaracter: TStringField
      FieldName = 'Caracter'
      Size = 1
    end
    object tblPdxOCRImagem: TGraphicField
      FieldName = 'Imagem'
      BlobType = ftGraphic
    end
  end
  object dsOCR: TDataSource
    DataSet = tblMemOCR
    Left = 234
    Top = 2
  end
  object MLP: TMLP
    Struct.Strings = (
      '576'
      '10')
    Momentum = 0.500000000000000000
    Learning = 0.899999976158142000
    Knowledge = 'OCR576.mlp'
    Left = 178
    Top = 2
  end
  object tblMemOCR: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Sequencia'
        DataType = ftInteger
      end
      item
        Name = 'ID'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Caracter'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Imagem'
        DataType = ftGraphic
      end>
    IndexFieldNames = 'Sequencia'
    IndexName = 'tblMemOCRIndex1'
    IndexDefs = <
      item
        Name = 'tblMemOCRIndex1'
        Fields = 'Sequencia'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.02b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 292
    Top = 2
    object tblMemOCRSequencia: TIntegerField
      FieldName = 'Sequencia'
    end
    object tblMemOCRID: TStringField
      FieldName = 'ID'
      Size = 4
    end
    object tblMemOCRCaracter: TStringField
      FieldName = 'Caracter'
      Size = 1
    end
    object tblMemOCRImagem: TGraphicField
      FieldName = 'Imagem'
      BlobType = ftGraphic
    end
  end
end
