unit uShowCompiled;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, kbmMemTable, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  ComCtrls;

type
  TFrmShowCompiled = class(TForm)
    tblProgr: TkbmMemTable;
    tblProgrAddress: TIntegerField;
    tblProgrLabel: TStringField;
    tblProgrOperator: TStringField;
    tblProgrA: TStringField;
    tblProgrB: TStringField;
    tblProgrC: TStringField;
    tblProgrObs: TStringField;
    dsTblProgr: TDataSource;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Panel4: TPanel;
    PageControl1: TPageControl;
    tsCode: TTabSheet;
    tsLabels: TTabSheet;
    DBGrid1: TDBGrid;
    tblLabels: TkbmMemTable;
    tblLabelsName: TStringField;
    tblLabelsContent: TStringField;
    tblLabelsLine: TIntegerField;
    tblLabelsValidNumber: TBooleanField;
    tblLabelsIsLabel: TBooleanField;
    dsTblLabels: TDataSource;
    DBGrid2: TDBGrid;
    Panel5: TPanel;
    tsErrors: TTabSheet;
    DBGrid3: TDBGrid;
    Panel3: TPanel;
    tblErrors: TkbmMemTable;
    tblErrorsLine: TIntegerField;
    tblErrorsSeq: TIntegerField;
    tblErrorsError: TStringField;
    dsTblErrors: TDataSource;
    tblProgrError: TBooleanField;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  FrmShowCompiled: TFrmShowCompiled;

implementation

{$R *.dfm}

procedure TFrmShowCompiled.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

end.

