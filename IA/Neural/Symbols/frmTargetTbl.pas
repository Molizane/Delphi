unit frmTargetTbl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ExtCtrls, NetObj;

type
  TTargetForm = class(TForm)
    Bevel3: TBevel;
    TargetGrid: TStringGrid;
    Button1: TButton;
    Button2: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TargetForm: TTargetForm;

procedure EditTargetTable(var Targets:TTargets);

implementation

{$R *.DFM}

procedure EditTargetTable(var Targets:TTargets);
var I:integer;
begin
 With TargetForm.TargetGrid, Targets do
  begin
   for I:=1 to Count do
    begin
     Cells[0,I-1]:=IntToStr(I);
     Cells[1,I-1]:=Table[I].Name;
    end;
   if TargetForm.ShowModal=mrOK then
    begin
     Count:=0;
     for I:=0 to RowCount-1 do
      if Cells[1,I]<>'' then
       begin
        Table[I+1].Name:=Cells[1,I];
        Inc(Count);
       end;
     for I:=1 to Count do Table[I].Vector[I]:=1.0;
    end;
  end;
end;

end.
