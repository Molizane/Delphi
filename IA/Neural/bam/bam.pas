{$R-}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N+}    {Numeric coprocessor}
{$E+}    {Numeric processor emulation}
{$M 65500,16384,655360} {Turbo 3 default stack and heap}


{Program Source for BAM simulation}


PROGRAM Bidirectional_Associative_Memory (input,output);


{

Copyright 1990 by Wesley R. Elsberry.  All rights reserved.

Commercial use of this software is prohibited without written consent of
the author.

For information, bug reports, and updates contact

Wesley R. Elsberry
528 Chambers Creek Drive South
Everman, Texas 76140
Telephone: (817) 551-7018 (voice)
           (817) 551-9363 (data, Central Neural System BBS
                                 RBBS-Net 8:930/303 )

}

{BAM program}

USES Dos, CRT;

CONST
  Max_Iterations = 10;
TYPE
  Weight_node_ptr_ = ^Weight_node_;
  Weight_node_ = RECORD
    na : Weight_node_ptr_;
    nd : Weight_node_ptr_;
    v : REAL;
  END;
  Vector_node_ptr_ = ^Vector_node_;
  Vector_node_ = RECORD
    v : INTEGER;
    w : Weight_node_ptr_;
    nxt : Vector_node_ptr_;
  END;
  Vector_header_ = RECORD
    vns : Vector_node_ptr_;
  END;

VAR
  xv : vector_header_;
  yv : vector_header_;
  wm : weight_node_ptr_;
  ii, jj : INTEGER;
  X_LENGTH, Y_LENGTH : INTEGER;
  inchar : CHAR;
  Last_v : CHAR;
  In_dat : Text;
  Out_assoc, Out_weight, Out_stable : Text;
  ttx, tty : Vector_node_ptr_;
  vfilename : string[255];
  files_open : BOOLEAN;

PROCEDURE Allocate_X_vector(VAR tt : Vector_node_ptr_);
VAR
  ii : INTEGER;
  Temp : Vector_node_ptr_;
BEGIN

  NEW(tt);
  Temp := tt;
  Temp^.v := 1;
  Temp^.w := NIL;
  FOR II := 1 TO X_length-1 DO
    BEGIN
      NEW(Temp^.nxt);
      Temp^.nxt^.v := 1;
      Temp^.nxt^.w := NIL;
      Temp := Temp^.nxt;
    END;
  Temp^.nxt := NIL;
  Temp^.w := NIL;
END;

PROCEDURE Allocate_Y_vector(VAR tt : Vector_node_ptr_);
VAR
  ii : INTEGER;
  Temp : Vector_node_ptr_;
BEGIN

  NEW(tt);
  Temp := tt;
  Temp^.v := 1;
  Temp^.w := NIL;
  FOR II := 1 TO Y_length-1 DO
    BEGIN
      NEW(Temp^.nxt);
      Temp^.nxt^.v := 1;
      Temp^.nxt^.w := NIL;
      Temp := Temp^.nxt;
    END;
  Temp^.nxt := NIL;
  Temp^.w := NIL;
END;

PROCEDURE  Allocate_weight_vector (VAR tv : weight_node_ptr_);
{}
VAR
  ii : INTEGER;
  tpv : weight_node_ptr_;
BEGIN {}
  NEW(tv);
  tpv := tv;
  tpv^.v := 0;
  tpv^.nd := NIL;
  FOR ii := 1 TO Y_Length-1 DO
    BEGIN {}
      NEW(tpv^.na);
      tpv^.v := 0;
      tpv^.nd := NIL;
      tpv := tpv^.na;
      tpv^.v := 0;
      tpv^.nd := NIL;
    END; {}
  tpv^.na := NIL;
  tpv^.nd := NIL;
END; {}

PROCEDURE  Link_weights (tu,td : weight_node_ptr_);
{}
VAR
  ii : INTEGER;
BEGIN {}
  FOR ii := 1 TO Y_length DO
    BEGIN {}
      tu^.nd := td;
      tu := tu^.na;
      td := td^.na;
    END; {}
END; {}


PROCEDURE Allocate_weight_matrix;
VAR
  ii : INTEGER;
  Temp, Tempa, Start, tl, tc, tls, tcs : weight_node_ptr_;
  Vt : Vector_node_ptr_;
  cnt : INTEGER;
