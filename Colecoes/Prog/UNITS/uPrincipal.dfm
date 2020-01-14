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
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu: TMainMenu
    Left = 202
    Top = 118
    object mnCadastros: TMenuItem
      Caption = '&Cadastros'
      object smnCategorias: TMenuItem
        Caption = '&Categorias'
        OnClick = smnCategoriasClick
      end
      object smnTipos: TMenuItem
        Caption = '&Tipos'
        OnClick = smnTiposClick
      end
      object smnEditoras: TMenuItem
        Caption = '&Editoras'
        OnClick = smnEditorasClick
      end
      object smnPublicacoes: TMenuItem
        Caption = '&Publica'#231#245'es'
        OnClick = smnPublicacoesClick
      end
    end
    object mnSair: TMenuItem
      Caption = '&Sair'
      OnClick = mnSairClick
    end
  end
end
