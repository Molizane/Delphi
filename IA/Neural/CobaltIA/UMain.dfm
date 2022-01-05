object mdiMain: TmdiMain
  Left = 195
  Top = 166
  Width = 544
  Height = 375
  Caption = 'Cobalt A.I. SDK Example'
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 58
    Top = 24
    object menu1: TMenuItem
      Caption = 'menu'
      object GA1: TMenuItem
        Caption = 'GA'
        OnClick = GA1Click
      end
      object FZ1: TMenuItem
        Caption = 'FZ'
        OnClick = FZ1Click
      end
      object NN1: TMenuItem
        Caption = 'NN'
        OnClick = NN1Click
      end
    end
  end
end
