unit UConfigCompile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Mask, Grids, DB, DBCtrls, DBGrids,
  DBClient;

type
  TFrmMain = class(TForm)
    DBGrid1: TDBGrid;
    DSProjetos: TDataSource;
    DBNavigator1: TDBNavigator;
    SelectProject: TOpenDialog;
    DSConfigs: TDataSource;
    Panel1: TPanel;
    BtnConfiguracoes: TSpeedButton;
    BtnSair: TSpeedButton;
    GBCompiler: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    ChkOptimization: TDBCheckBox;
    ChkStackFrame: TDBCheckBox;
    ChkPentiumSafeFDIV: TDBCheckBox;
    CmbRecordFieldAlignment: TDBComboBox;
    GroupBox3: TGroupBox;
    ChkRangeChecking: TDBCheckBox;
    ChkIOChecking: TDBCheckBox;
    ChkOverflowChecking: TDBCheckBox;
    GroupBox4: TGroupBox;
    ChkDebugInformation: TDBCheckBox;
    ChkLocalSymbols: TDBCheckBox;
    ChkReferenceInfo: TDBCheckBox;
    ChkDefinitionsOnly: TDBCheckBox;
    ChkAssertions: TDBCheckBox;
    ChkUseDebugDcus: TDBCheckBox;
    GBLinker: TGroupBox;
    GroupBox1: TGroupBox;
    ChkIncludeTD32DebugInfo: TDBCheckBox;
    ChkIncludeRemoteDebugSymbols: TDBCheckBox;
    RBMapFile: TDBRadioGroup;
    BtnGravar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    DBNavigator2: TDBNavigator;
    BtnAplicar: TSpeedButton;
    cdsProjetos: TClientDataSet;
    cdsProjetosSeq: TIntegerField;
    cdsProjetosCaminho: TStringField;
    cdsConfigs: TClientDataSet;
    cdsConfigsSeq: TIntegerField;
    cdsConfigsNome: TStringField;
    cdsConfigsOptimization: TBooleanField;
    cdsConfigsStackFrame: TBooleanField;
    cdsConfigsPentiumSafeFDIV: TBooleanField;
    cdsConfigsRecordFieldAlignment: TIntegerField;
    cdsConfigsRangeChecking: TBooleanField;
    cdsConfigsIOChecking: TBooleanField;
    cdsConfigsOverflowChecking: TBooleanField;
    cdsConfigsDebugInformation: TBooleanField;
    cdsConfigsLocalSymbols: TBooleanField;
    cdsConfigsReferenceInfo: TBooleanField;
    cdsConfigsDefinitionsOnly: TBooleanField;
    cdsConfigsAssertions: TBooleanField;
    cdsConfigsUseDebugDcus: TBooleanField;
    cdsConfigsMapFile: TIntegerField;
    cdsConfigsIncludeTD32DebugInfo: TBooleanField;
    cdsConfigsIncludeRemoteDebugSymbols: TBooleanField;
    ZDBLookupComboBox1: TPanel;
    DBTextNomeConfig: TDBText;
    procedure ChkReferenceInfoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsProjetosBeforeInsert(DataSet: TDataSet);
    procedure cdsProjetosAfterInsert(DataSet: TDataSet);
    procedure cdsProjetosAfterDelete(DataSet: TDataSet);
    procedure cdsProjetosAfterPost(DataSet: TDataSet);
    procedure BtnConfiguracoesClick(Sender: TObject);
    procedure cdsConfigsAfterInsert(DataSet: TDataSet);
    procedure cdsConfigsAfterPost(DataSet: TDataSet);
    procedure BtnSairClick(Sender: TObject);
    procedure DSConfigsStateChange(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure cdsConfigsAfterScroll(DataSet: TDataSet);
    procedure cdsConfigsReferenceInfoChange(Sender: TField);
    procedure cdsConfigsAfterDelete(DataSet: TDataSet);
    procedure cdsConfigsBeforeInsert(DataSet: TDataSet);
    procedure BtnAplicarClick(Sender: TObject);
  private
    IsLoading: Boolean;
    SeqConfig: Integer;
    procedure PopulaProjetos;
    procedure PersisteProjetos;
    procedure PopulaConfigs;
    procedure PersisteConfigs;
    procedure AplicarConfig(Projeto: string);
  public
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses
  Registry, IniFiles, StrUtils, UConfiguracoes, UNomeConfiguracao;

const
  LogicalToSignal: array[Boolean] of Char = ('-', '+');
  LogicalToInt: array[Boolean] of Byte = (0, 1);

procedure TFrmMain.ChkReferenceInfoClick(Sender: TObject);
begin
  ChkDefinitionsOnly.Enabled := ChkReferenceInfo.Checked;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  PopulaProjetos;
  PopulaConfigs;

  GBCompiler.Enabled := not cdsConfigs.IsEmpty;
  GBLinker.Enabled := GBCompiler.Enabled;
  BtnAplicar.Enabled := GBCompiler.Enabled and not cdsProjetos.IsEmpty;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  cdsConfigs.CreateDataSet;
  cdsConfigs.Open;

  cdsProjetos.CreateDataSet;
  cdsProjetos.Open;
end;

procedure TFrmMain.cdsProjetosBeforeInsert(DataSet: TDataSet);
var
  Ext: string;
begin
  if IsLoading then
    Exit;

  if SelectProject.Execute then
  begin
    Ext := ExtractFileExt(SelectProject.FileName);

    if not (SameText(Ext, '.dpr') or SameText(Ext, '.dpk')) then
      raise Exception.Create('Arquivo inválido');

    if not FileExists(SelectProject.FileName) then
      raise Exception.Create('Projeto não existe');

    cdsProjetos.First;

    while not cdsProjetos.EOF do
    begin
      if SameText(cdsProjetosCaminho.AsString, SelectProject.FileName) then
        raise Exception.Create('Projeto já está selecionado');

      cdsProjetos.Next;
    end;
  end
  else
    Abort;
end;

procedure TFrmMain.cdsProjetosAfterInsert(DataSet: TDataSet);
begin
  if IsLoading then
    Exit;

  cdsProjetosSeq.AsInteger := cdsProjetos.RecordCount + 1;
  cdsProjetosCaminho.AsString := SelectProject.FileName;
  cdsProjetos.Post;
end;

procedure TFrmMain.PopulaProjetos;
var
  Config: TIniFile;
  projetos, i: Integer;
  projeto: string;
begin
  IsLoading := True;
  Config := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

  try
    projetos := Config.ReadInteger('Projetos', 'Projetos', 0);

    for i := 1 to projetos do
    begin
      projeto := Trim(Config.ReadString('Projetos', 'Projeto' + IntToStr(i), ''));

      if projeto = '' then
        continue;

      cdsProjetos.Append;

      try
        cdsProjetosSeq.AsInteger := i;
        cdsProjetosCaminho.AsString := projeto;
        cdsProjetos.Post;
      except
        cdsProjetos.Cancel;
        raise;
      end;
    end;
  finally
    IsLoading := False;
    Config.Free;
    cdsProjetos.First;
  end;
end;

procedure TFrmMain.cdsProjetosAfterDelete(DataSet: TDataSet);
begin
  PersisteProjetos;
  BtnAplicar.Enabled := not cdsProjetos.IsEmpty and not cdsConfigs.IsEmpty;
end;

procedure TFrmMain.PersisteProjetos;
var
  Config: TIniFile;
  bmark: string;
  i: Integer;
begin
  bmark := cdsProjetos.Bookmark;
  Config := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

  try
    Config.EraseSection('Projetos');
    Config.WriteInteger('Projetos', 'Projetos', cdsProjetos.RecordCount);

    i := 1;
    cdsProjetos.First;

    while not cdsProjetos.EOF do
    begin
      Config.WriteString('Projetos', 'Projeto' + IntToStr(i), cdsProjetosCaminho.AsString);
      Inc(i);
      cdsProjetos.Next;
    end;
  finally
    Config.Free;
    cdsProjetos.Bookmark := bmark;
  end;
end;

procedure TFrmMain.cdsProjetosAfterPost(DataSet: TDataSet);
begin
  if IsLoading then
    Exit;

  PersisteProjetos;
  BtnAplicar.Enabled := not cdsProjetos.IsEmpty and not cdsConfigs.IsEmpty;
end;

procedure TFrmMain.PopulaConfigs;
var
  Config: TIniFile;
  configs, i: Integer;
  nome, NomeConfig: string;
begin
  IsLoading := True;
  Config := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

  try
    configs := Config.ReadInteger('Config', 'Configs', 0);

    for i := 1 to configs do
    begin
      NomeConfig := 'Config' + IntToStr(i);
      nome := Trim(Config.ReadString(NomeConfig, 'Nome', ''));

      if nome = '' then
        continue;

      cdsConfigs.Append;

      try
        cdsConfigsSeq.AsInteger := i;
        cdsConfigsNome.AsString := nome;
        cdsConfigsOptimization.AsBoolean := Config.ReadInteger(NomeConfig, 'Optimization', 0) <> 0;
        cdsConfigsStackFrame.AsBoolean := Config.ReadInteger(NomeConfig, 'StackFrame', 0) <> 0;
        cdsConfigsPentiumSafeFDIV.AsBoolean := Config.ReadInteger(NomeConfig, 'PentiumSafeFDIV', 0) <> 0;
        cdsConfigsRecordFieldAlignment.AsInteger := Config.ReadInteger(NomeConfig, 'RecordFieldAlignment', 8);
        cdsConfigsRangeChecking.AsBoolean := Config.ReadInteger(NomeConfig, 'RangeChecking', 0) <> 0;
        cdsConfigsIOChecking.AsBoolean := Config.ReadInteger(NomeConfig, 'IOChecking', 0) <> 0;
        cdsConfigsOverflowChecking.AsBoolean := Config.ReadInteger(NomeConfig, 'OverflowChecking', 0) <> 0;
        cdsConfigsDebugInformation.AsBoolean := Config.ReadInteger(NomeConfig, 'DebugInformation', 0) <> 0;
        cdsConfigsLocalSymbols.AsBoolean := Config.ReadInteger(NomeConfig, 'LocalSymbols', 0) <> 0;
        cdsConfigsReferenceInfo.AsBoolean := Config.ReadInteger(NomeConfig, 'ReferenceInfo', 0) <> 0;
        cdsConfigsDefinitionsOnly.AsBoolean := Config.ReadInteger(NomeConfig, 'DefinitionsOnly', 0) <> 0;
        cdsConfigsAssertions.AsBoolean := Config.ReadInteger(NomeConfig, 'Assertions', 0) <> 0;
        cdsConfigsUseDebugDcus.AsBoolean := Config.ReadInteger(NomeConfig, 'UseDebugDcus', 0) <> 0;
        cdsConfigsMapFile.AsInteger := Config.ReadInteger(NomeConfig, 'MapFile', 0);
        cdsConfigsIncludeTD32DebugInfo.AsBoolean := Config.ReadInteger(NomeConfig, 'IncludeTD32DebugInfo', 0) <> 0;
        cdsConfigsIncludeRemoteDebugSymbols.AsBoolean := Config.ReadInteger(NomeConfig, 'IncludeRemoteDebugSymbols', 0) <> 0;
        cdsConfigs.Post;
      except
        cdsConfigs.Cancel;
        raise;
      end;
    end;
  finally
    IsLoading := False;
    Config.Free;
    cdsConfigs.First;
  end;
end;

procedure TFrmMain.PersisteConfigs;
var
  Config: TIniFile;
  bmark, NomeConfig: string;
  i, old, n: Integer;
begin
  bmark := cdsConfigs.Bookmark;
  Config := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));

  try
    old := Config.ReadInteger('Config', 'Configs', 0);
    Config.WriteInteger('Config', 'Configs', cdsConfigs.RecordCount);

    i := 1;
    cdsConfigs.First;

    while not cdsConfigs.EOF do
    begin
      NomeConfig := 'Config' + IntToStr(i);
      Config.WriteString(NomeConfig, 'Nome', cdsConfigsNome.AsString);
      Config.WriteInteger(NomeConfig, 'Optimization', LogicalToInt[cdsConfigsOptimization.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'StackFrame', LogicalToInt[cdsConfigsStackFrame.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'PentiumSafeFDIV', LogicalToInt[cdsConfigsPentiumSafeFDIV.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'RecordFieldAlignment', cdsConfigsRecordFieldAlignment.AsInteger);
      Config.WriteInteger(NomeConfig, 'RangeChecking', LogicalToInt[cdsConfigsRangeChecking.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'IOChecking', LogicalToInt[cdsConfigsIOChecking.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'OverflowChecking', LogicalToInt[cdsConfigsOverflowChecking.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'DebugInformation', LogicalToInt[cdsConfigsDebugInformation.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'LocalSymbols', LogicalToInt[cdsConfigsLocalSymbols.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'ReferenceInfo', LogicalToInt[cdsConfigsReferenceInfo.AsBoolean]);

      if not cdsConfigsReferenceInfo.AsBoolean then
        Config.WriteInteger(NomeConfig, 'DefinitionsOnly', 0)
      else
        Config.WriteInteger(NomeConfig, 'DefinitionsOnly', LogicalToInt[cdsConfigsDefinitionsOnly.AsBoolean]);

      Config.WriteInteger(NomeConfig, 'Assertions', LogicalToInt[cdsConfigsAssertions.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'UseDebugDcus', LogicalToInt[cdsConfigsUseDebugDcus.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'MapFile', cdsConfigsMapFile.AsInteger);
      Config.WriteInteger(NomeConfig, 'IncludeTD32DebugInfo', LogicalToInt[cdsConfigsIncludeTD32DebugInfo.AsBoolean]);
      Config.WriteInteger(NomeConfig, 'IncludeRemoteDebugSymbols', LogicalToInt[cdsConfigsIncludeRemoteDebugSymbols.AsBoolean]);
      Inc(i);
      cdsConfigs.Next;
    end;

    for n := i to old do
      Config.EraseSection('Config' + IntToStr(n));
  finally
    Config.Free;
    cdsConfigs.Bookmark := bmark;
  end;
end;

procedure TFrmMain.BtnConfiguracoesClick(Sender: TObject);
begin
  FrmConfiguracoes.ShowModal;
end;

procedure TFrmMain.cdsConfigsAfterInsert(DataSet: TDataSet);
begin
  if IsLoading then
    Exit;

  if cdsConfigs.State = dsInsert then
  begin
    cdsConfigsSeq.AsInteger := SeqConfig;
    cdsConfigsOptimization.AsBoolean := False;
    cdsConfigsStackFrame.AsBoolean := False;
    cdsConfigsPentiumSafeFDIV.AsBoolean := False;
    cdsConfigsRecordFieldAlignment.AsInteger := 8;
    cdsConfigsRangeChecking.AsBoolean := False;
    cdsConfigsIOChecking.AsBoolean := False;
    cdsConfigsOverflowChecking.AsBoolean := False;
    cdsConfigsDebugInformation.AsBoolean := False;
    cdsConfigsLocalSymbols.AsBoolean := False;
    cdsConfigsReferenceInfo.AsBoolean := False;
    cdsConfigsDefinitionsOnly.AsBoolean := False;
    cdsConfigsAssertions.AsBoolean := False;
    cdsConfigsUseDebugDcus.AsBoolean := False;
    cdsConfigsMapFile.AsInteger := 0;
    cdsConfigsIncludeTD32DebugInfo.AsBoolean := False;
    cdsConfigsIncludeRemoteDebugSymbols.AsBoolean := False;
  end;

  FrmNomeConfiguracao.DBEdit1.Text := cdsConfigsNome.AsString;

  if FrmNomeConfiguracao.ShowModal = mrOk then
  begin
    cdsConfigsNome.AsString := FrmNomeConfiguracao.DBEdit1.Text;
    cdsConfigs.Post;
  end
  else
    cdsConfigs.Cancel;
end;

procedure TFrmMain.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.cdsConfigsAfterPost(DataSet: TDataSet);
begin
  if IsLoading then
    Exit;

  PersisteConfigs;
  BtnAplicar.Enabled := not cdsProjetos.IsEmpty and not cdsConfigs.IsEmpty;
end;

procedure TFrmMain.DSConfigsStateChange(Sender: TObject);
begin
  if IsLoading then
    Exit;

  BtnGravar.Visible := cdsConfigs.State in dsEditModes;
  BtnCancelar.Visible := BtnGravar.Visible;

  BtnConfiguracoes.Enabled := not BtnGravar.Visible;
  BtnSair.Enabled := BtnConfiguracoes.Enabled;
  DBNavigator2.Enabled := BtnConfiguracoes.Enabled;
  DBNavigator1.Enabled := BtnConfiguracoes.Enabled;
  BtnAplicar.Enabled := BtnConfiguracoes.Enabled and not cdsProjetos.IsEmpty and not cdsConfigs.IsEmpty;
end;

procedure TFrmMain.BtnGravarClick(Sender: TObject);
begin
  if cdsConfigs.State in dsEditModes then
  begin
    if not ChkReferenceInfo.Checked then
      ChkDefinitionsOnly.Checked := False;

    cdsConfigs.Post;
  end;
end;

procedure TFrmMain.BtnCancelarClick(Sender: TObject);
begin
  if cdsConfigs.State in dsEditModes then
    cdsConfigs.Cancel;
end;

procedure TFrmMain.cdsConfigsAfterScroll(DataSet: TDataSet);
begin
  ChkDefinitionsOnly.Enabled := cdsConfigsReferenceInfo.AsBoolean;
end;

procedure TFrmMain.cdsConfigsReferenceInfoChange(Sender: TField);
begin
  if not Sender.AsBoolean then
    cdsConfigsDefinitionsOnly.AsBoolean := False;
end;

procedure TFrmMain.cdsConfigsAfterDelete(DataSet: TDataSet);
begin
  PersisteConfigs;
  BtnAplicar.Enabled := not cdsProjetos.IsEmpty and not cdsConfigs.IsEmpty;
end;

procedure TFrmMain.cdsConfigsBeforeInsert(DataSet: TDataSet);
begin
  if IsLoading then
    Exit;

  cdsConfigs.Last;
  SeqConfig := cdsConfigsSeq.AsInteger + 1;
end;

procedure TFrmMain.AplicarConfig(Projeto: string);
var
  dof: TIniFile;
  Reg: TRegistry;
  FileName, DelphiDebugLibPath, Curr: string;
  CfgOld, CfgNew: TStringList;
  Found: Boolean;

  function SearchInOld(Key: string; Full: Boolean = False): string;
  var
    i: Integer;
  begin
    Result := '';

    for i := 0 to CfgOld.Count - 1 do
      if (Full and (CfgOld[i] = Key)) or (not Full and (LeftStr(CfgOld[i], Length(Key)) = Key)) then
      begin
        Result := CfgOld[i];
        CfgOld.Delete(i);
        Exit;
      end;
  end;

  procedure ReuseKey(Search: string; Full: Boolean = False);
  var
    Result: string;
  begin
    Result := SearchInOld(Search, Full);

    if Result <> '' then
      CfgNew.Add(Result);
  end;

  procedure WriteKey(Search: string; Value: Integer); overload;
  begin
    SearchInOld(Search);
    CfgNew.Add(Search + IntToStr(Value));
  end;

  procedure WriteKey(Search: string; Value: Boolean); overload;
  begin
    SearchInOld(Search);
    CfgNew.Add(Search + LogicalToSignal[Value]);
  end;

begin
  dof := TIniFile.Create(ChangeFileExt(Projeto, '.dof'));

  try
    dof.WriteInteger('Compiler', 'O', LogicalToInt[cdsConfigsOptimization.AsBoolean]);
    dof.WriteInteger('Compiler', 'W', LogicalToInt[cdsConfigsStackFrame.AsBoolean]);
    dof.WriteInteger('Compiler', 'U', LogicalToInt[cdsConfigsPentiumSafeFDIV.AsBoolean]);
    dof.WriteInteger('Compiler', 'A', cdsConfigsRecordFieldAlignment.AsInteger);
    dof.WriteInteger('Compiler', 'R', LogicalToInt[cdsConfigsRangeChecking.AsBoolean]);
    dof.WriteInteger('Compiler', 'I', LogicalToInt[cdsConfigsIOChecking.AsBoolean]);
    dof.WriteInteger('Compiler', 'Q', LogicalToInt[cdsConfigsOverflowChecking.AsBoolean]);
    dof.WriteInteger('Compiler', 'D', LogicalToInt[cdsConfigsDebugInformation.AsBoolean]);
    dof.WriteInteger('Compiler', 'L', LogicalToInt[cdsConfigsLocalSymbols.AsBoolean]);

    if not cdsConfigsReferenceInfo.AsBoolean then
      dof.WriteInteger('Compiler', 'Y', 0)
    else
    begin
      if cdsConfigsDefinitionsOnly.AsBoolean then
        dof.WriteInteger('Compiler', 'Y', 1)
      else
        dof.WriteInteger('Compiler', 'Y', 2);
    end;

    dof.WriteInteger('Compiler', 'C', LogicalToInt[cdsConfigsAssertions.AsBoolean]);

    if not cdsConfigsUseDebugDcus.AsBoolean then
      dof.WriteString('Directories', 'SearchPath', '')
    else
      dof.WriteString('Directories', 'SearchPath', '$(DELPHI)\Lib\Debug');

    dof.WriteInteger('Linker', 'MapFile', cdsConfigsMapFile.AsInteger);
    dof.WriteInteger('Linker', 'DebugInfo', LogicalToInt[cdsConfigsIncludeTD32DebugInfo.AsBoolean]);
    dof.WriteInteger('Linker', 'RemoteSymbols', LogicalToInt[cdsConfigsIncludeRemoteDebugSymbols.AsBoolean]);
  finally
    dof.Free;
  end;

  if cdsConfigsUseDebugDcus.AsBoolean then
  begin
    Reg := TRegistry.Create;

    try
      Reg.RootKey := HKEY_CURRENT_USER;
      Reg.OpenKey('\SOFTWARE\Borland\Delphi\7.0', False);

      try
        DelphiDebugLibPath := Reg.ReadString('RootDir');
      finally
        Reg.CloseKey;
      end;
    finally
      Reg.Free;
    end;
  end
  else
    DelphiDebugLibPath := '';

  DelphiDebugLibPath := IncludeTrailingBackslash(DelphiDebugLibPath) + 'Lib\Debug';
  FileName := ChangeFileExt(Projeto, '.cfg');
  Found := False;

  CfgOld := TStringList.Create;

  try
    CfgOld.LoadFromFile(FileName);
    CfgNew := TStringList.Create;

    try
      WriteKey('-$A', cdsConfigsRecordFieldAlignment.AsInteger);
      ReuseKey(('-$B'));
      WriteKey('-$C', cdsConfigsAssertions.AsBoolean);
      WriteKey('-$D', cdsConfigsDebugInformation.AsBoolean);
      ReuseKey(('-$E'));
      ReuseKey(('-$F'));
      ReuseKey(('-$G'));
      ReuseKey(('-$H'));
      WriteKey('-$I', cdsConfigsIOChecking.AsBoolean);
      ReuseKey(('-$J'));
      ReuseKey(('-$K'));
      WriteKey('-$L', cdsConfigsLocalSymbols.AsBoolean);
      ReuseKey(('-$M'));
      ReuseKey(('-$N'));
      WriteKey('-$O', cdsConfigsOptimization.AsBoolean);
      ReuseKey(('-$P'));
      WriteKey('-$Q', cdsConfigsOverflowChecking.AsBoolean);
      WriteKey('-$R', cdsConfigsRangeChecking.AsBoolean);
      ReuseKey(('-$S'));
      ReuseKey(('-$T'));
      WriteKey('-$U', cdsConfigsPentiumSafeFDIV.AsBoolean);
      ReuseKey(('-$V'));
      WriteKey('-$W', cdsConfigsStackFrame.AsBoolean);
      ReuseKey(('-$X'));

      SearchInOld('-$Y');

      if not cdsConfigsReferenceInfo.AsBoolean then
        CfgNew.Add('-$Y0')
      else if not cdsConfigsDefinitionsOnly.AsBoolean then
        CfgNew.Add('-$Y+')
      else
        CfgNew.Add('-$YD');

      ReuseKey(('-$Z'));

      SearchInOld('-GS', True);
      SearchInOld('-GP', True);
      SearchInOld('-GD', True);

      case cdsConfigsMapFile.AsInteger of
        1:
          CfgNew.Add('-GS');
        2:
          CfgNew.Add('-GP');
        3:
          CfgNew.Add('-GD');
      end;

      ReuseKey('-cg', True);

      SearchInOld('-vn', True);
      SearchInOld('-vr', True);

      if cdsConfigsIncludeTD32DebugInfo.AsBoolean then
        CfgNew.Add('-vn');

      if cdsConfigsIncludeRemoteDebugSymbols.AsBoolean then
        CfgNew.Add('-vr');

      SearchInOld('-U"');
      SearchInOld('-O"');
      SearchInOld('-I"');
      SearchInOld('-R"');

      while CfgOld.Count > 0 do
      begin
        Curr := CfgOld[0];
        ReuseKey(Curr, True);

        if cdsConfigsUseDebugDcus.AsBoolean and (LeftStr(Curr, 3) = '-LN') then
        begin
          Found := True;
          CfgNew.Add('-U"' + DelphiDebugLibPath + '"');
          CfgNew.Add('-O"' + DelphiDebugLibPath + '"');
          CfgNew.Add('-I"' + DelphiDebugLibPath + '"');
          CfgNew.Add('-R"' + DelphiDebugLibPath + '"');
        end;
      end;

      if cdsConfigsUseDebugDcus.AsBoolean and not Found then
      begin
        CfgNew.Add('-U"' + DelphiDebugLibPath + '"');
        CfgNew.Add('-O"' + DelphiDebugLibPath + '"');
        CfgNew.Add('-I"' + DelphiDebugLibPath + '"');
        CfgNew.Add('-R"' + DelphiDebugLibPath + '"');
      end;
    finally
      CfgNew.SaveToFile(FileName);
      CfgNew.Free;
    end;
  finally
    CfgOld.Free;
  end;
end;

procedure TFrmMain.BtnAplicarClick(Sender: TObject);
var
  Seq: Integer;
begin
  Seq := cdsProjetosSeq.AsInteger;
  cdsProjetos.DisableControls;
  Cursor := crHourGlass;

  try
    Enabled := False;
    cdsProjetos.First;

    while not cdsProjetos.EOF do
    begin
      AplicarConfig(cdsProjetosCaminho.AsString);
      cdsProjetos.Next;
    end;
  finally
    Enabled := True;
    Cursor := crDefault;
    cdsProjetos.EnableControls;
    cdsProjetos.Locate('Seq', Seq, []);
  end;
end;

end.

