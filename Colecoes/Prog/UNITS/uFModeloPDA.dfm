inherited FrmModeloPDA: TFrmModeloPDA
  Caption = 'FrmModeloPDA'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pcCadastro: TPageControl
    inherited tsGrid: TTabSheet
      inherited pnlNavegador: TPanel
        inherited Navegador: TDBNavigator
          Hints.Strings = ()
        end
      end
    end
    inherited tsCadastro: TTabSheet
      object lblResumida: TLabel [4]
        Left = 12
        Top = 71
        Width = 47
        Height = 13
        Caption = 'Resumida'
      end
      inherited pnlBotoesCadastro: TPanel
        TabOrder = 3
      end
      inherited pnlDtCriacao: TPanel
        TabOrder = 4
      end
      inherited pnlDtAlteracao: TPanel
        TabOrder = 5
      end
      object edtResumida: TDBEdit
        Left = 66
        Top = 67
        Width = 217
        Height = 21
        DataSource = dsCadastro
        TabOrder = 2
      end
    end
  end
end
