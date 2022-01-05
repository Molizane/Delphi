program evolve_simple_nets;

{
 These units implement some routines used in the program. 'Graph' is for
 any graphical operation such as 'Circle' and 'InitGraph' etc. 'Dos' is
 only used for the FindFirst and FindNext functions which search for
 filenames on the disc and 'Crt' is used for functions such as ReadKey
}

uses
  SysUtils, CRT32;

const
  MAX_INPS = 4; {Maximum number of inputs for each node}
  MAX_OP_NODES = 2; {Maximum number of nodes in output layer}
  MAX_POP = 80; {Maximum number of variants at any one time}
  MAX_TRAIN_DATA = 40; {Max. number of IP/OP training data pairs}
  SCREEN_LEN = 22; {For editing test data pairs}
  MAX_BEST = 5; {Number of networks used for breeding}

type
  wd8 = string[8];
  wd12 = string[12];

  node = record
    out: real;
    w: array[1..MAX_INPS] of real; {Weights for feeder nodes}
    threshold: real
  end;

  network = record
    ol: array[1..MAX_OP_NODES] of node;
    hl, il: array[1..MAX_INPS] of node
  end;

  netptr = ^network;
  pop_type = array[1..MAX_POP] of netptr; {Tracks changing population}

  train_type = record {Pairs of IP and OP data}
    used: boolean; {True if this pair assigned}
    ins: array[1..MAX_INPS] of real;
    outs: array[1..MAX_OP_NODES] of real
  end;

  train_pop_type = array[1..MAX_TRAIN_DATA] of train_type;

