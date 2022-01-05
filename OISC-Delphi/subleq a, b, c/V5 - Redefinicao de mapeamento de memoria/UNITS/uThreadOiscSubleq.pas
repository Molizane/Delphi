unit uThreadOiscSubleq;

interface

uses
  Classes, SysUtils, uCompOiscSubleq;

var
  rgAdd_Hard_IRQ_0: longword = 16; // Endereço de manipulação da Hard IRQ 0
  rgAdd_Hard_IRQ_1: longword = 17; // Endereço de manipulação da Hard IRQ 1
  rgAdd_Hard_IRQ_2: longword = 18; // Endereço de manipulação da Hard IRQ 2
  rgAdd_Hard_IRQ_3: longword = 19; // Endereço de manipulação da Hard IRQ 3
  rgAdd_Hard_IRQ_4: longword = 20; // Endereço de manipulação da Hard IRQ 4
  rgAdd_Hard_IRQ_5: longword = 21; // Endereço de manipulação da Hard IRQ 5
  rgAdd_Hard_IRQ_6: longword = 22; // Endereço de manipulação da Hard IRQ 6
  rgAdd_Hard_IRQ_7: longword = 23; // Endereço de manipulação da Hard IRQ 7

  rgRet_Hard_IRQ_0: longword = 24; // Retorno da Hard IRQ 0
  rgRet_Hard_IRQ_1: longword = 25; // Retorno da Hard IRQ 1
  rgRet_Hard_IRQ_2: longword = 26; // Retorno da Hard IRQ 2
  rgRet_Hard_IRQ_3: longword = 27; // Retorno da Hard IRQ 3
  rgRet_Hard_IRQ_4: longword = 28; // Retorno da Hard IRQ 4
  rgRet_Hard_IRQ_5: longword = 29; // Retorno da Hard IRQ 5
  rgRet_Hard_IRQ_6: longword = 30; // Retorno da Hard IRQ 6
  rgRet_Hard_IRQ_7: longword = 31; // Retorno da Hard IRQ 7

  rgAdd_Soft_IRQ_0: longword = 32; // Endereço de manipulação da Soft IRQ 0
  rgAdd_Soft_IRQ_1: longword = 33; // Endereço de manipulação da Soft IRQ 1
  rgAdd_Soft_IRQ_2: longword = 34; // Endereço de manipulação da Soft IRQ 2
  rgAdd_Soft_IRQ_3: longword = 35; // Endereço de manipulação da Soft IRQ 3
  rgAdd_Soft_IRQ_4: longword = 36; // Endereço de manipulação da Soft IRQ 4
  rgAdd_Soft_IRQ_5: longword = 37; // Endereço de manipulação da Soft IRQ 5
  rgAdd_Soft_IRQ_6: longword = 38; // Endereço de manipulação da Soft IRQ 6
  rgAdd_Soft_IRQ_7: longword = 39; // Endereço de manipulação da Soft IRQ 7

  rgRet_Soft_IRQ_0: longword = 40; // Retorno da Soft IRQ 0
  rgRet_Soft_IRQ_1: longword = 41; // Retorno da Soft IRQ 1
  rgRet_Soft_IRQ_2: longword = 42; // Retorno da Soft IRQ 2
  rgRet_Soft_IRQ_3: longword = 43; // Retorno da Soft IRQ 3
  rgRet_Soft_IRQ_4: longword = 44; // Retorno da Soft IRQ 4
  rgRet_Soft_IRQ_5: longword = 45; // Retorno da Soft IRQ 5
  rgRet_Soft_IRQ_6: longword = 46; // Retorno da Soft IRQ 6
  rgRet_Soft_IRQ_7: longword = 47; // Retorno da Soft IRQ 7

  Exec_Halt: longword = $FFFFFFCB; // Chamadas a este endereço acionam o HALT

  // Definições dos registros internos da CPU
  rgError_Line: longword = $FFFFFFCC; // Linha onde ocorreu o erro
  rgError_Code: longword = $FFFFFFCD; // Código do erro
  rgError_Hndr: longword = $FFFFFFCE; // Endereço da rotina de manipulação de erro

  rgPar0_IRQ: longword = $FFFFFFCF; // --+
  rgPar1_IRQ: longword = $FFFFFFD0; //   +----> Parâmetros (caso necessários) para a IRQ (a b)
  rgPar2_IRQ: longword = $FFFFFFD1; // --+

  rgNum_IRQ: longword = $FFFFFFD2; // Número da IRQ a ser chamada (subleq a Add_IRQ).
  // Após a escrita nessa posição as interrupções ficam
  // bloqueadas até a chamada para o endereço abaixo
  Exec_IRQ: longword = $FFFFFFD3; // Executa IRQ. Gancho para chamada de IRQ (subleq TMP TMP Exec_IRQ)
  Ret_IRQ: longword = $FFFFFFD4; // Quando uma IRQ é chamada, o retorno é feito por aqui (subleq TMP TMP Ret_IRQ)

  rgHaltSig: longword = $FFFFFFD5; // Endereço rotina de HALT (a b)
  rgAddHALT: longword = $FFFFFFD6; // Sinal HALT (a b)

  rgIRQ_En: longword = $FFFFFFD7; // Habilita interrupções (menos NMI) (a b)
  rgHard_IRQ: longword = $FFFFFFD8; // Habilita interrupções por hardware
  rgSoft_IRQ: longword = $FFFFFFD9; // Habilita interrupções por software

  rgMemTop: longword = $FFFFFFDA; // Ponteiro de topo de memória (RAM+ROM)

  rgProtected: longword = $FFFFFFDB; // Flag de Modo Protegido

  // Se modo protegido habilitado, esses endereços também indicam os limites da programa em execução
  // ESTAS AREAS NÂO PODEM ENCAVALAR
  rgCS_Start: longword = $FFFFFFDC; // Ponteiro Início da área de código -+
  rgCS_End: longword = $FFFFFFDD; // Ponteiro Fim da área de código ----+---> execução (c)

  rgDS_Start: longword = $FFFFFFDE; // Ponteiro Início da área de dados --+
  rgDS_End: longword = $FFFFFFDF; // Ponteiro Fim da área de dados -----+----> leitura e escrita (a b)

  // Portas de I/O
  Port_0: longword = $FFFFFFE0; // Status teclado (subleq Port_0 b) (a b)
  Port_1: longword = $FFFFFFE1; // Inkey          (subleq Port_1 b) (a b)
  Port_2: longword = $FFFFFFE2; // OutChar        (subleq a Port_2) (a b)
  Port_3: longword = $FFFFFFE3; // (a b)
  Port_4: longword = $FFFFFFE4; // (a b)
  Port_5: longword = $FFFFFFE5; // (a b)
  Port_6: longword = $FFFFFFE6; // (a b)
  Port_7: longword = $FFFFFFE7; // (a b)
  Port_8: longword = $FFFFFFE8; // (a b)
  Port_9: longword = $FFFFFFE9; // (a b)
  Port_10: longword = $FFFFFFEA; // (a b)
  Port_11: longword = $FFFFFFEB; // (a b)
  Port_12: longword = $FFFFFFEC; // (a b)
  Port_13: longword = $FFFFFFED; // (a b)
  Port_14: longword = $FFFFFFEE; // (a b)
  Port_15: longword = $FFFFFFEF; // (a b)
  Port_16: longword = $FFFFFFF0; // (a b)
  Port_17: longword = $FFFFFFF1; // (a b)
  Port_18: longword = $FFFFFFF2; // (a b)
  Port_19: longword = $FFFFFFF3; // (a b)
  Port_20: longword = $FFFFFFF4; // (a b)
  Port_21: longword = $FFFFFFF5; // (a b)
  Port_22: longword = $FFFFFFF6; // (a b)
  Port_23: longword = $FFFFFFF7; // (a b)
  Port_24: longword = $FFFFFFF8; // (a b)
  Port_25: longword = $FFFFFFF9; // (a b)
  Port_26: longword = $FFFFFFFA; // (a b)
  Port_27: longword = $FFFFFFFB; // (a b)
  Port_28: longword = $FFFFFFFC; // (a b)
  Port_29: longword = $FFFFFFFD; // (a b)
  Port_30: longword = $FFFFFFFE; // (a b)
  Port_31: longword = $FFFFFFFF; // (a b)

