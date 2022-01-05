{
This is the source code for the simple neural network written in Turbo Pascal 6.0.
The simplest way to download this file is to go the 'View Source Code' option of
your browser and select the 'Save' option from the file menu. It should
run without any changes. (Ignore the HTML and PRE tokens below - this is just to
ensure that your Web browser doesn't mess around with the text formatting
}
program simple_neural_net;

uses
  Crt32; {This is a unit which contains the ReadKey routine. If you can implement this a different way, you won't need this line}

const
  MAX_INP = 4; {Maximum number of nodes in input layer}
  MAX_HID = 4; {Maximum number of nodes in hidden layer}
  MAX_OUT = 2; {Maximum number of nodes in output layer}

  MAX_PAT = 4; {Maximum number of training patterns}

  {
   These two arrays contain the training input patterns and the
   corresponding output patterns. In this case they form a binary
   encoder, changing 0010 into 01 and 1000 into 11 etc. but feel
   free to change them into anything else you want. That is why they
   are arrays of Real values rather than bytes or integers
  }

  INP_PATTERNS: array[1..MAX_PAT, 1..MAX_INP] of Real48 =
  ((0, 0, 0, 1), (0, 0, 1, 0), (0, 1, 0, 0), (1, 0, 0, 0));

  OUT_PATTERNS: array[1..MAX_PAT, 1..MAX_OUT] of Real48 =
  ((0, 0), (0, 1), (1, 0), (1, 1));

type
  {An array to hold any input patterns that are used for training or typed in}
  inp_pattern_type = array[1..MAX_INP] of Real48;

  {An array for holding output patterns}
  out_pattern_type = array[1..MAX_OUT] of Real48;

  {All neurons are defined as having MAX_INP weights from the previous layer, an output value and a threshold}
  weights_type = array[1..MAX_INP] of Real48;

  neuron_type = record
    w: weights_type; {The actual weights themselves}
    change: weights_type; {Changes in weights - used in
    training only}
    threshold, a: Real48;
    t_change: Real48; {Change in threshold - used in
    training only}
    E: Real48 {Error for this node, used in}
  end; {training}

var
  test_pat: inp_pattern_type;
  desired: out_pattern_type;
  ipl: array[1..MAX_INP] of neuron_type; {Input layer}
  hl: array[1..MAX_HID] of neuron_type; {Hidden layer}
  ol: array[1..MAX_OUT] of neuron_type; {Output layer}

  {Ask the user whether to continue or not. Returns true or false}

function continue: boolean;
var
  k: char;
begin
  writeln;
  writeln('     Do you want another test pattern? (Press Y or N)');

  repeat
    k := ReadKey
  until (k = 'Y') or (k = 'y') or (k = 'N') or (k = 'n');

  continue := (k = 'Y') or (k = 'y');
end;

{Ask the user to type a pattern which is to be used for testing}

procedure get_test_pattern;
var
  i: byte;
begin
  writeln;
  writeln('Please enter the values for the test pattern.');
  writeln('You should type in ', MAX_INP, ' values (press Enter after each one).');

  for i := 1 to MAX_INP do
  begin
    write('    Please enter value ', i, ' : ');
    readln(test_pat[i])
  end
end;

{THE FOLLOWING PROCEDURES ARE FOR RUNNING THE NETWORK (FORWARD PROPAGATION)}

function sigmoid(x: Real48): Real48;
begin
  if abs(x) < 38 {Handle possible overflow} then
    sigmoid := 1 / (1 + exp(-x)) {exp only valid between -39 and 38}
  else if x >= 38 then
    sigmoid := 1
  else
    sigmoid := 0
end;

procedure run_input_layer;
var
  i, j: byte;
  sum: Real48;
begin
  for i := 1 to MAX_INP do
    with ipl[i] do
    begin
      sum := 0;

      for j := 1 to MAX_INP do
        sum := sum + w[j] * test_pat[j];

      a := sigmoid(sum - threshold)
    end
end;

procedure run_hidden_layer;
var
  i, j: byte;
  sum: Real48;
begin
  for i := 1 to MAX_HID do
    with hl[i] do
    begin
      sum := 0;

      for j := 1 to MAX_INP do
        sum := sum + w[j] * ipl[j].a;

      a := sigmoid(sum - threshold)
    end
end;

procedure run_output_layer;
var
  i, j: byte;
  sum: Real48;
begin
  for i := 1 to MAX_OUT do
    with ol[i] do
    begin
      sum := 0;

      for j := 1 to MAX_HID do
        sum := sum + w[j] * hl[j].a;

      a := sigmoid(sum - threshold)
    end
end;

procedure run_the_network;
begin
  run_input_layer;
  run_hidden_layer;
  run_output_layer
end;

{This procedure displays the results of the test on the screen.}

procedure display_the_results;
var
  i: byte;
begin
  writeln;
  write('Inputs: ');

  for i := 1 to MAX_INP do
    write(test_pat[i]:3:2, ' ');

  writeln;
  write('Outputs: ');

  for i := 1 to MAX_OUT do
    write(ol[i].a:3:2, ' ');

  writeln;
end;

{THE FOLLOWING PROCEDURES ARE FOR TESTING THE NETWORK EITHER BEFORE OR AFTER TRAINING}

procedure test_the_network;
begin
  writeln;
  writeln('I will ask you for test patterns. At the end of each test you will');
  writeln('be asked if you want to do another test.');

  repeat
    get_test_pattern;
    run_the_network;
    display_the_results
  until not continue
end;

{THE FOLLOWING PROCEDURES ARE FOR TRAINING THE NETWORK}

procedure calculate_output_layer_errors;
var
  j: byte;
begin
  for j := 1 to MAX_OUT do
    with ol[j] do
      E := (desired[j] - a) * a * (1 - a)
end;

procedure calculate_hidden_layer_errors;
var
  i, j: byte;
  sum: Real48;
begin
  for i := 1 to MAX_HID do
    with hl[i] do
    begin
      sum := 0; {Find sum of error products for output layer}

      for j := 1 to MAX_OUT do
        sum := sum + ol[j].E * ol[j].w[i];

      E := a * (1 - a) * sum
    end
end;

procedure calculate_input_layer_errors;
var
  i, j: byte;
  sum: Real48;
begin
  for i := 1 to MAX_INP do
    with ipl[i] do
    begin
      sum := 0; {Find sum of error products for output layer}

      for j := 1 to MAX_HID do
        sum := sum + hl[j].E * hl[j].w[i];

      E := a * (1 - a) * sum
    end
end;

{You will notice that the lines changing the threshold values have been
 bracketed out in the following procedure - they should be there according to
 the theory, but if I include them, the network doesn't produce the correct
 values. If I miss them out, as I have now, it produces correct values.
 If anyone can throw any light on this, I would be most grateful!}

procedure weight_change;
const
  BETA = 0.9; {Learning rate}
  M = 0.9; {Momentum parameter}
var
  i, j: byte; {for loop variables}
begin
  {First tackle weights from hidden layer to output layer}
  {i refers to a node in hidden layer, j refers to node in output layer}
  for j := 1 to MAX_OUT do {go through all output nodes}
    with ol[j] do
    begin
      for i := 1 to MAX_HID do {Adapt all weights}
      begin
        change[i] := BETA * E * hl[i].a + M * change[i];
        {this is the previous value  ------^}
        w[i] := w[i] + change[i]
      end;

      {Now adapt threshold as if from a node with activation 1}
      t_change := BETA * E * 1 + M * t_change;
      {threshold:=threshold + t_change}
    end;

  {Now tackle weights from input layer to hidden layer}
  {i refers to a node in input layer, j refers to node in hidden layer}
  for j := 1 to MAX_HID do {go through all hidden layer nodes}
    with hl[j] do
    begin
      for i := 1 to MAX_INP do {Adapt all weights}
      begin
        change[i] := BETA * E * ipl[i].a + M * change[i];
        {this is the previous value  ------^}
        w[i] := w[i] + change[i]
      end;

      {Now adapt threshold as if from a node with activation 1}
      t_change := BETA * E * 1 + M * t_change;
      {threshold:=threshold + t_change}
    end;

  {Now tackle weights from input to net to input layer}
  {i refers to a pattern input, j refers to node in input layer}
  for j := 1 to MAX_INP do {go through all input layer nodes}
    with ipl[j] do
    begin
      for i := 1 to MAX_INP do {Adapt all weights}
      begin
        change[i] := BETA * E * test_pat[i] + M * change[i];
        {this is the previous value  ------^}
        w[i] := w[i] + change[i]
      end;

      {Now adapt threshold as if from a node with activation 1}
      t_change := BETA * E * 1 + M * t_change;
      {threshold:=threshold + t_change}
    end
end;

{Perform back propagation on the network}

procedure back_propagate;
begin
  calculate_output_layer_errors;
  calculate_hidden_layer_errors;
  calculate_input_layer_errors;
  weight_change
end;

{Set the weights and thresholds for all the nodes to small random values in
 the range 0 to 1}

procedure random_weights;
var
  i, j: byte;
begin
  for i := 1 to MAX_INP do
    with ipl[i] do
    begin
      for j := 1 to MAX_INP do
        w[j] := random(1000) / 1000;

      threshold := random(1000) / 1000
    end;

  for i := 1 to MAX_HID do
    with hl[i] do
    begin
      for j := 1 to MAX_INP do
        w[j] := random(1000) / 1000;

      threshold := random(1000) / 1000
    end;

  for i := 1 to MAX_OUT do
    with ol[i] do
    begin
      for j := 1 to MAX_HID do
        w[j] := random(1000) / 1000;

      threshold := random(1000) / 1000
    end
end;

{At the start of back propagation, there are no weight changes to influence
 the next cycle, so clear the arrays}

procedure blank_changes;
var
  i, j: byte;
begin
  for j := 1 to MAX_INP do
    with ipl[j] do
    begin
      for i := 1 to MAX_INP do
        change[i] := 0;

      t_change := 0
    end;

  for j := 1 to MAX_HID do
    with hl[j] do
    begin
      for i := 1 to MAX_INP do
        change[i] := 0;

      t_change := 0
    end;

  for j := 1 to MAX_OUT do
    with ol[j] do
    begin
      for i := 1 to MAX_HID do
        change[i] := 0;

      t_change := 0
    end
end;

procedure train_the_network;
var
  pat: byte; {This cycles through all the patterns}
  i: byte; {General 'for' loop variable}
  num_cycles, loop: longint; {Might be VERY big value!}
begin
  writeln;
  write('Enter the number of training cycles (typically 100) : ');
  readln(num_cycles);
  blank_changes; {Clear all 'previous' weight changes}

  for loop := 1 to num_cycles do
    for pat := 1 to MAX_PAT do
    begin
      for i := 1 to MAX_INP do {Copies input pattern into}
        test_pat[i] := INP_PATTERNS[pat, i]; {'test_pat' array}

      for i := 1 to MAX_OUT do {Copies output pattern into}
        desired[i] := OUT_PATTERNS[pat, i]; {'desired' array}

      run_the_network; {Determine the outputs}
      back_propagate
    end
end;

begin
  randomize;
  random_weights;
  writeln;
  writeln('To start with, you should type in a few test patterns to see');
  writeln('how the network performs before it is trained.');
  test_the_network;
  train_the_network;
  writeln;
  writeln('Now you should type in a few more test patterns to see how the');
  writeln('network performs after it has been trained.');
  test_the_network
end.

