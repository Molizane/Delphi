object FrmModeloSDI: TFrmModeloSDI
  Left = 300
  Top = 136
  Width = 696
  Height = 445
  Caption = 'FrmModeloSDI'
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
    Height = 393
    ActivePage = tsGrid
    Align = alClient
    TabOrder = 0
    OnChanging = pcCadastroChanging
    object tsGrid: TTabSheet
      Caption = ' Grid '
      object gridCadastro: TDBGrid
        Left = 0
        Top = 46
        Width = 680
        Height = 319
        Align = alClient
        DataSource = dsCadastro
        Options = [dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnDrawColumnCell = gridCadastroDrawColumnCell
        OnDblClick = gridCadastroDblClick
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
          Left = 107
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
          Left = 136
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
          Left = 165
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
          Left = 194
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
        365)
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
        Left = 317
        Top = 362
        Width = 53
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Dt. Cria'#231#227'o'
      end
      object lblDtAlteracao: TLabel
        Left = 498
        Top = 362
        Width = 62
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Dt. Altera'#231#227'o'
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
        Left = 374
        Top = 358
        Width = 113
        Height = 21
        DataField = 'DT_CRIACAO'
        DataSource = dsCadastro
        DataAlignment = tpaCenter
        Anchors = [akTop, akRight]
        BevelOuter = bvLowered
        TabOrder = 1
      end
      object pnlDtAlteracao: TDBPanel
        Left = 564
        Top = 358
        Width = 113
        Height = 21
        DataField = 'DT_ALTERACAO'
        DataSource = dsCadastro
        DataAlignment = tpaCenter
        Anchors = [akTop, akRight]
        BevelOuter = bvLowered
        TabOrder = 2
      end
    end
  end
  object tblCadastro: TIBQuery
    Database = DMPrincipal.DBColecoes
    Transaction = DMPrincipal.IBTransaction
    ForcedRefresh = True
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
    Left = 328
    Top = 342
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
    Left = 398
    Top = 342
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
end
