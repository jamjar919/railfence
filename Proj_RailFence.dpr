program Proj_RailFence;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  FileHandlingRailfence in 'FileHandlingRailfence.pas',
  RailFence in 'RailFence.pas';

var
  plaintext: string;
  rails: integer;
  menuchoice: integer;
  output: string;
  inputFilePath, outputFilePath, yn: string;

begin
  repeat
    writeln('--- Railfence Encrypt and Decrypt ---');
    writeln('[1] Encrypt');
    writeln('[2] Decrypt');
    writeln('[3] Encrypt from/to file');
    writeln('[4] Decrypt from/to file');
    writeln('[0] Exit');
    write('> ');
    readln(menuchoice);
    case menuchoice of
      1:
        begin
          writeln('Enter your plaintext');
          write('> ');
          readln(plaintext);
          writeln('');
          writeln('Enter the number of rails to use');
          write('> ');
          readln(rails);
          writeln('');
          output := EncryptRail(rails, plaintext);
          writeln('''', output, '''');
          writeln('');
          writeln('Save to file? y/n ');
          write('> ');
          readln(yn);
          if (yn = 'y') or (yn = 'Y') then
          begin
            writeln('Enter your file name for the output file with extension');
            write('> ');
            readln(outputFilePath);
            saveToFile(outputFilePath, output);
            writeln('File Saved.');
          end
          else if (yn = 'n') or (yn = 'N') then
          else
            writeln('No choice specified.');
          writeln('');
          writeln('Press enter to return to the main menu');
          readln;
        end;
      2:
        begin
          writeln('Enter your plaintext');
          write('> ');
          readln(plaintext);
          writeln('');
          writeln('How many rails were used?');
          write('> ');
          readln(rails);
          writeln('');
          output := DecryptRail(rails, plaintext);
          writeln('''', output, '''');
          writeln('');
          writeln('Save to file? y/n ');
          write('> ');
          readln(yn);
          if (yn = 'y') or (yn = 'Y') then
          begin
            writeln('Enter your file name for the output file with extension');
            write('> ');
            readln(outputFilePath);
            saveToFile(outputFilePath, output);
            writeln('File Saved.');
          end
          else if (yn = 'n') or (yn = 'N') then
          else
            writeln('No choice specified.');
          writeln('');
          writeln('Press enter to return to the main menu');
          readln;
        end;
      3:
        begin
          try;
            writeln('Enter the name of your text file, with extension ');
            write('> ');
            readln(inputFilePath);
            writeFile(inputFilePath);
            writeln('Enter your file name for the output file with extension');
            write('> ');
            readln(outputFilePath);
            writeln('How many rails do you wish to encrypt with?');
            write('> ');
            readln(rails);
            encryptFileRailfence(inputFilePath, outputFilePath, rails);
            writeln('Encryption succeeded');
            writeln('Write contents of file? y/n ');
            write('> ');
            readln(yn);
            if (yn = 'y') or (yn = 'Y') then
              writeFile(outputFilePath)
            else if (yn = 'n') or (yn = 'N') then
            else
              writeln('No choice specified.');
            writeln('Press enter to return to the main menu');
            readln;
          except
            on E: EInOutError do
            begin
              writeln('File handling error occurred. Details: ', E.ClassName,
                '/' + E.Message);
              writeln('');
            end; // error handling for file errors, tells you if file does not exist
          end;
        end;
      4:
        begin
          try;
            writeln('Enter the name of your text file, with extension ');
            write('> ');
            readln(inputFilePath);
            writeFile(inputFilePath);
            writeln('Enter your file name for the output file with extension');
            write('> ');
            readln(outputFilePath);
            writeln('How many rails were used to encrypt?');
            write('> ');
            readln(rails);
            decryptFileRailfence(inputFilePath, outputFilePath, rails);
            writeln('Decryption succeeded');
            writeln('Write contents of file? y/n ');
            write('> ');
            readln(yn);
            if (yn = 'y') or (yn = 'Y') then
              writeFile(outputFilePath)
            else if (yn = 'n') or (yn = 'N') then
            else
              writeln('No choice specified.');
            writeln('Press enter to return to the main menu');
            readln;
          except
            on E: EInOutError do
            begin
              writeln('File handling error occurred. Details: ', E.ClassName,
                '/' + E.Message);
              writeln('');
            end; // error handling for file errors, tells you if file does not exist
          end;
        end;

      0:
        begin
          menuchoice := 0;
        end;
    end;

  until menuchoice = 0;

end.
