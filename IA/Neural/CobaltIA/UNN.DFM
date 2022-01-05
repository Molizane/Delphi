object frmNN: TfrmNN
  Left = 205
  Top = 283
  Width = 397
  Height = 310
  BorderIcons = [biSystemMenu]
  Caption = 'Cobalt A.I. SDK Example'
  Color = clBtnFace
  Constraints.MaxHeight = 310
  Constraints.MaxWidth = 397
  Constraints.MinHeight = 310
  Constraints.MinWidth = 397
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object imgRMSE: TImage
    Left = 34
    Top = 152
    Width = 325
    Height = 105
  end
  object lblCancel: TLabel
    Left = 118
    Top = 122
    Width = 3
    Height = 13
    Caption = ' '
  end
  object lblEpoch: TLabel
    Left = 118
    Top = 26
    Width = 50
    Height = 13
    Caption = '[untrained]'
  end
  object lblPrediction: TLabel
    Left = 118
    Top = 54
    Width = 3
    Height = 13
    Caption = ' '
  end
  object lblBatchPredict: TLabel
    Left = 118
    Top = 84
    Width = 3
    Height = 13
    Caption = ' '
  end
  object btnTrain: TButton
    Left = 32
    Top = 20
    Width = 75
    Height = 25
    Caption = '&Train'
    TabOrder = 0
    OnClick = btnTrainClick
  end
  object btnCancel: TButton
    Left = 34
    Top = 118
    Width = 75
    Height = 25
    Caption = '&Cancel'
    Enabled = False
    TabOrder = 1
  end
  object btnPredict: TButton
    Left = 32
    Top = 50
    Width = 75
    Height = 25
    Caption = '&Predict'
    Enabled = False
    TabOrder = 2
    OnClick = btnPredictClick
  end
  object btnbatchPredict: TButton
    Left = 34
    Top = 82
    Width = 75
    Height = 25
    Caption = '&Batch Predict'
    Enabled = False
    TabOrder = 3
    OnClick = btnbatchPredictClick
  end
  object NN1: TNN
    Left = 272
    Top = 18
    Width = 31
    Height = 26
    OnRMSError = NN1RMSError
    OnEpoch = NN1Epoch
    ControlData = {
      93B2000048000000030008000BF25747200000005F0065007800740065006E00
      740078001A030000030008000AF25747E0FFFFFF5F0065007800740065006E00
      740079007B020000}
  end
  object OD1: TOpenDialog
    FileName = 'NN Train.txt'
    Filter = 'CSV Files|*.csv;*.txt'
    Left = 178
    Top = 34
  end
end
