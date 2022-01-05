object Trein: TTrein
  Left = 385
  Top = 410
  Width = 307
  Height = 175
  Caption = 'Treinamento da Rede MLP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnConstruir: TBitBtn
    Left = 38
    Top = 28
    Width = 100
    Height = 70
    Caption = 'Construir'
    TabOrder = 0
    OnClick = btnConstruirClick
  end
  object btnTreinar: TBitBtn
    Left = 158
    Top = 28
    Width = 100
    Height = 70
    Caption = 'Treinar'
    Enabled = False
    TabOrder = 1
    OnClick = btnTreinarClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 120
    Width = 299
    Height = 28
    Panels = <
      item
        Width = 150
      end
      item
        Width = 50
      end>
  end
  object tblSegment: TTable
    BeforeOpen = tblSegmentBeforeOpen
    DatabaseName = 'Segment'
    TableName = 'Segment.db'
    Left = 134
    object tblSegmentID: TIntegerField
      FieldName = 'ID'
    end
    object tblSegmentRenda: TIntegerField
      FieldName = 'Renda'
    end
    object tblSegmentIdade: TIntegerField
      FieldName = 'Idade'
    end
    object tblSegmentSexo: TIntegerField
      FieldName = 'Sexo'
    end
    object tblSegmentTV: TIntegerField
      FieldName = 'TV'
    end
    object tblSegmentRadio: TIntegerField
      FieldName = 'Radio'
    end
    object tblSegmentVideo: TIntegerField
      FieldName = 'Video'
    end
    object tblSegmentInternet: TIntegerField
      FieldName = 'Internet'
    end
    object tblSegmentConjuge: TIntegerField
      FieldName = 'Conjuge'
    end
    object tblSegmentFaixa1: TIntegerField
      FieldName = 'Faixa1'
    end
    object tblSegmentFaixa2: TIntegerField
      FieldName = 'Faixa2'
    end
    object tblSegmentFaixa3: TIntegerField
      FieldName = 'Faixa3'
    end
    object tblSegmentClasse: TIntegerField
      FieldName = 'Classe'
    end
  end
  object dsSegment: TDataSource
    DataSet = tblSegment
    Left = 162
  end
  object KMeans: TKMeans
    Alpha = 0.010000000000000000
    ClusterNum = 3
    Dimension = 2
    ItemsNum = 300
    Knowledge = 'Segment.kme'
    OnGetData = KMeansGetData
    OnGetCluster = KMeansGetCluster
    Left = 106
  end
end
