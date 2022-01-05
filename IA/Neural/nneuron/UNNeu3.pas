unit UNNeu3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, UFGraf, UFrRegua;

type
  TForm1 = class(TForm)
    BBStart: TBitBtn;
    FGraPot: TFGra;
    GauFre: TFrRegua;
    GauInt: TFrRegua;
    GauDt: TFrRegua;
    FGraDisp: TFGra;
    FGraPotDisp: TFGra;
    Bevel1: TBevel;
    Label2: TLabel;
    Label1: TLabel;
    GauIniFre: TFrRegua;
    GauIniInt: TFrRegua;
    CBSempre: TCheckBox;
    procedure BBStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.BBStartClick(Sender: TObject);
// Formulas:
// CV = Q =>  V=Q/C
// Potenciais de Equilibrio:
const
PEqNa = 55;
PEqK = -75;
PEqCl = -69;
CC = 1; //Capacitancia do capacitor
CCPotDisp = 0.90;  { constante de correcao do potencial ate disparo }
PotDisparoRepouso = 1; { potencial (modelado) de disparo do neuronio carregado }

// Condutancias:
gNa = 1;   //
gK = 20;   // tipicamente 20XgNa
gCl =5;    // 1/4 ate 1/2 de gk
Limiar = -35;
C1 = gNa+gK+gCl;
C2 = PEqNa*gNa + PEqK*gK + PEqCl*gCl;
C3:Single = C2 / C1;

// correntes
var Q,dQ:single; // carga, variacao da carga
    V,dV:single; // potencial e variacao do potencial do capacitor
    dt:single; // variacao (passagem) do tempo
    Counter:longint;
    Disparou,posDisparo:boolean;
    PotDisparo: Single; { forca do disparo }
    Saida:Single; { potencial no axonio durante disparo }
    I,E:Single;
begin
repeat
Disparou:=false;
FGraPot.Clear;
FGraPot.DefineMinMax(PEqK,PEqNa);
FGraDisp.Clear;
FGraPotDisp.Clear;

dt:=1/GauDt.TBRegua.Position;
PotDisparo:=1;
Q:=-20;
V:=Q/CC;
Writeln(C3:10:5);
for Counter:=1 to FGraPot.Img.Width do
    begin
(*  dqNa:=(PEqNa-V)*gNa*dt;
    dqK:=(PEqK-V)*gK*dt;
    dqCl:=(PEqCl-V)*gCl*dt;
dq = (PEqNa-V)*gNa*dt + (PEqK-V)*gK*dt + (PEqCl-V)*gCl*dt =
= ( (PEqNa-V)*gNa + (PEqK-V)*gK + (PEqCl-V)*gCl )* dt =
= (  -V*(gNa+gK+gCl) + PEqNa*gNa + PEqK*gk + PEqCl*gCl) * dt =>
C1 = gNa+gK+gCl
C2 = PEqNa*gNa + PEqK*gk + PEqCl*gCl  =>
dQ = (C2-V*C1)*dt;
C3 = C2 / C1;
dQ/C1 = (C2/C1-V*C1/C1)*dt = (C3 - V)*dt;
*)
    PosDisparo:=Disparou;
    dQ := (C3-V)*dt;
    dV:=dQ/CC;
    PotDisparo:=PotDisparo+(PotDisparoRepouso-PotDisparo)*CCPotDisp*dt;
    if PosDisparo
       then begin
            V:=(PEqK);
            dv:=0;
            end;
   Disparou:=(V > Limiar);
    if Disparou
       then begin
            V:=55;
            Saida:=PotDisparo;
            PotDisparo:=0;
            end
       else begin
            Saida:=0;
            V:=V+dV;
            end;
   I:=0;
   E:=0;

(*    if random(100)<GauFre.TBRegua.Position  // Excitatorio ?
       then V:=(V*100 + GauInt.TBRegua.Position*PEqNa)/(100+GauInt.TBRegua.Position); *)
    if not (PosDisparo or Disparou)
       then begin
            if random(100)<GauFre.TBRegua.Position  // Excitatorio ?
               then E:=GauInt.TBRegua.Position/100;

            if random(100)<GauIniFre.TBRegua.Position  // Inibitorio ?
               then I:=GauIniInt.TBRegua.Position/100;
            V:=(V + E*PEqNa + I*PEqCl)/(1+E+I);
            end;
    writeln(V:10:5);
    FGraPot.PutMM(V);
    FGraDisp.Put(Saida);
    FGraPotDisp.Put(PotDisparo);
    Application.ProcessMessages;
    end;


until not (CBSempre.Checked);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
GauFre.Caption:='Freqüência';
GauInt.Caption:='Intensidade';
GauDt.Caption:='1/dt';

GauIniFre.Caption:='Freqüência';
GauIniInt.Caption:='Intensidade';

end;

end.
