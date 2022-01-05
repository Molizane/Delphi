object Trein: TTrein
  Left = 223
  Top = 125
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
  object tblPerfil: TTable
    BeforeOpen = tblPerfilBeforeOpen
    DatabaseName = 'Perfil'
    TableName = 'Perfil.db'
    Left = 134
  end
  object dsPerfil: TDataSource
    DataSet = tblPerfil
    Left = 162
  end
  object MLP: TMLP
    Struct.Strings = (
      '8'
      '5'
      '5')
    Momentum = 0.500000000000000000
    Learning = 0.899999976158142000
    Knowledge = 'Perfil.mlp'
    Left = 106
  end
end
