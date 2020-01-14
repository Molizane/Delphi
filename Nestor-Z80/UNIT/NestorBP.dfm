object FrmBreakPoints: TFrmBreakPoints
  Left = 492
  Top = 296
  Width = 466
  Height = 436
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeToolWin
  Caption = ' Break Points'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    450
    398)
  PixelsPerInch = 96
  TextHeight = 13
  object ListDebug: TCheckListBox
    Left = 2
    Top = 3
    Width = 451
    Height = 394
    OnClickCheck = ListDebugClickCheck
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    BevelOuter = bvNone
    Ctl3D = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier'
    Font.Style = []
    IntegralHeight = True
    ItemHeight = 13
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
end
