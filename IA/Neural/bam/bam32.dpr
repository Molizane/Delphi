{$R-} {Range checking off}
{$B+} {Boolean complete evaluation on}
{$S+} {Stack checking on}
{$I+} {I/O checking on}
{$N+} {Numeric coprocessor}
{$E+} {Numeric processor emulation}
//{$M 65500,16384,655360} {Turbo 3 default stack and heap}

{Program Source for BAM simulation}

program Bidirectional_Associative_Memory(input, output);

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

uses Win32CRT   ;

const
  Max_Iterations = 10;
type
  Weight_node_ptr_ = ^Weight_node_;

  Weight_node_ = record
    na: Weight_node_ptr_;
    nd: Weight_node_ptr_;
    v: REAL;
  end;

  Vector_node_ptr_ = ^Vector_node_;

  Vector_node_ = record
    v: Integer;
    w: Weight_node_ptr_;
    nxt: Vector_node_ptr_;
  end;

  Vector_header_ = record
    vns: Vector_node_ptr_;
  end;

var
  xv: vector_header_;
  yv: vector_header_;
  wm: weight_node_ptr_;
  ii, jj: Integer;
  X_LENGTH, Y_LENGTH: Integer;
  inchar: CHAR;
  Last_v: CHAR;
  In_dat: Text;
  Out_assoc, Out_weight, Out_stable: Text;
  ttx, tty: Vector_node_ptr_;
  vfilename: string[255];
  files_open: Boolean;

type
  TLongToByte = packed record
    case Integer of
      0: (l: LongInt);
      1: (b0, b1, b2, b3: Byte);
  end;

function seg(s: Vector_node_): string; overload;
begin

end;

function seg(s: Weight_node_): string; overload;
begin

end;

function ofs(s: Vector_node_): string; overload;
begin

end;

function ofs(s: Weight_node_): string; overload;
begin

end;

procedure Allocate_X_vector(var tt: Vector_node_ptr_);
var
  ii: Integer;
  Temp: Vector_node_ptr_;
begin
  New(tt);
  Temp := tt;
  Temp^.v := 1;
  Temp^.w := nil;

  for II := 1 to X_length - 1 do
  begin
    New(Temp^.nxt);
    Temp^.nxt^.v := 1;
    Temp^.nxt^.w := nil;
    Temp := Temp^.nxt;
  end;

  Temp^.nxt := nil;
  Temp^.w := nil;
end;

procedure Allocate_Y_vector(var tt: Vector_node_ptr_);
var
  ii: Integer;
  Temp: Vector_node_ptr_;
begin
  New(tt);
  Temp := tt;
  Temp^.v := 1;
  Temp^.w := nil;

  for II := 1 to Y_length - 1 do
  begin
    New(Temp^.nxt);
    Temp^.nxt^.v := 1;
    Temp^.nxt^.w := nil;
    Temp := Temp^.nxt;
  end;

  Temp^.nxt := nil;
  Temp^.w := nil;
end;

procedure Allocate_weight_vector(var tv: weight_node_ptr_);
{}
var
  ii: Integer;
  tpv: weight_node_ptr_;
begin {}
  New(tv);
  tpv := tv;
  tpv^.v := 0;
  tpv^.nd := nil;

  for ii := 1 to Y_Length - 1 do
  begin {}
    New(tpv^.na);
    tpv^.v := 0;
    tpv^.nd := nil;
    tpv := tpv^.na;
    tpv^.v := 0;
    tpv^.nd := nil;
  end; {}

  tpv^.na := nil;
  tpv^.nd := nil;
end; {}

procedure Link_weights(tu, td: weight_node_ptr_);
{}
var
  ii: Integer;
begin {}
  for ii := 1 to Y_length do
  begin {}
    tu^.nd := td;
    tu := tu^.na;
    td := td^.na;
  end; {}
end; {}

procedure Allocate_weight_matrix;
var
  ii: Integer;
  Temp, Tempa, Start, tl, tc, tls, tcs: weight_node_ptr_;
  Vt: Vector_node_ptr_;
  cnt: Integer;
begin
  cnt := 0;
  Allocate_weight_vector(wm);
  tls := wm;

  for ii := 1 to X_Length - 1 do
  begin {}
    Allocate_weight_vector(tcs);
    tl := tls;
    tc := tcs;
    Link_weights(tl, tc);
    tls := tcs;
  end; {}

  {Link to vectors}
  Start := wm;
  Temp := Start;
  Vt := Xv.vns;

  for ii := 1 to X_Length do
  begin
    Vt^.w := Temp;
    Temp := Temp^.nd;
    Vt := Vt^.nxt;
  end;

  Temp := Start;
  Vt := Yv.vns;

  for ii := 1 to Y_Length do
  begin
    Vt^.w := Temp;
    Temp := Temp^.na;
    Vt := Vt^.nxt;
  end;
