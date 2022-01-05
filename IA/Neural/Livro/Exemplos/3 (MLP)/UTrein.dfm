object Trein: TTrein
  Left = 314
  Top = 277
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
  object tblPrevis: TTable
    BeforeOpen = tblPrevisBeforeOpen
    DatabaseName = 'Previs'
    TableName = 'Previs.db'
    Left = 134
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
    Left = 162
  end
  object MLP: TMLP
    Struct.Strings = (
      '512'
      '1')
    Momentum = 0.500000000000000000
    Learning = 0.899999976158142000
    Knowledge = 'Previs.mlp'
    Left = 106
    Top = 65534
  end
end
