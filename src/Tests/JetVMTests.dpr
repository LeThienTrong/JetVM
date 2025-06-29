﻿{==============================================================================
      _     _ __   ____  __ ™
   _ | |___| |\ \ / /  \/  |
  | || / -_)  _\ V /| |\/| |
   \__/\___|\__|\_/ |_|  |_|
        Fast Delphi VM

 Copyright © 2025-present tinyBigGAMES™ LLC
 All Rights Reserved.

 https://github.com/tinyBigGAMES/JetVM

 BSD 3-Clause License

 Copyright (c) 2025-present, tinyBigGAMES LLC

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
==============================================================================}

program JetVMTests;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UJetVMTests in 'UJetVMTests.pas',
  JetVM in '..\JetVM.pas',
  JetVM.Test.Logger in '..\JetVM.Test.Logger.pas',
  JetVM.Test.Core in 'JetVM.Test.Core.pas',
  JetVM.Test.Values in 'JetVM.Test.Values.pas',
  JetVM.Test.Stack in 'JetVM.Test.Stack.pas',
  JetVM.Test.Constants in 'JetVM.Test.Constants.pas',
  JetVM.Test.Bytecode in 'JetVM.Test.Bytecode.pas',
  JetVM.Test.Execution in 'JetVM.Test.Execution.pas',
  JetVM.Test.Labels in 'JetVM.Test.Labels.pas',
  JetVM.Test.Registers in 'JetVM.Test.Registers.pas',
  JetVM.Test.Arithmetic in 'JetVM.Test.Arithmetic.pas',
  JetVM.Test.Bitwise in 'JetVM.Test.Bitwise.pas',
  JetVM.Test.Comparisons in 'JetVM.Test.Comparisons.pas',
  JetVM.Test.Boolean in 'JetVM.Test.Boolean.pas',
  JetVM.Test.Strings in 'JetVM.Test.Strings.pas',
  JetVM.Test.Pointers in 'JetVM.Test.Pointers.pas',
  JetVM.Test.Arrays in 'JetVM.Test.Arrays.pas',
  JetVM.Test.TypeConversion in 'JetVM.Test.TypeConversion.pas',
  JetVM.Test.ControlFlow in 'JetVM.Test.ControlFlow.pas',
  JetVM.Test.Functions in 'JetVM.Test.Functions.pas',
  JetVM.Test.Parameters in 'JetVM.Test.Parameters.pas',
  JetVM.Test.Memory in 'JetVM.Test.Memory.pas',
  JetVM.Test.Validation in 'JetVM.Test.Validation.pas',
  JetVM.Test.Integration in 'JetVM.Test.Integration.pas',
  JetVM.Test.Performance in 'JetVM.Test.Performance.pas';

begin
  try
    RunJetVMTests();
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
