unit NestorFonte;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ImgList, ActnList, ComCtrls, ToolWin, Menus, StdActns;

type
  TFrmFontes = class(TForm)
    ImageList3: TImageList;
    pcFontes: TPageControl;
    ToolBar1: TToolBar;
    btnAbrir: TToolButton;
    btnSalvar: TToolButton;
    ToolButton3: TToolButton;
    btnCopiar: TToolButton;
    btnRecortar: TToolButton;
    btnColar: TToolButton;
    ToolButton15: TToolButton;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ActionList1: TActionList;
    EditCut: TEditCut;
    EditCopy: TEditCopy;
    EditPaste: TEditPaste;
    Open: TAction;
    Save: TAction;
    Compile: TAction;
    SaveAs: TAction;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    SaveAs1: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Paste1: TMenuItem;
    btnCompilar: TToolButton;
    btnNovo: TToolButton;
    Novo1: TMenuItem;
    New: TAction;
    PopupMenu: TPopupMenu;
    Fechar1: TMenuItem;
    N2: TMenuItem;
    Fechar2: TMenuItem;
    ToolButton2: TToolButton;
    btnListagem: TToolButton;
    procedure CompileExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pcFontesChange(Sender: TObject);
    procedure OpenExecute(Sender: TObject);
    procedure NewExecute(Sender: TObject);
    procedure SaveExecute(Sender: TObject);
    procedure SaveAsExecute(Sender: TObject);
    procedure MemoChanged(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure btnListagemClick(Sender: TObject);
  private
    FMemosFontes: array of TMemo;
    FFileNames: array of string;
    FModified: array of Boolean;
    FonteIdx: Integer;
    function GetFileName: string;
    function GetFonteAtual: TMemo;
    procedure SetFileName(Value: string);
    procedure FechaArquivo(Idx: Integer; DestroyPage: Boolean);
    procedure SetMemoTabStop(Editor: TMemo);
  public
    procedure CarregaArquivo(Source: string);
    procedure SaveAll;
    property FonteAtual: TMemo read GetFonteAtual;
    property FileName: string read GetFileName write SetFileName;
  end;

var
  FrmFontes: TFrmFontes;

implementation

uses
  NestorMain, NestorListagem, MemoryZ80;

{$R *.dfm}

var
  TabArray: array[0..20] of Integer;

  { TFrmFonte }

procedure TFrmFontes.CarregaArquivo(Source: string);
var
  TabSheet: TTabSheet;
  i: Integer;
begin
  if Source <> '' then
    for i := Low(FFileNames) to High(FFileNames) do
      if FFileNames[i] = Source then
      begin
        pcFontes.ActivePageIndex := i;
        MessageDlg('File already open', mtInformation, [mbOK], 0);
        Exit;
      end;

  TabSheet := TTabSheet.Create(Self);
  FonteIdx := Length(FMemosFontes) + 1;
  SetLength(FFileNames, FonteIdx);
  SetLength(FMemosFontes, FonteIdx);
  SetLength(FModified, FonteIdx);

  with TabSheet do
  begin
    Name := 'tsSource' + IntToStr(FonteIdx);
    Parent := pcFontes;
    PageControl := pcFontes;

    if Source = '' then
      Caption := ' (new) '
    else
      Caption := ' ' + ExtractFileName(Source) + ' ';
  end;

  Dec(FonteIdx);
  FMemosFontes[FonteIdx] := TMemo.Create(Self);

  with FMemosFontes[FonteIdx] do
  begin
    Name := 'mFontes' + IntToStr(FonteIdx);
    Parent := TabSheet;
    Align := alClient;
    Font.Name := 'Courier';
    Font.Height := -16;
    Font.Style := [];
    OnChange := MemoChanged;
    ScrollBars := ssBoth;
    WantReturns := True;
    WantTabs := True;

    if Source = '' then
      Lines.Clear
    else
    begin
      Lines.LoadFromFile(Source);
      FileName := Source;
    end;
  end;

  SetMemoTabStop(FMemosFontes[FonteIdx]);

  FModified[FonteIdx] := False;
  pcFontes.ActivePageIndex := FonteIdx;
  FrmMain.opcFontes.Enabled := True;
  Show;
end;

procedure TFrmFontes.CompileExecute(Sender: TObject);
var
  f: TextFile;
  srcname, command: string;
  elapsed: DWORD;
begin
  if FMemosFontes[FonteIdx].Lines.Count = 0 then
    Exit;

  if not FileExists(FrmMain.Compiler) then
    raise Exception.Create('Compilador não encontrado: ' + FrmMain.Compiler);

  Compile.Enabled := False;
  FrmMain.Run.Enabled := False;
  FrmMain.Step.Enabled := False;
  FrmMain.Halt.Enabled := False;
  btnListagem.Visible := False;

  srcname := ChangeFileExt(Trim(pcFontes.ActivePage.Caption), '.');

  try
    DeleteFile(CompPath + srcname + 'ASM');
    DeleteFile(CompPath + srcname + 'HEX');
    DeleteFile(CompPath + srcname + 'LST');
    DeleteFile(CompPath + 'ok.out');

    FMemosFontes[FonteIdx].Lines.SaveToFile(CompPath + srcname + 'ASM');
    LstForm.Listagem.Lines.Clear;

    AssignFile(f, CompPath + 'comp.bat');
    Rewrite(f);

    try
      command := '"' + FrmMain.Compiler + '" ' + StringReplace(FrmMain.Parameters, '#ASM', srcname + 'ASM', [rfReplaceAll, rfIgnoreCase]);
      command := StringReplace(command, '#LST', srcname + 'LST', [rfReplaceAll, rfIgnoreCase]);

      Writeln(f, '@ECHO OFF');
      Writeln(f, 'CD "' + CompPath + '"');
      Writeln(f, 'IF EXIST ok.out DEL ok.out');
      Writeln(f, command);
      Writeln(f, 'IF NOT ERRORLEVEL 1 GOTO FIM');
      Writeln(f, 'IF EXIST ' + srcname + 'HEX DEL ' + srcname + 'HEX');
      Writeln(f, ':FIM');
      Writeln(f, 'echo OK > ok.out');
    finally
      CloseFile(f);
    end;

    WinExec(PChar(CompPath + 'comp.bat'), SW_HIDE);
    elapsed := GetTickCount() + 30000;

    while not FileExists(CompPath + 'ok.out') and (GetTickCount() <= elapsed) do
      Application.ProcessMessages;

    if not FileExists(CompPath + 'ok.out') then
      raise Exception.Create('Compilation failed. Time-out in compilation.');

    if FileExists(CompPath + srcname + 'LST') then
    begin
      LstForm.Listagem.Lines.LoadFromFile(CompPath + srcname + 'LST');
      btnListagem.Visible := True;
    end;

    if FileExists(CompPath + srcname + 'HEX') then
      LoadHex(CompPath, srcname + 'HEX', FrmMain.Memory);

    CopyFile(PChar(CompPath + srcname + 'HEX'), PChar(ChangeFileExt(FileName, '.HEX')), False);
    CopyFile(PChar(CompPath + srcname + 'LST'), PChar(ChangeFileExt(FileName, '.LST')), False);

    if not (FileExists(CompPath + srcname + 'LST') and FileExists(CompPath + srcname + 'HEX')) then
      MessageDlg('Compilation failed', mtError, [mbOK], 0);

    LstForm.Show; //Modal;

    if not (FileExists(CompPath + srcname + 'LST') and FileExists(CompPath + srcname + 'HEX')) then
      Exit;

    DeleteFile(CompPath + 'comp.bat');
    DeleteFile(CompPath + srcname + 'ASM');
    DeleteFile(CompPath + srcname + 'LST');
    DeleteFile(CompPath + srcname + 'HEX');
  finally
    DeleteFile(CompPath + 'ok.out');
    Compile.Enabled := True;
    FrmMain.Run.Enabled := True;
    FrmMain.Step.Enabled := True;
    FrmMain.Reset.Enabled := True;
    FrmMain.Halt.Enabled := False;
  end;
end;

procedure TFrmFontes.FormCreate(Sender: TObject);
begin
  FonteIdx := 0;
  OpenDialog.InitialDir := ExtractFilePath(Application.ExeName);
  SaveDialog.InitialDir := OpenDialog.InitialDir;
end;

function TFrmFontes.GetFileName: string;
begin
  Result := FFileNames[FonteIdx];
end;

function TFrmFontes.GetFonteAtual: TMemo;
begin
  Result := FMemosFontes[FonteIdx];
end;

procedure TFrmFontes.pcFontesChange(Sender: TObject);
begin
  FonteIdx := pcFontes.ActivePageIndex;
  Caption := 'Source: ' + pcFontes.ActivePage.Caption;
end;

procedure TFrmFontes.SetFileName(Value: string);
begin
  FFileNames[FonteIdx] := Value;
  pcFontes.Pages[FonteIdx].Caption := ' ' + ExtractFileName(Value) + ' ';
end;

procedure TFrmFontes.OpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    FrmMain.PauseExecute(FrmMain.Pause);
    CarregaArquivo(OpenDialog.FileName);
    SaveDialog.InitialDir := OpenDialog.InitialDir;
    btnListagem.Visible := False;
    LstForm.Listagem.Lines.Clear;
  end;
end;

procedure TFrmFontes.NewExecute(Sender: TObject);
begin
  CarregaArquivo('');
end;

procedure TFrmFontes.SaveExecute(Sender: TObject);
begin
  if FileName = '' then
  begin
    if SaveDialog.Execute then
    begin
      FileName := SaveDialog.FileName;
      FonteAtual.Lines.SaveToFile(SaveDialog.FileName);
      FModified[FonteIdx] := False;
      OpenDialog.InitialDir := SaveDialog.InitialDir;
    end;
  end
  else
  begin
    FonteAtual.Lines.SaveToFile(FileName);
    FModified[FonteIdx] := False;
  end;
end;

procedure TFrmFontes.SaveAsExecute(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    FonteAtual.Lines.SaveToFile(SaveDialog.FileName);
    FileName := SaveDialog.FileName;
    FModified[FonteIdx] := False;
  end;
end;

procedure TFrmFontes.MemoChanged(Sender: TObject);
begin
  FModified[FonteIdx] := True;
end;

procedure TFrmFontes.SaveAll;
var
  i: Integer;
begin
  if Length(FMemosFontes) > 0 then
    for i := Low(FMemosFontes) to High(FMemosFontes) do
      FechaArquivo(i, False);
end;

procedure TFrmFontes.Fechar1Click(Sender: TObject);
begin
  FechaArquivo(FonteIdx, True);
end;

procedure TFrmFontes.FechaArquivo(Idx: Integer; DestroyPage: Boolean);
var
  s: string;
  r: Integer;
  TabSheet: TTabSheet;
begin
  if FModified[Idx] then
  begin
    if Filename = '' then
      s := '<novo>'
    else
      s := FFileNames[Idx];

    r := Application.MessageBox(PChar('Save ' + s), 'Attention',
      MB_YESNOCANCEL);

    if r = IDCANCEL then
      Abort
    else if r = IDYES then
    begin
      if Filename = '' then
      begin
        if SaveDialog.Execute then
          FonteAtual.Lines.SaveToFile(SaveDialog.FileName)
        else
          Abort;
      end
      else
        FonteAtual.Lines.SaveToFile(FileName);

      FModified[Idx] := False;
    end;
  end;

  if DestroyPage then
  begin
    FMemosFontes[Idx].Destroy;

    if pcFontes.PageCount > 1 then
    begin
      r := Idx;

      while r <= pcFontes.PageCount - 2 do
      begin
        FFileNames[r] := FFileNames[r + 1];
        FMemosFontes[r] := FMemosFontes[r + 1];
        FModified[r] := FModified[r + 1];
        Inc(r);
      end;
    end;

    TabSheet := pcFontes.Pages[Idx];
    TabSheet.PageControl := nil;
    TabSheet.Destroy;

    SetLength(FFileNames, Length(FFileNames) - 1);
    SetLength(FMemosFontes, Length(FMemosFontes) - 1);
    SetLength(FModified, Length(FModified) - 1);

    if pcFontes.PageCount = 0 then
    begin
      Hide;
      FrmMain.opcFontes.Enabled := False;
    end
    else if FonteIdx >= pcFontes.PageCount then
    begin
      FonteIdx := pcFontes.PageCount - 1;
      pcFontes.ActivePageIndex := FonteIdx;
    end;
  end;
end;

procedure TFrmFontes.btnListagemClick(Sender: TObject);
begin
  LstForm.Show; //Modal;
end;

procedure TFrmFontes.SetMemoTabStop(Editor: TMemo);
// Thanks to Phoenix
// http://delphitipsandtricks2.blogspot.com/2012/03/set-tab-stops-for-tmemo.html
var
  DialogUnitsX: LongInt;
  PixelsX: LongInt;
  i: integer;
  PixelPerCharExt: Extended;
  PixelPerCharInt: Integer;
begin
  Editor.WantTabs := true;
  DialogUnitsX := LoWord(GetDialogBaseUnits);

  PixelPerCharExt := (Editor.Font.Size / 72) * 96;
  PixelPerCharInt := Trunc(PixelPerCharExt);

  PixelsX := PixelPerCharInt * 2;
  // tab. 2 (4 characters), just change 2 with anything you like.

  for i := Low(TabArray) to High(TabArray) do
    TabArray[i] := ((PixelsX * (i + 1)) * 4) div DialogUnitsX;

  SendMessage(Editor.Handle, EM_SETTABSTOPS, Length(TabArray),
    LongInt(@TabArray));
  Editor.Refresh;
end;

end.

