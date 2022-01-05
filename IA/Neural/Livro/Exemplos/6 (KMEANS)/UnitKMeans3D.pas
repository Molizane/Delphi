unit UnitKMeans3D;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CgWindow, CgTypes, CgLight, GL, GLu, GLut, KMeans, ExtCtrls;

type
  TCGForm1 = class(TCGForm)
    KMeans: TKMeans;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure BuildSpheres;
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure SpinDisplay;
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function KMeansGetCluster(Sender: TObject; i: Integer): Word;
    function KMeansGetData(Sender: TObject; i, j: Integer): Double;
    procedure FormResize(Sender: TObject);
  private
  public
    { Variáveis para controle da rotação }
    spinx: GLfloat;
    spiny: GLfloat;
    spinz: GLfloat;
    { Luz emissiva }
    mat_emission: array[0..3] of GLfloat;
    { Reflexão ambiente }
    lamb: array[0..3] of GLfloat;
    { Reflexão difusa }
    ldif: array[0..3] of GLfloat;
    { Reflexão especular }
    lspc: array[0..3] of GLfloat;
    { Posição da fonte de luz }
    lpos: array[0..3] of GLfloat;
    { Coordenadas das esferas }
    x, y, z: array[0..128] of single;
    { Vetor para guardas as amostras para o algoritmo K-Means }
    samples: array[0..2, 0..128] of double;
  end;

var
  CGForm1: TCGForm1;

implementation

{$R *.DFM}

procedure TCGForm1.FormCreate(Sender: TObject);
begin
  { Prepara o contexto de renderização do OpenGL na form, incializando um
    device context e formato de pixel }
  InitGL;

  { Vetor para cor ambiente }
  lamb[0] := 0.2;
  lamb[1] := 0.2;
  lamb[2] := 0.2;
  lamb[3] := 1;

  { Vetor para cor especular }
  lspc[0] := 1;
  lspc[1] := 1;
  lspc[2] := 1;
  lspc[3] := 1;

  { Vetor para coordenadas da luz }
  lpos[0] := 0;
  lpos[1] := 0;
  lpos[2] := 0;
  lpos[3] := 1;

  { Vetor para luz difusa }
  ldif[0] := 0.8;
  ldif[1] := 0.8;
  ldif[2] := 0.8;
  ldif[3] := 1;

  { Modo de sombreamento }
  glShadeModel(GL_SMOOTH);

  { Cria foco de luz e habilita }
  glEnable(GL_LIGHT0);
  glEnable(GL_LIGHTING);

  { Configuração do ponto de luz para o sistema }
  glLightfv(GL_LIGHT0, GL_POSITION, @lpos);
  glMaterialfv(GL_FRONT, GL_AMBIENT, @lamb);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, @ldif);
  glMaterialfv(GL_FRONT, GL_SPECULAR, @lspc);
  glMateriali(GL_FRONT, GL_SHININESS, 128);

  { Transformação das coordenadas normalizadas do device para as coordenadas da janela}
  glViewport(0, 0, Width, Height);

  { Especifica a pilha de matriz corrente }
  glMatrixMode(GL_PROJECTION);

  { Grava na matriz corrente a matriz identidade }
  glLoadIdentity();

  { Multiplica a matriz corrente pela matriz ortográfica }
  glOrtho(-60.0, 60.0, -60.0, 60.0, -60.0, 60.0);

  { Muda a pilha de matriz }
  glMatrixMode(GL_MODELVIEW);

  { Constrói as esferas referentes aos pontos e clusters }
  BuildSpheres;
end;

procedure TCgForm1.BuildSpheres;
var
  quadObj: PGLUquadricObj;
  i, j, k: integer;