end;

function Step(C_val: Integer; s_val: Real): Integer;
{}
begin {}
  if (S_val > 0) then {}
  begin
    Step := 1;
  end
  else {}
  begin
    if (S_val < 0) then {}
    begin
      Step := -1;
    end
    else {}
    begin
      Step := C_val;
    end;
  end;
end; {}

procedure Toggle_Value(ptr: Vector_node_ptr_);
{}
begin {}
  case ptr^.v of
    1: ptr^.v := -1;
    -1: ptr^.v := 1;
  end;
end; {}

function Next_X_Value(Xptr: Vector_node_ptr_): Integer;
{}
var
  tx, ty: Vector_node_ptr_;
  tw: Weight_node_ptr_;
  ii: Integer;
  Sum: REAL;
begin {}
  Sum := 0;
  tx := Xptr;
  ty := Yv.vns;
  tw := tx^.w;

  for ii := 1 to Y_length do
  begin {}
    Sum := sum + tw^.v * ty^.v;
    tw := tw^.na;
    ty := ty^.nxt;
  end; {}

  Next_X_value := Step(Xptr^.v, sum);
end; {}

function Next_Y_Value(Yptr: Vector_node_ptr_): Integer;
{}
var
  tx, ty: Vector_node_ptr_;
  tw: Weight_node_ptr_;
  ii: Integer;
  Sum: REAL;
begin {}
  Sum := 0;
  tx := Xv.vns;
  ty := Yptr;
  Tw := ty^.w;

  for ii := 1 to X_length do
  begin {}
    Sum := sum + tw^.v * tx^.v;
    tw := tw^.nd;
    tx := tx^.nxt;
  end; {}

  Next_Y_value := Step(Yptr^.v, sum);
end; {}

procedure Display_X(Assoc, Stable: Boolean);
{}
var
  tx: Vector_node_ptr_;
  ii: Integer;
begin {}
  tx := Xv.vns;
  Write('Vector X : ');

  for ii := 1 to X_length do
  begin {}
    if (tx^.v = 1) then {}
    begin
      Write('+');

      if (Assoc) then {}
      begin
        if files_open then
          Write(Out_Assoc, '+');
      end;
      if (Stable) then {}
      begin
        if files_open then
          Write(Out_Stable, '+');
      end;
    end
    else {}
    begin
      Write('-');

      if (Assoc) then {}
      begin
        if files_open then
          Write(Out_Assoc, '-');
      end;

      if (Stable) then {}
      begin
        if files_open then
          Write(Out_Stable, '-');
      end;
    end;

    tx := tx^.nxt;
  end; {}

  Writeln;
end; {}

procedure Display_Y(Assoc, Stable: Boolean);
{}
var
  ty: Vector_node_ptr_;
  ii: Integer;
begin {}
  ty := Yv.vns;
  Write('Vector Y : ');

  for ii := 1 to Y_length do
  begin {}
    if (ty^.v = 1) then {}
    begin
      Write('+');

      if (Assoc) then {}
      begin
        if files_open then
          Write(Out_Assoc, '+');
      end;

      if (Stable) then {}
      begin
        if files_open then
          Write(Out_Stable, '+');
      end;
    end
    else {}
    begin
      Write('-');

      if (Assoc) then {}
      begin
        if files_open then
          Write(Out_Assoc, '-');
      end;

      if (Stable) then {}
      begin
        if files_open then
          Write(Out_Stable, '-');
      end;
    end;

    ty := ty^.nxt;
  end; {}

  Writeln;
end; {}

procedure Set_Weights;
{}
var
  tx, ty: Vector_node_ptr_;
  td, ta, tw: Weight_node_ptr_;
  ii, jj: Integer;
begin {}
  tw := wm;
  ty := Yv.vns;
  tx := Xv.vns;
  td := tw;
  ta := tw;

  {For 1 to Y_length}
    {Set tx to Xv}
  for ii := 1 to X_length do
  begin {}
    for jj := 1 to Y_length do
    begin {}
      ta^.v := ta^.v + tx^.v * ty^.v;
      Write(ta^.v: 3: 1, ' ');
      ta := ta^.na;
      ty := ty^.nxt;
    end; {}

    Writeln;
    ty := Yv.vns;
    tx := tx^.nxt;
    td := td^.nd;
    ta := td;
  end; {}

  if files_open then
    Write(Out_Assoc, 'X then Y : ');

  Display_X(True, False);

  if files_open then
    Write(Out_Assoc, ' ');

  Display_Y(True, False);

  if files_open then
    Writeln(Out_Assoc);
