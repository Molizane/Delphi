unit CobaltSDK_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.88  $
// File generated on 26/08/2001 11:29:26 p.m. from Type Library described below.

// ************************************************************************ //
// Type Lib: E:\WINNT\System32\cobalt.ocx (1)
// IID\LCID: {71B532C5-96C7-11D5-AFEE-00E018023072}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (E:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (E:\WINNT\System32\STDVCL40.DLL)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  CobaltSDKMajorVersion = 3;
  CobaltSDKMinorVersion = 0;

  LIBID_CobaltSDK: TGUID = '{71B532C5-96C7-11D5-AFEE-00E018023072}';

  IID__NN: TGUID = '{EE26EA97-9A02-11D5-AFF2-00E018023072}';
  DIID___NN: TGUID = '{EE26EA98-9A02-11D5-AFF2-00E018023072}';
  IID__GA: TGUID = '{EE26EA99-9A02-11D5-AFF2-00E018023072}';
  DIID___GA: TGUID = '{EE26EA9A-9A02-11D5-AFF2-00E018023072}';
  IID__FZ: TGUID = '{EE26EA9B-9A02-11D5-AFF2-00E018023072}';
  DIID___FZ: TGUID = '{EE26EA9C-9A02-11D5-AFF2-00E018023072}';
  IID__Chromosome: TGUID = '{EE26EA9D-9A02-11D5-AFF2-00E018023072}';
  CLASS_Chromosome: TGUID = '{71B532CA-96C7-11D5-AFEE-00E018023072}';
  IID__FileReader: TGUID = '{EE26EA9E-9A02-11D5-AFF2-00E018023072}';
  CLASS_FileReader: TGUID = '{71B532D6-96C7-11D5-AFEE-00E018023072}';
  IID__HeaderInfo: TGUID = '{EE26EA9F-9A02-11D5-AFF2-00E018023072}';
  CLASS_HeaderInfo: TGUID = '{71B532D4-96C7-11D5-AFEE-00E018023072}';
  IID__Row: TGUID = '{EE26EAA0-9A02-11D5-AFF2-00E018023072}';
  CLASS_Row: TGUID = '{71B532D2-96C7-11D5-AFEE-00E018023072}';
  CLASS_NN: TGUID = '{71B532C7-96C7-11D5-AFEE-00E018023072}';
  CLASS_GA: TGUID = '{71B532CC-96C7-11D5-AFEE-00E018023072}';
  CLASS_FZ: TGUID = '{71B532CF-96C7-11D5-AFEE-00E018023072}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _NN = interface;
  _NNDisp = dispinterface;
  __NN = dispinterface;
  _GA = interface;
  _GADisp = dispinterface;
  __GA = dispinterface;
  _FZ = interface;
  _FZDisp = dispinterface;
  __FZ = dispinterface;
  _Chromosome = interface;
  _ChromosomeDisp = dispinterface;
  _FileReader = interface;
  _FileReaderDisp = dispinterface;
  _HeaderInfo = interface;
  _HeaderInfoDisp = dispinterface;
  _Row = interface;
  _RowDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Chromosome = _Chromosome;
  FileReader = _FileReader;
  HeaderInfo = _HeaderInfo;
  Row = _Row;
  NN = _NN;
  GA = _GA;
  FZ = _FZ;


// *********************************************************************//
// Interface: _NN
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA97-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _NN = interface(IDispatch)
    ['{EE26EA97-9A02-11D5-AFF2-00E018023072}']
    function  Get_RefreshRate: Integer; safecall;
    procedure Set_RefreshRate(RefreshRate: Integer); safecall;
    function  Cancel: OleVariant; safecall;
    function  Train(var FileNameOrData: WideString; var DataOption: Smallint; var Epochs: Integer;
                    var LearningRate: Double; var Momentum: Double; var MaxNeurons: Smallint;
                    var ResetWeights: Smallint): Smallint; safecall;
    function  Predict(var FileNameOrData: WideString; var DataOption: Smallint;
                      var LearningRate: Double; var Momentum: Double): Double; safecall;
    function  BatchPredict(var FileNameOrData: WideString; var DataOption: Smallint;
                           var OutputFileName: WideString; var LearningRate: Double;
                           var Momentum: Double): Integer; safecall;
    procedure saveNetwork(var FileName: WideString); safecall;
    function  loadNetwork(var FileNameOrData: WideString; var DataOption: Smallint;
                          var NetFileName: WideString; var LearningRate: Double;
                          var Momentum: Double; var MaxNeurons: Smallint): Smallint; safecall;
    function  getValue(var Row: Integer; var Col: Integer): Double; safecall;
    function  getLastValue: Double; safecall;
    function  About: OleVariant; safecall;
    property RefreshRate: Integer read Get_RefreshRate write Set_RefreshRate;
  end;

