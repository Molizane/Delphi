object FrmConjTrein: TFrmConjTrein
  Left = 508
  Top = 302
  Width = 517
  Height = 289
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
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 10
    Top = 37
    Width = 488
    Height = 221
    DataSource = dsPerfil
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'IFR'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERC_D'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PERC_K'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MFI'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UO'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SUPRES'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FUT'
        Title.Alignment = taCenter
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 10
    Top = 7
    Width = 240
    Height = 25
    DataSource = dsPerfil
    TabOrder = 1
  end
  object tblVale5: TTable
    DatabaseName = 'Vale5'
    TableName = 'Vale5'
    Left = 328
    Top = 3
    object tblVale5IFR: TFloatField
      FieldName = 'IFR'
    end
    object tblVale5PERC_D: TFloatField
      DisplayLabel = '%D'
      FieldName = 'PERC_D'
    end
    object tblVale5PERC_K: TFloatField
      DisplayLabel = '%K'
      FieldName = 'PERC_K'
    end
    object tblVale5MFI: TFloatField
      FieldName = 'MFI'
    end
    object tblVale5UO: TFloatField
      FieldName = 'UO'
    end
    object tblVale5SUPRES: TFloatField
      FieldName = 'SUPRES'
    end
    object tblVale5FUT: TFloatField
      FieldName = 'FUT'
    end
  end
  object dsPerfil: TDataSource
    DataSet = tblVale5
    Left = 358
    Top = 3
  end
end
