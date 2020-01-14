object FrmModelo: TFrmModelo
  Left = 441
  Top = 209
  Width = 696
  Height = 480
  Caption = 'FrmModelo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
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
    Width = 680
    Height = 441
    ActivePage = tsGrid
    Align = alClient
    TabOrder = 0
    OnChanging = pcCadastroChanging
    object tsGrid: TTabSheet
      Caption = ' Grid '
      object gridCadastro: TDBGrid
        Left = 0
        Top = 34
        Width = 672
        Height = 346
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
        Width = 672
        Height = 34
        Align = alTop
        BevelOuter = bvLowered
        Caption = ' '
        TabOrder = 1
        object Navegador: TDBNavigator
          Left = 8
          Top = 5
          Width = 232
          Height = 25
          DataSource = dsCadastro
          VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbRefresh]
          TabOrder = 0
        end
      end
      object pnlBotoesGrid: TPanel
        Left = 0
        Top = 380
        Width = 672
        Height = 33
        Align = alBottom
        BevelOuter = bvLowered
        Caption = ' '
        TabOrder = 2
        DesignSize = (
          672
          33)
        object btnFechar: TBitBtn
          Left = 592
          Top = 4
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '&Fechar'
          ModalResult = 3
          TabOrder = 0
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
            F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
            000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
            338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
            45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
            3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
            F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
            000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
            338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
            4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
            8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
            333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
            0000}
          NumGlyphs = 2
        end
        object btnAceitar: TBitBtn
          Left = 506
          Top = 4
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '&OK'
          Default = True
          ModalResult = 1
          TabOrder = 1
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333330000333333333333333333333333F33333333333
            00003333344333333333333333388F3333333333000033334224333333333333
            338338F3333333330000333422224333333333333833338F3333333300003342
            222224333333333383333338F3333333000034222A22224333333338F338F333
            8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
            33333338F83338F338F33333000033A33333A222433333338333338F338F3333
            0000333333333A222433333333333338F338F33300003333333333A222433333
            333333338F338F33000033333333333A222433333333333338F338F300003333
            33333333A222433333333333338F338F00003333333333333A22433333333333
            3338F38F000033333333333333A223333333333333338F830000333333333333
            333A333333333333333338330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
      end
    end
    object tsCadastro: TTabSheet
      Caption = '  Cadastro  '
      ImageIndex = 1
      DesignSize = (
        672
        413)
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
        Top = 362
        Width = 53
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Dt. Cria'#231#227'o'
      end
      object lblDtAlteracao: TLabel
        Left = 494
        Top = 362
        Width = 62
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Dt. Altera'#231#227'o'
      end
      object pnlCodigo: TDBPanel
        Left = 66
        Top = 11
        Width = 89
        Height = 21
        DataSource = dsCadastro
        DataAlignment = tpaRightJustify
        BevelOuter = bvLowered
        TabOrder = 0
      end
      object edtDescricao: TDBEdit
        Left = 66
        Top = 39
        Width = 291
        Height = 21
        DataSource = dsCadastro
        TabOrder = 1
      end
      object pnlBotoesCadastro: TPanel
        Left = 0
        Top = 380
        Width = 672
        Height = 33
        Align = alBottom
        BevelOuter = bvLowered
        Caption = ' '
        TabOrder = 2
        DesignSize = (
          672
          33)
        object btnGravar: TBitBtn
          Left = 492
          Top = 4
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '&Gravar'
          TabOrder = 0
          OnClick = btnGravarClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333330000333333333333333333333333F33333333333
            00003333344333333333333333388F3333333333000033334224333333333333
            338338F3333333330000333422224333333333333833338F3333333300003342
            222224333333333383333338F3333333000034222A22224333333338F338F333
            8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
            33333338F83338F338F33333000033A33333A222433333338333338F338F3333
            0000333333333A222433333333333338F338F33300003333333333A222433333
            333333338F338F33000033333333333A222433333333333338F338F300003333
            33333333A222433333333333338F338F00003333333333333A22433333333333
            3338F38F000033333333333333A223333333333333338F830000333333333333
            333A333333333333333338330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
        object btnCancelar: TBitBtn
          Left = 584
          Top = 4
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = '&Cancelar'
          TabOrder = 1
          OnClick = btnCancelarClick
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            333333333333333333333333000033338833333333333333333F333333333333
            0000333911833333983333333388F333333F3333000033391118333911833333
            38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
            911118111118333338F3338F833338F3000033333911111111833333338F3338
            3333F8330000333333911111183333333338F333333F83330000333333311111
            8333333333338F3333383333000033333339111183333333333338F333833333
            00003333339111118333333333333833338F3333000033333911181118333333
            33338333338F333300003333911183911183333333383338F338F33300003333
            9118333911183333338F33838F338F33000033333913333391113333338FF833
            38F338F300003333333333333919333333388333338FFF830000333333333333
            3333333333333333333888330000333333333333333333333333333333333333
            0000}
          NumGlyphs = 2
        end
      end
      object pnlDtCriacao: TDBPanel
        Left = 370
        Top = 358
        Width = 116
        Height = 21
        DataField = 'DT_CRIACAO'
        DataSource = dsCadastro
        DataAlignment = tpaCenter
        Anchors = [akTop, akRight]
        BevelOuter = bvLowered
        TabOrder = 3
      end
      object pnlDtAlteracao: TDBPanel
        Left = 560
        Top = 358
        Width = 116
        Height = 21
        DataField = 'DT_ALTERACAO'
        DataSource = dsCadastro
        DataAlignment = tpaCenter
        Anchors = [akTop, akRight]
        BevelOuter = bvLowered
        TabOrder = 4
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
end