end; {}

procedure Display_Links;
{}
var
  tx, ty: Vector_node_ptr_;
  tw, tw1: Weight_node_ptr_;
  ii, jj: Integer;
begin {}
  tx := nil;
  Writeln('NIL = ', seg(tx^), ':', ofs(tx^));

  {Display X links}
  tx := Xv.vns;
  Write('Vector X : ');

  for ii := 1 to X_length do
  begin {}
    Write(seg(tx^.w^), ':', ofs(tx^.w^), ' ');
    tx := tx^.nxt;
  end; {}

  Writeln;

  {Display Y links}
  ty := Yv.vns;
  Write('Vector Y : ');

  for ii := 1 to Y_length do
  begin {}
    Write(seg(ty^.w^), ':', ofs(ty^.w^), ' ');
    ty := ty^.nxt;
  end; {}

  Writeln;

  {Display Weight links}
  tw := Wm;
  tw1 := Wm;
  Writeln('Weight Matrix');
  Writeln(seg(wm^), ':', ofs(wm^), ' ', seg(tw1^), ':', ofs(tw1^));
  Writeln;

  for jj := 1 to X_Length do
  begin
    for ii := 1 to Y_length do
    begin {}
      Write(seg(tw1^), ':', ofs(tw1^), ' ');
      tw1 := tw1^.na;
    end; {}

    Writeln;
    tw1 := tw^.nd;
    tw := tw1;
  end;
end; {}

procedure Set_X_Vector;
{}
var
  inchar: CHAR;
  tx: Vector_node_ptr_;
  ii: Integer;
begin {}
  tx := Xv.vns;
  Writeln('Input X Vector.  Use "-" and "+" for input');

  for ii := 1 to X_Length do
  begin {}
    repeat {}
      inchar := ReadKey;
    until (inchar in ['-', '+', '=']); {}

    if (inchar = '=') then {}
    begin
      inchar := '+';
    end;

    Write(inchar);

    case inchar of
      '+': tx^.v := 1;
      '-': tx^.v := -1;
    end; {}

    tx := tx^.nxt;
  end; {FOR}

  Writeln;
  Last_V := 'X';
end; {}

procedure Set_Y_Vector;
{}
var
  inchar: CHAR;
  ty: Vector_node_ptr_;
  ii: Integer;
begin {}
  ty := Yv.vns;
  Writeln('Input Y Vector.  Use "-" and "+" for input');

  for ii := 1 to Y_Length do
  begin {}
    repeat {}
      inchar := ReadKey;
    until (inchar in ['-', '+', '=']); {}
    if (inchar = '=') then {}
    begin
      inchar := '+';
    end;
    Write(inchar);
    case inchar of
      '+': ty^.v := 1;
      '-': ty^.v := -1;
    end; {}
    ty := ty^.nxt;
  end; {FOR}
  Writeln;
  Last_V := 'Y';
end; {}

procedure Recall_X;
{}
const
  A = False;
  S = False;
var
  tx: Vector_node_ptr_;
  ii: Integer;

begin {}
  tx := Xv.vns;
  for ii := 1 to X_length do
  begin {}
    tx^.v := Next_X_Value(tx);
    tx := tx^.nxt;
  end; {}
  {  Display_X (A,S);}
end; {}

procedure Recall_Y;
{}
const
  A = False;
  S = False;
var
  ty: Vector_node_ptr_;
  ii: Integer;
begin {}
  ty := Yv.vns;
  for ii := 1 to Y_length do
  begin {}
    ty^.v := Next_Y_Value(ty);
    ty := ty^.nxt;
  end; {}
  {  Display_Y (A,S);}
end; {}

function Value_symbol(v: Integer): CHAR;
{}
begin {}
  case v of
    1: Value_Symbol := '+';
    -1: Value_symbol := '-';
  end;
end; {}

procedure Dump_weights;
{}
var
  td, ta: Weight_node_ptr_;
  ii, jj: Integer;
begin {}
  if files_open then
    Writeln(Out_weight, 'Weight Matrix');
  td := wm;
  ta := td;
  for ii := 1 to X_Length do
  begin {}
    for jj := 1 to Y_Length do
    begin {}
      if files_open then
        Write(Out_weight, ta^.v: 5: 3, ' ');
      ta := ta^.na;
    end; {}
    td := td^.nd;
    ta := td;
    if files_open then
      Writeln(Out_weight);
  end; {}
