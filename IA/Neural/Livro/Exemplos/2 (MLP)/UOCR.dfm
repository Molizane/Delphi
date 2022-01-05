object FOCR: TFOCR
  Left = 311
  Top = 269
  Width = 573
  Height = 363
  Caption = 'Exemplo 2 - OCR Experimental'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 16
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
      object ConjuntodeTeste1: TMenuItem
        Caption = 'Conjunto de Teste'
        OnClick = ConjuntodeTeste1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Treinamento1: TMenuItem
        Caption = 'Treinamento (576x10)'
        OnClick = Treinamento1Click
      end
      object Teste1: TMenuItem
        Caption = 'Teste (576x10)'
        OnClick = Teste1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object reinamento1600x101: TMenuItem
        Caption = 'Treinamento (1600x10)'
        OnClick = reinamento1600x101Click
      end
      object este1600x101: TMenuItem
        Caption = 'Teste (1600x10)'
        OnClick = este1600x101Click
      end
    end
    object Sobre1: TMenuItem
      Caption = 'Sobre...'
      OnClick = Sobre1Click
    end
  end
  object Database1: TDatabase
    Connected = True
    DatabaseName = 'OCR'
    DriverName = 'STANDARD'
    LoginPrompt = False
    Params.Strings = (
      'PATH=C:\Livro\Exemplos\2'
      'DEFAULT DRIVER=PARADOX'
      'ENABLE BCD=FALSE')
    SessionName = 'Default'
    Left = 70
    Top = 4
  end
end
