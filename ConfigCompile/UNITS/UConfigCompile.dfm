object FrmMain: TFrmMain
  Left = 676
  Top = 219
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = ' Configura'#231#245'es de Compila'#231#227'o'
  ClientHeight = 498
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object BtnAplicar: TSpeedButton
    Left = 257
    Top = 278
    Width = 75
    Height = 27
    Caption = 'Aplicar'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
      33333333333F8888883F33330000324334222222443333388F3833333388F333
      000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
      F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
      223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
      3338888300003AAAAAAA33333333333888888833333333330000333333333333
      333333333333333333FFFFFF000033333333333344444433FFFF333333888888
      00003A444333333A22222438888F333338F3333800003A2243333333A2222438
      F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
      22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
      33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
      3333333333338888883333330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    OnClick = BtnAplicarClick
  end
  object DBGrid1: TDBGrid
    Left = 12
    Top = 308
    Width = 613
    Height = 177
    DataSource = DSProjetos
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Caminho'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 12
    Top = 280
    Width = 228
    Height = 25
    DataSource = DSProjetos
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete]
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 1
    Top = 1
    Width = 625
    Height = 271
    BevelOuter = bvLowered
    Caption = ' '
    TabOrder = 2
    object BtnConfiguracoes: TSpeedButton
      Left = 364
      Top = 3
      Width = 21
      Height = 21
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = BtnConfiguracoesClick
    end
    object BtnSair: TSpeedButton
      Left = 538
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Sair'
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
      OnClick = BtnSairClick
    end
    object BtnGravar: TSpeedButton
      Left = 533
      Top = 233
      Width = 82
      Height = 25
      Caption = 'Gravar'
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000024000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
        3333333333388F3333333333000033334224333333333333338338F333333333
        0000333422224333333333333833338F33333333000033422222243333333333
        83333338F3333333000034222A22224333333338F33F33338F33333300003222
        A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
        38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
        2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
        0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
        333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
        33333A2224A2233333333338F338F83300003333333333A2224A333333333333
        8F338F33000033333333333A222433333333333338F338F30000333333333333
        A224333333333333338F38F300003333333333333A223333333333333338F8F3
        000033333333333333A3333333333333333383330000}
      NumGlyphs = 2
      Visible = False
      OnClick = BtnGravarClick
    end
    object BtnCancelar: TSpeedButton
      Left = 444
      Top = 234
      Width = 82
      Height = 25
      Caption = 'Cancelar'
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
      OnClick = BtnCancelarClick
    end
    object GBCompiler: TGroupBox
      Left = 4
      Top = 27
      Width = 392
      Height = 240
      Caption = ' Compiler '
      TabOrder = 0
      object GroupBox2: TGroupBox
        Left = 8
        Top = 18
        Width = 185
        Height = 108
        Caption = ' Code generation '
        TabOrder = 0
        object Label1: TLabel
          Left = 52
          Top = 83
          Width = 105
          Height = 13
          Caption = 'Record field ali&gnment'
          FocusControl = CmbRecordFieldAlignment
        end
        object ChkOptimization: TDBCheckBox
          Left = 8
          Top = 16
          Width = 78
          Height = 17
          Caption = '&Optimization'
          DataField = 'Optimization'
          DataSource = DSConfigs
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ChkStackFrame: TDBCheckBox
          Left = 8
          Top = 37
          Width = 81
          Height = 17
          Caption = '&Stack Frame'
          DataField = 'StackFrame'
          DataSource = DSConfigs
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ChkPentiumSafeFDIV: TDBCheckBox
          Left = 8
          Top = 58
          Width = 109
          Height = 17
          Caption = '&Pentium-safe FDIV'
          DataField = 'PentiumSafeFDIV'
          DataSource = DSConfigs
          TabOrder = 2
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object CmbRecordFieldAlignment: TDBComboBox
          Left = 7
          Top = 79
          Width = 42
          Height = 21
          Style = csDropDownList
          DataField = 'RecordFieldAlignment'
          DataSource = DSConfigs
          ItemHeight = 13
          Items.Strings = (
            '1'
            '2'
            '4'
            '8')
          TabOrder = 3
        end
      end
      object GroupBox3: TGroupBox
        Left = 198
        Top = 19
        Width = 185
        Height = 80
        Caption = ' Runtime errors '
        TabOrder = 1
        object ChkRangeChecking: TDBCheckBox
          Left = 8
          Top = 16
          Width = 97
          Height = 17
          Caption = '&Range checking'
          DataField = 'RangeChecking'
          DataSource = DSConfigs
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ChkIOChecking: TDBCheckBox
          Left = 8
          Top = 37
          Width = 83
          Height = 17
          Caption = '&I/O checking'
          DataField = 'IOChecking'
          DataSource = DSConfigs
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ChkOverflowChecking: TDBCheckBox
          Left = 8
          Top = 58
          Width = 109
          Height = 17
          Caption = 'O&verflow checking'
          DataField = 'OverflowChecking'
          DataSource = DSConfigs
          TabOrder = 2
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
      object GroupBox4: TGroupBox
        Left = 198
        Top = 103
        Width = 185
        Height = 129
        Caption = ' Debugging '
        TabOrder = 2
        object ChkDebugInformation: TDBCheckBox
          Left = 8
          Top = 16
          Width = 108
          Height = 17
          Caption = '&Debug information'
          DataField = 'DebugInformation'
          DataSource = DSConfigs
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ChkLocalSymbols: TDBCheckBox
          Left = 8
          Top = 34
          Width = 97
          Height = 17
          Caption = '&Local symbols'
          DataField = 'LocalSymbols'
          DataSource = DSConfigs
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ChkReferenceInfo: TDBCheckBox
          Left = 8
          Top = 53
          Width = 97
          Height = 17
          Caption = 'R&eference info'
          DataField = 'ReferenceInfo'
          DataSource = DSConfigs
          TabOrder = 2
          ValueChecked = 'True'
          ValueUnchecked = 'False'
          OnClick = ChkReferenceInfoClick
        end
        object ChkDefinitionsOnly: TDBCheckBox
          Left = 25
          Top = 71
          Width = 97
          Height = 17
          Caption = 'Definitions onl&y'
          DataField = 'DefinitionsOnly'
          DataSource = DSConfigs
          Enabled = False
          TabOrder = 3
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ChkAssertions: TDBCheckBox
          Left = 8
          Top = 89
          Width = 97
          Height = 17
          Caption = '&Assertions'
          DataField = 'Assertions'
          DataSource = DSConfigs
          TabOrder = 4
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ChkUseDebugDcus: TDBCheckBox
          Left = 8
          Top = 108
          Width = 97
          Height = 17
          Caption = '&Use Debug DCUs'
          DataField = 'UseDebugDcus'
          DataSource = DSConfigs
          TabOrder = 5
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
    end
    object GBLinker: TGroupBox
      Left = 408
      Top = 27
      Width = 207
      Height = 196
      Caption = ' Linker '
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 8
        Top = 132
        Width = 185
        Height = 59
        Caption = ' EXE and DLL options '
        TabOrder = 1
        object ChkIncludeTD32DebugInfo: TDBCheckBox
          Left = 8
          Top = 16
          Width = 140
          Height = 17
          Caption = 'Include TD&32 Debug info'
          DataField = 'IncludeTD32DebugInfo'
          DataSource = DSConfigs
          TabOrder = 0
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
        object ChkIncludeRemoteDebugSymbols: TDBCheckBox
          Left = 8
          Top = 37
          Width = 162
          Height = 17
          Caption = 'Include re&mote debug symbols'
          DataField = 'IncludeRemoteDebugSymbols'
          DataSource = DSConfigs
          TabOrder = 1
          ValueChecked = 'True'
          ValueUnchecked = 'False'
        end
      end
      object RBMapFile: TDBRadioGroup
        Left = 8
        Top = 18
        Width = 185
        Height = 105
        Caption = ' Map file '
        DataField = 'MapFile'
        DataSource = DSConfigs
        Items.Strings = (
          'O&ff'
          'Segme&nts'
          'Pu&blics'
          'De&tailed')
        TabOrder = 0
        Values.Strings = (
          '0'
          '1'
          '2'
          '3')
      end
    end
    object DBNavigator2: TDBNavigator
      Left = 277
      Top = 3
      Width = 84
      Height = 21
      DataSource = DSConfigs
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 2
    end
    object ZDBLookupComboBox1: TPanel
      Left = 4
      Top = 3
      Width = 272
      Height = 21
      BevelInner = bvLowered
      Caption = ' '
      Color = 8454143
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 3
      object DBTextNomeConfig: TDBText
        Left = 5
        Top = 4
        Width = 263
        Height = 14
        Color = 8454143
        DataField = 'Nome'
        DataSource = DSConfigs
        ParentColor = False
        Transparent = False
      end
    end
  end
  object DSProjetos: TDataSource
    DataSet = cdsProjetos
    Left = 173
    Top = 378
  end
  object SelectProject: TOpenDialog
    Filter = 'Projetos Delphi (*.dpr;*.dpk)|*.dpr;*.dpk'
    Options = [ofReadOnly, ofHideReadOnly, ofEnableSizing]
    Title = 'Selecionar projeto Delphi'
    Left = 265
    Top = 315
  end
  object DSConfigs: TDataSource
    DataSet = cdsConfigs
    OnStateChange = DSConfigsStateChange
    Left = 119
    Top = 375
  end
  object cdsProjetos: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cdsProjetosBeforeInsert
    AfterInsert = cdsProjetosAfterInsert
    AfterPost = cdsProjetosAfterPost
    AfterDelete = cdsProjetosAfterDelete
    Left = 453
    Top = 358
    object cdsProjetosSeq: TIntegerField
      FieldName = 'Seq'
      Required = True
    end
    object cdsProjetosCaminho: TStringField
      FieldName = 'Caminho'
      Required = True
      Size = 500
    end
  end
  object cdsConfigs: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cdsConfigsIndex1'
        Fields = 'Seq'
        Options = [ixPrimary, ixUnique]
      end>
    Params = <>
    StoreDefs = True
    BeforeInsert = cdsConfigsBeforeInsert
    AfterInsert = cdsConfigsAfterInsert
    AfterPost = cdsConfigsAfterPost
    AfterDelete = cdsConfigsAfterDelete
    AfterScroll = cdsConfigsAfterScroll
    Left = 395
    Top = 364
    object cdsConfigsSeq: TIntegerField
      FieldName = 'Seq'
      Required = True
    end
    object cdsConfigsNome: TStringField
      FieldName = 'Nome'
      Required = True
      Size = 50
    end
    object cdsConfigsOptimization: TBooleanField
      FieldName = 'Optimization'
      Required = True
    end
    object cdsConfigsStackFrame: TBooleanField
      FieldName = 'StackFrame'
      Required = True
    end
    object cdsConfigsPentiumSafeFDIV: TBooleanField
      FieldName = 'PentiumSafeFDIV'
      Required = True
    end
    object cdsConfigsRecordFieldAlignment: TIntegerField
      DefaultExpression = '8'
      FieldName = 'RecordFieldAlignment'
      Required = True
    end
    object cdsConfigsRangeChecking: TBooleanField
      FieldName = 'RangeChecking'
      Required = True
    end
    object cdsConfigsIOChecking: TBooleanField
      FieldName = 'IOChecking'
      Required = True
    end
    object cdsConfigsOverflowChecking: TBooleanField
      FieldName = 'OverflowChecking'
      Required = True
    end
    object cdsConfigsDebugInformation: TBooleanField
      FieldName = 'DebugInformation'
      Required = True
    end
    object cdsConfigsLocalSymbols: TBooleanField
      FieldName = 'LocalSymbols'
      Required = True
    end
    object cdsConfigsReferenceInfo: TBooleanField
      FieldName = 'ReferenceInfo'
      Required = True
      OnChange = cdsConfigsReferenceInfoChange
    end
    object cdsConfigsDefinitionsOnly: TBooleanField
      FieldName = 'DefinitionsOnly'
      Required = True
    end
    object cdsConfigsAssertions: TBooleanField
      FieldName = 'Assertions'
      Required = True
    end
    object cdsConfigsUseDebugDcus: TBooleanField
      FieldName = 'UseDebugDcus'
      Required = True
    end
    object cdsConfigsMapFile: TIntegerField
      FieldName = 'MapFile'
      Required = True
    end
    object cdsConfigsIncludeTD32DebugInfo: TBooleanField
      FieldName = 'IncludeTD32DebugInfo'
      Required = True
    end
    object cdsConfigsIncludeRemoteDebugSymbols: TBooleanField
      FieldName = 'IncludeRemoteDebugSymbols'
      Required = True
    end
  end
end
