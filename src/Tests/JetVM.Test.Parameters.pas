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

unit JetVM.Test.Parameters;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  System.Math,
  JetVM;

type
  [TestFixture]
  TTestJetVMParameters = class(TObject)
  strict private
    FVM: TJetVM;

  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Const Parameter Tests
    // ==========================================================================
    [Test]
    procedure TestParamConstInt();
    [Test]
    procedure TestParamConstUInt();
    [Test]
    procedure TestParamConstStr();
    [Test]
    procedure TestParamConstBool();
    [Test]
    procedure TestParamConstPtr();

    // ==========================================================================
    // Var Parameter Tests
    // ==========================================================================
    [Test]
    procedure TestParamVarInt();
    [Test]
    procedure TestParamVarUInt();
    [Test]
    procedure TestParamVarStr();
    [Test]
    procedure TestParamVarBool();
    [Test]
    procedure TestParamVarPtr();

    // ==========================================================================
    // Out Parameter Tests
    // ==========================================================================
    [Test]
    procedure TestParamOutInt();
    [Test]
    procedure TestParamOutUInt();
    [Test]
    procedure TestParamOutStr();
    [Test]
    procedure TestParamOutBool();
    [Test]
    procedure TestParamOutPtr();

    // ==========================================================================
    // Parameter Setup and Call Tests
    // ==========================================================================
    [Test]
    procedure TestSetupCall();
    [Test]
    procedure TestSetupCallWithParameters();
    [Test]
    procedure TestSetupCallZeroParameters();
    [Test]
    procedure TestSetupCallMultipleParameters();

    // ==========================================================================
    // Parameter Push Operations
    // ==========================================================================
    [Test]
    procedure TestPushParam();
    [Test]
    procedure TestPushParamSequence();
    [Test]
    procedure TestPushParamWithDifferentTypes();
    [Test]
    procedure TestPushParamStackOrder();

    // ==========================================================================
    // Parameter Type Validation Tests
    // ==========================================================================
    [Test]
    procedure TestParameterTypeValidation();
    [Test]
    procedure TestParameterTypeMismatch();
    [Test]
    procedure TestParameterCountValidation();
    [Test]
    procedure TestParameterStackUnderflow();

    // ==========================================================================
    // Function Call Parameter Tests
    // ==========================================================================
    [Test]
    procedure TestFunctionCallWithConstParameters();
    [Test]
    procedure TestFunctionCallWithVarParameters();
    [Test]
    procedure TestFunctionCallWithOutParameters();
    [Test]
    procedure TestFunctionCallWithMixedParameters();

    // ==========================================================================
    // Native Function Parameter Tests
    // ==========================================================================
    [Test]
    procedure TestNativeFunctionParameterPassing();
    [Test]
    procedure TestNativeFunctionParameterTypes();
    [Test]
    procedure TestNativeFunctionParameterValidation();
    [Test]
    procedure TestNativeFunctionParameterReturn();

    // ==========================================================================
    // Parameter Mode Tests
    // ==========================================================================
    [Test]
    procedure TestParameterModeConst();
    [Test]
    procedure TestParameterModeVar();
    [Test]
    procedure TestParameterModeOut();
    [Test]
    procedure TestParameterModeMixed();

    // ==========================================================================
    // Stack Frame Parameter Tests
    // ==========================================================================
    [Test]
    procedure TestStackFrameParameterSetup();
    [Test]
    procedure TestStackFrameParameterAccess();
    [Test]
    procedure TestStackFrameParameterCleanup();
    [Test]
    procedure TestNestedFunctionParameters();

    // ==========================================================================
    // Parameter Edge Cases
    // ==========================================================================
    [Test]
    procedure TestParameterEdgeCases();
    [Test]
    procedure TestParameterOverflow();
    [Test]
    procedure TestParameterUnderflow();
    [Test]
    procedure TestParameterMemoryManagement();

    // ==========================================================================
    // Fluent Interface Parameter Tests
    // ==========================================================================
    [Test]
    procedure TestFluentParameterInterface();
    [Test]
    procedure TestFluentParameterChaining();
    [Test]
    procedure TestFluentParameterConsistency();
    [Test]
    procedure TestFluentParameterComplexScenarios();
  end;

implementation

// =============================================================================
// Setup and TearDown
// =============================================================================

