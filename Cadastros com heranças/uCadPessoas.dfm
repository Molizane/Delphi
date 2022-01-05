inherited FCadPessoas: TFCadPessoas
  Caption = 'Pessoas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcCadastro: TPageControl
    inherited tsGrid: TTabSheet
      inherited gridCadastro: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_PESSOA'
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NO_PESSOA'
            Width = 234
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IN_FJ'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NO_TIPO'
            Width = 123
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DT_CRIACAO'
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'DT_ALTERACAO'
            Visible = True
          end>
      end
      inherited pnlNavegador: TPanel
        inherited Navegador: TDBNavigator
          Hints.Strings = ()
        end
      end
    end
    inherited tsCadastro: TTabSheet
      object lblTipo: TLabel [2]
        Left = 12
        Top = 74
        Width = 21
        Height = 13
        Caption = 'Tipo'
      end
      inherited edtDescricao: TDBEdit
        Width = 293
        DataField = 'NO_PESSOA'
        TabOrder = 2
      end
      inherited pnlBotoesCadastro: TPanel
        TabOrder = 4
      end
      object DBRadioGroup1: TDBRadioGroup [8]
        Left = 183
        Top = 3
        Width = 185
        Height = 32
        Columns = 2
        DataField = 'IN_FJ'
        DataSource = dsCadastro
        Items.Strings = (
          'F'#237'sico'
          'Jur'#237'dico')
        TabOrder = 1
        Values.Strings = (
          'F'
          'J')
      end
      object cmbTipo: TDBLookupComboBox [9]
        Left = 66
        Top = 68
        Width = 193
        Height = 21
        DataField = 'ID_TIPO'
        DataSource = dsCadastro
        KeyField = 'ID_TIPO'
        ListField = 'NO_TIPO'
        ListSource = dsTipos
        TabOrder = 3
      end
      inherited pnlDtCriacao: TPanel
        TabOrder = 5
      end
      inherited pnlDtAlteracao: TPanel
        TabOrder = 6
      end
    end
  end
  inherited tblCadastro: TIBQuery
    SQL.Strings = (
      'SELECT P.*,T.NO_TIPO'
      'FROM PESSOA AS P,TIPO AS T'
      'WHERE P.ID_TIPO=T.ID_TIPO'
      'ORDER BY P.NO_PESSOA')
    GeneratorField.Field = 'ID_PESSOA'
    GeneratorField.Generator = 'GEN_PESSOA_ID'
    GeneratorField.ApplyEvent = gamOnPost
    Left = 16
    object tblCadastroID_PESSOA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID_PESSOA'
    end
    object tblCadastroNO_PESSOA: TIBStringField
      DisplayLabel = 'Nome'
      FieldName = 'NO_PESSOA'
      Size = 60
    end
    object tblCadastroID_TIPO: TIntegerField
      DisplayLabel = 'Tipo'
      FieldName = 'ID_TIPO'
    end
    object tblCadastroIN_FJ: TIBStringField
      DisplayLabel = 'F/J'
      FieldName = 'IN_FJ'
      FixedChar = True
      Size = 1
    end
    object tblCadastroDT_CRIACAO: TDateTimeField
      DisplayLabel = 'Cria'#231#227'o'
      FieldName = 'DT_CRIACAO'
    end
    object tblCadastroDT_ALTERACAO: TDateTimeField
      DisplayLabel = 'Altera'#231#227'o'
      FieldName = 'DT_ALTERACAO'
    end
    object tblCadastroNO_TIPO: TIBStringField
      DisplayLabel = 'Tipo'
      FieldName = 'NO_TIPO'
      Origin = 'TIPO.NO_TIPO'
      Required = True
      Size = 40
    end
  end
  object qryTipos: TIBQuery [3]
    Database = DMPrincipal.DBCadastro
    Transaction = DMPrincipal.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT ID_TIPO,NO_TIPO FROM TIPO')
    Left = 344
    Top = 8
  end
  object dsTipos: TDataSource [4]
    DataSet = qryTipos
    Left = 398
    Top = 8
  end
  inherited CadUpdate: TIBUpdateSQL
    RefreshSQL.Strings = (
      
        'SELECT P.ID_PESSOA,P.NO_PESSOA,P.ID_TIPO,P.IN_FJ,P.DT_CRIACAO,P.' +
        'DT_ALTERACAO,'
      '       T.NO_TIPO'
      'FROM PESSOA P,TIPO T'
      'WHERE ID_PESSOA=:ID_PESSOA'
      'AND   P.ID_TIPO=T.ID_TIPO'
      'ORDER BY P.NO_PESSOA'
      '')
    ModifySQL.Strings = (
      'UPDATE PESSOA'
      
        'SET NO_PESSOA=:NO_PESSOA,ID_TIPO=:ID_TIPO,IN_FJ=:IN_FJ,DT_ALTERA' +
        'CAO=:DT_ALTERACAO'
      'WHERE ID_PESSOA=:OLD_ID_PESSOA')
    InsertSQL.Strings = (
      'INSERT INTO PESSOA '
      '(NO_PESSOA,ID_TIPO,IN_FJ,DT_CRIACAO,DT_ALTERACAO)'
      'VALUES (:NO_PESSOA,:ID_TIPO,:IN_FJ,:DT_CRIACAO,:DT_ALTERACAO)')
    DeleteSQL.Strings = (
      'DELETE FROM PESSOA'
      'WHERE ID_PESSOA=:OLD_ID_PESSOA')
  end
end