begin
  Randomize;

  { 32 Esferas referentes ao primeiro cluster }
  for i := 1 to 32 do
  begin
    { Cada esfera é uma lista}
    glNewList(i, GL_COMPILE);
    quadObj := gluNewQuadric;
    gluQuadricDrawStyle(quadObj, GLU_FILL);
    gluSphere(quadObj, 1.0, 8, 8);
    glEndList;

    { Atribui coordenadas aleatórias definindo a proximidade entre si }
    x[i] := 8 - 48 * Random(1000) / 1000;
    y[i] := 8 - 48 * Random(1000) / 1000;
    z[i] := 16 - 48 * Random(1000) / 1000;

    { Guarda os valores para uso no componente KMeans }
    samples[0, i] := x[i];
    samples[1, i] := y[i];
    samples[2, i] := z[i];
  end;

  { 32 Esferas referentes ao segundo cluster }
  for i := 33 to 64 do
  begin
    { Cada esfera é uma lista }
    glNewList(i, GL_COMPILE);
    quadObj := gluNewQuadric;
    gluQuadricDrawStyle(quadObj, GLU_FILL);
    gluSphere(quadObj, 1.0, 8, 8);
    glEndList;

    { Atribui coordenadas aleatórias definindo a proximidade entre si }
    x[i] := 8 - 48 * Random(1000) / 1000;
    y[i] := 32 - 48 * Random(1000) / 1000;
    z[i] := 16 - 48 * Random(1000) / 1000;

    { Guarda os valores para uso no componente KMeans }
    samples[0, i] := x[i];
    samples[1, i] := y[i];
    samples[2, i] := z[i];
  end;

  { 32 Esferas referentes ao terceiro cluster }
  for i := 65 to 96 do
  begin
    { Cada esfera é uma lista }
    glNewList(i, GL_COMPILE);
    quadObj := gluNewQuadric;
    gluQuadricDrawStyle(quadObj, GLU_FILL);
    gluSphere(quadObj, 1.0, 8, 8);
    glEndList;

    { Atribui coordenadas aleatórias definindo a proximidade entre si }
    x[i] := 8 - 48 * Random(1000) / 1000;
    y[i] := 8 - 48 * Random(1000) / 1000;
    z[i] := 8 + 48 * Random(1000) / 1000;

    { Guarda os valores para uso no componente KMeans }
    samples[0, i] := x[i];
    samples[1, i] := y[i];
    samples[2, i] := z[i];
  end;

  { Inicializa a rede KMeans }
  KMeans.Initialize;

  { Inicializa os clusters, são as esferas etiquetadas 1000, 1001 e 1002 }
  for i := 1000 to 1002 do
  begin
    glNewList(i, GL_COMPILE);
    quadObj := gluNewQuadric;
    gluQuadricDrawStyle(quadObj, GLU_FILL);
    gluSphere(quadObj, 3.0, 32, 8);
    glEndList;
  end;

  { Atribui as coordenadas iniciais dos clusters coincidentes com a posição do
    primeiro elemento de cada grupo }
  KMeans.Clusters[0, 0] := x[65];
  KMeans.Clusters[0, 1] := y[65];
  KMeans.Clusters[0, 2] := z[65];

  KMeans.Clusters[1, 0] := x[1];
  KMeans.Clusters[1, 1] := y[1];
  KMeans.Clusters[1, 2] := z[1];

  KMeans.Clusters[2, 0] := x[33];
  KMeans.Clusters[2, 1] := y[33];
  KMeans.Clusters[2, 2] := z[33];
end;

procedure TCGForm1.Timer1Timer(Sender: TObject);
begin
  { Modifica os valores para giro nas três dimensões do device }
  SpinDisplay;

  { Incrementa um passo na clusterização }
  KMeans.Step;
end;

procedure TCgForm1.SpinDisplay;
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

  { Refaz a janela com os valores recalculados }
  Paint;
end;

procedure TCGForm1.Timer2Timer(Sender: TObject);
begin
  { Reinicialização dos valores dos clusters }
  KMeans.Clusters[0, 0] := 50 - Random(100);
  KMeans.Clusters[0, 1] := 50 - Random(100);
  KMeans.Clusters[0, 2] := 50 - Random(100);

  KMeans.Clusters[1, 0] := 50 - Random(100);
  KMeans.Clusters[1, 1] := 50 - Random(100);
  KMeans.Clusters[1, 2] := 50 - Random(100);

  KMeans.Clusters[2, 0] := 50 - Random(100);
  KMeans.Clusters[2, 1] := 50 - Random(100);
  KMeans.Clusters[2, 2] := 50 - Random(100);
end;

procedure TCGForm1.FormPaint(Sender: TObject);
var
  i, j, k: integer;
  xc, yc, zc: single;