const
  EndOfMemory = $0FFFFFFF; // 268435455, 28 bits
  //EndOfMemory = $00FFFFFF; // 16777215, 24 bits

type
  TMemory = record
    case integer of
      1: (AsInteger: array[0..EndOfMemory] of integer);
      2: (AsLong: array[0..EndOfMemory] of longword);
      //1: (AsInteger: array of integer);
      //2: (AsLong: array of longword);
  end;

  TInternalRegs_ = (
    irError_Line, irError_Code, irError_Hndr, irPar0_IRQ, irPar1_IRQ,
    irPar2_IRQ, irNum_IRQ, irHaltSig, irAddHALT, irIRQ_En, irHard_IRQ,
    irSoft_IRQ, irMemTop, irProtected, irCS_Start, irCS_End, irDS_Start,
    irDS_End
    );

  TInternalRegs = record
    case integer of
      1: (AsInteger: array[TInternalRegs_] of integer);
      2: (AsLong: array[TInternalRegs_] of longword);
  end;

  TIRQVector = array[0..7] of longword;
  TOISCInData = function: char of object;
  TOISCInStatus = function: boolean of object;

  TOISCOut = procedure(str: string) of object;
  THaltEvent = procedure(Sender: TObject) of object;
  TPauseEvent = procedure(Sender: TObject; Addr: longword) of object;
  TResetEvent = procedure(Sender: TObject; Addr: longword) of object;
  TErrorEvent = procedure(Sender: TObject; Addr: longword; Err: integer) of object;
  TStartDebugEvent = procedure(Sender: TObject) of object;
  TStepEvent = procedure(Sender: TObject; Addr: longword) of object;
  TLoadProgram = procedure of object;

  { TOISCSubleq }

  TOISCSubleq = class(TThread)
  private
    FOnStartDebug: TStartDebugEvent;
    FOnStartStep: TStepEvent;
    FOnEndStep: TStepEvent;
    FCurrAddr: longword;
    FError: integer;
    FOISCInData: TOISCInData;
    FOISCInStatus: TOISCInStatus;
    FOISCOut: TOISCOut;
    FIsRunning: boolean;
    FIsHalted: boolean;
    FIsPaused: boolean;
    FIsReset: boolean;
    //FTxtBuff: string;
    FChrBuff: char;
    FExecHalt: Boolean;

    FOnHalt: THaltEvent;
    FOnStart: TNotifyEvent;
    FOnPause: TPauseEvent;
    FOnReset: TResetEvent;
    FOnError: TErrorEvent;
    FIRQ: boolean;
    FRetNMI: longword;
    FAddSoftIRQ: longword;
    FRetSoftIRQ: longword;
    FRetHardIRQ: longword;
    FErrorCap: longword;
    FAddHardIRQ: longword;
    FNMI: longword;
    FRomIni: longword;

    FMapSoftIRQ: TIRQVector;
    FMapHardIRQ: TIRQVector;

    FSuspended, FStartDebug, FInDebug, FContStep, F1Step: boolean;

    FMemory: TMemory;
    FInternalPc: longword;
    FInternalAcc: integer;
    FInternalRegs: TInternalRegs;
    FLoadProgram: TLoadProgram;

    function GetHardIRQ: boolean;
    function GetMemTop: longword;
    function GetProtected: boolean;
    function GetSoftIRQ: boolean;

    procedure IsKey;
    procedure ReadKey;
    procedure WriteChar;
    //procedure WriteString;
    procedure GoRunning;
    procedure GoHalted;
    procedure GoPaused;
    procedure ErrorTrap;
    procedure DoReset;
    procedure ExecStartDebug;
    procedure Process_Messages;
  protected
    procedure Execute; override;
    procedure RuntimeError(Error: integer);
  public
    constructor Create(InDebug: boolean);
    procedure LoadProgr(Progr: TArrAssembled; Pause: Boolean);
    procedure Suspend;
    procedure Resume;

    procedure ExecPause;
    procedure ExecRun;
    procedure HaltSignal;
    procedure ExecReset;
    procedure ExecStartStep;
    procedure ExecEndStep;
    function AdjustHex(hex: string): string;
    function Paused: boolean;
    function ReadAcc: integer;
    function ReadPC: longword;
    function ReadReg(reg: TInternalRegs_): longword;

    procedure Halt;

    property Memory: TMemory read FMemory;

    property RomIni: longword read FRomIni;
    property MemTop: longword read GetMemTop;

    property IRQ: boolean read FIRQ; // Setado quando estiver tratando uma IRQ

    property SoftIRQ: boolean read GetSoftIRQ; // Flag de interrupção por software (True = habilitado)
    property AddSoftIRQ: longword read FAddSoftIRQ; // Endereço de disparo da interrupção por software
    property MapSoftIRQ: TIRQVector read FMapSoftIRQ; // Endereço de disparo da interrupção por software
    property RetSoftIRQ: longword read FRetSoftIRQ; // Endereço de retorno da interrupção por software

    property HardIRQ: boolean read GetHardIRQ; // Flag de interrupção por hardware (True = habilitado)
    property AddHardIRQ: longword read FAddHardIRQ; // Endereço de disparo da interrupção por hardware
    property MapHardIRQ: TIRQVector read FMapHardIRQ; // Endereço de disparo da interrupção por software
    property RetHardIRQ: longword read FRetHardIRQ; // Endereço de retorno da interrupção por hardware

    property NMI: longword read FNMI; // Endereço da interrupção não mascarável
    property RetNMI: longword read FRetNMI; // Endereço de retorno da interrupção não mascarável

    property Protected: boolean read GetProtected; // Flag de modo protegido (0=desabilitado)

    // Região somente de leitura
    property CSStart: longword read FInternalRegs.AsLong[irCS_Start]; // Início da Área de programa (CS)
    property CSEnd: longword read FInternalRegs.AsLong[irCS_End]; // Fim da Área de programa

    // região de leitura/scrita
    property DSStart: longword read FInternalRegs.AsLong[irDS_Start]; // Início da Área de dados (DS)
    property DSEnd: longword read FInternalRegs.AsLong[irDS_End]; // Fim da Área de dados

    property ErrorCap: longword read FErrorCap; // Endereço da rotina de captura de erro

    property IsHalted: boolean read FIsHalted;
    property InDebug: boolean read FInDebug write FInDebug;

    property OnStart: TNotifyEvent read FOnStart write FOnStart;
    property OnStartStep: TStepEvent read FOnStartStep write FOnStartStep;
    property OnEndStep: TStepEvent read FOnEndStep write FOnEndStep;
    property OnPause: TPauseEvent read FOnPause write FOnPause;
    property OnHalt: THaltEvent read FOnHalt write FOnHalt;
    property OnReset: TResetEvent read FOnReset write FOnReset;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnKeyStatus: TOISCInStatus read FOISCInStatus write FOISCInStatus;
    property OnReadKey: TOISCInData read FOISCInData write FOISCInData;
    property OnWriteText: TOISCOut read FOISCOut write FOISCOut;
    property OnStartDebug: TStartDebugEvent read FOnStartDebug write FOnStartDebug;
    property LoadProgram: TLoadProgram read FLoadProgram write FLoadProgram;

    property Acc: integer read FInternalAcc;
    property Suspended: boolean read FSuspended write FSuspended;
  end;

