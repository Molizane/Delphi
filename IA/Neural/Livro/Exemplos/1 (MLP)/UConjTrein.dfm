object ConjTrein: TConjTrein
  Left = 293
  Top = 332
  Width = 430
  Height = 298
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
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    422
    271)
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 9
    Top = 42
    Width = 405
    Height = 225
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsPerfil
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 12
    Width = 240
    Height = 25
    DataSource = dsPerfil
    TabOrder = 1
  end
  object tblPerfil: TTable
    BeforeOpen = tblPerfilBeforeOpen
    DatabaseName = 'Perfil'
    TableName = 'Perfil.db'
    Left = 328
    Top = 2
    object tblPerfilID: TIntegerField
      FieldName = 'ID'
    end
    object tblPerfilNInvAR: TIntegerField
      FieldName = 'NInvAR'
    end
    object tblPerfilNInvMR: TIntegerField
      FieldName = 'NInvMR'
    end
    object tblPerfilNInvBR: TIntegerField
      FieldName = 'NInvBR'
    end
    object tblPerfilIdade: TIntegerField
      FieldName = 'Idade'
    end
    object tblPerfilSexo: TIntegerField
      FieldName = 'Sexo'
    end
    object tblPerfilRenda: TFloatField
      FieldName = 'Renda'
    end
    object tblPerfilPMI: TFloatField
      FieldName = 'PMI'
    end
    object tblPerfilEscolaridade: TIntegerField
      FieldName = 'Escolaridade'
    end
    object tblPerfilPerfil: TIntegerField
      FieldName = 'Perfil'
    end
  end
  object dsPerfil: TDataSource
    DataSet = tblPerfil
    Left = 358
    Top = 2
  end
end