end; {}

procedure Recall;
{}
var
  ii: Integer;
begin {}
  for ii := 1 to Max_Iterations do
  begin {}
    case Last_V of
      'X':
        begin {}
          Recall_Y;
          Recall_X;
        end; {}
      'Y':
        begin {}
          Recall_X;
          Recall_Y;
        end; {}
    end;
  end; {}
  Display_X(False, False);
  Display_Y(False, False);
end; {}

procedure Copy_list(var clst, tt: Vector_node_ptr_);
{}
var
  t1, t2: Vector_node_ptr_;
begin {}
  t1 := tt;
  t2 := clst;
  while (t2 <> nil) do
  begin {}
    t1^.v := t2^.v;
    t2 := t2^.nxt;
    t1 := t1^.nxt;
  end; {}
end; {}

procedure Increment(tt: Vector_node_ptr_);
{}
var
  Done: Boolean;
begin {}
  Done := False;
  {toggle v}
  {If v = 1 and nxt <> nil, then next and toggle
   else exit}
  while (not Done) do
  begin {}
    Toggle_Value(tt);
    if (tt^.v = 1) and (tt^.nxt <> nil) then {}
    begin
      tt := tt^.nxt;
    end
    else {}
    begin
      Done := True;
    end;
  end; {}
end; {}

function Done(vt: Vector_node_ptr_): Boolean;
{}
var
  Temp_B: Boolean;
begin {}
  Temp_B := True;
  while (vt <> nil) do
  begin {}
    if (vt^.v = 1) then {}
    begin
      Temp_B := False;
    end;
    vt := vt^.nxt;
  end; {}
  Done := Temp_B;
end; {}

procedure Find_stable;
{}
var
  tx, ty: Vector_node_ptr_;
  tv1, tv2: Vector_node_ptr_;
  ii, jj: Integer;

begin {}
  Allocate_X_Vector(tx);
  tv1 := tx;
  tv2 := Xv.vns;
  {Initialize Template}
  while (tv1 <> nil) do
  begin {}
    tv1^.v := 1;
    tv1 := tv1^.nxt;
  end; {}
  repeat {}
    tv1 := tx;
    Copy_list(Tv1, Tv2);
    Last_V := 'X';
    Recall;
    {Write X, Y to Stable}
    if files_open then
      Write(Out_Stable, 'X then Y ');
    Display_X(False, True);
    if files_open then
      Write(Out_Stable, ' ');
    Display_Y(False, True);
    if files_open then
      Writeln(Out_Stable);
    Increment(tv1);
  until (Done(tv1)); {}
  tv1 := tx;
  Copy_list(Tv1, Tv2);
  Recall;
  {Write X, Y to Stable}
  if files_open then
    Write(Out_Stable, 'X then Y ');
  Display_X(False, True);
  if files_open then
    Write(Out_Stable, ' ');
  Display_Y(False, True);
  if files_open then
    Writeln(Out_Stable);

  {For Y vector}
  Allocate_Y_Vector(ty);
  tv1 := ty;
  tv2 := Yv.vns;
  {Initialize Template}
  while (tv1 <> nil) do
  begin {}
    tv1^.v := 1;
    tv1 := tv1^.nxt;
  end; {}
  repeat {}
    tv1 := ty;
    Copy_list(Tv1, Tv2);
    Last_V := 'Y';
    Recall;
    {Write X, Y to Stable}
    if files_open then
      Write(Out_Stable, 'X then Y ');
    Display_X(False, True);
    if files_open then
      Write(Out_Stable, ' ');
    Display_Y(False, True);
    if files_open then
      Writeln(Out_Stable);
    Increment(tv1);
  until (Done(tv1)); {}
  tv1 := ty;
  Copy_list(Tv1, Tv2);
  Recall;
  {Write X, Y to Stable}
  if files_open then
    Write(Out_Stable, 'X then Y ');
  Display_X(False, True);
  if files_open then
    Write(Out_Stable, ' ');
  Display_Y(False, True);
  if files_open then
    Writeln(Out_Stable);
end; {}

procedure Set_vector_from_file(tv: Vector_node_ptr_);
{}
var
  tt: Vector_node_ptr_;
  inchar: CHAR;
begin {}
  tt := tv;
  while (tt <> nil) do
  begin {}
    READ(In_dat, inchar);
    case inchar of
      '+', '=':
        begin {}
          tt^.v := 1;
        end; {}
      '-':
        begin {}
          tt^.v := -1;
        end; {}
    end;
    tt := tt^.nxt;
  end; {}
