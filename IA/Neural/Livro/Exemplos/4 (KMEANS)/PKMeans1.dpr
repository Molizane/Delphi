program PKMeans1;

uses
  Forms,
  UKMeans1 in 'UKMeans1.pas' {Clustering};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TClustering, Clustering);
  Application.Run;
end.