BEGIN
  cnt := 0;
  Allocate_weight_vector (wm);
  tls := wm;
  FOR ii := 1 TO X_Length-1 DO
    BEGIN {}
      Allocate_weight_vector (tcs);
      tl := tls;
      tc := tcs;
      Link_weights(tl,tc);
      tls := tcs;
    END; {}

  {Link to vectors}
  Start := wm;
  Temp := Start;
  Vt := Xv.vns;
  FOR ii := 1 TO X_Length DO
    BEGIN
      Vt^.w := Temp;
      Temp := Temp^.nd;
      Vt := Vt^.nxt;
    END;
  Temp := Start;
  Vt := Yv.vns;
  FOR ii := 1 TO Y_Length DO
    BEGIN
      Vt^.w := Temp;
      Temp := Temp^.na;
      Vt := Vt^.nxt;
    END;
END;

FUNCTION Step(C_val :INTEGER; s_val : Real):INTEGER;
{}
BEGIN {}
    IF (S_val > 0) THEN {}
      BEGIN
        Step := 1;
      END
    ELSE {}
      BEGIN
        IF (S_val < 0) THEN {}
          BEGIN
            Step := -1;
          END
        ELSE {}
          BEGIN
            Step := C_val;
          END;
      END;
END; {}

PROCEDURE Toggle_Value(ptr : Vector_node_ptr_);
{}
BEGIN {}
  CASE ptr^.v OF
    1 : ptr^.v := -1;
    -1 : ptr^.v := 1;
  END;

END; {}

FUNCTION Next_X_Value(Xptr : Vector_node_ptr_):INTEGER;
{}
VAR
  tx, ty : Vector_node_ptr_;
  tw : Weight_node_ptr_;
  ii : INTEGER;
  Sum : REAL;
BEGIN {}
  Sum := 0;
  tx := Xptr;
  ty := Yv.vns;
  tw := tx^.w;
  FOR ii := 1 TO Y_length DO
    BEGIN {}
      Sum := sum + tw^.v * ty^.v;
      tw := tw^.na;
      ty := ty^.nxt;
    END; {}
  Next_X_value := Step(Xptr^.v,sum);
END; {}

FUNCTION Next_Y_Value(Yptr : Vector_node_ptr_):INTEGER;
{}
VAR
  tx, ty : Vector_node_ptr_;
  tw : Weight_node_ptr_;
  ii : INTEGER;
  Sum : REAL;
BEGIN {}
  Sum := 0;
  tx := Xv.vns;
  ty := Yptr;
  Tw := ty^.w;
  FOR ii := 1 TO X_length DO
    BEGIN {}
      Sum := sum + tw^.v * tx^.v;
      tw := tw^.nd;
      tx := tx^.nxt;
    END; {}
  Next_Y_value := Step(Yptr^.v,sum);
END; {}

PROCEDURE Display_X(Assoc,Stable : BOOLEAN);
{}
VAR
  tx : Vector_node_ptr_;
  ii : INTEGER;
BEGIN {}
  tx := Xv.vns;
  WRITE('Vector X : ');
  FOR ii := 1 TO X_length DO
    BEGIN {}
      IF (tx^.v = 1) THEN {}
        BEGIN
          WRITE('+');
          IF (Assoc) THEN {}
            BEGIN
             IF files_open THEN
                WRITE(Out_Assoc,'+');
            END;
          IF (Stable) THEN {}
            BEGIN
              IF files_open THEN
                WRITE(Out_Stable,'+');
            END;
        END
      ELSE {}
        BEGIN
          WRITE('-');
          IF (Assoc) THEN {}
            BEGIN
              IF files_open THEN
                WRITE(Out_Assoc,'-');
            END;
          IF (Stable) THEN {}
            BEGIN
              IF files_open THEN
                WRITE(Out_Stable,'-');
            END;
        END;
      tx := tx^.nxt;
    END; {}
  WRITELN;
END; {}

PROCEDURE Display_Y(Assoc,Stable : BOOLEAN);
{}
VAR
  ty : Vector_node_ptr_;
  ii : INTEGER;
