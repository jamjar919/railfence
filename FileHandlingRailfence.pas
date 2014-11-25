unit FileHandlingRailfence;

interface

procedure writeFile(inputFilePath: string);
{ Writes the content of a text file }

procedure encryptFileRailfence(inputFilePath: string; outputFilePath: string;
  rails: integer);
{ Encrypts a text file with railfence }

procedure decryptFileRailfence(inputFilePath: string; outputFilePath: string;
  rails: integer);
{ Encrypts a text file with railfence }

procedure saveToFile(outputFilePath: string; data: string);
{ saves text to file }

implementation

uses
  SysUtils,
  railFence;

procedure writeFile(inputFilePath: string);
var
  fileLine: string;
  inputFile: textfile;
begin
  assignfile(inputFile, inputFilePath);
  reset(inputFile); // open file
  writeln('');
  writeln('Contents of file: ');
  while not eof(inputFile) do // read and write each line of the file
  begin
    readln(inputFile, fileLine);
    writeln('> ', fileLine);
  end;
  writeln('');

  closefile(inputFile); // close file
end;

procedure encryptFileRailfence(inputFilePath: string; outputFilePath: string;
  rails: integer);
var
  outputFile, inputFile: textfile;
  fileContents, fileLine: string;
begin
  assignfile(outputFile, outputFilePath);
  assignfile(inputFile, inputFilePath);
  // assign both file paths to respective vars
  reset(inputFile); // open input file
  while not eof(inputFile) do
  begin
    readln(inputFile, fileLine); // read in a line
    fileContents := fileContents + fileLine; // add it to filecontents
  end;
  closefile(inputFile); // close input file
  fileContents := encryptRail(rails, fileContents); // encrypt file contents
  rewrite(outputFile); // open output
  write(outputFile, fileContents); // write filecontents to output
  closefile(outputFile); // close the output file
end;

procedure decryptFileRailfence(inputFilePath: string; outputFilePath: string;
  rails: integer);
{ Same as above, but decrypting }
var
  outputFile, inputFile: textfile;
  fileContents, fileLine: string;
begin
  assignfile(outputFile, outputFilePath);
  assignfile(inputFile, inputFilePath);
  reset(inputFile);
  while not eof(inputFile) do
  begin
    readln(inputFile, fileLine);
    fileContents := fileContents + fileLine;
  end;
  closefile(inputFile);
  fileContents := decryptRail(rails, fileContents);
  rewrite(outputFile);
  write(outputFile, fileContents);
  closefile(outputFile);
end;

procedure saveToFile(outputFilePath: string; data: string);
var
  outputFile: textfile;
begin
  assignfile(outputFile, outputFilePath);
  rewrite(outputFile);
  write(outputFile, data);
  closefile(outputFile);
end;

end.
