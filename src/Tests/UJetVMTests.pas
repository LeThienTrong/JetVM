{===============================================================================
      _     _ __   ____  __ ™
   _ | |___| |\ \ / /  \/  |
  | || / -_)  _\ V /| |\/| |
   \__/\___|\__|\_/ |_|  |_|
        Fast Delphi VM

 Copyright © 2025-present tinyBigGAMES™ LLC
 All Rights Reserved.

 https://github.com/tinyBigGAMES/JetVM

 BSD 3-Clause License

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
    list of conditions and the following disclaimer.

 2. Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.

 3. Neither the name of the copyright holder nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
===============================================================================}

unit UJetVMTests;

interface

procedure RunJetVMTests();

implementation

uses
  WinApi.Windows,
  System.SysUtils,
  System.IOUtils,
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Loggers.XML.NUnit,
  JetVM.Test.Logger,
  JetVM;

procedure Pause();
begin
  WriteLn;
  Write('Press ENTER to continue...');
  ReadLn;
  WriteLn;
end;

procedure RunJetVMTests();
var
  LRunner: ITestRunner;
  LResults: IRunResults;
  LCustomLogger: TJetVMTestLogger;
  LXmlLogger: ITestLogger;
  LXmlFilePath: string;
begin
  try
    LXmlFilePath := TPath.ChangeExtension(ParamStr(0), 'xml');

    LRunner := TDUnitX.CreateRunner();
    LRunner.UseRTTI := True;

    LCustomLogger := TJetVMTestLogger.Create(LXmlFilePath);
    LRunner.AddLogger(LCustomLogger);

    LXmlLogger := TDUnitXXMLNUnitFileLogger.Create(LXmlFilePath);
    LRunner.AddLogger(LXmlLogger);

    LResults := LRunner.Execute();

  except
    on E: Exception do
      WriteLn('ERROR: ', E.ClassName, ': ', E.Message);
  end;

  Pause();
end;

end.
