object FrmShowCompiled: TFrmShowCompiled
  Left = 245
  Top = 255
  Width = 1016
  Height = 579
  Caption = ' Program'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 506
    Width = 1000
    Height = 34
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      1000
      34)
    object BitBtn1: TBitBtn
      Left = 913
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ModalResult = 11
      TabOrder = 0
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
        F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
        000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
        338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
        45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
        3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
        F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
        000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
        338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
        4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
        8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
        333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
        0000}
      NumGlyphs = 2
    end
    object btnExport: TBitBtn
      Left = 9
      Top = 6
      Width = 75
      Height = 25
      Caption = 'E&xport'
      TabOrder = 1
      OnClick = btnExportClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 21
    Align = alTop
    TabOrder = 1
  end
  object Panel4: TPanel
    Left = 979
    Top = 21
    Width = 21
    Height = 485
    Align = alRight
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 21
    Top = 21
    Width = 958
    Height = 485
    ActivePage = tsLabels
    Align = alClient
    TabOrder = 3
    object tsCode: TTabSheet
      Caption = ' Code '
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 950
        Height = 457
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsTblProgr
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Error'
            Title.Alignment = taCenter
            Title.Caption = 'Error?'
            Width = 45
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Line'
            Title.Alignment = taCenter
            Width = 50
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IsRelative'
            Title.Alignment = taCenter
            Title.Caption = 'Relative'
            Width = 50
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'Address'
            Title.Alignment = taCenter
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Label'
            Title.Alignment = taCenter
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Operator'
            Title.Alignment = taCenter
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'A'
            Title.Alignment = taCenter
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'B'
            Title.Alignment = taCenter
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'C'
            Title.Alignment = taCenter
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Obs'
            Width = 600
            Visible = True
          end>
      end
    end
    object tsLabels: TTabSheet
      Caption = ' Labels '
      ImageIndex = 1
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 776
        Height = 457
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsTblLabels
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
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
            FieldName = 'Name'
            Title.Alignment = taCenter
            Width = 227
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Line'
            Title.Alignment = taCenter
            Width = 90
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'Content'
            Title.Alignment = taCenter
            Width = 90
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'Absolute'
            Title.Alignment = taCenter
            Title.Caption = 'Decimal'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Relative'
            Width = 80
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IsLabel'
            Title.Alignment = taCenter
            Width = 80
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'ValidNumber'
            Title.Alignment = taCenter
            Title.Caption = 'Valid'
            Width = 80
            Visible = True
          end>
      end
      object Panel5: TPanel
        Left = 776
        Top = 0
        Width = 174
        Height = 457
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
    object tsErrors: TTabSheet
      Caption = ' Errors '
      ImageIndex = 2
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 950
        Height = 457
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsTblErrors
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
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
            FieldName = 'Line'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Error'
            Visible = True
          end>
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 21
    Width = 21
    Height = 485
    Align = alLeft
    TabOrder = 4
  end
  object dsTblProgr: TDataSource
    DataSet = tblProgr
    Left = 680
    Top = 91
  end
  object dsTblLabels: TDataSource
    DataSet = tblLabels
    Left = 680
    Top = 168
  end
  object dsTblErrors: TDataSource
    DataSet = tblErrors
    Left = 685
    Top = 249
  end
  object SaveTxt: TSaveDialog
    Filter = 'List files (*.lst)|*.lst'
    Options = [ofReadOnly, ofOverwritePrompt, ofEnableSizing]
    Title = 'Save list file'
    Left = 520
    Top = 91
  end
  object SaveCVS: TSaveDialog
    Filter = 'CVS files (*.cvs)|*.cvs'
    Options = [ofReadOnly, ofOverwritePrompt, ofEnableSizing]
    Title = 'Save list file'
    Left = 520
    Top = 168
  end
  object tblProgr: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Address'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'Label'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Operator'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'A'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'B'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'C'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Obs'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Error'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 601
    Top = 95
    object tblProgrLine: TIntegerField
      FieldName = 'Line'
    end
    object tblProgrIsRelative: TBooleanField
      FieldName = 'IsRelative'
    end
    object tblProgrAbsolute: TStringField
      FieldKind = fkCalculated
      FieldName = 'Absolute'
      Size = 12
      Calculated = True
    end
    object tblProgrAddress: TStringField
      FieldName = 'Address'
    end
    object tblProgrLabel: TStringField
      FieldName = 'Label'
      Size = 30
    end
    object tblProgrOperator: TStringField
      FieldName = 'Operator'
      Size = 30
    end
    object tblProgrA: TStringField
      FieldName = 'A'
    end
    object tblProgrB: TStringField
      FieldName = 'B'
    end
    object tblProgrC: TStringField
      FieldName = 'C'
    end
    object tblProgrObs: TStringField
      FieldName = 'Obs'
      Size = 100
    end
    object tblProgrError: TBooleanField
      FieldName = 'Error'
    end
  end
  object tblLabels: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Name'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Content'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Line'
        DataType = ftInteger
      end
      item
        Name = 'ValidNumber'
        DataType = ftBoolean
      end
      item
        Name = 'IsLabel'
        DataType = ftBoolean
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 605
    Top = 168
    object tblLabelsName: TStringField
      FieldName = 'Name'
      Size = 30
    end
    object tblLabelsRelative: TIntegerField
      FieldName = 'Relative'
    end
    object tblLabelsAbsolute: TStringField
      FieldName = 'Absolute'
      Size = 12
    end
    object tblLabelsContent: TStringField
      FieldName = 'Content'
      Size = 30
    end
    object tblLabelsLine: TIntegerField
      FieldName = 'Line'
    end
    object tblLabelsValidNumber: TBooleanField
      FieldName = 'ValidNumber'
    end
    object tblLabelsIsLabel: TBooleanField
      FieldName = 'IsLabel'
    end
  end
  object tblErrors: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'Line'
        DataType = ftInteger
      end
      item
        Name = 'Seq'
        DataType = ftInteger
      end
      item
        Name = 'Error'
        DataType = ftString
        Size = 255
      end>
    IndexFieldNames = 'Line;Seq'
    IndexName = 'tblErrorsPK'
    IndexDefs = <
      item
        Name = 'tblErrorsPK'
        Fields = 'Line;Seq'
      end>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 607
    Top = 245
    object tblErrorsLine: TIntegerField
      FieldName = 'Line'
    end
    object tblErrorsSeq: TIntegerField
      FieldName = 'Seq'
    end
    object tblErrorsError: TStringField
      FieldName = 'Error'
      Size = 255
    end
  end
end