begin
  { Apaga o buffer dentro do viewport }
  glClear(GL_COLOR_BUFFER_BIT);

  { Salva a matriz atual }
  glPushMatrix();

  { Efetua rotação nos três eixos }
  glRotatef(spinx, 1.0, 0.0, 0.0);
  glRotatef(spiny, 0.0, 1.0, 0.0);
  glRotatef(spinz, 0.0, 0.0, 1.0);

  { Desenha as esferas do primeiro cluster }
  for i := 1 to 32 do
  begin
    glPushMatrix();
    glTranslatef(x[i], y[i], z[i]);
    glColor3f(0.6, 0.7, 0.2);
    mat_emission[0] := 0.1;
    mat_emission[1] := 0.1;
    mat_emission[2] := 0.4;
    mat_emission[3] := 1;
    glMaterialfv(GL_FRONT, GL_EMISSION, @mat_emission);
    glCallList(i);
    glPopMatrix();
  end;

  { Desenha as esferas do segundo cluster }
  for i := 33 to 64 do
  begin
    glPushMatrix();
    glTranslatef(x[i], y[i], z[i]);
    glColor3f(0.2, 0.2, 0.8);
    mat_emission[0] := 0.4;
    mat_emission[1] := 0.1;
    mat_emission[2] := 0.1;
    mat_emission[3] := 1;
    glMaterialfv(GL_FRONT, GL_EMISSION, @mat_emission);
    glCallList(i);
    glPopMatrix();
  end;

  { Desenha as esferas do terceiro cluster }
  for i := 65 to 92 do
  begin
    glPushMatrix();
    glTranslatef(x[i], y[i], z[i]);
    glColor3f(0.2, 0.7, 0.4);
    mat_emission[0] := 0.1;
    mat_emission[1] := 0.4;
    mat_emission[2] := 0.1;
    mat_emission[3] := 1;
    glMaterialfv(GL_FRONT, GL_EMISSION, @mat_emission);
    glCallList(i);
    glPopMatrix();
  end;

  { Desenha as esferas referentes aos clusters }
  for i := 1000 to 1002 do
  begin
    glPushMatrix();
    xc := KMeans.Clusters[i - 1000, 0];
    yc := KMeans.Clusters[i - 1000, 1];
    zc := KMeans.Clusters[i - 1000, 2];
    glTranslatef(xc, yc, zc);
    glColor3f(0.2, 0.7, 0.4);

    if i = 1000 then
    begin
      mat_emission[0] := 0.0;
      mat_emission[1] := 0.5;
      mat_emission[2] := 0.8;
      mat_emission[3] := 1;
    end;

    if i = 1001 then
    begin
      mat_emission[0] := 0.8;
      mat_emission[1] := 0.2;
      mat_emission[2] := 0.0;
      mat_emission[3] := 1;
    end;

    if i = 1002 then
    begin
      mat_emission[0] := 0.5;
      mat_emission[1] := 0.8;
      mat_emission[2] := 0.2;
      mat_emission[3] := 1;
    end;

    glMaterialfv(GL_FRONT, GL_EMISSION, @mat_emission);
    glCallList(i);
    glPopMatrix();
  end;

  { Desenha as conexões com o cluster 0 }
  xc := KMeans.Clusters[0, 0];
  yc := KMeans.Clusters[0, 1];
  zc := KMeans.Clusters[0, 2];

  for i := 1 to 32 do
  begin
    glPushMatrix();
    glColor3f(0.7, 0.4, 0.2);
    mat_emission[0] := 0.0;
    mat_emission[1] := 0.0;
    mat_emission[2] := 0.2 + Random(2) * 0.4;
    mat_emission[3] := 1;
    glMaterialfv(GL_FRONT, GL_EMISSION, @mat_emission);
    glPushMatrix();
    glBegin(GL_LINES);
    glVertex3f(x[i], y[i], z[i]);
    glVertex3f(xc, yc, zc);
    glEnd();
    glPopMatrix();
  end;

  { Desenha as conexões com o cluster 1 }
  xc := KMeans.Clusters[1, 0];
  yc := KMeans.Clusters[1, 1];
  zc := KMeans.Clusters[1, 2];

  for i := 33 to 64 do
  begin
    glPushMatrix();
    glColor3f(0.2, 0.4, 0.7);
    mat_emission[0] := 0.2 + Random(2) * 0.4;
    mat_emission[1] := 0.0;
    mat_emission[2] := 0.0;
    mat_emission[3] := 1;
    glMaterialfv(GL_FRONT, GL_EMISSION, @mat_emission);
    glPushMatrix();
    glBegin(GL_LINES);
    glVertex3f(x[i], y[i], z[i]);
    glVertex3f(xc, yc, zc);
    glEnd();
    glPopMatrix();
  end;

  { Desenha as conexões com o cluster 2 }
  xc := KMeans.Clusters[2, 0];
  yc := KMeans.Clusters[2, 1];
  zc := KMeans.Clusters[2, 2];

  for i := 65 to 92 do
  begin
    glPushMatrix();
    glColor3f(0.2, 0.7, 0.4);
    mat_emission[0] := 0.0;
    mat_emission[1] := 0.2 + Random(2) * 0.4;
    mat_emission[2] := 0.0;
    mat_emission[3] := 1;
    glMaterialfv(GL_FRONT, GL_EMISSION, @mat_emission);
    glPushMatrix();
    glBegin(GL_LINES);
    glVertex3f(x[i], y[i], z[i]);
    glVertex3f(xc, yc, zc);
    glEnd();
    glPopMatrix();
  end;

  { Restaura a matriz }
  glPopMatrix();

  { Troca os buffers (uso de buffer duplo) }
  PageFlip;
end;

procedure TCGForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  CGForm1 := nil;
end;

function TCGForm1.KMeansGetCluster(Sender: TObject; i: Integer): Word;
var
  m: word;
begin
  m := i div 32;
  Result := m;
end;

function TCGForm1.KMeansGetData(Sender: TObject; i, j: Integer): Double;
begin
  Result := samples[j, i];
end;

procedure TCGForm1.FormResize(Sender: TObject);
begin
  glViewport(0, 0, Width, Height);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity();
  glOrtho(-60.0, 60.0, -60.0, 60.0, -60.0, 60.0);
  glMatrixMode(GL_MODELVIEW);
end;

end.