// *********************************************************************//
// DispIntf:  _NNDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA97-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _NNDisp = dispinterface
    ['{EE26EA97-9A02-11D5-AFF2-00E018023072}']
    property RefreshRate: Integer dispid 1073938470;
    function  Cancel: OleVariant; dispid 1610809382;
    function  Train(var FileNameOrData: WideString; var DataOption: Smallint; var Epochs: Integer;
                    var LearningRate: Double; var Momentum: Double; var MaxNeurons: Smallint;
                    var ResetWeights: Smallint): Smallint; dispid 1610809383;
    function  Predict(var FileNameOrData: WideString; var DataOption: Smallint;
                      var LearningRate: Double; var Momentum: Double): Double; dispid 1610809384;
    function  BatchPredict(var FileNameOrData: WideString; var DataOption: Smallint;
                           var OutputFileName: WideString; var LearningRate: Double;
                           var Momentum: Double): Integer; dispid 1610809385;
    procedure saveNetwork(var FileName: WideString); dispid 1610809387;
    function  loadNetwork(var FileNameOrData: WideString; var DataOption: Smallint;
                          var NetFileName: WideString; var LearningRate: Double;
                          var Momentum: Double; var MaxNeurons: Smallint): Smallint; dispid 1610809388;
    function  getValue(var Row: Integer; var Col: Integer): Double; dispid 1610809395;
    function  getLastValue: Double; dispid 1610809396;
    function  About: OleVariant; dispid 1610809400;
  end;