implementation

uses
  Windows, Forms, StrUtils;

var
  FCriticalSection: TRTLCriticalSection;
  //FCriticalSection: longword;
  //FCriticalSection: QWord;

  { TOISCSubleq }

constructor TOISCSubleq.Create(InDebug: boolean);
begin
  inherited Create(False);

  Priority := tpNormal;
  FreeOnTerminate := True;

  FIsRunning := False;
  FIsHalted := False;
  FIsPaused := True;
  FInDebug := InDebug;
  F1Step := False;
  FContStep := False;
  FSuspended := False;
  FExecHalt := False;

  FStartDebug := InDebug;

  //SetLength(FMemory, EndOfMemory + 1);
  FInternalRegs.AsLong[irMemTop] := EndOfMemory;
end;

procedure TOISCSubleq.Execute;
var
  MemA, MemB, MemC: integer;
  MemAy: longword absolute MemA;
  MemBy: longword absolute MemB;
  MemCy: longword absolute MemC;
  MemAx, MemBx, MemCx, v: longword;
  InternalReg: TInternalRegs_;
  FProtected: boolean;
  vz: word;
begin
  if Assigned(FLoadProgram) then
    FLoadProgram;

  ExecRun;

  FSuspended := False;
  FIsReset := True;
  vz := 0;

  while not Terminated do
  begin
    if FExecHalt then
    begin
      FExecHalt := False;
      FInternalRegs.AsLong[irProtected] := 0; // Desabilita modo protegido
      FInternalPc := FInternalRegs.AsLong[irAddHALT]
    end
    else if FIsReset then
      DoReset
    else if FIsPaused then
    begin
      Synchronize(Process_Messages);
      Continue;
    end;

    FCurrAddr := FInternalPc;
    FProtected := GetProtected();

    if FInDebug then
    begin
      if FStartDebug then
      begin
        FStartDebug := False;

        if Assigned(FOnStartDebug) then
          Synchronize(ExecStartDebug);
      end;

      if Assigned(FOnStartStep) then
        Synchronize(ExecStartStep);

      FSuspended := True;
    end
    else if FIsPaused then
      Continue;

    if FSuspended then
    begin
      while not Terminated and FSuspended do
        Synchronize(Process_Messages);

      if Terminated then
        Break;
    end;

    Inc(vz);

    if vz mod 100 = 0 then
    begin
      vz := 0;
      Synchronize(Process_Messages);
    end;

    try
      try
        if FProtected then
        begin
          if (FInternalRegs.AsLong[irCS_Start] = 0) or (FInternalRegs.AsLong[irCS_End] = 0) then
          begin
            RuntimeError(1);
            Continue;
          end
          else if (FInternalRegs.AsLong[irCS_Start] >= FInternalRegs.AsLong[irCS_End]) then
          begin
            RuntimeError(2);
            Continue;
          end
          else if (FInternalPc < FInternalRegs.AsLong[irCS_Start]) or
            (FInternalPc > FInternalRegs.AsLong[irCS_End]) then
          begin
            RuntimeError(3);
            Continue;
          end;
        end
        else if FInternalPc >= FInternalRegs.AsLong[irMemTop] then
        begin
          RuntimeError(4);
          Continue;
        end;

        MemAy := FMemory.AsLong[FInternalPc];

        if FProtected and (MemAy < FRomIni) then
        begin
          MemAx := MemAy + FInternalRegs.AsLong[irCS_Start];

          if ((MemAx >= FInternalRegs.AsLong[irDS_Start]) and
            (MemAx <= FInternalRegs.AsLong[irDS_End])) then
            Inc(MemAy, FInternalRegs.AsLong[irCS_Start]);
        end;

        MemAx := MemAy;

        if (MemAx = Exec_IRQ) or (MemAx = Ret_IRQ) then
        begin
          RuntimeError(5);
          Continue;
        end
        else if FProtected and not
          (((MemAx >= FInternalRegs.AsLong[irDS_Start]) and (MemAx <= FInternalRegs.AsLong[irDS_End])) or
          ((MemAx >= rgPar0_IRQ) and (MemAx <= rgNum_IRQ)) or ((MemAx >= rgCS_Start) and (MemAx <= rgDS_End))) then
        begin
          RuntimeError(6);
          Continue;
        end;

        MemBy := FMemory.AsLong[FInternalPc + 1];

        if FProtected and (MemBy < FRomIni) then
        begin
          MemBx := MemBy + FInternalRegs.AsLong[irCS_Start];

          if (MemBx >= FInternalRegs.AsLong[irDS_Start]) and
            (MemBx <= FInternalRegs.AsLong[irDS_End]) then
            Inc(MemBy, FInternalRegs.AsLong[irCS_Start]);
        end;

        MemBx := MemBy;

        if (MemBx = Exec_IRQ) or (MemBX = Ret_IRQ) then
        begin
          RuntimeError(7);
          Continue;
        end
        else if FProtected and not
          (((MemBx >= FInternalRegs.AsLong[irDS_Start]) and (MemBx <= FInternalRegs.AsLong[irDS_End])) or
          ((MemBx >= rgPar0_IRQ) and (MemBx <= rgNum_IRQ))) then
        begin
          RuntimeError(8);
          Continue;
        end;

        if (MemAx >= rgError_Line) and (MemAx <= rgDS_End) then
        begin
          if MemAx = rgError_Line then
            FInternalAcc := FInternalRegs.AsInteger[irError_Line]
          else if MemAx = rgError_Code then
            FInternalAcc := FInternalRegs.AsInteger[irError_Code]
          else if MemAx = rgError_Hndr then
            FInternalAcc := FInternalRegs.AsInteger[irError_Hndr]
          else if MemAx = rgPar0_IRQ then
            FInternalAcc := FInternalRegs.AsInteger[irPar0_IRQ]
          else if MemAx = rgPar1_IRQ then
            FInternalAcc := FInternalRegs.AsInteger[irPar1_IRQ]
          else if MemAx = rgPar2_IRQ then
            FInternalAcc := FInternalRegs.AsInteger[irPar2_IRQ]
          else if MemAx = rgNum_IRQ then
            FInternalAcc := FInternalRegs.AsInteger[irNum_IRQ]
          else if MemAx = rgHaltSig then
            FInternalAcc := FInternalRegs.AsInteger[irHaltSig]
          else if MemAx = rgAddHALT then
            FInternalAcc := FInternalRegs.AsInteger[irAddHALT]
          else if MemAx = rgIRQ_En then
            FInternalAcc := FInternalRegs.AsInteger[irIRQ_En]
          else if MemAx = rgHard_IRQ then
            FInternalAcc := FInternalRegs.AsInteger[irHard_IRQ]
          else if MemAx = rgSoft_IRQ then
            FInternalAcc := FInternalRegs.AsInteger[irSoft_IRQ]
          else if MemAx = rgMemTop then
            FInternalAcc := FInternalRegs.AsInteger[irMemTop]
          else if MemAx = rgProtected then
            FInternalAcc := FInternalRegs.AsInteger[irProtected]
          else if MemAx = rgCS_Start then
            FInternalAcc := FInternalRegs.AsInteger[irCS_Start]
          else if MemAx = rgCS_End then
            FInternalAcc := FInternalRegs.AsInteger[irCS_End]
          else if MemAx = rgDS_Start then
            FInternalAcc := FInternalRegs.AsInteger[irDS_Start]
          else //if MemAx = rgDS_End then
            FInternalAcc := FInternalRegs.AsInteger[irDS_End];
        end
        else if (MemAx >= Port_0) and (MemAx <= Port_31) then
        begin
          if MemAx = Port_0 then // Ler status do teclado e armazenar em FMemory[MemBx]
          begin
            if Assigned(FOISCInStatus) then
            begin
              Synchronize(IsKey);
              FInternalAcc := Ord(FChrBuff);
            end
            else
              FInternalAcc := 0;
          end
          else if MemAx = Port_1 then // Ler tecla e armazenar em FMemory[MemBx]
          begin
            Synchronize(ReadKey);
            FInternalAcc := Ord(FChrBuff);
          end
          else
            FInternalAcc := 0;
        end
        else
          FInternalAcc := FMemory.AsInteger[MemAx];

        if (MemBx >= Port_0) and (MemBx <= Port_31) then
        begin
          if MemBx = Port_2 then // Exibir conteúdo de FMemory[MemAx]
          begin
            FChrBuff := Chr(FInternalAcc);
            Synchronize(WriteChar);
          end;
        end
        else if MemBx = rgHaltSig then
        begin
          FInternalRegs.AsInteger[irHaltSig] := FInternalRegs.AsInteger[irHaltSig] - FInternalAcc;

          if FInternalRegs.AsInteger[irHaltSig] <> 0 then // Halt
            HaltSignal
        end
        else if (MemBx >= rgError_Line) and (MemBx <= rgDS_End) then
        begin
          if MemBx = rgError_Line then
            InternalReg := irError_Line
          else if MemBx = rgError_Code then
            InternalReg := irError_Code
          else if MemBx = rgError_Hndr then
            InternalReg := irError_Hndr
          else if MemBx = rgPar0_IRQ then
            InternalReg := irPar0_IRQ
          else if MemBx = rgPar1_IRQ then
            InternalReg := irPar1_IRQ
          else if MemBx = rgPar2_IRQ then
            InternalReg := irPar2_IRQ
          else if MemBx = rgNum_IRQ then
            InternalReg := irNum_IRQ
          else if MemBx = rgAddHALT then
            InternalReg := irAddHALT
          else if MemBx = rgIRQ_En then
            InternalReg := irIRQ_En
          else if MemBx = rgHard_IRQ then
            InternalReg := irHard_IRQ
          else if MemBx = rgSoft_IRQ then
            InternalReg := irSoft_IRQ
          else if MemBx = rgMemTop then
            InternalReg := irMemTop
          else if MemBx = rgProtected then
            InternalReg := irProtected
          else if MemBx = rgCS_Start then
            InternalReg := irCS_Start
          else if MemBx = rgCS_End then
            InternalReg := irCS_End
          else if MemBx = rgDS_Start then
            InternalReg := irDS_Start
          else //if MemBx = rgDS_End then
            InternalReg := irDS_End;

          FInternalAcc := FInternalRegs.AsInteger[InternalReg] - FInternalAcc;
          FInternalRegs.AsInteger[InternalReg] := FInternalAcc;
        end
        else if MemBx <= FInternalRegs.AsLong[irMemTop] then
        begin
          FInternalAcc := FMemory.AsInteger[MemBx] - FInternalAcc;
          FMemory.AsInteger[MemBx] := FInternalAcc;
        end
        else
          FInternalAcc := 1;

        if FInternalAcc <= 0 then
        begin
          MemCy := FMemory.AsLong[FInternalPc + 2];

          if FProtected and (MemCy < FRomIni) then
          begin
            MemCx := MemCy + FInternalRegs.AsLong[irCS_Start];

            if (MemCx >= FInternalRegs.AsLong[irCS_Start]) and
              (MemCx <= FInternalRegs.AsLong[irCS_End]) then
              Inc(MemCy, FInternalRegs.AsLong[irCS_Start]);
          end;

          MemCx := MemCy;

          if (MemCx > FInternalRegs.AsLong[irMemTop]) and (MemCx <> Exec_IRQ) and
            (MemCx <> Ret_IRQ) and (MemCx <> rgCS_Start) and (MemCx <> Exec_Halt) then
          begin
            RuntimeError(9);
            Continue;
          end
          else if FProtected and ((MemCx < FInternalRegs.AsLong[irCS_Start]) or
            ((MemCx > FInternalRegs.AsLong[irCS_End]) and (MemCx <> Exec_IRQ) and (MemCx <> Exec_Halt))) then
          begin
            RuntimeError(10);
            Continue;
          end;

          if MemCx = Exec_IRQ then // Chamada de Soft IRQ
          begin
            v := FInternalRegs.AsLong[irNum_IRQ];

            if FMemory.AsLong[40 + v] <> 0 then
            begin
              RuntimeError(11);
              Continue;
            end
            else
            begin
              FInternalRegs.AsLong[irProtected] := 0; // Desabilita modo protegido
              FMemory.AsLong[40 + v] := FInternalPc + 3; // Salva end. retorno
              FInternalPc := FMemory.AsLong[32 + v]; //  Atualiza PC
            end;
          end
          else if MemCx = Ret_IRQ then
          begin
            if FMemory.AsLong[40 + FInternalRegs.AsLong[irNum_IRQ]] = 0 then
            begin
              RuntimeError(12);
              Continue;
            end
            else
            begin
              FInternalRegs.AsLong[irProtected] := 1; // Habilita modo protegido
              FInternalPc := FMemory.AsLong[40 + FInternalRegs.AsLong[irNum_IRQ]]; //  Atualiza PC
              FMemory.AsLong[40 + FInternalRegs.AsLong[irNum_IRQ]] := 0; // Limpa end. retorno
            end;
          end
          else if MemCx = Exec_Halt then
          begin
            FInternalRegs.AsLong[irProtected] := 0; // Desabilita modo protegido
            FInternalPc := FInternalRegs.AsLong[irAddHALT]
          end
          else
            FInternalPc := MemCx;

          Continue;
        end
        else
          Inc(FInternalPc, 3);
      except
        RuntimeError(99);
        Continue;
      end;
    finally
      if not Terminated and FInDebug then
        if Assigned(FOnEndStep) then
          Synchronize(ExecEndStep);
    end;
  end;
