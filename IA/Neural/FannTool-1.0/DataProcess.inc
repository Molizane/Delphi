
function GetnItem(FileName: string): Integer;

type
  TDataItem = class
    public
        nhist: Integer;
        scale: Boolean;
        constructor Create;
        function GetData(i: Longword): Double ;
        procedure   SetData(i :Longword; value: Double);
        procedure   Add(value: Double);
        // procedure DeleteData(i :Longword);
        function *Histogram(n: Integer=10);
        procedure Scale(iminv, imaxv : Double);
        procedure Scale;
        procedure Swap(i1, i2 :Longword);
        function GetMin: Double;
        procedure SetMin(value: Double);
        functrion GetMinV: Double;
        procedure SetMinV( value: Double);
        function GetMax: Double;
        procedure SetMax(value: Double);
        function GetMaxV: Double;
        procedure SetMaxV( value: Double);
        function GetAvg: Double;
        destructor Destroy; virtual;
    protected
       min      : Double ;
       max      : Double ;
       minv     : Double ;
       maxv     : Double ;
       sum      : Double ;
       hist[20] : Double ;
       avg      : Double ;
       stddev   : Double ;
      data::array of Double;
    private
end;


// typedef pDataItem TDataItem*;

TDataProcess = class
    public
       cinstructor Create;
       function LoadRawData(char * filename)                              : Boolean;
       function ParseData                                                 : Boolean;
       function WriteData(char *FileName,: Integer; nOut, float pTrain)   : Boolean;
       function WriteScaleParameters(char *FileName)                      : Boolean;
       function *GetItem(: Integer; i): TDataItem;
       function GetNData :Longword
       begin
           return nData;
       end;
       function GetNItem:Longword;
       begin
         return nItem;
       end;
       procedure ScaleAll;
       procedure Shuffle;
       destructor Destroy;
    protected
        vector<: Double> line_data;
        function ReadLine(string line): Integer;
        items: array of DataItem;
         nItem:Longword;
        nData:Longword ;
    private
end;


// Time Series Reader

class TimeSeri :
public DataItem
    public
        TimeSeri;
        : Boolean; shuffle;
        : Boolean; LoadRawData(char *file);
        : Boolean; WriteData(char *file,float pTrain);
        : Boolean; WriteScaleParameters(char *FileName);
        :Longword GetNDatabegin
           return (count-nInput-nOutput);
        end;
        virtual ~TimeSeri;

//    protected
        long count;
        : Integer; nInput;
        : Integer; nOutput;
    private
end;


#endif // DATAPROCESS_H