// *********************************************************************//
// DispIntf:  __NN
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {EE26EA98-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  __NN = dispinterface
    ['{EE26EA98-9A02-11D5-AFF2-00E018023072}']
    procedure RMSError(var RMSError: Double); dispid 1;
    procedure Epoch(var Epoch: Integer); dispid 2;
  end;

// *********************************************************************//
// Interface: _GA
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA99-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _GA = interface(IDispatch)
    ['{EE26EA99-9A02-11D5-AFF2-00E018023072}']
    function  CreateGA(var NumParams: Smallint; var SearchSpace: Double; var Mutation: Double): OleVariant; safecall;
    function  releaseObjects: OleVariant; safecall;
    function  getChromosome: _Chromosome; safecall;
    function  About: OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  _GADisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA99-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _GADisp = dispinterface
    ['{EE26EA99-9A02-11D5-AFF2-00E018023072}']
    function  CreateGA(var NumParams: Smallint; var SearchSpace: Double; var Mutation: Double): OleVariant; dispid 1610809360;
    function  releaseObjects: OleVariant; dispid 1610809361;
    function  getChromosome: _Chromosome; dispid 1610809362;
    function  About: OleVariant; dispid 1610809366;
  end;

// *********************************************************************//
// DispIntf:  __GA
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {EE26EA9A-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  __GA = dispinterface
    ['{EE26EA9A-9A02-11D5-AFF2-00E018023072}']
  end;

// *********************************************************************//
// Interface: _FZ
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA9B-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _FZ = interface(IDispatch)
    ['{EE26EA9B-9A02-11D5-AFF2-00E018023072}']
    function  getValue(var Col1: Integer; var Col2: Integer): Double; safecall;
    function  Cancel: Integer; safecall;
    function  Analyze(var FileNameOrData: WideString; var DataOption: Smallint; var Cycles: Integer): Integer; safecall;
    function  About: OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  _FZDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA9B-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _FZDisp = dispinterface
    ['{EE26EA9B-9A02-11D5-AFF2-00E018023072}']
    function  getValue(var Col1: Integer; var Col2: Integer): Double; dispid 1610809357;
    function  Cancel: Integer; dispid 1610809358;
    function  Analyze(var FileNameOrData: WideString; var DataOption: Smallint; var Cycles: Integer): Integer; dispid 1610809359;
    function  About: OleVariant; dispid 1610809362;
  end;

// *********************************************************************//
// DispIntf:  __FZ
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {EE26EA9C-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  __FZ = dispinterface
    ['{EE26EA9C-9A02-11D5-AFF2-00E018023072}']
  end;

// *********************************************************************//
// Interface: _Chromosome
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA9D-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _Chromosome = interface(IDispatch)
    ['{EE26EA9D-9A02-11D5-AFF2-00E018023072}']
    function  getValue(var Index: Smallint): Double; safecall;
    function  setValue(var Index: Smallint; var Value: Double): OleVariant; safecall;
    procedure Set_ABSError(var Param1: Double); safecall;
    function  Get_ABSError: Double; safecall;
    function  createChromosome(var Length: Smallint): OleVariant; safecall;
    property ABSError: Double read Get_ABSError write Set_ABSError;
  end;

// *********************************************************************//
// DispIntf:  _ChromosomeDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA9D-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _ChromosomeDisp = dispinterface
    ['{EE26EA9D-9A02-11D5-AFF2-00E018023072}']
    function  getValue(var Index: Smallint): Double; dispid 1610809353;
    function  setValue(var Index: Smallint; var Value: Double): OleVariant; dispid 1610809354;
    property ABSError: Double dispid 1745027080;
    function  createChromosome(var Length: Smallint): OleVariant; dispid 1610809355;
  end;

// *********************************************************************//
// Interface: _FileReader
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA9E-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _FileReader = interface(IDispatch)
    ['{EE26EA9E-9A02-11D5-AFF2-00E018023072}']
    function  readString(var DataString: WideString; var Delimiter: WideString; 
                         var FirstRowNames: WordBool; var Qualifier: WideString; 
                         var StopRow: Integer): OleVariant; safecall;
    function  readFile(var FileName: WideString; var Delimiter: WideString; 
                       var FirstRowNames: WordBool; var Qualifier: WideString; var StopRow: Integer): OleVariant; safecall;
    function  getHeaderObject: OleVariant; safecall;
    procedure setData(var Key: OleVariant; var Row: Integer; var Value: OleVariant); safecall;
    function  GetData(var Key: OleVariant; var Row: Integer): OleVariant; safecall;
    procedure setColumnName(var Col: Smallint; var Value: OleVariant); safecall;
    function  getColumnName(var Col: Smallint): OleVariant; safecall;
    procedure setColumnInfo(var Col: Smallint; var Value: OleVariant); safecall;
    function  getColumnInfo(var Col: Smallint): OleVariant; safecall;
    function  Get_ColumnCount: Smallint; safecall;
    function  Get_RowCount: Integer; safecall;
    property ColumnCount: Smallint read Get_ColumnCount;
    property RowCount: Integer read Get_RowCount;
  end;

// *********************************************************************//
// DispIntf:  _FileReaderDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA9E-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _FileReaderDisp = dispinterface
    ['{EE26EA9E-9A02-11D5-AFF2-00E018023072}']
    function  readString(var DataString: WideString; var Delimiter: WideString; 
                         var FirstRowNames: WordBool; var Qualifier: WideString; 
                         var StopRow: Integer): OleVariant; dispid 1610809366;
    function  readFile(var FileName: WideString; var Delimiter: WideString; 
                       var FirstRowNames: WordBool; var Qualifier: WideString; var StopRow: Integer): OleVariant; dispid 1610809367;
    function  getHeaderObject: OleVariant; dispid 1610809368;
    procedure setData(var Key: OleVariant; var Row: Integer; var Value: OleVariant); dispid 1610809369;
    function  GetData(var Key: OleVariant; var Row: Integer): OleVariant; dispid 1610809370;
    procedure setColumnName(var Col: Smallint; var Value: OleVariant); dispid 1610809371;
    function  getColumnName(var Col: Smallint): OleVariant; dispid 1610809372;
    procedure setColumnInfo(var Col: Smallint; var Value: OleVariant); dispid 1610809373;
    function  getColumnInfo(var Col: Smallint): OleVariant; dispid 1610809374;
    property ColumnCount: Smallint readonly dispid 1745027093;
    property RowCount: Integer readonly dispid 1745027092;
  end;

// *********************************************************************//
// Interface: _HeaderInfo
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA9F-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _HeaderInfo = interface(IDispatch)
    ['{EE26EA9F-9A02-11D5-AFF2-00E018023072}']
    procedure setColumnCount(var Count: Smallint); safecall;
    function  setColumnName(var Column: Smallint; var Value: OleVariant): OleVariant; safecall;
    function  getColumnName(var Column: Smallint): OleVariant; safecall;
    function  setColumnInfo(var Column: Smallint; var Value: OleVariant): OleVariant; safecall;
    function  getColumnInfo(var Column: Smallint): OleVariant; safecall;
    function  Get_ColumnCount: Smallint; safecall;
    property ColumnCount: Smallint read Get_ColumnCount;
  end;

// *********************************************************************//
// DispIntf:  _HeaderInfoDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EA9F-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _HeaderInfoDisp = dispinterface
    ['{EE26EA9F-9A02-11D5-AFF2-00E018023072}']
    procedure setColumnCount(var Count: Smallint); dispid 1610809357;
    function  setColumnName(var Column: Smallint; var Value: OleVariant): OleVariant; dispid 1610809358;
    function  getColumnName(var Column: Smallint): OleVariant; dispid 1610809359;
    function  setColumnInfo(var Column: Smallint; var Value: OleVariant): OleVariant; dispid 1610809360;
    function  getColumnInfo(var Column: Smallint): OleVariant; dispid 1610809361;
    property ColumnCount: Smallint readonly dispid 1745027084;
  end;

// *********************************************************************//
// Interface: _Row
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EAA0-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _Row = interface(IDispatch)
    ['{EE26EAA0-9A02-11D5-AFF2-00E018023072}']
    procedure setColumnCount(var Count: Smallint); safecall;
    procedure setData(var Column: Smallint; var Value: OleVariant); safecall;
    function  GetData(var Column: Smallint): OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  _RowDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {EE26EAA0-9A02-11D5-AFF2-00E018023072}
// *********************************************************************//
  _RowDisp = dispinterface
    ['{EE26EAA0-9A02-11D5-AFF2-00E018023072}']
    procedure setColumnCount(var Count: Smallint); dispid 1610809350;
    procedure setData(var Column: Smallint; var Value: OleVariant); dispid 1610809351;
    function  GetData(var Column: Smallint): OleVariant; dispid 1610809352;
  end;

// *********************************************************************//
// The Class CoChromosome provides a Create and CreateRemote method to          
// create instances of the default interface _Chromosome exposed by              
// the CoClass Chromosome. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.
// *********************************************************************//
  CoChromosome = class
    class function Create: _Chromosome;
    class function CreateRemote(const MachineName: string): _Chromosome;
  end;

// *********************************************************************//
// The Class CoFileReader provides a Create and CreateRemote method to          
// create instances of the default interface _FileReader exposed by              
// the CoClass FileReader. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoFileReader = class
    class function Create: _FileReader;
    class function CreateRemote(const MachineName: string): _FileReader;
  end;

// *********************************************************************//
// The Class CoHeaderInfo provides a Create and CreateRemote method to          
// create instances of the default interface _HeaderInfo exposed by              
// the CoClass HeaderInfo. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoHeaderInfo = class
    class function Create: _HeaderInfo;
    class function CreateRemote(const MachineName: string): _HeaderInfo;
  end;

// *********************************************************************//
// The Class CoRow provides a Create and CreateRemote method to          
// create instances of the default interface _Row exposed by              
// the CoClass Row. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoRow = class
    class function Create: _Row;
    class function CreateRemote(const MachineName: string): _Row;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TNN
// Help String      :
// Default Interface: _NN
// Def. Intf. DISP? : No
// Event   Interface: __NN
// TypeFlags        : (32) Control
// *********************************************************************//
  TNNRMSError = procedure(Sender: TObject; var RMSError: Double) of object;
  TNNEpoch = procedure(Sender: TObject; var Epoch: Integer) of object;

  TNN = class(TOleControl)
  private
    FOnRMSError: TNNRMSError;
    FOnEpoch: TNNEpoch;
    FIntf: _NNDisp;
    function  GetControlInterface: _NNDisp;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function  Cancel: OleVariant;
    function  Train(var FileNameOrData: WideString; var DataOption: Smallint; var Epochs: Integer;
                    var LearningRate: Double; var Momentum: Double; var MaxNeurons: Smallint;
                    var ResetWeights: Smallint): Smallint;
    function  Predict(var FileNameOrData: WideString; var DataOption: Smallint;
                      var LearningRate: Double; var Momentum: Double): Double;
    function  BatchPredict(var FileNameOrData: WideString; var DataOption: Smallint;
                           var OutputFileName: WideString; var LearningRate: Double;
                           var Momentum: Double): Integer;
    procedure saveNetwork(var FileName: WideString);
    function  loadNetwork(var FileNameOrData: WideString; var DataOption: Smallint; 
                          var NetFileName: WideString; var LearningRate: Double; 
                          var Momentum: Double; var MaxNeurons: Smallint): Smallint;
    function  getValue(var Row: Integer; var Col: Integer): Double;
    function  getLastValue: Double;
    function  About: OleVariant;
    property  ControlInterface: _NNDisp read GetControlInterface;
    property  DefaultInterface: _NNDisp read GetControlInterface;
  published
    property RefreshRate: Integer index 1073938470 read GetIntegerProp write SetIntegerProp stored False;
    property OnRMSError: TNNRMSError read FOnRMSError write FOnRMSError;
    property OnEpoch: TNNEpoch read FOnEpoch write FOnEpoch;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TGA
// Help String      : 
// Default Interface: _GA
// Def. Intf. DISP? : No
// Event   Interface: __GA
// TypeFlags        : (32) Control
// *********************************************************************//
  TGA = class(TOleControl)
  private
    FIntf: _GADisp;
    function  GetControlInterface: _GADisp;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function  CreateGA(var NumParams: Smallint; var SearchSpace: Double; var Mutation: Double): OleVariant;
    function  releaseObjects: OleVariant;
    function  getChromosome: _Chromosome;
    function  About: OleVariant;
    property  ControlInterface: _GADisp read GetControlInterface;
    property  DefaultInterface: _GADisp read GetControlInterface;
  published
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TFZ
// Help String      :
// Default Interface: _FZ
// Def. Intf. DISP? : No
// Event   Interface: __FZ
// TypeFlags        : (32) Control
// *********************************************************************//
  TFZ = class(TOleControl)
  private
    FIntf: _FZDisp;
    function  GetControlInterface: _FZDisp;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
  public
    function  getValue(var Col1: Integer; var Col2: Integer): Double;
    function  Cancel: Integer;
    function  Analyze(var FileNameOrData: WideString; var DataOption: Smallint; var Cycles: Integer): Integer;
    function  About: OleVariant;
    property  ControlInterface: _FZDisp read GetControlInterface;
    property  DefaultInterface: _FZDisp read GetControlInterface;
  published
  end;

procedure Register;

implementation

uses ComObj;

class function CoChromosome.Create: _Chromosome;
begin
  Result := CreateComObject(CLASS_Chromosome) as _Chromosome;
end;

class function CoChromosome.CreateRemote(const MachineName: string): _Chromosome;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Chromosome) as _Chromosome;
end;

class function CoFileReader.Create: _FileReader;
begin
  Result := CreateComObject(CLASS_FileReader) as _FileReader;
end;

class function CoFileReader.CreateRemote(const MachineName: string): _FileReader;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FileReader) as _FileReader;
end;

class function CoHeaderInfo.Create: _HeaderInfo;
begin
  Result := CreateComObject(CLASS_HeaderInfo) as _HeaderInfo;
end;

class function CoHeaderInfo.CreateRemote(const MachineName: string): _HeaderInfo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HeaderInfo) as _HeaderInfo;
end;

