inherited FTipos: TFTipos
  Caption = 'Tipos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcCadastro: TPageControl
    inherited tsGrid: TTabSheet
      inherited gridCadastro: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'CD_TIPO'
            Width = 42
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NO_TIPO'
            Width = 125
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NR_TIPO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DT_CRIACAO'
            Visible = True
          end
          item
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
        inherited DBNavigator1: TDBNavigator
          Hints.Strings = ()
        end
        inherited DBNavigator2: TDBNavigator
          Hints.Strings = ()
        end
      end
    end
    inherited tsCadastro: TTabSheet
      inherited pnlCodigo: TDBPanel
        DataField = 'CD_TIPO'
      end
      inherited edtDescricao: TDBEdit
        DataField = 'NO_TIPO'
      end
      inherited edtResumida: TDBEdit
        DataField = 'NR_TIPO'
      end
    end
  end
  inherited tblCadastro: TIBQuery
    SQL.Strings = (
      'SELECT * FROM TIPOS ORDER BY NO_TIPO')
    GeneratorField.Field = 'CD_TIPO'
    GeneratorField.Generator = 'TIPOS_GEN'
    GeneratorField.ApplyEvent = gamOnPost
    object tblCadastroCD_TIPO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CD_TIPO'
      Origin = 'TIPOS.CD_TIPO'
    end
    object tblCadastroNO_TIPO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NO_TIPO'
      Origin = 'TIPOS.NO_TIPO'
      Size = 30
    end
    object tblCadastroNR_TIPO: TIBStringField
      DisplayLabel = 'Resumido'
      FieldName = 'NR_TIPO'
      Origin = 'TIPOS.NR_TIPO'
      Size = 15
    end
    object tblCadastroDT_INCLUSAO: TDateTimeField
      DisplayLabel = 'Dt cria'#231#227'o'
      FieldName = 'DT_CRIACAO'
      Origin = 'TIPOS.DT_CRIACAO'
    end
    object tblCadastroDT_ALTERACAO: TDateTimeField
      DisplayLabel = 'Dt altera'#231#227'o'
      FieldName = 'DT_ALTERACAO'
      Origin = 'TIPOS.DT_ALTERACAO'
    end
    object tblCadastroIN_PDA: TIBStringField
      DisplayLabel = 'PDA?'
      FieldName = 'IN_PDA'
      Origin = 'TIPOS.IN_PDA'
      FixedChar = True
      Size = 1
    end
    object tblCadastroID: TIntegerField
      FieldName = 'ID'
      Origin = 'TIPOS.ID'
    end
    object tblCadastroIN_DIRTY: TIBStringField
      DisplayLabel = 'Dirty?'
      FieldName = 'IN_DIRTY'
      Origin = 'TIPOS.IN_DIRTY'
      FixedChar = True
      Size = 1
    end
    object tblCadastroIN_DELETED: TIBStringField
      DisplayLabel = 'Deletado?'
      FieldName = 'IN_DELETED'
      Origin = 'TIPOS.IN_DELETED'
      FixedChar = True
      Size = 1
    end
  end
  inherited CadUpdate: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT *'
      'FROM TIPOS'
      'WHERE CD_TIPO=:CD_TIPO')
    ModifySQL.Strings = (
      'UPDATE TIPOS'
      'SET NO_TIPO=:NO_TIPO,NR_TIPO=:NR_TIPO,'
      '    DT_ALTERACAO='#39'now'#39','
      '    IN_DIRTY='#39'T'#39',IN_DELETED=:IN_DELETED'
      'WHERE CD_TIPO=:OLD_CD_TIPO')
    InsertSQL.Strings = (
      'INSERT INTO TIPOS'
      '(CD_TIPO,NO_TIPO,NR_TIPO,'
      ' DT_CRIACAO,DT_ALTERACAO,'
      ' IN_PDA,ID,IN_DIRTY,IN_DELETED)'
      'VALUES '
      '(:CD_TIPO,:NO_TIPO,:NR_TIPO,'
      ' :DT_CRIACAO,:DT_ALTERACAO,'
      ' '#39'F'#39',0,'#39'T'#39','#39'F'#39')')
    DeleteSQL.Strings = (
      'DELETE FROM TIPOS'
      'WHERE CD_TIPO=:OLD_CD_TIPO')
  end
end