BEGIN {}
  ty := Yv.vns;
  WRITE('Vector Y : ');
  FOR ii := 1 TO Y_length DO
    BEGIN {}
      IF (ty^.v = 1) THEN {}
        BEGIN
          WRITE('+');
          IF (Assoc) THEN {}
            BEGIN
              IF files_open THEN
                WRITE(Out_Assoc,'+');
            END;
          IF (Stable) THEN {}
            BEGIN
              IF files_open THEN
                WRITE(Out_Stable,'+');
            END;
        END
      ELSE {}
        BEGIN
          WRITE('-');
          IF (Assoc) THEN {}
            BEGIN
              IF files_open THEN
                WRITE(Out_Assoc,'-');
            END;
          IF (Stable) THEN {}
            BEGIN
              IF files_open THEN
                WRITE(Out_Stable,'-');
            END;
        END;
      ty := ty^.nxt;
    END; {}
  WRITELN;
END; {}

PROCEDURE  Set_Weights;
{}
VAR
  tx, ty : Vector_node_ptr_;
  td, ta, tw : Weight_node_ptr_;
  ii, jj : INTEGER;
BEGIN {}
  tw := wm;
  ty := Yv.vns;
  tx := Xv.vns;
  td := tw;
  ta := tw;
  {For 1 to Y_length}
    {Set tx to Xv}
  FOR ii := 1 TO X_length DO
    BEGIN {}
      FOR jj := 1 TO Y_length DO
        BEGIN {}
          ta^.v := ta^.v + tx^.v * ty^.v;
          WRITE(ta^.v:3:1,' ');
          ta := ta^.na;
          ty := ty^.nxt;
        END; {}
      WRITELN;
      ty := Yv.vns;
      tx := tx^.nxt;
      td := td^.nd;
      ta := td;
    END; {}
    IF files_open THEN
      WRITE(Out_Assoc,'X then Y : ');
    Display_X(TRUE,FALSE);
    IF files_open THEN
      WRITE(Out_Assoc,' ');
    Display_Y(TRUE,FALSE);
    IF files_open THEN
      WRITELN(Out_Assoc);
END; {}


PROCEDURE Display_Links;
{}
VAR
  tx, ty : Vector_node_ptr_;
  tw, tw1 : Weight_node_ptr_;
  ii, jj : INTEGER;
BEGIN {}

  tx := NIL;
  WRITELN ('NIL = ',seg(tx^),':',ofs(tx^));

  {Display X links}
  tx := Xv.vns;
  WRITE('Vector X : ');
  FOR ii := 1 TO X_length DO
    BEGIN {}
      WRITE (seg(tx^.w^),':',ofs(tx^.w^),' ');
      tx := tx^.nxt;
    END; {}
  WRITELN;

  {Display Y links}
  ty := Yv.vns;
  WRITE('Vector Y : ');
  FOR ii := 1 TO Y_length DO
    BEGIN {}
      WRITE (seg(ty^.w^),':',ofs(ty^.w^),' ');
      ty := ty^.nxt;
    END; {}
  WRITELN;

  {Display Weight links}
  tw := Wm;
  tw1 := Wm;
  WRITELN ('Weight Matrix');
  WRITELN (seg(wm^),':',ofs(wm^),' ',seg(tw1^),':',ofs(tw1^));
  WRITELN;

  FOR jj := 1 TO X_Length DO
    BEGIN
      FOR ii := 1 TO Y_length DO
        BEGIN {}
          WRITE (seg(tw1^),':',ofs(tw1^),' ');
          tw1 := tw1^.na;
        END; {}
      WRITELN;
      tw1 := tw^.nd;
      tw := tw1;
    END;

END; {}


PROCEDURE  Set_X_Vector;
{}
VAR
  inchar : CHAR;
  tx : Vector_node_ptr_;
  ii : INTEGER;
BEGIN {}
  tx := Xv.vns;
  WRITELN('Input X Vector.  Use "-" and "+" for input');
  FOR ii := 1 TO X_Length DO
    BEGIN {}
      REPEAT {}
        inchar := READKEY;
      UNTIL (inchar in ['-','+','=']); {}
      IF (inchar = '=') THEN {}
        BEGIN
          inchar := '+';
        END;
      WRITE(inchar);
      CASE inchar OF
        '+' : tx^.v := 1;
        '-' : tx^.v := -1;
      END; {}
      tx := tx^.nxt;
    END; {FOR}
  WRITELN;
  Last_V := 'X';