class function CoRow.Create: _Row;
begin
  Result := CreateComObject(CLASS_Row) as _Row;
end;

class function CoRow.CreateRemote(const MachineName: string): _Row;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Row) as _Row;
end;

procedure TNN.InitControlData;
const
  CEventDispIDs: array [0..1] of DWORD = (
    $00000001, $00000002);
  CControlData: TControlData2 = (
    ClassID: '{71B532C7-96C7-11D5-AFEE-00E018023072}';
    EventIID: '{EE26EA98-9A02-11D5-AFF2-00E018023072}';
    EventCount: 2;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnRMSError) - Cardinal(Self);
end;

procedure TNN.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _NNDisp;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TNN.GetControlInterface: _NNDisp;
begin
  CreateControl;
  Result := FIntf;
end;

function  TNN.Cancel: OleVariant;
begin
  Result := DefaultInterface.Cancel;
end;

function  TNN.Train(var FileNameOrData: WideString; var DataOption: Smallint; var Epochs: Integer; 
                    var LearningRate: Double; var Momentum: Double; var MaxNeurons: Smallint; 
                    var ResetWeights: Smallint): Smallint;
begin
  Result := DefaultInterface.Train(FileNameOrData, DataOption, Epochs, LearningRate, Momentum, 
                                   MaxNeurons, ResetWeights);
