inherited FCategorias: TFCategorias
  Caption = ' Categorias'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcCadastro: TPageControl
    inherited tsGrid: TTabSheet
      inherited gridCadastro: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'CD_CATEGORIA'
            Width = 42
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NO_CATEGORIA'
            Width = 125
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NR_CATEGORIA'
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
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ID'
            Width = 37
            Visible = True
          end
          item
            Alignment = taCenter
            Expanded = False
            FieldName = 'IN_DIRTY'
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
        DataField = 'CD_CATEGORIA'
      end
      inherited edtDescricao: TDBEdit
        DataField = 'NO_CATEGORIA'
      end
      inherited edtResumida: TDBEdit
        DataField = 'NR_CATEGORIA'
      end
    end
  end
  inherited tblCadastro: TIBQuery
    SQL.Strings = (
      'SELECT *'
      'FROM CATEGORIAS'
      'ORDER BY NO_CATEGORIA')
    GeneratorField.Field = 'CD_CATEGORIA'
    GeneratorField.Generator = 'CATEGORIAS_GEN'
    GeneratorField.ApplyEvent = gamOnPost
    object tblCadastroCD_CATEGORIA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CD_CATEGORIA'
      Origin = 'CATEGORIAS.CD_CATEGORIA'
    end
    object tblCadastroNO_CATEGORIA: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NO_CATEGORIA'
      Origin = 'CATEGORIAS.NO_CATEGORIA'
      Size = 30
    end
    object tblCadastroNR_CATEGORIA: TIBStringField
      DisplayLabel = 'Resumido'
      FieldName = 'NR_CATEGORIA'
      Origin = 'CATEGORIAS.NR_CATEGORIA'
      Size = 15
    end
    object tblCadastroDT_CRIACAO: TDateTimeField
      DisplayLabel = 'Dt cria'#231#227'o'
      FieldName = 'DT_CRIACAO'
      Origin = 'CATEGORIAS.DT_CRIACAO'
    end
    object tblCadastroDT_ALTERACAO: TDateTimeField
      DisplayLabel = 'Dt altera'#231#227'o'
      FieldName = 'DT_ALTERACAO'
      Origin = 'CATEGORIAS.DT_ALTERACAO'
    end
    object tblCadastroIN_PDA: TIBStringField
      DisplayLabel = 'PDA?'
      FieldName = 'IN_PDA'
      Origin = 'CATEGORIAS.IN_PDA'
      FixedChar = True
      Size = 1
    end
    object tblCadastroID: TIntegerField
      FieldName = 'ID'
      Origin = 'CATEGORIAS.ID'
    end
    object tblCadastroIN_DIRTY: TIBStringField
      DisplayLabel = 'Dirty?'
      FieldName = 'IN_DIRTY'
      Origin = 'CATEGORIAS.IN_DIRTY'
      FixedChar = True
      Size = 1
    end
    object tblCadastroIN_DELETED: TIBStringField
      DisplayLabel = 'Deletado?'
      FieldName = 'IN_DELETED'
      Origin = 'CATEGORIAS.IN_DELETED'
      FixedChar = True
      Size = 1
    end
  end
  inherited CadUpdate: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT *'
      'FROM CATEGORIAS '
      'WHERE CD_CATEGORIA=:CD_CATEGORIA')
    ModifySQL.Strings = (
      'UPDATE CATEGORIAS'
      'SET NO_CATEGORIA=:NO_CATEGORIA,'
      '  NR_CATEGORIA=:NR_CATEGORIA,'
      '  DT_ALTERACAO=:DT_ALTERACAO,'
      '  IN_DIRTY='#39'T'#39','
      '  IN_DELETED=:IN_DELETED'
      'WHERE CD_CATEGORIA=:OLD_CD_CATEGORIA')
    InsertSQL.Strings = (
      'INSERT INTO CATEGORIAS'
      '  (CD_CATEGORIA,NO_CATEGORIA,NR_CATEGORIA,'
      '   DT_CRIACAO,DT_ALTERACAO,'
      '   IN_PDA,ID,IN_DIRTY,IN_DELETED)'
      'VALUES'
      '  (:CD_CATEGORIA,:NO_CATEGORIA,:NR_CATEGORIA,'
      '   :DT_CRIACAO,:DT_ALTERACAO,'
      '   '#39'F'#39',0,'#39'T'#39','#39'F'#39')')
    DeleteSQL.Strings = (
      'DELETE FROM CATEGORIAS'
      'WHERE CD_CATEGORIA=:OLD_CD_CATEGORIA')
  end
end
