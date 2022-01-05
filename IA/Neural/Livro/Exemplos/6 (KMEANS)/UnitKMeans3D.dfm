object CgForm1: TCgForm1
  Left = 779
  Top = 193
  AutoScroll = False
  Caption = 'CgForm1'
  ClientHeight = 485
  ClientWidth = 504
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnPaint = FormPaint
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object KMeans: TKMeans
    Alpha = 0.040000000000000000
    ClusterNum = 3
    Dimension = 3
    ItemsNum = 96
    OnGetData = KMeansGetData
    OnGetCluster = KMeansGetCluster
    Left = 462
    Top = 6
  end
  object Timer1: TTimer
    Interval = 31
    OnTimer = Timer1Timer
    Left = 432
    Top = 6
  end
  object Timer2: TTimer
    Interval = 10000
    OnTimer = Timer2Timer
    Left = 402
    Top = 6
  end
end