end;

function  TNN.Predict(var FileNameOrData: WideString; var DataOption: Smallint; 
                      var LearningRate: Double; var Momentum: Double): Double;
begin
  Result := DefaultInterface.Predict(FileNameOrData, DataOption, LearningRate, Momentum);
end;

function  TNN.BatchPredict(var FileNameOrData: WideString; var DataOption: Smallint; 
                           var OutputFileName: WideString; var LearningRate: Double; 
                           var Momentum: Double): Integer;
begin
  Result := DefaultInterface.BatchPredict(FileNameOrData, DataOption, OutputFileName, LearningRate, 
                                          Momentum);
end;

procedure TNN.saveNetwork(var FileName: WideString);
begin
  DefaultInterface.saveNetwork(FileName);
end;

function  TNN.loadNetwork(var FileNameOrData: WideString; var DataOption: Smallint; 
                          var NetFileName: WideString; var LearningRate: Double; 
                          var Momentum: Double; var MaxNeurons: Smallint): Smallint;
begin
  Result := DefaultInterface.loadNetwork(FileNameOrData, DataOption, NetFileName, LearningRate, 
                                         Momentum, MaxNeurons);
end;

function  TNN.getValue(var Row: Integer; var Col: Integer): Double;
begin
  Result := DefaultInterface.getValue(Row, Col);