end;

{
procedure TOISCSubleq.WriteString;
var
  i: integer;
begin
  if Assigned(FOISCOut) then
  begin
    for i := 1 to Length(FTxtBuff) do
      FOISCOut(FTxtBuff[i]);

    FTxtBuff := '';
  end;
end;
}

procedure TOISCSubleq.GoHalted;
begin
  FIsHalted := True;
  FIsPaused := False;

  if Assigned(FOnHalt) then
    FOnHalt(Self);
end;

procedure TOISCSubleq.ReadKey;
begin
  if Assigned(FOISCInData) then
    FChrBuff := FOISCInData()
  else
    FChrBuff := #0;
end;

procedure TOISCSubleq.GoRunning;
begin
  FIsReset := False;
  FIsHalted := False;
  FIsPaused := False;

  if Assigned(FOnStart) then
    FOnStart(Self);
end;

procedure TOISCSubleq.WriteChar;
begin
  if Assigned(FOISCOut) then
  begin
    FOISCOut(FChrBuff);
    FChrBuff := #0;
  end;
end;

procedure TOISCSubleq.GoPaused;
begin
  FIsPaused := True;

  if Assigned(FOnPause) then
    FOnPause(Self, Self.FInternalPc);
end;

procedure TOISCSubleq.HaltSignal;
begin
  EnterCriticalSection(FCriticalSection);

  try
    Synchronize(GoHalted);
  finally
    LeaveCriticalSection(FCriticalSection);
  end;