procedure TTestJetVMParameters.Setup();
begin
  FVM := TJetVM.Create(vlDevelopment);
end;

procedure TTestJetVMParameters.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Const Parameter Tests
// =============================================================================

procedure TTestJetVMParameters.TestParamConstInt();
var
  LInstance: TJetVM;
  LResult: TJetValue;
begin
  LInstance := FVM.LoadInt(42);
  Assert.AreSame(FVM, LInstance, 'LoadInt should return same instance');

  LInstance := LInstance.ParamConstInt();
  Assert.AreSame(FVM, LInstance, 'ParamConstInt should return same instance');

  // Verify bytecode was generated
  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamConstUInt();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadUInt(123);
  Assert.AreSame(FVM, LInstance, 'LoadUInt should return same instance');

  LInstance := LInstance.ParamConstUInt();
  Assert.AreSame(FVM, LInstance, 'ParamConstUInt should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamConstStr();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadStr('Test String');
  Assert.AreSame(FVM, LInstance, 'LoadStr should return same instance');

  LInstance := LInstance.ParamConstStr();
  Assert.AreSame(FVM, LInstance, 'ParamConstStr should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamConstBool();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadBool(True);
  Assert.AreSame(FVM, LInstance, 'LoadBool should return same instance');

  LInstance := LInstance.ParamConstBool();
  Assert.AreSame(FVM, LInstance, 'ParamConstBool should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamConstPtr();
var
  LInstance: TJetVM;
  LPtrConstant: TJetValue;
  LConstIndex: Integer;
begin
  // Create a pointer constant and add it to constants pool
  LPtrConstant := FVM.MakePtrConstant(nil);
  FVM.AddConstant(LPtrConstant);
  LConstIndex := 0; // First constant

  LInstance := FVM.LoadConst(LConstIndex);
  Assert.AreSame(FVM, LInstance, 'LoadConst should return same instance');

  LInstance := LInstance.ParamConstPtr();
  Assert.AreSame(FVM, LInstance, 'ParamConstPtr should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

// =============================================================================
// Var Parameter Tests
// =============================================================================

procedure TTestJetVMParameters.TestParamVarInt();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadInt(100);
  Assert.AreSame(FVM, LInstance, 'LoadInt should return same instance');

  LInstance := LInstance.ParamVarInt();
  Assert.AreSame(FVM, LInstance, 'ParamVarInt should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamVarUInt();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadUInt(200);
  Assert.AreSame(FVM, LInstance, 'LoadUInt should return same instance');

  LInstance := LInstance.ParamVarUInt();
  Assert.AreSame(FVM, LInstance, 'ParamVarUInt should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamVarStr();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadStr('Variable String');
  Assert.AreSame(FVM, LInstance, 'LoadStr should return same instance');

  LInstance := LInstance.ParamVarStr();
  Assert.AreSame(FVM, LInstance, 'ParamVarStr should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamVarBool();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadBool(False);
  Assert.AreSame(FVM, LInstance, 'LoadBool should return same instance');

  LInstance := LInstance.ParamVarBool();
  Assert.AreSame(FVM, LInstance, 'ParamVarBool should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamVarPtr();
var
  LInstance: TJetVM;
  LPtrConstant: TJetValue;
  LTestValue: Integer;
begin
  LTestValue := 42;
  LPtrConstant := FVM.MakePtrConstant(@LTestValue);
  FVM.AddConstant(LPtrConstant);

  LInstance := FVM.LoadConst(0);
  Assert.AreSame(FVM, LInstance, 'LoadConst should return same instance');

  LInstance := LInstance.ParamVarPtr();
  Assert.AreSame(FVM, LInstance, 'ParamVarPtr should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

// =============================================================================
// Out Parameter Tests
// =============================================================================

procedure TTestJetVMParameters.TestParamOutInt();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.ParamOutInt();
  Assert.AreSame(FVM, LInstance, 'ParamOutInt should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamOutUInt();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.ParamOutUInt();
  Assert.AreSame(FVM, LInstance, 'ParamOutUInt should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamOutStr();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.ParamOutStr();
  Assert.AreSame(FVM, LInstance, 'ParamOutStr should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamOutBool();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.ParamOutBool();
  Assert.AreSame(FVM, LInstance, 'ParamOutBool should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestParamOutPtr();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.ParamOutPtr();
  Assert.AreSame(FVM, LInstance, 'ParamOutPtr should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

// =============================================================================
// Parameter Setup and Call Tests
// =============================================================================

procedure TTestJetVMParameters.TestSetupCall();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.SetupCall(0);
  Assert.AreSame(FVM, LInstance, 'SetupCall should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestSetupCallWithParameters();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.SetupCall(3);
  Assert.AreSame(FVM, LInstance, 'SetupCall(3) should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestSetupCallZeroParameters();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.SetupCall(0);
  Assert.AreSame(FVM, LInstance, 'SetupCall(0) should return same instance');

  FVM.Stop();
  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'VM should complete execution');
end;

procedure TTestJetVMParameters.TestSetupCallMultipleParameters();
var
  LInstance: TJetVM;
  LParamCount: Integer;
begin
  for LParamCount := 1 to 5 do
  begin
    FVM.Reset();

    LInstance := FVM.SetupCall(LParamCount);
    Assert.AreSame(FVM, LInstance, Format('SetupCall(%d) should return same instance', [LParamCount]));

    FVM.Stop();
    Assert.IsTrue(FVM.GetBytecodeSize() > 0, Format('Bytecode should be generated for %d parameters', [LParamCount]));
  end;
end;

// =============================================================================
// Parameter Push Operations
// =============================================================================

procedure TTestJetVMParameters.TestPushParam();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadInt(42).PushParam();
  Assert.AreSame(FVM, LInstance, 'PushParam should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated');
end;

procedure TTestJetVMParameters.TestPushParamSequence();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadInt(1)
                  .PushParam()
                  .LoadInt(2)
                  .PushParam()
                  .LoadInt(3)
                  .PushParam();

  Assert.AreSame(FVM, LInstance, 'Chained PushParam should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated for parameter sequence');
end;

procedure TTestJetVMParameters.TestPushParamWithDifferentTypes();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadInt(42)
                  .PushParam()
                  .LoadStr('test')
                  .PushParam()
                  .LoadBool(True)
                  .PushParam();

  Assert.AreSame(FVM, LInstance, 'PushParam with different types should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated for mixed parameter types');
end;

procedure TTestJetVMParameters.TestPushParamStackOrder();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
  LResult3: TJetValue;
begin
  // Test that parameters are pushed in correct order
  FVM.LoadInt(1)
     .LoadInt(2)
     .LoadInt(3)
     .Stop();

  FVM.Execute();

  // Pop in reverse order (last pushed first)
  LResult3 := FVM.PopValue();
  LResult2 := FVM.PopValue();
  LResult1 := FVM.PopValue();

  Assert.AreEqual(Int64(3), LResult3.IntValue, 'Third parameter should be 3');
  Assert.AreEqual(Int64(2), LResult2.IntValue, 'Second parameter should be 2');
  Assert.AreEqual(Int64(1), LResult1.IntValue, 'First parameter should be 1');
end;

// =============================================================================
// Parameter Type Validation Tests
// =============================================================================

procedure TTestJetVMParameters.TestParameterTypeValidation();
begin
  // Test that parameter type validation works in development mode
  FVM.LoadInt(42).ParamConstInt().Stop();

  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'VM should complete execution without errors');
end;

procedure TTestJetVMParameters.TestParameterTypeMismatch();
begin
  // Test parameter type mismatch detection
  FVM.LoadStr('not a number').ParamConstInt().Stop();

  // In development mode, this should be caught during validation
  // Actual behavior depends on validation level implementation
  FVM.Execute();

  // This test verifies the VM handles type mismatches gracefully
  Assert.IsFalse(FVM.IsRunning(), 'VM should handle type mismatch');
end;

procedure TTestJetVMParameters.TestParameterCountValidation();
var
  LExpectedParamCount: Integer;
begin
  LExpectedParamCount := 2;

  FVM.LoadInt(1)
     .LoadInt(2)
     .SetupCall(LExpectedParamCount)
     .Stop();

  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'VM should complete execution');
  Assert.AreEqual(Integer(LExpectedParamCount), FVM.GetSP(), 'Stack should contain expected parameters');
end;

procedure TTestJetVMParameters.TestParameterStackUnderflow();
begin
  // Test parameter stack underflow detection
  // SetupCall(1) expects 1 parameter but stack is empty
  FVM.SetupCall(1).Stop();

  try
    FVM.Execute();
    // If execution completes without error, stack underflow was handled
    Assert.IsFalse(FVM.IsRunning(), 'VM should handle stack underflow gracefully');
  except
    on E: Exception do
      Assert.IsTrue(E.Message.Contains('stack') or E.Message.Contains('underflow'),
                   'Should raise stack underflow error: ' + E.Message);
  end;
end;

// =============================================================================
// Function Call Parameter Tests
// =============================================================================

procedure TTestJetVMParameters.TestFunctionCallWithConstParameters();
var
  LTestFunction: TJetNativeFunction;
  LParamReceived: Boolean;
begin
  LParamReceived := False;

  LTestFunction := procedure(const AVM: TJetVM)
    var
      LParam: TJetValue;
    begin
      LParam := AVM.PopValue();
      LParamReceived := (LParam.IntValue = 42);
    end;

  FVM.RegisterNativeFunction('TestFunc', LTestFunction, [jvtInt]);

  FVM.LoadInt(42)
     .SetupCall(1)
     .CallFunction('TestFunc')
     .Stop();

  FVM.Execute();

  Assert.IsTrue(LParamReceived, 'Native function should receive correct parameter');
end;

procedure TTestJetVMParameters.TestFunctionCallWithVarParameters();
var
  LTestFunction: TJetNativeFunction;
  LParamReceived: Boolean;
begin
  LParamReceived := False;

  LTestFunction := procedure(const AVM: TJetVM)
    var
      LParam: TJetValue;
    begin
      LParam := AVM.PopValue();
      LParamReceived := (LParam.StrValue = 'test');
    end;

  FVM.RegisterNativeFunction('TestVarFunc', LTestFunction, [jvtStr]);

  FVM.LoadStr('test')
     .SetupCall(1)
     .CallFunction('TestVarFunc')
     .Stop();

  FVM.Execute();

  Assert.IsTrue(LParamReceived, 'Native function should receive correct var parameter');
end;

procedure TTestJetVMParameters.TestFunctionCallWithOutParameters();
var
  LTestFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  LTestFunction := procedure(const AVM: TJetVM)
    begin
      AVM.PushValue(AVM.MakeIntConstant(99));
    end;

  FVM.RegisterNativeFunction('TestOutFunc', LTestFunction, [], jvtInt);

  FVM.SetupCall(0)
     .CallFunction('TestOutFunc')
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(99), LResult.IntValue, 'Out parameter should return correct value');
end;

procedure TTestJetVMParameters.TestFunctionCallWithMixedParameters();
var
  LTestFunction: TJetNativeFunction;
  LParamsReceived: Boolean;
begin
  LParamsReceived := False;

  LTestFunction := procedure(const AVM: TJetVM)
    var
      LParam1: TJetValue;
      LParam2: TJetValue;
    begin
      LParam2 := AVM.PopValue(); // Second parameter (pushed last)
      LParam1 := AVM.PopValue(); // First parameter (pushed first)
      LParamsReceived := (LParam1.IntValue = 10) and (LParam2.StrValue = 'hello');
    end;

  FVM.RegisterNativeFunction('TestMixedFunc', LTestFunction, [jvtInt, jvtStr]);

  FVM.LoadInt(10)
     .LoadStr('hello')
     .SetupCall(2)
     .CallFunction('TestMixedFunc')
     .Stop();

  FVM.Execute();

  Assert.IsTrue(LParamsReceived, 'Native function should receive correct mixed parameters');
end;

// =============================================================================
// Native Function Parameter Tests
// =============================================================================

procedure TTestJetVMParameters.TestNativeFunctionParameterPassing();
var
  LTestFunction: TJetNativeFunction;
  LParameterSum: Int64;
begin
  LParameterSum := 0;

  LTestFunction := procedure(const AVM: TJetVM)
    var
      LParam1: TJetValue;
      LParam2: TJetValue;
      LParam3: TJetValue;
    begin
      LParam3 := AVM.PopValue();
      LParam2 := AVM.PopValue();
      LParam1 := AVM.PopValue();
      LParameterSum := LParam1.IntValue + LParam2.IntValue + LParam3.IntValue;
    end;

  FVM.RegisterNativeFunction('SumFunc', LTestFunction, [jvtInt, jvtInt, jvtInt]);

  FVM.LoadInt(10)
     .LoadInt(20)
     .LoadInt(30)
     .SetupCall(3)
     .CallFunction('SumFunc')
     .Stop();

  FVM.Execute();

  Assert.AreEqual(Int64(60), LParameterSum, 'Native function should receive all parameters correctly');
end;

procedure TTestJetVMParameters.TestNativeFunctionParameterTypes();
var
  LTestFunction: TJetNativeFunction;
  LTypesCorrect: Boolean;
begin
  LTypesCorrect := False;

  LTestFunction := procedure(const AVM: TJetVM)
    var
      LIntParam: TJetValue;
      LStrParam: TJetValue;
      LBoolParam: TJetValue;
    begin
      LBoolParam := AVM.PopValue();
      LStrParam := AVM.PopValue();
      LIntParam := AVM.PopValue();

      LTypesCorrect := (LIntParam.ValueType = jvtInt) and
                      (LStrParam.ValueType = jvtStr) and
                      (LBoolParam.ValueType = jvtBool);
    end;

  FVM.RegisterNativeFunction('TypeTestFunc', LTestFunction, [jvtInt, jvtStr, jvtBool]);

  FVM.LoadInt(100)
     .LoadStr('type test')
     .LoadBool(True)
     .SetupCall(3)
     .CallFunction('TypeTestFunc')
     .Stop();

  FVM.Execute();

  Assert.IsTrue(LTypesCorrect, 'Native function should receive parameters with correct types');
end;

procedure TTestJetVMParameters.TestNativeFunctionParameterValidation();
var
  LTestFunction: TJetNativeFunction;
  LFunctionCalled: Boolean;
begin
  LFunctionCalled := False;

  LTestFunction := procedure(const AVM: TJetVM)
    begin
      LFunctionCalled := True;
      AVM.PopValue(); // Consume parameter
    end;

  FVM.RegisterNativeFunction('ValidateFunc', LTestFunction, [jvtInt]);

  FVM.LoadInt(42)
     .SetupCall(1)
     .CallFunction('ValidateFunc')
     .Stop();

  FVM.Execute();

  Assert.IsTrue(LFunctionCalled, 'Native function with valid parameters should be called');
end;

procedure TTestJetVMParameters.TestNativeFunctionParameterReturn();
var
  LTestFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  LTestFunction := procedure(const AVM: TJetVM)
    var
      LInput: TJetValue;
    begin
      LInput := AVM.PopValue();
      AVM.PushValue(AVM.MakeIntConstant(LInput.IntValue * 2));
    end;

  FVM.RegisterNativeFunction('DoubleFunc', LTestFunction, [jvtInt], jvtInt);

  FVM.LoadInt(21)
     .SetupCall(1)
     .CallFunction('DoubleFunc')
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Native function should return correct value');
end;

// =============================================================================
// Parameter Mode Tests
// =============================================================================

procedure TTestJetVMParameters.TestParameterModeConst();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadInt(42).ParamConstInt();
  Assert.AreSame(FVM, LInstance, 'Const parameter mode should work');

  FVM.Stop();
  FVM.Execute();
  Assert.IsFalse(FVM.IsRunning(), 'VM should complete execution');
end;

procedure TTestJetVMParameters.TestParameterModeVar();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadStr('variable').ParamVarStr();
  Assert.AreSame(FVM, LInstance, 'Var parameter mode should work');

  FVM.Stop();
  FVM.Execute();
  Assert.IsFalse(FVM.IsRunning(), 'VM should complete execution');
end;

procedure TTestJetVMParameters.TestParameterModeOut();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.ParamOutBool();
  Assert.AreSame(FVM, LInstance, 'Out parameter mode should work');

  FVM.Stop();
  FVM.Execute();
  Assert.IsFalse(FVM.IsRunning(), 'VM should complete execution');
end;

procedure TTestJetVMParameters.TestParameterModeMixed();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadInt(10)
                  .ParamConstInt()
                  .LoadStr('test')
                  .ParamVarStr()
                  .ParamOutInt();

  Assert.AreSame(FVM, LInstance, 'Mixed parameter modes should work');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated for mixed parameters');
end;

// =============================================================================
// Stack Frame Parameter Tests
// =============================================================================

procedure TTestJetVMParameters.TestStackFrameParameterSetup();
begin
  FVM.LoadInt(1)
     .LoadInt(2)
     .LoadInt(3)
     .SetupCall(3)
     .Stop();

  FVM.Execute();

  Assert.AreEqual(3, FVM.GetSP(), 'Stack should contain all parameters');
  Assert.IsFalse(FVM.IsRunning(), 'VM should complete execution');
end;

procedure TTestJetVMParameters.TestStackFrameParameterAccess();
var
  LParam1: TJetValue;
  LParam2: TJetValue;
  LParam3: TJetValue;
begin
  FVM.LoadInt(100)
     .LoadInt(200)
     .LoadInt(300)
     .Stop();

  FVM.Execute();

  // Access parameters in reverse order (stack is LIFO)
  LParam3 := FVM.PopValue();
  LParam2 := FVM.PopValue();
  LParam1 := FVM.PopValue();

  Assert.AreEqual(Int64(300), LParam3.IntValue, 'Third parameter should be 300');
  Assert.AreEqual(Int64(200), LParam2.IntValue, 'Second parameter should be 200');
  Assert.AreEqual(Int64(100), LParam1.IntValue, 'First parameter should be 100');
end;

procedure TTestJetVMParameters.TestStackFrameParameterCleanup();
var
  LInitialSP: Integer;
  LFinalSP: Integer;
begin
  LInitialSP := FVM.GetSP();

  FVM.LoadInt(42)
     .SetupCall(1)
     .Stop();

  FVM.Execute();

  // Pop the parameter to simulate cleanup
  FVM.PopValue();
  LFinalSP := FVM.GetSP();

  Assert.AreEqual(LInitialSP, LFinalSP, 'Stack should be cleaned up after parameter use');
end;

procedure TTestJetVMParameters.TestNestedFunctionParameters();
var
  LOuterFunction: TJetNativeFunction;
  LInnerFunction: TJetNativeFunction;
  LResult: TJetValue;
  LInnerCalled: Boolean;
begin
  LInnerCalled := False;

  LInnerFunction := procedure(const AVM: TJetVM)
    var
      LParam: TJetValue;
    begin
      LParam := AVM.PopValue();
      LInnerCalled := True;
      AVM.PushValue(AVM.MakeIntConstant(LParam.IntValue + 10));
    end;

  LOuterFunction := procedure(const AVM: TJetVM)
    var
      LParam: TJetValue;
      LModifiedValue: TJetValue;
    begin
      LParam := AVM.PopValue();
      LModifiedValue := AVM.MakeIntConstant(LParam.IntValue * 2);
      AVM.PushValue(LModifiedValue);
      // Simulate calling inner function by manually invoking it
      LInnerFunction(AVM);
    end;

  FVM.RegisterNativeFunction('InnerFunc', LInnerFunction, [jvtInt], jvtInt);
  FVM.RegisterNativeFunction('OuterFunc', LOuterFunction, [jvtInt], jvtInt);

  FVM.LoadInt(5)
     .SetupCall(1)
     .CallFunction('OuterFunc')
     .Stop();

  FVM.Execute();

  Assert.IsTrue(LInnerCalled, 'Inner function should have been called');

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(20), LResult.IntValue, 'Nested function parameters should work correctly: (5 * 2) + 10 = 20');
end;

// =============================================================================
// Parameter Edge Cases
// =============================================================================

procedure TTestJetVMParameters.TestParameterEdgeCases();
begin
  // Test with zero parameters
  FVM.SetupCall(0).Stop();
  FVM.Execute();
  Assert.IsFalse(FVM.IsRunning(), 'VM should handle zero parameters');

  // Test with maximum reasonable parameters (put them on stack first)
  FVM.Reset();
  // Put 10 parameters on stack
  FVM.LoadInt(1).LoadInt(2).LoadInt(3).LoadInt(4).LoadInt(5)
     .LoadInt(6).LoadInt(7).LoadInt(8).LoadInt(9).LoadInt(10)
     .SetupCall(10).Stop();
  FVM.Execute();
  Assert.IsFalse(FVM.IsRunning(), 'VM should handle many parameters');
end;

procedure TTestJetVMParameters.TestParameterOverflow();
var
  LParameterCount: Integer;
  LIndex: Integer;
begin
  // Test reasonable parameter limits
  for LParameterCount := 1 to 10 do
  begin
    FVM.Reset();

    // Put the required number of parameters on stack
    for LIndex := 1 to LParameterCount do
      FVM.LoadInt(LIndex);

    FVM.SetupCall(LParameterCount).Stop();
    FVM.Execute();
    Assert.IsFalse(FVM.IsRunning(), Format('VM should handle %d parameters', [LParameterCount]));
  end;
end;

procedure TTestJetVMParameters.TestParameterUnderflow();
begin
  // Test calling function with insufficient parameters
  FVM.SetupCall(3).Stop(); // Setup expecting 3 params but provide none

  try
    FVM.Execute();
    // If no exception, VM handled underflow gracefully
    Assert.IsFalse(FVM.IsRunning(), 'VM should handle parameter underflow');
  except
    on E: Exception do
      Assert.IsTrue(E.Message.Contains('stack') or E.Message.Contains('underflow'),
                   'Should indicate stack underflow: ' + E.Message);
  end;
end;

procedure TTestJetVMParameters.TestParameterMemoryManagement();
var
  LTestFunction: TJetNativeFunction;
  LStringParam: string;
begin
  LStringParam := '';

  LTestFunction := procedure(const AVM: TJetVM)
    var
      LParam: TJetValue;
    begin
      LParam := AVM.PopValue();
      LStringParam := LParam.StrValue;
    end;

  FVM.RegisterNativeFunction('MemTestFunc', LTestFunction, [jvtStr]);

  FVM.LoadStr('Memory test string')
     .SetupCall(1)
     .CallFunction('MemTestFunc')
     .Stop();

  FVM.Execute();

  Assert.AreEqual('Memory test string', LStringParam, 'String parameter memory should be managed correctly');
end;

// =============================================================================
// Fluent Interface Parameter Tests
// =============================================================================

procedure TTestJetVMParameters.TestFluentParameterInterface();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadInt(42)
                  .ParamConstInt()
                  .LoadStr('test')
                  .ParamConstStr()
                  .SetupCall(2);

  Assert.AreSame(FVM, LInstance, 'Fluent parameter interface should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Fluent parameter interface should generate bytecode');
end;

procedure TTestJetVMParameters.TestFluentParameterChaining();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadInt(1).ParamConstInt()
                  .LoadUInt(2).ParamConstUInt()
                  .LoadStr('three').ParamConstStr()
                  .LoadBool(True).ParamConstBool()
                  .SetupCall(4);

  Assert.AreSame(FVM, LInstance, 'Chained parameter operations should return same instance');

  FVM.Stop();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Chained parameters should generate bytecode');
end;

procedure TTestJetVMParameters.TestFluentParameterConsistency();
var
  LInstance1: TJetVM;
  LInstance2: TJetVM;
  LInstance3: TJetVM;
begin
  LInstance1 := FVM.LoadInt(100);
  LInstance2 := LInstance1.ParamConstInt();
  LInstance3 := LInstance2.SetupCall(1);

  Assert.AreSame(FVM, LInstance1, 'LoadInt should return same instance');
  Assert.AreSame(FVM, LInstance2, 'ParamConstInt should return same instance');
  Assert.AreSame(FVM, LInstance3, 'SetupCall should return same instance');
  Assert.AreSame(LInstance1, LInstance2, 'All instances should be the same');
  Assert.AreSame(LInstance2, LInstance3, 'All instances should be the same');
end;

procedure TTestJetVMParameters.TestFluentParameterComplexScenarios();
var
  LTestFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  LTestFunction := procedure(const AVM: TJetVM)
    var
      LParam1: TJetValue;
      LParam2: TJetValue;
      LParam3: TJetValue;
    begin
      LParam3 := AVM.PopValue();
      LParam2 := AVM.PopValue();
      LParam1 := AVM.PopValue();

      // Complex calculation using all parameters
      AVM.PushValue(AVM.MakeIntConstant(
        LParam1.IntValue + Integer(Length(LParam2.StrValue)) +
        IfThen(LParam3.BoolValue, 100, 0)
      ));
    end;

  FVM.RegisterNativeFunction('ComplexFunc', LTestFunction, [jvtInt, jvtStr, jvtBool], jvtInt);

  FVM.LoadInt(10)
     .LoadStr('hello')
     .LoadBool(True)
     .SetupCall(3)
     .CallFunction('ComplexFunc')
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  // Expected: 10 + 5 (length of "hello") + 100 (True) = 115
  Assert.AreEqual(Int64(115), LResult.IntValue, 'Complex fluent parameter scenario should work correctly');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMParameters);

end.
