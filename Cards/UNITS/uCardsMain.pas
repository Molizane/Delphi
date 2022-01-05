unit uCardsMain;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs, DB,
  StdCtrls, Buttons, ExtCtrls, Menus, ComCtrls, ClipBrd, ToolWin, ActnList,
  ImgList, DBClient;

type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    FilePrintItem: TMenuItem;
    FileExitItem: TMenuItem;
    EditUndoItem: TMenuItem;
    EditCutItem: TMenuItem;
    EditCopyItem: TMenuItem;
    EditPasteItem: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    Ruler: TPanel;
    FontDialog1: TFontDialog;
    FirstInd: TLabel;
    LeftInd: TLabel;
    RulerLine: TBevel;
    RightInd: TLabel;
    N5: TMenuItem;
    miEditFont: TMenuItem;
    StatusBar: TStatusBar;
    StandardToolBar: TToolBar;
    OpenButton: TToolButton;
    SaveButton: TToolButton;
    PrintButton: TToolButton;
    ToolButton5: TToolButton;
    UndoButton: TToolButton;
    CutButton: TToolButton;
    CopyButton: TToolButton;
    PasteButton: TToolButton;
    ToolButton10: TToolButton;
    FontName: TComboBox;
    FontSize: TEdit;
    ToolButton11: TToolButton;
    UpDown1: TUpDown;
    BoldButton: TToolButton;
    ItalicButton: TToolButton;
    UnderlineButton: TToolButton;
    ToolButton16: TToolButton;
    LeftAlign: TToolButton;
    CenterAlign: TToolButton;
    RightAlign: TToolButton;
    ToolButton20: TToolButton;
    BulletsButton: TToolButton;
    ToolbarImages: TImageList;
    ActionList1: TActionList;
    FileNewCmd: TAction;
    FileOpenCmd: TAction;
    FileSaveCmd: TAction;
    FilePrintCmd: TAction;
    FileExitCmd: TAction;
    NewButton: TToolButton;
    ToolButton2: TToolButton;
    Bevel1: TBevel;
    EditCutCmd: TAction;
    EditCopyCmd: TAction;
    EditPasteCmd: TAction;
    EditUndoCmd: TAction;
    EditFontCmd: TAction;
    FileSaveAsCmd: TAction;
    TabControl: TTabControl;
    DSCards: TClientDataSet;
    DSCardsID: TIntegerField;
    DSCardsDescr: TStringField;
    DSCardsText: TMemoField;
    DelButton: TToolButton;
    procedure SelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShowHint(Sender: TObject);
    procedure FileNew(Sender: TObject);
    procedure FileOpen(Sender: TObject);
    procedure FileSave(Sender: TObject);
    procedure FileSaveAs(Sender: TObject);
    procedure FilePrint(Sender: TObject);
    procedure FileExit(Sender: TObject);
    procedure EditUndo(Sender: TObject);
    procedure EditCut(Sender: TObject);
    procedure EditCopy(Sender: TObject);
    procedure EditPaste(Sender: TObject);
    procedure HelpAbout(Sender: TObject);
    procedure SelectFont(Sender: TObject);
    procedure RulerResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure BoldButtonClick(Sender: TObject);
    procedure ItalicButtonClick(Sender: TObject);
    procedure FontSizeChange(Sender: TObject);
    procedure AlignButtonClick(Sender: TObject);
    procedure FontNameChange(Sender: TObject);
    procedure UnderlineButtonClick(Sender: TObject);
    procedure BulletsButtonClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RulerItemMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RightIndMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure RichEditChange(Sender: TObject);
    procedure ActionList2Update(Action: TBasicAction; var Handled: Boolean);
    procedure TabControlDrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure btnAddClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure RenameCardClick(Sender: TObject);
    procedure TitleChange(Sender: TObject);
    procedure SaveChanges;
    procedure TabControlChange(Sender: TObject);
  private
    FFileName: string;
    FUpdating: Boolean;
    FDragOfs: Integer;
    FDragging: Boolean;
    Cards: array of TRichEdit;
    edtTitulos: array of TEdit;
    TabSheets: array of TPanel;
    Novos: Integer;
    FPath: string;
    FBackup: Boolean;
    procedure CreateCard(ReadFromDataSet: Boolean; Caption: string);
    function CurrText: TTextAttributes;
    procedure GetFontNames;
    procedure SetFileName(const FileName: string);
    function CheckFileSave: Boolean;
    procedure SetupRuler;
    procedure SetEditRect;
    procedure UpdateCursorPos;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
    procedure PerformFileOpen(const AFileName: string);
    procedure SetModified(Value: Boolean);
  end;