end;

procedure TOISCSubleq.ExecPause;
begin
  EnterCriticalSection(FCriticalSection);

  try
    if not FIsPaused then
      Synchronize(GoPaused);
  finally
    LeaveCriticalSection(FCriticalSection);
  end;
end;

procedure TOISCSubleq.ExecRun;
begin
  EnterCriticalSection(FCriticalSection);

  try
    Synchronize(GoRunning);
  finally
    LeaveCriticalSection(FCriticalSection);
  end;
end;

procedure TOISCSubleq.ExecReset;
begin
  EnterCriticalSection(FCriticalSection);

  try
    FIsReset := True;
    FIsHalted := False;
    FIsPaused := False;

    if Assigned(FonReset) then
      FOnReset(Self, Self.FInternalPc);
  finally
    LeaveCriticalSection(FCriticalSection);
  end;
end;

procedure TOISCSubleq.ExecStartStep;
begin
  EnterCriticalSection(FCriticalSection);

  try
    if Assigned(FOnStartStep) then
      FOnStartStep(Self, FCurrAddr);
  finally
    LeaveCriticalSection(FCriticalSection);
  end;
end;

procedure TOISCSubleq.ExecEndStep;
begin
  EnterCriticalSection(FCriticalSection);

  try
    if Assigned(FOnEndStep) then
      FOnEndStep(Self, FCurrAddr);
  finally
    LeaveCriticalSection(FCriticalSection);
  end;
