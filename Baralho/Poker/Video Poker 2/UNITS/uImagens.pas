unit uImagens;

interface

uses
  SysUtils, Classes, ImgList, Controls;

type
  TDMImagens = class(TDataModule)
    imgCards: TImageList;
    imgDecks: TImageList;
  private
  public
  end;

var
  DMImagens: TDMImagens;

implementation

{$R *.dfm}

end.
