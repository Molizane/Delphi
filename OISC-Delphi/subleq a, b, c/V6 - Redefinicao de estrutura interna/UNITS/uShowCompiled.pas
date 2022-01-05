unit uShowCompiled;

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, DB, Buttons,
  ExtCtrls, Grids, DBGrids, ComCtrls, StdCtrls, kbmMemTable;

type

  { TFrmShowCompiled }

  TFrmShowCompiled = class(TForm)
    dsTblProgr: TDataSource;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    Panel4: TPanel;
    PageControl1: TPageControl;
    tsCode: TTabSheet;
    tsLabels: TTabSheet;
    DBGrid1: TDBGrid;
    dsTblLabels: TDataSource;
    DBGrid2: TDBGrid;
    Panel5: TPanel;
    tsErrors: TTabSheet;
    DBGrid3: TDBGrid;
    Panel3: TPanel;
    dsTblErrors: TDataSource;
    btnExport: TBitBtn;
    SaveTxt: TSaveDialog;
    SaveCVS: TSaveDialog;
    tblProgr: TkbmMemTable;
    tblProgrAddress: TStringField;
    tblProgrLabel: TStringField;
    tblProgrOperator: TStringField;
    tblProgrA: TStringField;
    tblProgrB: TStringField;
    tblProgrC: TStringField;
    tblProgrObs: TStringField;
    tblProgrError: TBooleanField;
    tblLabels: TkbmMemTable;
    tblLabelsName: TStringField;
    tblLabelsContent: TStringField;
    tblLabelsLine: TIntegerField;
    tblLabelsValidNumber: TBooleanField;
    tblLabelsIsLabel: TBooleanField;
    tblErrors: TkbmMemTable;
    tblErrorsLine: TIntegerField;
    tblErrorsSeq: TIntegerField;
    tblErrorsError: TStringField;
    tblProgrLine: TIntegerField;
    tblProgrIsRelative: TBooleanField;
    tblProgrAbsolute: TStringField;
    tblLabelsAbsolute: TStringField;
    tblLabelsRelative: TIntegerField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
  private
    procedure ExportTxt;
    procedure ExportCVS;
  public
  end;

var
  FrmShowCompiled: TFrmShowCompiled;

implementation

uses
  StrUtils, uOiscSubleq;

{$R *.dfm}

procedure TFrmShowCompiled.FormShow(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TFrmShowCompiled.FormCreate(Sender: TObject);
begin
  tblProgr.Open;
  tblLabels.Open;
  tblErrors.Open;
end;

procedure TFrmShowCompiled.btnExportClick(Sender: TObject);
begin
  ExportTxt;
  ExportCVS;
end;

procedure TFrmShowCompiled.ExportTxt;
var
  Arq: TextFile;
  bm, str: string;
  i: integer;
begin
  if tblProgr.RecordCount = 0 then
    Exit;

  if SaveTxt.Execute then
  begin
    i := 0;

    AssignFile(Arq, SaveTxt.FileName);
    Rewrite(Arq);

    try
      tblProgr.DisableControls;

      try
        bm := tblProgr.Bookmark;

        try
          tblProgr.First;

          while not tblProgr.EOF do
          begin
            Write(Arq, RightStr('      ' + IntToStr(tblProgrLine.AsInteger), 6));

            if tblProgrError.AsBoolean then
              Write(Arq, ' *')
            else
              Write(Arq, '  ');

            str := tblProgrOperator.AsString;

            if (tblProgrLabel.AsString <> '') or ((str <> '') and not SameText(str, 'DC')) then
            begin
              str := tblProgrAddress.AsString;

              while Length(str) < 20 do
                str := Str + ' ';

              Write(Arq, str);

              str := tblProgrOperator.AsString;

              if SameText(str, '@REL') or SameText(str, 'ORG') or SameText(str, 'DS') then
                str := ''
              else
                str := tblProgrA.AsString;

              while Length(str) < 11 do
                str := Str + ' ';

              Write(Arq, str);

              str := tblProgrB.AsString;

              while Length(str) < 11 do
                str := Str + ' ';

              Write(Arq, str);

              str := tblProgrC.AsString;

              while Length(str) < 10 do
                str := Str + ' ';
            end
            else
            begin
              str := '';

              while Length(str) < 52 do
                str := Str + ' ';
            end;

            Write(Arq, str);

            WriteLn(Arq, '| ', AsmOISCKernel.Source[i]);

            Inc(i);

            tblProgr.Next;
          end;
        finally
          tblProgr.Bookmark := bm;
        end;
      finally
        tblProgr.EnableControls;
      end;
    finally
      CloseFile(Arq);
    end;
  end;
end;

procedure TFrmShowCompiled.ExportCVS;
var
  Arq: TextFile;
  bm, str: string;
  i: integer;
begin
  if tblProgr.RecordCount = 0 then
    Exit;

  if SaveCVS.Execute then
  begin
    i := 0;

    AssignFile(Arq, SaveCVS.FileName);
    Rewrite(Arq);

    try
      tblProgr.DisableControls;

      try
        bm := tblProgr.Bookmark;

        try
          tblProgr.First;

          WriteLn(Arq, 'Line'#9'Error?'#9'Address'#9'A'#9'B'#9'C'#9'Source');

          while not tblProgr.EOF do
          begin
            Write(Arq, tblProgrLine.AsInteger, #9);

            if tblProgrError.AsBoolean then
              Write(Arq, '*'#9)
            else
              Write(Arq, #9);

            str := tblProgrOperator.AsString;

            if (tblProgrLabel.AsString <> '') or ((str <> '') and not SameText(str, 'DC')) then
            begin
              Write(Arq, tblProgrAddress.AsString + #9);

              str := tblProgrOperator.AsString;

              if SameText(str, '@REL') or SameText(str, 'ORG') or SameText(str, 'DS') then
                str := ''
              else
                str := tblProgrA.AsString;

              Write(Arq, str + #9);

              Write(Arq, tblProgrB.AsString + #9);

              str := tblProgrC.AsString;
            end
            else
              str := #9#9#9;

            Write(Arq, str + #9);

            WriteLn(Arq, AsmOISCKernel.Source[i]);

            Inc(i);

            tblProgr.Next;
          end;
        finally
          tblProgr.Bookmark := bm;
        end;
      finally
        tblProgr.EnableControls;
      end;
    finally
      CloseFile(Arq);
    end;
  end;
end;

end.