end;

function TOISCSubleq.AdjustHex(hex: string): string;
begin
  Result := hex;

  while (Result <> '') and (Result[1] = '0') do
    Result := RightStr(Result, Length(Result) - 1);

  if Result = '' then
    Result := '0';
end;

procedure TOISCSubleq.LoadProgr(Progr: TArrAssembled; Pause: Boolean);
var
  i: integer;
begin
  if Pause then
    ExecPause;

  EnterCriticalSection(FCriticalSection);

  try
    if Length(Progr) > 0 then
      for i := 0 to Length(Progr) - 1 do
        FMemory.AsLong[Progr[i].Address] := Progr[i].Cont64;
  finally
    LeaveCriticalSection(FCriticalSection);
  end;
end;

function TOISCSubleq.Paused: boolean;
begin
  Result := FIsPaused;
end;

function TOISCSubleq.ReadAcc: integer;
begin
  Result := FInternalAcc;
end;

function TOISCSubleq.ReadPC: longword;
begin
  Result := FInternalPc;
end;

function TOISCSubleq.ReadReg(reg: TInternalRegs_): longword;
begin
  Result := FInternalRegs.AsLong[reg];
end;

procedure TOISCSubleq.ErrorTrap;
begin
  FIsHalted := True;
  FIsPaused := False;

  if Assigned(FOnError) then
    FOnError(Self, Self.FInternalPc, Self.FError);