var
  population: pop_type;
  path: string; {Path for loading/saving}
  train_data: train_pop_type;
  choice: byte;
  scores: array[1..MAX_POP] of real; {How well the networks do, low=good}
  best: array[1..MAX_BEST] of byte;
  best_score: array[1..MAX_BEST] of real;
  generation: longint;
  tempnet: network;
  tempdata: byte;
  display_running_values: boolean; {True if sum error totals are displayed
  during training}
  maxx, maxy: integer; {Maximum screen co-ordinates in graph mode}
  mousex, mousey: integer; {Mouse co-ordinates}
  left_button, right_button: boolean; {Mouse button status}
  gd, gm: integer; {Graphics driver and mode variables (only used in
  graphics mode}

{THESE PROCEDURES ARE FOR HANDLING THE MOUSE}

procedure initmouse;
var
  regs: registers;
begin
  regs.ax := 0;
  intr($33, regs);
  regs.ax := 1;
  intr($33, regs)
end;

procedure mouse;
var
  c: char;
  regs: registers;

  procedure movecursor(xinc, yinc: integer);
  begin
    Inc(mousex, xinc);
    Inc(mousey, yinc)
  end;
begin
  regs.ax := $3;
  intr($33, regs);
  mousex := regs.cx;
  mousey := regs.dx;
  left_button := ((regs.bx and 1) = 1);
  right_button := ((regs.bx and 2) > 0)
end;

procedure showmouse;
var
  regs: registers;
begin
  regs.ax := $1;
  intr($33, regs)
end;

procedure hidemouse;
var
  regs: registers;
begin
  regs.ax := $2;
  intr($33, regs)
end;

function yn: boolean;
var
  x: byte;
begin
  repeat
    x := Pos(ReadKey, 'YyNn')
  until x > 0;

  yn := (x < 3)
end;

procedure title(s: string);
begin
  ClrScr;
  TextColor(yellow);
  write('               ', s);
  writeln;
  TextColor(LightGray)
end;

function get_char: char;
var
  c: char;
begin
  c := UpCase(ReadKey);

  if c = #0 then
    c := chr(100 + ord(ReadKey));

  get_char := c
end;

{THE FOLLOWING PROCEDURES ARE FOR CREATING/EDITING TRAINING DATA}

{Procedure to mark all training data as not used}

procedure cancel_data;
var
  i, j: byte;
begin
  for i := 1 to MAX_TRAIN_DATA do
    with train_data[i] do
    begin
      used := false;

      for j := 1 to MAX_INPS do
        ins[j] := 0;

      for j := 1 to MAX_OP_NODES do
        outs[j] := 0
    end
end;

procedure show_cursor(cursor, colour: byte);
begin
  TextColor(colour);
  GotoXY(1 + 6 * ((cursor - 1) div SCREEN_LEN), 3 + (cursor - 1) mod SCREEN_LEN);
  write('>');
  TextColor(LightGray)
end;

{Display some text at position x,y in graphics mode}

procedure at(x, y: integer; s: string);
begin
  OutTextXY(x, y, s)
end;

{Display the inputs and outputs for training data set 'd'}

procedure display_training_set_data(d: byte);
var
  i: byte;
begin
  at(19, 6, 'These represent');
  at(19, 7, 'the INPUTS.');
  at(50, 6, 'These represent');
  at(50, 7, 'the OUTPUTS.');

  with train_data[d] do
  begin
    for i := 1 to MAX_INPS do
    begin
      GotoXY(20, 10 + i);
      write(ins[i])
    end;

    for i := 1 to MAX_OP_NODES do
    begin
      GotoXY(50, 10 + i);
      write(outs[i])
    end
  end
end;

procedure display_train_menu(cursor: byte);
var
  i: byte;
begin
  title('Enter/amend training data');

  for i := 1 to MAX_TRAIN_DATA do
  begin
    GotoXY(2 + 6 * ((i - 1) div SCREEN_LEN), 3 + (i - 1) mod SCREEN_LEN);

    if train_data[i].used then
    begin
      TextColor(LightMagenta);
      write('Used')
    end
    else
    begin
      TextColor(LightCyan);
      write('Free')
    end
  end;

  TextColor(LightGreen);
  GotoXY(1, 25);
  write('Arrow keys to move, E=edit/create test data pair, L,S to load/save data, Q=quit');
  show_cursor(cursor, yellow);
  display_training_set_data(cursor)
end;

{Function to convert a string (assumed a valid number) into a real value. If
 the string is not a valid number, the value returned is 0}

function r_value(s: string): real;
var
  error: integer;
  x: real;
begin
  Val(s, x, error);

  if (error > 0) or (s = '') then
    r_value := 0
  else
    r_value := x
end;

{Procedure to edit training data pair 'd'}

procedure edit_data(d: byte);
var
  k: char;
  i, cursor, cursor_col: byte;
  s: string;

  function st(x: byte): string;
  var
    s: string;
  begin
    Str(x, s);
    st := s
  end;

  procedure show_cursor(colour: byte);
  begin
    TextColor(colour);
    GotoXY(cursor_col, cursor + 10);
    write('>')
  end;
begin
  cursor := 1;
  cursor_col := 19;
  TextColor(LightRed);
  at(1, 25, '           Use Arrow keys to select data items, D when Done                    ');
  show_cursor(yellow);

  with train_data[d] do
  begin
    used := true;

    repeat
      k := get_char;

      case k of
        #175, #177:
          begin
            show_cursor(black);
            cursor_col := 68 - cursor_col;
            cursor := 1;
            show_cursor(yellow)
          end;
        #172:
          if cursor > 1 then
          begin
            show_cursor(black);
            Dec(cursor);
            show_cursor(yellow)
          end;
        #180:
          if (cursor_col = 19) and (cursor < MAX_INPS) or
            (cursor_col = 49) and (cursor < MAX_OP_NODES) then
          begin
            show_cursor(black);
            Inc(cursor);
            show_cursor(yellow)
          end;
        '-', '.', '0'..'9':
          begin
            GotoXY(cursor_col + 2, 10 + cursor);
            write(k + '               ');
            GotoXY(cursor_col + 3, 10 + cursor);
            readln(s);
            s := k + s;

            if cursor_col = 19 then
              ins[cursor] := r_value(s)
            else
              outs[cursor] := r_value(s)
          end
      end
    until k = 'D'
  end
end;

{Procedure to load a set of training data (extn='TRN') or a population of
 networks (extn='NET')}

procedure load_train_data_or_nets(extn: string);
var
  file_selected: boolean;
  fn: array[1..6, 1..17] of wd12; {Store names of files}
  f: file of train_type; {In case it's training data}
  g: file of network; {In case it's networks}
  i, cursorx, cursory, maxx, maxy: byte;
  k: char;
  path: string;
  tempnet: network;
  searchfile: TSearchRec;

  procedure move_cursor(x, y: shortint);
  begin
    GotoXY(cursorx * 13 - 12, cursory + 3);
    write(' ');
    Inc(cursorx, x);
    Inc(cursory, y);
    GotoXY(cursorx * 13 - 12, cursory + 3);
    write('>')
  end;

  procedure display_files;
  var
    cy: byte;
  begin
    maxx := 1;
    cy := 1;

    if findfirst(path + '*.' + extn, faAnyFile, searchfile) = 0 then
      while {(DosError <> 18) and}((maxx < 63) or (cy < 17)) do
      begin
        GotoXY(maxx * 13 - 11, cy + 3);
        TextColor(yellow);
        write(searchfile.name);
        fn[maxx, cy] := searchfile.name;

        if cy < 17 then
          Inc(cy)
        else
        begin
          Inc(maxx);
          cy := 1
        end;

        if findnext(searchfile) <> 0 then
          Break;
      end;

    cursorx := 1;
    cursory := 1;
    move_cursor(0, 0)
  end;
begin
  file_selected := false;
  path := '';
  title('Load a set of training data');
  display_files;
  cursorx := 1;
  cursory := 1;

  repeat
    k := get_char;

    case k of
      #177:
        if cursorx < maxx then
          move_cursor(1, 0);
      #175:
        if cursorx > 1 then
          move_cursor(-1, 0);
      #172:
        if cursory > 1 then
          move_cursor(0, -1);
      #180:
        if cursory < 17 then
          move_cursor(0, 1);
      ' ', #13:
        file_selected := true
    end
  until (k = 'Q') or file_selected;

  if k = 'Q' then
    exit; {Chosen not to load a file}

  if extn = 'TRN' then
  begin
    assign(f, fn[cursorx, cursory]);
    reset(f);

    for i := 1 to MAX_TRAIN_DATA do
      read(f, train_data[i]);

    Close(f)
  end
  else
  begin
    assign(g, fn[cursorx, cursory]);
    reset(g);

    for i := 1 to MAX_POP do
    begin
      read(g, tempnet);
      population[i]^ := tempnet
    end;

    Close(g)
  end
end;

{Procedure to save a set of training data}

procedure save_train_data;
var
  fname: wd12;
  f: file of train_type;
  i: byte;

  function get_file_name: wd12;
  var
    s: string;
  begin
    repeat
      GotoXY(10, 12);
      write('Please enter the file name :                       ');
      GotoXY(39, 12);
      readln(s);
    until (Length(s) < 9) and (s <> '') and (Pos('.', s) = 0);

    get_file_name := s + '.TRN'
  end;
begin
  title('Save a set of training data');
  fname := get_file_name;
  assign(f, fname);
  {$I-}
  reset(f);
  {$I+}

  if ioresult = 0 then
  begin
    Close(f);
    TextColor(LightRed + Blink);
    GotoXY(15, 15);
    write('That file exists already. Shall I replace it? (Y/N)', #7);

    if not yn then
      exit
  end;

  {$I-}
  rewrite(f);
  {$I+}

  if ioresult <> 0 then
  begin
    TextColor(LightCyan + Blink);
    GotoXY(15, 17);
    writeln('An error ocurred when I tried to open that file!', #7);
    GotoXY(30, 18);
    TextColor(LightBlue);
    write('Press the SPACE BAR');

    repeat until ReadKey = ' ';

    exit
  end;

  for i := 1 to MAX_TRAIN_DATA do
    write(f, train_data[i]);

  Close(f)
end;

{Procedure to enter training data in the form of inputs-outputs pairs}

procedure enter_training_data;
var
  i, cursor: byte;
  k: char;

  procedure move_cursor(increment: shortint);
  begin
    show_cursor(cursor, black);
    Inc(cursor, increment);
    show_cursor(cursor, yellow);
    display_training_set_data(cursor)
  end;
begin
  display_train_menu(1);
  cursor := 1;
  display_training_set_data(1);

  repeat
    k := get_char;

    case k of
      #180:
        if cursor < MAX_TRAIN_DATA then
          move_cursor(1);
      #172:
        if cursor > 1 then
          move_cursor(-1);
      #177:
        if cursor < MAX_TRAIN_DATA - (SCREEN_LEN - 1) then
          move_cursor(SCREEN_LEN);
      #175:
        if cursor > SCREEN_LEN then
          move_cursor(-SCREEN_LEN);
      'E':
        begin
          edit_data(cursor);
          display_train_menu(cursor)
        end;
      'S':
        begin
          save_train_data;
          display_train_menu(cursor)
        end;
      'L':
        begin
          load_train_data_or_nets('TRN');
          display_train_menu(cursor)
        end
    end
  until k = 'Q'
end;

{THE FOLLOWING PROCEDURES ARE FOR CREATING/RUNNING/EVOLVING NETWORKS}

{Function to create a network with num_op_nodes nodes in the outer layer. It
fills the weights and thresholds with random values. It returns a pointer to
that network}

function create_network: netptr;
var
  n: netptr;
  i: byte;

  procedure do_random(var n: node);
  var
    j: byte;
  begin
    with n do
    begin
      for j := 1 to MAX_INPS do
        w[j] := random(1000) / 1000;

      threshold := random(1000) / 1000
    end
  end;
begin
  new(n);

  with n^ do
  begin
    for i := 1 to MAX_OP_NODES do
      do_random(ol[i]);

    for i := 1 to MAX_INPS do
      do_random(hl[i]);

    for i := 1 to MAX_INPS do
      do_random(il[i])
  end;

  create_network := n
end;

{Procedure to set up all the population networks with random numbers}

procedure randomise_nets;
var
  i: byte;
begin
  for i := 1 to MAX_POP do
    population[i] := create_network
end;

{Get the name of the file to save the population of networks under}

function get_save_file_name: wd8;
var
  searchfile: TSearchRec;
  fname: wd8;
begin
  ClrScr;

  if FindFirst('*.NET', faAnyFile, searchfile) = 0 then
    repeat
      with searchfile do
      begin
        while Length(name) < 12 do
          name := name + ' ';

        write(name, '    '); {Pads it out to 16 bytes so 5 fit on screen}
      end;
    until FindNext(searchfile) <> 0;

  GotoXY(1, 23);
  write('Enter file to save the networks under : ');
  readln(fname);

  {Remove .XXX from the name as .NET is added later}
  if Pos('.', fname) > 0 then
    fname := Copy(fname, 1, Pos('.', fname) - 1);

  get_save_file_name := fname
end;

{Procedure to save a given population of networks to disk with a name ending
 in .NET}

procedure save_net(fname: wd12);
var
  f: file of network;
  i: byte;
begin
  assign(f, fname + '.NET');
  {$I-}
  rewrite(f);
  {$I+}

  for i := 1 to MAX_POP do
    write(f, population[i]^);

  Close(f)
end;

{Procedure to run a single network with a single set of training data}

procedure run_network(var net: network; train: train_type);
var
  i, j: byte;

  function f(x: real): real;
  begin
    if abs(x) < 38 {Handle possible overflow} then
      f := 1 / (1 + exp(-x)) {exp only valid between -39 and 38}
    else if x >= 38 then
      f := 1
    else
      f := 0
  end;
begin
  with net do
  begin
    for i := 1 to MAX_INPS do
      with il[i] do
      begin
        out := 0;

        for j := 1 to MAX_INPS do
          out := out + w[j] * train.ins[j];

        out := f(out - threshold)
      end;

    for i := 1 to MAX_INPS do
      with hl[i] do
      begin
        out := 0;

        for j := 1 to MAX_INPS do
          out := out + w[j] * il[j].out;

        out := f(out - threshold)
      end;

    for i := 1 to MAX_OP_NODES do
      with ol[i] do
      begin
        out := 0;

        for j := 1 to MAX_INPS do
          out := out + w[j] * hl[j].out;

        out := f(out - threshold)
      end
  end
end;

{Function to score a single network against a single set of training data.
 It returns the absolute difference between the network's output and the
 expected output, with a perfect match giving a score of 0}

function score_net(net: network; train: train_type): real;
var
  score_val: real;
  i: byte;
begin
  score_val := 0;

  for i := 1 to MAX_OP_NODES do
    score_val := score_val + abs(net.ol[i].out - train.outs[i]);

  score_net := score_val
end;

{Procedure to run the population of networks on all the current sets of
 training data}

procedure run_population;
var
  i, j: byte; {i steps through the networks, j steps through training data}
begin
  for i := 1 to MAX_POP do
  begin
    scores[i] := 0;

    for j := 1 to MAX_TRAIN_DATA do
      if train_data[j].used {ignore invalid ones} then
      begin
        run_network(population[i]^, train_data[j]);
        scores[i] := scores[i] + score_net(population[i]^,
          train_data[j])
      end;

    if display_running_values then
    begin
      case i of
        1..20:
          GotoXY(1, i);
        21..40:
          GotoXY(18, i - 20);
        41..60:
          GotoXY(35, i - 40);
        61..80:
          GotoXY(52, i - 60)
      end;

      write(scores[i])
    end
  end;

  GotoXY(60, 22);
  write('Generation ', generation)
end;

{Procedure to find the five best members of the population. They are stored in
 arrays BEST (the index of the member) and the BEST_SCORE (the value itself)}

procedure find_best;
var
  i, j, k, temp_b: byte;
  temp_r: real;
begin
  for i := 1 to MAX_BEST do
    best[i] := 255; {Indicate slot not filled}

  for i := 1 to MAX_POP do
    if (scores[i] < best_score[MAX_BEST]) or (best[MAX_BEST] = 255) then
    begin
      best_score[MAX_BEST] := scores[i];
      best[MAX_BEST] := i;

      for j := MAX_BEST downto 2 do
        if (best_score[j] < best_score[j - 1]) or (best[j - 1] = 255) then
        begin
          k := j - 1;
          temp_b := best[j];
          best[j] := best[k];
          best[k] := temp_b;
          temp_r := best_score[j];
          best_score[j] := best_score[k];
          best_score[k] := temp_r
        end
    end
end;

{Procedure to breed from the MAX_BEST most successful networks}

procedure breed;
const
  NUM_BABIES = (MAX_POP - MAX_BEST) div MAX_BEST;
var
  i, j, index: byte;

  function one_of_the_best(x: byte): boolean;
  var
    i: byte;
  begin
    one_of_the_best := false;

    for i := 1 to MAX_BEST do
      if best[i] = x then
        one_of_the_best := true
  end;

  procedure mutate_node(n1: node; var n2: node);
  var
    j: byte;
    x: real;
  begin
    for j := 1 to MAX_INPS do
    begin
      x := random(10) / 1000;

      if random(2) = 1 then
        x := -x;

      n2.w[j] := n1.w[j] + x
    end;

    x := random(10) / 1000;

    if random(2) = 1 then
      x := -x;

    n2.threshold := n1.threshold + x
  end;

  procedure mutate(m: network; var n: network); {Mutate m into n}
  var
    i, j: byte;
  begin
    with m do
    begin
      for i := 1 to MAX_OP_NODES do
        mutate_node(ol[i], n.ol[i]);

      for i := 1 to MAX_INPS do
      begin
        mutate_node(hl[i], n.hl[i]);
        mutate_node(il[i], n.il[i])
      end
    end
  end;
begin
  index := 0;

  for i := 1 to MAX_BEST do
    for j := 1 to NUM_BABIES do
    begin
      repeat
        Inc(index)
      until (index > MAX_POP) or not one_of_the_best(index);

      mutate(population[best[i]]^, population[index]^)
    end
end;

procedure evolve_population;
var
  k: char;
begin
  generation := 1;
  display_running_values := true;
  k := '*'; {Dummy value}

  repeat
    run_population;
    find_best;

    if generation mod 500 = 0 then
      save_net('TEMPNET');

    Inc(generation);
    breed;

    if keypressed then
      k := UpCase(ReadKey)
    else
      k := '*';

    if k = 'D' then
      display_running_values := not display_running_values
  until k = ' '
end;

function r_str(x: real): string;
var
  s: string;
begin
  Str(x, s);
  r_str := s
end;

{Create a button at a given x,y position in graphics mode}

procedure button(x, y: integer; caption: string);
var
  w, h: integer; {Width and height}
begin
  w := TextWidth(caption) + 4;
  h := TextHeight(caption) + 4;
  SetColor(yellow);
  OutTextXY(x + 2, y + 2, caption);
  SetColor(Red);
  Rectangle(x, y, x + w, y + h)
end;

{Display a network. sp and sp2 are spacing values. 'which' specifies the index
 of the network. 'test_data' specifies the index of the test data in the array.}

procedure draw_net(sp, sp2: word; which: network; test_data: byte);
var
  i, j: byte;
begin
  hidemouse;

  for i := 1 to MAX_INPS do
    for j := 1 to 2 do
      circle(150 * j, 25 + (i - 1) * SP, 5);

  for i := 1 to MAX_INPS do
    for j := 1 to MAX_INPS do
      line(155, 25 + (i - 1) * SP, 295, 25 + (j - 1) * SP);

  for i := 1 to MAX_OP_NODES do
    circle(450, 25 + (i - 1) * SP2, 5);

  for i := 1 to MAX_INPS do
    for j := 1 to MAX_OP_NODES do
      line(305, 25 + (i - 1) * SP, 445, 25 + (j - 1) * SP2);

  button(0, 0, 'EXIT');
  SetColor(white);
  OutTextXY(3, maxy - 13, 'Next network');

  if test_data > 0 then
    with train_data[test_data] do
    begin
      SetColor(LightGreen);
      OutTextXY(500, 1, 'Actual');
      SetColor(LightCyan);
      OutTextXY(560, 1, 'Desired');
      SetColor(white);

      for i := 1 to MAX_INPS do
        OutTextXY(1, 20 + (i - 1) * SP, r_str(ins[i]));

      for i := 1 to MAX_OP_NODES do
      begin
        SetColor(LightGreen);
        OutTextXY(500, 20 + (i - 1) * SP2, r_str(which.ol[i].out));
        SetColor(LightCyan);
        OutTextXY(500, 30 + (i - 1) * SP2, r_str(outs[i]))
      end
    end;

  showmouse
end;

{Procedure to draw and fill a rectangle with co-ordinates x1,y1 and x2,y2.
 FillPoly is used to draw the rectangle as FloodFill sometimes does not get
 the right boundaries}

procedure FillRectangle(x1, y1, x2, y2: integer; colour: word);
var
  p: array[1..5] of PointType;
begin
  p[1].x := x1;
  p[1].y := y1;
  p[2].x := x1;
  p[2].y := y2;
  p[3].x := x2;
  p[3].y := y2;
  p[4].x := x2;
  p[4].y := y1;
  p[5] := p[1];
  SetColor(colour);
  SetFillStyle(SolidFill, colour);
  FillPoly(5, p)
end;

{Procedure to go into EGA graphics mode}

procedure intographix;
begin
  gd := 3; {EGA graphics mode}
  gm := 1;
  InitGraph(gd, gm, '');
  maxx := GetMaxX;
  maxy := GetMaxY
end;

procedure show_single_net(which: network; test_data: byte);
const
  SP = 300 div MAX_INPS;
  SP2 = 300 div MAX_OP_NODES;
var
  layer_selected, node_selected: byte;
  i: byte;
  exit_chosen, show_actual: boolean;
  x, y: integer;

  procedure show_values(which_layer, which_node: byte);
  var
    save_rectangle: pointer;
    height: integer;
    i: byte;
    x: real;
    size: word;
  begin
    hidemouse;
    height := 10 * MAX_INPS + 10;
    size := ImageSize(100, 50, 500, 50 + height);
    GetMem(save_rectangle, size);
    GetImage(100, 50, 500, 50 + height, save_rectangle^);
    fillrectangle(100, 50, 500, 50 + height, black);
    SetColor(LightRed);
    Rectangle(100, 50, 500, 50 + height);
    SetColor(yellow);

    with which do
    begin
      for i := 1 to MAX_INPS do
      begin
        case which_layer of
          1:
            x := il[which_node].w[i];
          2:
            x := hl[which_node].w[i];
          3:
            x := ol[which_node].w[i]
        end;

        OutTextXY(120, 45 + 10 * i, r_str(x))
      end;

      case which_layer of
        1:
          x := il[which_node].threshold;
        2:
          x := hl[which_node].threshold;
        3:
          x := ol[which_node].threshold
      end
    end;

    OutTextXY(320, 55, 'Threshold');
    OutTextXY(320, 65, r_str(x));
    OutTextXY(280, 85, 'Press right mouse button');

    repeat
      mouse
    until right_button;

    SetColor(white);
    PutImage(100, 50, save_rectangle^, NormalPut);
    FreeMem(save_rectangle, size);
    showmouse
  end;
begin
  intographix;
  initmouse;
  exit_chosen := false;
  show_actual := true;

  repeat
    draw_net(SP, SP2, which, test_data);
    x := -1;
    y := -1;
    layer_selected := 0;

    repeat
      mouse;

      if left_button then
      begin
        x := mousex;
        y := mousey
      end;

      if (x > 0) and (y > 0) and (x < 40) and (y < 15) then
        exit_chosen := true;

      if (x > 0) and (x < 50) and (y > maxy - 13) then
      begin
      end;

      for i := 1 to MAX_INPS do
        if (y > (i - 1) * SP + 20) and (y < (i - 1) * SP + 30) then
        begin
          if (x > 145) and (x < 155) then
          begin
            layer_selected := 1;
            node_selected := i
          end;

          if (x > 295) and (x < 305) then
          begin
            layer_selected := 2;
            node_selected := i
          end
        end;

      if (x > 445) and (x < 455) then
        for i := 1 to MAX_OP_NODES do
          if (y > (i - 1) * SP2 + 20) and (y < (i - 1) * SP2 + 30) then
          begin
            layer_selected := 3;
            node_selected := i
          end
    until (layer_selected > 0) or exit_chosen;

    if layer_selected > 0 then
      show_values(layer_selected, node_selected)
  until exit_chosen;

  CloseGraph
end;

{Function to get a string input at position x,y and maximum length m. 'm'
 squares are printed on the screen, but the routine doesn't check to see if
 the user types in more than 'm' characters.}

function getstring(x, y, m: byte): string;
var
  s: string;
  i: byte;
  k: char;
begin
  GotoXY(x, y);

  for i := 1 to m do
    write('°');

  GotoXY(x, y);
  s := '';
  write(s);

  repeat
    k := ReadKey;

    case k of
      #32..#126:
        if Length(s) < m then
        begin
          s := s + k;
          write(k)
        end
        else
          write(^G);
      chr(127), chr(8):
        if Length(s) > 0 then
        begin
          write(chr(8), '°', chr(8));

          if Length(s) > 1 then
            s := Copy(s, 1, Length(s) - 1)
          else
            s := ''
        end
        else
          write(^G)
    end
  until k = chr(13);

  getstring := s
end;

{Function to get the user to type in a number of maximum 'm' digits at
 position x,y}

function get_value(x, y, m: byte): longint;
var
  s: string;
  v: longint;
  error: integer;
begin
  repeat
    s := getstring(x, y, m);
    Val(s, v, error);

    if error > 0 then
      write(^G)
  until error = 0;

  get_value := v
end;

function which_net(message: string): byte;
var
  which: byte;
begin
  repeat
    ClrScr;
    GotoXY(30, 12);
    write(message, ' which net? : ');
    which := get_value(45 + Length(message), 12, 2)
  until (which > 0) and (which <= MAX_POP);

  which_net := which
end;

function which_data: byte;
var
  which: byte;
begin
  repeat
    ClrScr;
    GotoXY(20, 12);
    write('Apply which set of test data? : ');
    which := get_value(52, 12, 2);
  until (which > 0) and (which <= MAX_TRAIN_DATA);

  which_data := which
end;

procedure main_menu;
begin
  title('Neural networks - Training through natural selection');
  writeln;
  writeln('                  by Richard Bowles');
  writeln;
  writeln('     0. Quit.');
  writeln;
  writeln('     1. Enter/amend training data.');
  writeln;
  writeln('     2. Evolve the population of networks on the training set.');
  writeln;
  writeln('     3. View/edit the networks');
  writeln;
  writeln('     4. Load a population of networks.');
  writeln;
  writeln('     5. Run a given network with a given set of test data.');
  writeln;
  writeln('     6. Save the population of networks.');

  repeat
    choice := ord(ReadKey) - 48
  until (choice >= 0) and (choice < 7)
end;

begin
  randomize;
  randomise_nets;
  cancel_data;

  repeat
    main_menu;

    case choice of
      1:
        enter_training_data;
      2:
        evolve_population;
      3:
        show_single_net(population[which_net('View')]^, 0);
      4:
        load_train_data_or_nets('NET');
      5:
        begin
          tempnet := population[which_net('Run')]^;
          tempdata := which_data;
          run_network(tempnet, train_data[tempdata]);
          show_single_net(tempnet, tempdata)
        end;
      6:
        save_net(get_save_file_name)
    end
  until choice = 0
end.