var
  MainForm: TMainForm;

implementation

uses
  RichEdit, ShellAPI, uCardsTitle, uCardsAbout;

resourcestring
  sSaveChanges = 'Save changes to %s?';
  sOverWrite = 'OK to overwrite %s';
  sUntitled = 'Untitled';
  sModified = 'Modified';
  sColRowInfo = 'Line: %3d   Col: %3d';

const
  RulerAdj = 4 / 3;
  GutterWid = 6;

  ENGLISH = (SUBLANG_ENGLISH_US shl 10) or LANG_ENGLISH;
  FRENCH = (SUBLANG_FRENCH shl 10) or LANG_FRENCH;
  GERMAN = (SUBLANG_GERMAN shl 10) or LANG_GERMAN;
  PORTUGUESE = (SUBLANG_PORTUGUESE shl 10) or LANG_PORTUGUESE;

{$R *.dfm}

procedure TMainForm.SelectionChange(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  with Cards[TabControl.TabIndex].Paragraph do
  try
    FUpdating := True;
    FirstInd.Left := Trunc(FirstIndent * RulerAdj) - 4 + GutterWid;
    LeftInd.Left := Trunc((LeftIndent + FirstIndent) * RulerAdj) - 4 + GutterWid;
    RightInd.Left := Ruler.ClientWidth - 6 - Trunc((RightIndent + GutterWid) * RulerAdj);
    BoldButton.Down := fsBold in Cards[TabControl.TabIndex].SelAttributes.Style;
    ItalicButton.Down := fsItalic in Cards[TabControl.TabIndex].SelAttributes.Style;
    UnderlineButton.Down := fsUnderline in Cards[TabControl.TabIndex].SelAttributes.Style;
    BulletsButton.Down := Boolean(Numbering);
    FontSize.Text := IntToStr(Cards[TabControl.TabIndex].SelAttributes.Size);
    FontName.Text := Cards[TabControl.TabIndex].SelAttributes.Name;

    case Ord(Alignment) of
      0: LeftAlign.Down := True;
      1: RightAlign.Down := True;
      2: CenterAlign.Down := True;
    end;

    UpdateCursorPos;
  finally
    FUpdating := False;
  end;
end;

function TMainForm.CurrText: TTextAttributes;
begin
  if TabControl.TabIndex = -1 then
    Result := nil
  else //if Cards[TabControl.TabIndex].SelLength > 0 then
    Result := Cards[TabControl.TabIndex].SelAttributes
      //else
    //  Result := Cards[TabControl.TabIndex].DefAttributes;
end;

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  TStrings(Data).Add(LogFont.lfFaceName);
  Result := 1;
end;

procedure TMainForm.GetFontNames;
var
  DC: HDC;
begin
  DC := GetDC(0);
  EnumFonts(DC, nil, @EnumFontsProc, Pointer(FontName.Items));
  ReleaseDC(0, DC);
  FontName.Sorted := True;
end;

procedure TMainForm.SetFileName(const FileName: string);
begin
  FFileName := FileName;
end;

function TMainForm.CheckFileSave: Boolean;
var
  SaveResp: Integer;
begin
  Result := True;

  if not FBackup then
    Exit;

  SaveResp := MessageDlg('Save changes?', mtConfirmation, mbYesNoCancel, 0);

  case SaveResp of
    idYes: SaveChanges;
    idNo: {Nothing};
    idCancel: Result := False;
  end;
end;

procedure TMainForm.SetupRuler;
var
  I: Integer;
  S: string;
begin
  SetLength(S, 201);
  I := 1;

  while I < 200 do
  begin
    S[I] := #9;
    S[I + 1] := '|';
    Inc(I, 2);
  end;

  Ruler.Caption := S;
end;

procedure TMainForm.SetEditRect;
var
  R: TRect;
begin
  if TabControl.TabIndex = -1 then
    Exit;

  with Cards[TabControl.TabIndex] do
  begin
    R := Rect(GutterWid, 0, ClientWidth - GutterWid, ClientHeight);
    SendMessage(Handle, EM_SETRECT, 0, Longint(@R));
  end;
end;

{ Event Handlers }

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  Novos := 1;
  FPath := ExtractFilePath(Application.ExeName);
  DSCards.FileName := FPath + 'Cards.dat';

  if not FileExists(DSCards.FileName) then
  begin
    DSCards.CreateDataSet;
    DSCards.SaveToFile(DSCards.FileName);
  end;

  DSCards.Open;

  if not DSCards.IsEmpty then
  begin
    for i := 0 to DSCards.RecordCount - 1 do
    begin
      CreateCard(True, '');
      DSCards.Next;
    end;

    TabControl.TabIndex := 0;
  end;

  Application.OnHint := ShowHint;
  OpenDialog.InitialDir := ExtractFilePath(ParamStr(0));
  SaveDialog.InitialDir := OpenDialog.InitialDir;
  SetFileName(sUntitled);
  GetFontNames;
  SetupRuler;
  SelectionChange(Self);
end;

procedure TMainForm.ShowHint(Sender: TObject);
begin
  if Length(Application.Hint) > 0 then
  begin
    StatusBar.SimplePanel := True;
    StatusBar.SimpleText := Application.Hint;
  end
  else
    StatusBar.SimplePanel := False;
end;

procedure TMainForm.FileNew(Sender: TObject);
begin
  FTitulo.edtTitulo.Text := '';

  if FTitulo.ShowModal = mrOk then
  begin
    CreateCard(False, Trim(FTitulo.edtTitulo.Text));
    Dec(Novos);

    Cards[TabControl.TabIndex].Lines.Clear;
    Cards[TabControl.TabIndex].Modified := False;
    SetModified(False);
    Cards[TabControl.TabIndex].SetFocus;
    SelectionChange(Self);
    FBackup := True;
  end;
end;

procedure TMainForm.PerformFileOpen(const AFileName: string);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  Cards[TabControl.TabIndex].Lines.LoadFromFile(AFileName);
  SetFileName(AFileName);
  Cards[TabControl.TabIndex].SetFocus;
  Cards[TabControl.TabIndex].Modified := False;
  SetModified(False);
end;

procedure TMainForm.FileOpen(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  if OpenDialog.Execute then
  begin
    PerformFileOpen(OpenDialog.FileName);
    Cards[TabControl.TabIndex].ReadOnly := ofReadOnly in OpenDialog.Options;
  end;
end;

procedure TMainForm.FileSave(Sender: TObject);
begin
  if TabControl.Tabs.Count = 0 then
    Exit;

  if FFileName = sUntitled then
    FileSaveAs(Sender)
  else
  begin
    Cards[TabControl.TabIndex].Lines.SaveToFile(FFileName);
    Cards[TabControl.TabIndex].Modified := False;
    SetModified(False);
  end;
end;

procedure TMainForm.FileSaveAs(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    if FileExists(SaveDialog.FileName) then
      if MessageDlg(Format(sOverWrite, [SaveDialog.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then
        Exit;

    Cards[TabControl.TabIndex].Lines.SaveToFile(SaveDialog.FileName);
    SetFileName(SaveDialog.FileName);
    Cards[TabControl.TabIndex].Modified := False;
    SetModified(False);
  end;
end;

procedure TMainForm.FilePrint(Sender: TObject);
begin
  if (TabControl.Tabs.Count <> 0) and PrintDialog.Execute then
    Cards[TabControl.TabIndex].Print(FFileName);
end;

procedure TMainForm.FileExit(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.EditUndo(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  with Cards[TabControl.TabIndex] do
    if HandleAllocated then
      SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TMainForm.EditCut(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  Cards[TabControl.TabIndex].CutToClipboard;
end;

procedure TMainForm.EditCopy(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  Cards[TabControl.TabIndex].CopyToClipboard;
end;

procedure TMainForm.EditPaste(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  Cards[TabControl.TabIndex].PasteFromClipboard;
end;

procedure TMainForm.HelpAbout(Sender: TObject);
begin
  with TAboutBox.Create(Self) do
  try
    ShowModal;
  finally
    Release;
  end;
end;

procedure TMainForm.SelectFont(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  FontDialog1.Font.Assign(Cards[TabControl.TabIndex].SelAttributes);

  if FontDialog1.Execute then
    CurrText.Assign(FontDialog1.Font);

  SelectionChange(Self);
  Cards[TabControl.TabIndex].SetFocus;
end;

procedure TMainForm.RulerResize(Sender: TObject);
begin
  RulerLine.Width := Ruler.ClientWidth - (RulerLine.Left * 2);
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  SetEditRect;
  SelectionChange(Sender);
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  SetEditRect;
end;

procedure TMainForm.BoldButtonClick(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  if FUpdating then
    Exit;

  if BoldButton.Down then
    CurrText.Style := CurrText.Style + [fsBold]
  else
    CurrText.Style := CurrText.Style - [fsBold];
end;

procedure TMainForm.ItalicButtonClick(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  if FUpdating then
    Exit;

  if ItalicButton.Down then
    CurrText.Style := CurrText.Style + [fsItalic]
  else
    CurrText.Style := CurrText.Style - [fsItalic];
end;

procedure TMainForm.FontSizeChange(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  if FUpdating then
    Exit;

  CurrText.Size := StrToInt(FontSize.Text);
end;

procedure TMainForm.AlignButtonClick(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  if FUpdating then
    Exit;

  Cards[TabControl.TabIndex].Paragraph.Alignment := TAlignment(TControl(Sender).Tag);
end;

procedure TMainForm.FontNameChange(Sender: TObject);
begin
  if FUpdating then
    Exit;

  CurrText.Name := FontName.Items[FontName.ItemIndex];
end;

procedure TMainForm.UnderlineButtonClick(Sender: TObject);
begin
  if FUpdating then
    Exit;

  if UnderlineButton.Down then
    CurrText.Style := CurrText.Style + [fsUnderline]
  else
    CurrText.Style := CurrText.Style - [fsUnderline];
end;

procedure TMainForm.BulletsButtonClick(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  if FUpdating then
    Exit;

  Cards[TabControl.TabIndex].Paragraph.Numbering := TNumberingStyle(BulletsButton.Down);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  try
    if not CheckFileSave then
      CanClose := False;
  except
    CanClose := False;
  end;
end;

{ Ruler Indent Dragging }

procedure TMainForm.RulerItemMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDragOfs := (TLabel(Sender).Width div 2);
  TLabel(Sender).Left := TLabel(Sender).Left + X - FDragOfs;
  FDragging := True;
end;

procedure TMainForm.RulerItemMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if FDragging then
    TLabel(Sender).Left := TLabel(Sender).Left + X - FDragOfs
end;

procedure TMainForm.FirstIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  FDragging := False;
  Cards[TabControl.TabIndex].Paragraph.FirstIndent := Trunc((FirstInd.Left + FDragOfs - GutterWid) / RulerAdj);
  LeftIndMouseUp(Sender, Button, Shift, X, Y);
end;

procedure TMainForm.LeftIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  FDragging := False;
  Cards[TabControl.TabIndex].Paragraph.LeftIndent := Trunc((LeftInd.Left + FDragOfs - GutterWid) / RulerAdj) - Cards[TabControl.TabIndex].Paragraph.FirstIndent;
  SelectionChange(Sender);
end;

procedure TMainForm.RightIndMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  FDragging := False;
  Cards[TabControl.TabIndex].Paragraph.RightIndent := Trunc((Ruler.ClientWidth - RightInd.Left + FDragOfs - 2) / RulerAdj) - 2 * GutterWid;
  SelectionChange(Sender);
end;

procedure TMainForm.UpdateCursorPos;
var
  CharPos: TPoint;
begin
  if TabControl.TabIndex = -1 then
    Exit;

  CharPos.Y := SendMessage(Cards[TabControl.TabIndex].Handle, EM_EXLINEFROMCHAR, 0,
    Cards[TabControl.TabIndex].SelStart);
  CharPos.X := (Cards[TabControl.TabIndex].SelStart -
    SendMessage(Cards[TabControl.TabIndex].Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  StatusBar.Panels[0].Text := Format(sColRowInfo, [CharPos.Y, CharPos.X]);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  UpdateCursorPos;
  DragAcceptFiles(Handle, True);
  RichEditChange(nil);

  { Check if we should load a file from the command line }
  if (ParamCount > 0) and FileExists(ParamStr(1)) then
    PerformFileOpen(ParamStr(1));

  TabControl.SetFocus;

  SetModified(False);
  FBackup := False;
  TabControlChange(TabControl);
end;

procedure TMainForm.WMDropFiles(var Msg: TWMDropFiles);
var
  CFileName: array[0..MAX_PATH] of Char;
begin
  try
    if DragQueryFile(Msg.Drop, 0, CFileName, MAX_PATH) > 0 then
    begin
      PerformFileOpen(CFileName);
      Msg.Result := 0;
    end;
  finally
    DragFinish(Msg.Drop);
  end;
end;

procedure TMainForm.RichEditChange(Sender: TObject);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  SetModified(Cards[TabControl.TabIndex].Modified);
end;

procedure TMainForm.SetModified(Value: Boolean);
begin
  if Value then
  begin
    StatusBar.Panels[1].Text := sModified;
    FBackup := True;
  end
  else
    StatusBar.Panels[1].Text := '';
end;

procedure TMainForm.ActionList2Update(Action: TBasicAction; var Handled: Boolean);
begin
  if TabControl.TabIndex = -1 then
    Exit;

  { Update the status of the edit commands }
  EditCutCmd.Enabled := Cards[TabControl.TabIndex].SelLength > 0;
  EditCopyCmd.Enabled := EditCutCmd.Enabled;

  if Cards[TabControl.TabIndex].HandleAllocated then
  begin
    EditUndoCmd.Enabled := Cards[TabControl.TabIndex].Perform(EM_CANUNDO, 0, 0) <> 0;
    EditPasteCmd.Enabled := Cards[TabControl.TabIndex].Perform(EM_CANPASTE, 0, 0) <> 0;
  end;
end;

procedure TMainForm.CreateCard(ReadFromDataSet: Boolean; Caption: string);
var
  Panel: TPanel;
  PanelTitulo: TPanel;
  Index: Integer;
  Caption_: string;
begin
  if ReadFromDataSet then
    Caption_ := DSCardsDescr.AsString
  else
  begin
    if Trim(Caption) = '' then
      Caption_ := 'New ' + IntToStr(Novos)
    else
      Caption_ := Caption;

    Inc(Novos);
  end;

  Index := Length(Cards);
  SetLength(Cards, Index + 1);
  SetLength(edtTitulos, Index + 1);
  SetLength(TabSheets, Index + 1);

  TabControl.Tabs.Add(' ' + Caption_ + ' ');

  TabSheets[Index] := TPanel.Create(TabControl);
  TabSheets[Index].Visible := True;
  TabSheets[Index].Parent := TabControl;
  TabSheets[Index].Caption := '';
  TabSheets[Index].Align := alClient;
  TabSheets[Index].Tag := Index;

  Panel := TPanel.Create(TabSheets[Index]);

  with Panel do
  begin
    Name := 'Panel' + IntToStr(Index);
    Parent := TabSheets[Index];
    Align := alClient;
    BorderStyle := bsSingle;
    Caption := '';
    Color := clWhite;
    Ctl3D := False;
    ParentCtl3D := False;
  end;

  PanelTitulo := TPanel.Create(TabSheets[Index]);

  with PanelTitulo do
  begin
    Name := 'PanelTitle' + IntToStr(Index);
    Parent := Panel;
    Left := 1;
    Top := 1;
    Width := 685;
    Height := 24;
    Align := alTop;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    Caption := '';
  end;

  edtTitulos[Index] := TEdit.Create(TabSheets[Index]);

  with edtTitulos[Index] do
  begin
    Name := 'edtTitulos' + IntToStr(Index);
    Parent := PanelTitulo;
    Left := 2;
    Top := 3;
    Width := PanelTitulo.Width - 4;
    Height := 21;
    Anchors := [akLeft, akTop, akRight, akBottom];
    MaxLength := 60;
    OnChange := TitleChange;
    Text := Trim(Caption_);
  end;

  Cards[Index] := TRichEdit.Create(TabSheets[Index]);

  with Cards[Index] do
  begin
    Name := 'Card' + IntToStr(Index);
    Parent := Panel;
    Align := alClient;
    Tag := Index;
    ScrollBars := ssBoth;
    HideSelection := False;
    OnSelectionChange := SelectionChange;

    if ReadFromDataSet then
      Lines.Assign(DSCardsText)
    else
      Text := '';

    Cards[Index].Modified := False;
    OnChange := RichEditChange;
  end;

  TabControl.TabIndex := Index;

  DelButton.Enabled := True;
  OpenButton.Enabled := True;
  SaveButton.Enabled := True;
  PrintButton.Enabled := True;
  CutButton.Enabled := True;
  CopyButton.Enabled := True;
  PasteButton.Enabled := True;
  UndoButton.Enabled := True;
  FontName.Enabled := True;
  FontSize.Enabled := True;
  UpDown1.Enabled := True;
  BoldButton.Enabled := True;
  ItalicButton.Enabled := True;
  UnderlineButton.Enabled := True;
  LeftAlign.Enabled := True;
  CenterAlign.Enabled := True;
  RightAlign.Enabled := True;
  BulletsButton.Enabled := True;
end;

procedure TMainForm.TabControlDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  nLeft, nTop: Integer;
begin
  Control.Canvas.Brush.Color := clWhite;
  Control.Canvas.FillRect(Rect);
  nLeft := (Rect.Right - Rect.Left - Control.Canvas.TextWidth(TabControl.Tabs[TabIndex])) div 2;
  nTop := (Rect.Bottom - Rect.Top - Control.Canvas.TextHeight(TabControl.Tabs[TabIndex])) div 2;
  Control.Canvas.TextOut(Rect.Left + nLeft, Rect.Top + nTop, TabControl.Tabs[TabIndex]);
end;

procedure TMainForm.btnAddClick(Sender: TObject);
begin
  if FTitulo.ShowModal = mrOk then
  begin
    CreateCard(False, Trim(FTitulo.edtTitulo.Text));
    Dec(Novos);
  end;
end;

procedure TMainForm.btnDelClick(Sender: TObject);
var
  i, n: Integer;
begin
  if (TabControl.Tabs.Count = 0) or
    (MessageBox(0, 'Confirm delete...', ' Confirmation',
    MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON2) = mrNo) then
    Exit;

  n := TabControl.TabIndex;

  TabSheets[n].Free;

  for i := n to TabControl.Tabs.Count - 2 do
  begin
    TabSheets[i] := TabSheets[i + 1];
    TabSheets[i].Tag := i;
    Cards[i] := Cards[i + 1];
    Cards[i].Tag := i;
  end;

  SetLength(TabSheets, Length(TabSheets) - 1);
  SetLength(Cards, Length(Cards) - 1);

  TabControl.Tabs.Delete(n);

  if TabControl.Tabs.Count > 0 then
  begin
    if n > 0 then
      Dec(n);

    TabControl.TabIndex := n;
    TabControlChange(TabControl);
  end;

  FBackup := True;

  DelButton.Enabled := TabControl.Tabs.Count <> 0;
  OpenButton.Enabled := DelButton.Enabled;
  SaveButton.Enabled := DelButton.Enabled;
  PrintButton.Enabled := DelButton.Enabled;
  CutButton.Enabled := DelButton.Enabled;
  CopyButton.Enabled := DelButton.Enabled;
  PasteButton.Enabled := DelButton.Enabled;
  UndoButton.Enabled := DelButton.Enabled;
  FontName.Enabled := DelButton.Enabled;
  FontSize.Enabled := DelButton.Enabled;
  UpDown1.Enabled := DelButton.Enabled;
  BoldButton.Enabled := DelButton.Enabled;
  ItalicButton.Enabled := DelButton.Enabled;
  UnderlineButton.Enabled := DelButton.Enabled;
  LeftAlign.Enabled := DelButton.Enabled;
  CenterAlign.Enabled := DelButton.Enabled;
  RightAlign.Enabled := DelButton.Enabled;
  BulletsButton.Enabled := DelButton.Enabled;
end;

procedure TMainForm.RenameCardClick(Sender: TObject);
begin
  if TabControl.Tabs.Count = 0 then
    Exit;

  FTitulo.edtTitulo.Text := Trim(TabControl.Tabs[TabControl.TabIndex]);

  if FTitulo.ShowModal = mrOk then
    TabControl.Tabs[TabControl.TabIndex] := ' ' + Trim(FTitulo.edtTitulo.Text) + ' ';
end;

procedure TMainForm.TitleChange(Sender: TObject);
begin
  TabControl.Tabs[TWinControl(Sender).Parent.Parent.Parent.Tag] := ' ' + TEdit(Sender).Text + ' ';
  SetModified(True);
end;

procedure TMainForm.SaveChanges;
var
  i: Integer;
begin
  if FBackup and not DSCards.IsEmpty then
  begin
    ForceDirectories(FPath + 'BKP');
    DSCards.SaveToFile(FPath + 'BKP\Cards_' + FormatDateTime('yyyymmddhhnn', Now()) + '.bkp');
    FBackup := False;
  end;

  DSCards.EmptyDataSet;

  for i := 0 to TabControl.Tabs.Count - 1 do
  begin
    DSCards.Append;

    try
      DSCardsID.AsInteger := i + 1;
      DSCardsDescr.AsString := TabControl.Tabs[i];
      DSCardsText.Assign(Cards[i].Lines);
      DSCards.Post;
    except
      DSCards.Cancel;
      raise;
    end
  end;
end;

procedure TMainForm.TabControlChange(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to TabControl.Tabs.Count - 1 do
  begin
    TabSheets[i].Visible := i = TabControl.TabIndex;

    if TabSheets[i].Visible then
      Cards[i].SetFocus;

    SelectionChange(Cards[i]);
  end
end;

end.

