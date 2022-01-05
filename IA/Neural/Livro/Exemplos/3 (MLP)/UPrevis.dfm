object FPrevis: TFPrevis
  Left = 268
  Top = 346
  Width = 573
  Height = 380
  Caption = 'Exemplo 3 - Modelo de Previs'#227'o'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 4
    Top = 4
    object Geral1: TMenuItem
      Caption = '&Geral'
      object Parmetros1: TMenuItem
        Caption = 'Par'#226'metros'
        OnClick = Parmetros1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair'
        OnClick = Sair1Click
      end
    end
    object MLP1: TMenuItem
      Caption = 'Processamento'
      object ConjuntodeTreinamento1: TMenuItem
        Caption = '&Conjunto de Entrada'
        OnClick = ConjuntodeTreinamento1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Treinamento1: TMenuItem
        Caption = 'Treinamento'
        OnClick = Treinamento1Click
      end
      object Teste1: TMenuItem
        Caption = 'Teste'
        OnClick = Teste1Click
      end
    end
    object Sobre1: TMenuItem
      Caption = 'Sobre...'
      OnClick = Sobre1Click
    end
  end
  object Database1: TDatabase
    Connected = True
    DatabaseName = 'Previs'
    DriverName = 'STANDARD'
    LoginPrompt = False
    Params.Strings = (
      'PATH=C:\Livro\Exemplos\3'
      'DEFAULT DRIVER=PARADOX'
      'ENABLE BCD=FALSE')
    SessionName = 'Default'
    Left = 34
    Top = 4
  end
end
