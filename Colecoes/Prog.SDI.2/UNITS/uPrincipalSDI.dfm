object FPrincipal: TFPrincipal
  Left = 300
  Top = 136
  Width = 696
  Height = 480
  Caption = ' Cole'#231#245'es'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    688
    428)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 18
    Top = 22
    Width = 651
    Height = 46
    Anchors = [akTop]
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object btnCategorias: TLabel
      Left = 17
      Top = 3
      Width = 111
      Height = 18
      Cursor = crHandPoint
      Caption = '&Categorias (F2)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      OnClick = btnCategoriasClick
      OnMouseEnter = LabelMouseEnter
      OnMouseLeave = LabelMouseLeave
    end
    object btnTipos: TLabel
      Left = 178
      Top = 3
      Width = 71
      Height = 18
      Cursor = crHandPoint
      Caption = '&Tipos (F3)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      OnClick = btnTiposClick
      OnMouseEnter = LabelMouseEnter
      OnMouseLeave = LabelMouseLeave
    end
    object btnEditoras: TLabel
      Left = 339
      Top = 3
      Width = 92
      Height = 18
      Cursor = crHandPoint
      Caption = '&Editoras (F4)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      OnClick = btnEditorasClick
      OnMouseEnter = LabelMouseEnter
      OnMouseLeave = LabelMouseLeave
    end
    object btnPublicacoes: TLabel
      Left = 498
      Top = 3
      Width = 120
      Height = 18
      Cursor = crHandPoint
      Caption = '&Publica'#231#245'es (F5)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial Black'
      Font.Style = []
      ParentFont = False
      OnClick = btnPublicacoesClick
      OnMouseEnter = LabelMouseEnter
      OnMouseLeave = LabelMouseLeave
    end
  end
  object MainMenu: TMainMenu
    Left = 202
    Top = 118
    object mnCadastros: TMenuItem
      Caption = '&Cadastros'
      Visible = False
      object smnCategorias: TMenuItem
        Caption = '&Categorias'
        ShortCut = 113
        OnClick = smnCategoriasClick
      end
      object smnTipos: TMenuItem
        Caption = '&Tipos'
        ShortCut = 114
        OnClick = smnTiposClick
      end
      object smnEditoras: TMenuItem
        Caption = '&Editoras'
        ShortCut = 115
        OnClick = smnEditorasClick
      end
      object smnPublicacoes: TMenuItem
        Caption = '&Publica'#231#245'es'
        ShortCut = 116
        OnClick = smnPublicacoesClick
      end
    end
    object mnSair: TMenuItem
      Caption = '&Sair   F11'
      ShortCut = 122
      OnClick = mnSairClick
    end
  end
end
