unit UFZ;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, OleCtrls, CobaltSDK_TLB;

type
  TfrmFZ = class(TForm)
    btnAnalyze: TButton;
    btnCancel: TButton;
    lblCancel: TLabel;
    lblFZ: TLabel;
    OD1: TOpenDialog;
    memFZ: TMemo;
    FZ1: TFZ;
    procedure btnAnalyzeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFZ: TfrmFZ;

implementation

{$R *.DFM}

procedure TfrmFZ.btnAnalyzeClick(Sender: TObject);
    var FileName : wideString;
    DataOption:smallint;
    cycles:integer;
    col1,col2,col3,col4:integer;
begin


    btnCancel.Enabled := true;
    lblCancel.Caption := '';

    //Get a filename
    OD1.Filter := 'CSV Files|*.csv;*.txt';
    if OD1.Execute then
    begin
      FileName := OD1.FileName;
      If ExtractFilePath(FileName) = '' Then
      begin
        ShowMessage('Please locate the Fuzzy PCA.txt file');
        abort;
      End;
      lblFZ.Caption := ExtractFileName(OD1.FileName);
      Cycles:=10;
      //FileNameOrData argument is a file name      
      DataOption:=1;
      FZ1.Analyze(FileName,DataOption,Cycles); //Analyze the file

    end;
    col1:=1;
    col2:=2;
    col3:=3;
    col4:=4;
    //Clear memo
    memFZ.Clear;

    //Display each of the component relationships
    memFZ.Lines.Add('Columns 1 and 2: ' + Floattostr(FZ1.getValue(col1, col2)));
    memFZ.Lines.Add('Columns 1 and 3: ' + Floattostr(FZ1.getValue(col1, col3)));
    memFZ.Lines.Add('Columns 1 and 4: ' + Floattostr(FZ1.getValue(col1, col4)));
    memFZ.Lines.Add('Columns 2 and 3: ' + Floattostr(FZ1.getValue(col2, col3)));
    memFZ.Lines.Add('Columns 2 and 4: ' + Floattostr(FZ1.getValue(col2, col4)));
    memFZ.Lines.Add('Columns 3 and 4: ' + Floattostr(FZ1.getValue(col3, col4)));

    btnCancel.Enabled := False;
end;

procedure TfrmFZ.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        frmFZ:=nil;
        Action:=caFree;
end;

end.
