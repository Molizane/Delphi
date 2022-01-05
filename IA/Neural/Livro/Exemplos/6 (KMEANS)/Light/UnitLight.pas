unit UnitLight;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, CgWindow, CgTypes, CgLight, GL, GLu, GLut, ExtCtrls;

type
  TCgForm2 = class(TCGForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Esfera;
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
  public
    spinx: GLfloat;
    spiny: GLfloat;
    spinz: GLfloat;
    spinz1t: GLfloat;
    spinz1r: GLfloat;
    spinz2t: GLfloat;
    spinz2r: GLfloat;
    spinz3t: GLfloat;
    spinz3r: GLfloat;
    transx: GLfloat;
    transy: GLfloat;
    transz: GLfloat;
    light_pos: TCGVector;
    light_amb, light_spec, light_dif: TCGColorF;
    mat_emission: array[0..3] of GLfloat;
    lamb: array[0..3] of GLfloat;
    ldif: array[0..3] of GLfloat;
    lspc: array[0..3] of GLfloat;
    lpos: array[0..3] of GLfloat;
  end;

var
  CgForm2: TCgForm2;

implementation

{$R *.dfm}

procedure TCgForm2.FormCreate(Sender: TObject);
begin
  { Prepara o contexto de renderização do OpenGL na form, incializando um
    device context e formato de pixel }
  InitGL;

  { Vetor para cor ambiente }
  lamb[0] := 0.0;
  lamb[1] := 0.4;
  lamb[2] := 0.0;
  lamb[3] := 1;

  { Vetor para cor especular }
  lspc[0] := 0.7;
  lspc[1] := 0.7;
  lspc[2] := 0.7;
  lspc[3] := 1;

  { Vetor para coordenadas da luz }
  lpos[0] := 0.0;
  lpos[1] := 0.0;
  lpos[2] := -0.1;
  lpos[3] := 0.0;

  { Vetor para luz difusa }
  ldif[0] := 0.2;
  ldif[1] := 0.6;
  ldif[2] := 0.8;
  ldif[3] := 1;

  { Modo de sombreamento }
  glShadeModel(GL_SMOOTH);

  { Cria foco de luz e habilita }
  glEnable(GL_LIGHT0);

  { Configuração do ponto de luz para o sistema }
  glLightfv(GL_LIGHT0, GL_POSITION, @lpos);

  { Transformação das coordenadas normalizadas do device para as coordenadas da janela}
  glViewport(0, 0, Width, Height);

  { Especifica a pilha de matriz corrente }
  glMatrixMode(GL_PROJECTION);

  { Grava na matriz corrente a matriz identidade }
  glLoadIdentity();

  { Multiplica a matriz corrente pela matriz ortográfica }
  glOrtho(-240.0, 240.0, -240.0, 240.0, -240.0, 240.0);

  { Muda a pilha de matriz }
  glMatrixMode(GL_MODELVIEW);

  { Constrói as esferas referentes aos pontos e clusters }
  Esfera;
end;

procedure TCgForm2.FormResize(Sender: TObject);
begin
  glViewport(0, 0, Width, Height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glOrtho(-240.0, 240.0, -240.0, 240.0, -240.0, 240.0);
  glMatrixMode(GL_MODELVIEW);
end;

procedure TCgForm2.Esfera;
var
  quadObj: PGLUquadricObj;
begin
  { Cada esfera é uma lista}
  glNewList(1, GL_COMPILE);
  quadObj := gluNewQuadric;
  gluQuadricDrawStyle(quadObj, GLU_FILL);
  gluSphere(quadObj, 40, 256, 256);
  glEndList;

  transx := -180.0;
  transy := 0.0;
  transz := 0.0;

  Repaint;
end;

procedure TCgForm2.FormPaint(Sender: TObject);
var
  i, j: integer;
begin
  { Apaga o buffer dentro do viewport }
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);

  for I := 0 to 4 do
  begin
    for j := 0 to 0 do
    begin
      glPushMatrix();
      glTranslatef(transx + i * 85, j * 85 - transy, transz);
      { Efetua rotação nos três eixos }
      glRotated(30, 1, 0, 0);
      glRotated(-30, 0, 1, 0);
      glLightfv(GL_LIGHT0, GL_POSITION, @lpos);
      glColorMaterial(GL_FRONT, GL_DIFFUSE);
      mat_emission[0] := 0.40;
      mat_emission[1] := 0.00;
      mat_emission[2] := 0.00;
      mat_emission[3] := 1;

      if i = 1 then
        glEnable(GL_LIGHTING);

      if i = 2 then
      begin
        glLightfv(GL_LIGHT0, GL_AMBIENT, @lamb);
        glMaterialfv(GL_FRONT, GL_AMBIENT, @lamb);
      end;

      if i = 3 then
      begin
        glLightfv(GL_LIGHT0, GL_DIFFUSE, @ldif);
        glMaterialfv(GL_FRONT, GL_DIFFUSE, @ldif);
      end;

      if i = 4 then
      begin
        glLightfv(GL_LIGHT0, GL_SPECULAR, @lspc);
        glMaterialfv(GL_FRONT, GL_SPECULAR, @lspc);
        glMateriali(GL_FRONT, GL_SHININESS, 50);
      end;

      glMaterialfv(GL_FRONT, GL_EMISSION, @mat_emission);
      glCallList(1);
      glPopMatrix();
    end;
  end;

  PageFlip;
end;

procedure TCgForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  CGForm2 := nil;
end;

procedure TCgForm2.Timer1Timer(Sender: TObject);
begin
  { Rotação em x }
  spinx := spinx + 0.5;

  if (spinx > 360.0) then
    spinx := spinx - 360.0;

  { Rotação em y }
  spiny := spiny + 0.5;

  if (spiny > 360.0) then
    spiny := spiny - 360.0;

  { Rotação em z }
  spinz := spinz + 0.25;

  if (spinz > 360.0) then
    spinz := spinz - 360.0;

  transx := transx + 0.5;

  if transx > 90 then
    transx := -90;

  { Refaz a janela com os valores recalculados }
  Paint;
end;

end.

