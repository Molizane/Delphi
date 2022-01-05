object Form1: TForm1
  Left = 192
  Top = 109
  Width = 226
  Height = 329
  Caption = 'Análise de Exames'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object inpIdade: TNNSignal
    Max = 1
    Limited = False
    Left = 26
    Top = 26
  end
  object inpPeso: TNNSignal
    Max = 1
    Limited = False
    Left = 26
    Top = 74
  end
  object inpSexo: TNNSignal
    Max = 1
    Limited = False
    Left = 26
    Top = 122
  end
  object inpExame: TNNSignal
    Max = 1
    Limited = False
    Left = 26
    Top = 170
  end
  object NeuralNet1: TNeuralNet
    SignalsInput.Strings = (
      'inpIdade'
      'inpPeso'
      'inpSexo'
      'inpExame'
      'inpResultado')
    SignalsOutput.Strings = (
      'outMuitoBaixo'
      'outBaixo'
      'outNormal'
      'outPoucoAlto'
      'outAlto'
      'outMuitoAlto')
    FileName = 'exames.net'
    Active = True
    LayerInputs = 5
    LayerOutputs = 6
    LayerHiden01 = 15
    LayerHiden02 = 0
    LayerHiden03 = 0
    LayerHiden04 = 0
    LayerHiden05 = 0
    LayerHiden06 = 0
    LayerHiden07 = 0
    LayerHiden08 = 0
    LayerHiden09 = 0
    LayerHiden10 = 0
    Ni = 0.25
    Left = 90
    Top = 136
  end
  object outMuitoBaixo: TNNSignal
    Max = 1
    Limited = True
    Left = 146
    Top = 8
  end
  object outBaixo: TNNSignal
    Max = 1
    Limited = True
    Left = 146
    Top = 56
  end
  object outNormal: TNNSignal
    Max = 1
    Limited = True
    Left = 146
    Top = 104
  end
  object outPoucoAlto: TNNSignal
    Max = 1
    Limited = True
    Left = 146
    Top = 151
  end
  object outAlto: TNNSignal
    Max = 1
    Limited = True
    Left = 146
    Top = 199
  end
  object outMuitoAlto: TNNSignal
    Max = 1
    Limited = True
    Left = 146
    Top = 247
  end
  object inpResultado: TNNSignal
    Max = 1
    Limited = False
    Left = 26
    Top = 218
  end
end
