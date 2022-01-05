unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    MainMenu1: TMainMenu;
    Game1: TMenuItem;
    New1: TMenuItem;
    Exit1: TMenuItem;
    Label5: TLabel;
    Button2: TButton;
    Image7: TImage;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Timer1: TTimer;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Info2: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure kleur;
    procedure kaart;
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Info2Click(Sender: TObject);
  private
  public
    bew, wons, credits, game, beurt, score1comp, score, reken: integer;
    bewaar: string;
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

uses
  Unit2;

procedure TForm1.kleur;
var
  i, x: integer;
  kleur1, kleur: string;
label
  1, 2;
begin
  if (beurt = 1) and (game = 1) then
  begin
    {kleur van de kaarten toekennen}
    1: if (score > 21) and (game = 1) and (beurt = 1) and (credits > 0) then
    begin
      {dood kaart show}
      label7.caption := 'Dood';
      label1.hide;
      label2.hide;
      label3.hide;
      image1.Picture.LoadFromFile('dood.bmp');
    end
    else
    begin
      if (game = 1) and (beurt = 1) then
      begin
        Randomize;
        //i := random(x);
        i := random(99) + 1;
        kleur := intToStr(i);
        kleur1 := kleur[1];
      end;

      if (kleur1 = '1') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.font.color := clRed;
        label2.font.color := clRed;
        label3.font.color := clRed;
        image1.Picture.LoadFromFile('harten.bmp');
      end
      else if (kleur1 = '2') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.font.color := clRed;
        label2.font.color := clRed;
        label3.font.color := clRed;
        image1.Picture.LoadFromFile('ruiten.bmp');
      end
      else if (kleur1 = '3') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.font.color := clBlack;
        label2.font.color := clBlack;
        label3.font.color := clBlack;
        image1.Picture.LoadFromFile('klaver.bmp');
      end
      else if (kleur1 = '4') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.font.color := clBlack;
        label2.font.color := clBlack;
        label3.font.color := clBlack;
        image1.Picture.LoadFromFile('schoppen.bmp');
      end
      else
        goto 1; {om ervoor te zorgen dat bij groter dan 4 opnieuw een waarde te geven}
    end
  end
  else
    if (game = 1) and (beurt = 2) then
    begin
      if (score1comp > 21) and (game = 1) and (beurt = 2) then
      begin
        {dood kaart show}
        label6.caption := 'Dood';
        label12.hide;
        label13.hide;
        label14.hide;
        image7.Picture.LoadFromFile('dood.bmp');
      end
      else
      begin
        2: Randomize;
        //i := random(x);
        i := random(99) + 1;
        kleur := intToStr(i);
        kleur1 := kleur[1];

        if (kleur1 = '1') and (game = 1) and (beurt = 2) then
        begin
          label12.font.color := clRed;
          label13.font.color := clRed;
          label14.font.color := clRed;
          image7.Picture.LoadFromFile('harten.bmp');
        end
        else if (kleur1 = '2') and (game = 1) and (beurt = 2) then
        begin
          label12.font.color := clRed;
          label13.font.color := clRed;
          label14.font.color := clRed;
          image7.Picture.LoadFromFile('ruiten.bmp');
        end
        else if (kleur1 = '3') and (game = 1) and (beurt = 2) then
        begin
          label12.font.color := clBlack;
          label13.font.color := clBlack;
          label14.font.color := clBlack;
          image7.Picture.LoadFromFile('klaver.bmp');
        end
        else if (kleur1 = '4') and (game = 1) and (beurt = 2) then
        begin
          label12.font.color := clBlack;
          label13.font.color := clBlack;
          label14.font.color := clBlack;
          image7.Picture.LoadFromFile('schoppen.bmp');
        end
        else
          goto 2; {om ervoor te zorgen dat bij groter dan 4 opnieuw een waarde te geven}
      end;
    end;
end;

procedure TForm1.kaart;
var
  f, k: integer;
  kaart1, kaart: string;
label
  1, 2;
