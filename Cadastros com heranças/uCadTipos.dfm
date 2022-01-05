inherited FCadTipos: TFCadTipos
  Width = 563
  Caption = 'Tipos de Pessoa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcCadastro: TPageControl
    Width = 555
    inherited tsGrid: TTabSheet
      inherited gridCadastro: TDBGrid
        Width = 547
        Columns = <
          item
            Expanded = False
            FieldName = 'ID_TIPO'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NO_TIPO'
            Width = 234
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DT_CRIACAO'
            Width = 112
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DT_ALTERACAO'
            Width = 112
            Visible = True
          end>
      end
      inherited pnlNavegador: TPanel
        Width = 547
        inherited Navegador: TDBNavigator
          Hints.Strings = ()
        end
      end
      inherited pnlBotoesGrid: TPanel
        Width = 547
        inherited btnFechar: TBitBtn
          Left = 459
        end
      end
    end
    inherited tsCadastro: TTabSheet
      inherited lblDtCriacao: TLabel
        Left = 184
      end
      inherited lblDtAlteracao: TLabel
        Left = 365
      end
      inherited edtDescricao: TDBEdit
        DataField = 'NO_TIPO'
      end
      inherited pnlBotoesCadastro: TPanel
        Width = 547
        inherited btnGravar: TBitBtn
          Left = 367
        end
        inherited btnCancelar: TBitBtn
          Left = 459
        end
      end
      inherited pnlDtCriacao: TPanel
        Left = 241
      end
      inherited pnlDtAlteracao: TPanel
        Left = 431
      end
    end
  end
  inherited tblCadastro: TIBQuery
    SQL.Strings = (
      'SELECT * FROM TIPO ORDER BY NO_TIPO')
    GeneratorField.Field = 'ID_TIPO'
    GeneratorField.Generator = 'GEN_TIPO_ID'
    GeneratorField.ApplyEvent = gamOnPost
    Left = 20
    object tblCadastroID_TIPO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 8
      FieldName = 'ID_TIPO'
    end
    object tblCadastroNO_TIPO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 48
      FieldName = 'NO_TIPO'
      Size = 40
    end
    object tblCadastroDT_CRIACAO: TDateTimeField
      DisplayLabel = 'Dt. cria'#231#227'o'
      DisplayWidth = 22
      FieldName = 'DT_CRIACAO'
    end
    object tblCadastroDT_ALTERACAO: TDateTimeField
      DisplayLabel = 'Dt. altera'#231#227'o'
      DisplayWidth = 22
      FieldName = 'DT_ALTERACAO'
    end
  end
  inherited CadUpdate: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT ID_TIPO,NO_TIPO,DT_CRIACAO,DT_ALTERACAO'
      'FROM TIPO'
      'WHERE ID_TIPO=:ID_TIPO')
    ModifySQL.Strings = (
      'UPDATE TIPO'
      'SET NO_TIPO=:NO_TIPO,DT_ALTERACAO=:DT_ALTERACAO'
      'WHERE ID_TIPO= :OLD_ID_TIPO')
    InsertSQL.Strings = (
      'INSERT INTO TIPO (NO_TIPO,DT_CRIACAO,DT_ALTERACAO)'
      'VALUES(:NO_TIPO,:DT_CRIACAO,:DT_ALTERACAO)')
    DeleteSQL.Strings = (
      'DELETE FROM TIPO'
      'WHERE ID_TIPO=:OLD_ID_TIPO')
  end
end