end;

procedure TOISCSubleq.IsKey;
begin
  if Assigned(FOISCInStatus) then
    if FOISCInStatus() then
      FChrBuff := #1
    else
      FChrBuff := #0
  else
    FChrBuff := #0;
end;

function TOISCSubleq.GetMemTop: longword;
begin
  Result := FInternalRegs.AsLong[irMemTop];
end;

function TOISCSubleq.GetHardIRQ: boolean;
begin
  Result := FInternalRegs.AsLong[irHard_IRQ] <> 0;
end;

function TOISCSubleq.GetProtected: boolean;
begin
  Result := FInternalRegs.AsLong[irProtected] <> 0;
end;

function TOISCSubleq.GetSoftIRQ: boolean;
begin
  Result := FInternalRegs.AsLong[irSoft_IRQ] <> 0;
end;

procedure TOISCSubleq.DoReset;
begin
  FIsReset := False;
  FIsHalted := False;
  FIsPaused := False;
  FIRQ := False;

  FAddSoftIRQ := 0;
  FRetSoftIRQ := 0;

  FAddHardIRQ := 0;
  FRetHardIRQ := 0;

  FErrorCap := 0;

  FNMI := 0;
  FRetNMI := 0;

  FRomIni := $FFFF000;
  FInternalRegs.AsLong[irMemTop] := EndOfMemory;

  FInternalRegs.AsLong[irProtected] := 0;
  FInternalRegs.AsLong[irSoft_IRQ] := 0;
  FInternalRegs.AsLong[irHard_IRQ] := 0;
  FInternalRegs.AsLong[irCS_Start] := 0;
  FInternalRegs.AsLong[irCS_End] := 0;
  FInternalRegs.AsLong[irDS_Start] := 0;
  FInternalRegs.AsLong[irDS_End] := 0;
  FInternalPc := FRomIni;
  FInternalAcc := 0;
  FError := 0;

  ExecRun;
end;

procedure TOISCSubleq.ExecStartDebug;
begin
  EnterCriticalSection(FCriticalSection);

  try
    if Assigned(FOnStartDebug) then
      FOnStartDebug(Self);
  finally
    LeaveCriticalSection(FCriticalSection);
  end;
end;

procedure TOISCSubleq.Process_Messages;
begin
  Application.ProcessMessages;
end;

procedure TOISCSubleq.RuntimeError(Error: integer);
begin
  FError := Error;
  Synchronize(ErrorTrap);
  FIsPaused := True;
end;

procedure TOISCSubleq.Suspend;
begin
  FSuspended := True;
end;

procedure TOISCSubleq.Resume;
begin
  FSuspended := False;
end;

procedure TOISCSubleq.Halt;
begin
  FExecHalt := True;
  HaltSignal;
end;

initialization
  InitializeCriticalSection(FCriticalSection);
  //OleInitialize(nil);

finalization
  DeleteCriticalSection(FCriticalSection);
  //OleUninitialize;

end.