begin
  if (beurt = 1) and (game = 1) then
  begin
    {player kaarten}
    if (score > 21) and (game = 1) and (beurt = 1) and (credits > 0) then
    begin
      label7.caption := 'Dood';
      label1.hide;
      label2.hide;
      label3.hide;
      image1.Picture.LoadFromFile('dood.bmp');
      {dood kaart show}
    end
    else
    begin
      1: Randomize;
      //f := random(k);
      f := random(99) + 1;
      kaart := intToStr(f);
      kaart1 := kaart[1];

      if (kaart1 = '1') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.left := 22;
        label2.caption := '8';
        label1.caption := '8';
        label3.caption := '8';
        score := score + 8;
        label7.caption := 'Score: ' + intToStr(score);
      end
      else if (kaart1 = '2') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.left := 22;
        label2.caption := 'V';
        label1.caption := 'V';
        label3.caption := 'V';
        score := score + 2;
        label7.caption := 'Score: ' + intToStr(score);
      end
      else if (kaart1 = '3') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.left := 22;
        label2.caption := '7';
        label3.caption := '7';
        label1.caption := '7';
        score := score + 7;
        label7.caption := 'Score: ' + intToStr(score);
      end
      else if (kaart1 = '4') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.left := 22;
        label2.caption := 'A';
        label1.caption := 'A';
        label3.caption := 'A';

        if (score > 10) and (game = 1) and (beurt = 1) and (credits > 0) then
          score := score + 1
        else if (score < 10) or (score = 10) and (game = 1) and (beurt = 1) and (credits > 0) then
          score := score + 11;

        label7.caption := 'Score: ' + intToStr(score);
      end
      else if (kaart1 = '5') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.left := 22;
        label2.caption := 'B';
        label1.caption := 'B';
        label3.caption := 'B';
        score := score + 1;
        label7.caption := 'Score: ' + intToStr(score);
      end
      else if (kaart1 = '6') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.left := 14;
        label2.caption := '10';
        label1.caption := '10';
        label3.caption := '10';
        score := score + 10;
        label7.caption := 'Score: ' + intToStr(score);
      end
      else if (kaart1 = '7') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.left := 22;
        label2.caption := '9';
        label1.caption := '9';
        label3.caption := '9';
        score := score + 9;
        label7.caption := 'Score: ' + intToStr(score);
      end
      else if (kaart1 = '8') and (game = 1) and (beurt = 1) and (credits > 0) then
      begin
        label1.left := 22;
        label2.caption := 'H';
        label1.caption := 'H';
        label3.caption := 'H';
        score := score + 3;
        label7.caption := 'Score: ' + intToStr(score);
      end
      else
        goto 1;
    end
  end
  else
    if (beurt = 2) and (game = 1) then
    begin
      if (score1comp > 21) and (game = 1) and (beurt = 2) then
      begin
        label6.caption := 'Dood';
        label12.hide;
        label13.hide;
        label14.hide;
        image7.Picture.LoadFromFile('dood.bmp');
        {dood kaart show}
      end
      else
      begin
        2: Randomize;
        //f := random(k);
        f := random(99) + 1;
        kaart := intToStr(f);
        kaart1 := kaart[1];

        if (kaart1 = '1') and (game = 1) and (beurt = 2) then
        begin
          label12.left := 118;
          label12.caption := '8';
          label13.caption := '8';
          label14.caption := '8';
          score1comp := score1comp + 8;
          label6.caption := 'Score: ' + intToStr(score1comp);
        end
        else if (kaart1 = '2') and (game = 1) and (beurt = 2) then
        begin
          label12.left := 118;
          label12.caption := 'V';
          label13.caption := 'V';
          label14.caption := 'V';
          score1comp := score1comp + 2;
          label6.caption := 'Score: ' + intToStr(score1comp);
        end
        else if (kaart1 = '3') and (game = 1) and (beurt = 2) then
        begin
          label12.left := 118;
          label12.caption := '7';
          label13.caption := '7';
          label14.caption := '7';
          score1comp := score1comp + 7;
          label6.caption := 'Score: ' + intToStr(score1comp);
        end
        else if (kaart1 = '4') and (game = 1) and (beurt = 2) then
        begin
          label12.left := 118;
          label12.caption := 'A';
          label13.caption := 'A';
          label14.caption := 'A';

          if (score1comp > 10) and (game = 1) and (beurt = 2) then
            score1comp := score1comp + 1
          else if (score1comp < 10) or (score1comp = 10) and (game = 1) and (beurt = 2) then
            score1comp := score1comp + 11;

          label6.caption := 'Score: ' + intToStr(score1comp);
        end
        else if (kaart1 = '5') and (game = 1) and (beurt = 2) then
        begin
          label12.left := 118;
          label12.caption := 'B';
          label13.caption := 'B';
          label14.caption := 'B';
          score1comp := score1comp + 1;
          label6.caption := 'Score: ' + intToStr(score1comp);
        end
        else if (kaart1 = '6') and (game = 1) and (beurt = 2) then
        begin
          label12.left := 110;
          label12.caption := '10';
          label13.caption := '10';
          label14.caption := '10';
          score1comp := score1comp + 10;
          label6.caption := 'Score: ' + intToStr(score1comp);
        end
        else if (kaart1 = '7') and (game = 1) and (beurt = 2) then
        begin
          label12.left := 118;
          label12.caption := '9';
          label13.caption := '9';
          label14.caption := '9';
          score1comp := score1comp + 9;
          label6.caption := 'Score: ' + intToStr(score1comp);
        end
        else if (kaart1 = '8') and (game = 1) and (beurt = 2) then
        begin
          label12.left := 118;
          label12.caption := 'H';
          label13.caption := 'H';
          label14.caption := 'H';
          score1comp := score1comp + 3;
          label6.caption := 'Score: ' + intToStr(score1comp);
        end
        else
          goto 2;
      end;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if (game = 1) and (beurt = 1) then
  begin
    kaart;
    kleur;
    label1.show;
    label2.show;
    label3.show;
  end;

  if (score > 21) and (beurt = 1) then
  begin
    credits := credits - 1;
    beurt := 3;
    label1.hide;
    label2.hide;
    label3.hide;
    label11.caption := intToStr(credits);
  end;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  timer1.enabled := false;
  label1.hide;
  label2.hide;
  label3.hide;
  label14.hide;
  label13.hide;
  label12.hide;
  label7.caption := 'Score: ';
  label10.caption := intToStr(wons);
  label11.caption := intToStr(credits);
  score := 0;
  score1comp := 0;
  game := 0;
  wons := 0;
  credits := 0;
