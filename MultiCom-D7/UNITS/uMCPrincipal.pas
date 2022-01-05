unit uMCPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Menus, IniFiles, uFormPadrao, CPort, CPortCtl,
  CPortTypes, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdTelnet;

type
  TFMCPrincipal = class(TFormPadrao)
    ComTerminal: TComTerminal;
    IdTelnet: TIdTelnet;
    btnConectar: TSpeedButton;
    btnDesconectar: TSpeedButton;
    edtHost: TComboBox;
    lblHost: TLabel;
    MainMenu: TMainMenu;
    mnSair: TMenuItem;
    mnConfigurar: TMenuItem;
    ComPort: TComPort;
    smnTerminal: TMenuItem;
    smnConexoes: TMenuItem;
    smnFonte: TMenuItem;
    smnParametros: TMenuItem;
    lblLocalEcho: TLabel;
    ComLedConn: TComLed;
    ComLedCTS: TComLed;
    ComLedDSR: TComLed;
    ComLedRing: TComLed;
    ComLedRLSD: TComLed;
    ComLedRX: TComLed;
    ComLedTX: TComLed;
    ComLabelConn: TLabel;
    ComLabelCTS: TLabel;
    ComLabelDSR: TLabel;
    ComLabelRing: TLabel;
    ComLabelRLSD: TLabel;
    ComLabelRX: TLabel;
    ComLabelTX: TLabel;
    lblCR_LF: TLabel;
    lblTec: TLabel;
    chkLogar: TCheckBox;
    procedure IdTelnetDataAvailable(Sender: TIdTelnet; const Buffer: string);
    procedure btnConectarClick(Sender: TObject);
    procedure IdTelnetDisconnected(Sender: TObject);
    procedure IdTelnetConnected(Sender: TObject);
    procedure ComTerminalKeyPress(Sender: TObject; var Key: Char);
    procedure btnDesconectarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComTerminalResize(Sender: TObject);
    procedure mnSairClick(Sender: TObject);
    procedure edtHostExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ComPortAfterClose(Sender: TObject);
    procedure ComPortAfterOpen(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure smnConexoesClick(Sender: TObject);
    procedure smnFonteClick(Sender: TObject);
    procedure smnParametrosClick(Sender: TObject);
    procedure ComPortRxBuf(Sender: TObject; const Buffer: PAnsiChar; Count: Integer);
    procedure chkLogarClick(Sender: TObject);
    procedure ComLedConnChange(Sender: TObject; AState: TLedState);
    procedure ComLedCTSChange(Sender: TObject; AState: TLedState);
    procedure ComLedRXChange(Sender: TObject; AState: TLedState);
    procedure ComLedTXChange(Sender: TObject; AState: TLedState);
  private
    FInit: TDateTime;
    FCanLog: Boolean;
    procedure LeParametros;
    procedure HabilitaTCPIP;
    procedure HabilitaSerial;
    procedure Inicializa;
    procedure Limpa;
  public
    procedure AtualizaServidores;
  end;

var
  FMCPrincipal: TFMCPrincipal;

implementation

uses
  uMCDefs, uMCConexoes, uMCConfTerminal;

{$R *.dfm}

procedure TFMCPrincipal.IdTelnetConnected(Sender: TObject);
begin
  HabilitaTCPIP;

  if chkLogar.Checked then
  begin
    FInit := Now();
    AssignFile(FStream, FormatDateTime('yyyy-mm-dd_hh"h"n"m"ss"s"', FInit) + '-' + IdTelnet.Host + '.txt');
    Rewrite(FStream);

    AssignFile(FLog, FormatDateTime('yyyy-mm-dd_hh"h"n"m"ss"s"', FInit) + '-' + IdTelnet.Host + '.time');
    Rewrite(FLog);
    FCanLog := True;
    FInit := -1;
  end;

  Inicializa;
end;

procedure TFMCPrincipal.IdTelnetDataAvailable(Sender: TIdTelnet; const Buffer: string);
begin
  ComTerminal.WriteStr(Buffer);

  if FCanLog then
  begin
    Write(FStream, Buffer);

    if FInit = -1 then
      FInit := Now();

    WriteLn(FLog, FormatDateTime('hh:nn:ss.zzz', Now() - FInit));
  end;
end;

procedure TFMCPrincipal.IdTelnetDisconnected(Sender: TObject);
begin
  Limpa;
  HabilitaTCPIP;

  if chkLogar.Checked then
  begin
    CloseFile(FStream);
    CloseFile(FLog);
    FCanLog := False;
  end;
end;

procedure TFMCPrincipal.ComPortAfterOpen(Sender: TObject);
begin
  HabilitaSerial;

  if chkLogar.Checked then
  begin
    FInit := Now();
    AssignFile(FStream, FormatDateTime('yyyy-mm-dd_hh"h"n"m"ss"s"', FInit) + '-' + IdTelnet.Host + '.txt');
    Rewrite(FStream);

    AssignFile(FLog, FormatDateTime('yyyy-mm-dd_hh"h"n"m"ss"s"', FInit) + '-' + IdTelnet.Host + '.time');
    Rewrite(FLog);
    FCanLog := True;
    FInit := -1;
  end;

  Inicializa;
end;

procedure TFMCPrincipal.ComPortRxBuf(Sender: TObject; const Buffer: PAnsiChar; Count: Integer);
begin
  if FCanLog then
  begin
    Write(FStream, Buffer);

    if FInit = -1 then
      FInit := Now();

    WriteLn(FLog, FormatDateTime('hh:nn:ss.z', Now() - FInit));
  end;
end;

procedure TFMCPrincipal.ComPortAfterClose(Sender: TObject);
begin
  Limpa;
  HabilitaSerial;

  if chkLogar.Checked then
  begin
    CloseFile(FStream);
    CloseFile(FLog);
    FCanLog := False;
  end;
end;

procedure TFMCPrincipal.btnConectarClick(Sender: TObject);
var
  i: Integer;
begin
  i := edtHost.ItemIndex;

  if i < 0 then
    Exit;

  ComTerminal.LocalEcho := FComsLocalEcho[i];

  ComTerminal.Font.Name := FFontsName[i];
  ComTerminal.Font.Size := FFontsSize[i];
  ComTerminal.Font.Color := FFontsColor[i];
  ComTerminal.Font.Style := [];

  if FFontsStyleBold[i] then
    ComTerminal.Font.Style := ComTerminal.Font.Style + [fsItalic];

  if FFontsStyleItalic[i] then
    ComTerminal.Font.Style := ComTerminal.Font.Style + [fsItalic];

  if FFontsStyleUnderline[i] then
    ComTerminal.Font.Style := ComTerminal.Font.Style + [fsUnderline];

  if FFontsStyleStrikeOut[i] then
    ComTerminal.Font.Style := ComTerminal.Font.Style + [fsStrikeOut];

  if FTypes[i] = 0 then
  begin
    IdTelnet.Host := FHosts[i];
    IdTelnet.Port := FPorts[i];
    IdTelnet.Connect;
  end
  else if FTypes[i] = 2 then
  begin
    ComPort.Port := ToPort(FPorts[i]);
    ComPort.Connected := True;
  end;
end;

procedure TFMCPrincipal.ComTerminalKeyPress(Sender: TObject; var Key: Char);
begin
  if FTypes[edtHost.ItemIndex] = 0 then
  begin
    if (Key <> #13) or ((Key = #13) and FCR_LF[edtHost.ItemIndex]) then
      IdTelnet.Write(Key)
    else
      IdTelnet.Write(#10);

    if ComTerminal.LocalEcho then
      ComTerminal.WriteStr(Key);
  end;

  lblTec.Caption := IntToStr(Ord(Key));
end;

procedure TFMCPrincipal.btnDesconectarClick(Sender: TObject);
begin
  if IdTelnet.Connected then
    IdTelnet.Disconnect
  else if ComPort.Connected then
    ComPort.Connected := False;
end;

procedure TFMCPrincipal.HabilitaTCPIP;
begin
  lblLocalEcho.Visible := False;
  lblCR_LF.Visible := False;
  btnConectar.Enabled := not IdTelnet.Connected;
  btnDesconectar.Enabled := IdTelnet.Connected;
  lblHost.Enabled := btnConectar.Enabled;
  edtHost.Enabled := btnConectar.Enabled;
  mnConfigurar.Enabled := btnConectar.Enabled;
  chkLogar.Enabled := btnConectar.Enabled;

  Caption := 'Terminal - ';

  if btnConectar.Enabled then
    Caption := Caption + 'desconectado'
  else
    Caption := Caption + 'conectado em ' + Trim(edtHost.Text) + ' : ' + IntToStr(FPorts[edtHost.ItemIndex]);

  if IdTelnet.Connected then
  begin
    ComLedConn.ComPort := nil;
    ComLedConn.State := lsOn;
  end
  else
  begin
    //ComLedConn.State := lsOff;
    ComLedConn.ComPort := ComPort;
  end;

  ComLedConn.Visible := IdTelnet.Connected;
  ComLabelConn.Visible := ComLedConn.Visible;

  Invalidate;
end;

procedure TFMCPrincipal.FormCreate(Sender: TObject);
begin
  lblTec.Caption := '';

  ComLabelConn.SendToBack;
  ComLabelConn.AutoSize := True;
  ComLabelConn.AutoSize := False;
  ComLabelConn.Width := ComLedConn.Width + ComLabelConn.Width;
  ComLabelConn.Height := ComLedConn.Height;
  ComLabelConn.Left := ComLedConn.Left;

  ComLedCTS.Left := ComLabelConn.Left + ComLabelConn.Width + 3;
  ComLabelCTS.SendToBack;
  ComLabelCTS.AutoSize := True;
  ComLabelCTS.AutoSize := False;
  ComLabelCTS.Width := ComLedCTS.Width + ComLabelCTS.Width;
  ComLabelCTS.Height := ComLedCTS.Height;
  ComLabelCTS.Left := ComLedCTS.Left;

  ComLedDSR.Left := ComLabelCTS.Left + ComLabelCTS.Width + 3;
  ComLabelDSR.SendToBack;
  ComLabelDSR.AutoSize := True;
  ComLabelDSR.AutoSize := False;
  ComLabelDSR.Width := ComLedDSR.Width + ComLabelDSR.Width;
  ComLabelDSR.Height := ComLedDSR.Height;
  ComLabelDSR.Left := ComLedDSR.Left;

  ComLedRing.Left := ComLabelDSR.Left + ComLabelDSR.Width + 3;
  ComLabelRing.SendToBack;
  ComLabelRing.AutoSize := True;
  ComLabelRing.AutoSize := False;
  ComLabelRing.Width := ComLedRing.Width + ComLabelRing.Width;
  ComLabelRing.Height := ComLedRing.Height;
  ComLabelRing.Left := ComLedRing.Left;

  ComLedRLSD.Left := ComLabelRing.Left + ComLabelRing.Width + 3;
  ComLabelRLSD.SendToBack;
  ComLabelRLSD.AutoSize := True;
  ComLabelRLSD.AutoSize := False;
  ComLabelRLSD.Width := ComLedRLSD.Width + ComLabelRLSD.Width;
  ComLabelRLSD.Height := ComLedRLSD.Height;
  ComLabelRLSD.Left := ComLedRLSD.Left;

  ComLedRX.Left := ComLabelRLSD.Left + ComLabelRLSD.Width + 3;
  ComLabelRX.SendToBack;
  ComLabelRX.AutoSize := True;
  ComLabelRX.AutoSize := False;
  ComLabelRX.Width := ComLedRX.Width + ComLabelRX.Width;
  ComLabelRX.Height := ComLedRX.Height;
  ComLabelRX.Left := ComLedRX.Left;

  ComLedTX.Left := ComLabelRX.Left + ComLabelRX.Width + 3;
  ComLabelTX.SendToBack;
  ComLabelTX.AutoSize := True;
  ComLabelTX.AutoSize := False;
  ComLabelTX.Width := ComLedTX.Width + ComLabelTX.Width;
  ComLabelTX.Height := ComLedTX.Height;
  ComLabelTX.Left := ComLedTX.Left;

  FCaret := Integer(tcBlock);
  FLocalEcho := False;
  FPath := ExtractFilePath(Application.ExeName);
  LeParametros;
  AtualizaServidores;
  Limpa;
  HabilitaTCPIP;
end;

procedure TFMCPrincipal.ComTerminalResize(Sender: TObject);
begin
  ClientWidth := ComTerminal.Width + ComTerminal.Left;
  ClientHeight := ComTerminal.Top + ComTerminal.Height + 36 + lblLocalEcho.Height;
end;

procedure TFMCPrincipal.mnSairClick(Sender: TObject);
begin
  if btnDesconectar.Enabled then
    btnDesconectar.Click;

  Application.Terminate;
end;

procedure TFMCPrincipal.edtHostExit(Sender: TObject);
begin
  TEdit(Sender).Text := Trim(TEdit(Sender).Text);
end;

procedure TFMCPrincipal.Limpa;
begin
  if ComTerminal <> nil then
  begin
    ComTerminal.Caret := tcNone;
    ComTerminal.ClearScreen;
    ComTerminal.WriteStr('Desconectado.');
  end;

  lblLocalEcho.Visible := False;
  lblCR_LF.Visible := False;
end;

procedure TFMCPrincipal.FormDestroy(Sender: TObject);
begin
  with TIniFile.Create(FPath + 'MultiCom.ini') do
  try
    WriteInteger('Connections', 'Current', edtHost.ItemIndex + 1);
    UpdateFile;
  finally
    Free;
  end;
end;

procedure TFMCPrincipal.HabilitaSerial;
begin
  btnConectar.Enabled := not ComPort.Connected;
  btnDesconectar.Enabled := ComPort.Connected;
  lblHost.Enabled := btnConectar.Enabled;
  edtHost.Enabled := btnConectar.Enabled;
  mnConfigurar.Enabled := btnConectar.Enabled;
  chkLogar.Enabled := btnConectar.Enabled;

  Caption := 'Terminal - ';

  if btnConectar.Enabled then
    Caption := Caption + 'desconectado'
  else
    Caption := Caption + 'conectado em ' + Trim(edtHost.Text);

  ComLedConn.Visible := ComPort.Connected;
  ComLabelConn.Visible := ComLedConn.Visible;
  ComLedCTS.Visible := ComLedConn.Visible;
  ComLabelCTS.Visible := ComLedCTS.Visible;
  ComLedDSR.Visible := ComLedConn.Visible;
  ComLabelDSR.Visible := ComLedDSR.Visible;
  ComLedRing.Visible := ComLedConn.Visible;
  ComLabelRing.Visible := ComLedRing.Visible;
  ComLedRLSD.Visible := ComLedConn.Visible;
  ComLabelRLSD.Visible := ComLedRLSD.Visible;
  ComLedRX.Visible := ComLedConn.Visible;
  ComLabelRX.Visible := ComLedRX.Visible;
  ComLedTX.Visible := ComLedConn.Visible;
  ComLabelTX.Visible := ComLedTX.Visible;

  Invalidate;
end;

procedure TFMCPrincipal.Inicializa;
begin
  ComTerminal.ClearScreen;
  
  if FCursor[edtHost.ItemIndex] then
    ComTerminal.Caret := TTermCaret(FCaret)
  else
    ComTerminal.Caret := tcNone;

  ComTerminal.SetFocus;

  lblLocalEcho.Visible := True;

  if FCR_LF[edtHost.ItemIndex] then
  begin
    lblCR_LF.Caption := ' CR ';
    lblCR_LF.Color := clGreen;
  end
  else
  begin
    lblCR_LF.Caption := ' LF ';
    lblCR_LF.Color := clBlue;
  end;

  lblCR_LF.Visible := True;

  if ComTerminal.LocalEcho then
    lblLocalEcho.Color := clRed
  else
    lblLocalEcho.Color := clSilver;
end;

procedure TFMCPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if btnDesconectar.Enabled then
    btnDesconectar.Click;
end;

procedure TFMCPrincipal.smnConexoesClick(Sender: TObject);
begin
  if FMCConexoes.ShowModal = mrOk then
    AtualizaServidores;
end;

procedure TFMCPrincipal.AtualizaServidores;
var
  i: Integer;
  s: string;
begin
  edtHost.Clear;

  with TIniFile.Create(FPath + 'MultiCom.ini') do
  try
    FNumConnections := ReadInteger('Connections', 'Connections', 0);

    SetLength(FNames, FNumConnections);
    SetLength(FTypes, FNumConnections);
    SetLength(FHosts, FNumConnections);
    SetLength(FPorts, FNumConnections);
    SetLength(FCR_LF, FNumConnections);
    SetLength(FCursor, FNumConnections);
    SetLength(FComsPort, FNumConnections);
    SetLength(FComsBaudRate, FNumConnections);
    SetLength(FComsDataBits, FNumConnections);
    SetLength(FComsStopBits, FNumConnections);
    SetLength(FComsParityBits, FNumConnections);
    SetLength(FComsFlowControl, FNumConnections);
    SetLength(FComsLocalEcho, FNumConnections);
    SetLength(FFontsName, FNumConnections);
    SetLength(FFontsSize, FNumConnections);
    SetLength(FFontsColor, FNumConnections);
    SetLength(FFontsStyleBold, FNumConnections);
    SetLength(FFontsStyleItalic, FNumConnections);
    SetLength(FFontsStyleUnderline, FNumConnections);
    SetLength(FFontsStyleStrikeOut, FNumConnections);

    if FNumConnections > 0 then
    begin
      for i := 0 to FNumConnections - 1 do
      begin
        FNames[i] := ReadString('Connections', IntToStr(i + 1), '');
        FTypes[i] := ReadInteger(FNames[i], 'Type', 1);
        FPorts[i] := ReadInteger(FNames[i], 'Port', 0);
        FCR_LF[i] := ReadBool(FNames[i], 'CR', True);
        FCursor[i] := ReadBool(FNames[i], 'Cursor', True);

        if FTypes[i] = 0 then
          FHosts[i] := ReadString(FNames[i], 'Host', '')
        else if FTypes[i] = 2 then
        begin
          FComsBaudRate[i] := TBaudRate(ReadInteger(FNames[i], 'BaudRate', 0));
          FComsDataBits[i] := TDataBits(ReadInteger(FNames[i], 'DataBits', 0));
          FComsStopBits[i] := TStopBits(ReadInteger(FNames[i], 'StopBits', 0));
          FComsParityBits[i] := TParityBits(ReadInteger(FNames[i], 'ParityBits', 0));
          FComsFlowControl[i] := TFlowControl(ReadInteger(FNames[i], 'FlowControl', 0));
        end;

        FComsLocalEcho[i] := ReadBool(FNames[i], 'LocalEcho', False);

        FFontsName[i] := ReadString(FNames[i], 'FontName', FFontName);
        FFontsSize[i] := ReadInteger(FNames[i], 'FontSize', FFontSize);
        FFontsColor[i] := TColor(ReadInteger(FNames[i], 'FontColor', Integer(FFontColor)));
        FFontsStyleBold[i] := ReadBool(FNames[i], 'FontStyleBold', FFontStyleBold);
        FFontsStyleItalic[i] := ReadBool(FNames[i], 'FontStyleItalic', FFontStyleItalic);
        FFontsStyleUnderline[i] := ReadBool(FNames[i], 'FontStyleUnderline', FFontStyleUnderline);
        FFontsStyleStrikeOut[i] := ReadBool(FNames[i], 'FontStyleStrikeOut', FFontStyleStrikeOut);

        s := FNames[i];

        if FHosts[i] <> '' then
          s := s + ' (' + FHosts[i];

        if FTypes[i] = 0 then
          s := s + ':' + IntToStr(FPorts[i])
        else if FTypes[i] = 0 then
          s := s + ToPort(FPorts[i]);

        if FHosts[i] <> '' then
          s := s + ')';

        edtHost.Items.Add(s);
      end;

      edtHost.ItemIndex := ReadInteger('Connections', 'Current', 1) - 1;
    end;
  finally
    Free;
  end;
end;

procedure TFMCPrincipal.smnFonteClick(Sender: TObject);
begin
  FMCConfTerminal.ConfigFont;
  LeParametros;
end;

procedure TFMCPrincipal.smnParametrosClick(Sender: TObject);
begin
  FMCConfTerminal.ConfigTerminal;
end;

procedure TFMCPrincipal.LeParametros;
begin
  with TIniFile.Create(FPath + 'MultiCom.ini') do
  try
    ComTerminal.Rows := ReadInteger('Terminal', 'Rows', 24);
    ComTerminal.Columns := ReadInteger('Terminal', 'Columns', 80);
    FLocalEcho := ReadBool('Terminal', 'LocalEcho', False);
    FSendLF := ReadBool('Terminal', 'SendLF', False);
    FSendWrapLines := ReadBool('Terminal', 'WrapLines', False);
    FForce7Bit := ReadBool('Terminal', 'Force7Bit', False);
    FAppendLF := ReadBool('Terminal', 'AppendLF', False);
    FCaret := ReadInteger('Terminal', 'Caret', Integer(tcBlock));
    FEmulation := ReadInteger('Terminal', 'Emulation', Integer(teVT100orANSI));
    FArrowKeys := ReadInteger('Terminal', 'ArrowKeys', Integer(akTerminal));

    FFontName := ReadString('Terminal', 'FontName', ComTerminalFont.Name);
    FFontSize := ReadInteger('Terminal', 'FontSize', ComTerminalFont.Size);
    FFontColor := TColor(ReadInteger('Terminal', 'FontColor', Integer(ComTerminalFont.Color)));

    FFontStyleBold := ReadBool('Terminal', 'FontStyleBold', fsBold in ComTerminalFont.Style);
    FFontStyleItalic := ReadBool('Terminal', 'FontStyleItalic', fsItalic in ComTerminalFont.Style);
    FFontStyleUnderline := ReadBool('Terminal', 'FontStyleUnderline', fsUnderline in ComTerminalFont.Style);
    FFontStyleStrikeOut := ReadBool('Terminal', 'FontStyleStrikeOut', fsStrikeOut in ComTerminalFont.Style);

    ComTerminal.Font.Name := FFontName;
    ComTerminal.Font.Size := FFontSize;
    ComTerminal.Font.Color := FFontColor;
    ComTerminal.Font.Style := [];

    if FFontStyleBold then
      ComTerminal.Font.Style := ComTerminal.Font.Style + [fsItalic];
    if FFontStyleItalic then
      ComTerminal.Font.Style := ComTerminal.Font.Style + [fsItalic];
    if FFontStyleUnderline then
      ComTerminal.Font.Style := ComTerminal.Font.Style + [fsUnderline];
    if FFontStyleStrikeOut then
      ComTerminal.Font.Style := ComTerminal.Font.Style + [fsStrikeOut];

    FComPort := ReadInteger('ComDefs', 'Port', 0);
    FComBaudRate := TBaudRate(ReadInteger('ComDefs', 'BaudRate', 0));
    FComDataBits := TDataBits(ReadInteger('ComDefs', 'DataBits', 0));
    FComStopBits := TStopBits(ReadInteger('ComDefs', 'StopBits', 0));
    FComParity := TParityBits(ReadInteger('ComDefs', 'ParityBits', 0));
    FComFlowControl := TFlowControl(ReadInteger('ComDefs', 'FlowControl', 0));

    chkLogar.OnClick := nil;

    try
      chkLogar.Checked := ReadBool('General', 'Log', False);
    finally
      chkLogar.OnClick := chkLogarClick;
    end;
  finally
    Free;
  end;
end;

procedure TFMCPrincipal.chkLogarClick(Sender: TObject);
begin
  with TIniFile.Create(FPath + 'MultiCom.ini') do
  try
    WriteBool('General', 'Log', chkLogar.Checked);
  finally
    UpdateFile;
    Free;
  end;
end;

procedure TFMCPrincipal.ComLedConnChange(Sender: TObject; AState: TLedState);
begin
  inherited;

  if AState = lsOn then
    ComLabelConn.Font.Style := ComLabelConn.Font.Style + [fsItalic]
  else
    ComLabelConn.Font.Style := ComLabelConn.Font.Style - [fsItalic];
end;

procedure TFMCPrincipal.ComLedCTSChange(Sender: TObject; AState: TLedState);
begin
  inherited;

  if AState = lsOn then
    ComLabelCTS.Font.Style := ComLabelCTS.Font.Style + [fsItalic]
  else
    ComLabelCTS.Font.Style := ComLabelCTS.Font.Style - [fsItalic];
end;

procedure TFMCPrincipal.ComLedRXChange(Sender: TObject; AState: TLedState);
begin
  inherited;

  if AState = lsOn then
    ComLabelRX.Font.Style := ComLabelRX.Font.Style + [fsItalic]
  else
    ComLabelRX.Font.Style := ComLabelRX.Font.Style - [fsItalic];
end;

procedure TFMCPrincipal.ComLedTXChange(Sender: TObject; AState: TLedState);
begin
  inherited;

  if AState = lsOn then
    ComLabelTX.Font.Style := ComLabelTX.Font.Style + [fsItalic]
  else
    ComLabelTX.Font.Style := ComLabelTX.Font.Style - [fsItalic];
end;

end.

