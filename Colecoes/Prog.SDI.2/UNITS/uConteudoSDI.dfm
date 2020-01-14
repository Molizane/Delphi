inherited FConteudo: TFConteudo
  Left = 297
  Top = 109
  Caption = ' Publica'#231#245'es - Edi'#231#245'es - Conte'#250'do'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcCadastro: TPageControl
    inherited tsGrid: TTabSheet
      inherited grdCadastro: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'NU_PAGINA'
            Width = 42
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TX_CONTEUDO'
            Width = 300
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
            Expanded = False
            FieldName = 'IN_DIRTY'
            Visible = True
          end
          item
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
      inherited lblCodigo: TLabel
        Left = 494
        Top = -41
        Visible = False
      end
      inherited lblDescricao: TLabel
        Top = 15
        Width = 33
        Caption = 'P'#225'gina'
      end
      inherited lblResumida: TLabel
        Top = 42
        Width = 28
        Caption = 'T'#237'tulo'
      end
      inherited pnlCodigo: TDBPanel
        Left = 548
        Top = -45
        DataField = 'CD_CONTEUDO'
        Visible = False
      end
      inherited edtDescricao: TDBEdit
        Left = 53
        Top = 11
        Width = 67
        DataField = 'NU_PAGINA'
      end
      inherited edtResumida: TDBEdit
        Left = 53
        Top = 39
        Width = 614
        Anchors = [akLeft, akTop, akRight]
        DataField = 'TX_CONTEUDO'
      end
    end
  end
  inherited tblCadastro: TIBQuery
    SQL.Strings = (
      'SELECT *'
      'FROM CONTEUDO'
      'WHERE CD_EDICAO=:CD_EDICAO'
      'ORDER BY NU_PAGINA')
    GeneratorField.Field = 'CD_CONTEUDO'
    GeneratorField.Generator = 'CONTEUDO_GEN'
    GeneratorField.ApplyEvent = gamOnPost
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CD_EDICAO'
        ParamType = ptUnknown
      end>
    object tblCadastroCD_CONTEUDO: TIntegerField
      FieldName = 'CD_CONTEUDO'
      Origin = 'CONTEUDO.CD_CONTEUDO'
      Required = True
    end
    object tblCadastroNU_PAGINA: TIntegerField
      DisplayLabel = 'P'#225'gina'
      FieldName = 'NU_PAGINA'
      Origin = 'CONTEUDO.NU_PAGINA'
      Required = True
    end
    object tblCadastroCD_EDICAO: TIntegerField
      FieldName = 'CD_EDICAO'
      Origin = 'CONTEUDO.CD_EDICAO'
      Required = True
    end
    object tblCadastroTX_CONTEUDO: TIBStringField
      DisplayLabel = 'Conte'#250'do'
      FieldName = 'TX_CONTEUDO'
      Origin = 'CONTEUDO.TX_CONTEUDO'
      Size = 100
    end
    object tblCadastroDT_CRIACAO: TDateTimeField
      DisplayLabel = 'Dt cria'#231#227'o'
      FieldName = 'DT_CRIACAO'
      Origin = 'CONTEUDO.DT_CRIACAO'
      Required = True
    end
    object tblCadastroDT_ALTERACAO: TDateTimeField
      DisplayLabel = 'Dt altera'#231#227'o'
      FieldName = 'DT_ALTERACAO'
      Origin = 'CONTEUDO.DT_ALTERACAO'
      Required = True
    end
    object tblCadastroIN_PDA: TIBStringField
      DisplayLabel = 'PDA?'
      FieldName = 'IN_PDA'
      Origin = 'CONTEUDO.IN_PDA'
      Required = True
      FixedChar = True
      Size = 1
    end
    object tblCadastroID: TIntegerField
      FieldName = 'ID'
      Origin = 'CONTEUDO.ID'
      Required = True
    end
    object tblCadastroIN_DIRTY: TIBStringField
      DisplayLabel = 'Dirty?'
      FieldName = 'IN_DIRTY'
      Origin = 'CONTEUDO.IN_DIRTY'
      Required = True
      FixedChar = True
      Size = 1
    end
    object tblCadastroIN_DELETED: TIBStringField
      DisplayLabel = 'Deletado?'
      FieldName = 'IN_DELETED'
      Origin = 'CONTEUDO.IN_DELETED'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  inherited CadUpdate: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT *'
      'FROM CONTEUDO '
      'WHERE CD_CONTEUDO=:CD_CONTEUDO'
      'AND   CD_EDICAO=:CD_EDICAO')
    ModifySQL.Strings = (
      'UPDATE CONTEUDO'
      'SET NU_PAGINA=:NU_PAGINA,'
      '    TX_CONTEUDO=:TX_CONTEUDO,'
      '    DT_ALTERACAO=:DT_ALTERACAO,'
      '    IN_DIRTY='#39'T'#39','
      '    IN_DELETED=:IN_DELETED'
      'WHERE CD_CONTEUDO=:OLD_CD_CONTEUDO'
      'AND   CD_EDICAO=:OLD_CD_EDICAO')
    InsertSQL.Strings = (
      'INSERT INTO CONTEUDO'
      '  (CD_CONTEUDO,NU_PAGINA,CD_EDICAO,TX_CONTEUDO,'
      '   DT_CRIACAO,DT_ALTERACAO,'
      '   IN_PDA,ID,IN_DIRTY,IN_DELETED)'
      'VALUES'
      '  (:CD_CONTEUDO,:NU_PAGINA,:CD_EDICAO,:TX_CONTEUDO,'
      '   :DT_CRIACAO,:DT_ALTERACAO,'
      '   '#39'F'#39',0,'#39'T'#39','#39'F'#39')')
    DeleteSQL.Strings = (
      'DELETE FROM CONTEUDO'
      'WHERE CD_CONTEUDO=:OLD_CD_CONTEUDO'
      'AND   CD_EDICAO=:OLD_CD_EDICAO')
  end
end
