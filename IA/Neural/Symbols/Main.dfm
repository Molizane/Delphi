�
 TMAINFORM 0�  TPF0	TMainFormMainFormLeftTopWidth(Height�CaptionHandwritten symbols recognitionFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style PositionpoScreenCenterOnCreate
FormCreateOnShowFormShowPixelsPerInch`
TextHeight TPanelPanel2Left Top Width�Height�AlignalLeft
BevelOuterbvNoneTabOrder  TImagePaintBoxLeft
Top
Width Height OnMouseDownPaintBoxMouseDownOnMouseMovePaintBoxMouseMove	OnMouseUpPaintBoxMouseUp  	TNotebookPanelsLeft
TopWidth Height)TabOrder  TPage Left Top CaptionEmpty  TPage Left Top CaptionIdentify TLabelLabel1Left Top Width Height)AlignalClient	AlignmenttaCenterCaptionProcessing...Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 
ParentFontLayouttlCenter   TPage Left Top Caption
AddPattern TLabelLabel2LeftTopWidth@HeightCaptionPattern count  TLabelPatternLabelLeftMTopWidthHeightCaption0    TButtonClearBtnLeft
Top`Width HeightCaptionClear paintboxTabOrderOnClickClearBtnClick  TButtonIdentifyBtnLeft� Top@WidthHeightCaption	RecognizeEnabledTabOrderOnClickIdentifyBtnClick  TButtonAddPatternBtnLeft
Top@Width� HeightCaptionAdd to the training data...EnabledTabOrderOnClickAddPatternBtnClick  TPanel
TrainPanelLeftTopWidth� Heightz
BevelInner	bvLoweredTabOrderVisible TLabelLabel4LeftTopWidth&HeightCaption	Iteration  TLabelLabel3LeftTop1WidthHeightCaptionError  TLabel
ErrorLabelLeftKTop2WidthHeightCaption0.000  TLabelIterateLabelLeftKTopWidthHeightCaption0  TLabelLabel5LeftTop`Width>HeightCaptionLearning rate  TLabelLRlabelLeftKTopaWidthHeightCaption0.000  TLabelLabel6LeftTopIWidth4HeightCaptionMomentum  TLabelMomentumLabelLeftKTopIWidthHeightCaption0.000  TLabelLabel7LeftTopWidth� HeightAlignalTop	AlignmenttaCenterAutoSizeCaptionTraining in progress...Color  � Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.Style ParentColor
ParentFont   	TGroupBox	GroupBox2LeftTop� Width� HeightzCaptionTraining dataTabOrder TButtonTargetTblBtnLeftTopWidthqHeightCaptionTarget table...TabOrder OnClickTargetTblBtnClick  TButton
SaveTrnBtnLeftTop*WidthqHeightCaptionSave...EnabledTabOrderOnClickSaveTrnBtnClick  TButton
LoadTrnBtnLeftTopBWidthqHeightCaptionLoad...TabOrderOnClickLoadTrnBtnClick   	TGroupBox	GroupBox1LeftTopWidth� HeightzCaptionNeural networkTabOrder TButtonTrainBtnLeftTopWidthqHeightCaptionTrain...TabOrder OnClickTrainBtnClick  TButtonTopologyBtnLeftTop*WidthqHeightCaptionTopology >>>EnabledTabOrderOnClickTopologyBtnClick  TButtonSaveBtnLeftTopBWidthqHeightCaptionSave...EnabledTabOrderOnClickSaveBtnClick  TButtonLoadBtnLeftTopZWidthqHeightCaptionLoad...TabOrderOnClickLoadBtnClick   TPanelPanel1Left Top�Width�HeightAlignalBottom
BevelOuterbvNoneTabOrder TProgressBarProgressBarLeft
TopWidth HeightMin MaxdTabOrder     TPanelPanel3Left�Top WidthwHeight�AlignalClient
BevelOuterbvNoneTabOrder TLabelLabel8Left Top WidthwHeightAlignalTopAutoSizeCaptionNeural network topology viewsColor  � Font.CharsetDEFAULT_CHARSET
Font.ColorclWhiteFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold ParentColor
ParentFont  TPageControlPageControl1Left TopWidthwHeight�
ActivePage	TabSheet1AlignalClientTabOrder  	TTabSheet	TabSheet1CaptionText TMemoMemo1Left Top WidthoHeighthAlignalClient
ScrollBars
ssVerticalTabOrder    	TTabSheet	TabSheet2CaptionTreeView 	TTreeView	TreeView1Left Top WidthoHeighthIndentAlignalClientTabOrder    	TTabSheet	TabSheet3CaptionGraph+TreeView 	TPaintBoxNetPaintBoxLeft Top WidthoHeight� AlignalClientOnPaintNetPaintBoxPaint  	TTreeViewGraphTreeViewLeft Topj�Width Height� IndentOnChangeGraphTreeViewChangeAlignalBottomTabOrder      TSaveDialog
SaveDialog
DefaultExtlrnFilter,Train File (*.lrn)|*.lrn|All Files (*.*)|*.*LefthTop(  TOpenDialog
OpenDialog
DefaultExtlrnFilter,Train File (*.lrn)|*.lrn|All Files (*.*)|*.*Left@Top(  TOpenDialogNetOpenDialog
DefaultExtnetFilter.Network File (*.net)|*.net|All Files (*.*)|*.*Left@TopP  TSaveDialogNetSaveDialog
DefaultExtnetFilter.Network File (*.net)|*.net|All Files (*.*)|*.*LefthTopP  TBPnetNetworkAutoLR	NetConnection	ncLayeredLearningType	ltPatternMinLR h�X���?BackTrackStep 033333��?	ErrorGoal h�X���?	LearnRate ��������?Momentum ��������?OnIterationNetworkIterationLeft@Top�    