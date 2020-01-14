unit uDefs;

interface

uses
  Windows, Menus;

const
  tpCadTipos = 1;
  tpCadCategorias = 2;
  tpCadEditoras = 3;
  tpCadPublicacoes = 4;
  tpCadEdicoes = 5;
  tpCadConteudo = 6;

procedure SetMenuItemRight(AMenuItem: TMenuItem);

implementation

procedure SetMenuItemRight(AMenuItem: TMenuItem);
var
  ItemInfo: TMenuItemInfo;
  Buffer: array[0..80] of Char;
begin
  ItemInfo.cbSize := SizeOf(TMenuItemInfo);
  ItemInfo.fMask := MIIM_TYPE;
  ItemInfo.dwTypeData := Buffer;
  ItemInfo.cch := SizeOf(Buffer);

  with AMenuItem do
  begin
    GetMenuItemInfo(GetParentMenu.Handle, Command, False, ItemInfo);
    ItemInfo.fType := ItemInfo.fType or MFT_RIGHTJUSTIFY;
    SetMenuItemInfo(GetParentMenu.Handle, Command, False, ItemInfo);
  end;
end;

end.