end;

procedure TForm1.New1Click(Sender: TObject);
begin
  timer1.enabled := false;
  score := 0;
  score1comp := 0;
  beurt := 1;
  game := 1;
  credits := 1;
  wons := 0;
  label1.hide;
  label2.hide;
  label3.hide;
  image1.Picture.LoadFromFile('leeg.bmp');
  image1.show;
  image7.Picture.LoadFromFile('leeg.bmp');
  image7.show;
  label12.hide;
  label13.hide;
  label14.hide;
  label7.caption := 'Score: ';
  label6.caption := 'Score: ';
  label10.caption := intToStr(wons);
  label11.caption := intToStr(credits);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if beurt = 1 then
    timer1.enabled := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  beurt := 2;
  if (score1comp < score + 1) and (game = 1) and (score < 22) and (score > 0) and (beurt = 2) then
  begin
    kaart;
    kleur;

    if (score1comp > score) and (beurt = 2) and (score1comp < 22) then
    begin
      beurt := 3;
      credits := credits - 1;
    end;
  end;

  if (score1comp > 21) and (game = 1) and (score > 0) and (beurt = 2) then
  begin
    image7.Picture.LoadFromFile('dood.bmp');
    label12.hide;
    label13.hide;
    label14.hide;
    label12.hide;
    label13.hide;
    label14.hide;
    label6.caption := 'Dood';
    credits := credits + 2;
    wons := wons + 1;
    timer1.enabled := false;
    beurt := 3;
  end
  else if (score1comp < 22) and (game = 1) and (score > 0) and (beurt = 2) then
  begin
    label12.show;
    label13.show;
    label14.show;
    beurt := 3;
  end;

  label10.caption := intToStr(wons);
  label11.caption := intTostr(credits);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if (beurt = 3) and (credits > 0) then
  begin
    image1.Picture.LoadFromFile('leeg.bmp');
    image1.show;
    image7.Picture.LoadFromFile('leeg.bmp');
    image7.show;
    label1.hide;
    label2.hide;
    label3.hide;
    label12.hide;
    label12.hide;
    label13.hide;
    label14.hide;
    label7.caption := 'Score: ';
    label6.caption := 'Score: ';
    label11.caption := intToStr(credits);
    score := 0;
    score1comp := 0;
    beurt := 1;
    game := 1;
    timer1.enabled := false;

    if credits > 1 then
      credits := credits - 1;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  game := 0;
end;

procedure TForm1.Info2Click(Sender: TObject);
begin
  form2.show;
end;

end.

