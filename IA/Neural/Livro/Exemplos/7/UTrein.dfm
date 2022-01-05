object FrmTrein: TFrmTrein
  Left = 629
  Top = 314
  Width = 307
  Height = 175
  Caption = 'Treinamento da Rede MLP'
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
  object btnConstruir: TBitBtn
    Left = 38
    Top = 28
    Width = 100
    Height = 70
    Caption = 'Construir'
    TabOrder = 0
    OnClick = btnConstruirClick
  end
  object btnTreinar: TBitBtn
    Left = 158
    Top = 28
    Width = 100
    Height = 70
    Caption = 'Treinar'
    Enabled = False
    TabOrder = 1
    OnClick = btnTreinarClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 120
    Width = 299
    Height = 28
    Panels = <
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object tblVale5: TTable
    DatabaseName = 'Vale5'
    TableName = 'Vale5'
    Left = 133
    object tblVale5IFR: TFloatField
      FieldName = 'IFR'
    end
    object tblVale5PERC_D: TFloatField
      FieldName = 'PERC_D'
    end
    object tblVale5PERC_K: TFloatField
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
    Left = 162
  end
  object MLP: TMLP
    Struct.Strings = (
      '6'
      '5'
      '3')
    Momentum = 0.500000000000000000
    Learning = 0.899999976158142000
    Knowledge = 'Vale5.mlp'
    Left = 106
    Top = 65535
  end
end
