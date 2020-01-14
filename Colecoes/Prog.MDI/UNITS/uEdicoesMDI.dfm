inherited FEdicoes: TFEdicoes
  Left = 305
  Top = 112
  Caption = ' Publica'#231#245'es - Edi'#231#245'es'
  ClientWidth = 533
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcCadastro: TPageControl
    Width = 533
    inherited tsGrid: TTabSheet
      inherited grdCadastro: TDBGrid
        Width = 525
        Columns = <
          item
            Expanded = False
            FieldName = 'NU_EDICAO'
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AN_EDICAO'
            Width = 55
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
        Width = 525
        object btnConteudo: TLabel [0]
          Left = 444
          Top = 16
          Width = 73
          Height = 13
          Cursor = crHandPoint
          Anchors = [akTop, akRight]
          Caption = '&Conte'#250'do (F12)'
          OnClick = btnConteudoClick
          OnMouseEnter = LabelMouseEnter
          OnMouseLeave = LabelMouseLeave
        end
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
        Left = 240
        Top = -34
        Visible = False
      end
      inherited lblDescricao: TLabel
        Top = 17
        Width = 12
        Caption = 'N'#186
      end
      inherited lblDtCriacao: TLabel
        Left = 158
      end
      inherited lblDtAlteracao: TLabel
        Left = 339
      end
      inherited lblResumida: TLabel
        Top = 46
        Width = 19
        Caption = 'Ano'
      end
      inherited btnMultiplo: TLabel
        Left = 450
        Visible = True
      end
      inherited pnlCodigo: TDBPanel
        Left = 294
        Top = -38
        DataField = 'CD_EDICAO'
        Visible = False
      end
      inherited edtDescricao: TDBEdit
        Left = 36
        Top = 13
        Width = 55
        DataField = 'NU_EDICAO'
      end
      inherited pnlDtCriacao: TDBPanel
        Left = 215
      end
      inherited pnlDtAlteracao: TDBPanel
        Left = 405
      end
      inherited edtResumida: TDBEdit
        Left = 36
        Top = 42
        Width = 55
        DataField = 'AN_EDICAO'
      end
    end
    inherited tsMultiplos: TTabSheet
      inherited grdMultiplo: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'NU_EDICAO'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'AN_EDICAO'
            Title.Alignment = taCenter
            Visible = True
          end>
      end
    end
  end
  inherited tblCadastro: TIBQuery
    AfterScroll = tblCadastroAfterScroll
    SQL.Strings = (
      'SELECT *'
      'FROM EDICOES'
      'WHERE CD_PUBLICACAO=:CD_PUBLICACAO'
      'ORDER BY NU_EDICAO')
    GeneratorField.Field = 'CD_EDICAO'
    GeneratorField.Generator = 'EDICOES_GEN'
    GeneratorField.ApplyEvent = gamOnPost
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CD_PUBLICACAO'
        ParamType = ptInput
        Value = 0
      end>
    object tblCadastroCD_EDICAO: TIntegerField
      DisplayLabel = 'C'#243'd Edi'#231#227'o'
      FieldName = 'CD_EDICAO'
      Origin = 'EDICOES.CD_EDICAO'
    end
    object tblCadastroCD_PUBLICACAO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CD_PUBLICACAO'
      Origin = 'EDICOES.CD_PUBLICACAO'
      Visible = False
    end
    object tblCadastroAN_EDICAO: TIntegerField
      DisplayLabel = 'Ano'
      FieldName = 'AN_EDICAO'
      Origin = 'EDICOES.AN_EDICAO'
    end
    object tblCadastroNU_EDICAO: TIntegerField
      DisplayLabel = 'N'#186' Edi'#231#227'o'
      FieldName = 'NU_EDICAO'
      Origin = 'EDICOES.NU_EDICAO'
    end
    object tblCadastroDT_CRIACAO: TDateTimeField
      DisplayLabel = 'Dt cria'#231#227'o'
      FieldName = 'DT_CRIACAO'
      Origin = 'EDICOES.DT_CRIACAO'
    end
    object tblCadastroDT_ALTERACAO: TDateTimeField
      DisplayLabel = 'Dt altera'#231#227'o'
      FieldName = 'DT_ALTERACAO'
      Origin = 'EDICOES.DT_ALTERACAO'
    end
    object tblCadastroIN_PDA: TIBStringField
      DisplayLabel = 'PDA?'
      FieldName = 'IN_PDA'
      Origin = 'EDICOES.IN_PDA'
      FixedChar = True
      Size = 1
    end
    object tblCadastroID: TIntegerField
      FieldName = 'ID'
      Origin = 'EDICOES.ID'
    end
    object tblCadastroIN_DIRTY: TIBStringField
      DisplayLabel = 'Dirty?'
      FieldName = 'IN_DIRTY'
      Origin = 'EDICOES.IN_DIRTY'
      FixedChar = True
      Size = 1
    end
    object tblCadastroIN_DELETED: TIBStringField
      DisplayLabel = 'Deletado?'
      FieldName = 'IN_DELETED'
      Origin = 'EDICOES.IN_DELETED'
      FixedChar = True
      Size = 1
    end
  end
  inherited CadUpdate: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT *'
      'FROM EDICOES '
      'WHERE CD_EDICAO=:CD_EDICAO'
      'AND   CD_PUBLICACAO=:CD_PUBLICACAO')
    ModifySQL.Strings = (
      'UPDATE EDICOES'
      'SET AN_EDICAO=:AN_EDICAO,'
      '    NU_EDICAO=:NU_EDICAO,'
      '    DT_ALTERACAO=:DT_ALTERACAO,'
      '    IN_DIRTY='#39'T'#39','
      '    IN_DELETED=:IN_DELETED'
      'WHERE CD_EDICAO=:OLD_CD_EDICAO'
      'AND   CD_PUBLICACAO=:OLD_CD_PUBLICACAO')
    InsertSQL.Strings = (
      'INSERT INTO EDICOES'
      '  (CD_EDICAO,CD_PUBLICACAO,AN_EDICAO,NU_EDICAO,'
      '   DT_CRIACAO,DT_ALTERACAO,'
      '   IN_PDA,ID,IN_DIRTY,IN_DELETED)'
      'VALUES'
      '  (:CD_EDICAO,:CD_PUBLICACAO,:AN_EDICAO,:NU_EDICAO,'
      '   :DT_CRIACAO,:DT_ALTERACAO,'
      '   '#39'F'#39',0,'#39'T'#39','#39'F'#39')')
    DeleteSQL.Strings = (
      'DELETE FROM EDICOES'
      'WHERE CD_EDICAO=:OLD_CD_EDICAO'
      'AND   CD_PUBLICACAO=:OLD_CD_PUBLICACAO')
  end
  inherited tblMultiplo: TkbmMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'NU_EDICAO'
        DataType = ftInteger
      end
      item
        Name = 'AN_EDICAO'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'tblEdicoesPK'
        Fields = 'NU_EDICAO'
        Options = [ixPrimary, ixUnique]
      end>
    object tblMultiploNU_EDICAO: TIntegerField
      DisplayLabel = 'N'#186
      FieldName = 'NU_EDICAO'
    end
    object tblMultiploAN_EDICAO: TIntegerField
      DisplayLabel = 'Ano'
      FieldName = 'AN_EDICAO'
    end
  end
end
