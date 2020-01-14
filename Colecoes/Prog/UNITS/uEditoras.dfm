inherited FEditoras: TFEditoras
  Caption = ' Editoras'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcCadastro: TPageControl
    inherited tsGrid: TTabSheet
      inherited gridCadastro: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'CD_EDITORA'
            Width = 42
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NO_EDITORA'
            Width = 125
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NR_EDITORA'
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
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IN_PDA'
            Width = 31
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID'
            Width = 32
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IN_DIRTY'
            Width = 37
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IN_DELETED'
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
      inherited pnlCodigo: TDBPanel
        DataField = 'CD_EDITORA'
      end
      inherited edtDescricao: TDBEdit
        DataField = 'NO_EDITORA'
      end
      inherited edtResumida: TDBEdit
        DataField = 'NR_EDITORA'
      end
    end
  end
  inherited tblCadastro: TIBQuery
    SQL.Strings = (
      'SELECT *'
      'FROM EDITORAS'
      'ORDER BY NO_EDITORA')
    GeneratorField.Field = 'CD_EDITORA'
    GeneratorField.Generator = 'EDITORAS_GEN'
    GeneratorField.ApplyEvent = gamOnPost
    object tblCadastroCD_EDITORA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CD_EDITORA'
      Origin = 'EDITORAS.CD_EDITORA'
    end
    object tblCadastroNO_EDITORA: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NO_EDITORA'
      Origin = 'EDITORAS.NO_EDITORA'
      Size = 30
    end
    object tblCadastroNR_EDITORA: TIBStringField
      DisplayLabel = 'Resumido'
      FieldName = 'NR_EDITORA'
      Origin = 'EDITORAS.NR_EDITORA'
      Size = 15
    end
    object tblCadastroDT_CRIACAO: TDateTimeField
      DisplayLabel = 'Dt cria'#231#227'o'
      FieldName = 'DT_CRIACAO'
      Origin = 'EDITORAS.DT_CRIACAO'
    end
    object tblCadastroDT_ALTERACAO: TDateTimeField
      DisplayLabel = 'Dt altera'#231#227'o'
      FieldName = 'DT_ALTERACAO'
      Origin = 'EDITORAS.DT_ALTERACAO'
    end
    object tblCadastroID: TIntegerField
      FieldName = 'ID'
      Origin = 'EDITORAS.ID'
    end
    object tblCadastroIN_DIRTY: TIBStringField
      DisplayLabel = 'Dirty?'
      FieldName = 'IN_DIRTY'
      Origin = 'EDITORAS.IN_DIRTY'
      FixedChar = True
      Size = 1
    end
    object tblCadastroIN_DELETED: TIBStringField
      DisplayLabel = 'Deletado?'
      FieldName = 'IN_DELETED'
      Origin = 'EDITORAS.IN_DELETED'
      FixedChar = True
      Size = 1
    end
    object tblCadastroIN_PDA: TIBStringField
      DisplayLabel = 'PDA?'
      FieldName = 'IN_PDA'
      Origin = 'EDITORAS.IN_PDA'
      FixedChar = True
      Size = 1
    end
  end
  inherited CadUpdate: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT *'
      'FROM EDITORAS '
      'WHERE CD_EDITORA=:CD_EDITORA')
    ModifySQL.Strings = (
      'UPDATE EDITORAS'
      'SET NO_EDITORA=:NO_EDITORA,NR_EDITORA=:NR_EDITORA,'
      '  DT_ALTERACAO=:DT_ALTERACAO,'
      '  IN_DIRTY='#39'T'#39',IN_DELETED=:IN_DELETED'
      'WHERE CD_EDITORA=:OLD_CD_EDITORA')
    InsertSQL.Strings = (
      'INSERT INTO EDITORAS'
      '  (CD_EDITORA,NO_EDITORA,NR_EDITORA,'
      '   DT_CRIACAO,DT_ALTERACAO,'
      '   ID,IN_DIRTY,'
      '   IN_DELETED,IN_PDA)'
      'VALUES'
      '  (:CD_EDITORA,:NO_EDITORA,:NR_EDITORA,'
      '   :DT_CRIACAO,:DT_ALTERACAO,'
      '   0,'#39'T'#39','#39'F'#39','#39'F'#39')')
    DeleteSQL.Strings = (
      'DELETE FROM EDITORAS'
      'WHERE CD_EDITORA=:OLD_CD_EDITORA')
  end
end