END; {}

PROCEDURE  Set_Y_Vector;
{}
VAR
  inchar : CHAR;
  ty : Vector_node_ptr_;
  ii : INTEGER;
BEGIN {}
  ty := Yv.vns;
  WRITELN('Input Y Vector.  Use "-" and "+" for input');
  FOR ii := 1 TO Y_Length DO
    BEGIN {}
      REPEAT {}
        inchar := READKEY;
      UNTIL (inchar in ['-','+','=']); {}
      IF (inchar = '=') THEN {}
        BEGIN
          inchar := '+';
        END;
      WRITE(inchar);
      CASE inchar OF
        '+' : ty^.v := 1;
        '-' : ty^.v := -1;
      END; {}
      ty := ty^.nxt;
    END; {FOR}
  WRITELN;
  Last_V := 'Y';
END; {}

PROCEDURE Recall_X;
{}
CONST
  A = FALSE;
  S = FALSE;
VAR
  tx : Vector_node_ptr_;
  ii : INTEGER;

BEGIN {}
  tx := Xv.vns;
  FOR ii := 1 TO X_length DO
    BEGIN {}
      tx^.v := Next_X_Value(tx);
      tx := tx^.nxt;
    END; {}
{  Display_X (A,S);}
END; {}

PROCEDURE Recall_Y;
{}
CONST
  A = FALSE;
  S = FALSE;
VAR
  ty : Vector_node_ptr_;
  ii : INTEGER;
BEGIN {}
  ty := Yv.vns;
  FOR ii := 1 TO Y_length DO
    BEGIN {}
      ty^.v := Next_Y_Value(ty);
      ty := ty^.nxt;
    END; {}
{  Display_Y (A,S);}
END; {}

FUNCTION Value_symbol (v : INTEGER): CHAR;
{}
BEGIN {}
  CASE v OF
    1 : Value_Symbol := '+';
    -1 : Value_symbol := '-';
  END;
END; {}

PROCEDURE  Dump_weights;
{}
VAR
  td, ta : Weight_node_ptr_;
  ii, jj : INTEGER;
BEGIN {}
  IF files_open THEN
    WRITELN (Out_weight,'Weight Matrix');
  td := wm;
  ta := td;
  FOR ii := 1 TO X_Length DO
    BEGIN {}
      FOR jj := 1 TO Y_Length DO
        BEGIN {}
          IF files_open THEN
            WRITE (Out_weight,ta^.v:5:3,' ');
          ta := ta^.na;
        END; {}
      td := td^.nd;
      ta := td;
      IF files_open THEN
        WRITELN (Out_weight);
    END; {}
END; {}

PROCEDURE Recall;
{}
VAR
  ii : INTEGER;
BEGIN {}
  FOR ii := 1 TO Max_Iterations DO
    BEGIN {}
      CASE Last_V OF
        'X':
          BEGIN {}
            Recall_Y;
            Recall_X;
          END; {}
        'Y':
          BEGIN {}
            Recall_X;
            Recall_Y;
          END; {}
      END;
    END; {}
  Display_X (FALSE,FALSE);
  Display_Y (FALSE,FALSE);
END; {}

PROCEDURE Copy_list (VAR clst, tt : Vector_node_ptr_);
{}
VAR
  t1, t2 : Vector_node_ptr_;
BEGIN {}
  t1 := tt;
  t2 := clst;
  WHILE (t2 <> NIL) DO
    BEGIN {}
      t1^.v := t2^.v;
      t2 := t2^.nxt;
      t1 := t1^.nxt;
    END; {}
END; {}

PROCEDURE  Increment (tt : Vector_node_ptr_);
{}
VAR
  Done : BOOLEAN;
BEGIN {}
  Done := FALSE;
  {toggle v}
  {If v = 1 and nxt <> nil, then next and toggle
   else exit}
  WHILE (NOT Done) DO
    BEGIN {}
      Toggle_Value(tt);
      IF (tt^.v = 1) AND (tt^.nxt <> NIL) THEN {}
        BEGIN
          tt := tt^.nxt;
        END
      ELSE {}
        BEGIN
          Done := TRUE;
        END;
    END; {}
END; {}

FUNCTION Done (vt : Vector_node_ptr_):BOOLEAN;
{}
VAR
  Temp_B : BOOLEAN;
