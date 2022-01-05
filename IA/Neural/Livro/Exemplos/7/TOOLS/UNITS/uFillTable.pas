unit uFillTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBTables, Grids, DBGrids, DB;

type
  TForm1 = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Query1: TQuery;
    ListBox1: TListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i: Integer;
begin
  Button1.Enabled := False;

  try
    Query1.SQL.Text := 'DELETE FROM VALE5';
    Query1.ExecSQL;

    for I := 0 to ListBox1.Items.Count - 1 do
    begin
      if Trim(ListBox1.Items[i]) <> '' then
      begin
        Query1.SQL.Text := ListBox1.Items[i];
        Query1.ExecSQL;
      end;

      if i mod 20 = 0 then
      begin
        Table1.Refresh;
        Table1.Last;
        Application.ProcessMessages;
      end;
    end;
  finally
    Table1.First;
    Button1.Enabled := True;
  end;
end;

end.

