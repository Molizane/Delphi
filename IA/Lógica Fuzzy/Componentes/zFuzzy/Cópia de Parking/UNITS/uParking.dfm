object Form1: TForm1
  Left = 15
  Top = 13
  Width = 993
  Height = 542
  Caption = 'Parking'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 634
    Top = 420
    Width = 209
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '0.00 '#176
  end
  object lblDistanciaValor: TLabel
    Left = 17
    Top = 150
    Width = 44
    Height = 13
    Caption = 'Valor=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDistanciaLE: TLabel
    Left = 17
    Top = 166
    Width = 30
    Height = 13
    Caption = 'LE=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDistanciaLC: TLabel
    Left = 17
    Top = 182
    Width = 29
    Height = 13
    Caption = 'MI=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAnguloValor: TLabel
    Left = 16
    Top = 369
    Width = 44
    Height = 13
    Caption = 'Valor=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAnguloRB: TLabel
    Left = 15
    Top = 386
    Width = 32
    Height = 13
    Caption = 'RB=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAnguloRU: TLabel
    Left = 15
    Top = 403
    Width = 33
    Height = 13
    Caption = 'RU=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 624
    Top = 204
    Width = 189
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = #216
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDistanciaCE: TLabel
    Left = 142
    Top = 173
    Width = 31
    Height = 13
    Caption = 'CE=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDistanciaRC: TLabel
    Left = 249
    Top = 166
    Width = 32
    Height = 13
    Caption = 'RC=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDistanciaRI: TLabel
    Left = 249
    Top = 182
    Width = 28
    Height = 13
    Caption = 'RI=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAnguloRV: TLabel
    Left = 15
    Top = 420
    Width = 32
    Height = 13
    Caption = 'RV=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAnguloVE: TLabel
    Left = 142
    Top = 403
    Width = 31
    Height = 13
    Caption = 'VE=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAnguloLV: TLabel
    Left = 249
    Top = 386
    Width = 30
    Height = 13
    Caption = 'LV=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAnguloLU: TLabel
    Left = 249
    Top = 403
    Width = 31
    Height = 13
    Caption = 'LU=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblAnguloLB: TLabel
    Left = 249
    Top = 420
    Width = 30
    Height = 13
    Caption = 'LB=0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object FuzzyDistancia: TzFuzzyfication
    Left = 17
    Top = 18
    Width = 450
    Height = 131
    OnChange = FuzzyDistanciaChange
    FuzzyName = 'Dist'#226'ncia x (m)'
    FuzzyNameFont.Charset = DEFAULT_CHARSET
    FuzzyNameFont.Color = clWindowText
    FuzzyNameFont.Height = -11
    FuzzyNameFont.Name = 'MS Sans Serif'
    FuzzyNameFont.Style = [fsBold]
    FuzzyNameBrush.Color = clBtnFace
    XAxisColor = clRed
    CursorColor = clYellow
    Maximum = 100.000000000000000000
    Minimum = -20.000000000000000000
    Members = <
      item
        Color = clBlack
        Name = 'LE'
        MemberType = tmLInfinity
        Middle = 20.000000000000000000
        EndMember = 32.857142857142900000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'LC'
        MemberType = tmTriangle
        StartMember = 10.000000000000000000
        Middle = 35.714285714285720000
        EndMember = 47.142857142857150000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'CE'
        MemberType = tmTriangle
        StartMember = 32.857142857142850000
        Middle = 45.714285714285720000
        EndMember = 61.428571428571430000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'RC'
        MemberType = tmTriangle
        StartMember = 47.142857142857150000
        Middle = 57.142857142857150000
        EndMember = 82.857142857142860000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'RI'
        MemberType = tmRInfinity
        StartMember = 61.428571428571400000
        Middle = 74.285714285714290000
        EndMember = 100.000000000000000000
        Length = 0
      end>
  end
  object FuzzyAngulo: TzFuzzyfication
    Left = 17
    Top = 237
    Width = 450
    Height = 131
    OnChange = FuzzyAnguloChange
    FuzzyName = #194'ngulo '#248' ('#176')'
    FuzzyNameFont.Charset = DEFAULT_CHARSET
    FuzzyNameFont.Color = clWindowText
    FuzzyNameFont.Height = -11
    FuzzyNameFont.Name = 'MS Sans Serif'
    FuzzyNameFont.Style = [fsBold]
    FuzzyNameBrush.Color = clBtnFace
    XAxisColor = clRed
    CursorColor = clYellow
    Maximum = 288.000000000000000000
    Minimum = -108.000000000000000000
    Members = <
      item
        Color = clBlack
        Name = 'RB'
        MemberType = tmTriangle
        StartMember = -108.000000000000000000
        Middle = -45.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'RU'
        MemberType = tmTriangle
        StartMember = -45.000000000000000000
        EndMember = 45.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'RV'
        MemberType = tmTriangle
        Middle = 63.000000000000000000
        EndMember = 90.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'VE'
        MemberType = tmTriangle
        StartMember = 45.000000000000000000
        Middle = 90.000000000000000000
        EndMember = 139.500000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'LV'
        MemberType = tmTriangle
        StartMember = 90.000000000000000000
        Middle = 126.000000000000000000
        EndMember = 180.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'LU'
        MemberType = tmTriangle
        StartMember = 139.500000000000000000
        Middle = 180.000000000000000000
        EndMember = 225.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'LB'
        MemberType = tmTriangle
        StartMember = 180.000000000000000000
        Middle = 243.000000000000000000
        EndMember = 288.000000000000000000
        Length = 0
      end>
  end
  object FuzzySolution: TzFuzzySolution
    Left = 513
    Top = 286
    Width = 450
    Height = 131
    FuzzyName = #194'ngulo resultante '#216' ('#176')'
    FuzzyNameFont.Charset = DEFAULT_CHARSET
    FuzzyNameFont.Color = clWindowText
    FuzzyNameFont.Height = -11
    FuzzyNameFont.Name = 'MS Sans Serif'
    FuzzyNameFont.Style = [fsBold]
    FuzzyNameBrush.Color = clBtnFace
    XAxisColor = clRed
    CursorColor = clYellow
    Maximum = 40.000000000000000000
    Minimum = -40.000000000000000000
    Members = <
      item
        Color = 66
        Name = 'NB'
        MemberType = tmLInfinity
        StartMember = -40.000000000000000000
        Middle = -30.000000000000000000
        EndMember = -15.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'NM'
        MemberType = tmTriangle
        StartMember = -25.000000000000000000
        Middle = -15.000000000000000000
        EndMember = -5.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'NS'
        MemberType = tmTriangle
        StartMember = -15.000000000000000000
        Middle = -5.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'ZE'
        MemberType = tmTriangle
        StartMember = -5.000000000000000000
        EndMember = 5.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'PS'
        MemberType = tmTriangle
        Middle = 5.000000000000000000
        EndMember = 15.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'PM'
        MemberType = tmTriangle
        StartMember = 5.000000000000000000
        Middle = 15.000000000000000000
        EndMember = 25.000000000000000000
        Length = 0
      end
      item
        Color = clBlack
        Name = 'PB'
        MemberType = tmRInfinity
        StartMember = 15.000000000000000000
        Middle = 30.000000000000000000
        EndMember = 40.000000000000000000
        Length = 0
      end>
    DeltaX = 2.000000000000000000
  end
  object GridDefuzzy: TStringGrid
    Left = 624
    Top = 21
    Width = 189
    Height = 179
    ColCount = 6
    DefaultColWidth = 30
    DefaultRowHeight = 21
    Enabled = False
    RowCount = 8
    TabOrder = 5
    OnDrawCell = GridDefuzzyDrawCell
    RowHeights = (
      21
      21
      21
      21
      21
      21
      21
      21)
  end
  object btnResult: TButton
    Left = 172
    Top = 453
    Width = 75
    Height = 25
    Caption = 'Resultado -->'
    TabOrder = 9
    OnClick = btnResultClick
  end
  object rbAverage: TRadioButton
    Left = 15
    Top = 442
    Width = 113
    Height = 17
    Caption = '&Average'
    TabOrder = 6
  end
  object rbMax: TRadioButton
    Left = 15
    Top = 460
    Width = 113
    Height = 17
    Caption = '&Max'
    TabOrder = 7
  end
  object EditDistancia: TAlignEdit
    Left = 340
    Top = 156
    Width = 121
    Height = 21
    TabOrder = 0
    OnEnter = EditDistanciaEnter
    OnExit = EditDistanciaExit
    Alignment = taRightJustify
    EnterColor = 12189695
    EnterFontColor = clBlack
    IsNumber = True
    ReturnIsTab = True
  end
  object EditAngulo: TAlignEdit
    Left = 340
    Top = 374
    Width = 121
    Height = 21
    TabOrder = 1
    OnEnter = EditDistanciaEnter
    OnExit = EditDistanciaExit
    Alignment = taRightJustify
    EnterColor = 12189695
    EnterFontColor = clBlack
    IsNumber = True
    ReturnIsTab = True
  end
  object rbMin: TRadioButton
    Left = 15
    Top = 478
    Width = 113
    Height = 17
    Caption = 'M&in'
    Checked = True
    TabOrder = 8
    TabStop = True
  end
  object btnRegras: TBitBtn
    Left = 681
    Top = 231
    Width = 75
    Height = 25
    Caption = 'Regras'
    TabOrder = 10
    OnClick = btnRegrasClick
  end
end
