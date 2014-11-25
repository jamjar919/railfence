unit RailFence;

interface

procedure ClearWhiteSpace(var str: string);
{ This procedure clears all the white space from a string, for example
  'hello world' would be converted into 'helloworld' }

function EncryptRail(rails: integer; plaintext: string): string;
{ Encrypts using RailFence }

function DecryptRail(rails: integer; plaintext: string): string;
{ Decrypts using RailFence }

implementation

procedure ClearWhiteSpace(var str: string);
var
  i: integer;
begin
  for i := 1 to Length(str) do // for every character in the string
  begin
    if str[i] = ' ' then // check if it's a space
    begin
      delete(str, i, 1); // if it is, delete it from the string
    end;
  end;
end;

function EncryptRail(rails: integer; plaintext: string): string;
{ Encrypts using RailFence }
type
  arr = array of string;
var
  n, i: integer;
  output: string;
  increase: boolean;
  RailFence: arr;
begin
  setlength(RailFence, rails + 1);
  // set the length of the array, accounting for zero
  if rails <> 1 then // account for crash when rails = 0
  begin
    increase := true;
    n := 1;
    for i := 1 to rails do
    begin
      RailFence[i] := ''; // initialise array
    end;
    for i := 1 to Length(plaintext) do
    begin
      writeln('writing character ', plaintext[i], ' to rail ', n);
      RailFence[n] := RailFence[n] + plaintext[i];
      // write character to correct rail
      writeln('rail ', n, ' = ''', RailFence[n], '''');
      if n = 1 then // if at top rail, increase value to return to bottom
        increase := true
      else if n = rails then
      // if at bottom rail, decrease alue to go back to top
        increase := false;
      if increase = true then
        n := n + 1
      else if increase = false then
        n := n - 1; // do the actual increasing + decreasing
    end;
    for i := 1 to rails do
    begin
      output := output + RailFence[i]; // combine strings into output
    end;
    result := output;
  end
  else
    result := plaintext;
end;

function DecryptRail(rails: integer; plaintext: string): string;
type
  arr = array of string;
  arrint = array of integer;
var
  n, i, h, m, temp: integer;
  increase: boolean;
  tempstr: string;
  RailFence: arr;
  RailFenceEn: arr;
  RailFenceInt: arrint;
  output: string;
begin
  setlength(RailFence, rails + 1);
  setlength(RailFenceEn, rails + 1);
  setlength(RailFenceInt, rails + 1);
  if rails <> 1 then
  begin
    { Encrypt the string to find out the number of characters in each row, and measure
      the lengths of each value for RailFenceEn }
    writeln('Finding row lengths!');
    increase := true;
    n := 1;
    for i := 1 to rails do
    begin
      RailFenceEn[i] := '';
    end;
    for i := 1 to Length(plaintext) do
    begin
      RailFenceEn[n] := RailFenceEn[n] + plaintext[i];
      if n = 1 then
        increase := true
      else if n = rails then
        increase := false;
      if increase = true then
        n := n + 1
      else if increase = false then
        n := n - 1;
    end;
    for i := 1 to rails do
    begin
      writeln('Length of rail ', i, ' is ', Length(RailFenceEn[i]), '.');
    end;

    { Read in correct number of characters to the array RailFence }
    temp := 1;
    for i := 1 to rails do // for each rail
    begin
      for h := 1 to Length(RailFenceEn[i]) do
      // get number of characters corresponding to characters stored in RailFenceEn
      begin
        if temp <= Length(plaintext) then // if all characters aren't used
        begin
          RailFence[i] := RailFence[i] + plaintext[temp];
          // append character to string
          writeln('Character ', plaintext[temp], ' appended to rail ', i,
            ' to create string ''', RailFence[i], '''');
          inc(temp);
        end; { ENDIF }
      end; { END FOR N }
    end; { END FOR I }
    writeln('');
    writeln('Rows are: '); // write out the rows
    for i := 1 to rails do
    begin
      writeln(RailFence[i]);
    end;
    writeln('');

    { Replace all spaces with * marks in order to correctly format }
    for i := 1 to rails do
    begin
      for n := 1 to Length(RailFence[i]) do // for every character in the string
      begin
        if RailFence[i][n] = ' ' then // check if it's a space
        begin
          RailFence[i][n] := '*'; // replace it with *
        end;
      end;
    end;

    { Write out rows and add spaces to end }
    for i := 1 to rails do
    begin
      for n := 1 to rails do
        insert(' ', RailFence[i], Length(RailFence[i]) + 1);
      // add spaces after the last character in the string to avoid parse errors, we will remove them later
    end;

    for i := 1 to rails do // initialise array for counting
      RailFenceInt[i] := 1;

    increase := false;
    n := 1;
    i := 1;
    { for i := 1 to (Length(plaintext)
      div Length(RailFenceEn[rails div 2])) * 2 do      OLD CODE, caused problems with long files }
    while Length(output) <> Length(plaintext) do
    // while not all characters have been processed
    begin
      if i = 1 then
        temp := rails
      else
        temp := rails - 1;
      // accounts for first repeat as going from 0 to 3 is less than going from 3 to 1
      for m := 1 to temp do
      begin
        if RailFence[n][RailFenceInt[n]] <> ' ' then
        // if the character is not a space
        begin
          output := output + RailFence[n][RailFenceInt[n]];
          // append character to output string
          writeln('Index: ', n, ',', i, ' is ', RailFence[n][RailFenceInt[n]]);
        end;
        inc(RailFenceInt[n]);
        // if the character was used then move on to the next character in that array entry
        if n = 1 then
          increase := true
        else if n = rails then
          increase := false;
        if increase = true then
          n := n + 1
        else if increase = false then
          n := n - 1;
        // increases or decreases n depending on state of variable increase
        inc(i);
      end;
    end;

    ClearWhiteSpace(output); // get rid of the spaces we added for padding

    { Rereplace all * marks with spaces }
    for n := 1 to Length(output) do // for every character in the string
    begin
      if output[n] = '*' then // check if it's a *
      begin
        output[n] := ' '; // replace it with a space
      end;
    end;
    writeln('');
    result := output;
  end
  else
    result := plaintext;
end;

end.