end; {}

procedure Set_weights_from_file;
{}
begin {}

  Assign(In_dat, vfilename + '.DAT');
  Reset(In_dat);

  Assign(Out_assoc, vfilename + 'a.bam');
  Rewrite(Out_assoc);

  Assign(Out_weight, vfilename + 'w.bam');
  Rewrite(Out_weight);

  Assign(Out_stable, vfilename + 's.bam');
  Rewrite(Out_stable);

  while (not EOF(In_dat)) do
  begin {}
    Set_vector_from_file(Xv.vns);
    Set_vector_from_file(Yv.vns);
    Readln(In_dat);
    Set_weights;
  end; {}
  Close(IN_dat);

end; {}

procedure Driver;
{}
begin {}
  Writeln;
  Writeln('Bidirectional Associative Memory program');
  Writeln('Copyright 1988 by Wesley R. Elsberry');
  Writeln(' All Rights Reserved');
  Writeln;

  {Initialize}
  files_open := False;

  {BAM Choices}
    {Set up BAM}

  repeat {}
    {Set X vector length}
    Write('Length of X vector? : ');
    Readln(X_length);
    Writeln;
  until (x_length >= 1); {}

  repeat {}
    {Set Y vector length}
    Write('Length of Y vector? : ');
    Readln(Y_length);
    Writeln;
  until (Y_length >= 1); {}

  {Allocate vectors}
  Allocate_X_vector(Xv.vns);
  Allocate_Y_vector(Yv.vns);

  {Allocate Weight matrix}
  Allocate_Weight_matrix;

  { Display_links is handy for debugging}
  {      Display_links;}

  repeat {}
    {Set associative weights}
    Writeln;
    Write('Set (X), (Y), (S)et weight, (G)et from file, (H)elp, or (Q)uit setup: ');
    Readln(inchar);

    case inchar of
      'X', 'x':
        begin {}
          Set_X_vector;
        end; {}
      'Y', 'y':
        begin {}
          Set_Y_vector;
        end; {}
      'S', 's':
        begin {}
          Set_weights;
        end; {}
      'G', 'g':
        begin {}
          Write('File to get vectors from? : ');
          Readln(vfilename);
          files_open := True;
          Set_Weights_from_File;
        end; {}
      'H', 'h':
        begin
          Writeln;
          Writeln('Set (X), (Y) :  These allow you to interactively enter values for X and Y');
          Writeln('                vector pairs.  The weights for the association between  ');
          Writeln('                these is not set until the (S)et weights option is used.');
          Writeln('                Thus, errors in entry can be corrected by recalling the');
          Writeln('                same vector entry routine again before setting weights.');
          Writeln('(S)et weights : This option records an association between the current');
          Writeln('                values of the X and Y vectors, storing this association');
          Writeln('                in a set of weights between the nodes of the network.');
          Writeln('(G)et from file :  This allows a textfile containing vector pairs to be');
          Writeln('                read and weights recorded for each.');
          Writeln('(H)elp  :       This help screen.');
          Writeln('(Q)uit setup  : After the BAM network has the sets of vectors which you');
          Writeln('                wish to train it to, you may leave the setup mode and');
          Writeln('                proceed to an interactive recall session, where you may');
          Writeln('                specify the X and/or Y vector(s) and examine the recalled');
          Writeln('                pattern.');
          Writeln;
        end;
    end;
  until (inchar = 'Q') or (inchar = 'q'); {}

  repeat {}
    {Choice: Set, Recall, Quit}
    Writeln;
    Write('Set (X), (Y), (R)ecall, or (Q)uit simulation : ');
    Readln(inchar);
    case inchar of
      'X', 'x':
        begin {}
          Set_X_vector;
        end; {}
      'Y', 'y':
        begin {}
          Set_Y_vector;
        end; {}
      'R', 'r':
        begin {}
          Recall;
        end; {}
    end;
  until (inchar = 'Q') or (inchar = 'q'); {}

  Writeln;
  Writeln('Weights and Stable States ... ');
  Writeln;

  Dump_weights;
  Find_stable;

  Writeln('End of BAM program, exiting to DOS');

  if files_open then
  begin
    Flush(Out_assoc);
    Flush(Out_weight);
    Flush(Out_stable);
    Close(Out_assoc);
    Close(Out_weight);
    Close(Out_stable);
  end;
end; {}

begin {MAIN}
  Driver;
end. {MAIN}

