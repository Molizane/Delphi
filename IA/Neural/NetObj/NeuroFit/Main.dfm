�
 TMAINFORM 0Y  TPF0	TMainFormMainFormLeftTopnWidthHeight�Caption"Curve Fitting using Neural NetworkFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterOnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight TPanelPanel2Left Top Width�Height�AlignalLeft
BevelOuterbvNoneTabOrder  TImagePaintBoxLeft
Top
Width�Height� OnMouseDownPaintBoxMouseDown  TLabelLabel5LeftTophWidth>HeightCaptionLearning rate  TLabelLabel6LeftTopQWidth4HeightCaptionMomentum  TButtonClearBtnLeft
Top`Width HeightCaptionClear paintboxTabOrder OnClickClearBtnClick  TPanel
TrainPanelLeftTopWidth� HeightG
BevelInner	bvLoweredTabOrderVisible TLabelLabel4LeftTopWidth&HeightCaption	Iteration  TLabelLabel3LeftTop1WidthHeightCaptionError  TLabel
ErrorLabelLeftKTop2WidthHeightCaption0.000  TLabelIterateLabelLeftKTopWidthHeightCaption0  TLabelLabel7LeftTopWidth� HeightAlignalTop	AlignmenttaCenterAutoSizeCaptionTraining in progress...Color  � Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.Style ParentColor
ParentFont   	TGroupBox	GroupBox1Left	Top� WidthHeightZCaptionNeural networkTabOrder TButtonTrainBtnLeftTopWidthqHeightCaptionTrainTabOrder OnClickTrainBtnClick  TButtonTopologyBtnLeftTop6WidthqHeightCaptionTopology >>>EnabledTabOrderOnClickTopologyBtnClick  TButtonSaveBtnLeft� Top7Width:HeightCaptionSave...EnabledTabOrderOnClickSaveBtnClick  TButtonLoadBtnLeft� Top7Width:HeightCaptionLoad...TabOrderOnClickLoadBtnClick  	TCheckBoxShowResponseCheckLeft� TopWidthsHeightCaptionshow NN responseState	cbCheckedTabOrder  	TCheckBoxLRcheckLeft� Top!WidthsHeightCaptioncompute optimal LRState	cbCheckedTabOrder   TEditMomentumEditLeftbTopLWidth6HeightColorclWhiteTabOrderText0.9  TEditLREditLeftcTopdWidth5HeightColorclWhiteTabOrderText0.35   TPanelPanel3Left�Top WidthRHeight�AlignalClient
BevelOuterbvNoneTabOrder TLabelLabel8Left Top WidthRHeightAlignalTopAutoSizeCaptionNeural network topology viewsColor  � Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentColor
ParentFont  TPageControlPageControl1Left TopWidthRHeights
ActivePage	TabSheet1AlignalClientTabOrder  	TTabSheet	TabSheet1CaptionText TMemoMemo1Left Top WidthJHeightWAlignalClient
ScrollBars
ssVerticalTabOrder    	TTabSheet	TabSheet2CaptionTreeView 	TTreeView	TreeView1Left Top WidthoHeighthIndentAlignalClientTabOrder    	TTabSheet	TabSheet3CaptionGraph+TreeView 	TPaintBoxNetPaintBoxLeft Top WidthJHeight� AlignalClientOnPaintNetPaintBoxPaint  	TTreeViewGraphTreeViewLeft Top� WidthJHeight� IndentOnChangeGraphTreeViewChangeAlignalBottomTabOrder      TOpenDialogNetOpenDialog
DefaultExtnetFilter.Network File (*.net)|*.net|All Files (*.*)|*.*Left@TopP  TSaveDialogNetSaveDialog
DefaultExtnetFilter.Network File (*.net)|*.net|All Files (*.*)|*.*LefthTopP  TBPnetNetworkAutoLR	NetConnection	ncLayeredLearningType	ltPatternMinLR,e�X���?BackTrackStepfffffff��?	ErrorGoal#�GG�ŧ�?	LearnRate���������?Momentumfffffff��?OnIterationNetworkIterationLeft@Top�    