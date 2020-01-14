object FrmModelo: TFrmModelo
  Left = 291
  Top = 94
  Width = 696
  Height = 478
  BorderIcons = []
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MenuGrid
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcCadastro: TPageControl
    Left = 0
    Top = 0
    Width = 688
    Height = 426
    ActivePage = tsGrid
    Align = alClient
    TabOrder = 0
    OnChanging = pcCadastroChanging
    object tsGrid: TTabSheet
      Caption = ' Grid '
      object grdCadastro: TDBGrid
        Left = 0
        Top = 46
        Width = 680
        Height = 352
        Align = alClient
        DataSource = dsCadastro
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = grdCadastroDrawColumnCell
        OnDblClick = grdCadastroDblClick
      end
      object pnlNavegador: TPanel
        Left = 0
        Top = 0
        Width = 680
        Height = 46
        Align = alTop
        BevelOuter = bvLowered
        Caption = ' '
        TabOrder = 1
        object lblF2: TLabel
          Left = 16
          Top = 4
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = 'F2'
          OnClick = lblF2Click
          OnMouseEnter = LabelMouseEnter
          OnMouseLeave = LabelMouseLeave
        end
        object lblF3: TLabel
          Left = 45
          Top = 4
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = 'F3'
          OnClick = lblF3Click
          OnMouseEnter = LabelMouseEnter
          OnMouseLeave = LabelMouseLeave
        end
        object lblF4: TLabel
          Left = 74
          Top = 4
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = 'F4'
          OnClick = lblF4Click
          OnMouseEnter = LabelMouseEnter
          OnMouseLeave = LabelMouseLeave
        end
        object lblF5: TLabel
          Left = 106
          Top = 4
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = 'F5'
          OnClick = lblF5Click
          OnMouseEnter = LabelMouseEnter
          OnMouseLeave = LabelMouseLeave
        end
        object lblF6: TLabel
          Left = 135
          Top = 4
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = 'F6'
          OnClick = lblF6Click
          OnMouseEnter = LabelMouseEnter
          OnMouseLeave = LabelMouseLeave
        end
        object lblF7: TLabel
          Left = 164
          Top = 4
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = 'F7'
          OnClick = lblF7Click
          OnMouseEnter = LabelMouseEnter
          OnMouseLeave = LabelMouseLeave
        end
        object lblF8: TLabel
          Left = 193
          Top = 4
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = 'F8'
          OnClick = lblF8Click
          OnMouseEnter = LabelMouseEnter
          OnMouseLeave = LabelMouseLeave
        end
        object lblF9: TLabel
          Left = 225
          Top = 4
          Width = 12
          Height = 13
          Cursor = crHandPoint
          Caption = 'F9'
          OnClick = lblF9Click
          OnMouseEnter = LabelMouseEnter
          OnMouseLeave = LabelMouseLeave
        end
        object Navegador: TDBNavigator
          Left = 8
          Top = 18
          Width = 87
          Height = 25
          DataSource = dsCadastro
          VisibleButtons = [nbInsert, nbDelete, nbEdit]
          TabOrder = 0
        end
        object DBNavigator1: TDBNavigator
          Left = 98
          Top = 18
          Width = 116
          Height = 25
          DataSource = dsCadastro
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
          TabOrder = 1
        end
        object DBNavigator2: TDBNavigator
          Left = 217
          Top = 18
          Width = 29
          Height = 25
          DataSource = dsCadastro
          VisibleButtons = [nbRefresh]
          TabOrder = 2
        end
      end
    end
    object tsCadastro: TTabSheet
      Caption = '  Cadastro  '
      ImageIndex = 1
      DesignSize = (
        680
        398)
      object lblCodigo: TLabel
        Left = 12
        Top = 15
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object lblDescricao: TLabel
        Left = 12
        Top = 43
        Width = 48
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object lblDtCriacao: TLabel
        Left = 313
        Top = 377
        Width = 53
        Height = 13
        Anchors = [akRight, akBottom]
        Caption = 'Dt. Cria'#231#227'o'
      end
      object lblDtAlteracao: TLabel
        Left = 494
        Top = 377
        Width = 62
        Height = 13
        Anchors = [akRight, akBottom]
        Caption = 'Dt. Altera'#231#227'o'
      end
      object btnMultiplo: TLabel
        Left = 610
        Top = 15
        Width = 57
        Height = 13
        Cursor = crHandPoint
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = '&M'#250'ltiplo (F2)'
        Enabled = False
        Visible = False
        OnClick = btnMultiploClick
        OnMouseEnter = LabelMouseEnter
        OnMouseLeave = LabelMouseLeave
      end
      object pnlCodigo: TDBPanel
        Left = 66
        Top = 11
        Width = 59
        Height = 21
        DataSource = dsCadastro
        DataAlignment = tpaRightJustify
        BevelOuter = bvLowered
        TabOrder = 3
      end
      object edtDescricao: TDBEdit
        Left = 66
        Top = 39
        Width = 291
        Height = 21
        DataSource = dsCadastro
        TabOrder = 0
      end
      object pnlDtCriacao: TDBPanel
        Left = 370
        Top = 373
        Width = 116
        Height = 21
        DataField = 'DT_CRIACAO'
        DataSource = dsCadastro
        DataAlignment = tpaCenter
        Anchors = [akRight, akBottom]
        BevelOuter = bvLowered
        TabOrder = 1
      end
      object pnlDtAlteracao: TDBPanel
        Left = 560
        Top = 373
        Width = 116
        Height = 21
        DataField = 'DT_ALTERACAO'
        DataSource = dsCadastro
        DataAlignment = tpaCenter
        Anchors = [akRight, akBottom]
        BevelOuter = bvLowered
        TabOrder = 2
      end
    end
    object tsMultiplos: TTabSheet
      Caption = '  M'#250'ltiplos  '
      ImageIndex = 2
      object grdMultiplo: TDBGrid
        Left = 18
        Top = 7
        Width = 167
        Height = 400
        DataSource = dsMultiplo
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
      end
    end
  end
  object tblCadastro: TIBQuery
    Database = DMPrincipal.DBColecoes
    Transaction = DMPrincipal.IBTransaction
    ForcedRefresh = True
    AfterCancel = tblCadastroAfterCancel
    AfterEdit = tblCadastroAfterEdit
    AfterInsert = tblCadastroAfterInsert
    BeforeInsert = tblCadastroBeforeInsert
    BeforePost = tblCadastroBeforePost
    BufferChunks = 1000
    CachedUpdates = False
    UpdateObject = CadUpdate
    Left = 18
    Top = 107
  end
  object dsCadastro: TDataSource
    DataSet = tblCadastro
    Left = 80
    Top = 107
  end
  object CadUpdate: TIBUpdateSQL
    Left = 20
    Top = 162
  end
  object MenuGrid: TMainMenu
    Left = 296
    Top = 301
    object smnOK: TMenuItem
      Caption = '&OK  F10'
      ShortCut = 121
      Visible = False
      OnClick = smnOKClick
    end
    object smnFechar: TMenuItem
      Caption = '&Fechar  F11'
      ShortCut = 122
      OnClick = smnFecharClick
    end
  end
  object MenuCadastro: TMainMenu
    Left = 387
    Top = 277
    object smnGravar: TMenuItem
      Caption = '&Gravar  F10'
      ShortCut = 121
      OnClick = smnGravarClick
    end
    object smnCancelar: TMenuItem
      Caption = '&Cancelar  F11'
      ShortCut = 122
      OnClick = smnCancelarClick
    end
  end
  object tblMultiplo: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexFieldNames = 'NU_EDICAO'
    IndexName = 'tblEdicoesPK'
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.02b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 413
    Top = 50
  end
  object dsMultiplo: TDataSource
    DataSet = tblMultiplo
    Left = 421
    Top = 97
  end
end