BEGIN {}
  Temp_B := TRUE;
  WHILE (vt <> NIL) DO
    BEGIN {}
      IF (vt^.v = 1) THEN {}
        BEGIN
          Temp_B := FALSE;
        END;
      vt := vt^.nxt;
    END; {}
  Done := Temp_B;
END; {}

PROCEDURE Find_stable;
{}
VAR
  tx, ty : Vector_node_ptr_;
  tv1, tv2 : Vector_node_ptr_;
  ii, jj : INTEGER;

BEGIN {}
  Allocate_X_Vector (tx);
  tv1 := tx;
  tv2 := Xv.vns;
  {Initialize Template}
  WHILE (tv1 <> NIL) DO
    BEGIN {}
      tv1^.v := 1;
      tv1 := tv1^.nxt;
    END; {}
  REPEAT {}
    tv1 := tx;
    Copy_list(Tv1,Tv2);
    Last_V := 'X';
    Recall;
    {Write X, Y to Stable}
    IF files_open THEN
      WRITE(Out_Stable,'X then Y ');
    Display_X (FALSE,TRUE);
    IF files_open THEN
      WRITE(Out_Stable,' ');
    Display_Y (FALSE,TRUE);
    IF files_open THEN
      WRITELN(Out_Stable);
    Increment(tv1);
  UNTIL (Done(tv1)); {}
  tv1 := tx;
  Copy_list(Tv1,Tv2);
  Recall;
  {Write X, Y to Stable}
  IF files_open THEN
    WRITE(Out_Stable,'X then Y ');
  Display_X (FALSE,TRUE);
  IF files_open THEN
    WRITE(Out_Stable,' ');
  Display_Y (FALSE,TRUE);
  IF files_open THEN
    WRITELN(Out_Stable);

  {For Y vector}
  Allocate_Y_Vector(ty);
  tv1 := ty;
  tv2 := Yv.vns;
  {Initialize Template}
  WHILE (tv1 <> NIL) DO
    BEGIN {}
      tv1^.v := 1;
      tv1 := tv1^.nxt;
    END; {}
  REPEAT {}
    tv1 := ty;
    Copy_list(Tv1,Tv2);
    Last_V := 'Y';
    Recall;
    {Write X, Y to Stable}
    IF files_open THEN
      WRITE(Out_Stable,'X then Y ');
    Display_X (FALSE,TRUE);
    IF files_open THEN
      WRITE(Out_Stable,' ');
    Display_Y (FALSE,TRUE);
    IF files_open THEN
      WRITELN(Out_Stable);
    Increment(tv1);
  UNTIL (Done(tv1)); {}
  tv1 := ty;
  Copy_list(Tv1,Tv2);
  Recall;
  {Write X, Y to Stable}
  IF files_open THEN
    WRITE(Out_Stable,'X then Y ');
  Display_X (FALSE,TRUE);
  IF files_open THEN
    WRITE(Out_Stable,' ');
  Display_Y (FALSE,TRUE);
  IF files_open THEN
    WRITELN(Out_Stable);
END; {}

PROCEDURE  Set_vector_from_file (tv : Vector_node_ptr_);
{}
VAR
  tt : Vector_node_ptr_;
  inchar : CHAR;
BEGIN {}
  tt := tv;
  WHILE (tt <> NIL) DO
    BEGIN {}
      READ(In_dat,inchar);
      CASE inchar OF
        '+','=' :
          BEGIN {}
            tt^.v := 1;
          END; {}
        '-' :
          BEGIN {}
            tt^.v := -1;
          END; {}
      END;
      tt := tt^.nxt;
    END; {}
END; {}

PROCEDURE  Set_weights_from_file;
{}
BEGIN {}

  ASSIGN (In_dat,vfilename + '.DAT');
  RESET (In_dat);

  ASSIGN(Out_assoc,vfilename+'a.bam');
  REWRITE(Out_assoc);

  ASSIGN(Out_weight,vfilename+'w.bam');
  REWRITE(Out_weight);

  ASSIGN(Out_stable,vfilename+'s.bam');
  REWRITE(Out_stable);

  WHILE (NOT EOF(In_dat)) DO
    BEGIN {}
      Set_vector_from_file(Xv.vns);
      Set_vector_from_file(Yv.vns);
      READLN(In_dat);
      Set_weights;
    END; {}
  CLOSE (IN_dat);