end;

function  TNN.getLastValue: Double;
begin
  Result := DefaultInterface.getLastValue;
end;

function  TNN.About: OleVariant;
begin
  Result := DefaultInterface.About;
end;

procedure TGA.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{71B532CC-96C7-11D5-AFEE-00E018023072}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TGA.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _GADisp;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TGA.GetControlInterface: _GADisp;
begin
  CreateControl;
  Result := FIntf;
end;

function  TGA.CreateGA(var NumParams: Smallint; var SearchSpace: Double; var Mutation: Double): OleVariant;
begin
  Result := DefaultInterface.CreateGA(NumParams, SearchSpace, Mutation);
end;

function  TGA.releaseObjects: OleVariant;
begin
  Result := DefaultInterface.releaseObjects;
end;

function  TGA.getChromosome: _Chromosome;
begin
  Result := DefaultInterface.getChromosome;
end;

function  TGA.About: OleVariant;
begin
  Result := DefaultInterface.About;
end;

procedure TFZ.InitControlData;
const
  CControlData: TControlData2 = (
    ClassID: '{71B532CF-96C7-11D5-AFEE-00E018023072}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil (*HR:$00000000*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TFZ.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as _FZDisp;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TFZ.GetControlInterface: _FZDisp;
begin
  CreateControl;
  Result := FIntf;
end;

function  TFZ.getValue(var Col1: Integer; var Col2: Integer): Double;
begin
  Result := DefaultInterface.getValue(Col1, Col2);
end;

function  TFZ.Cancel: Integer;
begin
  Result := DefaultInterface.Cancel;
end;

function  TFZ.Analyze(var FileNameOrData: WideString; var DataOption: Smallint; var Cycles: Integer): Integer;
begin
  Result := DefaultInterface.Analyze(FileNameOrData, DataOption, Cycles);
end;

function  TFZ.About: OleVariant;
begin
  Result := DefaultInterface.About;
end;

procedure Register;
begin
  RegisterComponents('ActiveX',[TNN, TGA, TFZ]);
end;

end.
