object FrmShowCompiled: TFrmShowCompiled
  Left = 216
  Top = 182
  Width = 783
  Height = 540
  Caption = ' Program'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 472
    Width = 775
    Height = 34
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 689
      Top = 6
      Width = 75
      Height = 25
      TabOrder = 0
      Kind = bkClose
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 775
    Height = 21
    Align = alTop
    TabOrder = 1
  end
  object Panel4: TPanel
    Left = 754
    Top = 21
    Width = 21
    Height = 451
    Align = alRight
    TabOrder = 2
  end
  object PageControl1: TPageControl
    Left = 21
    Top = 21
    Width = 733
    Height = 451
    ActivePage = tsCode
    Align = alClient
    TabOrder = 3
    object tsCode: TTabSheet
      Caption = ' Code '
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 725
        Height = 423
        Align = alClient
        BorderStyle = bsNone
        Ctl3D = False
        DataSource = dsTblProgr
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
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
            Alignment = taCenter
            Expanded = False
            FieldName = 'Address'
            Title.Alignment = taCenter
            Width = 66
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Label'
            Title.Alignment = taCenter
            Width = 80
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
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'A'
            Title.Alignment = taCenter
            Width = 66
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'B'
            Title.Alignment = taCenter
            Width = 66
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'C'
            Title.Alignment = taCenter
            Width = 66
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Obs'
            Title.Alignment = taCenter
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
        Width = 608
        Height = 423
        Align = alClient
        BorderStyle = bsNone
        Ctl3D = False
        DataSource = dsTblLabels
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
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
            Alignment = taCenter
            Expanded = False
            FieldName = 'ValidNumber'
            Title.Alignment = taCenter
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
          end>
      end
      object Panel5: TPanel
        Left = 608
        Top = 0
        Width = 117
        Height = 423
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
        Width = 725
        Height = 423
        Align = alClient
        BorderStyle = bsNone
        Ctl3D = False
        DataSource = dsTblErrors
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
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
    Height = 451
    Align = alLeft
    TabOrder = 4
  end
  object tblProgr: TkbmMemTable
    Active = True
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
    FilterOptions = []
    Version = '3.07'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    RangeFieldCount = 0
    Left = 601
    Top = 95
    object tblProgrAddress: TStringField
      FieldName = 'Address'
      Size = 12
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
  object dsTblProgr: TDataSource
    DataSet = tblProgr
    Left = 680
    Top = 93
  end
  object tblLabels: TkbmMemTable
    Active = True
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
    FilterOptions = []
    Version = '3.07'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    RangeFieldCount = 0
    Left = 605
    Top = 168
    object tblLabelsName: TStringField
      FieldName = 'Name'
      Size = 30
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
  object dsTblLabels: TDataSource
    DataSet = tblLabels
    Left = 682
    Top = 163
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
    FilterOptions = []
    Version = '3.07'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    RangeFieldCount = 0
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
  object dsTblErrors: TDataSource
    DataSet = tblErrors
    Left = 685
    Top = 249
  end
end
