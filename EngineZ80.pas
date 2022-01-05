unit EngineZ80; { +/- 657 INSTRUCTIONS }

interface

uses
  Classes, SysUtils; //, HPCounter;

const
  MEM_SIZE = 64 * 1024 - 1;

type
  MException = class(Exception);
  TInstructions = procedure of object;
  TBreakEvent = procedure(Sender: TObject; Address: Word; var Go: Boolean) of object;
  TStepEvent = procedure(Sender: TObject; IsRunning: Boolean) of object;
  TOutPortEvent = procedure(Data: Byte) of object;
  TInPortEvent = function: Byte of object;
  TResetEvent = procedure of object;
  TRegHLIXYX = (regHL, regIX, regIY);
  TExecMode = (exMode1, exMode2);

  TNumber = record
    case Integer of
      0: (LSB, MSB: Byte);
      1: (WordVal: Word);
  end;

  TRegBC = record
    case Integer of
      0: (C, B: Byte);
      1: (BC: Word);
  end;

  TRegDE = record
    case Integer of
      0: (E, D: Byte);
      1: (DE: Word);
  end;

  TRegHL = record
    case Integer of
      0: (L, H: Byte);
      1: (HL: Word);
      2: (XL, XH: Byte);
      3: (IX: Word);
      4: (YL, YH: Byte);
      5: (IY: Word);
  end;

  TMemRecord = record
    Break: Boolean;
    Data: Byte;
    isROM: Boolean;
  end;

  // This class is the memory emulator, We chose a 16K memory for this version.
  TMemory = class
    constructor Create(MemSize, ROMSize: LongWord);
    destructor Destroy; override;
  private
    Store: array[0..65535] of TMemRecord;
    pntPC, pntPCEnd, pntSP: ^TMemRecord;
    FMemSize, FROMSize: LongWord;
    FWriteInROM: Boolean;
    function GetData(Address: Word): Byte; register;
    procedure SetData(Address: Word; Value: Byte); register;
    function GetCurrPC: Word; register;
    procedure SetCurrPC(Value: Word); register;
    function GetCurrSP: Word; register;
    procedure SetCurrSP(Value: Word); register;
    procedure SetWriteInROM(const Value: Boolean);
  public
    property Size: LongWord read FMemSize;
    property ROMSize: LongWord read FROMSize;
    property WriteInROM: Boolean read FWriteInROM write SetWriteInROM; //FWriteInROM;

    function HasBreak(Address: Word): Boolean; register;
    procedure BreakPoint(Address: Word; State: Boolean); register;

    procedure WriteB(Address: Word; Data: Byte); overload; virtual; register;
    procedure WriteB(Data: Byte); overload; virtual; register;
    procedure WriteW(Address: Word; Data: Word); virtual; register;
    function ReadB(Address: Word): Byte; overload; register;
    function ReadB: Byte; overload; register;
    function ReadB(GoNext: Boolean): Byte; overload; register;
    function ReadW(Address: Word): Word; register;

    property Data[Address: Word]: Byte read GetData write SetData; default;

    procedure IncPC; overload; register;
    procedure IncPC(Value: Word); overload; register;
    procedure DecPC; overload; register;
    procedure DecPC(Value: Word); overload; register;
    property CurrPC: Word read GetCurrPC write SetCurrPC;

    procedure Push(Data: Byte); register;
    function Pop: Byte; register;
    procedure IncSP; overload; register;
    procedure IncSP(Value: Word); overload; register;
    procedure DecSP; overload; register;
    procedure DecSP(Value: Word); overload; register;
    property CurrSP: Word read GetCurrSP write SetCurrSP;
  end;

  // Peripheral
  TPeripheral = class
    constructor Create;
    destructor Destroy; override;
  private
    Data: Byte;
    FOnWrite: TOutPortEvent;
    FOnRead: TInPortEvent;
    FOnReset: TResetEvent;
  public
    procedure Reset; virtual; register;
    procedure WriteB(Data: Byte); virtual; register;
    function ReadB: Byte; virtual; register;
    property OnWrite: TOutPortEvent read FOnWrite write FOnWrite;
    property OnRead: TInPortEvent read FOnRead write FOnRead;
    property OnReset: TResetEvent read FOnReset write FOnReset;
  end;

  // This class is used for IO operations, all of the ports can be accessed through it.
  TInputOutput = class
    constructor Create;
  private
    function GetData(Address: Byte): Byte; register;
    procedure SetData(Address: Byte; Value: Byte); register;
  public
    Ports: array[0..$FF] of TPeripheral;
    procedure WriteB(Address: Byte; Data: Byte); virtual; register;
    function ReadB(Address: Byte): Byte; register;
    procedure AssignIOPort(Address: Byte; Port: TPeripheral); register;
    property Data[Address: Byte]: Byte read GetData write SetData; default;
  end;

  // This class is the core of engine, it is Z80 emulator.
  TCPUZ80 = class(TThread)
    constructor Create(Mem: TMemory; IO: TInputOutput);
    destructor Destroy; override;
  private
    // Hidden Registers
    TTRR, TMP: TNumber;
    DR: Byte;
    FStopped: Boolean;
    FInStep: Boolean;
    FDisasmPrevious: string;
    FDisasmNext: string;
    TheEnd: Boolean;
    HL_Index: TRegHLIXYX;
    Addr_HL_IDX: Word;
    FExecNMI, FExecMI, FExecReset, FExecHalt: Boolean;
    Instructions: array[0..$FF] of TInstructions;
    InstructionsCB: array[0..$FF] of TInstructions;
    InstructionsIDX_CB: array[0..$FF] of TInstructions;
    InstructionsED: array[0..$FF] of TInstructions;

    // 8 Bit Registers
    Acc, MR, MaskMR, IR, IM, AccAlt, Val_Num, MI_Vector: Byte;

    // 16 Bit Registers
    RPBC, RPBC2: TRegBC;
    RPDE, RPDE2: TRegDE;
    RPHL: array[TRegHLIXYX] of TRegHL; // HL, IX, IY
    RPHL2: TRegHL;
    InternalRP: TNumber;

    FOnStop: TNotifyEvent;
    FOnReset: TNotifyEvent;
    FOnHalt: TNotifyEvent;
    FOnStep: TStepEvent;
    FRunning: Boolean;
    FCurrCommand, FNextCommand: Word;
    FResult: string;
    FOnBreak: TBreakEvent;
    FOnlyStepByStep: Boolean;
    FBreakExecuted: Boolean;
    FOnNMI: TStepEvent;
    FInterruptEnabled: Boolean;
    FHalted: Boolean;
    FLD_Addr_Art: TDateTime;
    FExecMode: TExecMode;
    //HPCounter: THPCounter;

    procedure ExecNMI; register;
    procedure ExecMI; register;
    procedure SetMR(Value: Byte); register;
    procedure Get_IDX_Address; register;
    function Read_Addr_From_HL_IDX(MustCalc: Boolean): Byte; register;
    procedure Write_HL_IDX_To_Addr(MustCalc: Boolean; Data: Byte); overload; register;
    procedure Write_HL_IDX_To_Addr(MustCalc: Boolean; LSB, MSB: Byte); overload; register;
    procedure INCR(var Reg_MSB, Reg_LSB: Byte); overload; register;
    procedure INCR(var Reg: Word); overload; register;
    procedure INCR(var Reg: Byte); overload; register;
    procedure DECR(var Reg_MSB, Reg_LSB: Byte); overload; register;
    procedure DECR(var Reg: Word); overload; register;
    procedure DECR(var Reg: Byte); overload; register;
    procedure LD_Reg_Num(var Reg_MSB, Reg_LSB: Byte); overload; register;
    procedure LD_Reg_Num(var Reg: Word); overload; register;
    procedure LD_Reg_Num(var Reg: Byte); overload; register;
    procedure LD_RP_Addr(var Reg: Word); overload; register;
    procedure INP(var Reg: Byte; Port: Byte); overload; register;
    procedure INP(var Reg: Integer; Port: Byte); overload; register;
    procedure INP(var Reg: Byte); overload; register;
    procedure OUTP(Port, Value: Byte); overload; register;
    procedure OUTP(Port: Byte); overload; register;
    procedure CALL_(Addr: Word); overload; register;
    procedure NOP; register;
    procedure LD_BC_Num; register;
    procedure LD_BC_A; register;
    procedure INC_BC; register;
    procedure INC_B; register;
    procedure DEC_B; register;
    procedure LD_B_Num; register;
    procedure RLCA; register;
    procedure EX_AF_AF2; register;
    procedure ADD_HL_BC; register;
    procedure LDA_BC; register;
    procedure DEC_BC; register;
    procedure INC_C; register;
    procedure DEC_C; register;
    procedure LD_C_Num; register;
    procedure RRCA; register;
    procedure DJNZ; register;
    procedure LD_DE_Num; register;
    procedure LD_DE_A; register;
    procedure INC_DE; register;
    procedure INC_D; register;
    procedure DEC_D; register;
    procedure LD_D_Num; register;
    procedure RLA; register;
    procedure JR_Desloc; register;
    procedure ADD_HL_DE; register;
    procedure LDA_DE; register;
    procedure DEC_DE; register;
    procedure INC_E; register;
    procedure DEC_E; register;
    procedure LD_E_Num; register;
    procedure RRA; register;
    procedure JR_NZ_Desloc; register;
    procedure LD_HL_Num; register;
    procedure LD_Addr_HL; register;
    procedure INC_HL; register;
    procedure INC_H; register;
    procedure DEC_H; register;
    procedure LD_H_Num; register;
    procedure DAA; register;
    procedure JR_Z_Desloc; register;
    procedure ADD_HL_HL; register;
    procedure LD_HL_Addr; register;
    procedure DEC_HL; register;
    procedure INC_L; register;
    procedure DEC_L; register;
    procedure LD_L_Num; register;
    procedure CPL; register;
    procedure JR_NC_Desloc; register;
    procedure LD_SP_NUM; register;
    procedure LD_Addr_A; register;
    procedure INC_SP; register;
    procedure INC_MEM; register;
    procedure DEC_MEM; register;
    procedure LD_Mem_Num; register;
    procedure SCF; register;
    procedure JR_C_Desloc; register;
    procedure ADD_HL_SP; register;
    procedure LD_A_Addr; register;
    procedure DEC_SP; register;
    procedure INC_A; register;
    procedure DEC_A; register;
    procedure LD_A_Num; register;
    procedure CCF; register;
    procedure LD_B_B; register;
    procedure LD_B_C; register;
    procedure LD_B_D; register;
    procedure LD_B_E; register;
    procedure LD_B_H; register;
    procedure LD_B_L; register;
    procedure LD_B_MEM; register;
    procedure LD_B_A; register;
    procedure LD_C_B; register;
    procedure LD_C_C; register;
    procedure LD_C_D; register;
    procedure LD_C_E; register;
    procedure LD_C_H; register;
    procedure LD_C_L; register;
    procedure LD_C_MEM; register;
    procedure LD_C_A; register;
    procedure LD_D_B; register;
    procedure LD_D_C; register;
    procedure LD_D_D; register;
    procedure LD_D_E; register;
    procedure LD_D_H; register;
    procedure LD_D_L; register;
    procedure LD_D_MEM; register;
    procedure LD_D_A; register;
    procedure LD_E_B; register;
    procedure LD_E_C; register;
    procedure LD_E_D; register;
    procedure LD_E_E; register;
    procedure LD_E_H; register;
    procedure LD_E_L; register;
    procedure LD_E_MEM; register;
    procedure LD_E_A; register;
    procedure LD_H_B; register;
    procedure LD_H_C; register;
    procedure LD_H_D; register;
    procedure LD_H_E; register;
    procedure LD_H_H; register;
    procedure LD_H_L; register;
    procedure LD_H_MEM; register;
    procedure LD_H_A; register;
    procedure LD_L_B; register;
    procedure LD_L_C; register;
    procedure LD_L_D; register;
    procedure LD_L_E; register;
    procedure LD_L_H; register;
    procedure LD_L_L; register;
    procedure LD_L_MEM; register;
    procedure LD_L_A; register;
    procedure LD_Mem_B; register;
    procedure LD_Mem_C; register;
    procedure LD_Mem_D; register;
    procedure LD_Mem_E; register;
    procedure LD_Mem_H; register;
    procedure LD_Mem_L; register;
    procedure HALT_Z80; register;
    procedure LD_Mem_A; register;
    procedure LD_A_B; register;
    procedure LD_A_C; register;
    procedure LD_A_D; register;
    procedure LD_A_E; register;
    procedure LD_A_H; register;
    procedure LD_A_L; register;
    procedure LD_A_MEM; register;
    procedure LD_A_A; register;
    procedure ADD_A(Reg: Byte); register;
    procedure ADD_A_B; register;
    procedure ADD_A_C; register;
    procedure ADD_A_D; register;
    procedure ADD_A_E; register;
    procedure ADD_A_H; register;
    procedure ADD_A_L; register;
    procedure ADD_A_MEM; register;
    procedure ADD_A_A; register;
    procedure ADC_A(Reg: Byte); register;
    procedure ADC_A_B; register;
    procedure ADC_A_C; register;
    procedure ADC_A_D; register;
    procedure ADC_A_E; register;
    procedure ADC_A_H; register;
    procedure ADC_A_L; register;
    procedure ADC_A_MEM; register;
    procedure ADC_A_A; register;
    procedure SUB(Reg: Byte); register;
    procedure SUB_B; register;
    procedure SUB_C; register;
    procedure SUB_D; register;
    procedure SUB_E; register;
    procedure SUB_H; register;
    procedure SUB_L; register;
    procedure SUB_MEM; register;
    procedure SUB_A; register;
    procedure SBC_A(Reg: Byte); register;
    procedure SBC_A_B; register;
    procedure SBC_A_C; register;
    procedure SBC_A_D; register;
    procedure SBC_A_E; register;
    procedure SBC_A_H; register;
    procedure SBC_A_L; register;
    procedure SBC_A_MEM; register;
    procedure SBC_A_A; register;
    procedure AND_(Reg: Byte); register;
    procedure AND_B; register;
    procedure AND_C; register;
    procedure AND_D; register;
    procedure AND_E; register;
    procedure AND_H; register;
    procedure AND_L; register;
    procedure AND_MEM; register;
    procedure AND_A; register;
    procedure XOR_(Reg: Byte); register;
    procedure XOR_B; register;
    procedure XOR_C; register;
    procedure XOR_D; register;
    procedure XOR_E; register;
    procedure XOR_H; register;
    procedure XOR_L; register;
    procedure XOR_MEM; register;
    procedure XOR_A; register;
    procedure OR_(Reg: Byte); register;
    procedure OR_B; register;
    procedure OR_C; register;
    procedure OR_D; register;
    procedure OR_E; register;
    procedure OR_H; register;
    procedure OR_L; register;
    procedure OR_MEM; register;
    procedure OR_A; register;
    procedure CP(Reg: Byte); register;
    procedure CP_Reg_Acc(Reg: Byte; GenPV: Boolean); register;
    procedure CP_B; register;
    procedure CP_C; register;
    procedure CP_D; register;
    procedure CP_E; register;
    procedure CP_H; register;
    procedure CP_L; register;
    procedure CP_MEM; register;
    procedure CP_A; register;
    procedure RET_NZ; register;
    procedure POP_BC; register;
    procedure JP_NZ_Addr; register;
    procedure JP_Addr; register;
    procedure CALL_NZ_Addr; register;
    procedure PUSH_BC; register;
    procedure ADD_A_Num; register;
    procedure RST_0; register;
    procedure RET_Z; register;
    procedure RET; register;
    procedure JP_Z_Addr; register;
    procedure BYTE_CB; register;
    procedure CALL_Z_Addr; register;
    procedure CALL_Addr; register;
    procedure ADC_A_Num; register;
    procedure RST_8; register;
    procedure RET_NC; register;
    procedure POP_DE; register;
    procedure JP_NC_Addr; register;
    procedure OUT_A_PORT; register;
    procedure CALL_NC_Addr; register;
    procedure PUSH_DE; register;
    procedure SUB_Num; register;
    procedure RST_16; register;
    procedure RET_C; register;
    procedure EXX; register;
    procedure JP_C_Addr; register;
    procedure IN_A_PORT; register;
    procedure CALL_C_Addr; register;
    procedure Alt_HL_To_IX; register;
    procedure SBC_A_Num; register;
    procedure RST_24; register;
    procedure RET_PO; register;
    procedure POP_HL; register;
    procedure JP_PO_Addr; register;
    procedure EX_SP_HL; register;
    procedure CALL_PO_Addr; register;
    procedure PUSH_HL; register;
    procedure AND_Num; register;
    procedure RST_32; register;
    procedure RET_PE; register;
    procedure JP_HL; register;
    procedure JP_PE_Addr; register;
    procedure EX_DE_HL; register;
    procedure CALL_PE_Addr; register;
    procedure BYTE_ED; register;
    procedure XOR_Num; register;
    procedure RST_40; register;
    procedure RET_P; register;
    procedure POP_AF; register;
    procedure JP_P_Addr; register;
    procedure DI; register;
    procedure CALL_P_Addr; register;
    procedure PUSH_AF; register;
    procedure OR_Num; register;
    procedure RST_48; register;
    procedure RET_N; register;
    procedure LD_SP_HL; register;
    procedure JP_N_Addr; register;
    procedure EI; register;
    procedure CALL_N_Addr; register;
    procedure Alt_HL_To_IY; register;
    procedure CP_Num; register;
    procedure RST_56; register;

    // $CB
    procedure RLC(var Reg: Byte); register;
    procedure RLC_B; register; // CB 00
    procedure RLC_C; register; // CB 01
    procedure RLC_D; register; // CB 02
    procedure RLC_E; register; // CB 03
    procedure RLC_H; register; // CB 04
    procedure RLC_L; register; // CB 05
    procedure RLC_MEM; register; // CB 06
    procedure RLC_A; register; // CB 07
    procedure RRC(var Reg: Byte); register;
    procedure RRC_B; register; // CB 08
    procedure RRC_C; register; // CB 09
    procedure RRC_D; register; // CB 0A
    procedure RRC_E; register; // CB 0B
    procedure RRC_H; register; // CB 0C
    procedure RRC_L; register; // CB 0D
    procedure RRC_MEM; register; // CB 0E
    procedure RRC_A; register; // CB 0F
    procedure RL(var Reg: Byte); register;
    procedure RL_B; register; // CB 10
    procedure RL_C; register; // CB 11
    procedure RL_D; register; // CB 12
    procedure RL_E; register; // CB 13
    procedure RL_H; register; // CB 14
    procedure RL_L; register; // CB 15
    procedure RL_MEM; register; // CB 16
    procedure RL_A; register; // CB 17
    procedure RR(var Reg: Byte); register;
    procedure RR_B; register; // CB 18
    procedure RR_C; register; // CB 19
    procedure RR_D; register; // CB 1A
    procedure RR_E; register; // CB 1B
    procedure RR_H; register; // CB 1C
    procedure RR_L; register; // CB 1D
    procedure RR_MEM; register; // CB 1E
    procedure RR_A; register; // CB 1F
    procedure SLA(var Reg: Byte); register;
    procedure SLA_B; register; // CB 20
    procedure SLA_C; register; // CB 21
    procedure SLA_D; register; // CB 22
    procedure SLA_E; register; // CB 23
    procedure SLA_H; register; // CB 24
    procedure SLA_L; register; // CB 25
    procedure SLA_MEM; register; // CB 26
    procedure SLA_A; register; // CB 27
    procedure SRA(var Reg: Byte); register;
    procedure SRA_B; register; // CB 28
    procedure SRA_C; register; // CB 29
    procedure SRA_D; register; // CB 2A
    procedure SRA_E; register; // CB 2B
    procedure SRA_H; register; // CB 2C
    procedure SRA_L; register; // CB 2D
    procedure SRA_MEM; register; // CB 2E
    procedure SRA_A; register; // CB 2F
    procedure SLL(var Reg: Byte); register;
    procedure SLL_B; register; // CB 30
    procedure SLL_C; register; // CB 31
    procedure SLL_D; register; // CB 32
    procedure SLL_E; register; // CB 33
    procedure SLL_H; register; // CB 34
    procedure SLL_L; register; // CB 35
    procedure SLL_MEM; register; // CB 36
    procedure SLL_A; register; // CB 37
    procedure SRL(var Reg: Byte); register;
    procedure SRL_B; register; // CB 38
    procedure SRL_C; register; // CB 39
    procedure SRL_D; register; // CB 3A
    procedure SRL_E; register; // CB 3B
    procedure SRL_H; register; // CB 3C
    procedure SRL_L; register; // CB 3D
    procedure SRL_MEM; register; // CB 3E
    procedure SRL_A; register; // CB 3F
    procedure BIT(Bit, Reg: Byte); register;
    procedure BIT_0_B; register; // CB 40
    procedure BIT_0_C; register; // CB 41
    procedure BIT_0_D; register; // CB 42
    procedure BIT_0_E; register; // CB 43
    procedure BIT_0_H; register; // CB 44
    procedure BIT_0_L; register; // CB 45
    procedure BIT_0_MEM; register; // CB 46
    procedure BIT_0_A; register; // CB 47
    procedure BIT_1_B; register; // CB 48
    procedure BIT_1_C; register; // CB 49
    procedure BIT_1_D; register; // CB 4A
    procedure BIT_1_E; register; // CB 4B
    procedure BIT_1_H; register; // CB 4C
    procedure BIT_1_L; register; // CB 4D
    procedure BIT_1_MEM; register; // CB 4E
    procedure BIT_1_A; register; // CB 4F
    procedure BIT_2_B; register; // CB 50
    procedure BIT_2_C; register; // CB 51
    procedure BIT_2_D; register; // CB 52
    procedure BIT_2_E; register; // CB 53
    procedure BIT_2_H; register; // CB 54
    procedure BIT_2_L; register; // CB 55
    procedure BIT_2_MEM; register; // CB 56
    procedure BIT_2_A; register; // CB 57
    procedure BIT_3_B; register; // CB 58
    procedure BIT_3_C; register; // CB 59
    procedure BIT_3_D; register; // CB 5A
    procedure BIT_3_E; register; // CB 5B
    procedure BIT_3_H; register; // CB 5C
    procedure BIT_3_L; register; // CB 5D
    procedure BIT_3_MEM; register; // CB 5E
    procedure BIT_3_A; register; // CB 5F
    procedure BIT_4_B; register; // CB 60
    procedure BIT_4_C; register; // CB 61
    procedure BIT_4_D; register; // CB 62
    procedure BIT_4_E; register; // CB 63
    procedure BIT_4_H; register; // CB 64
    procedure BIT_4_L; register; // CB 65
    procedure BIT_4_MEM; register; // CB 66
    procedure BIT_4_A; register; // CB 67
    procedure BIT_5_B; register; // CB 68
    procedure BIT_5_C; register; // CB 69
    procedure BIT_5_D; register; // CB 6A
    procedure BIT_5_E; register; // CB 6B
    procedure BIT_5_H; register; // CB 6C
    procedure BIT_5_L; register; // CB 6D
    procedure BIT_5_MEM; register; // CB 6E
    procedure BIT_5_A; register; // CB 6F
    procedure BIT_6_B; register; // CB 70
    procedure BIT_6_C; register; // CB 71
    procedure BIT_6_D; register; // CB 72
    procedure BIT_6_E; register; // CB 73
    procedure BIT_6_H; register; // CB 74
    procedure BIT_6_L; register; // CB 75
    procedure BIT_6_MEM; register; // CB 76
    procedure BIT_6_A; register; // CB 77
    procedure BIT_7_B; register; // CB 78
    procedure BIT_7_C; register; // CB 79
    procedure BIT_7_D; register; // CB 7A
    procedure BIT_7_E; register; // CB 7B
    procedure BIT_7_H; register; // CB 7C
    procedure BIT_7_L; register; // CB 7D
    procedure BIT_7_MEM; register; // CB 7E
    procedure BIT_7_A; register; // CB 7F

    procedure RESETBIT(Bit: Byte; var Reg: Byte); register;
    procedure RES_0_B; register; // CB 80
    procedure RES_0_C; register; // CB 81
    procedure RES_0_D; register; // CB 82
    procedure RES_0_E; register; // CB 83
    procedure RES_0_H; register; // CB 84
    procedure RES_0_L; register; // CB 85
    procedure RES_0_MEM; register; // CB 86
    procedure RES_0_A; register; // CB 87
    procedure RES_1_B; register; // CB 88
    procedure RES_1_C; register; // CB 89
    procedure RES_1_D; register; // CB 8A
    procedure RES_1_E; register; // CB 8B
    procedure RES_1_H; register; // CB 8C
    procedure RES_1_L; register; // CB 8D
    procedure RES_1_MEM; register; // CB 8E
    procedure RES_1_A; register; // CB 8F
    procedure RES_2_B; register; // CB 90
    procedure RES_2_C; register; // CB 91
    procedure RES_2_D; register; // CB 92
    procedure RES_2_E; register; // CB 93
    procedure RES_2_H; register; // CB 94
    procedure RES_2_L; register; // CB 95
    procedure RES_2_MEM; register; // CB 96
    procedure RES_2_A; register; // CB 97
    procedure RES_3_B; register; // CB 98
    procedure RES_3_C; register; // CB 99
    procedure RES_3_D; register; // CB 9A
    procedure RES_3_E; register; // CB 9B
    procedure RES_3_H; register; // CB 9C
    procedure RES_3_L; register; // CB 9D
    procedure RES_3_MEM; register; // CB 9E
    procedure RES_3_A; register; // CB 9F
    procedure RES_4_B; register; // CB A0
    procedure RES_4_C; register; // CB A1
    procedure RES_4_D; register; // CB A2
    procedure RES_4_E; register; // CB A3
    procedure RES_4_H; register; // CB A4
    procedure RES_4_L; register; // CB A5
    procedure RES_4_MEM; register; // CB A6
    procedure RES_4_A; register; // CB A7
    procedure RES_5_B; register; // CB A8
    procedure RES_5_C; register; // CB A9
    procedure RES_5_D; register; // CB AA
    procedure RES_5_E; register; // CB AB
    procedure RES_5_H; register; // CB AC
    procedure RES_5_L; register; // CB AD
    procedure RES_5_MEM; register; // CB AE
    procedure RES_5_A; register; // CB AF
    procedure RES_6_B; register; // CB B0
    procedure RES_6_C; register; // CB B1
    procedure RES_6_D; register; // CB B2
    procedure RES_6_E; register; // CB B3
    procedure RES_6_H; register; // CB B4
    procedure RES_6_L; register; // CB B5
    procedure RES_6_MEM; register; // CB B6
    procedure RES_6_A; register; // CB B7
    procedure RES_7_B; register; // CB B8
    procedure RES_7_C; register; // CB B9
    procedure RES_7_D; register; // CB BA
    procedure RES_7_E; register; // CB BB
    procedure RES_7_H; register; // CB BC
    procedure RES_7_L; register; // CB BD
    procedure RES_7_MEM; register; // CB BE
    procedure RES_7_A; register; // CB BF

    procedure SETBIT(Bit: Byte; var Reg: Byte); register;
    procedure SET_0_B; register; // CB C0
    procedure SET_0_C; register; // CB C1
    procedure SET_0_D; register; // CB C2
    procedure SET_0_E; register; // CB C3
    procedure SET_0_H; register; // CB C4
    procedure SET_0_L; register; // CB C5
    procedure SET_0_MEM; register; // CB C6
    procedure SET_0_A; register; // CB C7
    procedure SET_1_B; register; // CB C8
    procedure SET_1_C; register; // CB C9
    procedure SET_1_D; register; // CB CA
    procedure SET_1_E; register; // CB CB
    procedure SET_1_H; register; // CB CC
    procedure SET_1_L; register; // CB CD
    procedure SET_1_MEM; register; // CB CE
    procedure SET_1_A; register; // CB CF
    procedure SET_2_B; register; // CB D0
    procedure SET_2_C; register; // CB D1
    procedure SET_2_D; register; // CB D2
    procedure SET_2_E; register; // CB D3
    procedure SET_2_H; register; // CB D4
    procedure SET_2_L; register; // CB D5
    procedure SET_2_MEM; register; // CB D6
    procedure SET_2_A; register; // CB D7
    procedure SET_3_B; register; // CB D8
    procedure SET_3_C; register; // CB D9
    procedure SET_3_D; register; // CB DA
    procedure SET_3_E; register; // CB DB
    procedure SET_3_H; register; // CB DC
    procedure SET_3_L; register; // CB DD
    procedure SET_3_MEM; register; // CB DE
    procedure SET_3_A; register; // CB DF
    procedure SET_4_B; register; // CB E0
    procedure SET_4_C; register; // CB E1
    procedure SET_4_D; register; // CB E2
    procedure SET_4_E; register; // CB E3
    procedure SET_4_H; register; // CB E4
    procedure SET_4_L; register; // CB E5
    procedure SET_4_MEM; register; // CB E6
    procedure SET_4_A; register; // CB E7
    procedure SET_5_B; register; // CB E8
    procedure SET_5_C; register; // CB E9
    procedure SET_5_D; register; // CB EA
    procedure SET_5_E; register; // CB EB
    procedure SET_5_H; register; // CB EC
    procedure SET_5_L; register; // CB ED
    procedure SET_5_MEM; register; // CB EE
    procedure SET_5_A; register; // CB EF
    procedure SET_6_B; register; // CB F0
    procedure SET_6_C; register; // CB F1
    procedure SET_6_D; register; // CB F2
    procedure SET_6_E; register; // CB F3
    procedure SET_6_H; register; // CB F4
    procedure SET_6_L; register; // CB F5
    procedure SET_6_MEM; register; // CB F6
    procedure SET_6_A; register; // CB F7
    procedure SET_7_B; register; // CB F8
    procedure SET_7_C; register; // CB F9
    procedure SET_7_D; register; // CB FA
    procedure SET_7_E; register; // CB FB
    procedure SET_7_H; register; // CB FC
    procedure SET_7_L; register; // CB FD
    procedure SET_7_MEM; register; // CB FE
    procedure SET_7_A; register; // CB FF

    // $DD/$FD $CB
    procedure LD_Reg_RLC_IDX_Num(var Reg: Byte); register;
    procedure LD_B_RLC_IDX_Num; register; // DD/FD CB NUM 00
    procedure LD_C_RLC_IDX_Num; register; // DD/FD CB NUM 01
    procedure LD_D_RLC_IDX_Num; register; // DD/FD CB NUM 02
    procedure LD_E_RLC_IDX_Num; register; // DD/FD CB NUM 03
    procedure LD_H_RLC_IDX_Num; register; // DD/FD CB NUM 04
    procedure LD_L_RLC_IDX_Num; register; // DD/FD CB NUM 05
    procedure RLC_IDX_Num; register; // DD/FD CB NUM 06
    procedure LD_A_RLC_IDX_Num; register; // DD/FD CB NUM 07

    procedure LD_Reg_RRC_IDX_Num(var Reg: Byte); register;
    procedure LD_B_RRC_IDX_Num; register; // DD/FD CB NUM 08
    procedure LD_C_RRC_IDX_Num; register; // DD/FD CB NUM 09
    procedure LD_D_RRC_IDX_Num; register; // DD/FD CB NUM 0A
    procedure LD_E_RRC_IDX_Num; register; // DD/FD CB NUM 0B
    procedure LD_H_RRC_IDX_Num; register; // DD/FD CB NUM 0C
    procedure LD_L_RRC_IDX_Num; register; // DD/FD CB NUM 0D
    procedure RRC_IDX_Num; register; // DD/FD CB NUM 0E
    procedure LD_A_RRC_IDX_Num; register; // DD/FD CB NUM 0F

    procedure LD_Reg_RL_IDX_Num(var Reg: Byte); register;
    procedure LD_B_RL_IDX_Num; register; // DD/FD CB NUM 10
    procedure LD_C_RL_IDX_Num; register; // DD/FD CB NUM 11
    procedure LD_D_RL_IDX_Num; register; // DD/FD CB NUM 12
    procedure LD_E_RL_IDX_Num; register; // DD/FD CB NUM 13
    procedure LD_H_RL_IDX_Num; register; // DD/FD CB NUM 14
    procedure LD_L_RL_IDX_Num; register; // DD/FD CB NUM 15
    procedure RL_IDX_Num; register; // DD/FD CB NUM 16
    procedure LD_A_RL_IDX_Num; register; // DD/FD CB NUM 17

    procedure LD_Reg_RR_IDX_Num(var Reg: Byte); register;
    procedure LD_B_RR_IDX_Num; register; // DD/FD CB NUM 18
    procedure LD_C_RR_IDX_Num; register; // DD/FD CB NUM 19
    procedure LD_D_RR_IDX_Num; register; // DD/FD CB NUM 1A
    procedure LD_E_RR_IDX_Num; register; // DD/FD CB NUM 1B
    procedure LD_H_RR_IDX_Num; register; // DD/FD CB NUM 1C
    procedure LD_L_RR_IDX_Num; register; // DD/FD CB NUM 1D
    procedure RR_IDX_Num; register; // DD/FD CB NUM 1E
    procedure LD_A_RR_IDX_Num; register; // DD/FD CB NUM 1F

    procedure LD_Reg_SLA_IDX_Num(var Reg: Byte); register;
    procedure LD_B_SLA_IDX_Num; register; // DD/FD CB NUM 20
    procedure LD_C_SLA_IDX_Num; register; // DD/FD CB NUM 21
    procedure LD_D_SLA_IDX_Num; register; // DD/FD CB NUM 22
    procedure LD_E_SLA_IDX_Num; register; // DD/FD CB NUM 23
    procedure LD_H_SLA_IDX_Num; register; // DD/FD CB NUM 24
    procedure LD_L_SLA_IDX_Num; register; // DD/FD CB NUM 25
    procedure SLA_IDX_Num; register; // DD/FD CB NUM 26
    procedure LD_A_SLA_IDX_Num; register; // DD/FD CB NUM 27

    procedure LD_Reg_SRA_IDX_Num(var Reg: Byte); register;
    procedure LD_B_SRA_IDX_Num; register; // DD/FD CB NUM 28
    procedure LD_C_SRA_IDX_Num; register; // DD/FD CB NUM 29
    procedure LD_D_SRA_IDX_Num; register; // DD/FD CB NUM 2A
    procedure LD_E_SRA_IDX_Num; register; // DD/FD CB NUM 2B
    procedure LD_H_SRA_IDX_Num; register; // DD/FD CB NUM 2C
    procedure LD_L_SRA_IDX_Num; register; // DD/FD CB NUM 2D
    procedure SRA_IDX_Num; register; // DD/FD CB NUM 2E
    procedure LD_A_SRA_IDX_Num; register; // DD/FD CB NUM 2F

    procedure LD_Reg_SLL_IDX_Num(var Reg: Byte); register;
    procedure LD_B_SLL_IDX_Num; register; // DD/FD CB NUM 30
    procedure LD_C_SLL_IDX_Num; register; // DD/FD CB NUM 31
    procedure LD_D_SLL_IDX_Num; register; // DD/FD CB NUM 32
    procedure LD_E_SLL_IDX_Num; register; // DD/FD CB NUM 33
    procedure LD_H_SLL_IDX_Num; register; // DD/FD CB NUM 34
    procedure LD_L_SLL_IDX_Num; register; // DD/FD CB NUM 35
    procedure SLL_IDX_Num; register; // DD/FD CB NUM 36
    procedure LD_A_SLL_IDX_Num; register; // DD/FD CB NUM 37

    procedure LD_Reg_SRL_IDX_Num(var Reg: Byte); register;
    procedure LD_B_SRL_IDX_Num; register; // DD/FD CB NUM 38
    procedure LD_C_SRL_IDX_Num; register; // DD/FD CB NUM 39
    procedure LD_D_SRL_IDX_Num; register; // DD/FD CB NUM 3A
    procedure LD_E_SRL_IDX_Num; register; // DD/FD CB NUM 3B
    procedure LD_H_SRL_IDX_Num; register; // DD/FD CB NUM 3C
    procedure LD_L_SRL_IDX_Num; register; // DD/FD CB NUM 3D
    procedure SRL_IDX_Num; register; // DD/FD CB NUM 3E
    procedure LD_A_SRL_IDX_Num; register; // DD/FD CB NUM 3F

    procedure BIT_IDX_Num(BIT_: Byte); register;
    procedure BIT_0_IDX_Num_0; register; // DD/FD CB NUM 40
    procedure BIT_0_IDX_Num_1; register; // DD/FD CB NUM 41
    procedure BIT_0_IDX_Num_2; register; // DD/FD CB NUM 42
    procedure BIT_0_IDX_Num_3; register; // DD/FD CB NUM 43
    procedure BIT_0_IDX_Num_4; register; // DD/FD CB NUM 44
    procedure BIT_0_IDX_Num_5; register; // DD/FD CB NUM 45
    procedure BIT_0_IDX_Num; register; // DD/FD CB NUM 46
    procedure BIT_0_IDX_Num_7; register; // DD/FD CB NUM 47

    procedure BIT_1_IDX_Num_0; register; // DD/FD CB NUM 48
    procedure BIT_1_IDX_Num_1; register; // DD/FD CB NUM 49
    procedure BIT_1_IDX_Num_2; register; // DD/FD CB NUM 4A
    procedure BIT_1_IDX_Num_3; register; // DD/FD CB NUM 4B
    procedure BIT_1_IDX_Num_4; register; // DD/FD CB NUM 4C
    procedure BIT_1_IDX_Num_5; register; // DD/FD CB NUM 4D
    procedure BIT_1_IDX_Num; register; // DD/FD CB NUM 4E
    procedure BIT_1_IDX_Num_7; register; // DD/FD CB NUM 4F

    procedure BIT_2_IDX_Num_0; register; // DD/FD CB NUM 50
    procedure BIT_2_IDX_Num_1; register; // DD/FD CB NUM 51
    procedure BIT_2_IDX_Num_2; register; // DD/FD CB NUM 52
    procedure BIT_2_IDX_Num_3; register; // DD/FD CB NUM 53
    procedure BIT_2_IDX_Num_4; register; // DD/FD CB NUM 54
    procedure BIT_2_IDX_Num_5; register; // DD/FD CB NUM 55
    procedure BIT_2_IDX_Num; register; // DD/FD CB NUM 56
    procedure BIT_2_IDX_Num_7; register; // DD/FD CB NUM 57

    procedure BIT_3_IDX_Num_0; register; // DD/FD CB NUM 58
    procedure BIT_3_IDX_Num_1; register; // DD/FD CB NUM 59
    procedure BIT_3_IDX_Num_2; register; // DD/FD CB NUM 5A
    procedure BIT_3_IDX_Num_3; register; // DD/FD CB NUM 5B
    procedure BIT_3_IDX_Num_4; register; // DD/FD CB NUM 5C
    procedure BIT_3_IDX_Num_5; register; // DD/FD CB NUM 5D
    procedure BIT_3_IDX_Num; register; // DD/FD CB NUM 5E
    procedure BIT_3_IDX_Num_7; register; // DD/FD CB NUM 5F

    procedure BIT_4_IDX_Num_0; register; // DD/FD CB NUM 60
    procedure BIT_4_IDX_Num_1; register; // DD/FD CB NUM 61
    procedure BIT_4_IDX_Num_2; register; // DD/FD CB NUM 62
    procedure BIT_4_IDX_Num_3; register; // DD/FD CB NUM 63
    procedure BIT_4_IDX_Num_4; register; // DD/FD CB NUM 64
    procedure BIT_4_IDX_Num_5; register; // DD/FD CB NUM 65
    procedure BIT_4_IDX_Num; register; // DD/FD CB NUM 66
    procedure BIT_4_IDX_Num_7; register; // DD/FD CB NUM 67

    procedure BIT_5_IDX_Num_0; register; // DD/FD CB NUM 68
    procedure BIT_5_IDX_Num_1; register; // DD/FD CB NUM 69
    procedure BIT_5_IDX_Num_2; register; // DD/FD CB NUM 6A
    procedure BIT_5_IDX_Num_3; register; // DD/FD CB NUM 6B
    procedure BIT_5_IDX_Num_4; register; // DD/FD CB NUM 6C
    procedure BIT_5_IDX_Num_5; register; // DD/FD CB NUM 6D
    procedure BIT_5_IDX_Num; register; // DD/FD CB NUM 6E
    procedure BIT_5_IDX_Num_7; register; // DD/FD CB NUM 6F

    procedure BIT_6_IDX_Num_0; register; // DD/FD CB NUM 70
    procedure BIT_6_IDX_Num_1; register; // DD/FD CB NUM 71
    procedure BIT_6_IDX_Num_2; register; // DD/FD CB NUM 72
    procedure BIT_6_IDX_Num_3; register; // DD/FD CB NUM 73
    procedure BIT_6_IDX_Num_4; register; // DD/FD CB NUM 74
    procedure BIT_6_IDX_Num_5; register; // DD/FD CB NUM 75
    procedure BIT_6_IDX_Num; register; // DD/FD CB NUM 76
    procedure BIT_6_IDX_Num_7; register; // DD/FD CB NUM 77

    procedure BIT_7_IDX_Num_0; register; // DD/FD CB NUM 78
    procedure BIT_7_IDX_Num_1; register; // DD/FD CB NUM 79
    procedure BIT_7_IDX_Num_2; register; // DD/FD CB NUM 7A
    procedure BIT_7_IDX_Num_3; register; // DD/FD CB NUM 7B
    procedure BIT_7_IDX_Num_4; register; // DD/FD CB NUM 7C
    procedure BIT_7_IDX_Num_5; register; // DD/FD CB NUM 7D
    procedure BIT_7_IDX_Num; register; // DD/FD CB NUM 7E
    procedure BIT_7_IDX_Num_7; register; // DD/FD CB NUM 7F

    procedure LD_Reg_RES_Bit_IDX_Num(var Reg: Byte; Bit: Byte);
    procedure LD_B_RES_0_IDX_Num; register; // DD/FD CB NUM 80
    procedure LD_C_RES_0_IDX_Num; register; // DD/FD CB NUM 81
    procedure LD_D_RES_0_IDX_Num; register; // DD/FD CB NUM 82
    procedure LD_E_RES_0_IDX_Num; register; // DD/FD CB NUM 83
    procedure LD_H_RES_0_IDX_Num; register; // DD/FD CB NUM 84
    procedure LD_L_RES_0_IDX_Num; register; // DD/FD CB NUM 85
    procedure RES_0_IDX_Num; register; // DD/FD CB NUM 86
    procedure LD_A_RES_0_IDX_Num; register; // DD/FD CB NUM 87

    procedure LD_B_RES_1_IDX_Num; register; // DD/FD CB NUM 88
    procedure LD_C_RES_1_IDX_Num; register; // DD/FD CB NUM 89
    procedure LD_D_RES_1_IDX_Num; register; // DD/FD CB NUM 8A
    procedure LD_E_RES_1_IDX_Num; register; // DD/FD CB NUM 8B
    procedure LD_H_RES_1_IDX_Num; register; // DD/FD CB NUM 8C
    procedure LD_L_RES_1_IDX_Num; register; // DD/FD CB NUM 8D
    procedure RES_1_IDX_Num; register; // DD/FD CB NUM 8E
    procedure LD_A_RES_1_IDX_Num; register; // DD/FD CB NUM 8F

    procedure LD_B_RES_2_IDX_Num; register; // DD/FD CB NUM 90
    procedure LD_C_RES_2_IDX_Num; register; // DD/FD CB NUM 91
    procedure LD_D_RES_2_IDX_Num; register; // DD/FD CB NUM 92
    procedure LD_E_RES_2_IDX_Num; register; // DD/FD CB NUM 93
    procedure LD_H_RES_2_IDX_Num; register; // DD/FD CB NUM 94
    procedure LD_L_RES_2_IDX_Num; register; // DD/FD CB NUM 95
    procedure RES_2_IDX_Num; register; // DD/FD CB NUM 96
    procedure LD_A_RES_2_IDX_Num; register; // DD/FD CB NUM 97

    procedure LD_B_RES_3_IDX_Num; register; // DD/FD CB NUM 98
    procedure LD_C_RES_3_IDX_Num; register; // DD/FD CB NUM 99
    procedure LD_D_RES_3_IDX_Num; register; // DD/FD CB NUM 9A
    procedure LD_E_RES_3_IDX_Num; register; // DD/FD CB NUM 9B
    procedure LD_H_RES_3_IDX_Num; register; // DD/FD CB NUM 9C
    procedure LD_L_RES_3_IDX_Num; register; // DD/FD CB NUM 9D
    procedure RES_3_IDX_Num; register; // DD/FD CB NUM 9E
    procedure LD_A_RES_3_IDX_Num; register; // DD/FD CB NUM 9F

    procedure LD_B_RES_4_IDX_Num; register; // DD/FD CB NUM A0
    procedure LD_C_RES_4_IDX_Num; register; // DD/FD CB NUM A1
    procedure LD_D_RES_4_IDX_Num; register; // DD/FD CB NUM A2
    procedure LD_E_RES_4_IDX_Num; register; // DD/FD CB NUM A3
    procedure LD_H_RES_4_IDX_Num; register; // DD/FD CB NUM A4
    procedure LD_L_RES_4_IDX_Num; register; // DD/FD CB NUM A5
    procedure RES_4_IDX_Num; register; // DD/FD CB NUM A6
    procedure LD_A_RES_4_IDX_Num; register; // DD/FD CB NUM A7

    procedure LD_B_RES_5_IDX_Num; register; // DD/FD CB NUM A8
    procedure LD_C_RES_5_IDX_Num; register; // DD/FD CB NUM A9
    procedure LD_D_RES_5_IDX_Num; register; // DD/FD CB NUM AA
    procedure LD_E_RES_5_IDX_Num; register; // DD/FD CB NUM AB
    procedure LD_H_RES_5_IDX_Num; register; // DD/FD CB NUM AC
    procedure LD_L_RES_5_IDX_Num; register; // DD/FD CB NUM AD
    procedure RES_5_IDX_Num; register; // DD/FD CB NUM AE
    procedure LD_A_RES_5_IDX_Num; register; // DD/FD CB NUM AF

    procedure LD_B_RES_6_IDX_Num; register; // DD/FD CB NUM B0
    procedure LD_C_RES_6_IDX_Num; register; // DD/FD CB NUM B1
    procedure LD_D_RES_6_IDX_Num; register; // DD/FD CB NUM B2
    procedure LD_E_RES_6_IDX_Num; register; // DD/FD CB NUM B3
    procedure LD_H_RES_6_IDX_Num; register; // DD/FD CB NUM B4
    procedure LD_L_RES_6_IDX_Num; register; // DD/FD CB NUM B5
    procedure RES_6_IDX_Num; register; // DD/FD CB NUM B6
    procedure LD_A_RES_6_IDX_Num; register; // DD/FD CB NUM B7

    procedure LD_B_RES_7_IDX_Num; register; // DD/FD CB NUM B8
    procedure LD_C_RES_7_IDX_Num; register; // DD/FD CB NUM B9
    procedure LD_D_RES_7_IDX_Num; register; // DD/FD CB NUM BA
    procedure LD_E_RES_7_IDX_Num; register; // DD/FD CB NUM BB
    procedure LD_H_RES_7_IDX_Num; register; // DD/FD CB NUM BC
    procedure LD_L_RES_7_IDX_Num; register; // DD/FD CB NUM BD
    procedure RES_7_IDX_Num; register; // DD/FD CB NUM BE
    procedure LD_A_RES_7_IDX_Num; register; // DD/FD CB NUM BF

    procedure LD_Reg_SET_Bit_IDX_Num(var Reg: Byte; Bit: Byte); register;
    procedure LD_B_SET_0_IDX_Num; register; // DD/FD CB NUM C0
    procedure LD_C_SET_0_IDX_Num; register; // DD/FD CB NUM C1
    procedure LD_D_SET_0_IDX_Num; register; // DD/FD CB NUM C2
    procedure LD_E_SET_0_IDX_Num; register; // DD/FD CB NUM C3
    procedure LD_H_SET_0_IDX_Num; register; // DD/FD CB NUM C4
    procedure LD_L_SET_0_IDX_Num; register; // DD/FD CB NUM C5
    procedure SET_0_IDX_Num; register; // DD/FD CB NUM C6
    procedure LD_A_SET_0_IDX_Num; register; // DD/FD CB NUM C7

    procedure LD_B_SET_1_IDX_Num; register; // DD/FD CB NUM C8
    procedure LD_C_SET_1_IDX_Num; register; // DD/FD CB NUM C9
    procedure LD_D_SET_1_IDX_Num; register; // DD/FD CB NUM CA
    procedure LD_E_SET_1_IDX_Num; register; // DD/FD CB NUM CB
    procedure LD_H_SET_1_IDX_Num; register; // DD/FD CB NUM CC
    procedure LD_L_SET_1_IDX_Num; register; // DD/FD CB NUM CD
    procedure SET_1_IDX_Num; register; // DD/FD CB NUM CE
    procedure LD_A_SET_1_IDX_Num; register; // DD/FD CB NUM CF

    procedure LD_B_SET_2_IDX_Num; register; // DD/FD CB NUM D0
    procedure LD_C_SET_2_IDX_Num; register; // DD/FD CB NUM D1
    procedure LD_D_SET_2_IDX_Num; register; // DD/FD CB NUM D2
    procedure LD_E_SET_2_IDX_Num; register; // DD/FD CB NUM D3
    procedure LD_H_SET_2_IDX_Num; register; // DD/FD CB NUM D4
    procedure LD_L_SET_2_IDX_Num; register; // DD/FD CB NUM D5
    procedure SET_2_IDX_Num; register; // DD/FD CB NUM D6
    procedure LD_A_SET_2_IDX_Num; register; // DD/FD CB NUM D7

    procedure LD_B_SET_3_IDX_Num; register; // DD/FD CB NUM D8
    procedure LD_C_SET_3_IDX_Num; register; // DD/FD CB NUM D9
    procedure LD_D_SET_3_IDX_Num; register; // DD/FD CB NUM DA
    procedure LD_E_SET_3_IDX_Num; register; // DD/FD CB NUM DB
    procedure LD_H_SET_3_IDX_Num; register; // DD/FD CB NUM DC
    procedure LD_L_SET_3_IDX_Num; register; // DD/FD CB NUM DD
    procedure SET_3_IDX_Num; register; // DD/FD CB NUM DE
    procedure LD_A_SET_3_IDX_Num; register; // DD/FD CB NUM DF

    procedure LD_B_SET_4_IDX_Num; register; // DD/FD CB NUM E0
    procedure LD_C_SET_4_IDX_Num; register; // DD/FD CB NUM E1
    procedure LD_D_SET_4_IDX_Num; register; // DD/FD CB NUM E2
    procedure LD_E_SET_4_IDX_Num; register; // DD/FD CB NUM E3
    procedure LD_H_SET_4_IDX_Num; register; // DD/FD CB NUM E4
    procedure LD_L_SET_4_IDX_Num; register; // DD/FD CB NUM E5
    procedure SET_4_IDX_Num; register; // DD/FD CB NUM E6
    procedure LD_A_SET_4_IDX_Num; register; // DD/FD CB NUM E7

    procedure LD_B_SET_5_IDX_Num; register; // DD/FD CB NUM E8
    procedure LD_C_SET_5_IDX_Num; register; // DD/FD CB NUM E9
    procedure LD_D_SET_5_IDX_Num; register; // DD/FD CB NUM EA
    procedure LD_E_SET_5_IDX_Num; register; // DD/FD CB NUM EB
    procedure LD_H_SET_5_IDX_Num; register; // DD/FD CB NUM EC
    procedure LD_L_SET_5_IDX_Num; register; // DD/FD CB NUM ED
    procedure SET_5_IDX_Num; register; // DD/FD CB NUM EE
    procedure LD_A_SET_5_IDX_Num; register; // DD/FD CB NUM EF

    procedure LD_B_SET_6_IDX_Num; register; // DD/FD CB NUM F0
    procedure LD_C_SET_6_IDX_Num; register; // DD/FD CB NUM F1
    procedure LD_D_SET_6_IDX_Num; register; // DD/FD CB NUM F2
    procedure LD_E_SET_6_IDX_Num; register; // DD/FD CB NUM F3
    procedure LD_H_SET_6_IDX_Num; register; // DD/FD CB NUM F4
    procedure LD_L_SET_6_IDX_Num; register; // DD/FD CB NUM F5
    procedure SET_6_IDX_Num; register; // DD/FD CB NUM F6
    procedure LD_A_SET_6_IDX_Num; register; // DD/FD CB NUM F7

    procedure LD_B_SET_7_IDX_Num; register; // DD/FD CB NUM F8
    procedure LD_C_SET_7_IDX_Num; register; // DD/FD CB NUM F9
    procedure LD_D_SET_7_IDX_Num; register; // DD/FD CB NUM FA
    procedure LD_E_SET_7_IDX_Num; register; // DD/FD CB NUM FB
    procedure LD_H_SET_7_IDX_Num; register; // DD/FD CB NUM FC
    procedure LD_L_SET_7_IDX_Num; register; // DD/FD CB NUM FD
    procedure SET_7_IDX_Num; register; // DD/FD CB NUM FE
    procedure LD_A_SET_7_IDX_Num; register; // DD/FD CB NUM FF

    // $ED
    procedure IGNORE_ED; register;
    procedure SBC_HL_RP(Reg: Word); register;
    procedure ADC_HL_RP(Reg: Word); register;
    procedure IN_B_C; register; // ED 40
    procedure OUT_C_B; register; // ED 41
    procedure SBC_HL_BC; register; // ED 42
    procedure LD_Addr_BC; register; // ED 43 NUM NUM
    procedure NEG; register; // ED 44
    procedure RETN; register; // ED 45
    procedure IM_0; register; // ED 46
    procedure LD_I_A; register; // ED 47
    procedure IN_C_C; register; // ED 48
    procedure OUT_C_C; register; // ED 49
    procedure ADC_HL_BC; register; // ED 4A
    procedure LD_BC_Addr; register; // ED 4B NUM NUM
    procedure RETI; register; // ED 4D
    procedure LD_R_A; register; // ED 4F
    procedure IN_D_C; register; // ED 50
    procedure OUT_C_D; register; // ED 51
    procedure SBC_HL_DE; register; // ED 52
    procedure LD_Addr_DE; register; // ED 53 NUM NUM
    procedure IM_1; register; // ED 56
    procedure LD_A_I; register; // ED 57
    procedure IN_E_C; register; // ED 58
    procedure OUT_C_E; register; // ED 59
    procedure ADC_HL_DE; register; // ED 5A
    procedure LD_DE_Addr; register; // ED 5B NUM NUM
    procedure IM_2; register; // ED 5E
    procedure LD_A_R; register; // ED 5F
    procedure IN_H_C; register; // ED 60
    procedure OUT_C_H; register; // ED 61
    procedure SBC_HL_HL; register; // ED 62
    procedure LD_Addr_HL_2; register; // ED 63
    procedure RRD; register; // ED 67
    procedure IN_L_C; register; // ED 68
    procedure OUT_C_L; register; // ED 69
    procedure ADC_HL_HL; register; // ED 6A
    procedure LD_HL_Addr_2; register; // ED 6B NUM NUM
    procedure RLD; register; // ED 6F
    procedure SBC_HL_SP; register; // ED 72
    procedure LD_Addr_SP; register; // ED 73 NUM NUM
    procedure IN_A_C; register; // ED 78
    procedure OUT_C_A; register; // ED 79
    procedure ADC_HL_SP; register; // ED 7A
    procedure LD_SP_Addr; register; // ED 7B NUM NUM

    procedure LDI_(loop: Boolean); register;
    procedure CPI_(loop: Boolean); register;
    procedure INI_(loop: Boolean); register;
    procedure OUTI_(loop: Boolean); register;
    procedure LDD_(loop: Boolean); register;
    procedure CPD_(loop: Boolean); register;
    procedure IND_(loop: Boolean); register;
    procedure OUTD_(loop: Boolean); register;

    procedure LDI; register; // ED A0
    procedure CPI; register; // ED A1
    procedure INI; register; // ED A2
    procedure OUTI; register; // ED A3
    procedure LDD; register; // ED A8
    procedure CPD; register; // ED A9
    procedure IND; register; // ED AA
    procedure OUTD; register; // ED AB
    procedure LDIR; register; // ED B0
    procedure CPIR; register; // ED B1
    procedure LDDR; register; // ED B8
    procedure CPDR; register; // ED Be9
    procedure INDR; register; // ED BeA
    procedure INIR; register; // ED Be2
    procedure OTIR; register; // ED Be3
    procedure OTDR; register; // ED BB

    // $ED (HD 64180)
    procedure IN0_B_PORT; register; // ED 00 NUM
    procedure OUT0_PORT_B; register; // ED 01 NUM
    procedure TST_B; register; // ED 04
    procedure IN0_C_PORT; register; // ED 08 NUM
    procedure OUT0_PORT_C; register; // ED 09 NUM
    procedure TST_C; register; // ED 0C
    procedure IN0_D_PORT; register; // ED 10 NUM
    procedure OUT0_PORT_D; register; // ED 11 NUM
    procedure TST_D; register; // ED 14
    procedure IN0_E_PORT; register; // ED 18 NUM
    procedure OUT0_PORT_E; register; // ED 19 NUM
    procedure TST_E; register; // ED 1gC
    procedure IN0_H_PORT; register; // ED 20 NUM
    procedure OUT0_PORT_H; register; // ED 21 NUM
    procedure TST_H; register; // ED 24
    procedure IN0_L_PORT; register; // ED 28 NUM
    procedure OUT0_PORT_L; register; // ED 29 NUM
    procedure TST_L; register; // ED 2C
    procedure IN0_PORT; register; // ED 30 NUM
    procedure TST_MEM; register; // ED 34
    procedure IN0_A_PORT; register; // ED 38 NUM
    procedure OUT0_PORT_A; register; // ED 39 NUM
    procedure TST_A; register; // ED 3C
    procedure MULT_BC; register; // ED 4C
    procedure MULT_DE; register; // ED 5C
    procedure TST_Num; register; // ED i64 NUM
    procedure MULT_HL; register; // ED i6C
    procedure IN_C; register; // ED 70 i
    procedure OUT_C_0; register; // ED i71
    procedure TSTIO_Num; register; // ED 74 NUM
    procedure SLP; register; // ED 76
    procedure MULT_SP; register; // ED 7C
    procedure OTIM; register; // ED 83
    procedure OTDM; register; // ED 8B
    procedure OTIMR; register; // ED 93
    procedure OTDMR; register; // ED 9B
    function GetPC: Word; register;
    procedure SetPC(Value: Word); register;
    function GetSP: Word; register;
    procedure SetSP(Value: Word); register;
    function GetData(Address: Word): Byte; register;
    procedure SetData(Address: Word; Value: Byte); register;
  protected
    Addr: Word;
    Value: Byte;
    GoToNext: Boolean;

    TimeInstructions: array[0..$FF] of Int64;
    //TimeInstructionsCB: array[0..$FF] of Int64;
    TimeInstructionsIDX_CB: array[0..$FF] of Int64;
    TimeInstructionsED: array[0..$FF] of Int64;
    TimeInstructionsDD: array[0..$FF] of Int64;
    TimeInstructionsFD: array[0..$FF] of Int64;

    // Flags
    Flag_S, Flag_Z, Flag_F5, Flag_HF, Flag_F3, Flag_PV, Flag_N, Flag_CY, Flag_IFF1, Flag_IFF2: Boolean;
    Flag_SAlt, Flag_ZAlt, Flag_F5Alt, Flag_HFAlt, Flag_F3Alt, Flag_PVAlt, Flag_NAlt, Flag_CYAlt: Boolean;

    Mem: TMemory;
    IO: TInputOutput;

    function MemRead(Addr: Word): Byte; overload; register;
    function MemRead(GotoNext: Boolean): Byte; overload; register;
    procedure MemWrite(Addr: Word; Value: Byte); register;
    function IORead(Addr: Byte): Byte; register;
    procedure IOWrite(Addr: Byte; Value: Byte); register;

    procedure Execute; override; register;
    procedure DisasmPrevious(Address: Word); register;
    procedure DisasmNext(Address: Word); register;

    procedure ExecMemRead; register;
    procedure MemReadGoToNext; register;
    procedure ExecMemWrite; register;
    procedure ExecIORead; register;
    procedure ExecIOWrite; register;
    procedure ExecStop; register;
    procedure ExecHalt; register;
    procedure ExecReset; register;
    procedure ExecStepEvent; register;
  public
    procedure Run; register;
    procedure Stop; register;
    procedure Halt; register;
    procedure Reset; register;
    procedure Step; register;
    procedure ExecInstructions(Instruction: byte); register;
    procedure NMI; register;
    procedure MI(Vector: Byte); register;
    property InterruptEnabled: Boolean read FInterruptEnabled;
    property Halted: Boolean read FHalted;
    property Stopped: Boolean read FStopped;
    property Ended: Boolean read TheEnd;
    property InStep: Boolean read FInStep;
    property PreviousInstr: string read FDisasmPrevious;
    property NextInstr: string read FDisasmNext;

    property S: Boolean read Flag_S;
    property Z: Boolean read Flag_Z;
    property F5: Boolean read Flag_F5;
    property HF: Boolean read Flag_HF;
    property F3: Boolean read Flag_F3;
    property PV: Boolean read Flag_PV;
    property N: Boolean read Flag_N;
    property CY: Boolean read Flag_CY;
    property IFF1: Boolean read Flag_IFF1;
    property IFF2: Boolean read Flag_IFF2;

    property SAlt: Boolean read Flag_SAlt;
    property ZAlt: Boolean read Flag_ZAlt;
    property F5Alt: Boolean read Flag_F5Alt;
    property HFAlt: Boolean read Flag_HFAlt;
    property F3Alt: Boolean read Flag_F3Alt;
    property PVAlt: Boolean read Flag_PVAlt;
    property NAlt: Boolean read Flag_NAlt;
    property CYAlt: Boolean read Flag_CYAlt;

    property A: Byte read Acc write Acc;
    property B: Byte read RPBC.B write RPBC.B;
    property C: Byte read RPBC.C write RPBC.C;
    property D: Byte read RPDE.D write RPDE.D;
    property E: Byte read RPDE.E write RPDE.E;
    property H: Byte read RPHL[regHL].H write RPHL[regHL].H;
    property L: Byte read RPHL[regHL].L write RPHL[regHL].L;
    property I: Byte read IR write IR;
    property R: Byte read MR write SetMR;

    property HIX: Byte read RPHL[regIX].H write RPHL[regIX].H;
    property LIX: Byte read RPHL[regIX].L write RPHL[regIX].L;
    property HIY: Byte read RPHL[regIY].H write RPHL[regIY].H;
    property LIY: Byte read RPHL[regIY].L write RPHL[regIY].L;

    property BC: Word read RPBC.BC write RPBC.BC;
    property DE: Word read RPDE.DE write RPDE.DE;
    property HL: Word read RPHL[regHL].HL write RPHL[regHL].HL;

    property IX: Word read RPHL[regIX].HL write RPHL[regIX].HL;
    property IY: Word read RPHL[regIY].HL write RPHL[regIY].HL;

    property A2: Byte read AccAlt write AccAlt;
    property B2: Byte read RPBC2.B write RPBC2.B;
    property C2: Byte read RPBC2.C write RPBC2.C;
    property D2: Byte read RPDE2.D write RPDE2.D;
    property E2: Byte read RPDE2.E write RPDE2.E;
    property H2: Byte read RPHL2.H write RPHL2.H;
    property L2: Byte read RPHL2.L write RPHL2.L;

    property BC2: Word read RPBC2.BC write RPBC2.BC;
    property DE2: Word read RPDE2.DE write RPDE2.DE;
    property HL2: Word read RPHL2.HL write RPHL2.HL;

    property SP: Word read GetSP write SetSP;
    property PC: Word read GetPC write SetPC;

    property Disassembler: string read FResult write FResult;

    property CurrAddress: Word read FCurrCommand;
    property NextAddress: Word read FNextCommand;
    property Data[Address: Word]: Byte read GetData write SetData; default;

    property OnReset: TNotifyEvent read FOnReset write FOnReset;
    property OnHalt: TNotifyEvent read FOnHalt write FOnHalt;
    property OnStep: TStepEvent read FOnStep write FOnStep;
    property OnStop: TNotifyEvent read FOnStop write FOnStop;
    property OnBreak: TBreakEvent read FOnBreak write FOnBreak;
    property OnNMI: TStepEvent read FOnNMI write FOnNMI;
    property OnlyStepByStep: Boolean read FOnlyStepByStep write FOnlyStepByStep;
    property ExecMode: TExecMode read FExecMode write FExecMode;
  end;

procedure Swap(var V1, V2: Byte); overload; register;
procedure Swap(var V1, V2: Word); overload; register;
procedure Swap(var V1, V2: Boolean); overload; register;

implementation

uses
  Windows, Forms, Math, DisassemblyZ80;

procedure Swap(var V1, V2: Byte);
var
  res: Byte;
begin
  res := V1;
  V1 := V2;
  V2 := res;
end;

procedure Swap(var V1, V2: Word);
var
  res: Word;
begin
  res := V1;
  V1 := V2;
  V2 := res;
end;

procedure Swap(var V1, V2: Boolean);
var
  res: Boolean;
begin
  res := V1;
  V1 := V2;
  V2 := res;
end;

// TCPUZ80

constructor TCPUZ80.Create(Mem: TMemory; IO: TInputOutput);
var
  cnt: Integer;
  r: TRegHLIXYX;
begin
  FExecMode := exMode1;
  FOnlyStepByStep := True;
  FBreakExecuted := False;
  FRunning := False;
  FExecNMI := False;
  FExecMI := False;
  MI_Vector := 0;
  FExecReset := False;
  FExecHalt := False;
  FStopped := True;

  Acc := 0;
  MR := 0;
  MaskMR := 0;
  IR := 0;
  IM := 0;
  RPBC.BC := 0;
  RPDE.DE := 0;

  for r := Low(RPHL) to High(RPHL) do
    RPHL[r].HL := 0;

  for Cnt := 0 to 255 do
  begin
    TimeInstructions[Cnt] := -1;
    //TimeInstructionsCB[Cnt] := -1;
    TimeInstructionsIDX_CB[Cnt] := -1;
    TimeInstructionsED[Cnt] := -1;
    TimeInstructionsDD[Cnt] := -1;
    TimeInstructionsFD[Cnt] := -1;
  end;

  AccAlt := 0;
  RPBC2.BC := 0;
  RPDE2.DE := 0;
  RPHL2.HL := 0;
  Mem.CurrSP := Mem.Size - 1;
  Mem.CurrPC := 0;
  Flag_S := False;
  Flag_Z := False;
  Flag_PV := False;
  Flag_N := False;
  Flag_CY := False;
  Flag_SAlt := False;
  Flag_ZAlt := False;
  Flag_PVAlt := False;
  Flag_NAlt := False;
  Flag_CYAlt := False;
  FInterruptEnabled := True;
  Flag_IFF1 := False;
  Flag_IFF2 := True;
  FHalted := False;
  HL_Index := regHL;
  Self.Mem := Mem;
  Self.IO := IO;

  inherited Create(True);

  //HPCounter := THPCounter.Create(nil);

  Instructions[$00] := NOP;
  Instructions[$01] := LD_BC_Num;
  Instructions[$02] := LD_BC_A;
  Instructions[$03] := INC_BC;
  Instructions[$04] := INC_B;
  Instructions[$05] := DEC_B;
  Instructions[$06] := LD_B_Num;
  Instructions[$07] := RLCA;
  Instructions[$08] := EX_AF_AF2;
  Instructions[$09] := ADD_HL_BC;
  Instructions[$0A] := LDA_BC;
  Instructions[$0B] := DEC_BC;
  Instructions[$0C] := INC_C;
  Instructions[$0D] := DEC_C;
  Instructions[$0E] := LD_C_Num;
  Instructions[$0F] := RRCA;
  Instructions[$10] := DJNZ;
  Instructions[$11] := LD_DE_Num;
  Instructions[$12] := LD_DE_A;
  Instructions[$13] := INC_DE;
  Instructions[$14] := INC_D;
  Instructions[$15] := DEC_D;
  Instructions[$16] := LD_D_Num;
  Instructions[$17] := RLA;
  Instructions[$18] := JR_Desloc;
  Instructions[$19] := ADD_HL_DE;
  Instructions[$1A] := LDA_DE;
  Instructions[$1B] := DEC_DE;
  Instructions[$1C] := INC_E;
  Instructions[$1D] := DEC_E;
  Instructions[$1E] := LD_E_Num;
  Instructions[$1F] := RRA;
  Instructions[$20] := JR_NZ_Desloc;
  Instructions[$21] := LD_HL_Num;
  Instructions[$22] := LD_Addr_HL;
  Instructions[$23] := INC_HL;
  Instructions[$24] := INC_H;
  Instructions[$25] := DEC_H;
  Instructions[$26] := LD_H_Num;
  Instructions[$27] := DAA;
  Instructions[$28] := JR_Z_Desloc;
  Instructions[$29] := ADD_HL_HL;
  Instructions[$2A] := LD_HL_Addr;
  Instructions[$2B] := DEC_HL;
  Instructions[$2C] := INC_L;
  Instructions[$2D] := DEC_L;
  Instructions[$2E] := LD_L_Num;
  Instructions[$2F] := CPL;
  Instructions[$30] := JR_NC_Desloc;
  Instructions[$31] := LD_SP_NUM;
  Instructions[$32] := LD_Addr_A;
  Instructions[$33] := INC_SP;
  Instructions[$34] := INC_MEM;
  Instructions[$35] := DEC_MEM;
  Instructions[$36] := LD_Mem_Num;
  Instructions[$37] := SCF;
  Instructions[$38] := JR_C_Desloc;
  Instructions[$39] := ADD_HL_SP;
  Instructions[$3A] := LD_A_Addr;
  Instructions[$3B] := DEC_SP;
  Instructions[$3C] := INC_A;
  Instructions[$3D] := DEC_A;
  Instructions[$3E] := LD_A_Num;
  Instructions[$3F] := CCF;
  Instructions[$40] := LD_B_B;
  Instructions[$41] := LD_B_C;
  Instructions[$42] := LD_B_D;
  Instructions[$43] := LD_B_E;
  Instructions[$44] := LD_B_H;
  Instructions[$45] := LD_B_L;
  Instructions[$46] := LD_B_MEM;
  Instructions[$47] := LD_B_A;
  Instructions[$48] := LD_C_B;
  Instructions[$49] := LD_C_C;
  Instructions[$4A] := LD_C_D;
  Instructions[$4B] := LD_C_E;
  Instructions[$4C] := LD_C_H;
  Instructions[$4D] := LD_C_L;
  Instructions[$4E] := LD_C_MEM;
  Instructions[$4F] := LD_C_A;
  Instructions[$50] := LD_D_B;
  Instructions[$51] := LD_D_C;
  Instructions[$52] := LD_D_D;
  Instructions[$53] := LD_D_E;
  Instructions[$54] := LD_D_H;
  Instructions[$55] := LD_D_L;
  Instructions[$56] := LD_D_MEM;
  Instructions[$57] := LD_D_A;
  Instructions[$58] := LD_E_B;
  Instructions[$59] := LD_E_C;
  Instructions[$5A] := LD_E_D;
  Instructions[$5B] := LD_E_E;
  Instructions[$5C] := LD_E_H;
  Instructions[$5D] := LD_E_L;
  Instructions[$5E] := LD_E_MEM;
  Instructions[$5F] := LD_E_A;
  Instructions[$60] := LD_H_B;
  Instructions[$61] := LD_H_C;
  Instructions[$62] := LD_H_D;
  Instructions[$63] := LD_H_E;
  Instructions[$64] := LD_H_H;
  Instructions[$65] := LD_H_L;
  Instructions[$66] := LD_H_MEM;
  Instructions[$67] := LD_H_A;
  Instructions[$68] := LD_L_B;
  Instructions[$69] := LD_L_C;
  Instructions[$6A] := LD_L_D;
  Instructions[$6B] := LD_L_E;
  Instructions[$6C] := LD_L_H;
  Instructions[$6D] := LD_L_L;
  Instructions[$6E] := LD_L_MEM;
  Instructions[$6F] := LD_L_A;
  Instructions[$70] := LD_Mem_B;
  Instructions[$71] := LD_Mem_C;
  Instructions[$72] := LD_Mem_D;
  Instructions[$73] := LD_Mem_E;
  Instructions[$74] := LD_Mem_H;
  Instructions[$75] := LD_Mem_L;
  Instructions[$76] := HALT_Z80;
  Instructions[$77] := LD_Mem_A;
  Instructions[$78] := LD_A_B;
  Instructions[$79] := LD_A_C;
  Instructions[$7A] := LD_A_D;
  Instructions[$7B] := LD_A_E;
  Instructions[$7C] := LD_A_H;
  Instructions[$7D] := LD_A_L;
  Instructions[$7E] := LD_A_MEM;
  Instructions[$7F] := LD_A_A;
  Instructions[$80] := ADD_A_B;
  Instructions[$81] := ADD_A_C;
  Instructions[$82] := ADD_A_D;
  Instructions[$83] := ADD_A_E;
  Instructions[$84] := ADD_A_H;
  Instructions[$85] := ADD_A_L;
  Instructions[$86] := ADD_A_MEM;
  Instructions[$87] := ADD_A_A;
  Instructions[$88] := ADC_A_B;
  Instructions[$89] := ADC_A_C;
  Instructions[$8A] := ADC_A_D;
  Instructions[$8B] := ADC_A_E;
  Instructions[$8C] := ADC_A_H;
  Instructions[$8D] := ADC_A_L;
  Instructions[$8E] := ADC_A_MEM;
  Instructions[$8F] := ADC_A_A;
  Instructions[$90] := SUB_B;
  Instructions[$91] := SUB_C;
  Instructions[$92] := SUB_D;
  Instructions[$93] := SUB_E;
  Instructions[$94] := SUB_H;
  Instructions[$95] := SUB_L;
  Instructions[$96] := SUB_MEM;
  Instructions[$97] := SUB_A;
  Instructions[$98] := SBC_A_B;
  Instructions[$99] := SBC_A_C;
  Instructions[$9A] := SBC_A_D;
  Instructions[$9B] := SBC_A_E;
  Instructions[$9C] := SBC_A_H;
  Instructions[$9D] := SBC_A_L;
  Instructions[$9E] := SBC_A_MEM;
  Instructions[$9F] := SBC_A_A;
  Instructions[$A0] := AND_B;
  Instructions[$A1] := AND_C;
  Instructions[$A2] := AND_D;
  Instructions[$A3] := AND_E;
  Instructions[$A4] := AND_H;
  Instructions[$A5] := AND_L;
  Instructions[$A6] := AND_MEM;
  Instructions[$A7] := AND_A;
  Instructions[$A8] := XOR_B;
  Instructions[$A9] := XOR_C;
  Instructions[$AA] := XOR_D;
  Instructions[$AB] := XOR_E;
  Instructions[$AC] := XOR_H;
  Instructions[$AD] := XOR_L;
  Instructions[$AE] := XOR_MEM;
  Instructions[$AF] := XOR_A;
  Instructions[$B0] := OR_B;
  Instructions[$B1] := OR_C;
  Instructions[$B2] := OR_D;
  Instructions[$B3] := OR_E;
  Instructions[$B4] := OR_H;
  Instructions[$B5] := OR_L;
  Instructions[$B6] := OR_MEM;
  Instructions[$B7] := OR_A;
  Instructions[$B8] := CP_B;
  Instructions[$B9] := CP_C;
  Instructions[$BA] := CP_D;
  Instructions[$BB] := CP_E;
  Instructions[$BC] := CP_H;
  Instructions[$BD] := CP_L;
  Instructions[$BE] := CP_MEM;
  Instructions[$BF] := CP_A;
  Instructions[$C0] := RET_NZ;
  Instructions[$C1] := POP_BC;
  Instructions[$C2] := JP_NZ_Addr;
  Instructions[$C3] := JP_Addr;
  Instructions[$C4] := CALL_NZ_Addr;
  Instructions[$C5] := PUSH_BC;
  Instructions[$C6] := ADD_A_Num;
  Instructions[$C7] := RST_0;
  Instructions[$C8] := RET_Z;
  Instructions[$C9] := RET;
  Instructions[$CA] := JP_Z_Addr;
  Instructions[$CB] := BYTE_CB;
  Instructions[$CC] := CALL_Z_Addr;
  Instructions[$CD] := CALL_Addr;
  Instructions[$CE] := ADC_A_Num;
  Instructions[$CF] := RST_8;
  Instructions[$D0] := RET_NC;
  Instructions[$D1] := POP_DE;
  Instructions[$D2] := JP_NC_Addr;
  Instructions[$D3] := OUT_A_PORT;
  Instructions[$D4] := CALL_NC_Addr;
  Instructions[$D5] := PUSH_DE;
  Instructions[$D6] := SUB_Num;
  Instructions[$D7] := RST_16;
  Instructions[$D8] := RET_C;
  Instructions[$D9] := EXX;
  Instructions[$DA] := JP_C_Addr;
  Instructions[$DB] := IN_A_PORT;
  Instructions[$DC] := CALL_C_Addr;
  Instructions[$DD] := Alt_HL_To_IX;
  Instructions[$DE] := SBC_A_Num;
  Instructions[$DF] := RST_24;
  Instructions[$E0] := RET_PO;
  Instructions[$E1] := POP_HL;
  Instructions[$E2] := JP_PO_Addr;
  Instructions[$E3] := EX_SP_HL;
  Instructions[$E4] := CALL_PO_Addr;
  Instructions[$E5] := PUSH_HL;
  Instructions[$E6] := AND_Num;
  Instructions[$E7] := RST_32;
  Instructions[$E8] := RET_PE;
  Instructions[$E9] := JP_HL;
  Instructions[$EA] := JP_PE_Addr;
  Instructions[$EB] := EX_DE_HL;
  Instructions[$EC] := CALL_PE_Addr;
  Instructions[$ED] := BYTE_ED;
  Instructions[$EE] := XOR_Num;
  Instructions[$EF] := RST_40;
  Instructions[$F0] := RET_P;
  Instructions[$F1] := POP_AF;
  Instructions[$F2] := JP_P_Addr;
  Instructions[$F3] := DI;
  Instructions[$F4] := CALL_P_Addr;
  Instructions[$F5] := PUSH_AF;
  Instructions[$F6] := OR_Num;
  Instructions[$F7] := RST_48;
  Instructions[$F8] := RET_N;
  Instructions[$F9] := LD_SP_HL;
  Instructions[$FA] := JP_N_Addr;
  Instructions[$FB] := EI;
  Instructions[$FC] := CALL_N_Addr;
  Instructions[$FD] := Alt_HL_To_IY;
  Instructions[$FE] := CP_Num;
  Instructions[$FF] := RST_56;

  // $CB
  InstructionsCB[$00] := RLC_B;
  InstructionsCB[$01] := RLC_C;
  InstructionsCB[$02] := RLC_D;
  InstructionsCB[$03] := RLC_E;
  InstructionsCB[$04] := RLC_H;
  InstructionsCB[$05] := RLC_L;
  InstructionsCB[$06] := RLC_MEM;
  InstructionsCB[$07] := RLC_A;
  InstructionsCB[$08] := RRC_B;
  InstructionsCB[$09] := RRC_C;
  InstructionsCB[$0A] := RRC_D;
  InstructionsCB[$0B] := RRC_E;
  InstructionsCB[$0C] := RRC_H;
  InstructionsCB[$0D] := RRC_L;
  InstructionsCB[$0E] := RRC_MEM;
  InstructionsCB[$0F] := RRC_A;
  InstructionsCB[$10] := RL_B;
  InstructionsCB[$11] := RL_C;
  InstructionsCB[$12] := RL_D;
  InstructionsCB[$13] := RL_E;
  InstructionsCB[$14] := RL_H;
  InstructionsCB[$15] := RL_L;
  InstructionsCB[$16] := RL_MEM;
  InstructionsCB[$17] := RL_A;
  InstructionsCB[$18] := RR_B;
  InstructionsCB[$19] := RR_C;
  InstructionsCB[$1A] := RR_D;
  InstructionsCB[$1B] := RR_E;
  InstructionsCB[$1C] := RR_H;
  InstructionsCB[$1D] := RR_L;
  InstructionsCB[$1E] := RR_MEM;
  InstructionsCB[$1F] := RR_A;
  InstructionsCB[$20] := SLA_B;
  InstructionsCB[$21] := SLA_C;
  InstructionsCB[$22] := SLA_D;
  InstructionsCB[$23] := SLA_E;
  InstructionsCB[$24] := SLA_H;
  InstructionsCB[$25] := SLA_L;
  InstructionsCB[$26] := SLA_MEM;
  InstructionsCB[$27] := SLA_A;
  InstructionsCB[$28] := SRA_B;
  InstructionsCB[$29] := SRA_C;
  InstructionsCB[$2A] := SRA_D;
  InstructionsCB[$2B] := SRA_E;
  InstructionsCB[$2C] := SRA_H;
  InstructionsCB[$2D] := SRA_L;
  InstructionsCB[$2E] := SRA_MEM;
  InstructionsCB[$2F] := SRA_A;
  InstructionsCB[$30] := SLL_B;
  InstructionsCB[$31] := SLL_C;
  InstructionsCB[$32] := SLL_D;
  InstructionsCB[$33] := SLL_E;
  InstructionsCB[$34] := SLL_H;
  InstructionsCB[$35] := SLL_L;
  InstructionsCB[$36] := SLL_MEM;
  InstructionsCB[$37] := SLL_A;
  InstructionsCB[$38] := SRL_B;
  InstructionsCB[$39] := SRL_C;
  InstructionsCB[$3A] := SRL_D;
  InstructionsCB[$3B] := SRL_E;
  InstructionsCB[$3C] := SRL_H;
  InstructionsCB[$3D] := SRL_L;
  InstructionsCB[$3E] := SRL_MEM;
  InstructionsCB[$3F] := SRL_A;
  InstructionsCB[$40] := BIT_0_B;
  InstructionsCB[$41] := BIT_0_C;
  InstructionsCB[$42] := BIT_0_D;
  InstructionsCB[$43] := BIT_0_E;
  InstructionsCB[$44] := BIT_0_H;
  InstructionsCB[$45] := BIT_0_L;
  InstructionsCB[$46] := BIT_0_MEM;
  InstructionsCB[$47] := BIT_0_A;
  InstructionsCB[$48] := BIT_1_B;
  InstructionsCB[$49] := BIT_1_C;
  InstructionsCB[$4A] := BIT_1_D;
  InstructionsCB[$4B] := BIT_1_E;
  InstructionsCB[$4C] := BIT_1_H;
  InstructionsCB[$4D] := BIT_1_L;
  InstructionsCB[$4E] := BIT_1_MEM;
  InstructionsCB[$4F] := BIT_1_A;
  InstructionsCB[$50] := BIT_2_B;
  InstructionsCB[$51] := BIT_2_C;
  InstructionsCB[$52] := BIT_2_D;
  InstructionsCB[$53] := BIT_2_E;
  InstructionsCB[$54] := BIT_2_H;
  InstructionsCB[$55] := BIT_2_L;
  InstructionsCB[$56] := BIT_2_MEM;
  InstructionsCB[$57] := BIT_2_A;
  InstructionsCB[$58] := BIT_3_B;
  InstructionsCB[$59] := BIT_3_C;
  InstructionsCB[$5A] := BIT_3_D;
  InstructionsCB[$5B] := BIT_3_E;
  InstructionsCB[$5C] := BIT_3_H;
  InstructionsCB[$5D] := BIT_3_L;
  InstructionsCB[$5E] := BIT_3_MEM;
  InstructionsCB[$5F] := BIT_3_A;
  InstructionsCB[$60] := BIT_4_B;
  InstructionsCB[$61] := BIT_4_C;
  InstructionsCB[$62] := BIT_4_D;
  InstructionsCB[$63] := BIT_4_E;
  InstructionsCB[$64] := BIT_4_H;
  InstructionsCB[$65] := BIT_4_L;
  InstructionsCB[$66] := BIT_4_MEM;
  InstructionsCB[$67] := BIT_4_A;
  InstructionsCB[$68] := BIT_5_B;
  InstructionsCB[$69] := BIT_5_C;
  InstructionsCB[$6A] := BIT_5_D;
  InstructionsCB[$6B] := BIT_5_E;
  InstructionsCB[$6C] := BIT_5_H;
  InstructionsCB[$6D] := BIT_5_L;
  InstructionsCB[$6E] := BIT_5_MEM;
  InstructionsCB[$6F] := BIT_5_A;
  InstructionsCB[$70] := BIT_6_B;
  InstructionsCB[$71] := BIT_6_C;
  InstructionsCB[$72] := BIT_6_D;
  InstructionsCB[$73] := BIT_6_E;
  InstructionsCB[$74] := BIT_6_H;
  InstructionsCB[$75] := BIT_6_L;
  InstructionsCB[$76] := BIT_6_MEM;
  InstructionsCB[$77] := BIT_6_A;
  InstructionsCB[$78] := BIT_7_B;
  InstructionsCB[$79] := BIT_7_C;
  InstructionsCB[$7A] := BIT_7_D;
  InstructionsCB[$7B] := BIT_7_E;
  InstructionsCB[$7C] := BIT_7_H;
  InstructionsCB[$7D] := BIT_7_L;
  InstructionsCB[$7E] := BIT_7_MEM;
  InstructionsCB[$7F] := BIT_7_A;
  InstructionsCB[$80] := RES_0_B;
  InstructionsCB[$81] := RES_0_C;
  InstructionsCB[$82] := RES_0_D;
  InstructionsCB[$83] := RES_0_E;
  InstructionsCB[$84] := RES_0_H;
  InstructionsCB[$85] := RES_0_L;
  InstructionsCB[$86] := RES_0_MEM;
  InstructionsCB[$87] := RES_0_A;
  InstructionsCB[$88] := RES_1_B;
  InstructionsCB[$89] := RES_1_C;
  InstructionsCB[$8A] := RES_1_D;
  InstructionsCB[$8B] := RES_1_E;
  InstructionsCB[$8C] := RES_1_H;
  InstructionsCB[$8D] := RES_1_L;
  InstructionsCB[$8E] := RES_1_MEM;
  InstructionsCB[$8F] := RES_1_A;
  InstructionsCB[$90] := RES_2_B;
  InstructionsCB[$91] := RES_2_C;
  InstructionsCB[$92] := RES_2_D;
  InstructionsCB[$93] := RES_2_E;
  InstructionsCB[$94] := RES_2_H;
  InstructionsCB[$95] := RES_2_L;
  InstructionsCB[$96] := RES_2_MEM;
  InstructionsCB[$97] := RES_2_A;
  InstructionsCB[$98] := RES_3_B;
  InstructionsCB[$99] := RES_3_C;
  InstructionsCB[$9A] := RES_3_D;
  InstructionsCB[$9B] := RES_3_E;
  InstructionsCB[$9C] := RES_3_H;
  InstructionsCB[$9D] := RES_3_L;
  InstructionsCB[$9E] := RES_3_MEM;
  InstructionsCB[$9F] := RES_3_A;
  InstructionsCB[$A0] := RES_4_B;
  InstructionsCB[$A1] := RES_4_C;
  InstructionsCB[$A2] := RES_4_D;
  InstructionsCB[$A3] := RES_4_E;
  InstructionsCB[$A4] := RES_4_H;
  InstructionsCB[$A5] := RES_4_L;
  InstructionsCB[$A6] := RES_4_MEM;
  InstructionsCB[$A7] := RES_4_A;
  InstructionsCB[$A8] := RES_5_B;
  InstructionsCB[$A9] := RES_5_C;
  InstructionsCB[$AA] := RES_5_D;
  InstructionsCB[$AB] := RES_5_E;
  InstructionsCB[$AC] := RES_5_H;
  InstructionsCB[$AD] := RES_5_L;
  InstructionsCB[$AE] := RES_5_MEM;
  InstructionsCB[$AF] := RES_5_A;
  InstructionsCB[$B0] := RES_6_B;
  InstructionsCB[$B1] := RES_6_C;
  InstructionsCB[$B2] := RES_6_D;
  InstructionsCB[$B3] := RES_6_E;
  InstructionsCB[$B4] := RES_6_H;
  InstructionsCB[$B5] := RES_6_L;
  InstructionsCB[$B6] := RES_6_MEM;
  InstructionsCB[$B7] := RES_6_A;
  InstructionsCB[$B8] := RES_7_B;
  InstructionsCB[$B9] := RES_7_C;
  InstructionsCB[$BA] := RES_7_D;
  InstructionsCB[$BB] := RES_7_E;
  InstructionsCB[$BC] := RES_7_H;
  InstructionsCB[$BD] := RES_7_L;
  InstructionsCB[$BE] := RES_7_MEM;
  InstructionsCB[$BF] := RES_7_A;
  InstructionsCB[$C0] := SET_0_B;
  InstructionsCB[$C1] := SET_0_C;
  InstructionsCB[$C2] := SET_0_D;
  InstructionsCB[$C3] := SET_0_E;
  InstructionsCB[$C4] := SET_0_H;
  InstructionsCB[$C5] := SET_0_L;
  InstructionsCB[$C6] := SET_0_MEM;
  InstructionsCB[$C7] := SET_0_A;
  InstructionsCB[$C8] := SET_1_B;
  InstructionsCB[$C9] := SET_1_C;
  InstructionsCB[$CA] := SET_1_D;
  InstructionsCB[$CB] := SET_1_E;
  InstructionsCB[$CC] := SET_1_H;
  InstructionsCB[$CD] := SET_1_L;
  InstructionsCB[$CE] := SET_1_MEM;
  InstructionsCB[$CF] := SET_1_A;
  InstructionsCB[$D0] := SET_2_B;
  InstructionsCB[$D1] := SET_2_C;
  InstructionsCB[$D2] := SET_2_D;
  InstructionsCB[$D3] := SET_2_E;
  InstructionsCB[$D4] := SET_2_H;
  InstructionsCB[$D5] := SET_2_L;
  InstructionsCB[$D6] := SET_2_MEM;
  InstructionsCB[$D7] := SET_2_A;
  InstructionsCB[$D8] := SET_3_B;
  InstructionsCB[$D9] := SET_3_C;
  InstructionsCB[$DA] := SET_3_D;
  InstructionsCB[$DB] := SET_3_E;
  InstructionsCB[$DC] := SET_3_H;
  InstructionsCB[$DD] := SET_3_L;
  InstructionsCB[$DE] := SET_3_MEM;
  InstructionsCB[$DF] := SET_3_A;
  InstructionsCB[$E0] := SET_4_B;
  InstructionsCB[$E1] := SET_4_C;
  InstructionsCB[$E2] := SET_4_D;
  InstructionsCB[$E3] := SET_4_E;
  InstructionsCB[$E4] := SET_4_H;
  InstructionsCB[$E5] := SET_4_L;
  InstructionsCB[$E6] := SET_4_MEM;
  InstructionsCB[$E7] := SET_4_A;
  InstructionsCB[$E8] := SET_5_B;
  InstructionsCB[$E9] := SET_5_C;
  InstructionsCB[$EA] := SET_5_D;
  InstructionsCB[$EB] := SET_5_E;
  InstructionsCB[$EC] := SET_5_H;
  InstructionsCB[$ED] := SET_5_L;
  InstructionsCB[$EE] := SET_5_MEM;
  InstructionsCB[$EF] := SET_5_A;
  InstructionsCB[$F0] := SET_6_B;
  InstructionsCB[$F1] := SET_6_C;
  InstructionsCB[$F2] := SET_6_D;
  InstructionsCB[$F3] := SET_6_E;
  InstructionsCB[$F4] := SET_6_H;
  InstructionsCB[$F5] := SET_6_L;
  InstructionsCB[$F6] := SET_6_MEM;
  InstructionsCB[$F7] := SET_6_A;
  InstructionsCB[$F8] := SET_7_B;
  InstructionsCB[$F9] := SET_7_C;
  InstructionsCB[$FA] := SET_7_D;
  InstructionsCB[$FB] := SET_7_E;
  InstructionsCB[$FC] := SET_7_H;
  InstructionsCB[$FD] := SET_7_L;
  InstructionsCB[$FE] := SET_7_MEM;
  InstructionsCB[$FF] := SET_7_A;

  // $DD/$FD $CB
  InstructionsIDX_CB[$00] := LD_B_RLC_IDX_Num; // DD/FD CB NUM 00
  InstructionsIDX_CB[$01] := LD_C_RLC_IDX_Num; // DD/FD CB NUM 01
  InstructionsIDX_CB[$02] := LD_D_RLC_IDX_Num; // DD/FD CB NUM 02
  InstructionsIDX_CB[$03] := LD_E_RLC_IDX_Num; // DD/FD CB NUM 03
  InstructionsIDX_CB[$04] := LD_H_RLC_IDX_Num; // DD/FD CB NUM 04
  InstructionsIDX_CB[$05] := LD_L_RLC_IDX_Num; // DD/FD CB NUM 05
  InstructionsIDX_CB[$06] := RLC_IDX_Num; // DD/FD CB NUM 06
  InstructionsIDX_CB[$07] := LD_A_RLC_IDX_Num; // DD/FD CB NUM 07
  InstructionsIDX_CB[$08] := LD_B_RRC_IDX_Num; // DD/FD CB NUM 08
  InstructionsIDX_CB[$09] := LD_C_RRC_IDX_Num; // DD/FD CB NUM 09
  InstructionsIDX_CB[$0A] := LD_D_RRC_IDX_Num; // DD/FD CB NUM 0A
  InstructionsIDX_CB[$0B] := LD_E_RRC_IDX_Num; // DD/FD CB NUM 0B
  InstructionsIDX_CB[$0C] := LD_H_RRC_IDX_Num; // DD/FD CB NUM 0C
  InstructionsIDX_CB[$0D] := LD_L_RRC_IDX_Num; // DD/FD CB NUM 0D
  InstructionsIDX_CB[$0E] := RRC_IDX_Num; // DD/FD CB NUM 0E
  InstructionsIDX_CB[$0F] := LD_A_RRC_IDX_Num; // DD/FD CB NUM 0F
  InstructionsIDX_CB[$10] := LD_B_RL_IDX_Num; // DD/FD CB NUM 10
  InstructionsIDX_CB[$11] := LD_C_RL_IDX_Num; // DD/FD CB NUM 11
  InstructionsIDX_CB[$12] := LD_D_RL_IDX_Num; // DD/FD CB NUM 12
  InstructionsIDX_CB[$13] := LD_E_RL_IDX_Num; // DD/FD CB NUM 13
  InstructionsIDX_CB[$14] := LD_H_RL_IDX_Num; // DD/FD CB NUM 14
  InstructionsIDX_CB[$15] := LD_L_RL_IDX_Num; // DD/FD CB NUM 15
  InstructionsIDX_CB[$16] := RL_IDX_Num; // DD/FD CB NUM 16
  InstructionsIDX_CB[$17] := LD_A_RL_IDX_Num; // DD/FD CB NUM 17
  InstructionsIDX_CB[$18] := LD_B_RR_IDX_Num; // DD/FD CB NUM 18
  InstructionsIDX_CB[$19] := LD_C_RR_IDX_Num; // DD/FD CB NUM 19
  InstructionsIDX_CB[$1A] := LD_D_RR_IDX_Num; // DD/FD CB NUM 1A
  InstructionsIDX_CB[$1B] := LD_E_RR_IDX_Num; // DD/FD CB NUM 1B
  InstructionsIDX_CB[$1C] := LD_H_RR_IDX_Num; // DD/FD CB NUM 1C
  InstructionsIDX_CB[$1D] := LD_L_RR_IDX_Num; // DD/FD CB NUM 1D
  InstructionsIDX_CB[$1E] := RR_IDX_Num; // DD/FD CB NUM 1E
  InstructionsIDX_CB[$1F] := LD_A_RR_IDX_Num; // DD/FD CB NUM 1F
  InstructionsIDX_CB[$20] := LD_B_SLA_IDX_Num; // DD/FD CB NUM 20
  InstructionsIDX_CB[$21] := LD_C_SLA_IDX_Num; // DD/FD CB NUM 21
  InstructionsIDX_CB[$22] := LD_D_SLA_IDX_Num; // DD/FD CB NUM 22
  InstructionsIDX_CB[$23] := LD_E_SLA_IDX_Num; // DD/FD CB NUM 23
  InstructionsIDX_CB[$24] := LD_H_SLA_IDX_Num; // DD/FD CB NUM 24
  InstructionsIDX_CB[$25] := LD_L_SLA_IDX_Num; // DD/FD CB NUM 25
  InstructionsIDX_CB[$26] := SLA_IDX_Num; // DD/FD CB NUM 26
  InstructionsIDX_CB[$27] := LD_A_SLA_IDX_Num; // DD/FD CB NUM 27
  InstructionsIDX_CB[$28] := LD_B_SRA_IDX_Num; // DD/FD CB NUM 28
  InstructionsIDX_CB[$29] := LD_C_SRA_IDX_Num; // DD/FD CB NUM 29
  InstructionsIDX_CB[$2A] := LD_D_SRA_IDX_Num; // DD/FD CB NUM 2A
  InstructionsIDX_CB[$2B] := LD_E_SRA_IDX_Num; // DD/FD CB NUM 2B
  InstructionsIDX_CB[$2C] := LD_H_SRA_IDX_Num; // DD/FD CB NUM 2C
  InstructionsIDX_CB[$2D] := LD_L_SRA_IDX_Num; // DD/FD CB NUM 2D
  InstructionsIDX_CB[$2E] := SRA_IDX_Num; // DD/FD CB NUM 2E
  InstructionsIDX_CB[$2F] := LD_A_SRA_IDX_Num; // DD/FD CB NUM 2F
  InstructionsIDX_CB[$30] := LD_B_SLL_IDX_Num; // DD/FD CB NUM 30
  InstructionsIDX_CB[$31] := LD_C_SLL_IDX_Num; // DD/FD CB NUM 31
  InstructionsIDX_CB[$32] := LD_D_SLL_IDX_Num; // DD/FD CB NUM 32
  InstructionsIDX_CB[$33] := LD_E_SLL_IDX_Num; // DD/FD CB NUM 33
  InstructionsIDX_CB[$34] := LD_H_SLL_IDX_Num; // DD/FD CB NUM 34
  InstructionsIDX_CB[$35] := LD_L_SLL_IDX_Num; // DD/FD CB NUM 35
  InstructionsIDX_CB[$36] := SLL_IDX_Num; // DD/FD CB NUM 36
  InstructionsIDX_CB[$37] := LD_A_SLL_IDX_Num; // DD/FD CB NUM 37
  InstructionsIDX_CB[$38] := LD_B_SRL_IDX_Num; // DD/FD CB NUM 38
  InstructionsIDX_CB[$39] := LD_C_SRL_IDX_Num; // DD/FD CB NUM 39
  InstructionsIDX_CB[$3A] := LD_D_SRL_IDX_Num; // DD/FD CB NUM 3A
  InstructionsIDX_CB[$3B] := LD_E_SRL_IDX_Num; // DD/FD CB NUM 3B
  InstructionsIDX_CB[$3C] := LD_H_SRL_IDX_Num; // DD/FD CB NUM 3C
  InstructionsIDX_CB[$3D] := LD_L_SRL_IDX_Num; // DD/FD CB NUM 3D
  InstructionsIDX_CB[$3E] := SRL_IDX_Num; // DD/FD CB NUM 3E
  InstructionsIDX_CB[$3F] := LD_A_SRL_IDX_Num; // DD/FD CB NUM 3F
  InstructionsIDX_CB[$40] := BIT_0_IDX_Num_0; // DD/FD CB NUM 40
  InstructionsIDX_CB[$41] := BIT_0_IDX_Num_1; // DD/FD CB NUM 41
  InstructionsIDX_CB[$42] := BIT_0_IDX_Num_2; // DD/FD CB NUM 42
  InstructionsIDX_CB[$43] := BIT_0_IDX_Num_3; // DD/FD CB NUM 43
  InstructionsIDX_CB[$44] := BIT_0_IDX_Num_4; // DD/FD CB NUM 44
  InstructionsIDX_CB[$45] := BIT_0_IDX_Num_5; // DD/FD CB NUM 45
  InstructionsIDX_CB[$46] := BIT_0_IDX_Num; // DD/FD CB NUM 46
  InstructionsIDX_CB[$47] := BIT_0_IDX_Num_7; // DD/FD CB NUM 47
  InstructionsIDX_CB[$48] := BIT_1_IDX_Num_0; // DD/FD CB NUM 48
  InstructionsIDX_CB[$49] := BIT_1_IDX_Num_1; // DD/FD CB NUM 49
  InstructionsIDX_CB[$4A] := BIT_1_IDX_Num_2; // DD/FD CB NUM 4A
  InstructionsIDX_CB[$4B] := BIT_1_IDX_Num_3; // DD/FD CB NUM 4B
  InstructionsIDX_CB[$4C] := BIT_1_IDX_Num_4; // DD/FD CB NUM 4C
  InstructionsIDX_CB[$4D] := BIT_1_IDX_Num_5; // DD/FD CB NUM 4D
  InstructionsIDX_CB[$4E] := BIT_1_IDX_Num; // DD/FD CB NUM 4E
  InstructionsIDX_CB[$4F] := BIT_1_IDX_Num_7; // DD/FD CB NUM 4F
  InstructionsIDX_CB[$50] := BIT_2_IDX_Num_0; // DD/FD CB NUM 50
  InstructionsIDX_CB[$51] := BIT_2_IDX_Num_1; // DD/FD CB NUM 51
  InstructionsIDX_CB[$52] := BIT_2_IDX_Num_2; // DD/FD CB NUM 52
  InstructionsIDX_CB[$53] := BIT_2_IDX_Num_3; // DD/FD CB NUM 53
  InstructionsIDX_CB[$54] := BIT_2_IDX_Num_4; // DD/FD CB NUM 54
  InstructionsIDX_CB[$55] := BIT_2_IDX_Num_5; // DD/FD CB NUM 55
  InstructionsIDX_CB[$56] := BIT_2_IDX_Num; // DD/FD CB NUM 56
  InstructionsIDX_CB[$57] := BIT_2_IDX_Num_7; // DD/FD CB NUM 57
  InstructionsIDX_CB[$58] := BIT_3_IDX_Num_0; // DD/FD CB NUM 58
  InstructionsIDX_CB[$59] := BIT_3_IDX_Num_1; // DD/FD CB NUM 59
  InstructionsIDX_CB[$5A] := BIT_3_IDX_Num_2; // DD/FD CB NUM 5A
  InstructionsIDX_CB[$5B] := BIT_3_IDX_Num_3; // DD/FD CB NUM 5B
  InstructionsIDX_CB[$5C] := BIT_3_IDX_Num_4; // DD/FD CB NUM 5C
  InstructionsIDX_CB[$5D] := BIT_3_IDX_Num_5; // DD/FD CB NUM 5D
  InstructionsIDX_CB[$5E] := BIT_3_IDX_Num; // DD/FD CB NUM 5E
  InstructionsIDX_CB[$5F] := BIT_3_IDX_Num_7; // DD/FD CB NUM 5F
  InstructionsIDX_CB[$60] := BIT_4_IDX_Num_0; // DD/FD CB NUM 60
  InstructionsIDX_CB[$61] := BIT_4_IDX_Num_1; // DD/FD CB NUM 61
  InstructionsIDX_CB[$62] := BIT_4_IDX_Num_2; // DD/FD CB NUM 62
  InstructionsIDX_CB[$63] := BIT_4_IDX_Num_3; // DD/FD CB NUM 63
  InstructionsIDX_CB[$64] := BIT_4_IDX_Num_4; // DD/FD CB NUM 64
  InstructionsIDX_CB[$65] := BIT_4_IDX_Num_5; // DD/FD CB NUM 65
  InstructionsIDX_CB[$66] := BIT_4_IDX_Num; // DD/FD CB NUM 66
  InstructionsIDX_CB[$67] := BIT_4_IDX_Num_7; // DD/FD CB NUM 67
  InstructionsIDX_CB[$68] := BIT_5_IDX_Num_0; // DD/FD CB NUM 68
  InstructionsIDX_CB[$69] := BIT_5_IDX_Num_1; // DD/FD CB NUM 69
  InstructionsIDX_CB[$6A] := BIT_5_IDX_Num_2; // DD/FD CB NUM 6A
  InstructionsIDX_CB[$6B] := BIT_5_IDX_Num_3; // DD/FD CB NUM 6B
  InstructionsIDX_CB[$6C] := BIT_5_IDX_Num_4; // DD/FD CB NUM 6C
  InstructionsIDX_CB[$6D] := BIT_5_IDX_Num_5; // DD/FD CB NUM 6D
  InstructionsIDX_CB[$6E] := BIT_5_IDX_Num; // DD/FD CB NUM 6E
  InstructionsIDX_CB[$6F] := BIT_5_IDX_Num_7; // DD/FD CB NUM 6F
  InstructionsIDX_CB[$70] := BIT_6_IDX_Num_0; // DD/FD CB NUM 70
  InstructionsIDX_CB[$71] := BIT_6_IDX_Num_1; // DD/FD CB NUM 71
  InstructionsIDX_CB[$72] := BIT_6_IDX_Num_2; // DD/FD CB NUM 72
  InstructionsIDX_CB[$73] := BIT_6_IDX_Num_3; // DD/FD CB NUM 73
  InstructionsIDX_CB[$74] := BIT_6_IDX_Num_4; // DD/FD CB NUM 74
  InstructionsIDX_CB[$75] := BIT_6_IDX_Num_5; // DD/FD CB NUM 75
  InstructionsIDX_CB[$76] := BIT_6_IDX_Num; // DD/FD CB NUM 76
  InstructionsIDX_CB[$77] := BIT_6_IDX_Num_7; // DD/FD CB NUM 77
  InstructionsIDX_CB[$78] := BIT_7_IDX_Num_0; // DD/FD CB NUM 78
  InstructionsIDX_CB[$79] := BIT_7_IDX_Num_1; // DD/FD CB NUM 79
  InstructionsIDX_CB[$7A] := BIT_7_IDX_Num_2; // DD/FD CB NUM 7A
  InstructionsIDX_CB[$7B] := BIT_7_IDX_Num_3; // DD/FD CB NUM 7B
  InstructionsIDX_CB[$7C] := BIT_7_IDX_Num_4; // DD/FD CB NUM 7C
  InstructionsIDX_CB[$7D] := BIT_7_IDX_Num_5; // DD/FD CB NUM 7D
  InstructionsIDX_CB[$7E] := BIT_7_IDX_Num; // DD/FD CB NUM 7E
  InstructionsIDX_CB[$7F] := BIT_7_IDX_Num_7; // DD/FD CB NUM 7F
  InstructionsIDX_CB[$80] := LD_B_RES_0_IDX_Num; // DD/FD CB NUM 80
  InstructionsIDX_CB[$81] := LD_C_RES_0_IDX_Num; // DD/FD CB NUM 81
  InstructionsIDX_CB[$82] := LD_D_RES_0_IDX_Num; // DD/FD CB NUM 82
  InstructionsIDX_CB[$83] := LD_E_RES_0_IDX_Num; // DD/FD CB NUM 83
  InstructionsIDX_CB[$84] := LD_H_RES_0_IDX_Num; // DD/FD CB NUM 84
  InstructionsIDX_CB[$85] := LD_L_RES_0_IDX_Num; // DD/FD CB NUM 85
  InstructionsIDX_CB[$86] := RES_0_IDX_Num; // DD/FD CB NUM 86
  InstructionsIDX_CB[$87] := LD_A_RES_0_IDX_Num; // DD/FD CB NUM 87
  InstructionsIDX_CB[$88] := LD_B_RES_1_IDX_Num; // DD/FD CB NUM 88
  InstructionsIDX_CB[$89] := LD_C_RES_1_IDX_Num; // DD/FD CB NUM 89
  InstructionsIDX_CB[$8A] := LD_D_RES_1_IDX_Num; // DD/FD CB NUM 8A
  InstructionsIDX_CB[$8B] := LD_E_RES_1_IDX_Num; // DD/FD CB NUM 8B
  InstructionsIDX_CB[$8C] := LD_H_RES_1_IDX_Num; // DD/FD CB NUM 8C
  InstructionsIDX_CB[$8D] := LD_L_RES_1_IDX_Num; // DD/FD CB NUM 8D
  InstructionsIDX_CB[$8E] := RES_1_IDX_Num; // DD/FD CB NUM 8E
  InstructionsIDX_CB[$8F] := LD_A_RES_1_IDX_Num; // DD/FD CB NUM 8F
  InstructionsIDX_CB[$90] := LD_B_RES_2_IDX_Num; // DD/FD CB NUM 90
  InstructionsIDX_CB[$91] := LD_C_RES_2_IDX_Num; // DD/FD CB NUM 91
  InstructionsIDX_CB[$92] := LD_D_RES_2_IDX_Num; // DD/FD CB NUM 92
  InstructionsIDX_CB[$93] := LD_E_RES_2_IDX_Num; // DD/FD CB NUM 93
  InstructionsIDX_CB[$94] := LD_H_RES_2_IDX_Num; // DD/FD CB NUM 94
  InstructionsIDX_CB[$95] := LD_L_RES_2_IDX_Num; // DD/FD CB NUM 95
  InstructionsIDX_CB[$96] := RES_2_IDX_Num; // DD/FD CB NUM 96
  InstructionsIDX_CB[$97] := LD_A_RES_2_IDX_Num; // DD/FD CB NUM 97
  InstructionsIDX_CB[$98] := LD_B_RES_3_IDX_Num; // DD/FD CB NUM 98
  InstructionsIDX_CB[$99] := LD_C_RES_3_IDX_Num; // DD/FD CB NUM 99
  InstructionsIDX_CB[$9A] := LD_D_RES_3_IDX_Num; // DD/FD CB NUM 9A
  InstructionsIDX_CB[$9B] := LD_E_RES_3_IDX_Num; // DD/FD CB NUM 9B
  InstructionsIDX_CB[$9C] := LD_H_RES_3_IDX_Num; // DD/FD CB NUM 9C
  InstructionsIDX_CB[$9D] := LD_L_RES_3_IDX_Num; // DD/FD CB NUM 9D
  InstructionsIDX_CB[$9E] := RES_3_IDX_Num; // DD/FD CB NUM 9E
  InstructionsIDX_CB[$9F] := LD_A_RES_3_IDX_Num; // DD/FD CB NUM 9F
  InstructionsIDX_CB[$A0] := LD_B_RES_4_IDX_Num; // DD/FD CB NUM A0
  InstructionsIDX_CB[$A1] := LD_C_RES_4_IDX_Num; // DD/FD CB NUM A1
  InstructionsIDX_CB[$A2] := LD_D_RES_4_IDX_Num; // DD/FD CB NUM A2
  InstructionsIDX_CB[$A3] := LD_E_RES_4_IDX_Num; // DD/FD CB NUM A3
  InstructionsIDX_CB[$A4] := LD_H_RES_4_IDX_Num; // DD/FD CB NUM A4
  InstructionsIDX_CB[$A5] := LD_L_RES_4_IDX_Num; // DD/FD CB NUM A5
  InstructionsIDX_CB[$A6] := RES_4_IDX_Num; // DD/FD CB NUM A6
  InstructionsIDX_CB[$A7] := LD_A_RES_4_IDX_Num; // DD/FD CB NUM A7
  InstructionsIDX_CB[$A8] := LD_B_RES_5_IDX_Num; // DD/FD CB NUM A8
  InstructionsIDX_CB[$A9] := LD_C_RES_5_IDX_Num; // DD/FD CB NUM A9
  InstructionsIDX_CB[$AA] := LD_D_RES_5_IDX_Num; // DD/FD CB NUM AA
  InstructionsIDX_CB[$AB] := LD_E_RES_5_IDX_Num; // DD/FD CB NUM AB
  InstructionsIDX_CB[$AC] := LD_H_RES_5_IDX_Num; // DD/FD CB NUM AC
  InstructionsIDX_CB[$AD] := LD_L_RES_5_IDX_Num; // DD/FD CB NUM AD
  InstructionsIDX_CB[$AE] := RES_5_IDX_Num; // DD/FD CB NUM AE
  InstructionsIDX_CB[$AF] := LD_A_RES_5_IDX_Num; // DD/FD CB NUM AF
  InstructionsIDX_CB[$B0] := LD_B_RES_6_IDX_Num; // DD/FD CB NUM B0
  InstructionsIDX_CB[$B1] := LD_C_RES_6_IDX_Num; // DD/FD CB NUM B1
  InstructionsIDX_CB[$B2] := LD_D_RES_6_IDX_Num; // DD/FD CB NUM B2
  InstructionsIDX_CB[$B3] := LD_E_RES_6_IDX_Num; // DD/FD CB NUM B3
  InstructionsIDX_CB[$B4] := LD_H_RES_6_IDX_Num; // DD/FD CB NUM B4
  InstructionsIDX_CB[$B5] := LD_L_RES_6_IDX_Num; // DD/FD CB NUM B5
  InstructionsIDX_CB[$B6] := RES_6_IDX_Num; // DD/FD CB NUM B6
  InstructionsIDX_CB[$B7] := LD_A_RES_6_IDX_Num; // DD/FD CB NUM B7
  InstructionsIDX_CB[$B8] := LD_B_RES_7_IDX_Num; // DD/FD CB NUM B8
  InstructionsIDX_CB[$B9] := LD_C_RES_7_IDX_Num; // DD/FD CB NUM B9
  InstructionsIDX_CB[$BA] := LD_D_RES_7_IDX_Num; // DD/FD CB NUM BA
  InstructionsIDX_CB[$BB] := LD_E_RES_7_IDX_Num; // DD/FD CB NUM BB
  InstructionsIDX_CB[$BC] := LD_H_RES_7_IDX_Num; // DD/FD CB NUM BC
  InstructionsIDX_CB[$BD] := LD_L_RES_7_IDX_Num; // DD/FD CB NUM BD
  InstructionsIDX_CB[$BE] := RES_7_IDX_Num; // DD/FD CB NUM BE
  InstructionsIDX_CB[$BF] := LD_A_RES_7_IDX_Num; // DD/FD CB NUM BF
  InstructionsIDX_CB[$C0] := LD_B_SET_0_IDX_Num; // DD/FD CB NUM C0
  InstructionsIDX_CB[$C1] := LD_C_SET_0_IDX_Num; // DD/FD CB NUM C1
  InstructionsIDX_CB[$C2] := LD_D_SET_0_IDX_Num; // DD/FD CB NUM C2
  InstructionsIDX_CB[$C3] := LD_E_SET_0_IDX_Num; // DD/FD CB NUM C3
  InstructionsIDX_CB[$C4] := LD_H_SET_0_IDX_Num; // DD/FD CB NUM C4
  InstructionsIDX_CB[$C5] := LD_L_SET_0_IDX_Num; // DD/FD CB NUM C5
  InstructionsIDX_CB[$C6] := SET_0_IDX_Num; // DD/FD CB NUM C6
  InstructionsIDX_CB[$C7] := LD_A_SET_0_IDX_Num; // DD/FD CB NUM C7
  InstructionsIDX_CB[$C8] := LD_B_SET_1_IDX_Num; // DD/FD CB NUM C8
  InstructionsIDX_CB[$C9] := LD_C_SET_1_IDX_Num; // DD/FD CB NUM C9
  InstructionsIDX_CB[$CA] := LD_D_SET_1_IDX_Num; // DD/FD CB NUM CA
  InstructionsIDX_CB[$CB] := LD_E_SET_1_IDX_Num; // DD/FD CB NUM CB
  InstructionsIDX_CB[$CC] := LD_H_SET_1_IDX_Num; // DD/FD CB NUM CC
  InstructionsIDX_CB[$CD] := LD_L_SET_1_IDX_Num; // DD/FD CB NUM CD
  InstructionsIDX_CB[$CE] := SET_1_IDX_Num; // DD/FD CB NUM CE
  InstructionsIDX_CB[$CF] := LD_A_SET_1_IDX_Num; // DD/FD CB NUM CF
  InstructionsIDX_CB[$D0] := LD_B_SET_2_IDX_Num; // DD/FD CB NUM D0
  InstructionsIDX_CB[$D1] := LD_C_SET_2_IDX_Num; // DD/FD CB NUM D1
  InstructionsIDX_CB[$D2] := LD_D_SET_2_IDX_Num; // DD/FD CB NUM D2
  InstructionsIDX_CB[$D3] := LD_E_SET_2_IDX_Num; // DD/FD CB NUM D3
  InstructionsIDX_CB[$D4] := LD_H_SET_2_IDX_Num; // DD/FD CB NUM D4
  InstructionsIDX_CB[$D5] := LD_L_SET_2_IDX_Num; // DD/FD CB NUM D5
  InstructionsIDX_CB[$D6] := SET_2_IDX_Num; // DD/FD CB NUM D6
  InstructionsIDX_CB[$D7] := LD_A_SET_2_IDX_Num; // DD/FD CB NUM D7
  InstructionsIDX_CB[$D8] := LD_B_SET_3_IDX_Num; // DD/FD CB NUM D8
  InstructionsIDX_CB[$D9] := LD_C_SET_3_IDX_Num; // DD/FD CB NUM D9
  InstructionsIDX_CB[$DA] := LD_D_SET_3_IDX_Num; // DD/FD CB NUM DA
  InstructionsIDX_CB[$DB] := LD_E_SET_3_IDX_Num; // DD/FD CB NUM DB
  InstructionsIDX_CB[$DC] := LD_H_SET_3_IDX_Num; // DD/FD CB NUM DC
  InstructionsIDX_CB[$DD] := LD_L_SET_3_IDX_Num; // DD/FD CB NUM DD
  InstructionsIDX_CB[$DE] := SET_3_IDX_Num; // DD/FD CB NUM DE
  InstructionsIDX_CB[$DF] := LD_A_SET_3_IDX_Num; // DD/FD CB NUM DF
  InstructionsIDX_CB[$E0] := LD_B_SET_4_IDX_Num; // DD/FD CB NUM E0
  InstructionsIDX_CB[$E1] := LD_C_SET_4_IDX_Num; // DD/FD CB NUM E1
  InstructionsIDX_CB[$E2] := LD_D_SET_4_IDX_Num; // DD/FD CB NUM E2
  InstructionsIDX_CB[$E3] := LD_E_SET_4_IDX_Num; // DD/FD CB NUM E3
  InstructionsIDX_CB[$E4] := LD_H_SET_4_IDX_Num; // DD/FD CB NUM E4
  InstructionsIDX_CB[$E5] := LD_L_SET_4_IDX_Num; // DD/FD CB NUM E5
  InstructionsIDX_CB[$E6] := SET_4_IDX_Num; // DD/FD CB NUM E6
  InstructionsIDX_CB[$E7] := LD_A_SET_4_IDX_Num; // DD/FD CB NUM E7
  InstructionsIDX_CB[$E8] := LD_B_SET_5_IDX_Num; // DD/FD CB NUM E8
  InstructionsIDX_CB[$E9] := LD_C_SET_5_IDX_Num; // DD/FD CB NUM E9
  InstructionsIDX_CB[$EA] := LD_D_SET_5_IDX_Num; // DD/FD CB NUM EA
  InstructionsIDX_CB[$EB] := LD_E_SET_5_IDX_Num; // DD/FD CB NUM EB
  InstructionsIDX_CB[$EC] := LD_H_SET_5_IDX_Num; // DD/FD CB NUM EC
  InstructionsIDX_CB[$ED] := LD_L_SET_5_IDX_Num; // DD/FD CB NUM ED
  InstructionsIDX_CB[$EE] := SET_5_IDX_Num; // DD/FD CB NUM EE
  InstructionsIDX_CB[$EF] := LD_A_SET_5_IDX_Num; // DD/FD CB NUM EF
  InstructionsIDX_CB[$F0] := LD_B_SET_6_IDX_Num; // DD/FD CB NUM F0
  InstructionsIDX_CB[$F1] := LD_C_SET_6_IDX_Num; // DD/FD CB NUM F1
  InstructionsIDX_CB[$F2] := LD_D_SET_6_IDX_Num; // DD/FD CB NUM F2
  InstructionsIDX_CB[$F3] := LD_E_SET_6_IDX_Num; // DD/FD CB NUM F3
  InstructionsIDX_CB[$F4] := LD_H_SET_6_IDX_Num; // DD/FD CB NUM F4
  InstructionsIDX_CB[$F5] := LD_L_SET_6_IDX_Num; // DD/FD CB NUM F5
  InstructionsIDX_CB[$F6] := SET_6_IDX_Num; // DD/FD CB NUM F6
  InstructionsIDX_CB[$F7] := LD_A_SET_6_IDX_Num; // DD/FD CB NUM F7
  InstructionsIDX_CB[$F8] := LD_B_SET_7_IDX_Num; // DD/FD CB NUM F8
  InstructionsIDX_CB[$F9] := LD_C_SET_7_IDX_Num; // DD/FD CB NUM F9
  InstructionsIDX_CB[$FA] := LD_D_SET_7_IDX_Num; // DD/FD CB NUM FA
  InstructionsIDX_CB[$FB] := LD_E_SET_7_IDX_Num; // DD/FD CB NUM FB
  InstructionsIDX_CB[$FC] := LD_H_SET_7_IDX_Num; // DD/FD CB NUM FC
  InstructionsIDX_CB[$FD] := LD_L_SET_7_IDX_Num; // DD/FD CB NUM FD
  InstructionsIDX_CB[$FE] := SET_7_IDX_Num; // DD/FD CB NUM FE
  InstructionsIDX_CB[$FF] := LD_A_SET_7_IDX_Num; // DD/FD CB NUM FF

  // $ED
  for Cnt := Low(InstructionsED) to High(InstructionsED) do
    InstructionsED[Cnt] := IGNORE_ED;

  InstructionsED[$40] := IN_B_C;
  InstructionsED[$41] := OUT_C_B;
  InstructionsED[$42] := SBC_HL_BC;
  InstructionsED[$43] := LD_Addr_BC;
  InstructionsED[$44] := NEG;
  InstructionsED[$45] := RETN;
  InstructionsED[$46] := IM_0;
  InstructionsED[$47] := LD_I_A;
  InstructionsED[$48] := IN_C_C;
  InstructionsED[$49] := OUT_C_C;
  InstructionsED[$4A] := ADC_HL_BC;
  InstructionsED[$4B] := LD_BC_Addr;
  InstructionsED[$4D] := RETI;
  InstructionsED[$4F] := LD_R_A;
  InstructionsED[$50] := IN_D_C;
  InstructionsED[$51] := OUT_C_D;
  InstructionsED[$52] := SBC_HL_DE;
  InstructionsED[$53] := LD_Addr_DE;
  InstructionsED[$56] := IM_1;
  InstructionsED[$57] := LD_A_I;
  InstructionsED[$58] := IN_E_C;
  InstructionsED[$59] := OUT_C_E;
  InstructionsED[$5A] := ADC_HL_DE;
  InstructionsED[$5B] := LD_DE_Addr;
  InstructionsED[$5E] := IM_2;
  InstructionsED[$5F] := LD_A_R;
  InstructionsED[$60] := IN_H_C;
  InstructionsED[$61] := OUT_C_H;
  InstructionsED[$62] := SBC_HL_HL;
  InstructionsED[$63] := LD_Addr_HL_2;
  InstructionsED[$67] := RRD;
  InstructionsED[$68] := IN_L_C;
  InstructionsED[$69] := OUT_C_L;
  InstructionsED[$6A] := ADC_HL_HL;
  InstructionsED[$6B] := LD_HL_Addr_2;
  InstructionsED[$6F] := RLD;
  InstructionsED[$72] := SBC_HL_SP;
  InstructionsED[$73] := LD_Addr_SP;
  InstructionsED[$78] := IN_A_C;
  InstructionsED[$79] := OUT_C_A;
  InstructionsED[$7A] := ADC_HL_SP;
  InstructionsED[$7B] := LD_SP_Addr;
  InstructionsED[$A0] := LDI;
  InstructionsED[$A1] := CPI;
  InstructionsED[$A2] := INI;
  InstructionsED[$A3] := OUTI;
  InstructionsED[$A8] := LDD;
  InstructionsED[$A9] := CPD;
  InstructionsED[$AA] := IND;
  InstructionsED[$AB] := OUTD;
  InstructionsED[$B0] := LDIR;
  InstructionsED[$B1] := CPIR;
  InstructionsED[$B8] := LDDR;
  InstructionsED[$B9] := CPDR;
  InstructionsED[$BA] := INDR;
  InstructionsED[$B2] := INIR;
  InstructionsED[$B3] := OTIR;
  InstructionsED[$BB] := OTDR;

  // $ED (HD 64180)
  InstructionsED[$00] := IN0_B_PORT;
  InstructionsED[$01] := OUT0_PORT_B;
  InstructionsED[$04] := TST_B;
  InstructionsED[$08] := IN0_C_PORT;
  InstructionsED[$09] := OUT0_PORT_C;
  InstructionsED[$0C] := TST_C;
  InstructionsED[$10] := IN0_D_PORT;
  InstructionsED[$11] := OUT0_PORT_D;
  InstructionsED[$14] := TST_D;
  InstructionsED[$18] := IN0_E_PORT;
  InstructionsED[$19] := OUT0_PORT_E;
  InstructionsED[$1C] := TST_E;
  InstructionsED[$20] := IN0_H_PORT;
  InstructionsED[$21] := OUT0_PORT_H;
  InstructionsED[$24] := TST_H;
  InstructionsED[$28] := IN0_L_PORT;
  InstructionsED[$29] := OUT0_PORT_L;
  InstructionsED[$2C] := TST_L;
  InstructionsED[$30] := IN0_PORT;
  InstructionsED[$34] := TST_MEM;
  InstructionsED[$38] := IN0_A_PORT;
  InstructionsED[$39] := OUT0_PORT_A;
  InstructionsED[$3C] := TST_A;
  InstructionsED[$4C] := MULT_BC;
  InstructionsED[$5C] := MULT_DE;
  InstructionsED[$64] := TST_Num;
  InstructionsED[$6C] := MULT_HL;
  InstructionsED[$70] := IN_C;
  InstructionsED[$71] := OUT_C_0;
  InstructionsED[$74] := TSTIO_Num;
  InstructionsED[$76] := SLP;
  InstructionsED[$7C] := MULT_SP;
  InstructionsED[$83] := OTIM;
  InstructionsED[$8B] := OTDM;
  InstructionsED[$93] := OTIMR;
  InstructionsED[$9B] := OTDMR;
end;

procedure TCPUZ80.Execute;
//var
//  elapsed: TLargeInteger;
begin
  FDisasmPrevious := EmptyStr;
  TheEnd := False;
  //elapsed := HPCounter.ReadInt() + 50;

  try
    while not Terminated do
    begin
      if FExecReset then
        Synchronize(ExecReset);

      if FHalted then
        Suspend
      else
      begin
        if not (FHalted or FStopped) then
        begin
          if FExecHalt then
            Synchronize(ExecHalt)
          else
          begin
            if FExecNMI then
              Synchronize(ExecNMI);

            if FExecMI and (IM <> 0) then
              Synchronize(ExecMI)
            else //if HPCounter.ReadInt() >= elapsed then
            begin
              //elapsed := HPCounter.ReadInt() + 50;

              if not FStopped then
                //Synchronize(Step);
                Step;
            end
              //else
              //  Application.ProcessMessages
              ;

            //Delay(1);
            Sleep(0);
          end;
        end;
      end;
    end;
  finally
    TheEnd := True;
  end;
end;

procedure TCPUZ80.ExecHalt;
begin
  FHalted := True;
  FExecHalt := False;

  if Assigned(FOnHalt) then
    FOnHalt(Self);
end;

procedure TCPUZ80.Halt;
begin
  FExecHalt := True;
end;

procedure TCPUZ80.ExecReset;
var
  FStp: Boolean;
  Cnt: Integer;
  r: TRegHLIXYX;
begin
  FExecNMI := False;
  FExecMI := False;
  FExecReset := False;
  FExecHalt := False;
  FStp := FStopped;
  FStopped := True;
  FBreakExecuted := False;

  while FInStep do
    Application.ProcessMessages;

  FHalted := False;
  Acc := 0;
  MR := 0;
  MaskMR := 0;
  IR := 0;
  IM := 0;
  MI_Vector := 0;
  RPBC.BC := 0;
  RPDE.DE := 0;
  AccAlt := 0;
  RPBC2.BC := 0;
  RPDE2.DE := 0;
  RPHL2.HL := 0;

  for r := Low(RPHL) to High(RPHL) do
    RPHL[r].HL := 0;

  Mem.CurrSP := $0000; //Mem.Size - 1;
  Mem.CurrPC := $0000;

  Flag_S := False;
  Flag_Z := False;
  Flag_PV := False;
  Flag_N := False;
  Flag_CY := False;
  Flag_SAlt := False;
  Flag_ZAlt := False;
  Flag_PVAlt := False;
  Flag_NAlt := False;
  Flag_CYAlt := False;
  FDisasmPrevious := EmptyStr;
  FStopped := FStp;
  HL_Index := regHL;

  for Cnt := Low(IO.Ports) to High(IO.Ports) do
    if Assigned(IO.Ports[Cnt]) then
      IO.Ports[Cnt].Reset;

  if Assigned(FOnReset) then
    FOnReset(Self);
end;

procedure TCPUZ80.Reset;
begin
  FExecReset := True;

  if FRunning and Suspended then
    Suspended := False;
end;

procedure TCPUZ80.Run;
begin
  if not FHalted then
  begin
    if Suspended then
      Suspended := False;

    FLD_Addr_Art := Time;
    FStopped := False;
    FRunning := True;
  end;
end;

procedure TCPUZ80.Step;
var
  Go: Boolean;
begin
  if FExecHalt then
    ExecHalt;

  if FHalted then
    Exit;

  FInStep := True;

  if Suspended and not FStopped then
    Suspended := False;

  try
    FCurrCommand := Mem.CurrPC;

    if FExecMI and (IM = 0) then
    begin
      FExecMI := False;
      DR := MI_Vector;
      MI_Vector := 0;
    end
    else if FRunning and Mem.HasBreak(FCurrCommand) and not FStopped then
    begin
      FNextCommand := FCurrCommand;
      DisasmPrevious(FCurrCommand);
      FDisasmNext := FDisasmPrevious;

      if Assigned(FOnBreak) then
      begin
        Go := True;
        FOnBreak(Self, FCurrCommand, Go);

        if not Go then
          Stop;
      end
      else
        Stop;

      if FStopped then
      begin
        DisasmPrevious(FCurrCommand);
        DisasmNext(FNextCommand);
        Exit;
      end;
    end;

    DR := Mem.ReadB(True);
    ExecInstructions(DR);
    FNextCommand := Mem.CurrPC;

    Inc(MR);
    MR := MR and $7F or MaskMR;

    if not (DR in [$DD, $FD]) then
      HL_Index := regHL;

    if not FRunning then
    begin
      DisasmPrevious(FCurrCommand);
      DisasmNext(FNextCommand);
    end;

    if Assigned(FOnStep) and (not FRunning or (FRunning and not FOnlyStepByStep)) then
      Synchronize(ExecStepEvent);
  finally
    FInStep := False;
  end;
end;

procedure TCPUZ80.Stop;
begin
  Synchronize(ExecStop);
  Suspend;
end;

procedure TCPUZ80.ExecNMI;
begin
  FExecNMI := False;

  if Flag_IFF2 then
  begin
    if Assigned(FOnNMI) then
      FOnNMI(Self, FRunning);

    Flag_IFF1 := False;
    CALL_($66);
  end;
end;

procedure TCPUZ80.ExecMI;
begin
  FExecMI := False;

  case IM of
    1: CALL_($38);
    2:
      begin
        TMP.MSB := IR;
        TMP.LSB := IM;
        CALL_(TMP.WordVal);
      end;
  end;
end;

procedure TCPUZ80.SetMR(Value: Byte);
begin
  Value := Value and $EF;

  if Value <> MR then
    MR := Value;
end;

procedure TCPUZ80.Get_IDX_Address;
begin
  if HL_Index <> regHL then // IX ou IY
  begin
    Val_Num := Mem.ReadB(True);

    if Val_Num > 127 then
      Val_Num := 129 - Val_Num;
  end
  else
    Val_Num := 0;

  Addr_HL_IDX := RPHL[HL_Index].HL + Val_Num;
end;

function TCPUZ80.Read_Addr_From_HL_IDX(MustCalc: Boolean): Byte;
begin
  if MustCalc then
    Get_IDX_Address;

  Result := Mem.ReadB(Addr_HL_IDX);
end;

procedure TCPUZ80.Write_HL_IDX_To_Addr(MustCalc: Boolean; Data: Byte);
begin
  if MustCalc then
    Get_IDX_Address;

  Mem.WriteB(Addr_HL_IDX, Data);
end;

procedure TCPUZ80.Write_HL_IDX_To_Addr(MustCalc: Boolean; LSB, MSB: Byte);
begin
  if MustCalc then
    Get_IDX_Address;

  Mem.WriteB(Addr_HL_IDX, LSB);
  Inc(Addr_HL_IDX);
  Mem.WriteB(Addr_HL_IDX, MSB);
end;

procedure TCPUZ80.INCR(var Reg_MSB, Reg_LSB: Byte);
begin
  InternalRP.LSB := Reg_LSB;
  InternalRP.MSB := Reg_MSB;
  Inc(InternalRP.WordVal);
  Reg_LSB := InternalRP.LSB;
  Reg_MSB := InternalRP.MSB;
end;

procedure TCPUZ80.INCR(var Reg: word);
begin
  Inc(Reg);
end;

procedure TCPUZ80.INCR(var Reg: Byte);
var
  res: Byte;
begin
  Inc(Reg);
  Flag_Z := Reg = 0;
  Flag_S := Reg > 127;
  Flag_F5 := (Reg and $20) = $20;
  // ?? Flag_HF := (Reg and 8 = 8) and (Acc and 8 = 8); ??
  Flag_F3 := (Reg and 8) = 8;
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Reg and Trunc(Power(2, res))) <> 0);
end;

procedure TCPUZ80.DECR(var Reg_MSB, Reg_LSB: Byte);
begin
  InternalRP.LSB := Reg_LSB;
  InternalRP.MSB := Reg_MSB;
  Dec(InternalRP.WordVal);
  Reg_LSB := InternalRP.LSB;
  Reg_MSB := InternalRP.MSB;
end;

procedure TCPUZ80.DECR(var Reg: word);
begin
  Dec(Reg);
end;

procedure TCPUZ80.DECR(var Reg: Byte);
var
  res: Byte;
begin
  Dec(Reg);
  Flag_S := (Reg > 127);
  Flag_Z := Reg = 0;
  Flag_F5 := (Reg and $20) = $20;
  // ?? Flag_HF := (Reg and 8 = 8) and (Acc and 8 = 8); ??
  Flag_F3 := (Reg and 8) = 8;
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Reg and Trunc(Power(2, res))) <> 0);
end;

procedure TCPUZ80.LD_Reg_Num(var Reg_MSB, Reg_LSB: Byte);
begin
  Reg_LSB := Mem.ReadB(True);
  Reg_MSB := Mem.ReadB(True);
end;

procedure TCPUZ80.LD_Reg_Num(var Reg: Word);
begin
  InternalRP.LSB := Mem.ReadB(True);
  InternalRP.MSB := Mem.ReadB(True);
  Reg := InternalRP.WordVal;
end;

procedure TCPUZ80.LD_Reg_Num(var Reg: Byte);
begin
  Reg := Mem.ReadB(True);
end;

procedure TCPUZ80.LD_RP_Addr(var Reg: Word);
begin
  TTRR.LSB := Mem.ReadB(True);
  TTRR.MSB := Mem.ReadB(True);
  Reg := Mem.ReadB(TTRR.WordVal) + 256 * Mem.ReadB(TTRR.WordVal + 1);
end;

procedure TCPUZ80.INP(var Reg: Byte; Port: Byte);
begin
  Reg := IORead(Port);
end;

procedure TCPUZ80.INP(var Reg: Integer; Port: Byte);
begin
  Reg := IORead(Port);
end;

procedure TCPUZ80.INP(var Reg: Byte);
begin
  INP(Reg, Mem.ReadB(True));
end;

procedure TCPUZ80.OUTP(Port, Value: Byte);
begin
  IOWrite(Port, Value);
end;

procedure TCPUZ80.OUTP(Port: Byte);
begin
  TTRR.LSB := Mem.ReadB(True);
  OUTP(TTRR.LSB, Port);
end;

procedure TCPUZ80.NMI;
begin
  FExecNMI := True;
  FHalted := False;
  Step;
end;

procedure TCPUZ80.MI(Vector: Byte);
begin
  MI_Vector := Vector;
  FExecMI := True;
end;

procedure TCPUZ80.CALL_(Addr: Word);
begin
  TTRR.WordVal := Mem.CurrPC;
  Mem.Push(TTRR.MSB);
  Mem.Push(TTRR.LSB);
  Mem.CurrPC := Addr;
  FStopped := False;
end;

procedure TCPUZ80.NOP;
begin
  // $00
end;

procedure TCPUZ80.LD_BC_Num;
begin
  // $01
  LD_Reg_Num(RPBC.BC);
end;

procedure TCPUZ80.LD_BC_A;
begin
  // $02:
  Mem.WriteB(RPBC.BC, Acc);
end;

procedure TCPUZ80.INC_BC;
begin
  // $03:
  INCR(RPBC.BC);
end;

procedure TCPUZ80.INC_B;
begin
  // $04:
  INCR(RPBC.B);
end;

procedure TCPUZ80.DEC_B;
begin
  // $05:
  DECR(RPBC.B);
end;

procedure TCPUZ80.LD_B_Num;
begin
  // $06:
  RPBC.B := Mem.ReadB(True);
end;

procedure TCPUZ80.RLCA;
begin
  // $07:
  Flag_CY := Acc and $80 <> 0;
  Acc := Acc shl 1;

  if Flag_CY then
    Acc := Acc or $01;

  Flag_F5 := (Acc and $20) = $20;
  Flag_HF := False;
  Flag_F3 := (Acc and 8) = 8;
  Flag_N := False;
end;

procedure TCPUZ80.EX_AF_AF2;
begin
  // $08:
  Swap(Acc, AccAlt);
  Swap(Flag_S, Flag_SAlt);
  Swap(Flag_Z, Flag_ZAlt);
  Swap(Flag_F5, Flag_F5Alt);
  Swap(Flag_HF, Flag_HFAlt);
  Swap(Flag_F3, Flag_F3Alt);
  Swap(Flag_PV, Flag_PVAlt);
  Swap(Flag_N, Flag_NAlt);
  Swap(Flag_CY, Flag_CYAlt);
end;

procedure TCPUZ80.ADD_HL_BC;
begin
  // $09:
  if (RPHL[HL_Index].L + RPBC.C) > 255 then
    Inc(RPHL[HL_Index].H);
  RPHL[HL_Index].L := RPBC.C + RPHL[HL_Index].L;
  if (RPHL[HL_Index].H + RPBC.B) > 255 then
    Flag_CY := True;
  RPHL[HL_Index].H := RPBC.B + RPHL[HL_Index].H;
end;

procedure TCPUZ80.LDA_BC;
begin
  // $0A:
  Acc := Mem.ReadB(RPBC.BC);
end;

procedure TCPUZ80.DEC_BC;
begin
  // $0B:
  DECR(RPBC.BC);
end;

procedure TCPUZ80.INC_C;
begin
  // $0C:
  INCR(RPBC.C);
end;

procedure TCPUZ80.DEC_C;
begin
  // $0D:
  DECR(RPBC.C);
end;

procedure TCPUZ80.LD_C_Num;
begin
  // $0E:
  RPBC.C := Mem.ReadB(True);
end;

procedure TCPUZ80.RRCA;
begin
  // $0F:
  RRC(Acc);
end;

procedure TCPUZ80.DJNZ;
var
  res: Integer;
begin
  // $10:
  res := Mem.ReadB(True);
  DEC_B;

  if RPBC.B <> 0 then
  begin
    if res > 127 then
      res := res - 256;

    Mem.CurrPC := res + Mem.CurrPC;
  end;
end;

procedure TCPUZ80.LD_DE_Num;
begin
  // $11:
  LD_Reg_Num(RPDE.DE);
end;

procedure TCPUZ80.LD_DE_A;
begin
  // $12:
  Mem.WriteB(RPDE.DE, Acc);
end;

procedure TCPUZ80.INC_DE;
begin
  // $13:
  INCR(RPDE.D, RPDE.E);
end;

procedure TCPUZ80.INC_D;
begin
  // $14:
  INCR(RPDE.D);
end;

procedure TCPUZ80.DEC_D;
begin
  // $15:
  DECR(RPDE.D);
end;

procedure TCPUZ80.LD_D_Num;
begin
  // $16:
  RPDE.D := Mem.ReadB(True);
end;

procedure TCPUZ80.RLA;
begin
  // $17:
  if (Acc and $80) > 0 then
  begin
    Acc := Acc shl 1;
    if Flag_CY then
      Acc := Acc or $01;
    Flag_CY := True;
  end
  else
  begin
    Acc := Acc shl 1;
    if Flag_CY then
      Acc := Acc or $01;
  end;
end;

procedure TCPUZ80.JR_Desloc;
var
  res: Integer;
begin
  // $18:
  res := Mem.ReadB(True);

  if res > 127 then
    res := res - 256;

  Mem.CurrPC := res + Mem.CurrPC;
end;

procedure TCPUZ80.ADD_HL_DE;
begin
  // $19:
  if (RPHL[HL_Index].L + RPDE.E) > 255 then
    Inc(RPHL[HL_Index].H);

  RPHL[HL_Index].L := RPHL[HL_Index].L + RPDE.E;

  if (RPHL[HL_Index].H + RPDE.D) > 255 then
    Flag_CY := True;

  RPHL[HL_Index].H := RPHL[HL_Index].H + RPDE.D;
end;

procedure TCPUZ80.LDA_DE;
begin
  // $1A:
  Acc := Mem.ReadB(RPDE.DE);
end;

procedure TCPUZ80.DEC_DE;
begin
  // $1B:
  DECR(RPDE.D, RPDE.E);
end;

procedure TCPUZ80.INC_E;
begin
  // $1C:
  INCR(RPDE.E);
end;

procedure TCPUZ80.DEC_E;
begin
  // $1D:
  DECR(RPDE.E);
end;

procedure TCPUZ80.LD_E_Num;
begin
  // $1E:
  RPDE.E := Mem.ReadB(True);
end;

procedure TCPUZ80.RRA;
begin
  // $1F:
  if (Acc and $01) > 0 then
  begin
    Acc := Acc shr 1;
    if Flag_CY then
      Acc := Acc or $80;
    Flag_CY := True;
  end
  else
  begin
    Acc := Acc shr 1;
    if Flag_CY then
      Acc := Acc or $80;
  end;
end;

procedure TCPUZ80.JR_NZ_Desloc;
begin
  // $28:
  if not Flag_Z then
    JR_Desloc
  else
    Mem.IncPC;
end;

procedure TCPUZ80.LD_HL_Num;
begin
  // $21:
  LD_Reg_Num(RPHL[HL_Index].HL);
end;

procedure TCPUZ80.LD_Addr_HL;
begin
  // $22:
  TTRR.LSB := Mem.ReadB(True);
  TTRR.MSB := Mem.ReadB(True);
  Mem.WriteB(TTRR.WordVal, RPHL[HL_Index].L);
  Mem.WriteB(TTRR.WordVal + 1, RPHL[HL_Index].H);
end;

procedure TCPUZ80.INC_HL;
begin
  // $23:
  INCR(RPHL[HL_Index].H, RPHL[HL_Index].L);
end;

procedure TCPUZ80.INC_H;
begin
  // $24:
  INCR(RPHL[HL_Index].H);
end;

procedure TCPUZ80.DEC_H;
begin
  // $25:
  DECR(RPHL[HL_Index].H);
end;

procedure TCPUZ80.LD_H_Num;
begin
  // $26:
  RPHL[HL_Index].H := Mem.ReadB(True);
end;

procedure TCPUZ80.DAA;
begin
  // $27:
  if ((Acc and $0F) > 9) or Flag_PV then
    Acc := Acc + $06;

  if ((Acc and $F0) > $90) or Flag_CY then
    Acc := Acc + $60;
end;

procedure TCPUZ80.JR_Z_Desloc;
begin
  // $28:
  if Flag_Z then
    JR_Desloc
  else
    Mem.IncPC;
end;

procedure TCPUZ80.ADD_HL_HL;
begin
  // $29:
  if (RPHL[HL_Index].L + RPHL[HL_Index].L) > 255 then
    Inc(RPHL[HL_Index].H);
  RPHL[HL_Index].L := RPHL[HL_Index].L + RPHL[HL_Index].L;
  if (RPHL[HL_Index].H + RPHL[HL_Index].H) > 255 then
    Flag_CY := True;
  RPHL[HL_Index].H := RPHL[HL_Index].H + RPHL[HL_Index].H;
end;

procedure TCPUZ80.LD_HL_Addr;
begin
  // $2A:
  LD_RP_Addr(RPHL[HL_Index].HL);
end;

procedure TCPUZ80.DEC_HL;
begin
  // $2B:
  DECR(RPHL[HL_Index].H, RPHL[HL_Index].L);
end;

procedure TCPUZ80.INC_L;
begin
  // $2C:
  INCR(RPHL[HL_Index].L);
end;

procedure TCPUZ80.DEC_L;
begin
  // $2D:
  DECR(RPHL[HL_Index].L);
end;

procedure TCPUZ80.LD_L_Num;
begin
  // $2E:
  RPHL[HL_Index].L := Mem.ReadB(True);
end;

procedure TCPUZ80.CPL;
begin
  // $2F:
  Acc := $FF - Acc;
end;

procedure TCPUZ80.JR_NC_Desloc;
begin
  // $30:
  if not Flag_CY then
    JR_Desloc
  else
    Mem.IncPC;
end;

procedure TCPUZ80.LD_SP_NUM;
begin
  // $31:
  TTRR.LSB := Mem.ReadB(True);
  TTRR.MSB := Mem.ReadB(True);
  Mem.CurrSP := TTRR.WordVal;
end;

procedure TCPUZ80.LD_Addr_A;
begin
  // $32:
  TTRR.LSB := Mem.ReadB(True);
  TTRR.MSB := Mem.ReadB(True);
  Mem.WriteB(TTRR.WordVal, Acc);
end;

procedure TCPUZ80.INC_SP;
begin
  // $33:
  TTRR.WordVal := Mem.CurrSP;
  INCR(TTRR.WordVal);
  Mem.CurrSP := TTRR.WordVal;
end;

procedure TCPUZ80.INC_MEM;
begin
  // $34:
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  INCR(TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.DEC_MEM;
begin
  // $35:
  Get_IDX_Address;
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  DECR(TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.LD_Mem_Num;
begin
  // $36:
  Get_IDX_Address;
  TTRR.LSB := Mem.ReadB(True);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.SCF;
begin
  // $37:
  Flag_CY := True;
end;

procedure TCPUZ80.JR_C_Desloc;
begin
  // $38:
  if Flag_CY then
    JR_Desloc
  else
    Mem.IncPC;
end;

procedure TCPUZ80.ADD_HL_SP;
begin
  // $39:
  if (RPHL[HL_Index].L + TNumber(Mem.CurrSP).LSB) > 255 then
    Inc(RPHL[HL_Index].H);

  RPHL[HL_Index].L := RPHL[HL_Index].L + TNumber(Mem.CurrSP).LSB;

  if (RPHL[HL_Index].H + TNumber(Mem.CurrSP).MSB) > 255 then
    Flag_CY := True;

  RPHL[HL_Index].H := RPHL[HL_Index].H + TNumber(Mem.CurrSP).MSB;
end;

procedure TCPUZ80.LD_A_Addr;
begin
  // $3A:
  TTRR.LSB := Mem.ReadB(True);
  TTRR.MSB := Mem.ReadB(True);
  Acc := Mem.ReadB(TTRR.WordVal);
end;

procedure TCPUZ80.DEC_SP;
begin
  // $3B:
  TTRR.WordVal := Mem.CurrSP;
  DECR(TTRR.WordVal);
  Mem.CurrSP := TTRR.WordVal;
end;

procedure TCPUZ80.INC_A;
begin
  // $3C:
  INCR(Acc);
end;

procedure TCPUZ80.DEC_A;
begin
  // $3D:
  DECR(Acc);
end;

procedure TCPUZ80.LD_A_Num;
begin
  // $3E:
  Acc := Mem.ReadB(True);
end;

procedure TCPUZ80.CCF;
begin
  // $3F:
  Flag_CY := not Flag_CY;
end;

procedure TCPUZ80.LD_B_B;
begin
  // $40:
end;

procedure TCPUZ80.LD_B_C;
begin
  // $41:
  RPBC.B := RPBC.C;
end;

procedure TCPUZ80.LD_B_D;
begin
  // $42:
  RPBC.B := RPDE.D;
end;

procedure TCPUZ80.LD_B_E;
begin
  // $43:
  RPBC.B := RPDE.E;
end;

procedure TCPUZ80.LD_B_H;
begin
  // $44:
  RPBC.B := RPHL[HL_Index].H;
end;

procedure TCPUZ80.LD_B_L;
begin
  // $45:
  RPBC.B := RPHL[HL_Index].L;
end;

procedure TCPUZ80.LD_B_MEM;
begin
  // $46:
  RPBC.B := Read_Addr_From_HL_IDX(True);
end;

procedure TCPUZ80.LD_B_A;
begin
  // $47:
  RPBC.B := Acc;
end;

procedure TCPUZ80.LD_C_B;
begin
  // $48:
  RPBC.C := RPBC.B;
end;

procedure TCPUZ80.LD_C_C;
begin
  // $49:
  //Result := 'ld RPBC.C,c';
end;

procedure TCPUZ80.LD_C_D;
begin
  // $4A:
  RPBC.C := RPDE.D;
  //Result := 'ld RPBC.C,RPDE.D';
end;

procedure TCPUZ80.LD_C_E;
begin
  // $4B:
  RPBC.C := RPDE.E;
  //Result := 'ld RPBC.C,RPDE.E';
end;

procedure TCPUZ80.LD_C_H;
begin
  // $4C:
  RPBC.C := RPHL[HL_Index].H;
  //Result := 'ld RPBC.C,h';
end;

procedure TCPUZ80.LD_C_L;
begin
  // $4D:
  RPBC.C := RPHL[HL_Index].L;
  //Result := 'ld RPBC.C,l';
end;

procedure TCPUZ80.LD_C_MEM;
begin
  // $4E:
  RPBC.C := Read_Addr_From_HL_IDX(True);
  //Result := 'ld RPBC.C,(hl)';
end;

procedure TCPUZ80.LD_C_A;
begin
  // $4F:
  RPBC.C := Acc;
  //Result := 'ld RPBC.C,a';
end;

procedure TCPUZ80.LD_D_B;
begin
  // $50:
  RPDE.D := RPBC.B;
  //Result := 'ld RPDE.D,b';
end;

procedure TCPUZ80.LD_D_C;
begin
  // $51:
  RPDE.D := RPBC.C;
  //Result := 'ld RPDE.D,c';
end;

procedure TCPUZ80.LD_D_D;
begin
  // $52:
  //Result := 'ld RPDE.D,RPDE.D';
end;

procedure TCPUZ80.LD_D_E;
begin
  // $53:
  RPDE.D := RPDE.E;
  //Result := 'ld RPDE.D,RPDE.E';
end;

procedure TCPUZ80.LD_D_H;
begin
  // $54:
  RPDE.D := RPHL[HL_Index].H;
  //Result := 'ld RPDE.D,h';
end;

procedure TCPUZ80.LD_D_L;
begin
  // $55:
  RPDE.D := RPHL[HL_Index].L;
  //Result := 'ld RPDE.D,l';
end;

procedure TCPUZ80.LD_D_MEM;
begin
  // $56:
  RPDE.D := Read_Addr_From_HL_IDX(True);
  //Result := 'ld RPDE.D,(hl)';
end;

procedure TCPUZ80.LD_D_A;
begin
  // $57:
  RPDE.D := Acc;
  //Result := 'ld RPDE.D,a';
end;

procedure TCPUZ80.LD_E_B;
begin
  // $58:
  RPDE.E := RPBC.B;
  //Result := 'ld RPDE.E,b';
end;

procedure TCPUZ80.LD_E_C;
begin
  // $59:
  RPDE.E := RPBC.C;
  //Result := 'ld RPDE.E,c';
end;

procedure TCPUZ80.LD_E_D;
begin
  // $5A:
  RPDE.E := RPDE.D;
  //Result := 'ld RPDE.E,RPDE.D';
end;

procedure TCPUZ80.LD_E_E;
begin
  // $5B:
  //Result := 'ld RPDE.E,RPDE.E';
end;

procedure TCPUZ80.LD_E_H;
begin
  // $5C:
  RPDE.E := RPHL[HL_Index].H;
  //Result := 'ld RPDE.E,h';
end;

procedure TCPUZ80.LD_E_L;
begin
  // $5D:
  RPDE.E := RPHL[HL_Index].L;
  //Result := 'ld RPDE.E,l';
end;

procedure TCPUZ80.LD_E_MEM;
begin
  // $5E:
  RPDE.E := Read_Addr_From_HL_IDX(True);
  //Result := 'ld RPDE.E,(hl)';
end;

procedure TCPUZ80.LD_E_A;
begin
  // $5F:
  RPDE.E := Acc;
  //Result := 'ld RPDE.E,a';
end;

procedure TCPUZ80.LD_H_B;
begin
  // $60:
  RPHL[HL_Index].H := RPBC.B;
  //Result := 'ld h,b';
end;

procedure TCPUZ80.LD_H_C;
begin
  // $61:
  RPHL[HL_Index].H := RPBC.C;
  //Result := 'ld h,c';
end;

procedure TCPUZ80.LD_H_D;
begin
  // $62:
  RPHL[HL_Index].H := RPDE.D;
  //Result := 'ld h,RPDE.D';
end;

procedure TCPUZ80.LD_H_E;
begin
  // $63:
  RPHL[HL_Index].H := RPDE.E;
  //Result := 'ld h,RPDE.E';
end;

procedure TCPUZ80.LD_H_H;
begin
  // $64:
  //Result := 'ld h,h';
end;

procedure TCPUZ80.LD_H_L;
begin
  // $65:
  RPHL[HL_Index].H := RPHL[HL_Index].L;
  //Result := 'ld h,l';
end;

procedure TCPUZ80.LD_H_MEM;
begin
  // $66:
  RPHL[regHL].H := Read_Addr_From_HL_IDX(True);
  //Result := 'ld h,(hl)';
end;

procedure TCPUZ80.LD_H_A;
begin
  // $67:
  RPHL[HL_Index].H := Acc;
  //Result := 'ld h,a';
end;

procedure TCPUZ80.LD_L_B;
begin
  // $68:
  RPHL[HL_Index].L := RPBC.B;
  //Result := 'ld l,b';
end;

procedure TCPUZ80.LD_L_C;
begin
  // $69:
  RPHL[HL_Index].L := RPBC.C;
  //Result := 'ld l,c';
end;

procedure TCPUZ80.LD_L_D;
begin
  // $6A:
  RPHL[HL_Index].L := RPDE.D;
  //Result := 'ld l,RPDE.D';
end;

procedure TCPUZ80.LD_L_E;
begin
  // $6B:
  RPHL[HL_Index].L := RPDE.E;
  //Result := 'ld l,RPDE.E';
end;

procedure TCPUZ80.LD_L_H;
begin
  // $6C:
  RPHL[HL_Index].L := RPHL[HL_Index].H;
  //Result := 'ld l,h';
end;

procedure TCPUZ80.LD_L_L;
begin
  // $6D:
  //Result := 'ld l,l';
end;

procedure TCPUZ80.LD_L_MEM;
begin
  // $6E:
  RPHL[regHL].L := Read_Addr_From_HL_IDX(True);
  //Result := 'ld l,(hl)';
end;

procedure TCPUZ80.LD_L_A;
begin
  // $6F:
  RPHL[HL_Index].L := Acc;
  //Result := 'ld l,a';
end;

procedure TCPUZ80.LD_Mem_B;
begin
  // $70:
  Write_HL_IDX_To_Addr(True, RPBC.B);
  //Result := 'ld (hl),b';
end;

procedure TCPUZ80.LD_Mem_C;
begin
  // $71:
  Write_HL_IDX_To_Addr(True, RPBC.C);
  //Result := 'ld (hl),c';
end;

procedure TCPUZ80.LD_Mem_D;
begin
  // $72:
  Write_HL_IDX_To_Addr(True, RPDE.D);
  //Result := 'ld (hl),RPDE.D';
end;

procedure TCPUZ80.LD_Mem_E;
begin
  // $73:
  Write_HL_IDX_To_Addr(True, RPDE.E);
  //Result := 'ld (hl),RPDE.E';
end;

procedure TCPUZ80.LD_Mem_H;
begin
  // $74:
  Write_HL_IDX_To_Addr(True, RPHL[regHL].H);
  //Result := 'ld (hl),h';
end;

procedure TCPUZ80.LD_Mem_L;
begin
  // $75:
  Write_HL_IDX_To_Addr(True, RPHL[regHL].L);
  //Result := 'ld (hl),l';
end;

procedure TCPUZ80.HALT_Z80;
begin
  // $76:
  Halt;
  //Result := 'halt';
end;

procedure TCPUZ80.LD_Mem_A;
begin
  // $77:
  Write_HL_IDX_To_Addr(True, Acc);
  //Result := 'ld (hl),a';
end;

procedure TCPUZ80.LD_A_B;
begin
  // $78:
  Acc := RPBC.B;
  //Result := 'ld a,b';
end;

procedure TCPUZ80.LD_A_C;
begin
  // $79:
  Acc := RPBC.C;
  //Result := 'ld a,c';
end;

procedure TCPUZ80.LD_A_D;
begin
  // $7A:
  Acc := RPDE.D;
  //Result := 'ld a,RPDE.D';
end;

procedure TCPUZ80.LD_A_E;
begin
  // $7B:
  Acc := RPDE.E;
  //Result := 'ld a,RPDE.E';
end;

procedure TCPUZ80.LD_A_H;
begin
  // $7C:
  Acc := RPHL[HL_Index].H;
  //Result := 'ld a,h';
end;

procedure TCPUZ80.LD_A_L;
begin
  // $7D:
  Acc := RPHL[HL_Index].L;
  //Result := 'ld a,l';
end;

procedure TCPUZ80.LD_A_MEM;
begin
  // $7E:
  Acc := Read_Addr_From_HL_IDX(True);
  //Result := 'ld a,(hl)';
end;

procedure TCPUZ80.LD_A_A;
begin
  // $7F:
  //Result := 'ld a,a';
end;

procedure TCPUZ80.ADD_A(Reg: Byte);
var
  res: Integer;
  b: Byte;
begin
  Flag_S := (Max(Acc, Reg) < Abs(Min(Acc, Reg)));
  res := Acc + Reg;
  Flag_CY := (res > 255);
  Acc := Acc + Reg;
  Flag_Z := (Acc = 0);
  Flag_PV := False;
  
  for b := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, b))) <> 0);
end;

procedure TCPUZ80.ADD_A_B;
begin
  // $80:
  ADD_A(RPBC.B);
  //Result := 'add a,b';
end;

procedure TCPUZ80.ADD_A_C;
begin
  // $81:
  ADD_A(RPBC.C);
  //Result := 'add a,c';
end;

procedure TCPUZ80.ADD_A_D;
begin
  // $82:
  ADD_A(RPDE.D);
  //Result := 'add a,RPDE.D';
end;

procedure TCPUZ80.ADD_A_E;
begin
  // $83:
  ADD_A(RPDE.E);
  //Result := 'add a,RPDE.E';
end;

procedure TCPUZ80.ADD_A_H;
begin
  // $84:
  ADD_A(RPHL[HL_Index].H);
  //Result := 'add a,h';
end;

procedure TCPUZ80.ADD_A_L;
begin
  // $85:
  ADD_A(RPHL[HL_Index].L);
  //Result := 'add a,l';
end;

procedure TCPUZ80.ADD_A_MEM;
begin
  // $86:
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  ADD_A(TTRR.LSB);
  //Result := 'add a,(hl)';
end;

procedure TCPUZ80.ADD_A_A;
begin
  // $87:
  ADD_A(Acc);
  //Result := 'add a,a';
end;

procedure TCPUZ80.ADC_A(Reg: Byte);
var
  res: Integer;
  b: Byte;
begin
  // $88:
  if Flag_CY then
    Inc(Acc);

  Flag_S := (Max(Acc, Reg) < Abs(Min(Acc, Reg)));
  res := Acc + Reg;
  Flag_CY := (res > 255);
  Acc := Acc + Reg;
  Flag_Z := (Acc = 0);
  Flag_PV := False;
  
  for b := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, b))) <> 0);
  //Result := 'adc b';
end;

procedure TCPUZ80.ADC_A_B;
begin
  // $88:
  ADC_A(RPBC.B);
  //Result := 'adc b';
end;

procedure TCPUZ80.ADC_A_C;
begin
  // $89:
  ADC_A(RPBC.C);
  //Result := 'adc c';
end;

procedure TCPUZ80.ADC_A_D;
begin
  // $8A:
  ADC_A(RPDE.D);
  //Result := 'adc RPDE.D';
end;

procedure TCPUZ80.ADC_A_E;
begin
  // $8B:
  ADC_A(RPDE.E);
  //Result := 'adc RPDE.E';
end;

procedure TCPUZ80.ADC_A_H;
begin
  // $8C:
  ADC_A(RPHL[HL_Index].H);
  //Result := 'adc h';
end;

procedure TCPUZ80.ADC_A_L;
begin
  // $8D:
  ADC_A(RPHL[HL_Index].L);
  //Result := 'adc l';
end;

procedure TCPUZ80.ADC_A_MEM;
begin
  // $8E:
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  ADC_A(TTRR.LSB);
  //Result := 'adc M';
end;

procedure TCPUZ80.ADC_A_A;
begin
  // $8F:
  ADC_A(Acc);
  //Result := 'adc a';
end;

procedure TCPUZ80.SUB(Reg: Byte);
var
  res: Integer;
  b: Byte;
begin
  // $90:
  Flag_S := (Max(Acc, -Reg) < ABS(Min(Acc, -Reg)));
  res := Acc - Reg;
  Flag_CY := (res < 0);
  Acc := Acc - Reg;
  Flag_Z := (Acc = 0);
  Flag_PV := False;
  
  for b := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, b))) <> 0);
  //Result := 'sub b';
end;

procedure TCPUZ80.SUB_B;
begin
  // $90:
  SUB(RPBC.B);
  //Result := 'sub b';
end;

procedure TCPUZ80.SUB_C;
begin
  // $91:
  SUB(RPBC.C);
  //Result := 'sub c';
end;

procedure TCPUZ80.SUB_D;
begin
  // $92:
  SUB(RPDE.D);
  //Result := 'sub RPDE.D';
end;

procedure TCPUZ80.SUB_E;
begin
  // $93:
  SUB(RPDE.E);
  //Result := 'sub RPDE.E';
end;

procedure TCPUZ80.SUB_H;
begin
  // $94:
  SUB(RPHL[HL_Index].H);
  //Result := 'sub h';
end;

procedure TCPUZ80.SUB_L;
begin
  // $95:
  SUB(RPHL[HL_Index].L);
  //Result := 'sub l';
end;

procedure TCPUZ80.SUB_MEM;
begin
  // $96:
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SUB(TTRR.LSB);
  //Result := 'sub (hl)';
end;

procedure TCPUZ80.SUB_A;
begin
  // $97:
  SUB(Acc);
  //Result := 'sub a';
end;

procedure TCPUZ80.SBC_A(Reg: Byte);
var
  res: Integer;
  b: Byte;
begin
  if Flag_CY then
    Dec(Acc);

  Flag_S := (Max(Acc, -Reg) < ABS(Min(Acc, -Reg)));
  res := Acc - Reg;
  Flag_CY := (res < 0);
  Acc := Acc - Reg;
  Flag_Z := (Acc = 0);
  Flag_PV := False;

  for b := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, b))) <> 0);
end;

procedure TCPUZ80.SBC_A_B;
begin
  // $98:
  SBC_A(RPBC.B);
  //Result := 'sbc a,b';
end;

procedure TCPUZ80.SBC_A_C;
begin
  // $99:
  SBC_A(RPBC.C);
  //Result := 'sbc a,c';
end;

procedure TCPUZ80.SBC_A_D;
begin
  // $9A:
  SBC_A(RPDE.D);
  //Result := 'sbc a,RPDE.D';
end;

procedure TCPUZ80.SBC_A_E;
begin
  // $9B:
  SBC_A(RPDE.E);
  //Result := 'sbc a,RPDE.E';
end;

procedure TCPUZ80.SBC_A_H;
begin
  // $9C:
  SBC_A(RPHL[HL_Index].H);
  //Result := 'sbc a,h';
end;

procedure TCPUZ80.SBC_A_L;
begin
  // $9D:
  SBC_A(RPHL[HL_Index].L);
  //Result := 'sbc a,l';
end;

procedure TCPUZ80.SBC_A_MEM;
begin
  // $9E:
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SBC_A(TTRR.LSB);
  //Result := 'sbc a,M';
end;

procedure TCPUZ80.SBC_A_A;
begin
  // $9F:
  SBC_A(Acc);
  //Result := 'sbc a,a';
end;

procedure TCPUZ80.AND_(Reg: Byte);
var
  res: Byte;
begin
  // $A0:
  Acc := Acc and Reg;
  Flag_Z := (Acc = 0);
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, res))) <> 0);
    
  Flag_S := (Acc > 127);
  Flag_CY := False;
  Flag_PV := True;
  //Result := 'ana b';
end;

procedure TCPUZ80.AND_B;
begin
  // $A0:
  AND_(RPBC.B);
  //Result := 'ana b';
end;

procedure TCPUZ80.AND_C;
begin
  // $A1:
  AND_(RPBC.C);
  //Result := 'ana c';
end;

procedure TCPUZ80.AND_D;
begin
  // $A2:
  AND_(RPDE.D);
  //Result := 'ana RPDE.D';
end;

procedure TCPUZ80.AND_E;
begin
  // $A3:
  AND_(RPDE.E);
  //Result := 'ana RPDE.E';
end;

procedure TCPUZ80.AND_H;
begin
  // $A4:
  AND_(RPHL[HL_Index].H);
  //Result := 'ana h';
end;

procedure TCPUZ80.AND_L;
begin
  // $A5:
  AND_(RPHL[HL_Index].L);
  //Result := 'ana l';
end;

procedure TCPUZ80.AND_MEM;
begin
  // $A6:
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  AND_(TTRR.LSB);
  //Result := 'ana M';
end;

procedure TCPUZ80.AND_A;
begin
  // $A7:
  AND_(Acc);
  //Result := 'ana a';
end;

procedure TCPUZ80.XOR_(Reg: Byte);
var
  res: Byte;
begin
  Acc := Acc xor Reg;
  Flag_Z := (Acc = 0);
  Flag_PV := False;
  
  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, res))) <> 0);
    
  Flag_S := (Acc > 127);
  Flag_CY := False;
  Flag_PV := False;
end;

procedure TCPUZ80.XOR_B;
begin
  // $A8:
  XOR_(RPBC.B);
  //Result := 'xra b';
end;

procedure TCPUZ80.XOR_C;
begin
  // $A9:
  XOR_(RPBC.C);
  //Result := 'xra c';
end;

procedure TCPUZ80.XOR_D;
begin
  // $AA:
  XOR_(RPDE.D);
  //Result := 'xra RPDE.D';
end;

procedure TCPUZ80.XOR_E;
begin
  // $AB:
  XOR_(RPDE.E);
  //Result := 'xra RPDE.E';
end;

procedure TCPUZ80.XOR_H;
begin
  // $AC:
  XOR_(RPHL[HL_Index].H);
  //Result := 'xra h';
end;

procedure TCPUZ80.XOR_L;
begin
  // $AD:
  XOR_(RPHL[HL_Index].L);
  //Result := 'xra l';
end;

procedure TCPUZ80.XOR_MEM;
begin
  // $AE:
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  XOR_(TTRR.LSB);
  //Result := 'xra M';
end;

procedure TCPUZ80.XOR_A;
begin
  // $AF:
  XOR_(Acc);
  //Result := 'xra a';
end;

procedure TCPUZ80.OR_(Reg: Byte);
var
  res: Byte;
begin
  Acc := Acc or Reg;
  Flag_Z := (Acc = 0);
  Flag_PV := False;
  
  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, res))) <> 0);
    
  Flag_S := (Acc > 127);
  Flag_CY := False;
  Flag_PV := False;
  //Result := 'ora b';
end;

procedure TCPUZ80.OR_B;
begin
  // $B0:
  OR_(RPBC.B)
    //Result := 'ora b';
end;

procedure TCPUZ80.OR_C;
begin
  // $B1:
  OR_(RPBC.C);
  //Result := 'ora c';
end;

procedure TCPUZ80.OR_D;
begin
  // $B2:
  OR_(RPDE.D);
  //Result := 'ora RPDE.D';
end;

procedure TCPUZ80.OR_E;
begin
  // $B3:
  OR_(RPDE.E);
  //Result := 'ora RPDE.E';
end;

procedure TCPUZ80.OR_H;
begin
  // $B4:
  OR_(RPHL[HL_Index].H);
  //Result := 'ora h';
end;

procedure TCPUZ80.OR_L;
begin
  // $B5:
  OR_(RPHL[HL_Index].L);
  //Result := 'ora l';
end;

procedure TCPUZ80.OR_MEM;
begin
  // $B6:
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  OR_(TTRR.LSB);
  //Result := 'ora M';
end;

procedure TCPUZ80.OR_A;
begin
  // $B7:
  OR_(Acc);
  //Result := 'ora a';
end;

procedure TCPUZ80.CP(Reg: Byte);
var
  res: Byte;
begin
  Flag_Z := Reg = 0;
  Flag_S := (Reg > 127);
  Flag_F5 := (Reg and $20) = $20;
  // ?? Flag_HF := (Reg and 8 = 8) and (Acc and 8 = 8); ??
  Flag_F3 := (Reg and 8) = 8;
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Reg and Trunc(Power(2, res))) <> 0);
end;

procedure TCPUZ80.CP_Reg_Acc(Reg: Byte; GenPV: Boolean);
var
  res: Byte;
begin
  Flag_Z := Reg = Acc;
  Flag_CY := Reg > Acc;
  Flag_S := (Max(Acc, -Reg) > ABS(Min(Acc, -Reg)));
  Flag_F5 := Reg and 2 = 2;
  Flag_F3 := Reg and 4 = 4;
  Flag_HF := (Reg and 8 = 8) and (Acc and 8 = 8);

  if GenPV then
  begin
    TTRR.LSB := Acc - Reg;
    Flag_PV := False;

    for res := 0 to 7 do
      Flag_PV := Flag_PV xor ((TTRR.LSB and Trunc(Power(2, res))) <> 0);
  end;
end;

procedure TCPUZ80.CP_B;
begin
  // $B8:
  CP_Reg_Acc(RPBC.B, True);
  //Result := 'cmp b';
end;

procedure TCPUZ80.CP_C;
begin
  // $B9:
  CP_Reg_Acc(RPBC.C, True);
  //Result := 'cmp c';
end;

procedure TCPUZ80.CP_D;
begin
  // $BA:
  CP_Reg_Acc(RPDE.D, True);
  //Result := 'cmp RPDE.D';
end;

procedure TCPUZ80.CP_E;
begin
  // $BB:
  CP_Reg_Acc(RPDE.E, True);
  //Result := 'cmp RPDE.E';
end;

procedure TCPUZ80.CP_H;
begin
  // $BC:
  CP_Reg_Acc(RPHL[HL_Index].H, True);
  //Result := 'cmp h';
end;

procedure TCPUZ80.CP_L;
begin
  // $BD:
  CP_Reg_Acc(RPHL[HL_Index].L, True);
  //Result := 'cmp l';
end;

procedure TCPUZ80.CP_MEM;
begin
  // $BE:
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  CP_Reg_Acc(TTRR.LSB, True);
  //Result := 'cmp M';
end;

procedure TCPUZ80.CP_A;
begin
  // $BF:
  CP_Reg_Acc(Acc, True);
end;

procedure TCPUZ80.RET_NZ;
begin
  // $C0:
  if not Flag_Z then
    RET;
end;

procedure TCPUZ80.POP_BC;
begin
  // $C1:
  RPBC.C := Mem.Pop;
  RPBC.B := Mem.Pop;
end;

procedure TCPUZ80.JP_NZ_Addr;
begin
  // $C2:
  if not Flag_Z then
    JP_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.JP_Addr;
begin
  // $C3:
  TTRR.LSB := Mem.ReadB(True);
  TTRR.MSB := Mem.ReadB(True);
  Mem.CurrPC := TTRR.WordVal;
end;

procedure TCPUZ80.CALL_NZ_Addr;
begin
  // $C4:
  if not Flag_Z then
    CALL_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.PUSH_BC;
begin
  // $C5:
  Mem.Push(RPBC.B);
  Mem.Push(RPBC.C);
end;

procedure TCPUZ80.ADD_A_Num;
begin
  // $C6:
  TTRR.LSB := Mem.ReadB(True);
  Acc := Acc + TTRR.LSB;
end;

procedure TCPUZ80.RST_0;
begin
  // $C7:
  CALL_(0);
  //Result := 'rst 0';
end;

procedure TCPUZ80.RET_Z;
begin
  // $C8:
  if Flag_Z then
    RET;
  //Result := 'rz';
end;

procedure TCPUZ80.RET;
begin
  // $C9:
  TTRR.LSB := Mem.Pop;
  TTRR.MSB := Mem.Pop;
  Mem.CurrPC := TTRR.WordVal;
end;

procedure TCPUZ80.JP_Z_Addr;
begin
  // $CA:
  if Flag_Z then
    JP_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.BYTE_CB;
begin
  // $CB:
  if HL_Index = regHL then
  begin
    DR := Mem.ReadB(True);
    InstructionsCB[DR];
  end
  else // $DD/$FD $CB
  begin
    Get_IDX_Address;
    DR := Mem.ReadB(True);
    InstructionsIDX_CB[DR];
  end;
end;

procedure TCPUZ80.CALL_Z_Addr;
begin
  // $CC:
  if Flag_Z then
    CALL_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.CALL_Addr;
begin
  // $CD:
  TTRR.LSB := Mem.ReadB(True);
  TTRR.MSB := Mem.ReadB(True);
  TMP.WordVal := Mem.CurrPC;
  Mem.Push(TMP.MSB);
  Mem.Push(TMP.LSB);
  Mem.CurrPC := TTRR.WordVal;
end;

procedure TCPUZ80.ADC_A_Num;
var
  res: Integer;
  b: Byte;
begin
  // $CE:
  if Flag_CY then
    Inc(Acc);

  TTRR.LSB := Mem.ReadB(True);
  Flag_S := (Max(Acc, TTRR.LSB) < Abs(Min(Acc, TTRR.LSB)));
  res := Acc + TTRR.LSB;
  Flag_CY := (res > 255);
  Acc := Acc + TTRR.LSB;
  Flag_Z := (Acc = 0);
  Flag_PV := False;
  
  for b := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, b))) <> 0);
end;

procedure TCPUZ80.RST_8;
begin
  // $CF:
  CALL_(8);
  //Result := 'rst 1';
end;

procedure TCPUZ80.RET_NC;
begin
  // $D0:
  if not Flag_CY then
    RET;
  //Result := 'RET_NC';
end;

procedure TCPUZ80.POP_DE;
begin
  // $D1:
  RPDE.E := Mem.Pop;
  RPDE.D := Mem.Pop;
end;

procedure TCPUZ80.JP_NC_Addr;
begin
  // $D2:
  if not Flag_CY then
    JP_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.OUT_A_PORT;
begin
  // $D3:
  OUTP(Acc);
  //Result := 'out ' + IntToHex(TTRR.LSB, 2);
end;

procedure TCPUZ80.CALL_NC_Addr;
begin
  // $D4:
  if not Flag_CY then
    CALL_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.PUSH_DE;
begin
  // $D5:
  Mem.Push(RPDE.D);
  Mem.Push(RPDE.E);
end;

procedure TCPUZ80.SUB_Num;
var
  res: Integer;
  b: Byte;
begin
  // $D6:
  TTRR.LSB := Mem.ReadB(True);
  Flag_S := (Max(Acc, -TTRR.LSB) < ABS(Min(Acc, -TTRR.LSB)));
  res := Acc - TTRR.LSB;
  Flag_CY := (res < 0);
  Acc := Acc - TTRR.LSB;
  Flag_Z := (Acc = 0);
  Flag_PV := False;

  for b := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, b))) <> 0);
end;

procedure TCPUZ80.RST_16;
begin
  // $D7:
  CALL_(16);
  //Result := 'rst 2';
end;

procedure TCPUZ80.RET_C;
begin
  // $D8:
  if Flag_CY then
    RET;
  //Result := 'rc';
end;

procedure TCPUZ80.EXX;
begin
  // $D9:
  Swap(RPBC.BC, RPBC2.BC);
  Swap(RPDE.DE, RPDE2.DE);
  Swap(RPHL[regHL].HL, RPHL2.HL);
  //Result := 'exx';
end;

procedure TCPUZ80.JP_C_Addr;
begin
  // $DA:
  if Flag_CY then
    JP_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.IN_A_PORT;
begin
  // $DB:
  INP(Acc);
end;

procedure TCPUZ80.CALL_C_Addr;
begin
  // $DC:
  if Flag_CY then
    CALL_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.Alt_HL_To_IX;
begin
  // $DD:
  HL_Index := regIX;
end;

procedure TCPUZ80.SBC_A_Num;
var
  res: Integer;
  b: Byte;
begin
  // $DE:
  if Flag_CY then
    Dec(Acc);

  TTRR.LSB := Mem.ReadB(True);
  Flag_S := (Max(Acc, -TTRR.LSB) < ABS(Min(Acc, -TTRR.LSB)));
  res := Acc - TTRR.LSB;
  Flag_CY := (res < 0);
  Acc := Acc - TTRR.LSB;
  Flag_Z := (Acc = 0);
  Flag_PV := False;

  for b := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, b))) <> 0);
  //Result := 'sbi ' + IntToHex(TTRR.LSB, 2);
end;

procedure TCPUZ80.RST_24;
begin
  // $DF:
  CALL_(24);
  //Result := 'rst 3';
end;

procedure TCPUZ80.RET_PO;
begin
  // $E0:
  if not Flag_PV then
    RET;
end;

procedure TCPUZ80.POP_HL;
begin
  // $E1:
  RPHL[HL_Index].L := Mem.Pop;
  RPHL[HL_Index].H := Mem.Pop;
end;

procedure TCPUZ80.JP_PO_Addr;
begin
  // $E2:
  if not Flag_PV then
    JP_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.EX_SP_HL;
begin
  // $E3:
  TTRR.WordVal := RPHL[HL_Index].HL;
  TMP.WordVal := Mem.CurrSP;
  RPHL[HL_Index].L := Mem.ReadB(TMP.WordVal);
  RPHL[HL_Index].H := Mem.ReadB(TMP.WordVal + 1);
  Mem.WriteB(TMP.WordVal, TTRR.LSB);
  Mem.WriteB(TMP.WordVal + 1, TTRR.MSB);
end;

procedure TCPUZ80.CALL_PO_Addr;
begin
  // $E4:
  if not Flag_PV then
    CALL_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.PUSH_HL;
begin
  // $E5:
  Mem.Push(RPHL[HL_Index].H);
  Mem.Push(RPHL[HL_Index].L);
end;

procedure TCPUZ80.AND_Num;
var
  res: Byte;
begin
  // $E6:
  TTRR.LSB := Mem.ReadB(True);
  Acc := Acc and TTRR.LSB;
  Flag_Z := (Acc = 0);
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, res))) <> 0);

  Flag_S := (Acc > 127);
  Flag_CY := False;
  Flag_PV := True;
  //Result := 'ani ' + IntToHex(TTRR.LSB, 2);
end;

procedure TCPUZ80.RST_32;
begin
  // $E7:
  CALL_(32);
  //Result := 'rst 4';
end;

procedure TCPUZ80.RET_PE;
begin
  // $E8:
  if Flag_PV then
    RET;
  //Result := 'rpe';
end;

procedure TCPUZ80.JP_HL;
begin
  // $E9:
  Mem.CurrPC := RPHL[HL_index].HL;
end;

procedure TCPUZ80.JP_PE_Addr;
begin
  // $EA:
  if Flag_PV then
    JP_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.EX_DE_HL;
begin
  // $EB:
  TTRR.LSB := RPHL[regHL].H;
  RPHL[regHL].H := RPDE.D;
  RPDE.D := TTRR.LSB;
  TTRR.LSB := RPHL[regHL].L;
  RPHL[regHL].L := RPDE.E;
  RPDE.E := TTRR.LSB;
  //Result := 'ex de,hl';
end;

procedure TCPUZ80.CALL_PE_Addr;
begin
  // $EC:
  if Flag_PV then
    CALL_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.BYTE_ED;
begin
  // $ED:
  DR := Mem.ReadB(True);
  InstructionsED[DR];
end;

procedure TCPUZ80.XOR_Num;
var
  res: Byte;
begin
  // $EE:
  TTRR.LSB := Mem.ReadB(True);
  Acc := Acc xor TTRR.LSB;
  Flag_Z := (Acc = 0);
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, res))) <> 0);

  Flag_S := (Acc > 127);
  Flag_CY := False;
  Flag_PV := False;
  //Result := 'xri ' + IntToHex(TTRR.LSB, 2);
end;

procedure TCPUZ80.RST_40;
begin
  // $EF:
  CALL_(40);
  //Result := 'rst 5';
end;

procedure TCPUZ80.RET_P;
begin
  // $F0:
  if not Flag_S then
    RET;
  //Result := 'ret p';
end;

procedure TCPUZ80.POP_AF;
begin
  // $F1:
  TTRR.LSB := Mem.Pop;
  Acc := Mem.Pop;

  Flag_S := (TTRR.LSB and $80) > 0; // 10000000
  Flag_Z := (TTRR.LSB and $40) > 0; // 01000000
  Flag_F5 := (TTRR.LSB and $20) > 0; // 00100000
  Flag_HF := (TTRR.LSB and $10) > 0; // 00010000
  Flag_F3 := (TTRR.LSB and $08) > 0; // 00001000
  Flag_PV := (TTRR.LSB and $04) > 0; // 00000100
  Flag_N := (TTRR.LSB and $02) > 0; // 00000010
  Flag_CY := (TTRR.LSB and $01) > 0; // 00000001
end;

procedure TCPUZ80.JP_P_Addr;
begin
  // $F2:
  if not Flag_S then
    JP_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.DI;
begin
  // $F3:
  FInterruptEnabled := False;
  Flag_IFF1 := False;
  Flag_IFF2 := False;
  //Result := 'di';
end;

procedure TCPUZ80.CALL_P_Addr;
begin
  // $F4:
  if not Flag_S then
    CALL_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.PUSH_AF;
begin
  // $F5:
  Mem.Push(Acc);
  TTRR.LSB := 0;

  if Flag_S then
    TTRR.LSB := TTRR.LSB or $80; // 10000000

  if Flag_Z then
    TTRR.LSB := TTRR.LSB or $40; // 01000000

  if F5 then
    TTRR.LSB := TTRR.LSB or $20; // 00100000

  if Flag_HF then
    TTRR.LSB := TTRR.LSB or $10; // 00010000

  if F3 then
    TTRR.LSB := TTRR.LSB or $08; // 00001000

  if Flag_PV then
    TTRR.LSB := TTRR.LSB or $04; // 00000100

  if Flag_N then
    TTRR.LSB := TTRR.LSB or $02; // 00000010

  if Flag_CY then
    TTRR.LSB := TTRR.LSB or $01; // 00000001

  Mem.Push(TTRR.LSB);
end;

procedure TCPUZ80.OR_Num;
var
  res: Byte;
begin
  // $F6:
  TTRR.LSB := Mem.ReadB(True);
  Acc := Acc or TTRR.LSB;
  Flag_Z := (Acc = 0);
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Acc and Trunc(Power(2, res))) <> 0);

  Flag_S := (Acc > 127);
  Flag_CY := False;
  Flag_PV := False;
  //Result := 'ori ' + IntToHex(TTRR.LSB, 2);
end;

procedure TCPUZ80.RST_48;
begin
  // $F7:
  CALL_(48);
  //Result := 'rst 6';
end;

procedure TCPUZ80.RET_N;
begin
  // $F8:
  if Flag_S then
    RET;
  //Result := 'rm';
end;

procedure TCPUZ80.LD_SP_HL;
begin
  // $F9:
  Mem.CurrSP := RPHL[HL_Index].HL;
end;

procedure TCPUZ80.JP_N_Addr;
begin
  // $FA:
  if Flag_S then
    JP_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.EI;
begin
  // $FB:
  FInterruptEnabled := True;
  Flag_IFF1 := True;
  Flag_IFF2 := True;
  //Result := 'ei';
end;

procedure TCPUZ80.CALL_N_Addr;
begin
  // $FC:
  if Flag_S then
    CALL_Addr
  else
    Mem.IncPC(2);
end;

procedure TCPUZ80.Alt_HL_To_IY;
begin
  // $FD:
  HL_Index := regIY;
end;

procedure TCPUZ80.CP_Num;
var
  res: Byte;
begin
  // $FE:
  TTRR.LSB := Mem.ReadB(True);
  Flag_Z := TTRR.LSB = Acc;
  Flag_CY := TTRR.LSB > Acc;
  Flag_S := (Max(Acc, -TTRR.LSB) > ABS(Min(Acc, -TTRR.LSB)));
  //Result := 'cpi ' + IntToHex(TTRR.LSB, 2);
  TTRR.LSB := Acc - TTRR.LSB;
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((TTRR.LSB and Trunc(Power(2, res))) <> 0);
end;

procedure TCPUZ80.RST_56;
begin
  // $FF:
  CALL_(56);
  //Result := 'rst 7';
end;

// $CB

procedure TCPUZ80.RLC(var Reg: Byte);
var
  res: Byte;
begin
  Flag_CY := Reg and $80 <> 0;
  Reg := Reg shl 1;

  if Flag_CY then
    Reg := Reg or $01;

  Flag_S := Reg > 127;
  Flag_Z := Reg = 0;
  Flag_F5 := (Reg and $20) = $20;
  Flag_HF := False;
  Flag_F3 := (Reg and 8) = 8;
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Reg and Trunc(Power(2, res))) <> 0);

  Flag_N := False;
end;

procedure TCPUZ80.RLC_B;
begin
  // CB 00
  RLC(RPBC.B);
  //Result := 'rcl b';
end;

procedure TCPUZ80.RLC_C;
begin
  // CB 01
  RLC(RPBC.C);
  //Result := 'rcl c';
end;

procedure TCPUZ80.RLC_D;
begin
  // CB 02
  RLC(RPDE.D);
  //Result := 'rcl RPDE.D';
end;

procedure TCPUZ80.RLC_E;
begin
  // CB 03
  RLC(RPDE.E);
  //Result := 'rcl RPDE.E';
end;

procedure TCPUZ80.RLC_H;
begin
  // CB 04
  RLC(RPHL[HL_Index].H);
  //Result := 'rcl h';
end;

procedure TCPUZ80.RLC_L;
begin
  // CB 05
  RLC(RPHL[HL_Index].L);
  //Result := 'rcl l';
end;

procedure TCPUZ80.RLC_MEM;
var
  Reg: Byte;
begin
  // CB 06
  Reg := Read_Addr_From_HL_IDX(True);
  RLC(Reg);
  Write_HL_IDX_To_Addr(True, Reg);
  //Result := 'rlc (hl)';
end;

procedure TCPUZ80.RLC_A;
begin
  // CB 07
  RLC(Acc);
  //Result := 'rcl l';
end;

procedure TCPUZ80.RRC(var Reg: Byte);
begin
  // $0F:
  Flag_CY := (Reg and $01) <> 0;
  Reg := Reg shr 1;
  if Flag_CY then
    Reg := Reg or $80;
end;

procedure TCPUZ80.RRC_B;
begin
  // CB 08
  RRC(RPBC.B);
  //Result := 'rrc b';
end;

procedure TCPUZ80.RRC_C;
begin
  // CB 09
  RRC(RPBC.C);
  //Result := 'rrc c';
end;

procedure TCPUZ80.RRC_D;
begin
  // CB 0A
  RRC(RPDE.D);
  //Result := 'rrc RPDE.D';
end;

procedure TCPUZ80.RRC_E;
begin
  // CB 0B
  RRC(RPDE.E);
  //Result := 'rrc RPDE.E';
end;

procedure TCPUZ80.RRC_H;
begin
  // CB 0C
  RRC(RPHL[HL_Index].H);
  //Result := 'rrc h';
end;

procedure TCPUZ80.RRC_L;
begin
  // CB 0D
  RRC(RPHL[HL_Index].L);
  //Result := 'rrc l';
end;

procedure TCPUZ80.RRC_MEM;
var
  Reg: Byte;
begin
  // CB 0E
  Reg := Read_Addr_From_HL_IDX(True);
  RRC(Reg);
  Write_HL_IDX_To_Addr(True, Reg);
  //Result := 'rrc (hl)';
end;

procedure TCPUZ80.RRC_A;
begin
  // CB 0F
  RRC(Acc);
  //Result := 'rrc a';
end;

procedure TCPUZ80.RL(var Reg: Byte);
begin
  if Reg and $80 <> 0 then
  begin
    Flag_CY := True;
    Reg := (Reg shl 1) or 1;
  end
  else
  begin
    Flag_CY := False;
    Reg := Reg shl 1;
  end;
end;

procedure TCPUZ80.RL_B;
begin
  // CB 10
  RL(RPBC.B);
  //Result := 'rl a';
end;

procedure TCPUZ80.RL_C;
begin
  // CB 11
  RL(RPBC.C);
  //Result := 'rl c';
end;

procedure TCPUZ80.RL_D;
begin
  // CB 12
  RL(RPDE.D);
  //Result := 'rl RPDE.D';
end;

procedure TCPUZ80.RL_E;
begin
  // CB 13
  RL(RPDE.E);
  //Result := 'rl RPDE.E';
end;

procedure TCPUZ80.RL_H;
begin
  // CB 14
  RL(RPHL[HL_Index].H);
  //Result := 'rl h';
end;

procedure TCPUZ80.RL_L;
begin
  // CB 15
  RL(RPHL[HL_Index].L);
  //Result := 'rl l';
end;

procedure TCPUZ80.RL_MEM;
var
  Reg: Byte;
begin
  // CB 16
  Reg := Read_Addr_From_HL_IDX(True);
  RL(Reg);
  Write_HL_IDX_To_Addr(True, Reg);
  //Result := 'rl (hl)';
end;

procedure TCPUZ80.RL_A;
begin
  // CB 17
  RL(Acc);
  //Result := 'rl a';
end;

procedure TCPUZ80.RR(var Reg: Byte);
begin
  if Reg and 1 <> 0 then
  begin
    Flag_CY := True;
    Reg := (Reg shr 1) or $80;
  end
  else
  begin
    Flag_CY := False;
    Reg := Reg shr 1;
  end;
end;

procedure TCPUZ80.RR_B;
begin
  // CB 18
  RR(RPBC.B);
  //Result := 'rr b';
end;

procedure TCPUZ80.RR_C;
begin
  // CB 19
  RR(RPBC.C);
  //Result := 'rr c';
end;

procedure TCPUZ80.RR_D;
begin
  // CB 1A
  RR(RPDE.D);
  //Result := 'rr RPDE.D';
end;

procedure TCPUZ80.RR_E;
begin
  // CB 1B
  RR(RPDE.E);
  //Result := 'rr RPDE.E';
end;

procedure TCPUZ80.RR_H;
begin
  // CB 1C
  RR(RPHL[HL_Index].H);
  //Result := 'rr h';
end;

procedure TCPUZ80.RR_L;
begin
  // CB 1D
  RR(RPHL[HL_Index].L);
  //Result := 'rr l';
end;

procedure TCPUZ80.RR_MEM;
var
  Reg: Byte;
begin
  // CB 1E
  Reg := Read_Addr_From_HL_IDX(True);
  RR(Reg);
  Write_HL_IDX_To_Addr(True, Reg);
  //Result := 'rr (hl)';
end;

procedure TCPUZ80.RR_A;
begin
  // CB 1F
  RR(Acc);
  //Result := 'rr a';
end;

procedure TCPUZ80.SLA(var Reg: Byte);
begin
  Flag_CY := Reg and $80 <> 0;
  Reg := Reg shl 1;
end;

procedure TCPUZ80.SLA_B;
begin
  // CB 20
  SLA(RPBC.B);
  //Result := 'sla b';
end;

procedure TCPUZ80.SLA_C;
begin
  // CB 21
  SLA(RPBC.C);
  //Result := 'sla c';
end;

procedure TCPUZ80.SLA_D;
begin
  // CB 22
  SLA(RPDE.D);
  //Result := 'sla RPDE.D';
end;

procedure TCPUZ80.SLA_E;
begin
  // CB 23
  SLA(RPDE.E);
  //Result := 'sla RPDE.E';
end;

procedure TCPUZ80.SLA_H;
begin
  // CB 24
  SLA(RPHL[HL_Index].H);
  //Result := 'sla h';
end;

procedure TCPUZ80.SLA_L;
begin
  // CB 25
  SLA(RPHL[HL_Index].L);
  //Result := 'sla l';
end;

procedure TCPUZ80.SLA_MEM;
var
  Reg: Byte;
begin
  // CB 26
  Reg := Read_Addr_From_HL_IDX(True);
  SLA(Reg);
  Write_HL_IDX_To_Addr(True, Reg);
  //Result := 'sla (hl)';
end;

procedure TCPUZ80.SLA_A;
begin
  // CB 27
  SLA(Acc);
  //Result := 'sla a';
end;

procedure TCPUZ80.SRA(var Reg: Byte);
begin
  Flag_CY := Reg and 1 <> 0;
  Reg := (Reg and $80) or (Reg shr 1);
end;

procedure TCPUZ80.SRA_B;
begin
  // CB 28
  SRA(RPBC.B);
  //Result := 'sla b';
end;

procedure TCPUZ80.SRA_C;
begin
  // CB 29
  SRA(RPBC.C);
  //Result := 'sla c';
end;

procedure TCPUZ80.SRA_D;
begin
  // CB 2A
  SRA(RPDE.D);
  //Result := 'sla RPDE.D';
end;

procedure TCPUZ80.SRA_E;
begin
  // CB 2B
  SRA(RPDE.E);
  //Result := 'sla RPDE.E';
end;

procedure TCPUZ80.SRA_H;
begin
  // CB 2C
  SRA(RPHL[HL_Index].H);
  //Result := 'sla h';
end;

procedure TCPUZ80.SRA_L;
begin
  // CB 2D
  SRA(RPHL[HL_Index].L);
  //Result := 'sla l';
end;

procedure TCPUZ80.SRA_MEM;
var
  Reg: Byte;
begin
  // CB 2E
  Reg := Read_Addr_From_HL_IDX(True);
  SRA(Reg);
  Write_HL_IDX_To_Addr(True, Reg);
  //Result := 'sra (hl)';
end;

procedure TCPUZ80.SRA_A;
begin
  // CB 2F
  SRA(Acc);
  //Result := 'sla a';
end;

procedure TCPUZ80.SLL(var Reg: Byte);
begin
  Flag_CY := Reg and $80 <> 0;
  Reg := (Reg shl 1) or 1;
end;

procedure TCPUZ80.SLL_B;
begin
  // CB 30
  SLL(RPBC.B);
  //Result := 'sll b';
end;

procedure TCPUZ80.SLL_C;
begin
  // CB 31
  SLL(RPBC.C);
  //Result := 'sll c';
end;

procedure TCPUZ80.SLL_D;
begin
  // CB 32
  SLL(RPDE.D);
  //Result := 'sll RPDE.D';
end;

procedure TCPUZ80.SLL_E;
begin
  // CB 33
  SLL(RPDE.E);
  //Result := 'sll RPDE.E';
end;

procedure TCPUZ80.SLL_H;
begin
  // CB 34
  SLL(RPHL[HL_Index].H);
  //Result := 'sll h';
end;

procedure TCPUZ80.SLL_L;
begin
  // CB 35
  SLL(RPHL[HL_Index].L);
  //Result := 'sll l';
end;

procedure TCPUZ80.SLL_MEM;
var
  Reg: Byte;
begin
  // CB 36
  Reg := Read_Addr_From_HL_IDX(True);
  SLL(Reg);
  Write_HL_IDX_To_Addr(True, Reg);
  //Result := 'sll (hl)';
end;

procedure TCPUZ80.SLL_A;
begin
  // CB 37
  SLL(Acc);
  //Result := 'sll a';
end;

procedure TCPUZ80.SRL(var Reg: Byte);
begin
  Flag_CY := Reg and $1 <> 0;
  Reg := Reg shr 1;
end;

procedure TCPUZ80.SRL_B;
begin
  // CB 38
  SRL(RPBC.B);
  //Result := 'srl b';
end;

procedure TCPUZ80.SRL_C;
begin
  // CB 39
  SRL(RPBC.C);
  //Result := 'srl c';
end;

procedure TCPUZ80.SRL_D;
begin
  // CB 3A
  SRL(RPDE.D);
  //Result := 'srl RPDE.D';
end;

procedure TCPUZ80.SRL_E;
begin
  // CB 3B
  SRL(RPDE.E);
  //Result := 'srl RPDE.E';
end;

procedure TCPUZ80.SRL_H;
begin
  // CB 3C
  SRL(RPHL[HL_Index].H);
  //Result := 'srl h';
end;

procedure TCPUZ80.SRL_L;
begin
  // CB 3D
  SRL(RPHL[HL_Index].L);
  //Result := 'srl l';
end;

procedure TCPUZ80.SRL_MEM;
var
  Reg: Byte;
begin
  // CB 3E
  Reg := Read_Addr_From_HL_IDX(True);
  SRL(Reg);
  Write_HL_IDX_To_Addr(True, Reg);
  //Result := 'srl (hl)';
end;

procedure TCPUZ80.SRL_A;
begin
  // CB 3F
  SRL(Acc);
  //Result := 'sll a';
end;

procedure TCPUZ80.BIT(Bit, Reg: Byte);
begin
  Flag_Z := (Reg and Trunc(Power(2, Bit))) = 0;
  Flag_S := (Bit = 7) and not Flag_Z;
  Flag_F5 := (Bit = 5) and not Flag_Z;
  Flag_HF := True;
  Flag_F3 := (Bit = 3) and not Flag_Z;
  Flag_PV := Flag_Z;
  Flag_N := False;
end;

procedure TCPUZ80.BIT_0_B;
begin
  // CB 40
  BIT(0, RPBC.B);
end;

procedure TCPUZ80.BIT_0_C;
begin
  // CB 41
  BIT(0, RPBC.C);
end;

procedure TCPUZ80.BIT_0_D;
begin
  // CB 42
  BIT(0, RPDE.D);
end;

procedure TCPUZ80.BIT_0_E;
begin
  // CB 43
  BIT(0, RPDE.E);
end;

procedure TCPUZ80.BIT_0_H;
begin
  // CB 44
  BIT(0, RPHL[regHL].H);
end;

procedure TCPUZ80.BIT_0_L;
begin
  // CB 45
  BIT(0, RPHL[regHL].L);
end;

procedure TCPUZ80.BIT_0_MEM;
begin
  // CB 46
  BIT(0, Read_Addr_From_HL_IDX(True));
end;

procedure TCPUZ80.BIT_0_A;
begin
  // CB 47
  BIT(0, Acc);
end;

procedure TCPUZ80.BIT_1_B;
begin
  // CB 48
  BIT(1, RPBC.B);
end;

procedure TCPUZ80.BIT_1_C;
begin
  // CB 49
  BIT(1, RPBC.C);
end;

procedure TCPUZ80.BIT_1_D;
begin
  // CB 4A
  BIT(1, RPDE.D);
end;

procedure TCPUZ80.BIT_1_E;
begin
  // CB 4B
  BIT(1, RPDE.E);
end;

procedure TCPUZ80.BIT_1_H;
begin
  // CB 4C
  BIT(1, RPHL[regHL].H);
end;

procedure TCPUZ80.BIT_1_L;
begin
  // CB 4D
  BIT(1, RPHL[regHL].L);
end;

procedure TCPUZ80.BIT_1_MEM;
begin
  // CB 4E
  BIT(1, Read_Addr_From_HL_IDX(True));
end;

procedure TCPUZ80.BIT_1_A;
begin
  // CB 4F
  BIT(1, Acc);
end;

procedure TCPUZ80.BIT_2_B;
begin
  // CB 50
  BIT(2, RPBC.B);
end;

procedure TCPUZ80.BIT_2_C;
begin
  // CB 51
  BIT(2, RPBC.C);
end;

procedure TCPUZ80.BIT_2_D;
begin
  // CB 52
  BIT(2, RPDE.D);
end;

procedure TCPUZ80.BIT_2_E;
begin
  // CB 53
  BIT(2, RPDE.E);
end;

procedure TCPUZ80.BIT_2_H;
begin
  // CB 54
  BIT(2, RPHL[regHL].H);
end;

procedure TCPUZ80.BIT_2_L;
begin
  // CB 55
  BIT(2, RPHL[regHL].L);
end;

procedure TCPUZ80.BIT_2_MEM;
begin
  // CB 56
  BIT(2, Read_Addr_From_HL_IDX(True));
end;

procedure TCPUZ80.BIT_2_A;
begin
  // CB 57
  BIT(2, Acc);
end;

procedure TCPUZ80.BIT_3_B;
begin
  // CB 58
  BIT(3, RPBC.B);
end;

procedure TCPUZ80.BIT_3_C;
begin
  // CB 59
  BIT(3, RPBC.C);
end;

procedure TCPUZ80.BIT_3_D;
begin
  // CB 5A
  BIT(3, RPDE.D);
end;

procedure TCPUZ80.BIT_3_E;
begin
  // CB 5B
  BIT(3, RPDE.E);
end;

procedure TCPUZ80.BIT_3_H;
begin
  // CB 5C
  BIT(3, RPHL[regHL].H);
end;

procedure TCPUZ80.BIT_3_L;
begin
  // CB 5D
  BIT(3, RPHL[regHL].L);
end;

procedure TCPUZ80.BIT_3_MEM;
begin
  // CB 5E
  BIT(3, Read_Addr_From_HL_IDX(True));
end;

procedure TCPUZ80.BIT_3_A;
begin
  // CB 5F
  BIT(3, Acc);
end;

procedure TCPUZ80.BIT_4_B;
begin
  // CB 60
  BIT(4, RPBC.B);
end;

procedure TCPUZ80.BIT_4_C;
begin
  // CB 61
  BIT(4, RPBC.C);
end;

procedure TCPUZ80.BIT_4_D;
begin
  // CB 62
  BIT(4, RPDE.D);
end;

procedure TCPUZ80.BIT_4_E;
begin
  // CB 63
  BIT(4, RPDE.E);
end;

procedure TCPUZ80.BIT_4_H;
begin
  // CB 64
  BIT(4, RPHL[regHL].H);
end;

procedure TCPUZ80.BIT_4_L;
begin
  // CB 65
  BIT(4, RPHL[regHL].L);
end;

procedure TCPUZ80.BIT_4_MEM;
begin
  // CB 66
  BIT(4, Read_Addr_From_HL_IDX(True));
end;

procedure TCPUZ80.BIT_4_A;
begin
  // CB 67
  BIT(4, Acc);
end;

procedure TCPUZ80.BIT_5_B;
begin
  // CB 68
  BIT(5, RPBC.B);
end;

procedure TCPUZ80.BIT_5_C;
begin
  // CB 69
  BIT(5, RPBC.C);
end;

procedure TCPUZ80.BIT_5_D;
begin
  // CB 6A
  BIT(5, RPDE.D);
end;

procedure TCPUZ80.BIT_5_E;
begin
  // CB 6B
  BIT(5, RPDE.E);
end;

procedure TCPUZ80.BIT_5_H;
begin
  // CB 6C
  BIT(5, RPHL[regHL].H);
end;

procedure TCPUZ80.BIT_5_L;
begin
  // CB 6D
  BIT(5, RPHL[regHL].L);
end;

procedure TCPUZ80.BIT_5_MEM;
begin
  // CB 6E
  BIT(5, Read_Addr_From_HL_IDX(True));
end;

procedure TCPUZ80.BIT_5_A;
begin
  // CB 6F
  BIT(5, Acc);
end;

procedure TCPUZ80.BIT_6_B;
begin
  // CB 70
  BIT(6, RPBC.B);
end;

procedure TCPUZ80.BIT_6_C;
begin
  // CB 71
  BIT(6, RPBC.C);
end;

procedure TCPUZ80.BIT_6_D;
begin
  // CB 72
  BIT(6, RPDE.D);
end;

procedure TCPUZ80.BIT_6_E;
begin
  // CB 73
  BIT(6, RPDE.E);
end;

procedure TCPUZ80.BIT_6_H;
begin
  // CB 74
  BIT(6, RPHL[regHL].H);
end;

procedure TCPUZ80.BIT_6_L;
begin
  // CB 75
  BIT(6, RPHL[regHL].L);
end;

procedure TCPUZ80.BIT_6_MEM;
begin
  // CB 76
  BIT(6, Read_Addr_From_HL_IDX(True));
end;

procedure TCPUZ80.BIT_6_A;
begin
  // CB 77
  BIT(6, Acc);
end;

procedure TCPUZ80.BIT_7_B;
begin
  // CB 78
  BIT(7, RPBC.B);
end;

procedure TCPUZ80.BIT_7_C;
begin
  // CB 79
  BIT(7, RPBC.C);
end;

procedure TCPUZ80.BIT_7_D;
begin
  // CB 7A
  BIT(7, RPDE.D);
end;

procedure TCPUZ80.BIT_7_E;
begin
  // CB 7B
  BIT(7, RPDE.E);
end;

procedure TCPUZ80.BIT_7_H;
begin
  // CB 7C
  BIT(7, RPHL[regHL].H);
end;

procedure TCPUZ80.BIT_7_L;
begin
  // CB 7D
  BIT(7, RPHL[regHL].L);
end;

procedure TCPUZ80.BIT_7_MEM;
begin
  // CB 7E
  BIT(7, Read_Addr_From_HL_IDX(True));
end;

procedure TCPUZ80.BIT_7_A;
begin
  // CB 7F
  BIT(7, Acc);
end;

procedure TCPUZ80.RESETBIT(Bit: Byte; var Reg: Byte);
begin
  Reg := Reg and (Trunc(Power(2, Bit)) xor $FF);
end;

procedure TCPUZ80.RES_0_B;
begin
  // CB 80
  RESETBIT(0, RPBC.B);
end;

procedure TCPUZ80.RES_0_C;
begin
  // CB 81
  RESETBIT(0, RPBC.C);
end;

procedure TCPUZ80.RES_0_D;
begin
  // CB 82
  RESETBIT(0, RPDE.D);
end;

procedure TCPUZ80.RES_0_E;
begin
  // CB 83
  RESETBIT(0, RPDE.E);
end;

procedure TCPUZ80.RES_0_H;
begin
  // CB 84
  RESETBIT(0, RPHL[regHL].H);
end;

procedure TCPUZ80.RES_0_L;
begin
  // CB 85
  RESETBIT(0, RPHL[regHL].L);
end;

procedure TCPUZ80.RES_0_MEM;
begin
  // CB 86
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  RESETBIT(0, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.RES_0_A;
begin
  // CB 87
  RESETBIT(0, Acc);
end;

procedure TCPUZ80.RES_1_B;
begin
  // CB 88
  RESETBIT(1, RPBC.B);
end;

procedure TCPUZ80.RES_1_C;
begin
  // CB 89
  RESETBIT(1, RPBC.C);
end;

procedure TCPUZ80.RES_1_D;
begin
  // CB 8A
  RESETBIT(1, RPDE.D);
end;

procedure TCPUZ80.RES_1_E;
begin
  // CB 8B
  RESETBIT(1, RPDE.E);
end;

procedure TCPUZ80.RES_1_H;
begin
  // CB 8C
  RESETBIT(1, RPHL[regHL].H);
end;

procedure TCPUZ80.RES_1_L;
begin
  // CB 8D
  RESETBIT(1, RPHL[regHL].L);
end;

procedure TCPUZ80.RES_1_MEM;
begin
  // CB 8E
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  RESETBIT(1, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.RES_1_A;
begin
  // CB 8F
  RESETBIT(1, Acc);
end;

procedure TCPUZ80.RES_2_B;
begin
  // CB 90
  RESETBIT(2, RPBC.B);
end;

procedure TCPUZ80.RES_2_C;
begin
  // CB 91
  RESETBIT(2, RPBC.C);
end;

procedure TCPUZ80.RES_2_D;
begin
  // CB 92
  RESETBIT(2, RPDE.D);
end;

procedure TCPUZ80.RES_2_E;
begin
  // CB 93
  RESETBIT(2, RPDE.E);
end;

procedure TCPUZ80.RES_2_H;
begin
  // CB 94
  RESETBIT(2, RPHL[regHL].H);
end;

procedure TCPUZ80.RES_2_L;
begin
  // CB 95
  RESETBIT(2, RPHL[regHL].L);
end;

procedure TCPUZ80.RES_2_MEM;
begin
  // CB 96
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  RESETBIT(2, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.RES_2_A;
begin
  // CB 97
  RESETBIT(2, Acc);
end;

procedure TCPUZ80.RES_3_B;
begin
  // CB 98
  RESETBIT(3, RPBC.B);
end;

procedure TCPUZ80.RES_3_C;
begin
  // CB 99
  RESETBIT(3, RPBC.C);
end;

procedure TCPUZ80.RES_3_D;
begin
  // CB 9A
  RESETBIT(3, RPDE.D);
end;

procedure TCPUZ80.RES_3_E;
begin
  // CB 9B
  RESETBIT(3, RPDE.E);
end;

procedure TCPUZ80.RES_3_H;
begin
  // CB 9C
  RESETBIT(3, RPHL[regHL].H);
end;

procedure TCPUZ80.RES_3_L;
begin
  // CB 9D
  RESETBIT(3, RPHL[regHL].L);
end;

procedure TCPUZ80.RES_3_MEM;
begin
  // CB 9E
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  RESETBIT(3, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.RES_3_A;
begin
  // CB 9F
  RESETBIT(3, Acc);
end;

procedure TCPUZ80.RES_4_B;
begin
  // CB A0
  RESETBIT(4, RPBC.B);
end;

procedure TCPUZ80.RES_4_C;
begin
  // CB A1
  RESETBIT(4, RPBC.C);
end;

procedure TCPUZ80.RES_4_D;
begin
  // CB A2
  RESETBIT(4, RPDE.D);
end;

procedure TCPUZ80.RES_4_E;
begin
  // CB A3
  RESETBIT(4, RPDE.E);
end;

procedure TCPUZ80.RES_4_H;
begin
  // CB A4
  RESETBIT(4, RPHL[regHL].H);
end;

procedure TCPUZ80.RES_4_L;
begin
  // CB A5
  RESETBIT(4, RPHL[regHL].L);
end;

procedure TCPUZ80.RES_4_MEM;
begin
  // CB A6
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  RESETBIT(4, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.RES_4_A;
begin
  // CB A7
  RESETBIT(4, Acc);
end;

procedure TCPUZ80.RES_5_B;
begin
  // CB A8
  RESETBIT(5, RPBC.B);
end;

procedure TCPUZ80.RES_5_C;
begin
  // CB A9
  RESETBIT(5, RPBC.C);
end;

procedure TCPUZ80.RES_5_D;
begin
  // CB AA
  RESETBIT(5, RPDE.D);
end;

procedure TCPUZ80.RES_5_E;
begin
  // CB AB
  RESETBIT(5, RPDE.E);
end;

procedure TCPUZ80.RES_5_H;
begin
  // CB AC
  RESETBIT(5, RPHL[regHL].H);
end;

procedure TCPUZ80.RES_5_L;
begin
  // CB AD
  RESETBIT(5, RPHL[regHL].L);
end;

procedure TCPUZ80.RES_5_MEM;
begin
  // CB AE
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  RESETBIT(5, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.RES_5_A;
begin
  // CB AF
  RESETBIT(5, Acc);
end;

procedure TCPUZ80.RES_6_B;
begin
  // CB B0
  RESETBIT(6, RPBC.B);
end;

procedure TCPUZ80.RES_6_C;
begin
  // CB B1
  RESETBIT(6, RPBC.C);
end;

procedure TCPUZ80.RES_6_D;
begin
  // CB B2
  RESETBIT(6, RPDE.D);
end;

procedure TCPUZ80.RES_6_E;
begin
  // CB B3
  RESETBIT(6, RPDE.E);
end;

procedure TCPUZ80.RES_6_H;
begin
  // CB B4
  RESETBIT(6, RPHL[regHL].H);
end;

procedure TCPUZ80.RES_6_L;
begin
  // CB B5
  RESETBIT(6, RPHL[regHL].L);
end;

procedure TCPUZ80.RES_6_MEM;
begin
  // CB B6
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  RESETBIT(6, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.RES_6_A;
begin
  // CB B7
  RESETBIT(6, Acc);
end;

procedure TCPUZ80.RES_7_B;
begin
  // CB B8
  RESETBIT(7, RPBC.B);
end;

procedure TCPUZ80.RES_7_C;
begin
  // CB B9
  RESETBIT(7, RPBC.C);
end;

procedure TCPUZ80.RES_7_D;
begin
  // CB BA
  RESETBIT(7, RPDE.D);
end;

procedure TCPUZ80.RES_7_E;
begin
  // CB BB
  RESETBIT(7, RPDE.E);
end;

procedure TCPUZ80.RES_7_H;
begin
  // CB BC
  RESETBIT(7, RPHL[regHL].H);
end;

procedure TCPUZ80.RES_7_L;
begin
  // CB BD
  RESETBIT(7, RPHL[regHL].L);
end;

procedure TCPUZ80.RES_7_MEM;
begin
  // CB BE
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  RESETBIT(7, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.RES_7_A;
begin
  // CB BF
  RESETBIT(7, Acc);
end;

procedure TCPUZ80.SETBIT(Bit: Byte; var Reg: Byte);
begin
  Reg := Reg or Trunc(Power(2, Bit));
end;

procedure TCPUZ80.SET_0_B;
begin
  // CB C0
  SETBIT(0, RPBC.B);
end;

procedure TCPUZ80.SET_0_C;
begin
  // CB C1
  SETBIT(0, RPBC.C);
end;

procedure TCPUZ80.SET_0_D;
begin
  // CB C2
  SETBIT(0, RPDE.D);
end;

procedure TCPUZ80.SET_0_E;
begin
  // CB C3
  SETBIT(0, RPDE.E);
end;

procedure TCPUZ80.SET_0_H;
begin
  // CB C4
  SETBIT(0, RPHL[regHL].H);
end;

procedure TCPUZ80.SET_0_L;
begin
  // CB C5
  SETBIT(0, RPHL[regHL].L);
end;

procedure TCPUZ80.SET_0_MEM;
begin
  // CB C6
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SETBIT(0, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.SET_0_A;
begin
  // CB C7
  SETBIT(0, Acc);
end;

procedure TCPUZ80.SET_1_B;
begin
  // CB C8
  SETBIT(1, RPBC.B);
end;

procedure TCPUZ80.SET_1_C;
begin
  // CB C9
  SETBIT(1, RPBC.C);
end;

procedure TCPUZ80.SET_1_D;
begin
  // CB CA
  SETBIT(1, RPDE.D);
end;

procedure TCPUZ80.SET_1_E;
begin
  // CB CB
  SETBIT(1, RPDE.E);
end;

procedure TCPUZ80.SET_1_H;
begin
  // CB CC
  SETBIT(1, RPHL[regHL].H);
end;

procedure TCPUZ80.SET_1_L;
begin
  // CB CD
  SETBIT(1, RPHL[regHL].L);
end;

procedure TCPUZ80.SET_1_MEM;
begin
  // CB CE
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SETBIT(1, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.SET_1_A;
begin
  // CB CF
  SETBIT(1, Acc);
end;

procedure TCPUZ80.SET_2_B;
begin
  // CB D0
  SETBIT(2, RPBC.B);
end;

procedure TCPUZ80.SET_2_C;
begin
  // CB D1
  SETBIT(2, RPBC.C);
end;

procedure TCPUZ80.SET_2_D;
begin
  // CB D2
  SETBIT(2, RPDE.D);
end;

procedure TCPUZ80.SET_2_E;
begin
  // CB D3
  SETBIT(2, RPDE.E);
end;

procedure TCPUZ80.SET_2_H;
begin
  // CB D4
  SETBIT(2, RPHL[regHL].H);
end;

procedure TCPUZ80.SET_2_L;
begin
  // CB D5
  SETBIT(2, RPHL[regHL].L);
end;

procedure TCPUZ80.SET_2_MEM;
begin
  // CB D6
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SETBIT(2, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.SET_2_A;
begin
  // CB D7
  SETBIT(2, Acc);
end;

procedure TCPUZ80.SET_3_B;
begin
  // CB D8
  SETBIT(3, RPBC.B);
end;

procedure TCPUZ80.SET_3_C;
begin
  // CB D9
  SETBIT(3, RPBC.C);
end;

procedure TCPUZ80.SET_3_D;
begin
  // CB DA
  SETBIT(3, RPDE.D);
end;

procedure TCPUZ80.SET_3_E;
begin
  // CB DB
  SETBIT(3, RPDE.E);
end;

procedure TCPUZ80.SET_3_H;
begin
  // CB DC
  SETBIT(3, RPHL[regHL].H);
end;

procedure TCPUZ80.SET_3_L;
begin
  // CB DD
  SETBIT(3, RPHL[regHL].L);
end;

procedure TCPUZ80.SET_3_MEM;
begin
  // CB DE
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SETBIT(3, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.SET_3_A;
begin
  // CB DF
  SETBIT(3, Acc);
end;

procedure TCPUZ80.SET_4_B;
begin
  // CB E0
  SETBIT(4, RPBC.B);
end;

procedure TCPUZ80.SET_4_C;
begin
  // CB E1
  SETBIT(4, RPBC.C);
end;

procedure TCPUZ80.SET_4_D;
begin
  // CB E2
  SETBIT(4, RPDE.D);
end;

procedure TCPUZ80.SET_4_E;
begin
  // CB E3
  SETBIT(4, RPDE.E);
end;

procedure TCPUZ80.SET_4_H;
begin
  // CB E4
  SETBIT(4, RPHL[regHL].H);
end;

procedure TCPUZ80.SET_4_L;
begin
  // CB E5
  SETBIT(4, RPHL[regHL].L);
end;

procedure TCPUZ80.SET_4_MEM;
begin
  // CB E6
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SETBIT(4, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.SET_4_A;
begin
  // CB E7
  SETBIT(4, Acc);
end;

procedure TCPUZ80.SET_5_B;
begin
  // CB E8
  SETBIT(5, RPBC.B);
end;

procedure TCPUZ80.SET_5_C;
begin
  // CB E9
  SETBIT(5, RPBC.C);
end;

procedure TCPUZ80.SET_5_D;
begin
  // CB EA
  SETBIT(5, RPDE.D);
end;

procedure TCPUZ80.SET_5_E;
begin
  // CB EB
  SETBIT(5, RPDE.E);
end;

procedure TCPUZ80.SET_5_H;
begin
  // CB EC
  SETBIT(5, RPHL[regHL].H);
end;

procedure TCPUZ80.SET_5_L;
begin
  // CB ED
  SETBIT(5, RPHL[regHL].L);
end;

procedure TCPUZ80.SET_5_MEM;
begin
  // CB EE
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SETBIT(5, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.SET_5_A;
begin
  // CB EF
  SETBIT(5, Acc);
end;

procedure TCPUZ80.SET_6_B;
begin
  // CB F0
  SETBIT(6, RPBC.B);
end;

procedure TCPUZ80.SET_6_C;
begin
  // CB F1
  SETBIT(6, RPBC.C);
end;

procedure TCPUZ80.SET_6_D;
begin
  // CB F2
  SETBIT(6, RPDE.D);
end;

procedure TCPUZ80.SET_6_E;
begin
  // CB F3
  SETBIT(6, RPDE.E);
end;

procedure TCPUZ80.SET_6_H;
begin
  // CB F4
  SETBIT(6, RPHL[regHL].H);
end;

procedure TCPUZ80.SET_6_L;
begin
  // CB F5
  SETBIT(6, RPHL[regHL].L);
end;

procedure TCPUZ80.SET_6_MEM;
begin
  // CB F6
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SETBIT(6, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.SET_6_A;
begin
  // CB F7
  SETBIT(6, Acc);
end;

procedure TCPUZ80.SET_7_B;
begin
  // CB F8
  SETBIT(7, RPBC.B);
end;

procedure TCPUZ80.SET_7_C;
begin
  // CB F9
  SETBIT(7, RPBC.C);
end;

procedure TCPUZ80.SET_7_D;
begin
  // CB FA
  SETBIT(7, RPDE.D);
end;

procedure TCPUZ80.SET_7_E;
begin
  // CB FB
  SETBIT(7, RPDE.E);
end;

procedure TCPUZ80.SET_7_H;
begin
  // CB FC
  SETBIT(7, RPHL[regHL].H);
end;

procedure TCPUZ80.SET_7_L;
begin
  // CB FD
  SETBIT(7, RPHL[regHL].L);
end;

procedure TCPUZ80.SET_7_MEM;
begin
  // CB FE
  TTRR.LSB := Read_Addr_From_HL_IDX(True);
  SETBIT(7, TTRR.LSB);
  Write_HL_IDX_To_Addr(True, TTRR.LSB);
end;

procedure TCPUZ80.SET_7_A;
begin
  // CB FF
  SETBIT(7, Acc);
end;

// $DD/$FD $CB

procedure TCPUZ80.LD_Reg_RLC_IDX_Num(var Reg: Byte);
begin
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  RLC(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
  Reg := TTRR.LSB
end;

procedure TCPUZ80.LD_B_RLC_IDX_Num;
begin
  // DD/FD CB NUM 00
  LD_Reg_RLC_IDX_Num(RPBC.B);
end;

procedure TCPUZ80.LD_C_RLC_IDX_Num;
begin
  // DD/FD CB NUM 01
  LD_Reg_RLC_IDX_Num(RPBC.C);
end;

procedure TCPUZ80.LD_D_RLC_IDX_Num;
begin
  // DD/FD CB NUM 02
  LD_Reg_RLC_IDX_Num(RPDE.D);
end;

procedure TCPUZ80.LD_E_RLC_IDX_Num;
begin
  // DD/FD CB NUM 03
  LD_Reg_RLC_IDX_Num(RPDE.E);
end;

procedure TCPUZ80.LD_H_RLC_IDX_Num;
begin
  // DD/FD CB NUM 04
  LD_Reg_RLC_IDX_Num(RPHL[regHL].H);
end;

procedure TCPUZ80.LD_L_RLC_IDX_Num;
begin
  // DD/FD CB NUM 05
  LD_Reg_RLC_IDX_Num(RPHL[regHL].L);
end;

procedure TCPUZ80.RLC_IDX_Num;
begin
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RLC_IDX_Num(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RLC_IDX_Num;
begin
  // DD/FD CB NUM 07
  LD_Reg_RLC_IDX_Num(Acc);
end;

procedure TCPUZ80.LD_Reg_RRC_IDX_Num(var Reg: Byte);
begin
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  RRC(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
  Reg := TTRR.LSB
end;

procedure TCPUZ80.LD_B_RRC_IDX_Num;
begin
  // DD/FD CB NUM 08
  LD_Reg_RRC_IDX_Num(RPBC.B);
end;

procedure TCPUZ80.LD_C_RRC_IDX_Num;
begin
  // DD/FD CB NUM 09
  LD_Reg_RRC_IDX_Num(RPBC.C);
end;

procedure TCPUZ80.LD_D_RRC_IDX_Num;
begin
  // DD/FD CB NUM 0A
  LD_Reg_RRC_IDX_Num(RPDE.D);
end;

procedure TCPUZ80.LD_E_RRC_IDX_Num;
begin
  // DD/FD CB NUM 0B
  LD_Reg_RRC_IDX_Num(RPDE.E);
end;

procedure TCPUZ80.LD_H_RRC_IDX_Num;
begin
  // DD/FD CB NUM 0C
  LD_Reg_RRC_IDX_Num(RPHL[regHL].H);
end;

procedure TCPUZ80.LD_L_RRC_IDX_Num;
begin
  // DD/FD CB NUM 0D
  LD_Reg_RRC_IDX_Num(RPHL[regHL].L);
end;

procedure TCPUZ80.RRC_IDX_Num;
begin
  // DD CB NUM 0E
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RRC_IDX_Num(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RRC_IDX_Num;
begin
  // DD/FD CB NUM 0F
  LD_Reg_RRC_IDX_Num(Acc);
end;

procedure TCPUZ80.LD_Reg_RL_IDX_Num(var Reg: Byte);
begin
  InternalRP.WordVal := Read_Addr_From_HL_IDX(False) shl 1;

  if Flag_CY then
    InternalRP.WordVal := InternalRP.WordVal or $01;

  Flag_CY := InternalRP.MSB <> 0;
  Flag_F5 := (InternalRP.LSB and $20) = $20;
  Flag_HF := False;
  Flag_F3 := (InternalRP.LSB and 8) = 8;
  Flag_N := False;
  Write_HL_IDX_To_Addr(False, InternalRP.LSB);
  Reg := InternalRP.LSB;
end;

procedure TCPUZ80.LD_B_RL_IDX_Num;
begin
  // DD/FD CB NUM 10
  LD_Reg_RL_IDX_Num(RPBC.B);
end;

procedure TCPUZ80.LD_C_RL_IDX_Num;
begin
  // DD/FD CB NUM 11
  LD_Reg_RL_IDX_Num(RPBC.C);
end;

procedure TCPUZ80.LD_D_RL_IDX_Num;
begin
  // DD/FD CB NUM 12
  LD_Reg_RL_IDX_Num(RPDE.D);
end;

procedure TCPUZ80.LD_E_RL_IDX_Num;
begin
  // DD/FD CB NUM 13
  LD_Reg_RL_IDX_Num(RPDE.E);
end;

procedure TCPUZ80.LD_H_RL_IDX_Num;
begin
  // DD/FD CB NUM 14
  LD_Reg_RL_IDX_Num(RPHL[regHL].H);
end;

procedure TCPUZ80.LD_L_RL_IDX_Num;
begin
  // DD/FD CB NUM 15
  LD_Reg_RL_IDX_Num(RPHL[regHL].L);
end;

procedure TCPUZ80.RL_IDX_Num;
begin
  // DD CB NUM 16
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RL_IDX_Num(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RL_IDX_Num;
begin
  // DD/FD CB NUM 17
  LD_Reg_RL_IDX_Num(Acc);
end;

procedure TCPUZ80.LD_Reg_RR_IDX_Num(var Reg: Byte);
begin
  InternalRP.MSB := Read_Addr_From_HL_IDX(False);
  InternalRP.LSB := 0;
  InternalRP.WordVal := InternalRP.WordVal shr 1;
  if Flag_CY then
    InternalRP.MSB := InternalRP.MSB or $80;
  Flag_CY := InternalRP.LSB <> 0;
  Flag_F5 := (InternalRP.MSB and $20) = $20;
  Flag_HF := False;
  Flag_F3 := (InternalRP.MSB and 8) = 8;
  Flag_N := False;
  Write_HL_IDX_To_Addr(False, InternalRP.MSB);
  Reg := InternalRP.LSB;
end;

procedure TCPUZ80.LD_B_RR_IDX_Num;
begin
  // DD/FD CB NUM 18
  LD_Reg_RR_IDX_Num(RPBC.B);
end;

procedure TCPUZ80.LD_C_RR_IDX_Num;
begin
  // DD/FD CB NUM 19
  LD_Reg_RR_IDX_Num(RPBC.C);
end;

procedure TCPUZ80.LD_D_RR_IDX_Num;
begin
  // DD/FD CB NUM 1A
  LD_Reg_RR_IDX_Num(RPDE.D);
end;

procedure TCPUZ80.LD_E_RR_IDX_Num;
begin
  // DD/FD CB NUM 1B
  LD_Reg_RR_IDX_Num(RPDE.E);
end;

procedure TCPUZ80.LD_H_RR_IDX_Num;
begin
  // DD/FD CB NUM 1C
  LD_Reg_RR_IDX_Num(RPHL[regHL].H);
end;

procedure TCPUZ80.LD_L_RR_IDX_Num;
begin
  // DD/FD CB NUM 1D
  LD_Reg_RR_IDX_Num(RPHL[regHL].L);
end;

procedure TCPUZ80.RR_IDX_Num;
begin
  // DD CB NUM 1E
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RR_IDX_Num(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RR_IDX_Num;
begin
  // DD/FD CB NUM 1F
  LD_Reg_RR_IDX_Num(Acc);
end;

procedure TCPUZ80.LD_Reg_SLA_IDX_Num(var Reg: Byte);
begin
  InternalRP.WordVal := Read_Addr_From_HL_IDX(False) shl 1;
  Flag_CY := InternalRP.MSB <> 0;
  Flag_F5 := (InternalRP.LSB and $20) = $20;
  Flag_HF := False;
  Flag_F3 := (InternalRP.LSB and 8) = 8;
  Flag_N := False;
  Write_HL_IDX_To_Addr(False, InternalRP.LSB);
  Reg := InternalRP.LSB;
end;

procedure TCPUZ80.LD_B_SLA_IDX_Num;
begin
  // DD/FD CB NUM 20
  LD_Reg_SLA_IDX_Num(RPBC.B);
end;

procedure TCPUZ80.LD_C_SLA_IDX_Num;
begin
  // DD/FD CB NUM 21
  LD_Reg_SLA_IDX_Num(RPBC.C);
end;

procedure TCPUZ80.LD_D_SLA_IDX_Num;
begin
  // DD/FD CB NUM 22
  LD_Reg_SLA_IDX_Num(RPDE.D);
end;

procedure TCPUZ80.LD_E_SLA_IDX_Num;
begin
  // DD/FD CB NUM 23
  LD_Reg_SLA_IDX_Num(RPDE.E);
end;

procedure TCPUZ80.LD_H_SLA_IDX_Num;
begin
  // DD/FD CB NUM 24
  LD_Reg_SLA_IDX_Num(RPHL[regHL].H);
end;

procedure TCPUZ80.LD_L_SLA_IDX_Num;
begin
  // DD/FD CB NUM 25
  LD_Reg_SLA_IDX_Num(RPHL[regHL].L);
end;

procedure TCPUZ80.SLA_IDX_Num;
begin
  // DD CB NUM 26
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SLA_IDX_Num(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SLA_IDX_Num;
begin
  // DD/FD CB NUM 27
  LD_Reg_SLA_IDX_Num(Acc);
end;

procedure TCPUZ80.LD_Reg_SRA_IDX_Num(var Reg: Byte);
begin
  InternalRP.LSB := Read_Addr_From_HL_IDX(False);
  Flag_CY := InternalRP.LSB and 1 <> 0;
  InternalRP.LSB := (InternalRP.LSB and $80) or (InternalRP.LSB shr 1);
  Flag_F5 := (InternalRP.LSB and $20) = $20;
  Flag_HF := False;
  Flag_F3 := (InternalRP.LSB and 8) = 8;
  Flag_N := False;
  Write_HL_IDX_To_Addr(False, InternalRP.LSB);
  Reg := InternalRP.LSB;
end;

procedure TCPUZ80.LD_B_SRA_IDX_Num;
begin
  // DD/FD CB NUM 28
  LD_Reg_SRA_IDX_Num(RPBC.B);
end;

procedure TCPUZ80.LD_C_SRA_IDX_Num;
begin
  // DD/FD CB NUM 29
  LD_Reg_SRA_IDX_Num(RPBC.C);
end;

procedure TCPUZ80.LD_D_SRA_IDX_Num;
begin
  // DD/FD CB NUM 2A
  LD_Reg_SRA_IDX_Num(RPDE.D);
end;

procedure TCPUZ80.LD_E_SRA_IDX_Num;
begin
  // DD/FD CB NUM 2B
  LD_Reg_SRA_IDX_Num(RPDE.E);
end;

procedure TCPUZ80.LD_H_SRA_IDX_Num;
begin
  // DD/FD CB NUM 2C
  LD_Reg_SRA_IDX_Num(RPHL[regHL].H);
end;

procedure TCPUZ80.LD_L_SRA_IDX_Num;
begin
  // DD/FD CB NUM 2D
  LD_Reg_SRA_IDX_Num(RPHL[regHL].L);
end;

procedure TCPUZ80.SRA_IDX_Num;
begin
  // DD CB NUM 2E
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SRA_IDX_Num(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SRA_IDX_Num;
begin
  // DD/FD CB NUM 2F
  LD_Reg_SRA_IDX_Num(Acc);
end;

procedure TCPUZ80.LD_Reg_SLL_IDX_Num(var Reg: Byte);
begin
  InternalRP.LSB := Read_Addr_From_HL_IDX(False);
  Flag_CY := InternalRP.LSB and $80 <> 0;
  InternalRP.LSB := (InternalRP.LSB shl 1) or 1;
  Write_HL_IDX_To_Addr(False, InternalRP.LSB);
  Reg := InternalRP.LSB;
end;

procedure TCPUZ80.LD_B_SLL_IDX_Num;
begin
  // DD/FD CB NUM 30
  LD_Reg_SLL_IDX_Num(RPBC.B);
end;

procedure TCPUZ80.LD_C_SLL_IDX_Num;
begin
  // DD/FD CB NUM 31
  LD_Reg_SLL_IDX_Num(RPBC.C);
end;

procedure TCPUZ80.LD_D_SLL_IDX_Num;
begin
  // DD/FD CB NUM 32
  LD_Reg_SLL_IDX_Num(RPDE.D);
end;

procedure TCPUZ80.LD_E_SLL_IDX_Num;
begin
  // DD/FD CB NUM 33
  LD_Reg_SLL_IDX_Num(RPDE.E);
end;

procedure TCPUZ80.LD_H_SLL_IDX_Num;
begin
  // DD/FD CB NUM 34
  LD_Reg_SLL_IDX_Num(RPHL[regHL].H);
end;

procedure TCPUZ80.LD_L_SLL_IDX_Num;
begin
  // DD/FD CB NUM 35
  LD_Reg_SLL_IDX_Num(RPHL[regHL].L);
end;

procedure TCPUZ80.SLL_IDX_Num;
begin
  // DD CB NUM 36
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SLL_IDX_Num(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SLL_IDX_Num;
begin
  // DD/FD CB NUM 37
  LD_Reg_SLL_IDX_Num(Acc);
end;

procedure TCPUZ80.LD_Reg_SRL_IDX_Num(var Reg: Byte);
begin
  InternalRP.LSB := Read_Addr_From_HL_IDX(False);
  Flag_CY := InternalRP.LSB and 1 <> 0;
  InternalRP.LSB := InternalRP.LSB shr 1;
  Flag_F5 := (InternalRP.LSB and $20) = $20;
  Flag_HF := False;
  Flag_F3 := (InternalRP.LSB and 8) = 8;
  Flag_N := False;
  Write_HL_IDX_To_Addr(False, InternalRP.LSB);
  Reg := InternalRP.LSB;
end;

procedure TCPUZ80.LD_B_SRL_IDX_Num;
begin
  // DD/FD CB NUM 38
  LD_Reg_SRL_IDX_Num(RPBC.B);
end;

procedure TCPUZ80.LD_C_SRL_IDX_Num;
begin
  // DD/FD CB NUM 39
  LD_Reg_SRL_IDX_Num(RPBC.C);
end;

procedure TCPUZ80.LD_D_SRL_IDX_Num;
begin
  // DD/FD CB NUM 3A
  LD_Reg_SRL_IDX_Num(RPDE.D);
end;

procedure TCPUZ80.LD_E_SRL_IDX_Num;
begin
  // DD/FD CB NUM 3B
  LD_Reg_SRL_IDX_Num(RPDE.E);
end;

procedure TCPUZ80.LD_H_SRL_IDX_Num;
begin
  // DD/FD CB NUM 3C
  LD_Reg_SRL_IDX_Num(RPHL[regHL].H);
end;

procedure TCPUZ80.LD_L_SRL_IDX_Num;
begin
  // DD/FD CB NUM 3D
  LD_Reg_SRL_IDX_Num(RPHL[regHL].L);
end;

procedure TCPUZ80.SRL_IDX_Num;
begin
  // DD CB NUM 3E
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SRL_IDX_Num(TTRR.LSB);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SRL_IDX_Num;
begin
  // DD/FD CB NUM 3F
  LD_Reg_SRL_IDX_Num(Acc);
end;

procedure TCPUZ80.BIT_IDX_Num(BIT_: Byte);
begin
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  BIT(BIT_, TTRR.LSB);
end;

procedure TCPUZ80.BIT_0_IDX_Num_0;
begin
  // DD/FD CB NUM 40
  BIT_IDX_Num(0);
end;

procedure TCPUZ80.BIT_0_IDX_Num_1;
begin
  // DD/FD CB NUM 41
  BIT_IDX_Num(0);
end;

procedure TCPUZ80.BIT_0_IDX_Num_2;
begin
  // DD/FD CB NUM 42
  BIT_IDX_Num(0);
end;

procedure TCPUZ80.BIT_0_IDX_Num_3;
begin
  // DD/FD CB NUM 43
  BIT_IDX_Num(0);
end;

procedure TCPUZ80.BIT_0_IDX_Num_4;
begin
  // DD/FD CB NUM 44
  BIT_IDX_Num(0);
end;

procedure TCPUZ80.BIT_0_IDX_Num_5;
begin
  // DD/FD CB NUM 45
  BIT_IDX_Num(0);
end;

procedure TCPUZ80.BIT_0_IDX_Num;
begin
  // DD CB NUM 46
  BIT_IDX_Num(0);
end;

procedure TCPUZ80.BIT_0_IDX_Num_7;
begin
  // DD/FD CB NUM 47
  BIT_IDX_Num(0);
end;

procedure TCPUZ80.BIT_1_IDX_Num_0;
begin
  // DD/FD CB NUM 48
  BIT_IDX_Num(1);
end;

procedure TCPUZ80.BIT_1_IDX_Num_1;
begin
  // DD/FD CB NUM 49
  BIT_IDX_Num(1);
end;

procedure TCPUZ80.BIT_1_IDX_Num_2;
begin
  // DD/FD CB NUM 4A
  BIT_IDX_Num(1);
end;

procedure TCPUZ80.BIT_1_IDX_Num_3;
begin
  // DD/FD CB NUM 4B
  BIT_IDX_Num(1);
end;

procedure TCPUZ80.BIT_1_IDX_Num_4;
begin
  // DD/FD CB NUM 4C
  BIT_IDX_Num(1);
end;

procedure TCPUZ80.BIT_1_IDX_Num_5;
begin
  // DD/FD CB NUM 4D
  BIT_IDX_Num(1);
end;

procedure TCPUZ80.BIT_1_IDX_Num;
begin
  // DD CB NUM 4E
  BIT_IDX_Num(1);
end;

procedure TCPUZ80.BIT_1_IDX_Num_7;
begin
  // DD/FD CB NUM 4F
  BIT_IDX_Num(1);
end;

procedure TCPUZ80.BIT_2_IDX_Num_0;
begin
  // DD/FD CB NUM 50
  BIT_IDX_Num(2);
end;

procedure TCPUZ80.BIT_2_IDX_Num_1;
begin
  // DD/FD CB NUM 51
  BIT_IDX_Num(2);
end;

procedure TCPUZ80.BIT_2_IDX_Num_2;
begin
  // DD/FD CB NUM 52
  BIT_IDX_Num(2);
end;

procedure TCPUZ80.BIT_2_IDX_Num_3;
begin
  // DD/FD CB NUM 53
  BIT_IDX_Num(2);
end;

procedure TCPUZ80.BIT_2_IDX_Num_4;
begin
  // DD/FD CB NUM 54
  BIT_IDX_Num(2);
end;

procedure TCPUZ80.BIT_2_IDX_Num_5;
begin
  // DD/FD CB NUM 55
  BIT_IDX_Num(2);
end;

procedure TCPUZ80.BIT_2_IDX_Num;
begin
  // DD CB NUM 56
  BIT_IDX_Num(2);
end;

procedure TCPUZ80.BIT_2_IDX_Num_7;
begin
  // DD/FD CB NUM 57
  BIT_IDX_Num(2);
end;

procedure TCPUZ80.BIT_3_IDX_Num_0;
begin
  // DD/FD CB NUM 58
  BIT_IDX_Num(3);
end;

procedure TCPUZ80.BIT_3_IDX_Num_1;
begin
  // DD/FD CB NUM 59
  BIT_IDX_Num(3);
end;

procedure TCPUZ80.BIT_3_IDX_Num_2;
begin
  // DD/FD CB NUM 5A
  BIT_IDX_Num(3);
end;

procedure TCPUZ80.BIT_3_IDX_Num_3;
begin
  // DD/FD CB NUM 5B
  BIT_IDX_Num(3);
end;

procedure TCPUZ80.BIT_3_IDX_Num_4;
begin
  // DD/FD CB NUM 5C
  BIT_IDX_Num(3);
end;

procedure TCPUZ80.BIT_3_IDX_Num_5;
begin
  // DD/FD CB NUM 5D
  BIT_IDX_Num(3);
end;

procedure TCPUZ80.BIT_3_IDX_Num;
begin
  // DD CB NUM 5E
  BIT_IDX_Num(3);
end;

procedure TCPUZ80.BIT_3_IDX_Num_7;
begin
  // DD/FD CB NUM 5F
  BIT_IDX_Num(3);
end;

procedure TCPUZ80.BIT_4_IDX_Num_0;
begin
  // DD/FD CB NUM 60
  BIT_IDX_Num(4);
end;

procedure TCPUZ80.BIT_4_IDX_Num_1;
begin
  // DD/FD CB NUM 61
  BIT_IDX_Num(4);
end;

procedure TCPUZ80.BIT_4_IDX_Num_2;
begin
  // DD/FD CB NUM 62
  BIT_IDX_Num(4);
end;

procedure TCPUZ80.BIT_4_IDX_Num_3;
begin
  // DD/FD CB NUM 63
  BIT_IDX_Num(4);
end;

procedure TCPUZ80.BIT_4_IDX_Num_4;
begin
  // DD/FD CB NUM 64
  BIT_IDX_Num(4);
end;

procedure TCPUZ80.BIT_4_IDX_Num_5;
begin
  // DD/FD CB NUM 65
  BIT_IDX_Num(4);
end;

procedure TCPUZ80.BIT_4_IDX_Num;
begin
  // DD CB NUM 66
  BIT_IDX_Num(4);
end;

procedure TCPUZ80.BIT_4_IDX_Num_7;
begin
  // DD/FD CB NUM 67
  BIT_IDX_Num(4);
end;

procedure TCPUZ80.BIT_5_IDX_Num_0;
begin
  // DD/FD CB NUM 68
  BIT_IDX_Num(5);
end;

procedure TCPUZ80.BIT_5_IDX_Num_1;
begin
  // DD/FD CB NUM 69
  BIT_IDX_Num(5);
end;

procedure TCPUZ80.BIT_5_IDX_Num_2;
begin
  // DD/FD CB NUM 6A
  BIT_IDX_Num(5);
end;

procedure TCPUZ80.BIT_5_IDX_Num_3;
begin
  // DD/FD CB NUM 6B
  BIT_IDX_Num(5);
end;

procedure TCPUZ80.BIT_5_IDX_Num_4;
begin
  // DD/FD CB NUM 6C
  BIT_IDX_Num(5);
end;

procedure TCPUZ80.BIT_5_IDX_Num_5;
begin
  // DD/FD CB NUM 6D
  BIT_IDX_Num(5);
end;

procedure TCPUZ80.BIT_5_IDX_Num;
begin
  // DD CB NUM 6E
  BIT_IDX_Num(5);
end;

procedure TCPUZ80.BIT_5_IDX_Num_7;
begin
  // DD/FD CB NUM 6F
  BIT_IDX_Num(5);
end;

procedure TCPUZ80.BIT_6_IDX_Num_0;
begin
  // DD/FD CB NUM 70
  BIT_IDX_Num(6);
end;

procedure TCPUZ80.BIT_6_IDX_Num_1;
begin
  // DD/FD CB NUM 71
  BIT_IDX_Num(6);
end;

procedure TCPUZ80.BIT_6_IDX_Num_2;
begin
  // DD/FD CB NUM 72
  BIT_IDX_Num(6);
end;

procedure TCPUZ80.BIT_6_IDX_Num_3;
begin
  // DD/FD CB NUM 73
  BIT_IDX_Num(6);
end;

procedure TCPUZ80.BIT_6_IDX_Num_4;
begin
  // DD/FD CB NUM 74
  BIT_IDX_Num(6);
end;

procedure TCPUZ80.BIT_6_IDX_Num_5;
begin
  // DD/FD CB NUM 75
  BIT_IDX_Num(6);
end;

procedure TCPUZ80.BIT_6_IDX_Num;
begin
  // DD CB NUM 76
  BIT_IDX_Num(6);
end;

procedure TCPUZ80.BIT_6_IDX_Num_7;
begin
  // DD/FD CB NUM 77
  BIT_IDX_Num(6);
end;

procedure TCPUZ80.BIT_7_IDX_Num_0;
begin
  // DD/FD CB NUM 78
  BIT_IDX_Num(7);
end;

procedure TCPUZ80.BIT_7_IDX_Num_1;
begin
  // DD/FD CB NUM 79
  BIT_IDX_Num(7);
end;

procedure TCPUZ80.BIT_7_IDX_Num_2;
begin
  // DD/FD CB NUM 7A
  BIT_IDX_Num(7);
end;

procedure TCPUZ80.BIT_7_IDX_Num_3;
begin
  // DD/FD CB NUM 7B
  BIT_IDX_Num(7);
end;

procedure TCPUZ80.BIT_7_IDX_Num_4;
begin
  // DD/FD CB NUM 7C
  BIT_IDX_Num(7);
end;

procedure TCPUZ80.BIT_7_IDX_Num_5;
begin
  // DD/FD CB NUM 7D
  BIT_IDX_Num(7);
end;

procedure TCPUZ80.BIT_7_IDX_Num;
begin
  // DD CB NUM 7E
  BIT_IDX_Num(7);
end;

procedure TCPUZ80.BIT_7_IDX_Num_7;
begin
  // DD/FD CB NUM 7F
  BIT_IDX_Num(7);
end;

procedure TCPUZ80.LD_Reg_RES_Bit_IDX_Num(var Reg: Byte; Bit: Byte);
begin
  InternalRP.LSB := Read_Addr_From_HL_IDX(False);
  RESETBIT(Bit, InternalRP.LSB);
  Write_HL_IDX_To_Addr(False, InternalRP.LSB);
  Reg := InternalRP.LSB
end;

procedure TCPUZ80.LD_B_RES_0_IDX_Num;
begin
  // DD/FD CB NUM 80
  LD_Reg_RES_Bit_IDX_Num(RPBC.B, 0);
end;

procedure TCPUZ80.LD_C_RES_0_IDX_Num;
begin
  // DD/FD CB NUM 81
  LD_Reg_RES_Bit_IDX_Num(RPBC.C, 0);
end;

procedure TCPUZ80.LD_D_RES_0_IDX_Num;
begin
  // DD/FD CB NUM 82
  LD_Reg_RES_Bit_IDX_Num(RPDE.D, 0);
end;

procedure TCPUZ80.LD_E_RES_0_IDX_Num;
begin
  // DD/FD CB NUM 83
  LD_Reg_RES_Bit_IDX_Num(RPDE.E, 0);
end;

procedure TCPUZ80.LD_H_RES_0_IDX_Num;
begin
  // DD/FD CB NUM 84
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].H, 0);
end;

procedure TCPUZ80.LD_L_RES_0_IDX_Num;
begin
  // DD/FD CB NUM 85
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].L, 0);
end;

procedure TCPUZ80.RES_0_IDX_Num;
begin
  // DD CB NUM 86
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RES_Bit_IDX_Num(TTRR.LSB, 0);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RES_0_IDX_Num;
begin
  // DD/FD CB NUM 87
  LD_Reg_RES_Bit_IDX_Num(Acc, 0);
end;

procedure TCPUZ80.LD_B_RES_1_IDX_Num;
begin
  // DD/FD CB NUM 88
  LD_Reg_RES_Bit_IDX_Num(RPBC.B, 1);
end;

procedure TCPUZ80.LD_C_RES_1_IDX_Num;
begin
  // DD/FD CB NUM 89
  LD_Reg_RES_Bit_IDX_Num(RPBC.C, 1);
end;

procedure TCPUZ80.LD_D_RES_1_IDX_Num;
begin
  // DD/FD CB NUM 8A
  LD_Reg_RES_Bit_IDX_Num(RPDE.D, 1);
end;

procedure TCPUZ80.LD_E_RES_1_IDX_Num;
begin
  // DD/FD CB NUM 8B
  LD_Reg_RES_Bit_IDX_Num(RPDE.E, 1);
end;

procedure TCPUZ80.LD_H_RES_1_IDX_Num;
begin
  // DD/FD CB NUM 8C
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].H, 1);
end;

procedure TCPUZ80.LD_L_RES_1_IDX_Num;
begin
  // DD/FD CB NUM 8D
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].L, 1);
end;

procedure TCPUZ80.RES_1_IDX_Num;
begin
  // DD CB NUM 8E
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RES_Bit_IDX_Num(TTRR.LSB, 1);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RES_1_IDX_Num;
begin
  // DD/FD CB NUM 8F
  LD_Reg_RES_Bit_IDX_Num(Acc, 1);
end;

procedure TCPUZ80.LD_B_RES_2_IDX_Num;
begin
  // DD/FD CB NUM 90
  LD_Reg_RES_Bit_IDX_Num(RPBC.B, 2);
end;

procedure TCPUZ80.LD_C_RES_2_IDX_Num;
begin
  // DD/FD CB NUM 91
  LD_Reg_RES_Bit_IDX_Num(RPBC.C, 2);
end;

procedure TCPUZ80.LD_D_RES_2_IDX_Num;
begin
  // DD/FD CB NUM 92
  LD_Reg_RES_Bit_IDX_Num(RPDE.D, 2);
end;

procedure TCPUZ80.LD_E_RES_2_IDX_Num;
begin
  // DD/FD CB NUM 93
  LD_Reg_RES_Bit_IDX_Num(RPDE.E, 2);
end;

procedure TCPUZ80.LD_H_RES_2_IDX_Num;
begin
  // DD/FD CB NUM 94
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].H, 2);
end;

procedure TCPUZ80.LD_L_RES_2_IDX_Num;
begin
  // DD/FD CB NUM 95
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].L, 2);
end;

procedure TCPUZ80.RES_2_IDX_Num;
begin
  // DD CB NUM 96
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RES_Bit_IDX_Num(TTRR.LSB, 2);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RES_2_IDX_Num;
begin
  // DD/FD CB NUM 97
  LD_Reg_RES_Bit_IDX_Num(Acc, 2);
end;

procedure TCPUZ80.LD_B_RES_3_IDX_Num;
begin
  // DD/FD CB NUM 98
  LD_Reg_RES_Bit_IDX_Num(RPBC.B, 3);
end;

procedure TCPUZ80.LD_C_RES_3_IDX_Num;
begin
  // DD/FD CB NUM 99
  LD_Reg_RES_Bit_IDX_Num(RPBC.C, 3);
end;

procedure TCPUZ80.LD_D_RES_3_IDX_Num;
begin
  // DD/FD CB NUM 9A
  LD_Reg_RES_Bit_IDX_Num(RPDE.D, 3);
end;

procedure TCPUZ80.LD_E_RES_3_IDX_Num;
begin
  // DD/FD CB NUM 9B
  LD_Reg_RES_Bit_IDX_Num(RPDE.E, 3);
end;

procedure TCPUZ80.LD_H_RES_3_IDX_Num;
begin
  // DD/FD CB NUM 9C
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].H, 3);
end;

procedure TCPUZ80.LD_L_RES_3_IDX_Num;
begin
  // DD/FD CB NUM 9D
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].L, 3);
end;

procedure TCPUZ80.RES_3_IDX_Num;
begin
  // DD CB NUM 9E
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RES_Bit_IDX_Num(TTRR.LSB, 3);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RES_3_IDX_Num;
begin
  // DD/FD CB NUM 9F
  LD_Reg_RES_Bit_IDX_Num(Acc, 3);
end;

procedure TCPUZ80.LD_B_RES_4_IDX_Num;
begin
  // DD/FD CB NUM A0
  LD_Reg_RES_Bit_IDX_Num(RPBC.B, 4);
end;

procedure TCPUZ80.LD_C_RES_4_IDX_Num;
begin
  // DD/FD CB NUM A1
  LD_Reg_RES_Bit_IDX_Num(RPBC.C, 4);
end;

procedure TCPUZ80.LD_D_RES_4_IDX_Num;
begin
  // DD/FD CB NUM A2
  LD_Reg_RES_Bit_IDX_Num(RPDE.D, 4);
end;

procedure TCPUZ80.LD_E_RES_4_IDX_Num;
begin
  // DD/FD CB NUM A3
  LD_Reg_RES_Bit_IDX_Num(RPDE.E, 4);
end;

procedure TCPUZ80.LD_H_RES_4_IDX_Num;
begin
  // DD/FD CB NUM A4
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].H, 4);
end;

procedure TCPUZ80.LD_L_RES_4_IDX_Num;
begin
  // DD/FD CB NUM A5
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].L, 4);
end;

procedure TCPUZ80.RES_4_IDX_Num;
begin
  // DD CB NUM A6
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RES_Bit_IDX_Num(TTRR.LSB, 4);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RES_4_IDX_Num;
begin
  // DD/FD CB NUM A7
  LD_Reg_RES_Bit_IDX_Num(Acc, 4);
end;

procedure TCPUZ80.LD_B_RES_5_IDX_Num;
begin
  // DD/FD CB NUM A8
  LD_Reg_RES_Bit_IDX_Num(RPBC.B, 5);
end;

procedure TCPUZ80.LD_C_RES_5_IDX_Num;
begin
  // DD/FD CB NUM A9
  LD_Reg_RES_Bit_IDX_Num(RPBC.C, 5);
end;

procedure TCPUZ80.LD_D_RES_5_IDX_Num;
begin
  // DD/FD CB NUM AA
  LD_Reg_RES_Bit_IDX_Num(RPDE.D, 5);
end;

procedure TCPUZ80.LD_E_RES_5_IDX_Num;
begin
  // DD/FD CB NUM AB
  LD_Reg_RES_Bit_IDX_Num(RPDE.E, 5);
end;

procedure TCPUZ80.LD_H_RES_5_IDX_Num;
begin
  // DD/FD CB NUM AC
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].H, 5);
end;

procedure TCPUZ80.LD_L_RES_5_IDX_Num;
begin
  // DD/FD CB NUM AD
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].L, 5);
end;

procedure TCPUZ80.RES_5_IDX_Num;
begin
  // DD CB NUM AE
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RES_Bit_IDX_Num(TTRR.LSB, 5);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RES_5_IDX_Num;
begin
  // DD/FD CB NUM AF
  LD_Reg_RES_Bit_IDX_Num(Acc, 5);
end;

procedure TCPUZ80.LD_B_RES_6_IDX_Num;
begin
  // DD/FD CB NUM B0
  LD_Reg_RES_Bit_IDX_Num(RPBC.B, 6);
end;

procedure TCPUZ80.LD_C_RES_6_IDX_Num;
begin
  // DD/FD CB NUM B1
  LD_Reg_RES_Bit_IDX_Num(RPBC.C, 6);
end;

procedure TCPUZ80.LD_D_RES_6_IDX_Num;
begin
  // DD/FD CB NUM B2
  LD_Reg_RES_Bit_IDX_Num(RPDE.D, 6);
end;

procedure TCPUZ80.LD_E_RES_6_IDX_Num;
begin
  // DD/FD CB NUM B3
  LD_Reg_RES_Bit_IDX_Num(RPDE.E, 6);
end;

procedure TCPUZ80.LD_H_RES_6_IDX_Num;
begin
  // DD/FD CB NUM B4
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].H, 6);
end;

procedure TCPUZ80.LD_L_RES_6_IDX_Num;
begin
  // DD/FD CB NUM B5
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].L, 6);
end;

procedure TCPUZ80.RES_6_IDX_Num;
begin
  // DD CB NUM B6
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RES_Bit_IDX_Num(TTRR.LSB, 6);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RES_6_IDX_Num;
begin
  // DD/FD CB NUM B7
  LD_Reg_RES_Bit_IDX_Num(Acc, 6);
end;

procedure TCPUZ80.LD_B_RES_7_IDX_Num;
begin
  // DD/FD CB NUM B8
  LD_Reg_RES_Bit_IDX_Num(RPBC.B, 7);
end;

procedure TCPUZ80.LD_C_RES_7_IDX_Num;
begin
  // DD/FD CB NUM B9
  LD_Reg_RES_Bit_IDX_Num(RPBC.C, 7);
end;

procedure TCPUZ80.LD_D_RES_7_IDX_Num;
begin
  // DD/FD CB NUM BA
  LD_Reg_RES_Bit_IDX_Num(RPDE.D, 7);
end;

procedure TCPUZ80.LD_E_RES_7_IDX_Num;
begin
  // DD/FD CB NUM BB
  LD_Reg_RES_Bit_IDX_Num(RPDE.E, 7);
end;

procedure TCPUZ80.LD_H_RES_7_IDX_Num;
begin
  // DD/FD CB NUM BC
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].H, 7);
end;

procedure TCPUZ80.LD_L_RES_7_IDX_Num;
begin
  // DD/FD CB NUM BD
  LD_Reg_RES_Bit_IDX_Num(RPHL[regHL].L, 7);
end;

procedure TCPUZ80.RES_7_IDX_Num;
begin
  // DD CB NUM BE
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_RES_Bit_IDX_Num(TTRR.LSB, 7);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_RES_7_IDX_Num;
begin
  // DD/FD CB NUM BF
  LD_Reg_RES_Bit_IDX_Num(Acc, 7);
end;

procedure TCPUZ80.LD_Reg_SET_Bit_IDX_Num(var Reg: Byte; Bit: Byte);
begin
  // DD CB NUM C6
  InternalRP.LSB := Read_Addr_From_HL_IDX(False);
  SETBIT(Bit, InternalRP.LSB);
  Write_HL_IDX_To_Addr(False, InternalRP.LSB);
  Reg := InternalRP.LSB
end;

procedure TCPUZ80.LD_B_SET_0_IDX_Num;
begin
  // DD/FD CB NUM C0
  LD_Reg_SET_Bit_IDX_Num(RPBC.B, 0);
end;

procedure TCPUZ80.LD_C_SET_0_IDX_Num;
begin
  // DD/FD CB NUM C1
  LD_Reg_SET_Bit_IDX_Num(RPBC.C, 0);
end;

procedure TCPUZ80.LD_D_SET_0_IDX_Num;
begin
  // DD/FD CB NUM C2
  LD_Reg_SET_Bit_IDX_Num(RPDE.D, 0);
end;

procedure TCPUZ80.LD_E_SET_0_IDX_Num;
begin
  // DD/FD CB NUM C3
  LD_Reg_SET_Bit_IDX_Num(RPDE.E, 0);
end;

procedure TCPUZ80.LD_H_SET_0_IDX_Num;
begin
  // DD/FD CB NUM C4
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].H, 0);
end;

procedure TCPUZ80.LD_L_SET_0_IDX_Num;
begin
  // DD/FD CB NUM C5
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].L, 0);
end;

procedure TCPUZ80.SET_0_IDX_Num;
begin
  // DD CB NUM C6
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SET_Bit_IDX_Num(TTRR.LSB, 0);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SET_0_IDX_Num;
begin
  // DD/FD CB NUM C7
  LD_Reg_SET_Bit_IDX_Num(Acc, 0);
end;

procedure TCPUZ80.LD_B_SET_1_IDX_Num;
begin
  // DD/FD CB NUM C8
  LD_Reg_SET_Bit_IDX_Num(RPBC.B, 1);
end;

procedure TCPUZ80.LD_C_SET_1_IDX_Num;
begin
  // DD/FD CB NUM C9
  LD_Reg_SET_Bit_IDX_Num(RPBC.C, 1);
end;

procedure TCPUZ80.LD_D_SET_1_IDX_Num;
begin
  // DD/FD CB NUM CA
  LD_Reg_SET_Bit_IDX_Num(RPDE.D, 1);
end;

procedure TCPUZ80.LD_E_SET_1_IDX_Num;
begin
  // DD/FD CB NUM CB
  LD_Reg_SET_Bit_IDX_Num(RPDE.E, 1);
end;

procedure TCPUZ80.LD_H_SET_1_IDX_Num;
begin
  // DD/FD CB NUM CC
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].H, 1);
end;

procedure TCPUZ80.LD_L_SET_1_IDX_Num;
begin
  // DD/FD CB NUM CD
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].L, 1);
end;

procedure TCPUZ80.SET_1_IDX_Num;
begin
  // DD CB NUM CE
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SET_Bit_IDX_Num(TTRR.LSB, 1);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SET_1_IDX_Num;
begin
  // DD/FD CB NUM CF
  LD_Reg_SET_Bit_IDX_Num(Acc, 1);
end;

procedure TCPUZ80.LD_B_SET_2_IDX_Num;
begin
  // DD/FD CB NUM D0
  LD_Reg_SET_Bit_IDX_Num(RPBC.B, 2);
end;

procedure TCPUZ80.LD_C_SET_2_IDX_Num;
begin
  // DD/FD CB NUM D1
  LD_Reg_SET_Bit_IDX_Num(RPBC.C, 2);
end;

procedure TCPUZ80.LD_D_SET_2_IDX_Num;
begin
  // DD/FD CB NUM D2
  LD_Reg_SET_Bit_IDX_Num(RPDE.D, 2);
end;

procedure TCPUZ80.LD_E_SET_2_IDX_Num;
begin
  // DD/FD CB NUM D3
  LD_Reg_SET_Bit_IDX_Num(RPDE.E, 2);
end;

procedure TCPUZ80.LD_H_SET_2_IDX_Num;
begin
  // DD/FD CB NUM D4
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].H, 2);
end;

procedure TCPUZ80.LD_L_SET_2_IDX_Num;
begin
  // DD/FD CB NUM D5
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].L, 2);
end;

procedure TCPUZ80.SET_2_IDX_Num;
begin
  // DD CB NUM D6
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SET_Bit_IDX_Num(TTRR.LSB, 2);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SET_2_IDX_Num;
begin
  // DD/FD CB NUM D7
  LD_Reg_SET_Bit_IDX_Num(Acc, 2);
end;

procedure TCPUZ80.LD_B_SET_3_IDX_Num;
begin
  // DD/FD CB NUM D8
  LD_Reg_SET_Bit_IDX_Num(RPBC.B, 3);
end;

procedure TCPUZ80.LD_C_SET_3_IDX_Num;
begin
  // DD/FD CB NUM D9
  LD_Reg_SET_Bit_IDX_Num(RPBC.C, 3);
end;

procedure TCPUZ80.LD_D_SET_3_IDX_Num;
begin
  // DD/FD CB NUM DA
  LD_Reg_SET_Bit_IDX_Num(RPDE.D, 3);
end;

procedure TCPUZ80.LD_E_SET_3_IDX_Num;
begin
  // DD/FD CB NUM DB
  LD_Reg_SET_Bit_IDX_Num(RPDE.E, 3);
end;

procedure TCPUZ80.LD_H_SET_3_IDX_Num;
begin
  // DD/FD CB NUM DC
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].H, 3);
end;

procedure TCPUZ80.LD_L_SET_3_IDX_Num;
begin
  // DD/FD CB NUM DD
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].L, 3);
end;

procedure TCPUZ80.SET_3_IDX_Num;
begin
  // DD CB NUM DE
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SET_Bit_IDX_Num(TTRR.LSB, 3);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SET_3_IDX_Num;
begin
  // DD/FD CB NUM DF
  LD_Reg_SET_Bit_IDX_Num(Acc, 3);
end;

procedure TCPUZ80.LD_B_SET_4_IDX_Num;
begin
  // DD/FD CB NUM E0
  LD_Reg_SET_Bit_IDX_Num(RPBC.B, 4);
end;

procedure TCPUZ80.LD_C_SET_4_IDX_Num;
begin
  // DD/FD CB NUM E1
  LD_Reg_SET_Bit_IDX_Num(RPBC.C, 4);
end;

procedure TCPUZ80.LD_D_SET_4_IDX_Num;
begin
  // DD/FD CB NUM E2
  LD_Reg_SET_Bit_IDX_Num(RPDE.D, 4);
end;

procedure TCPUZ80.LD_E_SET_4_IDX_Num;
begin
  // DD/FD CB NUM E3
  LD_Reg_SET_Bit_IDX_Num(RPDE.E, 4);
end;

procedure TCPUZ80.LD_H_SET_4_IDX_Num;
begin
  // DD/FD CB NUM E4
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].H, 4);
end;

procedure TCPUZ80.LD_L_SET_4_IDX_Num;
begin
  // DD/FD CB NUM E5
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].L, 4);
end;

procedure TCPUZ80.SET_4_IDX_Num;
begin
  // DD CB NUM E6
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SET_Bit_IDX_Num(TTRR.LSB, 4);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SET_4_IDX_Num;
begin
  // DD/FD CB NUM E7
  LD_Reg_SET_Bit_IDX_Num(Acc, 4);
end;

procedure TCPUZ80.LD_B_SET_5_IDX_Num;
begin
  // DD/FD CB NUM E8
  LD_Reg_SET_Bit_IDX_Num(RPBC.B, 5);
end;

procedure TCPUZ80.LD_C_SET_5_IDX_Num;
begin
  // DD/FD CB NUM E9
  LD_Reg_SET_Bit_IDX_Num(RPBC.C, 5);
end;

procedure TCPUZ80.LD_D_SET_5_IDX_Num;
begin
  // DD/FD CB NUM EA
  LD_Reg_SET_Bit_IDX_Num(RPDE.D, 5);
end;

procedure TCPUZ80.LD_E_SET_5_IDX_Num;
begin
  // DD/FD CB NUM EB
  LD_Reg_SET_Bit_IDX_Num(RPDE.E, 5);
end;

procedure TCPUZ80.LD_H_SET_5_IDX_Num;
begin
  // DD/FD CB NUM EC
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].H, 5);
end;

procedure TCPUZ80.LD_L_SET_5_IDX_Num;
begin
  // DD/FD CB NUM ED
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].L, 5);
end;

procedure TCPUZ80.SET_5_IDX_Num;
begin
  // DD CB NUM EE
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SET_Bit_IDX_Num(TTRR.LSB, 5);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SET_5_IDX_Num;
begin
  // DD/FD CB NUM EF
  LD_Reg_SET_Bit_IDX_Num(Acc, 5);
end;

procedure TCPUZ80.LD_B_SET_6_IDX_Num;
begin
  // DD/FD CB NUM F0
  LD_Reg_SET_Bit_IDX_Num(RPBC.B, 6);
end;

procedure TCPUZ80.LD_C_SET_6_IDX_Num;
begin
  // DD/FD CB NUM F1
  LD_Reg_SET_Bit_IDX_Num(RPBC.C, 6);
end;

procedure TCPUZ80.LD_D_SET_6_IDX_Num;
begin
  // DD/FD CB NUM F2
  LD_Reg_SET_Bit_IDX_Num(RPDE.D, 6);
end;

procedure TCPUZ80.LD_E_SET_6_IDX_Num;
begin
  // DD/FD CB NUM F3
  LD_Reg_SET_Bit_IDX_Num(RPDE.E, 6);
end;

procedure TCPUZ80.LD_H_SET_6_IDX_Num;
begin
  // DD/FD CB NUM F4
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].H, 6);
end;

procedure TCPUZ80.LD_L_SET_6_IDX_Num;
begin
  // DD/FD CB NUM F5
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].L, 6);
end;

procedure TCPUZ80.SET_6_IDX_Num;
begin
  // DD CB NUM F6
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SET_Bit_IDX_Num(TTRR.LSB, 6);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SET_6_IDX_Num;
begin
  // DD/FD CB NUM F7
  LD_Reg_SET_Bit_IDX_Num(Acc, 6);
end;

procedure TCPUZ80.LD_B_SET_7_IDX_Num;
begin
  // DD/FD CB NUM F8
  LD_Reg_SET_Bit_IDX_Num(RPBC.B, 7);
end;

procedure TCPUZ80.LD_C_SET_7_IDX_Num;
begin
  // DD/FD CB NUM F9
  LD_Reg_SET_Bit_IDX_Num(RPBC.C, 7);
end;

procedure TCPUZ80.LD_D_SET_7_IDX_Num;
begin
  // DD/FD CB NUM FA
  LD_Reg_SET_Bit_IDX_Num(RPDE.D, 7);
end;

procedure TCPUZ80.LD_E_SET_7_IDX_Num;
begin
  // DD/FD CB NUM FB
  LD_Reg_SET_Bit_IDX_Num(RPDE.E, 7);
end;

procedure TCPUZ80.LD_H_SET_7_IDX_Num;
begin
  // DD/FD CB NUM FC
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].H, 7);
end;

procedure TCPUZ80.LD_L_SET_7_IDX_Num;
begin
  // DD/FD CB NUM FD
  LD_Reg_SET_Bit_IDX_Num(RPHL[regHL].L, 7);
end;

procedure TCPUZ80.SET_7_IDX_Num;
begin
  // DD CB NUM FE
  TTRR.LSB := Read_Addr_From_HL_IDX(False);
  LD_Reg_SET_Bit_IDX_Num(TTRR.LSB, 7);
  Write_HL_IDX_To_Addr(False, TTRR.LSB);
end;

procedure TCPUZ80.LD_A_SET_7_IDX_Num;
begin
  // DD/FD CB NUM FF
  LD_Reg_SET_Bit_IDX_Num(Acc, 7);
end;

// $ED

procedure TCPUZ80.IGNORE_ED;
begin
  Mem.IncPC;
end;

procedure TCPUZ80.SBC_HL_RP(Reg: Word);
var
  res: Integer;
  b: Byte;
begin
  if Flag_CY then
    Dec(RPHL[regHL].HL);
    
  Flag_S := (Max(RPHL[regHL].HL, -Reg) < ABS(Min(RPHL[regHL].HL, -Reg)));
  res := RPHL[regHL].HL - Reg;
  Flag_CY := (res < 0);
  RPHL[regHL].HL := RPHL[regHL].HL - Reg;
  Flag_Z := (RPHL[regHL].HL = 0);
  Flag_PV := False;
  
  for b := 0 to 15 do
    Flag_PV := Flag_PV xor ((RPHL[regHL].HL and Trunc(Power(2, b))) <> 0);
end;

procedure TCPUZ80.ADC_HL_RP(Reg: Word);
var
  res: Integer;
  b: Byte;
begin
  if Flag_CY then
    Inc(RPHL[regHL].HL);

  Flag_S := (Max(RPHL[regHL].HL, Reg) < Abs(Min(RPHL[regHL].HL, Reg)));
  res := RPHL[regHL].HL + Reg;
  Flag_CY := (res > 255);
  RPHL[regHL].HL := RPHL[regHL].HL + Reg;
  Flag_Z := (RPHL[regHL].HL = 0);
  Flag_PV := False;
  
  for b := 0 to 7 do
    Flag_PV := Flag_PV xor ((RPHL[regHL].HL and Trunc(Power(2, b))) <> 0);
end;

procedure TCPUZ80.IN_B_C;
begin
  // ED 40
  INP(RPBC.B, RPBC.C);
end;

procedure TCPUZ80.OUT_C_B;
begin
  // ED 41
  OUTP(RPBC.C, RPBC.B);
end;

procedure TCPUZ80.SBC_HL_BC;
begin
  // ED 42
  SBC_HL_RP(RPBC.BC);
end;

procedure TCPUZ80.LD_Addr_BC;
begin
  // ED 43 NUM NUM
  InternalRP.LSB := Mem.ReadB(True);
  InternalRP.MSB := Mem.ReadB(True);
  Mem.WriteB(TTRR.WordVal, RPBC.C);
  Mem.WriteB(TTRR.WordVal + 1, RPBC.B);
end;

procedure TCPUZ80.NEG;
begin
  // ED 44
  Acc := -Acc;
end;

procedure TCPUZ80.RETN;
begin
  // ED 45
  Flag_IFF1 := Flag_IFF2;
  RET;
end;

procedure TCPUZ80.IM_0;
begin
  // ED 46
  IM := 0;
end;

procedure TCPUZ80.LD_I_A;
begin
  // ED 47
  IR := Acc;
end;

procedure TCPUZ80.IN_C_C;
begin
  // ED 48
  INP(RPBC.C, RPBC.C);
end;

procedure TCPUZ80.OUT_C_C;
begin
  // ED 49
  OUTP(RPBC.C, RPBC.C);
end;

procedure TCPUZ80.ADC_HL_BC;
begin
  // ED 4A
  ADC_HL_RP(RPBC.BC);
end;

procedure TCPUZ80.LD_BC_Addr;
begin
  // ED 4B NUM NUM
  LD_RP_Addr(RPBC.BC);
end;

procedure TCPUZ80.RETI;
begin
  // ED 4D
  Flag_IFF1 := Flag_IFF2;
  RET;
end;

procedure TCPUZ80.LD_R_A;
begin
  MR := Acc;
  MaskMR := MR and $80;
end;

procedure TCPUZ80.IN_D_C;
begin
  // ED 50
  INP(RPDE.D, RPBC.C);
end;

procedure TCPUZ80.OUT_C_D;
begin
  // ED 51
  OUTP(RPBC.C, RPDE.D);
end;

procedure TCPUZ80.SBC_HL_DE;
begin
  // ED 52
  SBC_HL_RP(RPDE.DE);
end;

procedure TCPUZ80.LD_Addr_DE;
begin
  // ED 53 NUM NUM
  InternalRP.LSB := Mem.ReadB(True);
  InternalRP.MSB := Mem.ReadB(True);
  Mem.WriteB(TTRR.WordVal, RPDE.E);
  Mem.WriteB(TTRR.WordVal + 1, RPDE.D);
end;

procedure TCPUZ80.IM_1;
begin
  // ED 56
  IM := 1;
end;

procedure TCPUZ80.LD_A_I;
begin
  // ED 57
  Acc := IR;
  Flag_S := Acc > 127;
  Flag_Z := Acc = 0;
  Flag_F5 := (Acc and $20) = $20;
  Flag_HF := False;
  Flag_F3 := (Acc and 8) = 8;
  Flag_N := False;
  Flag_PV := Flag_IFF2;
end;

procedure TCPUZ80.IN_E_C;
begin
  // ED 58
  INP(RPDE.E, RPBC.C);
end;

procedure TCPUZ80.OUT_C_E;
begin
  // ED 59
  OUTP(RPBC.C, RPDE.E);
end;

procedure TCPUZ80.ADC_HL_DE;
begin
  // ED 5A
  ADC_HL_RP(RPDE.DE);
end;

procedure TCPUZ80.LD_DE_Addr;
begin
  // ED 5B NUM NUM
  LD_RP_Addr(RPDE.DE);
end;

procedure TCPUZ80.IM_2;
begin
  // ED 5E
  IM := 2;
end;

procedure TCPUZ80.LD_A_R; // ED 5F
begin
  Acc := MR;
  Flag_S := Acc > 127;
  Flag_Z := Acc = 0;
  Flag_F5 := (Acc and $20) = $20;
  Flag_HF := False;
  Flag_F3 := (Acc and 8) = 8;
  Flag_N := False;
  Flag_PV := Flag_IFF2;
end;

procedure TCPUZ80.IN_H_C;
begin
  // ED 60
  INP(RPHL[regHL].H, RPBC.C);
end;

procedure TCPUZ80.OUT_C_H;
begin
  // ED 61
  OUTP(RPBC.C, RPHL[regHL].H);
end;

procedure TCPUZ80.SBC_HL_HL;
begin
  // ED 62
  SBC_HL_RP(RPHL[regHL].HL);
end;

procedure TCPUZ80.LD_Addr_HL_2;
begin
  // ED 63
  TTRR.LSB := Mem.ReadB(True);
  TTRR.MSB := Mem.ReadB(True);
  Mem.WriteB(TTRR.WordVal, RPHL[regHL].L);
  Mem.WriteB(TTRR.WordVal + 1, RPHL[regHL].H);
end;

procedure TCPUZ80.RRD;
begin
  // ED 67
  TTRR.LSB := Mem.ReadB(RPHL[regHL].HL);
  InternalRP.LSB := (Acc and $F0) or (TTRR.LSB and $0F);
  InternalRP.MSB := (Acc shl 4) or (TTRR.LSB shr 4);
  Acc := InternalRP.LSB;
  Mem.WriteB(RPHL[regHL].HL, InternalRP.MSB);
end;

procedure TCPUZ80.IN_L_C;
begin
  // ED 68
  INP(RPHL[regHL].L, RPBC.C);
end;

procedure TCPUZ80.OUT_C_L;
begin
  // ED 69
  OUTP(RPBC.C, RPHL[regHL].L);
end;

procedure TCPUZ80.ADC_HL_HL;
begin
  // ED 6A
  ADC_HL_RP(RPHL[regHL].HL);
end;

procedure TCPUZ80.LD_HL_Addr_2;
begin
  // ED 6B NUM NUM
  LD_RP_Addr(RPHL[regHL].HL);
end;

procedure TCPUZ80.RLD;
begin
  // ED 6F
  TTRR.LSB := Mem.ReadB(RPHL[regHL].HL);
  InternalRP.LSB := (Acc and $F0) or (TTRR.LSB shr 4);
  InternalRP.MSB := (TTRR.LSB shl 4) or (Acc and $0F);
  Acc := InternalRP.LSB;
  Mem.WriteB(RPHL[regHL].HL, InternalRP.MSB);
end;

procedure TCPUZ80.SBC_HL_SP;
begin
  // ED 72
  SBC_HL_RP(Mem.CurrSP);
end;

procedure TCPUZ80.LD_Addr_SP;
begin
  // ED 73 NUM NUM
  InternalRP.LSB := Mem.ReadB(True);
  InternalRP.MSB := Mem.ReadB(True);
  Mem.WriteB(TTRR.WordVal, TNumber(Mem.CurrSP).LSB);
  Mem.WriteB(TTRR.WordVal + 1, TNumber(Mem.CurrSP).MSB);
end;

procedure TCPUZ80.IN_A_C;
begin
  // ED 78
  INP(Acc, RPBC.C);
end;

procedure TCPUZ80.OUT_C_A;
begin
  // ED 79
  OUTP(RPBC.C, Acc);
end;

procedure TCPUZ80.ADC_HL_SP;
begin
  // ED 7A
  ADC_HL_RP(Mem.CurrSP);
end;

procedure TCPUZ80.LD_SP_Addr;
begin
  // ED 7B NUM NUM
  LD_RP_Addr(TTRR.WordVal);
  Mem.CurrSP := TTRR.WordVal;
end;

procedure TCPUZ80.LDI_(loop: Boolean);
begin
  repeat
    TMP.WordVal := Mem.ReadB(RPHL[regHL].HL);
    Mem.WriteB(RPDE.DE, TMP.WordVal);
    Flag_F5 := (Acc + TMP.WordVal) and 2 = 2;
    Flag_F3 := (Acc + TMP.WordVal) and 4 = 4;
    Inc(RPDE.DE);
    Inc(RPHL[regHL].HL);
    Dec(RPBC.BC);
    Flag_PV := RPBC.BC <> 0;
    Flag_HF := False;
    Flag_N := False;
  until not (loop and Flag_PV and not FStopped);
end;

procedure TCPUZ80.CPI_(loop: Boolean);
var
  res: Byte;
begin
  repeat
    CP_Reg_Acc(Mem.ReadB(RPHL[regHL].HL), False);
    res := Acc - Mem.ReadB(RPHL[regHL].HL);

    if Flag_HF then
      Dec(res);
      
    Flag_F5 := res and 2 = 2;
    Flag_F3 := res and 4 = 4;
    Inc(RPHL[regHL].HL);
    Dec(RPBC.BC);
    Flag_PV := RPBC.BC <> 0;
    Flag_N := True;
  until not (loop and Flag_PV and not FStopped);
end;

procedure TCPUZ80.INI_(loop: Boolean);
var
  res: Integer;
begin
  res := 0;

  repeat
    INP(RPBC.C, res);
    Mem.WriteB(RPHL[regHL].HL, Byte(res));
    res := ((res + 1) and $FF) + res;
    Flag_HF := res and $10 <> 0;
    Flag_CY := Flag_HF;
    Inc(RPHL[regHL].HL);
    Dec(RPBC.B);
    Flag_F3 := False;
  until not (loop and not Flag_Z and not FStopped);
end;

procedure TCPUZ80.OUTI_(loop: Boolean);
begin
  repeat
    OUTP(RPBC.C, Mem.ReadB(RPHL[regHL].HL));
    Inc(RPHL[regHL].HL);
    Dec(RPBC.B);
    Flag_PV := RPBC.B <> 0;
    Flag_HF := False;
    Flag_N := False;
  until not (loop and Flag_PV and not FStopped);
end;

procedure TCPUZ80.LDD_(loop: Boolean);
begin
  // ED A8
  repeat
    Mem.WriteB(RPDE.DE, Mem.ReadB(RPHL[regHL].HL));
    Flag_F5 := (Acc + Mem.ReadB(RPHL[regHL].HL)) and 2 = 2;
    Flag_F3 := (Acc + Mem.ReadB(RPHL[regHL].HL)) and 4 = 4;
    Dec(RPDE.DE);
    Dec(RPHL[regHL].HL);
    Dec(RPBC.BC);
    Flag_PV := RPBC.BC <> 0;
    Flag_HF := False;
    Flag_N := False;
  until not (loop and Flag_PV and not FStopped);
end;

procedure TCPUZ80.CPD_(loop: Boolean);
var
  res: Byte;
begin
  // ED A9
  repeat
    CP_Reg_Acc(Mem.ReadB(RPHL[regHL].HL), False);
    res := Acc - Mem.ReadB(RPHL[regHL].HL);

    if Flag_HF then
      Dec(res);
      
    Flag_F5 := res and 2 = 2;
    Flag_F3 := res and 4 = 4;
    Dec(RPHL[regHL].HL);
    Dec(RPBC.BC);
    Flag_PV := RPBC.BC <> 0;
    Flag_N := True;
  until not (loop and Flag_PV and not FStopped);
end;

procedure TCPUZ80.IND_(loop: Boolean);
var
  res: Integer;
begin
  // ED AA
  res := 0;

  repeat
    INP(RPBC.C, res);
    Mem.WriteB(RPHL[regHL].HL, Byte(res));
    res := ((res - 1) and $FF) + res;
    Flag_HF := res and $10 <> 0;
    Flag_CY := Flag_HF;
    Dec(RPHL[regHL].HL);
    Dec(RPBC.B);
    Flag_F3 := False;
  until not (loop and not Flag_Z and not FStopped);
end;

procedure TCPUZ80.OUTD_(loop: Boolean);
begin
  // ED AB
  repeat
    OUTP(RPBC.C, Mem.ReadB(RPHL[regHL].HL));
    Dec(RPHL[regHL].HL);
    Dec(RPBC.B);
  until not (loop and not Flag_Z and not FStopped);
end;

procedure TCPUZ80.LDI;
begin
  // ED A0
  LDI_(False);
end;

procedure TCPUZ80.CPI;
begin
  // ED A1
  CPI_(False);
end;

procedure TCPUZ80.INI;
begin
  // ED A2
  INI_(False);
end;

procedure TCPUZ80.OUTI;
begin
  // ED A3
  OUTI_(False);
end;

procedure TCPUZ80.LDD;
begin
  // ED A8
  LDD_(False);
end;

procedure TCPUZ80.CPD;
begin
  // ED A9
  CPD_(False);
end;

procedure TCPUZ80.IND;
begin
  // ED AA
  IND_(False);
end;

procedure TCPUZ80.OUTD;
begin
  // ED AB
  OUTD_(False);
end;

procedure TCPUZ80.LDIR;
begin
  // ED B0
  LDI_(True);
end;

procedure TCPUZ80.CPIR;
begin
  // ED B1
  CPI_(True);
end;

procedure TCPUZ80.LDDR;
begin
  // ED B8
  LDD_(True);
end;

procedure TCPUZ80.CPDR;
begin
  // ED B9
  CPD_(True);
end;

procedure TCPUZ80.INDR;
begin
  // ED BA
  IND_(True);
end;

procedure TCPUZ80.INIR;
begin
  // ED B2
  INI_(True);
end;

procedure TCPUZ80.OTIR;
begin
  // ED B3
  OUTI_(True);
end;

procedure TCPUZ80.OTDR;
begin
  // ED BB
  OUTD_(True);
end;

// $ED (HD 64180)

procedure TCPUZ80.IN0_B_PORT;
begin
  // ED 00 NUM
  INP(RPBC.B);
end;

procedure TCPUZ80.OUT0_PORT_B;
begin
  // ED 01 NUM
  OUTP(RPBC.B);
end;

procedure TCPUZ80.TST_B;
begin
  // ED 04
  CP(RPBC.B);
end;

procedure TCPUZ80.IN0_C_PORT;
begin
  // ED 08 NUM
  INP(RPBC.C);
end;

procedure TCPUZ80.OUT0_PORT_C;
begin
  // ED 09 NUM
  OUTP(RPBC.C);
end;

procedure TCPUZ80.TST_C;
begin
  // ED 0C
  CP(RPBC.C);
end;

procedure TCPUZ80.IN0_D_PORT;
begin
  // ED 10 NUM
  INP(RPDE.D);
end;

procedure TCPUZ80.OUT0_PORT_D;
begin
  // ED 11 NUM
  OUTP(RPDE.D);
end;

procedure TCPUZ80.TST_D;
begin
  // ED 14
  CP(RPDE.D);
end;

procedure TCPUZ80.IN0_E_PORT;
begin
  // ED 18 NUM
  INP(RPDE.E);
end;

procedure TCPUZ80.OUT0_PORT_E;
begin
  // ED 19 NUM
  OUTP(RPDE.E);
end;

procedure TCPUZ80.TST_E;
begin
  // ED 1C
  CP(RPDE.E);
end;

procedure TCPUZ80.IN0_H_PORT;
begin
  // ED 20 NUM
  INP(RPHL[regHL].H);
end;

procedure TCPUZ80.OUT0_PORT_H;
begin
  // ED 21 NUM
  OUTP(RPHL[regHL].H);
end;

procedure TCPUZ80.TST_H;
begin
  // ED 24
  CP(RPHL[regHL].H);
end;

procedure TCPUZ80.IN0_L_PORT;
begin
  // ED 28 NUM
  INP(RPHL[regHL].L);
end;

procedure TCPUZ80.OUT0_PORT_L;
begin
  // ED 29 NUM
  OUTP(RPHL[regHL].L);
end;

procedure TCPUZ80.TST_L;
begin
  // ED 2C
  CP(RPHL[regHL].L);
end;

procedure TCPUZ80.IN0_PORT;
var
  Reg, res: Byte;
begin
  // ED 30 NUM
  INP(Reg);
  Flag_Z := Reg = 0;
  Flag_S := (Reg > 127);
  Flag_F5 := (Reg and $20) = $20;
  // ?? Flag_HF := (Reg and 8 = 8) and (Acc and 8 = 8); ??
  Flag_F3 := (Reg and 8) = 8;
  Flag_PV := False;

  for res := 0 to 7 do
    Flag_PV := Flag_PV xor ((Reg and Trunc(Power(2, res))) <> 0);
end;

procedure TCPUZ80.TST_MEM;
begin
  // ED 34
  CP(Mem.ReadB(RPHL[regHL].HL));
end;

procedure TCPUZ80.IN0_A_PORT;
begin
  // ED 38 NUM
  INP(Acc);
end;

procedure TCPUZ80.OUT0_PORT_A;
begin
  // ED 39 NUM
  OUTP(Acc);
end;

procedure TCPUZ80.TST_A;
begin
  // ED 3C
  CP(Acc);
end;

procedure TCPUZ80.MULT_BC;
begin
  // ED 4C
end;

procedure TCPUZ80.MULT_DE;
begin
  // ED 5C
end;

procedure TCPUZ80.TST_Num;
begin
  // ED 64 NUM
  TTRR.LSB := Mem.ReadB(True);
  CP(TTRR.LSB);
end;

procedure TCPUZ80.MULT_HL;
begin
  // ED 6C
end;

procedure TCPUZ80.IN_C;
begin
  // ED 70
end;

procedure TCPUZ80.OUT_C_0;
begin
  // ED 71
end;

procedure TCPUZ80.TSTIO_Num;
begin
  // ED 74 NUM
end;

procedure TCPUZ80.SLP;
begin
  // ED 76
end;

procedure TCPUZ80.MULT_SP;
begin
  // ED 7C
end;

procedure TCPUZ80.OTIM;
begin
  // ED 83
end;

procedure TCPUZ80.OTDM;
begin
  // ED 8B
end;

procedure TCPUZ80.OTIMR;
begin
  // ED 93
end;

procedure TCPUZ80.OTDMR;
begin
  // ED 9B
end;

procedure TCPUZ80.DisasmPrevious(Address: Word);
begin
  FDisasmPrevious := Format('$%0.4x - ', [Address]) + DisasmZ80(Mem, Address);
end;

procedure TCPUZ80.DisasmNext(Address: Word);
begin
  FDisasmNext := Format('$%0.4x - ', [Address]) + DisasmZ80(Mem, Address);
end;

destructor TCPUZ80.Destroy;
begin
  //FreeAndNil(HPCounter);

  inherited;
end;

function TCPUZ80.GetPC: Word;
begin
  Result := Mem.CurrPC;
end;

procedure TCPUZ80.SetPC(Value: Word);
begin
  Mem.CurrPC := Value;
end;

function TCPUZ80.GetSP: Word;
begin
  Result := Mem.CurrSP;
end;

procedure TCPUZ80.SetSP(Value: Word);
begin
  Mem.CurrSP := Value;
end;

function TCPUZ80.GetData(Address: Word): Byte;
begin
  Result := Mem.ReadB(Address);
end;

procedure TCPUZ80.SetData(Address: Word; Value: Byte);
begin
  Mem.WriteB(Address, Value);
end;

// TMemory

constructor TMemory.Create(MemSize, ROMSize: LongWord);
var
  i: LongWord;
begin
  FWriteInROM := True;
  FMemSize := MemSize;
  FROMSize := ROMSize;

  for i := 0 to FMemSize - 1 do
  begin
    Store[i].Break := False;
    Store[i].Data := 0;
    Store[i].isROM := i < FROMSize;
  end;

  pntPC := @Store;
  pntPCEnd := pntPC;
  Inc(pntPCEnd, 65535);
  pntSP := pntPCEnd;
end;

destructor TMemory.Destroy;
begin

  inherited;
end;

function TMemory.GetData(Address: Word): Byte;
begin
  Result := ReadB(Address);
end;

function TMemory.ReadB(Address: Word): Byte;
begin
  while Address >= FMemSize do
    Dec(Address, FMemSize);

  Result := Store[Address].Data;
end;

function TMemory.ReadW(Address: Word): Word;
begin
  Result := ReadB(Address) * 256 + ReadB(Address + 1);
end;

procedure TMemory.SetData(Address: Word; Value: Byte);
begin
  WriteB(Address, value);
end;

procedure TMemory.WriteB(Address: Word; Data: Byte);
begin
  while Address >= FMemSize do
    Dec(Address, FMemSize);

  if (Address < RomSize) and not WriteInROM then
    Exit
  else
    Store[Address].Data := Data;
end;

procedure TMemory.WriteW(Address, Data: Word);
begin
  WriteB(Address, Byte(Data));
  WriteB(Address + 1, Data div 256);
end;

function TMemory.ReadB: Byte;
begin
  Result := pntPC^.Data;
end;

procedure TMemory.WriteB(Data: Byte);
begin
  pntPC^.Data := Data;
end;

procedure TMemory.BreakPoint(Address: Word; State: Boolean);
begin
  if Address < FMemSize then
    Store[Address].Break := State;
end;

function TMemory.HasBreak(Address: Word): Boolean;
begin
  Result := Store[Address].Break;
end;

function TMemory.GetCurrPC: Word;
begin
  Result := (LongInt(pntPC) - LongInt(@Store)) div SizeOf(TMemRecord);
end;

procedure TMemory.SetCurrPC(Value: Word);
begin
  pntPC := @Store;

  if Value <> 0 then
  begin
    Inc(pntPC, Value);

    if LongInt(pntPC) > LongInt(pntPCEnd) then
      Dec(pntPC, 65535);
  end;
end;

function TMemory.ReadB(GoNext: Boolean): Byte;
begin
  Result := pntPC^.Data;
  IncPC;
end;

procedure TMemory.DecPC;
begin
  Dec(pntPC);

  if LongInt(pntPC) < LongInt(@Store) then
    pntPC := pntPCEnd;
end;

procedure TMemory.DecPC(Value: Word);
begin
  if Value <> 0 then
  begin
    Dec(pntPC, Value);

    if LongInt(pntPC) < LongInt(@Store) then
      Inc(pntPC, 65535);
  end;
end;

procedure TMemory.IncPC(Value: Word);
begin
  if Value <> 0 then
  begin
    Inc(pntPC, Value);

    if LongInt(pntPC) > LongInt(pntPCEnd) then
      Dec(pntPC, 65535);
  end;
end;

procedure TMemory.DecSP(Value: Word);
begin
  if Value <> 0 then
  begin
    Dec(pntSP, Value);

    if LongInt(pntSP) < LongInt(@Store) then
      Inc(pntSP, 65535);
  end;
end;

procedure TMemory.DecSP;
begin
  Dec(pntSP);

  if LongInt(pntSP) < LongInt(@Store) then
    pntSP := pntPCEnd;
end;

function TMemory.GetCurrSP: Word;
begin
  Result := (LongInt(pntSP) - LongInt(@Store)) div SizeOf(TMemRecord);
end;

procedure TMemory.IncSP;
begin
  Inc(pntSP);

  if LongInt(pntSP) > LongInt(pntPCEnd) then
    pntSP := @Store;
end;

procedure TMemory.IncSP(Value: Word);
begin
  if Value <> 0 then
  begin
    Inc(pntSP, Value);

    if LongInt(pntSP) > LongInt(pntPCEnd) then
      Dec(pntSP, 65535);
  end;
end;

function TMemory.Pop: Byte;
begin
  Result := pntSP^.Data;
  IncSP;
end;

procedure TMemory.Push(Data: Byte);
begin
  DecSP;
  pntSP^.Data := Data;
end;

procedure TMemory.SetCurrSP(Value: Word);
begin
  pntSP := @Store;

  if Value <> 0 then
  begin
    Inc(pntSP, Value);

    if LongInt(pntSP) > LongInt(pntPCEnd) then
      Dec(pntSP, 65535);
  end;
end;

procedure TMemory.IncPC;
begin
  Inc(pntPC);

  if LongInt(pntPC) > LongInt(pntPCEnd) then
    pntPC := @Store;
end;

// InputOutput

procedure TInputOutput.AssignIOPort(Address: Byte; Port: TPeripheral);
begin
  Ports[Address] := Port;
end;

constructor TInputOutput.Create;
var
  i: Integer;
begin
  for i := Low(Ports) to High(Ports) do
    Ports[i] := nil;
end;

function TInputOutput.GetData(Address: Byte): Byte;
begin
  Result := ReadB(Address);
end;

function TInputOutput.ReadB(Address: Byte): Byte;
begin
  //Result :=  ports[Address];
  if ports[Address] = nil then
    Result := 0
  else
    Result := ports[Address].ReadB;
end;

procedure TInputOutput.SetData(Address: Byte; Value: Byte);
begin
  Write(Address, Value);
end;

procedure TInputOutput.WriteB(Address, Data: Byte);
begin
  //ports[Address] := Data;
  if ports[Address] <> nil then
    ports[Address].WriteB(Data);
end;

// TPeripheral

constructor TPeripheral.Create;
begin
  inherited;
  Data := 0;
end;

destructor TPeripheral.Destroy;
begin
  inherited;
end;

function TPeripheral.ReadB: Byte;
begin
  if Assigned(FOnRead) then
    Data := FOnRead
  else
    Data := 0;

  Result := Data;
end;

procedure TPeripheral.Reset;
begin
  Data := 0;

  if Assigned(FOnReset) then
    FOnReset;
end;

procedure TPeripheral.WriteB(Data: Byte);
begin
  if Assigned(FOnWrite) then
    FOnWrite(Data);
end;

function TCPUZ80.IORead(Addr: Byte): Byte;
begin
  Self.Addr := Addr;
  Synchronize(ExecIORead);
  Result := Value;
end;

procedure TCPUZ80.ExecIORead;
begin
  Value := IO.ReadB(Addr);
end;

procedure TCPUZ80.IOWrite(Addr, Value: Byte);
begin
  Self.Addr := Addr;
  Self.Value := Value;
  Synchronize(ExecIOWrite);
end;

procedure TCPUZ80.ExecIOWrite;
begin
  IO.WriteB(Addr, Value);
end;

function TCPUZ80.MemRead(Addr: Word): Byte;
begin
  Self.Addr := Addr;
  Synchronize(ExecMemRead);
  Result := Value;
end;

procedure TCPUZ80.ExecMemRead;
begin
  Value := Mem.ReadB(Addr);
end;

procedure TCPUZ80.MemWrite(Addr: Word; Value: Byte);
begin
  Self.Addr := Addr;
  Self.Value := Value;
  Synchronize(ExecMemWrite);
end;

procedure TCPUZ80.ExecMemWrite;
begin
  Mem.WriteB(Addr, Value);
end;

function TCPUZ80.MemRead(GotoNext: Boolean): Byte;
begin
  Self.GoToNext := GoToNext;
  Synchronize(MemReadGoToNext);
  Result := Value;
end;

procedure TCPUZ80.MemReadGoToNext;
begin
  Value := Mem.ReadB(GoToNext);
end;

procedure TCPUZ80.ExecInstructions(Instruction: byte);
begin
  if FExecMode = exMode1 then
    Instructions[DR]
  else if Instruction = $00 then
    NOP
  else if Instruction = $01 then
    LD_BC_Num
  else if Instruction = $02 then
    LD_BC_A
  else if Instruction = $03 then
    INC_BC
  else if Instruction = $04 then
    INC_B
  else if Instruction = $05 then
    DEC_B
  else if Instruction = $06 then
    LD_B_Num
  else if Instruction = $07 then
    RLCA
  else if Instruction = $08 then
    EX_AF_AF2
  else if Instruction = $09 then
    ADD_HL_BC
  else if Instruction = $0A then
    LDA_BC
  else if Instruction = $0B then
    DEC_BC
  else if Instruction = $0C then
    INC_C
  else if Instruction = $0D then
    DEC_C
  else if Instruction = $0E then
    LD_C_Num
  else if Instruction = $0F then
    RRCA
  else if Instruction = $10 then
    DJNZ
  else if Instruction = $11 then
    LD_DE_Num
  else if Instruction = $12 then
    LD_DE_A
  else if Instruction = $13 then
    INC_DE
  else if Instruction = $14 then
    INC_D
  else if Instruction = $15 then
    DEC_D
  else if Instruction = $16 then
    LD_D_Num
  else if Instruction = $17 then
    RLA
  else if Instruction = $18 then
    JR_Desloc
  else if Instruction = $19 then
    ADD_HL_DE
  else if Instruction = $1A then
    LDA_DE
  else if Instruction = $1B then
    DEC_DE
  else if Instruction = $1C then
    INC_E
  else if Instruction = $1D then
    DEC_E
  else if Instruction = $1E then
    LD_E_Num
  else if Instruction = $1F then
    RRA
  else if Instruction = $20 then
    JR_NZ_Desloc
  else if Instruction = $21 then
    LD_HL_Num
  else if Instruction = $22 then
    LD_Addr_HL
  else if Instruction = $23 then
    INC_HL
  else if Instruction = $24 then
    INC_H
  else if Instruction = $25 then
    DEC_H
  else if Instruction = $26 then
    LD_H_Num
  else if Instruction = $27 then
    DAA
  else if Instruction = $28 then
    JR_Z_Desloc
  else if Instruction = $29 then
    ADD_HL_HL
  else if Instruction = $2A then
    LD_HL_Addr
  else if Instruction = $2B then
    DEC_HL
  else if Instruction = $2C then
    INC_L
  else if Instruction = $2D then
    DEC_L
  else if Instruction = $2E then
    LD_L_Num
  else if Instruction = $2F then
    CPL
  else if Instruction = $30 then
    JR_NC_Desloc
  else if Instruction = $31 then
    LD_SP_NUM
  else if Instruction = $32 then
    LD_Addr_A
  else if Instruction = $33 then
    INC_SP
  else if Instruction = $34 then
    INC_MEM
  else if Instruction = $35 then
    DEC_MEM
  else if Instruction = $36 then
    LD_Mem_Num
  else if Instruction = $37 then
    SCF
  else if Instruction = $38 then
    JR_C_Desloc
  else if Instruction = $39 then
    ADD_HL_SP
  else if Instruction = $3A then
    LD_A_Addr
  else if Instruction = $3B then
    DEC_SP
  else if Instruction = $3C then
    INC_A
  else if Instruction = $3D then
    DEC_A
  else if Instruction = $3E then
    LD_A_Num
  else if Instruction = $3F then
    CCF
  else if Instruction = $40 then
    LD_B_B
  else if Instruction = $41 then
    LD_B_C
  else if Instruction = $42 then
    LD_B_D
  else if Instruction = $43 then
    LD_B_E
  else if Instruction = $44 then
    LD_B_H
  else if Instruction = $45 then
    LD_B_L
  else if Instruction = $46 then
    LD_B_MEM
  else if Instruction = $47 then
    LD_B_A
  else if Instruction = $48 then
    LD_C_B
  else if Instruction = $49 then
    LD_C_C
  else if Instruction = $4A then
    LD_C_D
  else if Instruction = $4B then
    LD_C_E
  else if Instruction = $4C then
    LD_C_H
  else if Instruction = $4D then
    LD_C_L
  else if Instruction = $4E then
    LD_C_MEM
  else if Instruction = $4F then
    LD_C_A
  else if Instruction = $50 then
    LD_D_B
  else if Instruction = $51 then
    LD_D_C
  else if Instruction = $52 then
    LD_D_D
  else if Instruction = $53 then
    LD_D_E
  else if Instruction = $54 then
    LD_D_H
  else if Instruction = $55 then
    LD_D_L
  else if Instruction = $56 then
    LD_D_MEM
  else if Instruction = $57 then
    LD_D_A
  else if Instruction = $58 then
    LD_E_B
  else if Instruction = $59 then
    LD_E_C
  else if Instruction = $5A then
    LD_E_D
  else if Instruction = $5B then
    LD_E_E
  else if Instruction = $5C then
    LD_E_H
  else if Instruction = $5D then
    LD_E_L
  else if Instruction = $5E then
    LD_E_MEM
  else if Instruction = $5F then
    LD_E_A
  else if Instruction = $60 then
    LD_H_B
  else if Instruction = $61 then
    LD_H_C
  else if Instruction = $62 then
    LD_H_D
  else if Instruction = $63 then
    LD_H_E
  else if Instruction = $64 then
    LD_H_H
  else if Instruction = $65 then
    LD_H_L
  else if Instruction = $66 then
    LD_H_MEM
  else if Instruction = $67 then
    LD_H_A
  else if Instruction = $68 then
    LD_L_B
  else if Instruction = $69 then
    LD_L_C
  else if Instruction = $6A then
    LD_L_D
  else if Instruction = $6B then
    LD_L_E
  else if Instruction = $6C then
    LD_L_H
  else if Instruction = $6D then
    LD_L_L
  else if Instruction = $6E then
    LD_L_MEM
  else if Instruction = $6F then
    LD_L_A
  else if Instruction = $70 then
    LD_Mem_B
  else if Instruction = $71 then
    LD_Mem_C
  else if Instruction = $72 then
    LD_Mem_D
  else if Instruction = $73 then
    LD_Mem_E
  else if Instruction = $74 then
    LD_Mem_H
  else if Instruction = $75 then
    LD_Mem_L
  else if Instruction = $76 then
    HALT_Z80
  else if Instruction = $77 then
    LD_Mem_A
  else if Instruction = $78 then
    LD_A_B
  else if Instruction = $79 then
    LD_A_C
  else if Instruction = $7A then
    LD_A_D
  else if Instruction = $7B then
    LD_A_E
  else if Instruction = $7C then
    LD_A_H
  else if Instruction = $7D then
    LD_A_L
  else if Instruction = $7E then
    LD_A_MEM
  else if Instruction = $7F then
    LD_A_A
  else if Instruction = $80 then
    ADD_A_B
  else if Instruction = $81 then
    ADD_A_C
  else if Instruction = $82 then
    ADD_A_D
  else if Instruction = $83 then
    ADD_A_E
  else if Instruction = $84 then
    ADD_A_H
  else if Instruction = $85 then
    ADD_A_L
  else if Instruction = $86 then
    ADD_A_MEM
  else if Instruction = $87 then
    ADD_A_A
  else if Instruction = $88 then
    ADC_A_B
  else if Instruction = $89 then
    ADC_A_C
  else if Instruction = $8A then
    ADC_A_D
  else if Instruction = $8B then
    ADC_A_E
  else if Instruction = $8C then
    ADC_A_H
  else if Instruction = $8D then
    ADC_A_L
  else if Instruction = $8E then
    ADC_A_MEM
  else if Instruction = $8F then
    ADC_A_A
  else if Instruction = $90 then
    SUB_B
  else if Instruction = $91 then
    SUB_C
  else if Instruction = $92 then
    SUB_D
  else if Instruction = $93 then
    SUB_E
  else if Instruction = $94 then
    SUB_H
  else if Instruction = $95 then
    SUB_L
  else if Instruction = $96 then
    SUB_MEM
  else if Instruction = $97 then
    SUB_A
  else if Instruction = $98 then
    SBC_A_B
  else if Instruction = $99 then
    SBC_A_C
  else if Instruction = $9A then
    SBC_A_D
  else if Instruction = $9B then
    SBC_A_E
  else if Instruction = $9C then
    SBC_A_H
  else if Instruction = $9D then
    SBC_A_L
  else if Instruction = $9E then
    SBC_A_MEM
  else if Instruction = $9F then
    SBC_A_A
  else if Instruction = $A0 then
    AND_B
  else if Instruction = $A1 then
    AND_C
  else if Instruction = $A2 then
    AND_D
  else if Instruction = $A3 then
    AND_E
  else if Instruction = $A4 then
    AND_H
  else if Instruction = $A5 then
    AND_L
  else if Instruction = $A6 then
    AND_MEM
  else if Instruction = $A7 then
    AND_A
  else if Instruction = $A8 then
    XOR_B
  else if Instruction = $A9 then
    XOR_C
  else if Instruction = $AA then
    XOR_D
  else if Instruction = $AB then
    XOR_E
  else if Instruction = $AC then
    XOR_H
  else if Instruction = $AD then
    XOR_L
  else if Instruction = $AE then
    XOR_MEM
  else if Instruction = $AF then
    XOR_A
  else if Instruction = $B0 then
    OR_B
  else if Instruction = $B1 then
    OR_C
  else if Instruction = $B2 then
    OR_D
  else if Instruction = $B3 then
    OR_E
  else if Instruction = $B4 then
    OR_H
  else if Instruction = $B5 then
    OR_L
  else if Instruction = $B6 then
    OR_MEM
  else if Instruction = $B7 then
    OR_A
  else if Instruction = $B8 then
    CP_B
  else if Instruction = $B9 then
    CP_C
  else if Instruction = $BA then
    CP_D
  else if Instruction = $BB then
    CP_E
  else if Instruction = $BC then
    CP_H
  else if Instruction = $BD then
    CP_L
  else if Instruction = $BE then
    CP_MEM
  else if Instruction = $BF then
    CP_A
  else if Instruction = $C0 then
    RET_NZ
  else if Instruction = $C1 then
    POP_BC
  else if Instruction = $C2 then
    JP_NZ_Addr
  else if Instruction = $C3 then
    JP_Addr
  else if Instruction = $C4 then
    CALL_NZ_Addr
  else if Instruction = $C5 then
    PUSH_BC
  else if Instruction = $C6 then
    ADD_A_Num
  else if Instruction = $C7 then
    RST_0
  else if Instruction = $C8 then
    RET_Z
  else if Instruction = $C9 then
    RET
  else if Instruction = $CA then
    JP_Z_Addr
  else if Instruction = $CB then
  begin
    if HL_Index = regHL then
    begin
      // $CB:
      Instruction := Mem.ReadB(True);

      if Instruction = $00 then
        RLC_B
      else if Instruction = $01 then
        RLC_C
      else if Instruction = $02 then
        RLC_D
      else if Instruction = $03 then
        RLC_E
      else if Instruction = $04 then
        RLC_H
      else if Instruction = $05 then
        RLC_L
      else if Instruction = $06 then
        RLC_MEM
      else if Instruction = $07 then
        RLC_A
      else if Instruction = $08 then
        RRC_B
      else if Instruction = $09 then
        RRC_C
      else if Instruction = $0A then
        RRC_D
      else if Instruction = $0B then
        RRC_E
      else if Instruction = $0C then
        RRC_H
      else if Instruction = $0D then
        RRC_L
      else if Instruction = $0E then
        RRC_MEM
      else if Instruction = $0F then
        RRC_A
      else if Instruction = $10 then
        RL_B
      else if Instruction = $11 then
        RL_C
      else if Instruction = $12 then
        RL_D
      else if Instruction = $13 then
        RL_E
      else if Instruction = $14 then
        RL_H
      else if Instruction = $15 then
        RL_L
      else if Instruction = $16 then
        RL_MEM
      else if Instruction = $17 then
        RL_A
      else if Instruction = $18 then
        RR_B
      else if Instruction = $19 then
        RR_C
      else if Instruction = $1A then
        RR_D
      else if Instruction = $1B then
        RR_E
      else if Instruction = $1C then
        RR_H
      else if Instruction = $1D then
        RR_L
      else if Instruction = $1E then
        RR_MEM
      else if Instruction = $1F then
        RR_A
      else if Instruction = $20 then
        SLA_B
      else if Instruction = $21 then
        SLA_C
      else if Instruction = $22 then
        SLA_D
      else if Instruction = $23 then
        SLA_E
      else if Instruction = $24 then
        SLA_H
      else if Instruction = $25 then
        SLA_L
      else if Instruction = $26 then
        SLA_MEM
      else if Instruction = $27 then
        SLA_A
      else if Instruction = $28 then
        SRA_B
      else if Instruction = $29 then
        SRA_C
      else if Instruction = $2A then
        SRA_D
      else if Instruction = $2B then
        SRA_E
      else if Instruction = $2C then
        SRA_H
      else if Instruction = $2D then
        SRA_L
      else if Instruction = $2E then
        SRA_MEM
      else if Instruction = $2F then
        SRA_A
      else if Instruction = $30 then
        SLL_B
      else if Instruction = $31 then
        SLL_C
      else if Instruction = $32 then
        SLL_D
      else if Instruction = $33 then
        SLL_E
      else if Instruction = $34 then
        SLL_H
      else if Instruction = $35 then
        SLL_L
      else if Instruction = $36 then
        SLL_MEM
      else if Instruction = $37 then
        SLL_A
      else if Instruction = $38 then
        SRL_B
      else if Instruction = $39 then
        SRL_C
      else if Instruction = $3A then
        SRL_D
      else if Instruction = $3B then
        SRL_E
      else if Instruction = $3C then
        SRL_H
      else if Instruction = $3D then
        SRL_L
      else if Instruction = $3E then
        SRL_MEM
      else if Instruction = $3F then
        SRL_A
      else if Instruction = $40 then
        BIT_0_B
      else if Instruction = $41 then
        BIT_0_C
      else if Instruction = $42 then
        BIT_0_D
      else if Instruction = $43 then
        BIT_0_E
      else if Instruction = $44 then
        BIT_0_H
      else if Instruction = $45 then
        BIT_0_L
      else if Instruction = $46 then
        BIT_0_MEM
      else if Instruction = $47 then
        BIT_0_A
      else if Instruction = $48 then
        BIT_1_B
      else if Instruction = $49 then
        BIT_1_C
      else if Instruction = $4A then
        BIT_1_D
      else if Instruction = $4B then
        BIT_1_E
      else if Instruction = $4C then
        BIT_1_H
      else if Instruction = $4D then
        BIT_1_L
      else if Instruction = $4E then
        BIT_1_MEM
      else if Instruction = $4F then
        BIT_1_A
      else if Instruction = $50 then
        BIT_2_B
      else if Instruction = $51 then
        BIT_2_C
      else if Instruction = $52 then
        BIT_2_D
      else if Instruction = $53 then
        BIT_2_E
      else if Instruction = $54 then
        BIT_2_H
      else if Instruction = $55 then
        BIT_2_L
      else if Instruction = $56 then
        BIT_2_MEM
      else if Instruction = $57 then
        BIT_2_A
      else if Instruction = $58 then
        BIT_3_B
      else if Instruction = $59 then
        BIT_3_C
      else if Instruction = $5A then
        BIT_3_D
      else if Instruction = $5B then
        BIT_3_E
      else if Instruction = $5C then
        BIT_3_H
      else if Instruction = $5D then
        BIT_3_L
      else if Instruction = $5E then
        BIT_3_MEM
      else if Instruction = $5F then
        BIT_3_A
      else if Instruction = $60 then
        BIT_4_B
      else if Instruction = $61 then
        BIT_4_C
      else if Instruction = $62 then
        BIT_4_D
      else if Instruction = $63 then
        BIT_4_E
      else if Instruction = $64 then
        BIT_4_H
      else if Instruction = $65 then
        BIT_4_L
      else if Instruction = $66 then
        BIT_4_MEM
      else if Instruction = $67 then
        BIT_4_A
      else if Instruction = $68 then
        BIT_5_B
      else if Instruction = $69 then
        BIT_5_C
      else if Instruction = $6A then
        BIT_5_D
      else if Instruction = $6B then
        BIT_5_E
      else if Instruction = $6C then
        BIT_5_H
      else if Instruction = $6D then
        BIT_5_L
      else if Instruction = $6E then
        BIT_5_MEM
      else if Instruction = $6F then
        BIT_5_A
      else if Instruction = $70 then
        BIT_6_B
      else if Instruction = $71 then
        BIT_6_C
      else if Instruction = $72 then
        BIT_6_D
      else if Instruction = $73 then
        BIT_6_E
      else if Instruction = $74 then
        BIT_6_H
      else if Instruction = $75 then
        BIT_6_L
      else if Instruction = $76 then
        BIT_6_MEM
      else if Instruction = $77 then
        BIT_6_A
      else if Instruction = $78 then
        BIT_7_B
      else if Instruction = $79 then
        BIT_7_C
      else if Instruction = $7A then
        BIT_7_D
      else if Instruction = $7B then
        BIT_7_E
      else if Instruction = $7C then
        BIT_7_H
      else if Instruction = $7D then
        BIT_7_L
      else if Instruction = $7E then
        BIT_7_MEM
      else if Instruction = $7F then
        BIT_7_A
      else if Instruction = $80 then
        RES_0_B
      else if Instruction = $81 then
        RES_0_C
      else if Instruction = $82 then
        RES_0_D
      else if Instruction = $83 then
        RES_0_E
      else if Instruction = $84 then
        RES_0_H
      else if Instruction = $85 then
        RES_0_L
      else if Instruction = $86 then
        RES_0_MEM
      else if Instruction = $87 then
        RES_0_A
      else if Instruction = $88 then
        RES_1_B
      else if Instruction = $89 then
        RES_1_C
      else if Instruction = $8A then
        RES_1_D
      else if Instruction = $8B then
        RES_1_E
      else if Instruction = $8C then
        RES_1_H
      else if Instruction = $8D then
        RES_1_L
      else if Instruction = $8E then
        RES_1_MEM
      else if Instruction = $8F then
        RES_1_A
      else if Instruction = $90 then
        RES_2_B
      else if Instruction = $91 then
        RES_2_C
      else if Instruction = $92 then
        RES_2_D
      else if Instruction = $93 then
        RES_2_E
      else if Instruction = $94 then
        RES_2_H
      else if Instruction = $95 then
        RES_2_L
      else if Instruction = $96 then
        RES_2_MEM
      else if Instruction = $97 then
        RES_2_A
      else if Instruction = $98 then
        RES_3_B
      else if Instruction = $99 then
        RES_3_C
      else if Instruction = $9A then
        RES_3_D
      else if Instruction = $9B then
        RES_3_E
      else if Instruction = $9C then
        RES_3_H
      else if Instruction = $9D then
        RES_3_L
      else if Instruction = $9E then
        RES_3_MEM
      else if Instruction = $9F then
        RES_3_A
      else if Instruction = $A0 then
        RES_4_B
      else if Instruction = $A1 then
        RES_4_C
      else if Instruction = $A2 then
        RES_4_D
      else if Instruction = $A3 then
        RES_4_E
      else if Instruction = $A4 then
        RES_4_H
      else if Instruction = $A5 then
        RES_4_L
      else if Instruction = $A6 then
        RES_4_MEM
      else if Instruction = $A7 then
        RES_4_A
      else if Instruction = $A8 then
        RES_5_B
      else if Instruction = $A9 then
        RES_5_C
      else if Instruction = $AA then
        RES_5_D
      else if Instruction = $AB then
        RES_5_E
      else if Instruction = $AC then
        RES_5_H
      else if Instruction = $AD then
        RES_5_L
      else if Instruction = $AE then
        RES_5_MEM
      else if Instruction = $AF then
        RES_5_A
      else if Instruction = $B0 then
        RES_6_B
      else if Instruction = $B1 then
        RES_6_C
      else if Instruction = $B2 then
        RES_6_D
      else if Instruction = $B3 then
        RES_6_E
      else if Instruction = $B4 then
        RES_6_H
      else if Instruction = $B5 then
        RES_6_L
      else if Instruction = $B6 then
        RES_6_MEM
      else if Instruction = $B7 then
        RES_6_A
      else if Instruction = $B8 then
        RES_7_B
      else if Instruction = $B9 then
        RES_7_C
      else if Instruction = $BA then
        RES_7_D
      else if Instruction = $BB then
        RES_7_E
      else if Instruction = $BC then
        RES_7_H
      else if Instruction = $BD then
        RES_7_L
      else if Instruction = $BE then
        RES_7_MEM
      else if Instruction = $BF then
        RES_7_A
      else if Instruction = $C0 then
        SET_0_B
      else if Instruction = $C1 then
        SET_0_C
      else if Instruction = $C2 then
        SET_0_D
      else if Instruction = $C3 then
        SET_0_E
      else if Instruction = $C4 then
        SET_0_H
      else if Instruction = $C5 then
        SET_0_L
      else if Instruction = $C6 then
        SET_0_MEM
      else if Instruction = $C7 then
        SET_0_A
      else if Instruction = $C8 then
        SET_1_B
      else if Instruction = $C9 then
        SET_1_C
      else if Instruction = $CA then
        SET_1_D
      else if Instruction = $CB then
        SET_1_E
      else if Instruction = $CC then
        SET_1_H
      else if Instruction = $CD then
        SET_1_L
      else if Instruction = $CE then
        SET_1_MEM
      else if Instruction = $CF then
        SET_1_A
      else if Instruction = $D0 then
        SET_2_B
      else if Instruction = $D1 then
        SET_2_C
      else if Instruction = $D2 then
        SET_2_D
      else if Instruction = $D3 then
        SET_2_E
      else if Instruction = $D4 then
        SET_2_H
      else if Instruction = $D5 then
        SET_2_L
      else if Instruction = $D6 then
        SET_2_MEM
      else if Instruction = $D7 then
        SET_2_A
      else if Instruction = $D8 then
        SET_3_B
      else if Instruction = $D9 then
        SET_3_C
      else if Instruction = $DA then
        SET_3_D
      else if Instruction = $DB then
        SET_3_E
      else if Instruction = $DC then
        SET_3_H
      else if Instruction = $DD then
        SET_3_L
      else if Instruction = $DE then
        SET_3_MEM
      else if Instruction = $DF then
        SET_3_A
      else if Instruction = $E0 then
        SET_4_B
      else if Instruction = $E1 then
        SET_4_C
      else if Instruction = $E2 then
        SET_4_D
      else if Instruction = $E3 then
        SET_4_E
      else if Instruction = $E4 then
        SET_4_H
      else if Instruction = $E5 then
        SET_4_L
      else if Instruction = $E6 then
        SET_4_MEM
      else if Instruction = $E7 then
        SET_4_A
      else if Instruction = $E8 then
        SET_5_B
      else if Instruction = $E9 then
        SET_5_C
      else if Instruction = $EA then
        SET_5_D
      else if Instruction = $EB then
        SET_5_E
      else if Instruction = $EC then
        SET_5_H
      else if Instruction = $ED then
        SET_5_L
      else if Instruction = $EE then
        SET_5_MEM
      else if Instruction = $EF then
        SET_5_A
      else if Instruction = $F0 then
        SET_6_B
      else if Instruction = $F1 then
        SET_6_C
      else if Instruction = $F2 then
        SET_6_D
      else if Instruction = $F3 then
        SET_6_E
      else if Instruction = $F4 then
        SET_6_H
      else if Instruction = $F5 then
        SET_6_L
      else if Instruction = $F6 then
        SET_6_MEM
      else if Instruction = $F7 then
        SET_6_A
      else if Instruction = $F8 then
        SET_7_B
      else if Instruction = $F9 then
        SET_7_C
      else if Instruction = $FA then
        SET_7_D
      else if Instruction = $FB then
        SET_7_E
      else if Instruction = $FC then
        SET_7_H
      else if Instruction = $FD then
        SET_7_L
      else if Instruction = $FE then
        SET_7_MEM
      else if Instruction = $FF then
        SET_7_A
    end
    else // $DD/$FD $CB
    begin
      Get_IDX_Address;
      Instruction := Mem.ReadB(True);

      if Instruction = $00 then
        LD_B_RLC_IDX_Num // DD/FD CB NUM 00
      else if Instruction = $01 then
        LD_C_RLC_IDX_Num // DD/FD CB NUM 01
      else if Instruction = $02 then
        LD_D_RLC_IDX_Num // DD/FD CB NUM 02
      else if Instruction = $03 then
        LD_E_RLC_IDX_Num // DD/FD CB NUM 03
      else if Instruction = $04 then
        LD_H_RLC_IDX_Num // DD/FD CB NUM 04
      else if Instruction = $05 then
        LD_L_RLC_IDX_Num // DD/FD CB NUM 05
      else if Instruction = $06 then
        RLC_IDX_Num // DD/FD CB NUM 06
      else if Instruction = $07 then
        LD_A_RLC_IDX_Num // DD/FD CB NUM 07
      else if Instruction = $08 then
        LD_B_RRC_IDX_Num // DD/FD CB NUM 08
      else if Instruction = $09 then
        LD_C_RRC_IDX_Num // DD/FD CB NUM 09
      else if Instruction = $0A then
        LD_D_RRC_IDX_Num // DD/FD CB NUM 0A
      else if Instruction = $0B then
        LD_E_RRC_IDX_Num // DD/FD CB NUM 0B
      else if Instruction = $0C then
        LD_H_RRC_IDX_Num // DD/FD CB NUM 0C
      else if Instruction = $0D then
        LD_L_RRC_IDX_Num // DD/FD CB NUM 0D
      else if Instruction = $0E then
        RRC_IDX_Num // DD/FD CB NUM 0E
      else if Instruction = $0F then
        LD_A_RRC_IDX_Num // DD/FD CB NUM 0F
      else if Instruction = $10 then
        LD_B_RL_IDX_Num // DD/FD CB NUM 10
      else if Instruction = $11 then
        LD_C_RL_IDX_Num // DD/FD CB NUM 11
      else if Instruction = $12 then
        LD_D_RL_IDX_Num // DD/FD CB NUM 12
      else if Instruction = $13 then
        LD_E_RL_IDX_Num // DD/FD CB NUM 13
      else if Instruction = $14 then
        LD_H_RL_IDX_Num // DD/FD CB NUM 14
      else if Instruction = $15 then
        LD_L_RL_IDX_Num // DD/FD CB NUM 15
      else if Instruction = $16 then
        RL_IDX_Num // DD/FD CB NUM 16
      else if Instruction = $17 then
        LD_A_RL_IDX_Num // DD/FD CB NUM 17
      else if Instruction = $18 then
        LD_B_RR_IDX_Num // DD/FD CB NUM 18
      else if Instruction = $19 then
        LD_C_RR_IDX_Num // DD/FD CB NUM 19
      else if Instruction = $1A then
        LD_D_RR_IDX_Num // DD/FD CB NUM 1A
      else if Instruction = $1B then
        LD_E_RR_IDX_Num // DD/FD CB NUM 1B
      else if Instruction = $1C then
        LD_H_RR_IDX_Num // DD/FD CB NUM 1C
      else if Instruction = $1D then
        LD_L_RR_IDX_Num // DD/FD CB NUM 1D
      else if Instruction = $1E then
        RR_IDX_Num // DD/FD CB NUM 1E
      else if Instruction = $1F then
        LD_A_RR_IDX_Num // DD/FD CB NUM 1F
      else if Instruction = $20 then
        LD_B_SLA_IDX_Num // DD/FD CB NUM 20
      else if Instruction = $21 then
        LD_C_SLA_IDX_Num // DD/FD CB NUM 21
      else if Instruction = $22 then
        LD_D_SLA_IDX_Num // DD/FD CB NUM 22
      else if Instruction = $23 then
        LD_E_SLA_IDX_Num // DD/FD CB NUM 23
      else if Instruction = $24 then
        LD_H_SLA_IDX_Num // DD/FD CB NUM 24
      else if Instruction = $25 then
        LD_L_SLA_IDX_Num // DD/FD CB NUM 25
      else if Instruction = $26 then
        SLA_IDX_Num // DD/FD CB NUM 26
      else if Instruction = $27 then
        LD_A_SLA_IDX_Num // DD/FD CB NUM 27
      else if Instruction = $28 then
        LD_B_SRA_IDX_Num // DD/FD CB NUM 28
      else if Instruction = $29 then
        LD_C_SRA_IDX_Num // DD/FD CB NUM 29
      else if Instruction = $2A then
        LD_D_SRA_IDX_Num // DD/FD CB NUM 2A
      else if Instruction = $2B then
        LD_E_SRA_IDX_Num // DD/FD CB NUM 2B
      else if Instruction = $2C then
        LD_H_SRA_IDX_Num // DD/FD CB NUM 2C
      else if Instruction = $2D then
        LD_L_SRA_IDX_Num // DD/FD CB NUM 2D
      else if Instruction = $2E then
        SRA_IDX_Num // DD/FD CB NUM 2E
      else if Instruction = $2F then
        LD_A_SRA_IDX_Num // DD/FD CB NUM 2F
      else if Instruction = $30 then
        LD_B_SLL_IDX_Num // DD/FD CB NUM 30
      else if Instruction = $31 then
        LD_C_SLL_IDX_Num // DD/FD CB NUM 31
      else if Instruction = $32 then
        LD_D_SLL_IDX_Num // DD/FD CB NUM 32
      else if Instruction = $33 then
        LD_E_SLL_IDX_Num // DD/FD CB NUM 33
      else if Instruction = $34 then
        LD_H_SLL_IDX_Num // DD/FD CB NUM 34
      else if Instruction = $35 then
        LD_L_SLL_IDX_Num // DD/FD CB NUM 35
      else if Instruction = $36 then
        SLL_IDX_Num // DD/FD CB NUM 36
      else if Instruction = $37 then
        LD_A_SLL_IDX_Num // DD/FD CB NUM 37
      else if Instruction = $38 then
        LD_B_SRL_IDX_Num // DD/FD CB NUM 38
      else if Instruction = $39 then
        LD_C_SRL_IDX_Num // DD/FD CB NUM 39
      else if Instruction = $3A then
        LD_D_SRL_IDX_Num // DD/FD CB NUM 3A
      else if Instruction = $3B then
        LD_E_SRL_IDX_Num // DD/FD CB NUM 3B
      else if Instruction = $3C then
        LD_H_SRL_IDX_Num // DD/FD CB NUM 3C
      else if Instruction = $3D then
        LD_L_SRL_IDX_Num // DD/FD CB NUM 3D
      else if Instruction = $3E then
        SRL_IDX_Num // DD/FD CB NUM 3E
      else if Instruction = $3F then
        LD_A_SRL_IDX_Num // DD/FD CB NUM 3F
      else if Instruction = $40 then
        BIT_0_IDX_Num_0 // DD/FD CB NUM 40
      else if Instruction = $41 then
        BIT_0_IDX_Num_1 // DD/FD CB NUM 41
      else if Instruction = $42 then
        BIT_0_IDX_Num_2 // DD/FD CB NUM 42
      else if Instruction = $43 then
        BIT_0_IDX_Num_3 // DD/FD CB NUM 43
      else if Instruction = $44 then
        BIT_0_IDX_Num_4 // DD/FD CB NUM 44
      else if Instruction = $45 then
        BIT_0_IDX_Num_5 // DD/FD CB NUM 45
      else if Instruction = $46 then
        BIT_0_IDX_Num // DD/FD CB NUM 46
      else if Instruction = $47 then
        BIT_0_IDX_Num_7 // DD/FD CB NUM 47
      else if Instruction = $48 then
        BIT_1_IDX_Num_0 // DD/FD CB NUM 48
      else if Instruction = $49 then
        BIT_1_IDX_Num_1 // DD/FD CB NUM 49
      else if Instruction = $4A then
        BIT_1_IDX_Num_2 // DD/FD CB NUM 4A
      else if Instruction = $4B then
        BIT_1_IDX_Num_3 // DD/FD CB NUM 4B
      else if Instruction = $4C then
        BIT_1_IDX_Num_4 // DD/FD CB NUM 4C
      else if Instruction = $4D then
        BIT_1_IDX_Num_5 // DD/FD CB NUM 4D
      else if Instruction = $4E then
        BIT_1_IDX_Num // DD/FD CB NUM 4E
      else if Instruction = $4F then
        BIT_1_IDX_Num_7 // DD/FD CB NUM 4F
      else if Instruction = $50 then
        BIT_2_IDX_Num_0 // DD/FD CB NUM 50
      else if Instruction = $51 then
        BIT_2_IDX_Num_1 // DD/FD CB NUM 51
      else if Instruction = $52 then
        BIT_2_IDX_Num_2 // DD/FD CB NUM 52
      else if Instruction = $53 then
        BIT_2_IDX_Num_3 // DD/FD CB NUM 53
      else if Instruction = $54 then
        BIT_2_IDX_Num_4 // DD/FD CB NUM 54
      else if Instruction = $55 then
        BIT_2_IDX_Num_5 // DD/FD CB NUM 55
      else if Instruction = $56 then
        BIT_2_IDX_Num // DD/FD CB NUM 56
      else if Instruction = $57 then
        BIT_2_IDX_Num_7 // DD/FD CB NUM 57
      else if Instruction = $58 then
        BIT_3_IDX_Num_0 // DD/FD CB NUM 58
      else if Instruction = $59 then
        BIT_3_IDX_Num_1 // DD/FD CB NUM 59
      else if Instruction = $5A then
        BIT_3_IDX_Num_2 // DD/FD CB NUM 5A
      else if Instruction = $5B then
        BIT_3_IDX_Num_3 // DD/FD CB NUM 5B
      else if Instruction = $5C then
        BIT_3_IDX_Num_4 // DD/FD CB NUM 5C
      else if Instruction = $5D then
        BIT_3_IDX_Num_5 // DD/FD CB NUM 5D
      else if Instruction = $5E then
        BIT_3_IDX_Num // DD/FD CB NUM 5E
      else if Instruction = $5F then
        BIT_3_IDX_Num_7 // DD/FD CB NUM 5F
      else if Instruction = $60 then
        BIT_4_IDX_Num_0 // DD/FD CB NUM 60
      else if Instruction = $61 then
        BIT_4_IDX_Num_1 // DD/FD CB NUM 61
      else if Instruction = $62 then
        BIT_4_IDX_Num_2 // DD/FD CB NUM 62
      else if Instruction = $63 then
        BIT_4_IDX_Num_3 // DD/FD CB NUM 63
      else if Instruction = $64 then
        BIT_4_IDX_Num_4 // DD/FD CB NUM 64
      else if Instruction = $65 then
        BIT_4_IDX_Num_5 // DD/FD CB NUM 65
      else if Instruction = $66 then
        BIT_4_IDX_Num // DD/FD CB NUM 66
      else if Instruction = $67 then
        BIT_4_IDX_Num_7 // DD/FD CB NUM 67
      else if Instruction = $68 then
        BIT_5_IDX_Num_0 // DD/FD CB NUM 68
      else if Instruction = $69 then
        BIT_5_IDX_Num_1 // DD/FD CB NUM 69
      else if Instruction = $6A then
        BIT_5_IDX_Num_2 // DD/FD CB NUM 6A
      else if Instruction = $6B then
        BIT_5_IDX_Num_3 // DD/FD CB NUM 6B
      else if Instruction = $6C then
        BIT_5_IDX_Num_4 // DD/FD CB NUM 6C
      else if Instruction = $6D then
        BIT_5_IDX_Num_5 // DD/FD CB NUM 6D
      else if Instruction = $6E then
        BIT_5_IDX_Num // DD/FD CB NUM 6E
      else if Instruction = $6F then
        BIT_5_IDX_Num_7 // DD/FD CB NUM 6F
      else if Instruction = $70 then
        BIT_6_IDX_Num_0 // DD/FD CB NUM 70
      else if Instruction = $71 then
        BIT_6_IDX_Num_1 // DD/FD CB NUM 71
      else if Instruction = $72 then
        BIT_6_IDX_Num_2 // DD/FD CB NUM 72
      else if Instruction = $73 then
        BIT_6_IDX_Num_3 // DD/FD CB NUM 73
      else if Instruction = $74 then
        BIT_6_IDX_Num_4 // DD/FD CB NUM 74
      else if Instruction = $75 then
        BIT_6_IDX_Num_5 // DD/FD CB NUM 75
      else if Instruction = $76 then
        BIT_6_IDX_Num // DD/FD CB NUM 76
      else if Instruction = $77 then
        BIT_6_IDX_Num_7 // DD/FD CB NUM 77
      else if Instruction = $78 then
        BIT_7_IDX_Num_0 // DD/FD CB NUM 78
      else if Instruction = $79 then
        BIT_7_IDX_Num_1 // DD/FD CB NUM 79
      else if Instruction = $7A then
        BIT_7_IDX_Num_2 // DD/FD CB NUM 7A
      else if Instruction = $7B then
        BIT_7_IDX_Num_3 // DD/FD CB NUM 7B
      else if Instruction = $7C then
        BIT_7_IDX_Num_4 // DD/FD CB NUM 7C
      else if Instruction = $7D then
        BIT_7_IDX_Num_5 // DD/FD CB NUM 7D
      else if Instruction = $7E then
        BIT_7_IDX_Num // DD/FD CB NUM 7E
      else if Instruction = $7F then
        BIT_7_IDX_Num_7 // DD/FD CB NUM 7F
      else if Instruction = $80 then
        LD_B_RES_0_IDX_Num // DD/FD CB NUM 80
      else if Instruction = $81 then
        LD_C_RES_0_IDX_Num // DD/FD CB NUM 81
      else if Instruction = $82 then
        LD_D_RES_0_IDX_Num // DD/FD CB NUM 82
      else if Instruction = $83 then
        LD_E_RES_0_IDX_Num // DD/FD CB NUM 83
      else if Instruction = $84 then
        LD_H_RES_0_IDX_Num // DD/FD CB NUM 84
      else if Instruction = $85 then
        LD_L_RES_0_IDX_Num // DD/FD CB NUM 85
      else if Instruction = $86 then
        RES_0_IDX_Num // DD/FD CB NUM 86
      else if Instruction = $87 then
        LD_A_RES_0_IDX_Num // DD/FD CB NUM 87
      else if Instruction = $88 then
        LD_B_RES_1_IDX_Num // DD/FD CB NUM 88
      else if Instruction = $89 then
        LD_C_RES_1_IDX_Num // DD/FD CB NUM 89
      else if Instruction = $8A then
        LD_D_RES_1_IDX_Num // DD/FD CB NUM 8A
      else if Instruction = $8B then
        LD_E_RES_1_IDX_Num // DD/FD CB NUM 8B
      else if Instruction = $8C then
        LD_H_RES_1_IDX_Num // DD/FD CB NUM 8C
      else if Instruction = $8D then
        LD_L_RES_1_IDX_Num // DD/FD CB NUM 8D
      else if Instruction = $8E then
        RES_1_IDX_Num // DD/FD CB NUM 8E
      else if Instruction = $8F then
        LD_A_RES_1_IDX_Num // DD/FD CB NUM 8F
      else if Instruction = $90 then
        LD_B_RES_2_IDX_Num // DD/FD CB NUM 90
      else if Instruction = $91 then
        LD_C_RES_2_IDX_Num // DD/FD CB NUM 91
      else if Instruction = $92 then
        LD_D_RES_2_IDX_Num // DD/FD CB NUM 92
      else if Instruction = $93 then
        LD_E_RES_2_IDX_Num // DD/FD CB NUM 93
      else if Instruction = $94 then
        LD_H_RES_2_IDX_Num // DD/FD CB NUM 94
      else if Instruction = $95 then
        LD_L_RES_2_IDX_Num // DD/FD CB NUM 95
      else if Instruction = $96 then
        RES_2_IDX_Num // DD/FD CB NUM 96
      else if Instruction = $97 then
        LD_A_RES_2_IDX_Num // DD/FD CB NUM 97
      else if Instruction = $98 then
        LD_B_RES_3_IDX_Num // DD/FD CB NUM 98
      else if Instruction = $99 then
        LD_C_RES_3_IDX_Num // DD/FD CB NUM 99
      else if Instruction = $9A then
        LD_D_RES_3_IDX_Num // DD/FD CB NUM 9A
      else if Instruction = $9B then
        LD_E_RES_3_IDX_Num // DD/FD CB NUM 9B
      else if Instruction = $9C then
        LD_H_RES_3_IDX_Num // DD/FD CB NUM 9C
      else if Instruction = $9D then
        LD_L_RES_3_IDX_Num // DD/FD CB NUM 9D
      else if Instruction = $9E then
        RES_3_IDX_Num // DD/FD CB NUM 9E
      else if Instruction = $9F then
        LD_A_RES_3_IDX_Num // DD/FD CB NUM 9F
      else if Instruction = $A0 then
        LD_B_RES_4_IDX_Num // DD/FD CB NUM A0
      else if Instruction = $A1 then
        LD_C_RES_4_IDX_Num // DD/FD CB NUM A1
      else if Instruction = $A2 then
        LD_D_RES_4_IDX_Num // DD/FD CB NUM A2
      else if Instruction = $A3 then
        LD_E_RES_4_IDX_Num // DD/FD CB NUM A3
      else if Instruction = $A4 then
        LD_H_RES_4_IDX_Num // DD/FD CB NUM A4
      else if Instruction = $A5 then
        LD_L_RES_4_IDX_Num // DD/FD CB NUM A5
      else if Instruction = $A6 then
        RES_4_IDX_Num // DD/FD CB NUM A6
      else if Instruction = $A7 then
        LD_A_RES_4_IDX_Num // DD/FD CB NUM A7
      else if Instruction = $A8 then
        LD_B_RES_5_IDX_Num // DD/FD CB NUM A8
      else if Instruction = $A9 then
        LD_C_RES_5_IDX_Num // DD/FD CB NUM A9
      else if Instruction = $AA then
        LD_D_RES_5_IDX_Num // DD/FD CB NUM AA
      else if Instruction = $AB then
        LD_E_RES_5_IDX_Num // DD/FD CB NUM AB
      else if Instruction = $AC then
        LD_H_RES_5_IDX_Num // DD/FD CB NUM AC
      else if Instruction = $AD then
        LD_L_RES_5_IDX_Num // DD/FD CB NUM AD
      else if Instruction = $AE then
        RES_5_IDX_Num // DD/FD CB NUM AE
      else if Instruction = $AF then
        LD_A_RES_5_IDX_Num // DD/FD CB NUM AF
      else if Instruction = $B0 then
        LD_B_RES_6_IDX_Num // DD/FD CB NUM B0
      else if Instruction = $B1 then
        LD_C_RES_6_IDX_Num // DD/FD CB NUM B1
      else if Instruction = $B2 then
        LD_D_RES_6_IDX_Num // DD/FD CB NUM B2
      else if Instruction = $B3 then
        LD_E_RES_6_IDX_Num // DD/FD CB NUM B3
      else if Instruction = $B4 then
        LD_H_RES_6_IDX_Num // DD/FD CB NUM B4
      else if Instruction = $B5 then
        LD_L_RES_6_IDX_Num // DD/FD CB NUM B5
      else if Instruction = $B6 then
        RES_6_IDX_Num // DD/FD CB NUM B6
      else if Instruction = $B7 then
        LD_A_RES_6_IDX_Num // DD/FD CB NUM B7
      else if Instruction = $B8 then
        LD_B_RES_7_IDX_Num // DD/FD CB NUM B8
      else if Instruction = $B9 then
        LD_C_RES_7_IDX_Num // DD/FD CB NUM B9
      else if Instruction = $BA then
        LD_D_RES_7_IDX_Num // DD/FD CB NUM BA
      else if Instruction = $BB then
        LD_E_RES_7_IDX_Num // DD/FD CB NUM BB
      else if Instruction = $BC then
        LD_H_RES_7_IDX_Num // DD/FD CB NUM BC
      else if Instruction = $BD then
        LD_L_RES_7_IDX_Num // DD/FD CB NUM BD
      else if Instruction = $BE then
        RES_7_IDX_Num // DD/FD CB NUM BE
      else if Instruction = $BF then
        LD_A_RES_7_IDX_Num // DD/FD CB NUM BF
      else if Instruction = $C0 then
        LD_B_SET_0_IDX_Num // DD/FD CB NUM C0
      else if Instruction = $C1 then
        LD_C_SET_0_IDX_Num // DD/FD CB NUM C1
      else if Instruction = $C2 then
        LD_D_SET_0_IDX_Num // DD/FD CB NUM C2
      else if Instruction = $C3 then
        LD_E_SET_0_IDX_Num // DD/FD CB NUM C3
      else if Instruction = $C4 then
        LD_H_SET_0_IDX_Num // DD/FD CB NUM C4
      else if Instruction = $C5 then
        LD_L_SET_0_IDX_Num // DD/FD CB NUM C5
      else if Instruction = $C6 then
        SET_0_IDX_Num // DD/FD CB NUM C6
      else if Instruction = $C7 then
        LD_A_SET_0_IDX_Num // DD/FD CB NUM C7
      else if Instruction = $C8 then
        LD_B_SET_1_IDX_Num // DD/FD CB NUM C8
      else if Instruction = $C9 then
        LD_C_SET_1_IDX_Num // DD/FD CB NUM C9
      else if Instruction = $CA then
        LD_D_SET_1_IDX_Num // DD/FD CB NUM CA
      else if Instruction = $CB then
        LD_E_SET_1_IDX_Num // DD/FD CB NUM CB
      else if Instruction = $CC then
        LD_H_SET_1_IDX_Num // DD/FD CB NUM CC
      else if Instruction = $CD then
        LD_L_SET_1_IDX_Num // DD/FD CB NUM CD
      else if Instruction = $CE then
        SET_1_IDX_Num // DD/FD CB NUM CE
      else if Instruction = $CF then
        LD_A_SET_1_IDX_Num // DD/FD CB NUM CF
      else if Instruction = $D0 then
        LD_B_SET_2_IDX_Num // DD/FD CB NUM D0
      else if Instruction = $D1 then
        LD_C_SET_2_IDX_Num // DD/FD CB NUM D1
      else if Instruction = $D2 then
        LD_D_SET_2_IDX_Num // DD/FD CB NUM D2
      else if Instruction = $D3 then
        LD_E_SET_2_IDX_Num // DD/FD CB NUM D3
      else if Instruction = $D4 then
        LD_H_SET_2_IDX_Num // DD/FD CB NUM D4
      else if Instruction = $D5 then
        LD_L_SET_2_IDX_Num // DD/FD CB NUM D5
      else if Instruction = $D6 then
        SET_2_IDX_Num // DD/FD CB NUM D6
      else if Instruction = $D7 then
        LD_A_SET_2_IDX_Num // DD/FD CB NUM D7
      else if Instruction = $D8 then
        LD_B_SET_3_IDX_Num // DD/FD CB NUM D8
      else if Instruction = $D9 then
        LD_C_SET_3_IDX_Num // DD/FD CB NUM D9
      else if Instruction = $DA then
        LD_D_SET_3_IDX_Num // DD/FD CB NUM DA
      else if Instruction = $DB then
        LD_E_SET_3_IDX_Num // DD/FD CB NUM DB
      else if Instruction = $DC then
        LD_H_SET_3_IDX_Num // DD/FD CB NUM DC
      else if Instruction = $DD then
        LD_L_SET_3_IDX_Num // DD/FD CB NUM DD
      else if Instruction = $DE then
        SET_3_IDX_Num // DD/FD CB NUM DE
      else if Instruction = $DF then
        LD_A_SET_3_IDX_Num // DD/FD CB NUM DF
      else if Instruction = $E0 then
        LD_B_SET_4_IDX_Num // DD/FD CB NUM E0
      else if Instruction = $E1 then
        LD_C_SET_4_IDX_Num // DD/FD CB NUM E1
      else if Instruction = $E2 then
        LD_D_SET_4_IDX_Num // DD/FD CB NUM E2
      else if Instruction = $E3 then
        LD_E_SET_4_IDX_Num // DD/FD CB NUM E3
      else if Instruction = $E4 then
        LD_H_SET_4_IDX_Num // DD/FD CB NUM E4
      else if Instruction = $E5 then
        LD_L_SET_4_IDX_Num // DD/FD CB NUM E5
      else if Instruction = $E6 then
        SET_4_IDX_Num // DD/FD CB NUM E6
      else if Instruction = $E7 then
        LD_A_SET_4_IDX_Num // DD/FD CB NUM E7
      else if Instruction = $E8 then
        LD_B_SET_5_IDX_Num // DD/FD CB NUM E8
      else if Instruction = $E9 then
        LD_C_SET_5_IDX_Num // DD/FD CB NUM E9
      else if Instruction = $EA then
        LD_D_SET_5_IDX_Num // DD/FD CB NUM EA
      else if Instruction = $EB then
        LD_E_SET_5_IDX_Num // DD/FD CB NUM EB
      else if Instruction = $EC then
        LD_H_SET_5_IDX_Num // DD/FD CB NUM EC
      else if Instruction = $ED then
        LD_L_SET_5_IDX_Num // DD/FD CB NUM ED
      else if Instruction = $EE then
        SET_5_IDX_Num // DD/FD CB NUM EE
      else if Instruction = $EF then
        LD_A_SET_5_IDX_Num // DD/FD CB NUM EF
      else if Instruction = $F0 then
        LD_B_SET_6_IDX_Num // DD/FD CB NUM F0
      else if Instruction = $F1 then
        LD_C_SET_6_IDX_Num // DD/FD CB NUM F1
      else if Instruction = $F2 then
        LD_D_SET_6_IDX_Num // DD/FD CB NUM F2
      else if Instruction = $F3 then
        LD_E_SET_6_IDX_Num // DD/FD CB NUM F3
      else if Instruction = $F4 then
        LD_H_SET_6_IDX_Num // DD/FD CB NUM F4
      else if Instruction = $F5 then
        LD_L_SET_6_IDX_Num // DD/FD CB NUM F5
      else if Instruction = $F6 then
        SET_6_IDX_Num // DD/FD CB NUM F6
      else if Instruction = $F7 then
        LD_A_SET_6_IDX_Num // DD/FD CB NUM F7
      else if Instruction = $F8 then
        LD_B_SET_7_IDX_Num // DD/FD CB NUM F8
      else if Instruction = $F9 then
        LD_C_SET_7_IDX_Num // DD/FD CB NUM F9
      else if Instruction = $FA then
        LD_D_SET_7_IDX_Num // DD/FD CB NUM FA
      else if Instruction = $FB then
        LD_E_SET_7_IDX_Num // DD/FD CB NUM FB
      else if Instruction = $FC then
        LD_H_SET_7_IDX_Num // DD/FD CB NUM FC
      else if Instruction = $FD then
        LD_L_SET_7_IDX_Num // DD/FD CB NUM FD
      else if Instruction = $FE then
        SET_7_IDX_Num // DD/FD CB NUM FE
      else if Instruction = $FF then
        LD_A_SET_7_IDX_Num // DD/FD CB NUM FF
    end;
  end
  else if Instruction = $CC then
    CALL_Z_Addr
  else if Instruction = $CD then
    CALL_Addr
  else if Instruction = $CE then
    ADC_A_Num
  else if Instruction = $CF then
    RST_8
  else if Instruction = $D0 then
    RET_NC
  else if Instruction = $D1 then
    POP_DE
  else if Instruction = $D2 then
    JP_NC_Addr
  else if Instruction = $D3 then
    OUT_A_PORT
  else if Instruction = $D4 then
    CALL_NC_Addr
  else if Instruction = $D5 then
    PUSH_DE
  else if Instruction = $D6 then
    SUB_Num
  else if Instruction = $D7 then
    RST_16
  else if Instruction = $D8 then
    RET_C
  else if Instruction = $D9 then
    EXX
  else if Instruction = $DA then
    JP_C_Addr
  else if Instruction = $DB then
    IN_A_PORT
  else if Instruction = $DC then
    CALL_C_Addr
  else if Instruction = $DD then
    Alt_HL_To_IX
  else if Instruction = $DE then
    SBC_A_Num
  else if Instruction = $DF then
    RST_24
  else if Instruction = $E0 then
    RET_PO
  else if Instruction = $E1 then
    POP_HL
  else if Instruction = $E2 then
    JP_PO_Addr
  else if Instruction = $E3 then
    EX_SP_HL
  else if Instruction = $E4 then
    CALL_PO_Addr
  else if Instruction = $E5 then
    PUSH_HL
  else if Instruction = $E6 then
    AND_Num
  else if Instruction = $E7 then
    RST_32
  else if Instruction = $E8 then
    RET_PE
  else if Instruction = $E9 then
    JP_HL
  else if Instruction = $EA then
    JP_PE_Addr
  else if Instruction = $EB then
    EX_DE_HL
  else if Instruction = $EC then
    CALL_PE_Addr
  else if Instruction = $ED then
  begin
    Instruction := Mem.ReadB(True);

    if Instruction = $40 then
      IN_B_C
    else if Instruction = $41 then
      OUT_C_B
    else if Instruction = $42 then
      SBC_HL_BC
    else if Instruction = $43 then
      LD_Addr_BC
    else if Instruction = $44 then
      NEG
    else if Instruction = $45 then
      RETN
    else if Instruction = $46 then
      IM_0
    else if Instruction = $47 then
      LD_I_A
    else if Instruction = $48 then
      IN_C_C
    else if Instruction = $49 then
      OUT_C_C
    else if Instruction = $4A then
      ADC_HL_BC
    else if Instruction = $4B then
      LD_BC_Addr
    else if Instruction = $4D then
      RETI
    else if Instruction = $4F then
      LD_R_A
    else if Instruction = $50 then
      IN_D_C
    else if Instruction = $51 then
      OUT_C_D
    else if Instruction = $52 then
      SBC_HL_DE
    else if Instruction = $53 then
      LD_Addr_DE
    else if Instruction = $56 then
      IM_1
    else if Instruction = $57 then
      LD_A_I
    else if Instruction = $58 then
      IN_E_C
    else if Instruction = $59 then
      OUT_C_E
    else if Instruction = $5A then
      ADC_HL_DE
    else if Instruction = $5B then
      LD_DE_Addr
    else if Instruction = $5E then
      IM_2
    else if Instruction = $5F then
      LD_A_R
    else if Instruction = $60 then
      IN_H_C
    else if Instruction = $61 then
      OUT_C_H
    else if Instruction = $62 then
      SBC_HL_HL
    else if Instruction = $63 then
      LD_Addr_HL_2
    else if Instruction = $67 then
      RRD
    else if Instruction = $68 then
      IN_L_C
    else if Instruction = $69 then
      OUT_C_L
    else if Instruction = $6A then
      ADC_HL_HL
    else if Instruction = $6B then
      LD_HL_Addr_2
    else if Instruction = $6F then
      RLD
    else if Instruction = $72 then
      SBC_HL_SP
    else if Instruction = $73 then
      LD_Addr_SP
    else if Instruction = $78 then
      IN_A_C
    else if Instruction = $79 then
      OUT_C_A
    else if Instruction = $7A then
      ADC_HL_SP
    else if Instruction = $7B then
      LD_SP_Addr
    else if Instruction = $A0 then
      LDI
    else if Instruction = $A1 then
      CPI
    else if Instruction = $A2 then
      INI
    else if Instruction = $A3 then
      OUTI
    else if Instruction = $A8 then
      LDD
    else if Instruction = $A9 then
      CPD
    else if Instruction = $AA then
      IND
    else if Instruction = $AB then
      OUTD
    else if Instruction = $B0 then
      LDIR
    else if Instruction = $B1 then
      CPIR
    else if Instruction = $B8 then
      LDDR
    else if Instruction = $B9 then
      CPDR
    else if Instruction = $BA then
      INDR
    else if Instruction = $B2 then
      INIR
    else if Instruction = $B3 then
      OTIR
    else if Instruction = $BB then
      OTDR

      // $ED (HD 64180)
    else if Instruction = $00 then
      IN0_B_PORT
    else if Instruction = $01 then
      OUT0_PORT_B
    else if Instruction = $04 then
      TST_B
    else if Instruction = $08 then
      IN0_C_PORT
    else if Instruction = $09 then
      OUT0_PORT_C
    else if Instruction = $0C then
      TST_C
    else if Instruction = $10 then
      IN0_D_PORT
    else if Instruction = $11 then
      OUT0_PORT_D
    else if Instruction = $14 then
      TST_D
    else if Instruction = $18 then
      IN0_E_PORT
    else if Instruction = $19 then
      OUT0_PORT_E
    else if Instruction = $1C then
      TST_E
    else if Instruction = $20 then
      IN0_H_PORT
    else if Instruction = $21 then
      OUT0_PORT_H
    else if Instruction = $24 then
      TST_H
    else if Instruction = $28 then
      IN0_L_PORT
    else if Instruction = $29 then
      OUT0_PORT_L
    else if Instruction = $2C then
      TST_L
    else if Instruction = $30 then
      IN0_PORT
    else if Instruction = $34 then
      TST_MEM
    else if Instruction = $38 then
      IN0_A_PORT
    else if Instruction = $39 then
      OUT0_PORT_A
    else if Instruction = $3C then
      TST_A
    else if Instruction = $4C then
      MULT_BC
    else if Instruction = $5C then
      MULT_DE
    else if Instruction = $64 then
      TST_Num
    else if Instruction = $6C then
      MULT_HL
    else if Instruction = $70 then
      IN_C
    else if Instruction = $71 then
      OUT_C_0
    else if Instruction = $74 then
      TSTIO_Num
    else if Instruction = $76 then
      SLP
    else if Instruction = $7C then
      MULT_SP
    else if Instruction = $83 then
      OTIM
    else if Instruction = $8B then
      OTDM
    else if Instruction = $93 then
      OTIMR
    else if Instruction = $9B then
      OTDMR
  end
  else if Instruction = $EE then
    XOR_Num
  else if Instruction = $EF then
    RST_40
  else if Instruction = $F0 then
    RET_P
  else if Instruction = $F1 then
    POP_AF
  else if Instruction = $F2 then
    JP_P_Addr
  else if Instruction = $F3 then
    DI
  else if Instruction = $F4 then
    CALL_P_Addr
  else if Instruction = $F5 then
    PUSH_AF
  else if Instruction = $F6 then
    OR_Num
  else if Instruction = $F7 then
    RST_48
  else if Instruction = $F8 then
    RET_N
  else if Instruction = $F9 then
    LD_SP_HL
  else if Instruction = $FA then
    JP_N_Addr
  else if Instruction = $FB then
    EI
  else if Instruction = $FC then
    CALL_N_Addr
  else if Instruction = $FD then
    Alt_HL_To_IY
  else if Instruction = $FE then
    CP_Num
  else if Instruction = $FF then
    RST_56
end;

procedure TMemory.SetWriteInROM(const Value: Boolean);
begin
  FWriteInROM := Value;
end;

procedure TCPUZ80.ExecStop;
begin
  FStopped := True;
  FRunning := False;
  DisasmPrevious(FCurrCommand);

  Sleep(0);

  if Assigned(FOnStop) then
    FOnStop(Self);
end;

procedure TCPUZ80.ExecStepEvent;
begin
  FOnStep(Self, FRunning);
end;

end.
