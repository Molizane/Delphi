unit fgl;

interface

uses GL ;

type gl4d = array [0..3] of gldouble;
type gl4f = array [0..3] of glfloat;
type gl3f = array [0..2] of glfloat;
type gl2f = array [0..1] of glfloat;
type gl1f = glfloat;

type jitter_point = record
     x,y : glfloat;
     end;

type tj8 = array[0..7] of jitter_point;



implementation

end.
