object Form1: TForm1
  Left = 331
  Top = 103
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Preenche Vale5'
  ClientHeight = 524
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 6
    Top = 3
    Width = 488
    Height = 516
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object ListBox1: TListBox
    Left = 499
    Top = 4
    Width = 70
    Height = 30
    ItemHeight = 13
    Items.Strings = (
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.45, 91.01, 78.84, 69.59, 58.29, 84.45, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.09, 87.10, 56.62, 62.36, 52.57, 71.72, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.83, 80.01, 28.80, 55.23, 45.39, 66.01, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.88, 71.68, 16.83, 60.25, 49.15, 66.07, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.27, 64.46, 28.59, 59.08, 50.79, 81.15, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.27, 59.13, 43.52, 50.21, 49.32, 77.31, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.08, 54.43, 52.98, 50.97, 48.94, 78.70, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.80, 49.94, 52.03, 43.35, 55.47, 79.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.68, 47.26, 67.13, 48.61, 66.09, 97.35, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.86, 47.58, 81.69, 51.98, 72.14, 97.76, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.22, 51.58, 92.70, 51.56, 69.71, 93.38, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.63, 58.33, 89.51, 43.68, 68.59, 91.69, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.92, 65.64, 82.66, 43.84, 68.02, 88.85, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.81, 71.00, 76.82, 40.78, 66.46, 86.65, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.51, 74.58, 75.75, 48.92, 64.57, 91.15, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.33, 77.82, 82.09, 55.96, 64.45, 97.11, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.29, 81.57, 85.81, 55.80, 60.99, 93.21, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.80, 82.92, 79.24, 53.85, 61.16, 87.54, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.33, 80.87, 63.30, 46.87, 57.22, 82.53, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.73, 75.97, 48.52, 47.67, 55.79, 79.07, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.74, 71.04, 45.22, 52.74, 54.58, 83.98, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.26, 66.77, 44.18, 52.00, 50.61, 81.13, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.76, 62.17, 35.44, 42.44, 43.12, 77.00, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.76, 56.33, 23.20, 30.93, 40.65, 76.74, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.37, 48.96, 15.77, 26.82, 41.22, 77.04, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.34, 41.11, 15.10, 26.18, 39.14, 72.50, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.26, 34.05, 15.68, 32.94, 40.96, 73.57, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.12, 29.17, 19.38, 40.81, 39.80, 75.70, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.01, 27.59, 34.34, 42.44, 46.16, 79.12, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.27, 26.88, 38.87, 34.08, 44.30, 74.78, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.45, 28.37, 57.52, 41.82, 50.03, 83.92, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.47, 32.13, 69.32, 49.19, 53.99, 90.30, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.56, 39.74, 91.71, 54.57, 62.30, 99.26, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (75.08, 47.86, 88.85, 64.94, 63.47, 90.27, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (78.57, 56.39, 91.85, 67.12, 66.46, 99.19, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (82.94, 64.79, 91.28, 74.29, 70.01, 97.73, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.72, 72.84, 91.86, 69.71, 68.59, 89.46, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.17, 78.08, 81.44, 68.46, 60.79, 81.60, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.45, 81.14, 66.47, 66.52, 55.82, 73.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.10, 81.44, 60.18, 72.73, 58.57, 80.83, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.28, 80.82, 63.75, 72.91, 61.25, 90.42, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.45, 79.39, 78.79, 73.71, 62.00, 98.85, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.98, 79.36, 88.58, 73.51, 58.47, 97.36, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.41, 78.78, 86.70, 74.71, 57.65, 91.04, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.48, 77.26, 77.57, 74.88, 59.37, 89.96, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.64, 74.31, 65.28, 68.56, 59.92, 85.50, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.75, 71.62, 57.22, 63.45, 50.78, 83.26, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.07, 69.30, 45.66, 55.03, 46.07, 78.80, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.69, 65.82, 28.83, 48.95, 39.45, 75.83, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.64, 60.36, 14.59, 37.93, 36.76, 73.22, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.06, 53.73, 19.09, 46.57, 45.94, 84.19, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.90, 47.31, 30.80, 52.99, 47.78, 80.29, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.91, 41.64, 35.67, 53.73, 44.32, 75.08, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.26, 35.69, 24.02, 43.64, 42.22, 72.85, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.63, 29.76, 11.98, 34.01, 36.58, 61.14, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.28, 25.68, 20.50, 33.77, 43.00, 71.74, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.66, 23.25, 23.76, 28.78, 40.74, 64.61, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.80, 22.69, 23.84, 27.17, 29.66, 50.69, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.33, 23.10, 18.28, 26.27, 34.38, 56.04, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.03, 23.93, 26.52, 32.35, 39.61, 63.08, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.03, 25.17, 41.95, 38.63, 40.94, 62.83, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.85, 25.86, 41.90, 38.86, 43.16, 53.71, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.53, 26.45, 29.35, 39.10, 34.74, 46.14, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.53, 26.80, 15.14, 40.12, 34.48, 41.41, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.21, 26.14, 14.49, 38.54, 42.05, 47.32, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.75, 25.84, 21.13, 38.20, 37.17, 48.17, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.06, 26.20, 27.02, 39.27, 37.06, 46.82, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.60, 26.57, 21.68, 40.81, 38.11, 42.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.63, 25.03, 12.62, 39.77, 35.05, 31.05, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (29.91, 20.85, 4.33, 29.24, 30.47, 15.16, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.22, 16.74, 4.94, 28.52, 32.78, 15.57, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.93, 14.99, 13.59, 36.93, 35.54, 21.76, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.78, 16.45, 28.29, 36.02, 37.95, 28.65, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.95, 18.81, 35.69, 36.78, 32.04, 24.52, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.54, 20.47, 36.05, 31.70, 31.18, 21.30, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.95, 21.66, 37.79, 36.22, 38.27, 22.92, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.97, 23.72, 40.15, 41.46, 41.06, 18.55, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.60, 27.20, 43.95, 42.87, 41.38, 13.13, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.43, 29.96, 29.15, 35.06, 31.13, 1.65, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.87, 31.73, 20.90, 29.43, 30.26, 5.62, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.19, 31.71, 13.41, 32.69, 33.92, 6.04, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.91, 30.47, 17.14, 37.69, 35.28, 5.39, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.02, 29.15, 23.80, 48.90, 36.68, 11.67, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.92, 27.72, 23.17, 54.19, 36.73, 5.15, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.29, 26.59, 27.65, 61.75, 39.04, 9.37, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.50, 25.71, 32.26, 60.87, 45.65, 12.18, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.23, 25.12, 38.57, 54.01, 40.56, 6.04, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.37, 25.90, 36.20, 44.55, 40.15, 4.23, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.37, 25.91, 20.98, 41.75, 35.39, 1.28, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (29.55, 25.96, 13.83, 35.00, 32.98, 4.15, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.60, 26.56, 22.56, 33.28, 45.78, 14.67, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.93, 28.23, 38.81, 40.75, 46.87, 16.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.39, 32.88, 65.03, 49.96, 51.89, 27.08, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.95, 38.55, 78.71, 58.16, 55.15, 27.87, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.12, 44.39, 84.79, 53.80, 51.60, 22.38, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.87, 48.73, 77.62, 48.57, 57.06, 22.02, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.38, 53.47, 78.89, 47.89, 62.37, 29.06, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.68, 60.28, 82.25, 56.06, 56.40, 25.50, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.52, 68.54, 88.16, 56.83, 54.18, 27.84, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.11, 75.62, 86.28, 55.26, 49.30, 29.85, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.29, 79.37, 72.58, 53.74, 42.98, 23.92, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.88, 80.37, 74.05, 62.27, 53.33, 32.42, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.80, 79.64, 72.10, 73.26, 55.54, 36.69, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.86, 80.02, 88.23, 82.43, 52.50, 38.27, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.94, 80.10, 78.37, 74.49, 52.07, 32.73, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.57, 77.51, 55.59, 65.74, 47.30, 25.90, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.11, 71.61, 29.12, 57.20, 43.52, 23.92, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.72, 62.89, 9.70, 51.04, 44.15, 19.17, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.52, 54.57, 11.43, 55.61, 41.77, 22.26, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.98, 47.99, 13.33, 60.03, 39.00, 21.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.49, 42.58, 25.32, 50.82, 44.71, 25.30, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.04, 38.37, 34.28, 51.35, 53.34, 25.90, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.09, 34.83, 56.30, 54.21, 58.28, 30.32, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.67, 34.19, 72.68, 57.09, 62.86, 34.59, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.26, 37.01, 80.90, 55.86, 63.31, 31.44, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.65, 41.49, 69.48, 48.02, 56.18, 26.17, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.00, 46.61, 55.76, 39.86, 59.81, 27.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.01, 49.32, 35.84, 33.97, 46.67, 18.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.88, 50.15, 20.83, 34.84, 37.76, 16.47, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.57, 49.29, 17.53, 40.95, 45.38, 24.11, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.36, 49.23, 33.74, 48.29, 47.14, 30.38, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.59, 48.37, 48.57, 48.32, 45.74, 26.53, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.22, 46.33, 54.34, 43.48, 46.68, 27.32, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.41, 44.30, 62.59, 43.79, 47.87, 33.46, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.98, 45.17, 77.37, 49.54, 53.28, 35.03, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.24, 48.37, 84.52, 43.17, 52.13, 34.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.55, 54.18, 88.18, 39.90, 52.08, 39.54, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.90, 61.67, 88.23, 37.66, 53.53, 43.01, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.17, 70.23, 94.58, 49.93, 64.03, 55.56, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.94, 76.40, 89.20, 60.04, 62.06, 55.30, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.53, 80.57, 86.11, 60.86, 63.39, 56.37, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.36, 84.14, 86.52, 69.25, 66.23, 61.60, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.75, 86.98, 88.07, 75.47, 66.63, 64.86, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.80, 87.17, 79.14, 68.25, 56.11, 57.27, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.34, 85.07, 65.60, 60.73, 53.78, 62.39, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.13, 82.28, 63.06, 66.63, 56.75, 71.60, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.77, 80.65, 73.54, 75.36, 63.06, 79.61, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.28, 79.87, 87.63, 77.49, 66.16, 92.60, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.79, 80.42, 94.08, 80.18, 66.16, 98.09, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.63, 81.23, 93.48, 76.34, 68.69, 93.92, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.72, 81.71, 90.77, 76.60, 76.10, 96.68, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.84, 81.78, 88.68, 76.61, 74.86, 95.25, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.27, 82.99, 90.09, 75.50, 69.01, 95.16, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.01, 85.04, 84.02, 70.35, 61.88, 88.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.09, 86.91, 79.88, 71.57, 58.93, 92.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.92, 87.81, 81.68, 72.29, 59.20, 98.54, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.44, 87.15, 81.68, 72.55, 55.16, 92.39, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.94, 84.84, 73.29, 73.43, 48.12, 85.96, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.41, 80.67, 55.97, 72.67, 47.72, 84.37, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.42, 77.11, 58.72, 73.40, 52.58, 95.58, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.90, 75.17, 71.17, 73.12, 58.06, 96.70, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.36, 74.58, 84.81, 72.48, 53.99, 94.86, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.06, 73.76, 76.68, 58.83, 42.61, 84.93, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.95, 72.24, 66.16, 58.26, 51.54, 86.44, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.05, 70.18, 63.16, 59.69, 55.88, 91.98, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.83, 67.79, 60.14, 53.69, 50.69, 83.67, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.85, 65.89, 56.22, 47.11, 47.42, 82.71, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.31, 63.84, 37.52, 46.76, 43.77, 77.07, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.21, 60.88, 32.09, 51.57, 46.34, 80.90, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.05, 57.22, 38.16, 50.42, 55.52, 89.77, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.96, 52.85, 45.56, 44.38, 48.92, 83.32, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.84, 48.83, 40.49, 43.64, 43.81, 75.49, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.93, 45.59, 36.94, 49.11, 53.22, 82.76, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.23, 42.99, 39.76, 48.29, 51.15, 81.78, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.69, 43.18, 61.87, 44.97, 58.06, 86.17, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.77, 44.72, 70.09, 42.29, 55.41, 85.02, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.12, 49.20, 77.80, 53.11, 49.97, 85.60, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.54, 54.46, 79.49, 62.07, 52.49, 89.53, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.19, 59.83, 86.49, 62.56, 60.75, 97.97, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.13, 65.17, 93.61, 69.53, 61.19, 97.93, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.40, 71.33, 95.87, 69.64, 66.17, 98.48, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.28, 77.48, 92.29, 75.99, 61.38, 96.58, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.36, 83.54, 94.33, 76.16, 68.30, 99.95, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.56, 86.78, 91.02, 76.60, 68.56, 96.09, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.72, 88.38, 84.50, 74.56, 60.95, 92.02, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.95, 88.47, 78.65, 81.74, 60.10, 95.52, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.26, 88.64, 80.95, 83.24, 61.27, 98.07, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (77.65, 89.19, 91.48, 84.71, 69.48, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.86, 89.17, 93.48, 85.99, 67.13, 96.54, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.93, 88.76, 92.13, 79.22, 64.32, 96.70, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (80.82, 88.51, 90.07, 81.24, 73.44, 97.78, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (81.26, 88.33, 92.68, 82.17, 77.56, 98.61, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (83.15, 88.83, 95.49, 82.34, 77.33, 98.65, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (83.82, 89.99, 94.95, 83.41, 76.52, 96.79, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (82.08, 91.52, 92.41, 81.87, 74.10, 95.81, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (82.84, 92.50, 89.80, 82.36, 73.85, 96.47, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (83.60, 92.38, 90.41, 75.43, 76.01, 98.40, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (83.82, 92.22, 92.02, 76.00, 73.76, 98.15, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (83.47, 92.35, 93.34, 74.18, 73.86, 98.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.46, 91.53, 82.69, 67.68, 65.20, 92.75, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.74, 86.97, 51.60, 58.40, 50.16, 77.22, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.03, 79.06, 24.30, 48.73, 44.20, 65.67, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.27, 69.54, 9.31, 49.32, 42.23, 67.83, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.91, 61.98, 24.38, 54.18, 44.99, 78.74, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.24, 56.32, 38.80, 51.74, 41.68, 82.17, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.56, 50.75, 40.33, 44.05, 37.81, 69.62, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.56, 44.40, 34.84, 44.64, 44.00, 72.35, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.17, 37.04, 27.11, 44.08, 47.96, 73.17, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.83, 30.66, 25.27, 44.34, 43.27, 64.79, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.55, 27.63, 24.34, 38.33, 46.30, 63.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.75, 26.49, 14.05, 38.74, 35.04, 53.06, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.38, 27.70, 20.16, 38.29, 40.79, 65.12, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.89, 28.74, 33.78, 43.56, 48.19, 76.39, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.23, 30.39, 53.60, 50.36, 41.41, 70.46, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.10, 33.44, 67.81, 58.57, 45.08, 75.64, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.30, 37.13, 68.06, 64.40, 48.72, 72.83, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.71, 42.28, 73.46, 62.65, 46.71, 75.20, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.55, 48.44, 80.71, 63.02, 59.96, 87.27, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.13, 55.76, 90.20, 63.22, 59.30, 95.88, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.14, 64.85, 95.87, 73.74, 56.53, 95.82, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.54, 72.39, 88.01, 65.44, 59.82, 89.06, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.87, 77.87, 83.08, 64.89, 59.58, 92.20, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.39, 80.53, 77.59, 65.56, 60.88, 89.87, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.90, 81.28, 74.51, 64.21, 60.31, 86.27, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.87, 80.65, 62.43, 59.90, 55.48, 78.58, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.24, 78.18, 51.20, 59.80, 50.90, 77.58, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.85, 73.51, 38.72, 55.34, 51.42, 76.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.44, 67.68, 37.68, 53.77, 56.03, 80.64, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.35, 62.67, 50.78, 54.27, 59.46, 89.90, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.21, 60.52, 68.73, 58.57, 60.26, 89.71, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.70, 60.24, 80.51, 52.27, 61.04, 87.45, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.37, 61.24, 86.58, 52.05, 66.50, 94.42, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.45, 62.84, 88.96, 52.17, 67.52, 96.11, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.51, 65.69, 88.01, 45.74, 64.02, 90.38, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.95, 68.90, 80.16, 47.42, 60.53, 91.16, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.67, 71.89, 65.62, 39.06, 48.29, 83.38, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.97, 73.30, 50.38, 39.55, 49.69, 83.84, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.16, 70.92, 29.32, 41.42, 47.56, 80.36, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.02, 67.06, 34.01, 54.10, 47.73, 90.97, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.83, 63.02, 44.17, 54.00, 43.83, 90.74, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.49, 59.03, 50.61, 53.72, 42.64, 85.38, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.16, 52.97, 34.49, 44.42, 39.75, 78.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.73, 44.84, 14.79, 35.21, 35.20, 64.38, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.60, 36.81, 7.88, 27.89, 35.47, 63.81, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.26, 31.44, 17.28, 33.90, 42.43, 73.55, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.26, 29.24, 30.61, 32.85, 33.35, 73.55, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.45, 31.04, 45.51, 31.29, 40.50, 78.58, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.45, 32.93, 51.05, 37.07, 43.00, 78.30, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.35, 33.81, 52.07, 36.64, 41.93, 70.41, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.12, 34.17, 53.83, 44.06, 49.72, 73.36, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.20, 36.83, 58.43, 42.44, 48.37, 69.41, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.37, 42.92, 69.64, 42.42, 47.21, 71.25, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.71, 50.47, 75.80, 41.48, 49.16, 74.35, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.41, 57.11, 77.07, 36.92, 41.96, 73.43, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.26, 61.31, 68.41, 37.80, 39.13, 68.50, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.95, 62.20, 53.53, 42.71, 41.45, 68.05, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.38, 60.54, 36.03, 47.28, 39.98, 65.62, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.56, 58.85, 36.95, 59.14, 47.63, 66.90, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.77, 57.97, 45.83, 58.21, 42.43, 68.67, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.25, 58.47, 62.98, 52.31, 50.73, 70.78, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.37, 59.36, 77.59, 56.21, 61.47, 95.78, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.00, 60.72, 88.09, 56.74, 64.87, 97.14, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.52, 62.75, 95.32, 66.17, 70.36, 97.50, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.68, 65.25, 90.96, 67.26, 68.10, 91.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.54, 68.97, 87.00, 69.35, 67.19, 90.79, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.31, 74.43, 85.14, 78.27, 71.52, 94.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (75.86, 80.26, 89.45, 79.79, 72.40, 98.45, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (76.63, 85.16, 89.87, 84.46, 63.42, 90.32, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (77.27, 87.91, 87.77, 79.90, 64.17, 91.86, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (80.08, 89.07, 88.00, 82.19, 66.74, 99.26, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (76.98, 89.35, 90.62, 85.80, 70.81, 97.03, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.42, 88.39, 86.67, 80.50, 66.64, 90.32, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.58, 87.70, 84.80, 81.43, 66.95, 97.04, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.11, 87.03, 80.95, 78.97, 60.66, 92.26, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.86, 85.79, 74.00, 73.82, 60.54, 87.30, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.36, 84.02, 73.46, 74.31, 63.84, 98.20, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.41, 82.62, 77.31, 74.91, 62.59, 98.01, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.17, 82.61, 87.71, 76.14, 62.45, 95.40, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.39, 82.15, 83.84, 75.84, 65.50, 94.76, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.12, 81.73, 86.81, 75.91, 68.28, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.40, 81.99, 89.00, 75.72, 69.96, 97.13, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.67, 80.68, 73.02, 66.33, 62.75, 83.41, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.11, 76.87, 46.70, 63.71, 57.59, 76.65, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.15, 71.53, 25.92, 63.57, 53.93, 74.94, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.18, 65.18, 16.32, 57.12, 47.82, 63.07, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.44, 58.06, 13.27, 53.31, 47.44, 56.16, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.59, 49.50, 10.65, 52.63, 39.06, 58.17, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.31, 41.34, 10.42, 49.59, 31.81, 44.38, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.99, 32.42, 6.46, 48.59, 30.20, 33.35, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.24, 23.10, 5.14, 40.99, 32.08, 33.90, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.77, 16.84, 16.66, 40.29, 35.78, 44.38, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.12, 14.49, 25.60, 29.02, 38.83, 38.10, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.98, 15.11, 31.43, 27.79, 41.41, 39.46, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.40, 16.25, 26.61, 21.75, 38.57, 33.52, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.97, 18.29, 31.63, 20.84, 47.40, 42.25, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.53, 21.23, 37.13, 26.66, 53.02, 44.81, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.63, 26.81, 60.58, 32.52, 55.06, 53.66, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.25, 34.94, 79.69, 31.77, 57.03, 58.57, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.67, 44.59, 91.96, 32.35, 61.48, 54.20, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.77, 52.28, 85.90, 38.72, 57.78, 50.93, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.41, 57.95, 76.60, 33.23, 62.52, 50.32, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.38, 61.06, 59.42, 34.73, 57.60, 41.54, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.39, 62.14, 36.34, 32.00, 48.56, 18.07, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.49, 60.72, 18.89, 32.09, 45.98, 15.45, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (28.08, 57.47, 7.85, 25.14, 34.73, 1.26, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.85, 52.05, 11.77, 28.49, 35.62, 9.72, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.47, 44.90, 15.36, 34.84, 37.42, 17.08, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.19, 37.90, 28.93, 39.81, 41.44, 23.37, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.62, 33.26, 44.13, 39.80, 45.86, 33.40, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.09, 30.46, 51.41, 32.98, 48.98, 27.84, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.49, 30.73, 61.92, 26.74, 46.42, 28.55, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.88, 34.81, 73.04, 30.28, 57.92, 36.52, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.66, 41.83, 82.05, 29.24, 53.87, 30.18, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.10, 50.73, 87.97, 24.62, 58.00, 34.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.10, 58.71, 83.57, 30.62, 52.67, 34.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.32, 67.00, 89.96, 37.56, 55.51, 45.96, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.07, 73.55, 87.93, 50.27, 61.64, 49.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.92, 78.12, 85.23, 62.17, 57.06, 51.20, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.83, 81.96, 85.96, 70.74, 62.32, 64.26, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.62, 84.97, 88.99, 78.38, 68.06, 77.43, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.23, 87.32, 94.20, 72.90, 67.58, 75.52, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.40, 88.15, 89.56, 74.03, 64.38, 78.74, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.22, 87.76, 84.42, 67.20, 58.14, 74.64, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.86, 87.61, 82.29, 66.36, 62.04, 78.69, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.96, 86.46, 79.56, 71.00, 66.51, 77.59, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.95, 84.99, 74.71, 64.68, 60.87, 72.73, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.95, 82.83, 65.79, 65.12, 62.12, 72.73, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.03, 77.80, 40.66, 63.50, 51.04, 64.04, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.33, 70.89, 26.82, 57.16, 55.82, 64.53, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.23, 62.79, 21.32, 56.36, 60.14, 69.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.00, 57.55, 42.37, 55.49, 58.89, 73.97, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.44, 55.73, 68.03, 54.52, 63.94, 89.69, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.25, 55.55, 80.74, 52.99, 61.86, 84.71, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.21, 55.89, 82.57, 43.07, 60.12, 82.22, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.72, 56.72, 82.18, 52.29, 69.70, 97.32, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.07, 58.96, 85.96, 51.57, 68.37, 95.40, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.23, 63.96, 85.65, 46.08, 62.99, 86.98, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.78, 68.28, 65.74, 44.57, 55.42, 72.77, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.27, 70.74, 43.42, 38.78, 48.98, 75.50, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.51, 71.40, 48.28, 46.84, 57.80, 95.68, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.26, 70.27, 57.88, 46.44, 56.69, 90.48, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.13, 69.62, 74.89, 53.77, 52.89, 92.50, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.44, 69.05, 77.43, 60.15, 54.79, 97.92, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.36, 69.46, 85.93, 61.06, 58.54, 97.65, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.47, 70.44, 94.76, 62.23, 68.56, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.98, 71.51, 95.24, 61.62, 70.54, 97.98, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.46, 74.35, 91.36, 63.57, 59.97, 93.14, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.26, 77.57, 72.37, 60.16, 57.01, 85.79, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.46, 76.83, 41.60, 50.73, 45.59, 67.66, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.29, 72.29, 17.01, 40.67, 35.98, 57.17, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.49, 64.56, 5.30, 42.29, 33.39, 45.61, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.55, 56.53, 5.17, 42.30, 27.20, 34.33, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.29, 47.93, 8.54, 41.15, 31.56, 38.26, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.34, 38.64, 11.18, 32.54, 35.22, 32.77, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.07, 29.53, 13.27, 41.46, 28.67, 26.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.97, 21.08, 15.24, 34.00, 34.74, 35.81, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.90, 16.41, 30.40, 35.44, 44.26, 57.36, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.98, 17.95, 55.43, 39.30, 50.04, 69.03, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.26, 24.65, 77.32, 34.99, 51.99, 63.25, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.05, 32.53, 76.26, 30.56, 46.23, 48.55, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.05, 39.34, 66.41, 24.45, 41.99, 46.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.65, 45.02, 59.66, 24.03, 55.93, 53.35, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.41, 50.08, 56.70, 32.93, 51.73, 45.61, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.17, 54.10, 49.47, 35.39, 44.46, 37.28, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.68, 56.05, 32.82, 33.90, 40.89, 27.47, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.99, 54.68, 18.09, 32.37, 38.43, 8.37, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.21, 50.09, 14.11, 31.38, 44.88, 13.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.21, 43.18, 15.08, 37.57, 44.35, 13.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (27.36, 36.19, 13.39, 29.62, 36.22, 0.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (24.50, 29.63, 7.37, 30.12, 34.23, 0.80, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (29.13, 23.66, 5.87, 33.61, 37.46, 11.10, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.43, 19.51, 19.39, 34.50, 41.31, 24.33, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.73, 17.47, 31.13, 33.16, 42.75, 17.26, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.97, 17.94, 37.02, 33.85, 39.83, 15.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.89, 21.87, 53.48, 39.28, 51.42, 31.18, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.71, 28.12, 70.36, 45.84, 54.69, 36.43, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.72, 36.50, 90.49, 44.95, 61.05, 40.23, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.95, 45.07, 90.52, 50.32, 61.09, 44.48, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.49, 53.79, 85.85, 52.95, 53.26, 36.12, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.33, 62.32, 82.68, 60.61, 59.91, 43.27, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.08, 69.64, 85.22, 69.37, 64.28, 55.44, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.38, 76.42, 92.20, 70.13, 59.10, 58.40, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.71, 83.06, 96.77, 75.89, 65.09, 66.39, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.93, 87.79, 95.99, 82.68, 64.43, 66.92, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.73, 89.93, 89.61, 74.51, 60.12, 59.01, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.48, 88.57, 78.30, 73.10, 60.96, 57.04, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.58, 85.93, 66.76, 74.65, 56.32, 55.67, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.57, 83.48, 63.78, 80.23, 52.77, 57.42, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.42, 81.20, 62.19, 80.23, 54.67, 58.86, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.75, 77.17, 48.88, 79.98, 44.57, 55.36, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.98, 70.10, 28.59, 73.16, 40.00, 48.67, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.77, 60.93, 14.27, 67.01, 41.72, 48.36, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.68, 51.08, 7.35, 66.98, 39.60, 37.26, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.17, 42.50, 12.42, 61.48, 42.64, 37.87, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.39, 37.36, 32.00, 60.41, 51.06, 55.67, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.44, 34.77, 43.45, 51.96, 41.10, 42.28, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.49, 32.37, 42.20, 44.84, 40.95, 36.50, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.73, 28.74, 29.49, 44.29, 46.60, 43.35, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.12, 28.01, 42.30, 51.45, 51.09, 51.10, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.44, 30.99, 55.43, 49.44, 53.01, 46.47, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.52, 36.48, 63.71, 56.69, 51.33, 48.29, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.83, 43.54, 70.90, 56.74, 48.64, 57.87, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.42, 50.73, 77.10, 49.39, 52.00, 52.47, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.85, 56.29, 82.01, 40.75, 60.51, 53.23, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.19, 60.56, 81.86, 49.71, 59.47, 59.09, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.42, 65.56, 87.20, 59.24, 56.76, 63.19, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.99, 72.80, 94.71, 67.78, 65.38, 70.27, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.74, 77.97, 88.78, 67.71, 63.88, 64.64, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.20, 80.56, 78.73, 60.15, 52.50, 61.14, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.43, 79.65, 55.54, 57.03, 49.41, 54.15, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.67, 75.65, 34.93, 55.68, 46.60, 49.81, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.42, 68.92, 16.55, 46.21, 40.32, 42.58, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.55, 60.53, 6.49, 41.52, 31.51, 37.26, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.82, 51.63, 1.73, 35.13, 24.58, 33.92, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.66, 42.43, 4.45, 41.34, 27.82, 38.78, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.66, 32.92, 9.05, 41.78, 27.58, 38.78, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.42, 24.53, 13.30, 41.83, 32.15, 38.40, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.21, 17.07, 11.57, 41.11, 29.30, 36.58, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.70, 12.15, 11.26, 35.02, 29.30, 33.72, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.45, 9.06, 7.10, 26.40, 26.49, 22.32, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.18, 8.56, 12.10, 19.75, 34.20, 27.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.92, 9.75, 17.18, 23.49, 32.72, 31.13, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.47, 13.57, 36.11, 27.70, 40.94, 42.05, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.32, 18.31, 47.13, 34.15, 43.04, 41.75, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.89, 23.83, 58.68, 39.15, 44.84, 40.94, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.38, 28.32, 53.76, 41.29, 43.07, 34.23, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.26, 34.23, 64.80, 48.49, 58.54, 49.05, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.05, 41.46, 76.33, 55.73, 59.13, 53.96, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.26, 50.64, 89.64, 52.30, 58.46, 57.96, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.14, 58.02, 78.52, 45.57, 52.22, 51.03, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.49, 62.70, 59.38, 45.31, 51.19, 48.43, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.32, 62.39, 33.23, 45.45, 44.31, 29.73, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.66, 59.47, 20.89, 44.95, 49.61, 30.27, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.31, 55.05, 18.88, 54.31, 48.96, 37.84, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.52, 51.82, 24.74, 55.01, 43.00, 31.46, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.50, 47.28, 23.95, 49.86, 42.05, 29.08, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.01, 41.22, 21.75, 50.26, 45.24, 34.49, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.70, 33.28, 18.17, 43.56, 43.35, 24.87, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.29, 26.10, 13.87, 37.12, 43.48, 13.41, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.54, 21.45, 17.60, 45.63, 47.39, 21.52, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.44, 20.18, 21.75, 43.47, 40.99, 16.22, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.53, 20.95, 27.85, 36.80, 44.15, 11.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.41, 22.34, 31.33, 35.71, 48.76, 20.16, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.13, 25.63, 54.40, 42.78, 52.02, 32.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.72, 31.78, 79.27, 48.29, 55.70, 38.32, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.98, 39.98, 95.59, 55.32, 64.12, 40.98, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.93, 48.42, 94.07, 64.32, 60.64, 47.29, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.55, 55.86, 80.89, 57.68, 55.00, 30.79, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.88, 62.52, 77.55, 65.15, 63.85, 47.40, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.92, 68.88, 78.96, 72.22, 62.66, 55.37, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.17, 75.85, 90.55, 66.97, 62.66, 56.04, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.63, 82.33, 89.70, 73.94, 60.98, 62.46, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.56, 86.40, 91.04, 81.43, 62.43, 67.67, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.97, 87.79, 91.72, 81.64, 64.21, 71.54, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.03, 87.55, 93.44, 82.37, 70.87, 80.40, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.41, 87.58, 94.38, 90.29, 69.66, 87.93, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.34, 88.81, 91.98, 83.04, 65.73, 80.29, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.66, 90.11, 89.23, 84.11, 60.06, 81.18, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.88, 91.16, 88.43, 84.58, 63.59, 87.27, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.58, 91.32, 91.91, 84.76, 63.41, 89.22, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.20, 92.22, 97.83, 84.78, 67.88, 93.71, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.33, 93.11, 99.04, 90.13, 75.39, 100.00, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (76.35, 93.85, 98.39, 90.82, 74.88, 98.23, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.54, 93.92, 94.08, 81.52, 76.94, 95.25, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.23, 93.05, 86.55, 80.16, 76.34, 91.72, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.66, 91.39, 77.08, 75.26, 73.79, 87.81, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.93, 89.80, 74.91, 75.38, 75.22, 93.02, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.33, 89.01, 81.29, 76.91, 74.78, 98.68, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.99, 88.84, 90.38, 76.67, 71.50, 97.52, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (77.81, 88.73, 96.87, 77.23, 73.08, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.43, 88.23, 94.51, 76.96, 73.29, 96.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.45, 87.64, 93.07, 67.83, 76.72, 96.96, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (77.09, 86.67, 85.38, 72.06, 71.13, 91.19, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.90, 85.77, 78.45, 66.27, 64.52, 88.05, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.25, 84.22, 63.11, 59.37, 56.54, 79.86, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.35, 81.42, 49.75, 59.03, 55.29, 81.63, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.22, 76.40, 36.06, 57.86, 48.22, 82.99, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.13, 69.87, 31.65, 57.61, 52.21, 82.10, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.90, 63.48, 39.35, 63.77, 56.11, 89.69, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.79, 58.78, 52.17, 67.84, 60.55, 91.26, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.95, 55.59, 64.37, 67.53, 63.08, 91.53, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.35, 54.10, 72.01, 61.11, 66.99, 91.12, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.57, 53.55, 73.52, 56.33, 63.68, 87.84, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.47, 54.83, 74.55, 50.47, 66.50, 87.78, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.53, 58.22, 80.26, 55.56, 69.49, 97.95, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.89, 63.67, 85.13, 62.24, 63.83, 95.88, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.81, 69.08, 80.37, 51.72, 54.61, 90.37, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.48, 73.59, 79.96, 59.99, 64.16, 99.69, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (78.14, 77.18, 84.41, 70.44, 69.43, 99.50, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.27, 80.66, 95.75, 70.06, 70.25, 96.68, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.27, 82.46, 88.15, 61.83, 64.82, 92.02, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.84, 82.83, 76.91, 61.79, 58.25, 88.31, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.47, 82.68, 73.23, 59.94, 61.39, 94.24, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.48, 81.57, 70.21, 53.33, 64.87, 91.69, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.44, 80.21, 72.90, 56.39, 61.26, 93.18, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.02, 79.74, 76.15, 62.83, 57.25, 97.28, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.43, 79.96, 81.91, 68.92, 57.91, 97.95, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.49, 79.25, 78.06, 64.25, 58.43, 94.96, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.38, 76.62, 72.04, 57.16, 66.17, 96.18, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.39, 73.71, 61.99, 57.74, 58.51, 94.02, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.76, 71.47, 56.78, 63.79, 56.23, 93.17, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.55, 69.69, 57.14, 62.49, 55.50, 96.45, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.42, 68.65, 60.86, 59.16, 52.36, 95.74, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.69, 69.32, 78.98, 59.18, 57.61, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.12, 69.69, 79.48, 66.55, 58.48, 96.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.13, 70.71, 91.08, 73.81, 59.95, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.66, 69.40, 66.27, 63.76, 50.43, 87.99, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.60, 67.51, 54.98, 59.98, 59.46, 87.94, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.38, 63.26, 23.77, 50.36, 48.10, 77.03, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.90, 59.75, 25.18, 51.74, 51.22, 82.77, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.23, 55.54, 19.29, 44.94, 48.55, 78.33, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.67, 52.47, 33.20, 53.74, 57.38, 85.64, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.96, 48.45, 42.77, 61.84, 54.90, 88.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.45, 46.75, 64.22, 62.62, 64.23, 95.98, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.22, 45.09, 76.14, 61.86, 59.87, 94.30, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.90, 47.08, 84.21, 56.33, 64.59, 93.84, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.94, 50.22, 83.17, 52.46, 62.58, 93.90, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.73, 56.51, 80.45, 52.92, 59.32, 91.70, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.04, 63.30, 86.21, 53.07, 59.88, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.88, 71.36, 91.91, 54.00, 62.82, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.21, 78.71, 99.29, 64.85, 66.38, 99.20, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (75.78, 84.85, 98.02, 74.32, 71.29, 98.54, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.60, 88.00, 92.62, 74.26, 70.96, 93.92, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.76, 88.86, 83.87, 68.26, 65.65, 89.05, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.90, 87.94, 75.90, 68.25, 68.62, 89.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.28, 87.31, 77.51, 68.61, 68.37, 95.52, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.29, 87.55, 82.59, 68.89, 62.97, 94.58, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.88, 87.28, 83.85, 61.39, 56.16, 92.41, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.15, 85.80, 78.53, 56.15, 55.68, 92.90, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.04, 83.88, 81.98, 63.60, 60.92, 99.46, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.46, 81.69, 78.34, 59.73, 59.41, 92.60, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.07, 80.01, 77.52, 53.06, 63.94, 93.67, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.74, 77.49, 61.16, 47.40, 54.21, 88.20, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.71, 74.52, 49.18, 41.58, 53.29, 85.59, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.94, 72.14, 56.07, 40.51, 59.84, 98.45, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.85, 70.32, 66.29, 43.46, 58.07, 93.81, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.68, 70.45, 84.95, 49.72, 56.48, 95.69, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.68, 70.95, 83.08, 49.47, 61.94, 95.61, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (75.67, 71.86, 90.15, 54.18, 64.42, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (77.01, 73.07, 89.25, 55.19, 63.12, 92.87, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.41, 73.81, 84.19, 48.47, 61.10, 87.79, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.55, 75.46, 76.01, 54.45, 56.70, 89.99, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.45, 76.04, 54.35, 49.75, 44.58, 64.65, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.07, 74.83, 45.19, 51.06, 48.55, 75.39, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.73, 70.69, 29.08, 51.06, 48.43, 68.75, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.36, 64.04, 25.05, 50.16, 41.20, 59.47, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.66, 56.01, 10.86, 49.15, 37.93, 47.80, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.66, 47.72, 15.51, 55.68, 48.84, 69.24, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.87, 40.91, 27.93, 55.78, 47.44, 67.68, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.16, 36.51, 44.63, 53.00, 52.07, 68.86, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.85, 34.83, 60.86, 53.75, 51.85, 74.09, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.11, 37.28, 76.40, 58.92, 52.20, 76.79, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.15, 41.10, 79.60, 53.42, 50.93, 66.11, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.14, 46.22, 75.11, 46.09, 60.66, 72.07, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.80, 51.86, 75.88, 54.12, 56.49, 77.62, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.42, 59.52, 79.77, 48.75, 54.71, 72.05, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.59, 67.47, 87.09, 58.22, 60.62, 80.77, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.66, 74.07, 87.28, 57.01, 57.14, 80.94, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.01, 79.81, 96.30, 56.30, 61.80, 83.74, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.53, 83.04, 89.91, 63.96, 65.56, 79.71, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.34, 84.02, 85.23, 65.32, 61.80, 79.43, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.73, 84.44, 83.39, 65.20, 60.68, 84.06, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.80, 84.84, 78.76, 59.75, 62.65, 79.94, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.25, 82.96, 58.89, 54.04, 52.62, 71.49, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.58, 78.78, 42.20, 53.70, 53.88, 77.14, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.43, 74.16, 45.46, 54.61, 54.36, 82.28, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.02, 71.47, 63.09, 60.35, 60.24, 81.71, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.60, 69.81, 81.37, 68.85, 65.85, 94.51, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.54, 69.61, 88.12, 68.29, 66.09, 98.57, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.18, 70.78, 95.73, 74.90, 69.75, 98.21, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.48, 71.74, 92.08, 73.67, 71.40, 95.56, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.69, 73.17, 91.62, 67.96, 73.06, 97.94, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.07, 76.57, 89.48, 77.75, 65.62, 95.53, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.22, 82.28, 93.60, 76.93, 70.46, 99.69, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.17, 87.55, 92.83, 82.94, 65.72, 97.20, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (76.10, 91.30, 96.88, 83.16, 69.70, 100.00, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (76.87, 92.73, 94.20, 88.59, 68.62, 97.35, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.37, 92.92, 89.89, 85.58, 68.06, 94.24, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.35, 91.06, 78.95, 78.13, 67.56, 92.08, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.61, 89.59, 78.89, 77.67, 71.30, 97.79, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.48, 88.63, 82.96, 78.02, 68.40, 97.84, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.94, 88.73, 90.35, 71.72, 67.84, 97.49, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.18, 88.04, 87.38, 70.65, 59.85, 96.49, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.39, 85.18, 67.12, 64.16, 52.43, 87.72, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.00, 79.91, 49.47, 57.21, 59.97, 87.96, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.66, 73.05, 32.42, 62.53, 55.63, 86.57, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.97, 67.25, 37.70, 61.23, 55.12, 89.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.83, 64.94, 58.14, 62.04, 60.45, 99.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.76, 64.94, 78.96, 64.30, 62.79, 98.16, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.30, 65.43, 87.37, 56.34, 57.87, 91.88, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.83, 63.63, 74.08, 47.77, 62.52, 87.13, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.75, 62.32, 75.62, 57.10, 67.13, 99.25, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.05, 63.22, 75.26, 55.13, 63.46, 89.59, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.27, 66.97, 83.20, 55.28, 61.83, 94.11, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.52, 71.20, 70.52, 49.58, 54.54, 87.04, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.63, 73.50, 58.34, 49.03, 49.05, 84.61, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.54, 72.76, 51.48, 50.40, 57.05, 91.57, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.20, 68.81, 43.42, 48.66, 56.08, 86.03, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.67, 64.43, 47.93, 54.75, 51.78, 88.52, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.46, 60.49, 38.64, 55.82, 52.85, 87.04, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.97, 55.53, 30.95, 50.72, 48.00, 82.73, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.93, 48.94, 16.00, 43.76, 43.35, 77.39, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.01, 40.59, 8.04, 34.52, 39.55, 66.67, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.71, 34.81, 18.50, 40.36, 40.01, 75.87, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.25, 32.23, 35.12, 45.25, 41.34, 78.15, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.68, 31.54, 45.29, 37.51, 36.69, 74.34, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.52, 32.79, 54.64, 47.55, 48.37, 83.03, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.05, 34.84, 66.41, 48.47, 50.94, 87.20, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.99, 40.16, 86.47, 55.22, 60.03, 96.19, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.80, 47.36, 95.80, 61.30, 71.45, 97.77, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.13, 56.59, 99.06, 60.36, 69.57, 97.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.53, 65.52, 88.36, 61.91, 63.53, 87.61, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.56, 71.62, 73.40, 54.23, 64.98, 83.49, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.15, 74.57, 61.73, 53.61, 63.64, 85.77, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.76, 74.94, 48.56, 51.92, 57.15, 74.85, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.68, 73.78, 44.22, 61.06, 58.49, 83.44, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.50, 71.49, 45.82, 70.56, 58.73, 89.69, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.68, 69.24, 66.19, 70.99, 58.34, 95.32, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.57, 68.09, 85.49, 73.00, 65.46, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.34, 66.25, 82.49, 68.91, 56.85, 86.47, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.17, 63.98, 67.88, 61.83, 48.18, 82.49, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.03, 61.97, 55.39, 55.12, 56.05, 87.94, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.49, 61.14, 54.18, 49.61, 51.71, 85.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.86, 61.53, 52.11, 43.45, 48.90, 82.55, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.09, 60.30, 33.11, 37.25, 41.92, 75.94, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.03, 58.22, 27.10, 36.89, 46.64, 77.62, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.62, 52.56, 15.24, 36.63, 45.50, 66.17, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.61, 45.75, 24.22, 37.62, 53.88, 74.87, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.84, 41.30, 42.46, 44.83, 58.18, 88.75, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.71, 41.90, 73.27, 43.44, 58.35, 90.84, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.13, 46.20, 94.11, 42.30, 62.70, 98.15, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.13, 50.82, 95.76, 44.16, 68.45, 98.43, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.77, 55.81, 97.00, 43.63, 67.50, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.18, 62.77, 95.73, 43.75, 75.96, 96.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.12, 70.52, 96.89, 51.52, 79.33, 99.77, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.28, 79.59, 96.89, 62.21, 81.83, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.25, 87.33, 93.83, 67.62, 73.60, 90.45, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.12, 91.75, 82.26, 65.90, 68.70, 83.73, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.75, 91.55, 71.52, 65.81, 69.54, 83.91, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.50, 88.51, 66.66, 71.19, 69.79, 84.97, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.04, 85.55, 69.21, 77.43, 70.22, 88.41, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.56, 82.24, 67.19, 72.82, 62.25, 83.33, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.37, 79.93, 74.90, 72.55, 60.07, 95.98, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.53, 75.83, 60.03, 66.77, 57.65, 80.57, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.99, 70.63, 50.04, 59.21, 56.67, 74.22, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.64, 63.37, 28.48, 50.30, 53.35, 53.30, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.00, 56.87, 23.78, 51.69, 45.76, 45.26, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.91, 52.11, 28.69, 58.81, 51.10, 64.33, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.12, 48.86, 37.42, 59.28, 49.45, 67.57, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.83, 46.71, 49.83, 46.53, 45.59, 66.93, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.40, 45.19, 53.51, 46.01, 48.56, 70.75, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.46, 41.51, 41.81, 45.95, 42.92, 46.82, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.46, 38.97, 37.17, 43.84, 48.84, 46.82, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.18, 37.81, 39.59, 45.68, 55.97, 59.79, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.49, 41.72, 63.67, 47.48, 56.43, 73.74, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.53, 46.76, 69.17, 45.78, 53.21, 53.37, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.32, 49.79, 55.95, 40.18, 49.37, 37.16, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.83, 49.63, 35.99, 46.01, 47.05, 38.39, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.10, 46.11, 18.15, 46.60, 44.70, 14.40, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.89, 41.25, 9.78, 45.17, 34.82, 0.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.23, 37.78, 10.58, 36.43, 43.29, 26.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.78, 36.23, 23.21, 37.08, 41.59, 31.62, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.82, 35.95, 37.01, 36.57, 43.62, 34.57, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.87, 33.82, 44.53, 42.45, 47.63, 42.17, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.95, 32.91, 60.96, 44.74, 54.09, 58.46, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.05, 35.52, 79.45, 51.76, 62.71, 64.97, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.21, 42.01, 94.39, 59.30, 70.75, 74.46, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.37, 50.84, 97.69, 58.84, 68.43, 79.74, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.73, 59.97, 91.94, 51.77, 62.42, 65.39, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.22, 68.83, 90.32, 58.27, 68.12, 78.68, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.45, 75.91, 86.88, 65.50, 64.89, 79.27, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.59, 82.01, 91.90, 65.56, 62.86, 87.34, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.46, 87.41, 93.18, 70.96, 64.14, 92.40, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.97, 91.30, 95.99, 82.37, 64.90, 97.84, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.84, 92.70, 91.99, 82.88, 61.17, 92.94, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.16, 92.50, 92.61, 84.29, 71.73, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.20, 91.09, 85.01, 71.76, 64.22, 88.93, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.89, 90.83, 89.58, 73.80, 68.48, 98.66, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.10, 90.20, 84.72, 74.54, 65.26, 95.15, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.91, 90.95, 93.58, 75.64, 67.70, 99.71, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.98, 90.43, 87.24, 66.87, 61.96, 94.01, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.87, 89.77, 87.21, 59.27, 65.80, 96.13, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.05, 88.71, 86.48, 66.89, 70.24, 98.81, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.24, 88.10, 86.49, 70.89, 67.30, 90.33, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.46, 87.17, 84.25, 64.18, 67.12, 90.88, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.07, 86.42, 78.22, 64.86, 67.02, 92.29, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (78.06, 86.00, 85.77, 67.46, 70.39, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (78.37, 86.86, 92.53, 69.01, 74.90, 99.60, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (79.88, 87.43, 98.64, 74.63, 74.28, 98.80, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (83.06, 88.69, 98.64, 76.01, 74.94, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (78.22, 89.38, 93.41, 83.18, 74.71, 93.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (82.80, 90.26, 94.41, 84.29, 79.17, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (78.36, 90.46, 88.24, 85.69, 73.75, 92.66, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.81, 89.16, 72.56, 73.40, 57.12, 76.58, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.39, 85.36, 44.08, 69.24, 49.56, 71.36, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.95, 78.93, 27.82, 73.67, 50.43, 79.16, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.18, 71.46, 25.32, 69.18, 48.56, 79.57, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.53, 64.37, 34.86, 68.69, 51.58, 83.73, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.46, 57.40, 35.84, 67.10, 43.83, 81.58, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.63, 51.15, 37.21, 62.73, 44.61, 80.74, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.99, 45.34, 42.09, 63.44, 53.81, 87.93, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.99, 40.88, 48.14, 57.76, 54.65, 81.80, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.13, 40.14, 65.88, 57.47, 56.76, 86.91, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.16, 43.53, 74.59, 55.98, 56.57, 86.96, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.49, 47.61, 64.59, 49.62, 48.63, 77.63, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.63, 49.87, 45.61, 42.07, 50.72, 75.38, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.36, 49.70, 33.31, 37.67, 53.12, 78.96, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.05, 49.33, 32.56, 40.67, 48.55, 73.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.32, 49.06, 34.80, 49.09, 54.00, 76.71, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.93, 49.73, 48.06, 49.04, 55.48, 86.01, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.19, 52.50, 73.10, 56.41, 57.41, 95.16, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.37, 54.97, 88.12, 49.31, 61.81, 90.97, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.03, 56.39, 87.39, 57.66, 59.10, 93.82, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.58, 58.00, 79.03, 57.02, 57.52, 90.09, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.29, 60.16, 65.12, 48.14, 54.00, 82.58, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.75, 63.22, 60.82, 55.06, 58.67, 90.97, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.40, 65.68, 54.66, 48.32, 50.88, 86.77, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.36, 67.76, 53.52, 40.17, 42.86, 86.74, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.75, 67.26, 43.60, 38.98, 47.58, 88.68, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.78, 62.25, 27.97, 38.15, 42.15, 78.73, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.19, 55.21, 24.76, 32.99, 45.94, 81.86, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.59, 49.00, 31.49, 40.02, 53.13, 87.96, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.21, 44.96, 42.74, 34.56, 48.35, 83.72, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.09, 41.62, 35.07, 27.89, 44.95, 76.67, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.27, 36.99, 19.15, 19.63, 44.52, 70.77, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.57, 32.30, 12.41, 22.97, 45.74, 72.29, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.91, 28.68, 20.90, 19.57, 50.07, 73.82, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.23, 25.92, 18.80, 19.78, 38.99, 68.48, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.97, 24.78, 17.75, 20.08, 36.73, 68.10, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.17, 25.30, 29.40, 20.60, 44.85, 79.91, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.09, 27.91, 54.97, 29.21, 50.22, 83.95, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.34, 31.52, 75.27, 38.41, 47.94, 84.30, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.16, 36.49, 79.73, 40.38, 45.92, 82.42, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.80, 43.03, 78.02, 42.72, 49.38, 82.33, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.21, 50.89, 83.20, 49.53, 56.38, 87.22, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.05, 58.66, 90.80, 48.70, 60.25, 90.89, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.54, 66.87, 92.73, 48.93, 51.95, 87.46, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.49, 74.74, 88.58, 50.57, 52.17, 87.10, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.45, 79.20, 69.54, 50.60, 50.81, 79.33, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.83, 78.47, 48.40, 43.92, 45.31, 77.19, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.98, 72.50, 21.52, 37.41, 37.62, 64.64, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.18, 64.60, 8.59, 37.43, 35.39, 61.62, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.14, 56.07, 1.24, 37.43, 28.98, 48.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.32, 47.71, 8.00, 37.48, 31.31, 52.87, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.73, 39.51, 16.99, 33.82, 31.72, 57.97, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.79, 32.70, 31.43, 31.48, 35.90, 62.50, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.54, 27.43, 41.13, 35.95, 39.56, 65.29, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.87, 25.80, 54.91, 39.79, 49.48, 72.59, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.67, 27.58, 64.40, 33.66, 45.22, 63.14, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.09, 33.06, 70.90, 27.59, 47.26, 61.43, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.70, 38.83, 60.44, 28.58, 39.30, 49.80, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.74, 44.76, 54.60, 33.24, 38.12, 54.84, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.69, 47.56, 33.26, 34.67, 30.78, 41.95, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.58, 48.41, 24.63, 36.60, 31.95, 28.71, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.64, 46.77, 16.69, 46.43, 31.48, 25.13, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.10, 45.07, 25.82, 46.47, 39.28, 25.37, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.56, 43.46, 40.44, 56.65, 47.79, 34.87, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.90, 40.99, 42.11, 47.57, 44.90, 18.23, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.84, 38.60, 49.43, 41.12, 43.79, 23.02, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.65, 35.79, 35.17, 32.66, 44.40, 6.56, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.32, 33.06, 30.02, 24.67, 43.91, 10.86, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.92, 31.75, 21.41, 30.37, 43.74, 13.86, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.07, 32.57, 32.08, 38.21, 45.41, 23.39, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.06, 33.54, 25.39, 35.70, 32.32, 0.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.31, 33.37, 24.28, 43.48, 39.34, 15.20, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.59, 30.05, 10.58, 38.53, 35.95, 4.16, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.23, 28.02, 23.82, 45.27, 44.53, 23.66, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.08, 25.97, 30.99, 51.98, 49.43, 25.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.83, 27.38, 47.85, 52.94, 47.86, 27.13, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.72, 30.49, 57.99, 59.01, 49.30, 33.19, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.60, 35.21, 63.91, 52.46, 60.65, 30.41, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.10, 40.30, 77.90, 59.07, 63.82, 44.48, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.37, 46.28, 79.17, 57.95, 64.50, 33.12, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.86, 52.42, 79.53, 58.55, 59.75, 29.27, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.32, 58.97, 69.56, 65.47, 57.29, 34.39, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.01, 65.02, 78.25, 64.54, 63.96, 44.79, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.47, 70.92, 84.09, 65.09, 58.56, 48.20, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.12, 75.59, 89.90, 66.28, 59.20, 49.65, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.75, 78.39, 83.22, 64.84, 49.39, 47.13, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.66, 79.35, 72.50, 66.41, 53.58, 41.32, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.68, 78.84, 73.33, 67.72, 60.21, 56.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.83, 78.03, 71.91, 69.14, 54.02, 54.70, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.20, 79.01, 88.34, 69.75, 58.06, 64.98, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.62, 80.76, 85.31, 71.05, 55.81, 64.04, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.38, 82.40, 93.01, 76.71, 58.80, 74.42, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.61, 83.24, 91.70, 76.21, 61.63, 75.02, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.19, 83.89, 95.68, 82.55, 64.71, 74.42, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.79, 85.02, 93.43, 87.79, 62.85, 75.75, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.10, 87.49, 94.74, 88.25, 70.92, 83.39, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.18, 88.08, 78.60, 79.24, 52.59, 65.85, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.31, 86.86, 60.91, 72.67, 56.18, 64.39, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.71, 80.55, 31.53, 73.51, 48.87, 58.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.95, 74.15, 27.74, 73.81, 48.92, 64.05, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.86, 65.74, 17.29, 74.02, 45.14, 57.01, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.74, 57.32, 15.97, 67.30, 41.73, 53.16, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.55, 47.27, 5.19, 57.56, 33.69, 40.60, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.76, 38.58, 15.21, 56.75, 46.44, 56.74, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.12, 30.77, 24.47, 55.15, 42.74, 55.48, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.03, 26.99, 44.56, 48.12, 48.73, 57.14, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.26, 26.06, 52.57, 48.49, 49.15, 57.54, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.79, 27.47, 44.23, 39.87, 47.18, 43.52, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.56, 28.70, 38.83, 38.93, 51.53, 51.50, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.82, 28.81, 18.25, 31.24, 45.45, 28.64, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.67, 29.16, 19.17, 32.81, 41.52, 28.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.54, 30.90, 20.83, 39.00, 47.64, 42.19, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.71, 34.15, 44.43, 45.47, 47.56, 50.70, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.88, 38.84, 66.74, 50.37, 48.33, 65.12, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.54, 42.58, 78.22, 56.34, 50.19, 66.78, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.09, 46.00, 83.31, 56.85, 49.15, 70.54, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.76, 50.83, 87.71, 64.22, 60.58, 74.60, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.77, 56.85, 93.00, 64.52, 63.14, 86.34, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.25, 65.33, 94.58, 57.76, 60.53, 90.44, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.41, 73.75, 94.94, 57.67, 60.79, 93.63, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.56, 81.76, 92.88, 57.85, 62.58, 94.03, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.36, 86.45, 86.67, 67.11, 63.61, 91.63, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.36, 87.75, 78.42, 60.72, 62.01, 91.63, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.14, 86.10, 63.41, 60.93, 59.83, 85.63, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.78, 82.61, 51.92, 60.63, 58.88, 83.65, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.38, 76.64, 33.93, 60.45, 55.64, 80.17, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.65, 68.39, 18.78, 55.47, 48.23, 72.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.54, 59.99, 18.96, 50.41, 51.74, 82.78, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.54, 53.69, 38.24, 50.53, 58.35, 92.68, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.94, 50.36, 62.91, 56.32, 59.79, 93.52, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.36, 49.48, 78.72, 56.36, 62.07, 92.75, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.05, 49.93, 82.51, 57.95, 60.04, 95.08, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.50, 52.16, 83.49, 58.46, 62.58, 93.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.08, 54.26, 70.77, 58.39, 56.51, 82.68, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.34, 57.19, 60.33, 49.98, 57.30, 84.75, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.71, 61.43, 56.90, 49.05, 55.81, 90.45, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.91, 64.87, 49.98, 50.17, 48.98, 81.26, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.51, 67.63, 63.10, 58.96, 57.11, 98.17, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.05, 67.96, 65.81, 66.63, 57.15, 93.28, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.94, 69.15, 89.48, 67.79, 60.36, 99.33, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.34, 70.18, 91.76, 73.40, 69.36, 100.00, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.72, 70.94, 90.37, 66.53, 61.83, 91.00, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.45, 72.80, 87.49, 66.12, 63.15, 96.32, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.46, 75.02, 80.27, 62.12, 66.54, 93.91, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.07, 78.45, 87.79, 61.90, 65.62, 98.72, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.15, 82.96, 90.59, 59.77, 67.71, 99.23, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.48, 85.72, 87.95, 67.32, 57.93, 89.87, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.62, 88.33, 89.30, 74.96, 60.93, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.22, 88.41, 90.14, 83.66, 71.43, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.41, 88.97, 96.84, 84.12, 69.30, 96.79, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.68, 89.25, 92.89, 80.23, 74.50, 96.11, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.51, 88.23, 78.33, 72.68, 63.19, 85.66, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.60, 86.13, 61.38, 65.78, 60.79, 81.03, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.82, 80.71, 38.94, 63.91, 61.74, 78.87, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.48, 73.48, 25.60, 55.79, 55.53, 72.01, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.10, 66.50, 25.09, 64.28, 58.77, 78.87, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.27, 58.59, 18.14, 53.75, 49.30, 64.03, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.18, 50.60, 18.22, 58.53, 46.37, 69.97, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.22, 41.14, 11.72, 59.50, 48.47, 70.03, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.23, 32.34, 13.67, 53.96, 42.90, 58.16, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.46, 24.67, 9.28, 46.88, 41.76, 48.28, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.11, 19.61, 15.81, 45.82, 47.35, 61.32, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.07, 17.49, 19.88, 38.56, 37.84, 52.91, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.60, 17.32, 24.07, 29.92, 42.46, 47.35, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.54, 15.94, 12.68, 29.67, 36.72, 34.49, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.36, 14.68, 6.78, 30.01, 34.88, 28.19, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.21, 13.16, 4.58, 29.74, 36.52, 27.76, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.83, 12.29, 3.89, 26.54, 36.49, 23.87, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.28, 11.65, 7.86, 26.94, 32.45, 24.42, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.59, 12.37, 15.81, 26.89, 37.79, 33.75, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.39, 13.73, 28.04, 36.48, 39.86, 36.23, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.76, 15.89, 39.31, 34.83, 42.37, 34.99, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.17, 17.04, 34.41, 27.97, 38.90, 22.94, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.79, 19.61, 35.79, 32.50, 42.79, 27.57, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.06, 23.50, 41.83, 38.92, 47.52, 31.90, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.58, 30.34, 66.13, 39.43, 47.82, 39.81, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.01, 36.59, 60.15, 38.59, 38.03, 24.61, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.19, 40.88, 46.49, 39.86, 37.66, 24.85, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.02, 42.43, 29.77, 48.06, 40.15, 28.81, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.18, 42.31, 26.90, 47.90, 43.07, 18.55, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.06, 40.12, 19.61, 47.93, 35.12, 2.24, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (29.68, 37.10, 7.28, 48.14, 32.48, 1.84, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.03, 33.80, 6.02, 53.69, 30.99, 5.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.76, 30.30, 10.38, 52.36, 32.45, 6.43, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.67, 24.94, 17.87, 43.13, 37.63, 10.76, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.48, 20.62, 21.22, 34.96, 40.23, 8.20, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.10, 18.03, 23.18, 40.62, 42.58, 7.40, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.45, 17.88, 28.47, 42.46, 51.08, 12.81, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.07, 18.63, 33.60, 34.84, 54.50, 10.36, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.38, 20.59, 37.27, 26.11, 51.27, 5.41, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (27.53, 22.66, 25.88, 22.94, 48.58, 2.07, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (27.22, 23.66, 15.05, 22.14, 40.81, 1.35, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.33, 24.28, 15.97, 25.50, 42.32, 7.76, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.45, 23.76, 13.18, 25.47, 38.31, 0.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.12, 22.76, 12.27, 25.71, 35.48, 0.62, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (26.50, 20.29, 0.91, 23.63, 28.21, 0.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (26.45, 18.07, 8.46, 20.73, 35.17, 7.81, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (27.50, 16.18, 16.63, 19.32, 35.97, 8.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.68, 15.85, 34.30, 23.52, 39.49, 12.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.54, 19.65, 60.08, 31.23, 45.05, 23.57, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.97, 26.50, 76.73, 32.93, 45.34, 20.27, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.04, 32.68, 71.57, 28.22, 41.42, 9.85, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.06, 35.49, 38.49, 28.53, 39.50, 0.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (31.57, 36.02, 16.99, 29.47, 36.66, 3.74, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.57, 37.24, 11.87, 39.94, 39.69, 6.52, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.76, 38.43, 19.18, 46.49, 38.29, 6.69, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.37, 38.79, 19.93, 40.06, 30.13, 4.40, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (29.67, 36.41, 12.81, 41.60, 28.69, 0.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (29.65, 30.62, 8.04, 42.98, 33.09, 2.76, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.71, 23.37, 11.47, 55.03, 44.01, 6.56, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.35, 19.02, 32.43, 61.98, 43.89, 10.31, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.94, 19.89, 46.29, 57.57, 42.73, 7.11, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.68, 23.24, 47.14, 52.47, 39.31, 3.95, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.41, 26.51, 41.24, 43.05, 41.71, 6.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.28, 30.72, 57.14, 42.23, 53.57, 16.56, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.58, 37.15, 77.78, 51.00, 55.09, 20.08, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.96, 45.54, 88.28, 52.89, 52.92, 17.34, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.52, 53.07, 75.88, 55.77, 48.73, 13.54, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.09, 59.07, 65.44, 47.53, 49.41, 13.07, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.16, 63.00, 67.77, 46.76, 56.74, 18.90, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.93, 66.37, 76.62, 52.79, 54.49, 19.69, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.02, 70.25, 82.13, 53.20, 45.42, 17.37, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.00, 72.95, 65.50, 54.45, 43.58, 15.39, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.58, 71.23, 41.66, 45.60, 45.07, 13.99, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.63, 65.05, 22.16, 48.33, 43.22, 12.95, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.34, 56.99, 15.73, 45.23, 41.17, 8.28, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.50, 51.00, 22.00, 43.72, 43.85, 10.93, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.99, 45.93, 19.79, 50.89, 35.51, 5.31, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.39, 40.03, 14.70, 41.91, 32.41, 0.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.83, 33.20, 15.12, 42.40, 38.91, 9.67, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.76, 27.79, 33.45, 49.40, 47.99, 16.59, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.02, 27.03, 58.66, 54.90, 53.83, 20.71, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.49, 27.94, 49.88, 52.89, 46.70, 2.52, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.15, 30.52, 45.31, 46.22, 49.41, 13.29, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.53, 31.10, 21.00, 39.68, 48.24, 0.76, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.42, 32.35, 33.27, 45.73, 55.66, 14.37, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.56, 35.19, 45.28, 51.19, 56.25, 26.99, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.96, 40.77, 64.98, 50.86, 48.39, 19.16, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.41, 45.60, 58.55, 42.61, 43.81, 8.28, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.24, 46.57, 42.24, 44.74, 50.93, 11.83, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.85, 45.00, 44.48, 51.25, 48.90, 21.24, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.49, 45.05, 50.36, 44.20, 53.55, 13.75, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.84, 44.73, 42.40, 44.30, 43.41, 5.84, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.26, 46.15, 33.82, 41.84, 45.27, 17.48, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.24, 46.15, 33.25, 40.66, 50.94, 17.43, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.01, 44.43, 29.76, 33.39, 46.82, 1.50, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.25, 39.12, 17.24, 34.39, 43.82, 1.84, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.00, 33.99, 12.35, 34.77, 44.28, 13.90, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.47, 31.27, 17.77, 41.71, 43.68, 10.26, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.15, 28.86, 22.80, 33.70, 47.26, 9.45, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.18, 25.18, 17.17, 24.86, 39.10, 4.56, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (29.79, 22.42, 17.57, 25.41, 40.63, 9.41, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.38, 21.73, 27.65, 32.27, 49.60, 24.07, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.10, 22.80, 42.89, 40.03, 50.11, 25.13, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.43, 24.07, 41.14, 32.68, 42.51, 6.61, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.63, 25.64, 31.38, 33.57, 46.04, 8.16, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.35, 26.78, 22.65, 40.86, 47.07, 11.75, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.15, 29.12, 38.85, 41.28, 54.47, 24.80, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.97, 32.64, 54.46, 41.04, 53.41, 26.13, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.11, 37.19, 58.12, 42.42, 47.08, 16.09, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.54, 40.50, 47.37, 42.65, 48.31, 12.91, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.17, 40.83, 30.64, 43.66, 51.07, 7.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.99, 37.93, 16.76, 37.81, 46.22, 0.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.30, 35.51, 19.40, 45.08, 50.95, 13.04, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.85, 35.31, 29.57, 52.50, 45.45, 15.68, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.46, 38.81, 54.14, 59.61, 46.94, 23.86, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.99, 41.86, 66.27, 51.72, 53.12, 24.82, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.37, 44.78, 80.72, 50.15, 57.61, 29.05, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.07, 47.97, 86.90, 58.91, 62.90, 35.98, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.77, 52.05, 84.07, 58.24, 60.80, 26.60, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.33, 56.67, 72.22, 51.04, 56.02, 21.93, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.08, 61.25, 57.93, 50.58, 52.41, 19.53, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.95, 64.56, 49.22, 50.33, 47.98, 26.24, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.89, 66.12, 43.59, 51.04, 48.76, 29.41, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.18, 63.35, 29.22, 51.36, 43.12, 20.01, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.45, 58.60, 23.54, 52.32, 43.69, 22.11, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.34, 51.89, 20.34, 57.52, 49.76, 23.55, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.72, 45.31, 27.63, 51.81, 48.95, 22.44, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.18, 38.40, 21.94, 45.94, 49.73, 16.03, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.33, 31.92, 13.91, 39.23, 46.56, 12.49, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.71, 26.17, 6.12, 41.61, 39.00, 2.82, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.96, 23.08, 21.41, 38.90, 49.65, 17.69, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.50, 22.91, 42.05, 35.78, 48.25, 20.23, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.30, 27.32, 68.92, 44.69, 50.72, 23.16, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.52, 33.35, 77.80, 51.46, 48.11, 21.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.67, 40.43, 84.11, 49.54, 49.99, 23.61, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.13, 45.47, 72.96, 41.12, 47.33, 14.65, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.86, 49.77, 60.61, 42.37, 48.43, 12.44, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.76, 53.33, 46.01, 44.17, 44.90, 12.27, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.05, 56.35, 33.31, 51.62, 40.48, 9.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.48, 56.67, 24.23, 43.39, 38.63, 6.97, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.45, 55.59, 32.33, 53.18, 49.14, 19.18, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.49, 53.50, 50.16, 61.07, 50.39, 19.57, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.56, 53.20, 75.08, 69.30, 59.45, 29.23, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.25, 52.51, 77.89, 76.48, 57.33, 26.17, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.33, 53.56, 82.39, 69.33, 58.41, 27.78, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.78, 55.37, 76.93, 69.46, 57.15, 27.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.56, 59.62, 84.28, 68.75, 60.63, 34.95, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.24, 65.85, 89.37, 71.28, 59.06, 37.77, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.83, 72.76, 86.37, 64.68, 54.46, 31.21, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.30, 77.21, 72.45, 65.32, 52.62, 30.54, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.11, 76.95, 47.78, 65.96, 52.21, 23.70, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.42, 71.49, 25.93, 67.69, 41.77, 18.28, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.80, 64.35, 13.66, 66.56, 47.72, 22.53, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.35, 56.50, 11.72, 71.72, 42.44, 21.92, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.83, 49.95, 17.95, 69.81, 37.47, 22.47, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.25, 44.92, 39.01, 69.20, 51.59, 36.69, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.25, 41.85, 61.77, 70.38, 56.08, 47.77, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.95, 41.60, 84.14, 72.19, 60.03, 54.77, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.51, 42.23, 78.09, 72.62, 57.06, 49.13, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.63, 45.40, 76.33, 73.06, 60.97, 56.04, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.24, 50.60, 72.72, 74.23, 58.53, 54.14, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.09, 56.39, 65.80, 63.78, 52.29, 43.46, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.14, 61.31, 55.98, 61.12, 49.45, 54.57, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.90, 63.72, 39.63, 58.01, 43.59, 46.95, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.57, 63.36, 35.78, 54.62, 49.11, 52.97, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.33, 59.94, 31.04, 60.53, 52.73, 58.45, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.38, 54.38, 34.04, 57.94, 47.29, 60.18, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.61, 48.73, 27.25, 54.00, 43.95, 52.38, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.59, 42.91, 24.01, 55.08, 51.00, 59.32, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.04, 37.53, 24.21, 55.91, 48.89, 58.07, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.13, 34.52, 38.75, 53.83, 53.63, 62.73, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.06, 34.89, 59.31, 51.40, 50.17, 69.46, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.13, 39.20, 78.43, 58.53, 55.32, 79.61, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.24, 45.39, 91.48, 60.54, 58.86, 94.51, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.40, 51.64, 87.24, 53.21, 61.35, 85.51, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.81, 56.47, 77.58, 53.10, 57.93, 80.44, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.43, 60.74, 65.63, 54.79, 56.57, 77.74, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.42, 65.77, 69.32, 62.95, 60.16, 90.68, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.06, 71.38, 74.68, 73.89, 56.51, 88.86, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.98, 76.76, 87.21, 74.95, 57.87, 98.06, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.95, 80.17, 89.94, 80.43, 57.38, 97.07, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.40, 81.19, 87.65, 75.92, 55.46, 88.06, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.98, 79.52, 76.43, 66.19, 55.68, 83.14, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.82, 76.75, 62.28, 60.10, 53.41, 78.27, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.29, 73.93, 52.22, 54.36, 49.33, 74.19, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.68, 72.14, 49.55, 55.88, 52.24, 81.26, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.53, 69.68, 47.15, 56.31, 51.87, 83.08, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.13, 65.04, 32.91, 48.50, 41.51, 68.31, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.43, 57.78, 21.85, 47.67, 48.37, 72.68, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.19, 49.50, 15.41, 51.78, 48.99, 74.11, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.37, 41.83, 18.71, 49.60, 45.38, 58.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.74, 34.83, 13.39, 45.20, 41.07, 48.05, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.99, 28.72, 7.25, 41.29, 34.74, 48.45, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.41, 24.08, 10.52, 34.28, 34.77, 50.60, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.83, 19.56, 8.87, 24.16, 33.27, 38.05, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.80, 15.46, 10.20, 30.80, 31.79, 42.41, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.07, 14.38, 23.21, 41.32, 42.84, 62.27, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.91, 15.93, 35.78, 41.92, 44.94, 53.53, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.66, 19.31, 45.90, 42.29, 44.63, 48.53, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.92, 20.75, 31.62, 35.24, 43.28, 42.18, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.71, 23.82, 40.99, 35.02, 46.04, 54.88, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.15, 28.61, 50.41, 43.28, 51.39, 54.53, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.63, 34.57, 64.18, 43.22, 52.00, 51.43, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.63, 39.84, 56.21, 37.13, 42.93, 47.35, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.16, 43.72, 45.13, 38.81, 43.93, 48.25, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.87, 46.21, 45.68, 38.43, 51.73, 51.02, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.44, 47.80, 50.07, 40.80, 57.80, 50.29, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.29, 49.65, 62.57, 47.91, 51.24, 53.06, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.22, 53.06, 62.33, 48.93, 50.68, 51.43, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.07, 56.89, 75.44, 49.81, 55.51, 62.04, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.78, 59.02, 69.59, 41.47, 52.36, 54.12, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.08, 59.90, 72.09, 48.52, 53.33, 49.67, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.26, 61.52, 70.77, 55.78, 53.02, 52.17, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.31, 64.90, 75.53, 55.81, 50.76, 46.55, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.41, 66.62, 61.23, 48.16, 45.19, 35.06, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.95, 65.10, 36.39, 47.90, 44.81, 35.98, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.78, 60.94, 25.08, 49.30, 43.06, 39.02, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.50, 59.29, 47.51, 58.42, 55.22, 55.79, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.53, 59.06, 73.31, 65.52, 59.79, 60.37, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.37, 60.98, 86.94, 65.96, 56.08, 55.18, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.78, 61.65, 78.06, 57.94, 54.77, 50.81, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.17, 61.44, 68.88, 49.99, 58.62, 51.52, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.23, 61.53, 76.38, 56.24, 66.83, 65.96, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.23, 64.55, 88.42, 51.87, 64.78, 65.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.47, 71.37, 97.74, 60.23, 64.49, 72.89, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.85, 78.66, 90.71, 61.10, 58.97, 71.23, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.14, 82.73, 84.11, 53.69, 60.87, 69.95, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.27, 83.65, 81.64, 61.75, 62.45, 70.72, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.55, 82.97, 80.81, 59.91, 60.45, 67.03, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.86, 82.29, 71.94, 53.41, 48.72, 58.78, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.26, 81.09, 58.04, 59.29, 48.02, 61.49, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.55, 78.96, 57.19, 57.42, 47.12, 70.35, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.13, 76.82, 69.20, 56.34, 51.34, 76.26, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.85, 73.46, 67.52, 56.72, 45.23, 65.80, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.25, 69.20, 52.39, 56.98, 48.14, 63.34, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.97, 64.69, 43.49, 63.36, 54.76, 70.72, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.16, 61.88, 56.33, 64.11, 55.80, 74.34, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.36, 61.82, 80.28, 69.76, 68.94, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.23, 63.56, 87.57, 70.61, 63.00, 92.03, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.15, 67.28, 91.51, 71.44, 61.99, 94.95, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.64, 69.84, 80.25, 69.06, 57.32, 82.95, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.43, 70.94, 79.11, 68.02, 60.36, 90.45, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.72, 71.95, 76.67, 75.71, 61.80, 91.12, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.25, 74.60, 76.18, 74.47, 59.22, 84.63, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.36, 76.16, 57.52, 66.24, 46.95, 71.54, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.88, 73.98, 36.78, 67.00, 49.01, 74.73, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.47, 67.23, 19.49, 61.85, 48.57, 72.34, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.03, 61.82, 38.83, 67.67, 62.21, 94.65, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.76, 58.20, 58.99, 72.82, 59.19, 93.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.68, 57.73, 76.02, 74.30, 50.54, 85.84, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.52, 55.74, 61.16, 67.07, 49.76, 75.82, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.25, 52.58, 48.24, 64.36, 50.30, 77.24, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.33, 48.86, 42.67, 61.71, 49.35, 79.26, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.73, 47.96, 49.44, 60.65, 54.44, 83.81, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.11, 49.21, 48.03, 61.28, 42.88, 76.33, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.15, 52.36, 47.85, 54.86, 44.26, 81.79, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.17, 51.95, 35.18, 56.45, 44.83, 77.75, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.95, 50.40, 44.96, 64.22, 54.58, 90.79, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.01, 47.14, 46.72, 64.62, 51.16, 82.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.54, 45.00, 41.89, 57.05, 44.96, 69.65, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.47, 43.47, 34.46, 55.94, 46.99, 76.94, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.90, 42.40, 33.11, 55.09, 45.57, 77.75, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.61, 42.82, 53.16, 48.67, 48.32, 82.80, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.04, 44.30, 61.34, 46.87, 53.82, 83.61, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.09, 47.10, 73.11, 56.76, 51.32, 87.35, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.82, 51.52, 74.97, 48.42, 54.23, 84.32, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.51, 54.41, 70.90, 44.25, 59.65, 79.77, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.90, 55.46, 56.23, 38.37, 50.89, 73.26, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.89, 55.39, 41.23, 38.51, 56.45, 70.07, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.78, 54.20, 23.78, 39.36, 49.90, 66.68, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.05, 51.71, 10.69, 32.51, 45.85, 65.51, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.42, 46.07, 2.34, 24.53, 35.98, 47.75, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.67, 39.85, 5.38, 25.31, 37.81, 50.60, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.17, 32.34, 5.53, 26.26, 31.05, 42.82, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (43.76, 26.12, 18.99, 34.21, 43.36, 56.07, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.65, 20.83, 23.33, 31.88, 39.91, 49.61, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.15, 18.70, 37.05, 32.90, 40.04, 51.80, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.72, 17.68, 32.01, 25.86, 38.70, 46.41, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.89, 18.97, 35.42, 22.29, 42.09, 48.84, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (41.47, 21.98, 37.73, 24.85, 42.60, 48.06, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (40.66, 26.79, 45.68, 29.24, 47.03, 46.60, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.40, 30.59, 39.59, 30.77, 35.94, 40.57, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (29.66, 32.72, 24.70, 30.03, 31.68, 22.36, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.48, 32.36, 15.70, 29.35, 36.91, 27.06, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.48, 31.70, 17.41, 31.06, 39.59, 27.06, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.89, 30.14, 23.01, 32.68, 44.47, 25.72, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.95, 29.22, 23.79, 38.91, 46.79, 27.95, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.78, 27.69, 21.58, 46.11, 45.16, 23.48, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.57, 28.72, 47.00, 48.06, 57.08, 38.37, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.10, 31.18, 67.81, 51.45, 66.96, 37.41, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.64, 37.05, 92.50, 57.60, 65.33, 38.50, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.41, 44.61, 92.66, 66.48, 68.50, 51.02, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.99, 53.57, 96.33, 67.25, 71.06, 57.28, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.70, 62.16, 94.77, 65.99, 65.62, 51.70, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.92, 70.12, 94.61, 68.62, 70.99, 61.91, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.39, 77.89, 93.71, 73.63, 67.49, 65.71, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.71, 86.25, 96.86, 83.01, 71.63, 69.11, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.42, 91.58, 94.95, 81.02, 70.99, 68.71, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.25, 93.61, 86.09, 74.88, 64.44, 61.22, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.29, 91.92, 77.26, 78.71, 57.42, 63.40, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.79, 89.96, 75.08, 78.98, 63.52, 68.71, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.69, 88.41, 82.34, 79.39, 64.77, 77.82, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.37, 87.41, 85.77, 78.40, 58.57, 77.41, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.79, 86.24, 84.08, 72.17, 59.57, 78.37, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.21, 83.94, 72.98, 64.29, 55.54, 72.93, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.40, 81.11, 71.43, 63.12, 57.00, 77.28, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.68, 78.42, 70.75, 55.99, 61.29, 77.82, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.44, 75.83, 62.81, 55.66, 52.61, 67.89, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.70, 73.31, 54.58, 46.72, 50.97, 71.70, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.60, 71.70, 60.60, 48.85, 58.65, 82.99, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.47, 71.68, 82.15, 51.10, 62.12, 87.07, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.87, 69.84, 69.14, 50.57, 52.82, 67.76, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.83, 64.77, 38.51, 51.41, 48.89, 65.98, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (50.41, 58.18, 13.70, 44.67, 51.51, 65.30, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.00, 52.81, 23.10, 43.81, 56.13, 69.52, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.49, 50.12, 46.51, 43.98, 58.66, 79.46, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.23, 50.36, 64.97, 44.65, 53.47, 85.03, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.18, 52.73, 75.93, 44.39, 46.20, 82.31, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.18, 54.40, 75.57, 45.49, 57.09, 82.31, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.61, 53.29, 72.20, 39.53, 62.44, 81.63, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.65, 53.93, 74.90, 45.08, 59.78, 85.03, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.80, 57.23, 68.15, 45.06, 56.88, 82.59, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.64, 61.45, 51.73, 48.82, 47.55, 77.83, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.11, 61.63, 24.74, 39.66, 41.46, 72.17, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.66, 57.96, 13.43, 35.92, 43.92, 77.38, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.21, 53.23, 22.43, 44.39, 47.93, 84.67, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.15, 50.99, 55.76, 52.24, 52.58, 95.83, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.70, 51.68, 81.81, 53.64, 52.89, 95.24, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.32, 54.66, 98.96, 56.03, 60.05, 100.00, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.40, 56.59, 92.26, 55.24, 60.07, 93.28, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.81, 59.15, 91.26, 46.53, 70.49, 97.94, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.14, 63.37, 89.69, 55.14, 73.20, 98.29, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.25, 71.21, 95.24, 64.68, 73.78, 98.64, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.85, 79.77, 90.54, 58.64, 63.46, 92.06, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.69, 87.16, 88.88, 62.01, 66.08, 97.47, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.31, 90.96, 90.02, 70.13, 69.04, 100.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (75.49, 92.17, 92.70, 73.16, 72.66, 95.27, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.00, 90.93, 87.75, 71.61, 64.88, 90.74, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.43, 89.12, 76.00, 65.85, 59.00, 86.70, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.13, 86.46, 67.26, 61.61, 58.81, 87.88, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.09, 83.90, 66.73, 61.09, 64.49, 93.10, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.93, 80.70, 66.42, 60.95, 59.33, 90.44, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.36, 78.20, 68.04, 54.74, 54.07, 91.13, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.20, 74.02, 51.22, 49.79, 45.08, 81.97, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.29, 69.59, 50.24, 55.20, 56.89, 90.94, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.46, 65.94, 59.84, 54.30, 62.14, 96.45, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.85, 65.06, 79.82, 53.36, 59.64, 96.01, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.90, 66.84, 91.96, 63.49, 62.55, 99.25, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.63, 69.43, 90.64, 62.57, 63.98, 97.15, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.32, 72.54, 94.68, 60.51, 65.62, 98.53, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.32, 75.61, 94.09, 55.38, 72.60, 98.53, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.63, 78.53, 94.28, 57.57, 67.91, 97.33, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (78.82, 83.06, 92.01, 72.25, 68.93, 95.12, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (79.69, 87.54, 90.53, 78.58, 69.49, 97.09, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (79.09, 90.86, 89.75, 69.82, 69.63, 96.74, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (82.77, 92.14, 91.34, 75.79, 72.09, 97.73, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.82, 91.27, 84.12, 70.20, 67.18, 91.55, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.83, 89.74, 76.81, 76.39, 61.75, 90.61, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (77.02, 87.57, 75.15, 76.89, 63.38, 96.73, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.10, 85.39, 74.52, 70.36, 54.09, 89.94, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.07, 83.50, 77.22, 64.84, 54.09, 92.95, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.25, 78.99, 51.43, 57.75, 43.08, 78.42, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.15, 72.42, 31.41, 48.25, 35.66, 62.77, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.65, 65.84, 30.53, 51.80, 46.76, 88.74, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.22, 60.14, 40.05, 48.14, 43.97, 74.48, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.26, 57.56, 60.95, 52.94, 48.47, 87.33, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.16, 56.16, 64.18, 49.37, 51.85, 92.37, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.14, 56.77, 80.65, 49.29, 53.44, 95.21, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.70, 58.14, 86.86, 48.74, 58.45, 92.64, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.06, 59.86, 92.64, 48.98, 66.18, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (62.24, 64.51, 93.28, 49.62, 60.16, 95.73, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.54, 71.00, 89.81, 41.02, 64.73, 91.97, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.24, 75.35, 69.76, 33.70, 51.08, 77.65, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.19, 77.17, 56.42, 32.51, 51.23, 81.79, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.67, 76.65, 56.21, 39.56, 54.32, 94.54, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.78, 77.99, 76.26, 45.12, 59.55, 100.00, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.92, 77.68, 77.91, 47.02, 50.47, 87.73, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.64, 76.09, 72.54, 40.16, 51.65, 89.31, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.64, 72.44, 59.75, 43.20, 55.53, 89.31, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.10, 69.31, 65.15, 40.73, 60.98, 92.24, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.02, 67.20, 70.83, 34.76, 64.80, 94.06, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.13, 68.24, 79.07, 35.06, 60.61, 96.20, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.65, 69.58, 68.50, 36.46, 50.09, 89.15, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.58, 70.01, 60.08, 34.28, 63.86, 92.48, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.36, 66.03, 40.44, 41.70, 54.42, 88.28, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.96, 62.81, 48.98, 50.21, 55.65, 92.13, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.50, 59.46, 42.36, 54.23, 54.38, 88.87, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.18, 57.21, 39.50, 58.62, 47.14, 87.13, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.53, 52.24, 20.37, 46.64, 38.02, 79.23, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.77, 46.33, 17.64, 38.21, 41.13, 80.90, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.31, 39.36, 16.36, 39.13, 39.20, 77.41, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.76, 34.34, 23.35, 45.72, 44.17, 80.48, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.57, 31.56, 35.05, 50.70, 47.12, 86.96, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.92, 33.25, 55.60, 51.71, 50.01, 90.36, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.61, 36.59, 79.05, 58.48, 54.35, 94.43, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.72, 42.13, 92.23, 51.11, 64.97, 94.58, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.44, 48.26, 94.70, 50.50, 63.53, 92.15, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.29, 53.82, 70.41, 38.10, 52.03, 77.71, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (46.29, 57.04, 46.59, 30.56, 52.41, 77.71, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.94, 57.56, 21.09, 23.53, 44.06, 72.39, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.00, 58.22, 29.28, 28.66, 51.08, 83.09, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.63, 58.58, 38.28, 33.03, 49.65, 84.04, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.13, 58.75, 57.16, 38.61, 48.71, 85.35, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.20, 56.80, 61.47, 40.58, 48.34, 84.66, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.59, 53.44, 61.98, 41.22, 55.56, 82.54, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.17, 51.13, 73.89, 41.64, 61.17, 96.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.40, 52.48, 82.59, 43.88, 67.97, 96.43, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.45, 57.95, 95.83, 46.61, 67.73, 98.66, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.74, 66.05, 94.00, 48.43, 69.06, 97.69, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.81, 73.14, 93.10, 55.70, 66.48, 95.58, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.67, 78.95, 90.49, 61.53, 64.86, 95.83, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.12, 82.53, 89.39, 67.84, 70.35, 96.70, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (73.93, 86.00, 92.72, 77.05, 69.06, 99.24, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.44, 89.47, 93.25, 85.50, 67.97, 96.60, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.63, 91.23, 89.73, 76.69, 63.98, 94.61, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.32, 91.91, 88.68, 77.59, 65.26, 98.76, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.70, 91.16, 89.09, 78.34, 70.31, 97.79, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (65.47, 89.80, 81.72, 73.98, 66.99, 90.19, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.90, 85.35, 53.07, 69.35, 52.41, 74.72, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.66, 78.03, 24.59, 62.63, 45.08, 62.57, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.80, 68.90, 7.24, 54.90, 42.70, 51.10, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.37, 59.51, 8.24, 47.33, 42.57, 45.71, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.05, 50.33, 10.63, 47.22, 40.62, 46.61, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.00, 41.79, 12.89, 47.05, 35.68, 46.51, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.48, 34.30, 21.20, 47.69, 43.87, 61.08, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (48.86, 27.76, 30.29, 53.12, 46.19, 61.68, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.97, 23.10, 39.75, 46.37, 47.16, 60.28, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.34, 20.45, 29.26, 36.90, 42.09, 37.62, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.55, 20.53, 25.25, 36.12, 44.99, 33.13, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.85, 22.40, 24.10, 35.82, 43.76, 37.62, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.41, 26.15, 41.97, 37.47, 47.32, 47.41, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (44.25, 30.73, 51.88, 38.17, 43.53, 47.11, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.30, 36.44, 64.26, 48.08, 52.63, 55.09, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (47.79, 41.62, 67.87, 55.13, 53.59, 52.50, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.39, 47.15, 79.98, 62.47, 64.62, 63.06, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.50, 52.53, 88.19, 70.16, 67.50, 73.53, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.84, 59.87, 95.38, 70.04, 67.89, 72.38, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.18, 66.92, 88.64, 64.23, 63.87, 61.37, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (51.53, 72.65, 75.70, 57.76, 62.06, 53.91, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (53.93, 75.62, 68.71, 58.15, 58.49, 59.38, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (55.66, 77.59, 69.62, 57.64, 62.83, 63.35, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.97, 78.34, 70.96, 66.26, 60.06, 62.11, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.14, 78.28, 67.36, 75.18, 54.08, 64.60, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.77, 77.23, 70.54, 76.40, 57.26, 75.03, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (59.56, 75.50, 72.58, 76.56, 56.90, 73.17, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.05, 74.21, 83.80, 82.45, 61.96, 81.37, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (68.94, 74.00, 86.76, 82.85, 64.83, 97.65, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.74, 75.86, 92.43, 83.44, 59.08, 93.61, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.62, 78.46, 92.10, 83.80, 61.31, 95.69, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.26, 80.16, 84.92, 74.81, 56.98, 88.59, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.11, 80.74, 76.15, 68.87, 55.96, 84.17, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (58.90, 80.18, 62.33, 68.64, 57.01, 81.02, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.55, 78.58, 56.18, 67.97, 55.28, 84.40, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.24, 77.91, 66.53, 68.13, 56.42, 97.56, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.64, 76.86, 74.31, 73.30, 55.47, 94.04, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (61.87, 75.59, 75.40, 68.25, 52.59, 90.48, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (57.27, 71.45, 55.11, 63.17, 50.49, 84.29, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (60.33, 66.77, 50.01, 56.71, 55.82, 90.25, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.45, 63.89, 59.03, 57.53, 62.96, 95.79, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (66.01, 63.92, 76.37, 50.97, 60.92, 95.26, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.00, 65.73, 78.63, 40.93, 49.96, 88.98, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (64.98, 67.92, 75.90, 32.83, 54.44, 92.86, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.22, 69.49, 80.68, 30.92, 59.33, 99.50, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.61, 71.14, 89.11, 38.88, 62.37, 96.74, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.61, 73.15, 93.53, 38.32, 61.13, 96.74, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.48, 77.25, 91.99, 45.54, 60.09, 97.67, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (69.64, 81.51, 88.40, 46.77, 57.44, 95.74, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (70.56, 84.67, 87.38, 39.91, 65.54, 97.41, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.74, 85.80, 86.60, 40.72, 63.94, 98.08, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (75.23, 87.31, 92.22, 49.02, 66.02, 99.22, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (75.62, 89.22, 93.09, 54.69, 68.69, 97.97, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (71.71, 90.00, 87.68, 54.60, 62.41, 95.36, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (72.76, 89.37, 83.41, 51.82, 61.99, 97.05, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (74.72, 88.16, 82.64, 61.58, 64.21, 97.86, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (76.07, 87.58, 86.79, 73.29, 63.99, 97.50, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (67.39, 86.61, 79.66, 67.73, 57.07, 92.41, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (63.20, 84.09, 64.75, 60.43, 51.49, 89.66, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (54.41, 78.47, 35.96, 54.84, 44.15, 83.04, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (56.63, 71.61, 30.48, 54.53, 54.11, 85.30, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (52.41, 64.29, 27.23, 54.41, 51.76, 81.83, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (49.99, 58.49, 35.49, 53.89, 48.10, 79.73, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (34.15, 51.45, 20.00, 51.39, 37.10, 60.19, 2)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.86, 43.52, 11.27, 45.00, 36.13, 57.93, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (45.25, 35.47, 14.37, 44.69, 42.06, 70.45, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (38.70, 28.73, 18.98, 40.17, 40.36, 59.79, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.96, 23.47, 17.49, 38.70, 30.73, 50.26, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (27.27, 20.33, 7.62, 32.38, 27.59, 32.49, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (33.96, 18.14, 10.83, 31.90, 35.00, 40.97, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.95, 17.27, 19.41, 18.96, 44.34, 32.66, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.89, 16.47, 28.23, 26.23, 47.18, 32.49, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (42.37, 18.85, 41.50, 32.86, 47.75, 48.64, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.71, 23.11, 49.56, 33.26, 49.05, 42.59, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (39.71, 27.81, 56.71, 33.91, 50.71, 42.59, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.18, 31.47, 51.90, 28.90, 52.92, 36.93, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (32.95, 34.65, 46.06, 27.97, 47.09, 26.36, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (30.71, 37.70, 35.08, 28.72, 45.40, 20.06, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (26.68, 38.58, 18.80, 29.85, 37.22, 7.06, 3)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (24.52, 37.54, 10.02, 23.20, 30.05, 5.23, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (21.69, 34.74, 3.06, 23.29, 28.37, 0.00, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (36.39, 31.82, 15.24, 29.91, 41.00, 19.91, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.14, 28.84, 22.69, 37.61, 41.05, 16.42, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (37.04, 26.48, 35.47, 28.60, 48.81, 19.27, 1)'
      
        'INSERT INTO VALE5 (IFR, PERC_D, PERC_K, MFI, UO, SUPRES, FUT) VA' +
        'LUES (35.40, 24.65, 35.43, 37.70, 42.10, 15.06, 3)'
      '')
    TabOrder = 1
    Visible = False
  end
  object Button1: TButton
    Left = 513
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Table1: TTable
    Active = True
    DatabaseName = 'Vale5'
    ReadOnly = True
    TableName = 'vale5'
    Left = 47
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 89
    Top = 18
  end
  object Query1: TQuery
    DatabaseName = 'Vale5'
    Left = 523
    Top = 19
  end
end