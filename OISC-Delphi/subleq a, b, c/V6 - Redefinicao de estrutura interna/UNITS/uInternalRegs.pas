unit uInternalRegs;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Buttons;

type

  { TFrmInternalRegs }

  TFrmInternalRegs = class(TForm)
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblAddHALT: TLabel;
    lblCS_End: TLabel;
    lblCS_Start: TLabel;
    lblDS_End: TLabel;
    lblDS_Start: TLabel;
    lblError_Code: TLabel;
    lblError_Hndr: TLabel;
    lblError_Line: TLabel;
    lblHaltSig: TLabel;
    lblHardIRQ_In0: TLabel;
    lblHardIRQ_In1: TLabel;
    lblHardIRQ_In2: TLabel;
    lblHardIRQ_In3: TLabel;
    lblHardIRQ_In4: TLabel;
    lblHardIRQ_In5: TLabel;
    lblHardIRQ_In6: TLabel;
    lblHardIRQ_In7: TLabel;
    lblHardIRQ_Out0: TLabel;
    lblHardIRQ_Out1: TLabel;
    lblHardIRQ_Out2: TLabel;
    lblHardIRQ_Out3: TLabel;
    lblHardIRQ_Out4: TLabel;
    lblHardIRQ_Out5: TLabel;
    lblHardIRQ_Out6: TLabel;
    lblHardIRQ_Out7: TLabel;
    lblHard_IRQ: TLabel;
    lblIRQ_En: TLabel;
    lblMemTop: TLabel;
    lblNum_IRQ: TLabel;
    lblPar0_IRQ: TLabel;
    lblPar1_IRQ: TLabel;
    lblPar2_IRQ: TLabel;
    lblpc: TLabel;
    lblProtected: TLabel;
    lblSoftIRQ_In0: TLabel;
    lblSoftIRQ_In1: TLabel;
    lblSoftIRQ_In2: TLabel;
    lblSoftIRQ_In3: TLabel;
    lblSoftIRQ_In4: TLabel;
    lblSoftIRQ_In5: TLabel;
    lblSoftIRQ_In6: TLabel;
    lblSoftIRQ_In7: TLabel;
    lblSoftIRQ_Out0: TLabel;
    lblSoftIRQ_Out1: TLabel;
    lblSoftIRQ_Out2: TLabel;
    lblSoftIRQ_Out3: TLabel;
    lblSoftIRQ_Out4: TLabel;
    lblSoftIRQ_Out5: TLabel;
    lblSoftIRQ_Out6: TLabel;
    lblSoftIRQ_Out7: TLabel;
    lblSoft_IRQ: TLabel;
    PageControl1: TPageControl;
    btnRefresh: TSpeedButton;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnRefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
  public
  end;

var
  FrmInternalRegs: TFrmInternalRegs;

implementation

uses uOiscSubleq;

{$R *.dfm}

{ TFrmInternalRegs }

procedure TFrmInternalRegs.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;

  lblPC.Caption := '';
  lblError_Line.Caption := '';
  lblError_Code.Caption := '';
  lblError_Hndr.Caption := '';
  lblPar0_IRQ.Caption := '';
  lblPar1_IRQ.Caption := '';
  lblPar2_IRQ.Caption := '';
  lblNum_IRQ.Caption := '';
  lblHaltSig.Caption := '';
  lblAddHALT.Caption := '';
  lblIRQ_En.Caption := '';
  lblHard_IRQ.Caption := '';
  lblSoft_IRQ.Caption := '';
  lblMemTop.Caption := '';
  lblProtected.Caption := '';
  lblCS_Start.Caption := '';
  lblCS_End.Caption := '';
  lblDS_Start.Caption := '';
  lblDS_End.Caption := '';

  lblHardIRQ_In0.Caption := '';
  lblHardIRQ_In1.Caption := '';
  lblHardIRQ_In2.Caption := '';
  lblHardIRQ_In3.Caption := '';
  lblHardIRQ_In4.Caption := '';
  lblHardIRQ_In5.Caption := '';
  lblHardIRQ_In6.Caption := '';
  lblHardIRQ_In7.Caption := '';
  lblHardIRQ_Out0.Caption := '';
  lblHardIRQ_Out1.Caption := '';
  lblHardIRQ_Out2.Caption := '';
  lblHardIRQ_Out3.Caption := '';
  lblHardIRQ_Out4.Caption := '';
  lblHardIRQ_Out5.Caption := '';
  lblHardIRQ_Out6.Caption := '';
  lblHardIRQ_Out7.Caption := '';
  lblSoftIRQ_In0.Caption := '';
  lblSoftIRQ_In1.Caption := '';
  lblSoftIRQ_In2.Caption := '';
  lblSoftIRQ_In3.Caption := '';
  lblSoftIRQ_In4.Caption := '';
  lblSoftIRQ_In5.Caption := '';
  lblSoftIRQ_In6.Caption := '';
  lblSoftIRQ_In7.Caption := '';
  lblSoftIRQ_Out0.Caption := '';
  lblSoftIRQ_Out1.Caption := '';
  lblSoftIRQ_Out2.Caption := '';
  lblSoftIRQ_Out3.Caption := '';
  lblSoftIRQ_Out4.Caption := '';
  lblSoftIRQ_Out5.Caption := '';
  lblSoftIRQ_Out6.Caption := '';
  lblSoftIRQ_Out7.Caption := '';
end;

procedure TFrmInternalRegs.btnRefreshClick(Sender: TObject);
begin
  with FrmOISCSubleq do
  begin
    lblHardIRQ_In0.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[16], 8);
    lblHardIRQ_In1.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[17], 8);
    lblHardIRQ_In2.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[18], 8);
    lblHardIRQ_In3.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[19], 8);
    lblHardIRQ_In4.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[20], 8);
    lblHardIRQ_In5.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[21], 8);
    lblHardIRQ_In6.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[22], 8);
    lblHardIRQ_In7.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[23], 8);

    lblHardIRQ_Out0.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[24], 8);
    lblHardIRQ_Out1.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[25], 8);
    lblHardIRQ_Out2.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[26], 8);
    lblHardIRQ_Out3.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[27], 8);
    lblHardIRQ_Out4.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[28], 8);
    lblHardIRQ_Out5.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[29], 8);
    lblHardIRQ_Out6.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[30], 8);
    lblHardIRQ_Out7.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[31], 8);

    lblSoftIRQ_In0.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[32], 8);
    lblSoftIRQ_In1.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[33], 8);
    lblSoftIRQ_In2.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[34], 8);
    lblSoftIRQ_In3.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[35], 8);
    lblSoftIRQ_In4.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[36], 8);
    lblSoftIRQ_In5.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[37], 8);
    lblSoftIRQ_In6.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[38], 8);
    lblSoftIRQ_In7.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[39], 8);

    lblSoftIRQ_Out0.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[40], 8);
    lblSoftIRQ_Out1.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[41], 8);
    lblSoftIRQ_Out2.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[42], 8);
    lblSoftIRQ_Out3.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[43], 8);
    lblSoftIRQ_Out4.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[44], 8);
    lblSoftIRQ_Out5.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[45], 8);
    lblSoftIRQ_Out6.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[46], 8);
    lblSoftIRQ_Out7.Caption := '$' + IntToHex(ThreadOisc.Memory.AsLong[47], 8);
  end;
end;

procedure TFrmInternalRegs.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 1 then
    btnRefresh.Click;
end;


end.
