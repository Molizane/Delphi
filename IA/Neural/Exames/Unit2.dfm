object Form2: TForm2
  Left = 192
  Top = 109
  Width = 323
  Height = 358
  Caption = 'Análise de Exames'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 5
    Top = 12
    Width = 27
    Height = 13
    Caption = 'Idade'
  end
  object Label2: TLabel
    Left = 5
    Top = 35
    Width = 24
    Height = 13
    Caption = 'Peso'
  end
  object Label3: TLabel
    Left = 5
    Top = 61
    Width = 24
    Height = 13
    Caption = 'Sexo'
  end
  object Label4: TLabel
    Left = 5
    Top = 88
    Width = 48
    Height = 13
    Caption = 'Resultado'
  end
  object EditIdade: TEdit
    Left = 41
    Top = 6
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'EditIdade'
    OnChange = EditIdadeChange
  end
  object EditPeso: TEdit
    Left = 41
    Top = 30
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'EditPeso'
    OnChange = EditIdadeChange
  end
  object RBMasculino: TRadioButton
    Left = 41
    Top = 58
    Width = 73
    Height = 17
    Caption = 'Masculino'
    Checked = True
    TabOrder = 2
    TabStop = True
  end
  object RBFeminino: TRadioButton
    Left = 122
    Top = 59
    Width = 70
    Height = 17
    Caption = 'Feminino'
    TabOrder = 3
  end
  object EditResultado: TEdit
    Left = 59
    Top = 84
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'EditResultado'
    OnChange = EditIdadeChange
  end
  object BtnProcessar: TButton
    Left = 9
    Top = 118
    Width = 75
    Height = 25
    Caption = 'Processar'
    Default = True
    TabOrder = 5
    OnClick = BtnProcessarClick
  end
  object RdGrpDecisao: TRadioGroup
    Left = 9
    Top = 148
    Width = 111
    Height = 145
    Caption = ' < Decisão > '
    Items.Strings = (
      'Muito Baixo'
      'Baixo'
      'Normal'
      'Pouco Alto'
      'Alto'
      'Muito Alto')
    TabOrder = 6
  end
  object BtnCorrigir: TButton
    Left = 9
    Top = 298
    Width = 75
    Height = 25
    Caption = 'Corrigir'
    TabOrder = 7
    OnClick = BtnCorrigirClick
  end
  object Panel1: TPanel
    Left = 123
    Top = 154
    Width = 185
    Height = 139
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Caption = ' '
    TabOrder = 8
    object LblMuitoBaixo: TLabel
      Left = 6
      Top = 12
      Width = 66
      Height = 13
      Caption = 'LblMuitoBaixo'
    end
    object LblBaixo: TLabel
      Left = 6
      Top = 33
      Width = 40
      Height = 13
      Caption = 'LblBaixo'
    end
    object LblNormal: TLabel
      Left = 6
      Top = 54
      Width = 47
      Height = 13
      Caption = 'LblNormal'
    end
    object LblPoucoAlto: TLabel
      Left = 6
      Top = 76
      Width = 63
      Height = 13
      Caption = 'LblPoucoAlto'
    end
    object LblAlto: TLabel
      Left = 6
      Top = 97
      Width = 32
      Height = 13
      Caption = 'LblAlto'
    end
    object LblMuitoAlto: TLabel
      Left = 6
      Top = 118
      Width = 58
      Height = 13
      Caption = 'LblMuitoAlto'
    end
  end
  object TblNet: TTable
    Active = True
    DatabaseName = 'Neural'
    TableName = 'ExamesNet'
    Left = 192
    Top = 8
    object TblNetIdExame: TSmallintField
      FieldName = 'IdExame'
    end
    object TblNetIdade: TFloatField
      FieldName = 'Idade'
      Required = True
    end
    object TblNetPeso: TFloatField
      FieldName = 'Peso'
      Required = True
    end
    object TblNetSexo: TSmallintField
      FieldName = 'Sexo'
      Required = True
    end
    object TblNetResultado: TFloatField
      FieldName = 'Resultado'
      Required = True
    end
    object TblNetMuitoBaixo: TSmallintField
      FieldName = 'MuitoBaixo'
    end
    object TblNetBaixo: TSmallintField
      FieldName = 'Baixo'
    end
    object TblNetNormal: TSmallintField
      FieldName = 'Normal'
    end
    object TblNetPoucoAlto: TSmallintField
      FieldName = 'PoucoAlto'
    end
    object TblNetAlto: TSmallintField
      FieldName = 'Alto'
    end
    object TblNetMuitoAlto: TSmallintField
      FieldName = 'MuitoAlto'
    end
  end
end
