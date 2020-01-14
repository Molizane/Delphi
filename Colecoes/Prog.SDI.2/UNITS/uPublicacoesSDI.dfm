inherited FPublicacoes: TFPublicacoes
  Left = 292
  Top = 110
  Caption = ' Publica'#231#245'es'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcCadastro: TPageControl
    inherited tsGrid: TTabSheet
      inherited grdCadastro: TDBGrid
        Columns = <
          item
            Expanded = False
            FieldName = 'CD_PUBLICACAO'
            Width = 42
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NO_PUBLICACAO'
            Width = 125
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NR_PUBLICACAO'
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
            FieldName = 'NO_CATEGORIA'
            Width = 125
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
            Width = 33
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
      object lblTipo: TLabel [5]
        Left = 12
        Top = 99
        Width = 21
        Height = 13
        Caption = 'Tipo'
      end
      object lblCategoria: TLabel [6]
        Left = 12
        Top = 127
        Width = 45
        Height = 13
        Caption = 'Categoria'
      end
      object lblEditora: TLabel [7]
        Left = 12
        Top = 155
        Width = 33
        Height = 13
        Caption = 'Editora'
      end
      object btnTipos: TSpeedButton [8]
        Left = 380
        Top = 95
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 0
        OnClick = btnTiposClick
      end
      object btnCategorias: TSpeedButton [9]
        Left = 380
        Top = 123
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 0
        OnClick = btnCategoriasClick
      end
      object btnEditoras: TSpeedButton [10]
        Left = 380
        Top = 151
        Width = 21
        Height = 21
        Caption = '+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 0
        OnClick = btnEditorasClick
      end
      inherited pnlCodigo: TDBPanel
        DataField = 'CD_PUBLICACAO'
        TabOrder = 6
      end
      inherited edtDescricao: TDBEdit
        DataField = 'NO_PUBLICACAO'
      end
      inherited pnlDtCriacao: TDBPanel
        TabOrder = 7
      end
      inherited pnlDtAlteracao: TDBPanel
        TabOrder = 5
      end
      inherited edtResumida: TDBEdit
        DataField = 'NR_PUBLICACAO'
      end
      object cmbTipo: TDBLookupComboBox
        Left = 66
        Top = 95
        Width = 312
        Height = 21
        DataField = 'CD_TIPO'
        DataSource = dsCadastro
        KeyField = 'CD_TIPO'
        ListField = 'NO_TIPO'
        ListSource = dsTipo
        NullValueKey = 46
        TabOrder = 2
      end
      object cmbCategoria: TDBLookupComboBox
        Left = 66
        Top = 123
        Width = 312
        Height = 21
        DataField = 'CD_CATEGORIA'
        DataSource = dsCadastro
        KeyField = 'CD_CATEGORIA'
        ListField = 'NO_CATEGORIA'
        ListSource = dsCategoria
        NullValueKey = 46
        TabOrder = 3
      end
      object cmbEditora: TDBLookupComboBox
        Left = 66
        Top = 151
        Width = 312
        Height = 21
        DataField = 'CD_EDITORA'
        DataSource = dsCadastro
        KeyField = 'CD_EDITORA'
        ListField = 'NO_EDITORA'
        ListSource = dsEditora
        NullValueKey = 46
        TabOrder = 4
      end
    end
  end
  inherited tblCadastro: TIBQuery
    AfterScroll = tblCadastroAfterScroll
    SQL.Strings = (
      'SELECT P.*,T.NO_TIPO,C.NO_CATEGORIA,E.NO_EDITORA'
      'FROM PUBLICACOES P,TIPOS T,CATEGORIAS C,EDITORAS E'
      'WHERE P.CD_PUBLICACAO=CD_PUBLICACAO'
      'AND   P.CD_TIPO=T.CD_TIPO'
      'AND   P.CD_CATEGORIA=C.CD_CATEGORIA'
      'AND   P.CD_EDITORA=E.CD_EDITORA'
      'ORDER BY NO_PUBLICACAO')
    GeneratorField.Field = 'CD_PUBLICACAO'
    GeneratorField.Generator = 'PUBLICACOES_GEN'
    GeneratorField.ApplyEvent = gamOnPost
    Left = 22
    Top = 303
    object tblCadastroCD_PUBLICACAO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CD_PUBLICACAO'
      Origin = 'PUBLICACOES.CD_PUBLICACAO'
    end
    object tblCadastroCD_EDITORA: TIntegerField
      DisplayLabel = 'C'#243'd. Editora'
      FieldName = 'CD_EDITORA'
      Origin = 'PUBLICACOES.CD_EDITORA'
      Visible = False
    end
    object tblCadastroCD_TIPO: TIntegerField
      DisplayLabel = 'C'#243'd. Tipo'
      FieldName = 'CD_TIPO'
      Origin = 'PUBLICACOES.CD_TIPO'
      Visible = False
    end
    object tblCadastroCD_CATEGORIA: TIntegerField
      DisplayLabel = 'C'#243'd. Categoria'
      FieldName = 'CD_CATEGORIA'
      Origin = 'PUBLICACOES.CD_CATEGORIA'
      Visible = False
    end
    object tblCadastroNO_PUBLICACAO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NO_PUBLICACAO'
      Origin = 'PUBLICACOES.NO_PUBLICACAO'
      Size = 30
    end
    object tblCadastroNR_PUBLICACAO: TIBStringField
      DisplayLabel = 'Resumido'
      FieldName = 'NR_PUBLICACAO'
      Origin = 'PUBLICACOES.NR_PUBLICACAO'
      Size = 15
    end
    object tblCadastroDT_CRIACAO: TDateTimeField
      DisplayLabel = 'Dt cria'#231#227'o'
      FieldName = 'DT_CRIACAO'
      Origin = 'PUBLICACOES.DT_CRIACAO'
    end
    object tblCadastroDT_ALTERACAO: TDateTimeField
      DisplayLabel = 'Dt altera'#231#227'o'
      FieldName = 'DT_ALTERACAO'
      Origin = 'PUBLICACOES.DT_ALTERACAO'
    end
    object tblCadastroIN_PDA: TIBStringField
      DisplayLabel = 'PDA?'
      FieldName = 'IN_PDA'
      Origin = 'PUBLICACOES.IN_PDA'
      FixedChar = True
      Size = 1
    end
    object tblCadastroID: TIntegerField
      FieldName = 'ID'
      Origin = 'PUBLICACOES.ID'
    end
    object tblCadastroIN_DIRTY: TIBStringField
      DisplayLabel = 'Dirty?'
      FieldName = 'IN_DIRTY'
      Origin = 'PUBLICACOES.IN_DIRTY'
      FixedChar = True
      Size = 1
    end
    object tblCadastroIN_DELETED: TIBStringField
      DisplayLabel = 'Deletado'
      FieldName = 'IN_DELETED'
      Origin = 'PUBLICACOES.IN_DELETED'
      FixedChar = True
      Size = 1
    end
    object tblCadastroNO_TIPO: TIBStringField
      DisplayLabel = 'Tipo'
      FieldName = 'NO_TIPO'
      Origin = 'TIPOS.NO_TIPO'
      Size = 30
    end
    object tblCadastroNO_CATEGORIA: TIBStringField
      DisplayLabel = 'Categoria'
      FieldName = 'NO_CATEGORIA'
      Origin = 'CATEGORIAS.NO_CATEGORIA'
      Size = 30
    end
    object tblCadastroNO_EDITORA: TIBStringField
      DisplayLabel = 'Editora'
      FieldName = 'NO_EDITORA'
      Origin = 'EDITORAS.NO_EDITORA'
      Size = 30
    end
  end
  inherited dsCadastro: TDataSource
    Left = 82
    Top = 303
  end
  inherited CadUpdate: TIBUpdateSQL
    RefreshSQL.Strings = (
      'SELECT P.*,T.NO_TIPO,C.NO_CATEGORIA,E.NO_EDITORA'
      'FROM PUBLICACOES P,TIPOS T,CATEGORIAS C,EDITORAS E'
      'WHERE P.CD_PUBLICACAO=:CD_PUBLICACAO'
      'AND   P.CD_TIPO=T.CD_TIPO'
      'AND   P.CD_CATEGORIA=C.CD_CATEGORIA'
      'AND   P.CD_EDITORA=E.CD_EDITORA')
    ModifySQL.Strings = (
      'UPDATE PUBLICACOES'
      'SET '
      '  CD_EDITORA=:CD_EDITORA,'
      '  CD_TIPO=:CD_TIPO,'
      '  CD_CATEGORIA=:CD_CATEGORIA,'
      '  NO_PUBLICACAO=:NO_PUBLICACAO,NR_PUBLICACAO=:NR_PUBLICACAO,'
      '  DT_ALTERACAO=:DT_ALTERACAO,'
      '  IN_DIRTY='#39'T'#39',IN_DELETED=:IN_DELETED'
      'WHERE CD_PUBLICACAO=:OLD_CD_PUBLICACAO')
    InsertSQL.Strings = (
      'INSERT INTO PUBLICACOES'
      '  (CD_PUBLICACAO,'
      '   CD_EDITORA,CD_TIPO,CD_CATEGORIA,'
      '   NO_PUBLICACAO,NR_PUBLICACAO,'
      '   DT_CRIACAO,DT_ALTERACAO,'
      '   IN_PDA,ID,IN_DIRTY,IN_DELETED)'
      'VALUES'
      '  (:CD_PUBLICACAO,'
      '   :CD_EDITORA,:CD_TIPO,:CD_CATEGORIA,'
      '   :NO_PUBLICACAO,:NR_PUBLICACAO,'
      '   :DT_CRIACAO,:DT_ALTERACAO,'
      '   '#39'F'#39',0,'#39'T'#39','#39'F'#39')')
    DeleteSQL.Strings = (
      'DELETE FROM PUBLICACOES'
      'WHERE CD_PUBLICACAO=:OLD_CD_PUBLICACAO')
    Left = 22
    Top = 358
  end
  inherited MenuGrid: TMainMenu
    object smnConteudo: TMenuItem [0]
      Caption = 'Edi'#231#245'es  F12'
      OnClick = smnConteudoClick
    end
  end
  object qryTipos: TIBQuery
    Database = DMPrincipal.DBColecoes
    Transaction = DMPrincipal.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT CD_TIPO,NO_TIPO FROM TIPOS'
      'ORDER BY NO_TIPO')
    Left = 254
    Top = 154
  end
  object qryCategorias: TIBQuery
    Database = DMPrincipal.DBColecoes
    Transaction = DMPrincipal.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT CD_CATEGORIA,NO_CATEGORIA'
      'FROM CATEGORIAS'
      'ORDER BY NO_CATEGORIA')
    Left = 330
    Top = 154
  end
  object qryEditoras: TIBQuery
    Database = DMPrincipal.DBColecoes
    Transaction = DMPrincipal.IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT CD_EDITORA,NO_EDITORA'
      'FROM EDITORAS'
      'ORDER BY NO_EDITORA')
    Left = 427
    Top = 157
  end
  object dsTipo: TDataSource
    DataSet = qryTipos
    Left = 258
    Top = 200
  end
  object dsCategoria: TDataSource
    DataSet = qryCategorias
    Left = 330
    Top = 204
  end
  object dsEditora: TDataSource
    DataSet = qryEditoras
    Left = 398
    Top = 204
  end
end
