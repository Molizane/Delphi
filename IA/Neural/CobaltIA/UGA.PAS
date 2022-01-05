unit UGA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, OleCtrls,Math, CobaltSDK_TLB,Activex;

type
  TfrmGA = class(TForm)
    btnRun: TButton;
    btnCancel: TButton;
    lblCancel: TLabel;
    lblErr: TLabel;
    imgErr: TImage;
    GA1: TGA;

    procedure btnCancelClick(Sender: TObject);
    procedure btnRunClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Graph : Tpoint;
    Cancelled: Boolean;
    Chromosome : Chromosome;
    Procedure Evaluate;
    Procedure Showerror (Error : Double);
  public
    { Public declarations }
  end;

var
  frmGA: TfrmGA;
implementation

{$R *.DFM}

procedure TfrmGA.btnCancelClick(Sender: TObject);
begin
    Cancelled := True;
end;

procedure TfrmGA.btnRunClick(Sender: TObject);
var var1:Smallint;
var2,var3: double;
a:olevariant;
begin
    btnCancel.Enabled := True;
    lblCancel.Caption := '';

    //Clear the graph
    Graph.X := 0;
    //Clear the graph
    imgErr.Canvas.Brush.Color:=clBtnFace;
    imgErr.Canvas.Fillrect(imgErr.ClientRect);
    Graph.X := 0;
    Graph.Y := 0;
    //set initial point
    imgErr.Canvas.MoveTo(Graph.x,Graph.Y);
    //set pen color
    imgErr.canvas.Pen.Color:=clblue;

    var1:=5;
    var2:=1.0;
    var3:=0.5;
    a:=GA1.CreateGA(var1,var2,var3);   //Create a new genetic algorithm with 5 inputs

    //Loop until the error is at a satisfactory level
    Chromosome := CoChromosome.Create;
    Chromosome.CreateChromosome(var1);
    repeat
        Chromosome:=GA1.GetChromosome; //Get a chromosome
        Evaluate; //Evaluate the chromosome
        Application.ProcessMessages; //Yield to operating system
        ShowError(Chromosome.ABSError); //Show the error
        If Cancelled = True Then
        begin
            lblCancel.Caption := 'Genetic algorithm canceled';
            Cancelled := False;
            Break;
        End;
    until Chromosome.ABSError < 0.01;

    GA1.ReleaseObjects; //Unload chromosomes

    If Not Cancelled Then lblErr.Caption := 'Solved!';
    btnCancel.Enabled := False;
end;


Procedure TfrmGA.Evaluate;
var
    X: array[1..5] of Double;
    Sum,y: Double;
    n,i:smallint;
begin

    //This function evaluates chromosome fittness for the Sphere Model

    //Minimize
    //f(X) = Sum((X(i) - 1) ^ 2)
    //-5 <= x(i) <= 5
    //Global minimum
    //f(X) = 0
    //x(i) = 1.0, i=1:n


    For n:= 1 To 5 do
    begin
        i:=n;
        try
        y:=Chromosome.getValue(i);
        except
         y:=0;
        end;
        X[n] :=y;
    end;
    Sum:=0;
    For n := 1 To 5 do
        Sum := Sum + Power((X[n] - 1),2);

    Chromosome.ABSError := Sum;
end;

procedure TfrmGA.Showerror(Error: Double);
var ErrorInt:Integer;
begin
    //Display the error
    Graph.X := Graph.X + 1;
    ErrorInt:=Round(Error * 20);
    Graph.Y := imgErr.Height - ErrorInt - 10;
    imgErr.Canvas.LineTo (Graph.X, Graph.Y);
    imgErr.Canvas.MoveTo(Graph.x,Graph.Y);
    lblErr.Caption := floattostr(Error);
end;

procedure TfrmGA.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        frmGa:=nil;
        Action:=caFree;
end;

end.