END; {}

PROCEDURE  Driver;
{}
BEGIN {}
  WRITELN;
  WRITELN('Bidirectional Associative Memory program');
  WRITELN('Copyright 1988 by Wesley R. Elsberry');
  WRITELN(' All Rights Reserved');
  WRITELN;

  {Initialize}
  files_open := FALSE;

  {BAM Choices}
    {Set up BAM}

      REPEAT {}
        {Set X vector length}
        WRITE('Length of X vector? : ');
        READLN(X_length);
        WRITELN;
      UNTIL (x_length >= 1); {}

      REPEAT {}
        {Set Y vector length}
        WRITE('Length of Y vector? : ');
        READLN(Y_length);
        WRITELN;
      UNTIL (Y_length >= 1); {}

      {Allocate vectors}
      Allocate_X_vector(Xv.vns);
      Allocate_Y_vector(Yv.vns);

      {Allocate Weight matrix}
      Allocate_Weight_matrix;

{ Display_links is handy for debugging}
{      Display_links;}


    REPEAT {}
      {Set associative weights}
      WRITELN;
      WRITE(
'Set (X),(Y), (S)et weight, (G)et from file, (H)elp, or (Q)uit setup : ');
      READLN(inchar);
      CASE inchar OF
        'X','x' :
          BEGIN {}
            Set_X_vector;
          END; {}
        'Y','y' :
          BEGIN {}
            Set_Y_vector;
          END; {}
        'S','s' :
          BEGIN {}
            Set_weights;
          END; {}
        'G','g' :
          BEGIN {}
            WRITE ('File to get vectors from? : ');
            READLN(vfilename);
            files_open := TRUE;
            Set_Weights_from_File;
          END; {}
        'H','h' :
          BEGIN
            WRITELN;
            WRITELN(
'Set (X), (Y) :  These allow you to interactively enter values for X and Y');
            WRITELN(
'                vector pairs.  The weights for the association between  ');
            WRITELN(
'                these is not set until the (S)et weights option is used.');
            WRITELN(
'                Thus, errors in entry can be corrected by recalling the');
            WRITELN(
'                same vector entry routine again before setting weights.');
            WRITELN(
'(S)et weights : This option records an association between the current');
            WRITELN(
'                values of the X and Y vectors, storing this association');
            WRITELN(
'                in a set of weights between the nodes of the network.');
            WRITELN(
'(G)et from file :  This allows a textfile containing vector pairs to be');
            WRITELN(
'                read and weights recorded for each.');
            WRITELN(
'(H)elp  :       This help screen.');
            WRITELN(
'(Q)uit setup  : After the BAM network has the sets of vectors which you');
            WRITELN(
'                wish to train it to, you may leave the setup mode and');
            WRITELN(
'                proceed to an interactive recall session, where you may');
            WRITELN(
'                specify the X and/or Y vector(s) and examine the recalled');
            WRITELN(
'                pattern.');
            WRITELN;
            END;
      END;
    UNTIL (inchar = 'Q') OR (inchar = 'q'); {}

    REPEAT {}
      {Choice: Set, Recall, Quit}
      WRITELN;
      WRITE('Set (X), (Y), (R)ecall, or (Q)uit simulation : ');
      READLN(inchar);
      CASE inchar OF
        'X','x' :
          BEGIN {}
            Set_X_vector;
          END; {}
        'Y','y' :
          BEGIN {}
            Set_Y_vector;
          END; {}
        'R','r' :
          BEGIN {}
            Recall;
          END; {}
      END;
    UNTIL (inchar = 'Q') OR (inchar = 'q'); {}

  WRITELN;
  WRITELN ('Weights and Stable States ... ');
  WRITELN;

  Dump_weights;
  Find_stable;

  WRITELN('End of BAM program, exiting to DOS');

  IF files_open THEN BEGIN
    FLUSH(Out_assoc);
    FLUSH(Out_weight);
    FLUSH(Out_stable);
    CLOSE(Out_assoc);
    CLOSE(Out_weight);
    CLOSE(Out_stable);
    END;
END; {}

BEGIN {MAIN}
  Driver;
END. {MAIN}

