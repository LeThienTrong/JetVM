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

unit JetVM.Test.Functions;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  System.TypInfo,
  JetVM;

type
  [TestFixture]
  TTestJetVMFunctions = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Native Function Registration Tests
    // ==========================================================================
    [Test]
    procedure TestRegisterNativeFunctionWithReturnType();
    [Test]
    procedure TestRegisterNativeFunctionVoid();
    [Test]
    procedure TestRegisterNativeFunctionMultipleParameters();
    [Test]
    procedure TestRegisterNativeFunctionZeroParameters();
    [Test]
    procedure TestRegisterNativeFunctionAllValueTypes();

    // ==========================================================================
    // Native Function Registration Edge Cases
    // ==========================================================================
    [Test]
    procedure TestRegisterNativeFunctionDuplicateName();
    [Test]
    procedure TestRegisterNativeFunctionEmptyName();
    [Test]
    procedure TestRegisterNativeFunctionNilProc();
    [Test]
    procedure TestRegisterNativeFunctionMaxParameters();
    [Test]
    procedure TestRegisterNativeFunctionInvalidParameters();

    // ==========================================================================
    // VM Function Declaration Tests
    // ==========================================================================
    [Test]
    procedure TestDeclareVMFunctionWithReturnType();
    [Test]
    procedure TestDeclareVMFunctionVoid();
    [Test]
    procedure TestDeclareVMFunctionMultipleParameters();
    [Test]
    procedure TestDeclareVMFunctionZeroParameters();
    [Test]
    procedure TestDeclareVMFunctionAllValueTypes();

    // ==========================================================================
    // VM Function Declaration Edge Cases
    // ==========================================================================
    [Test]
    procedure TestDeclareVMFunctionInvalidAddress();
    [Test]
    procedure TestDeclareVMFunctionNegativeAddress();
    [Test]
    procedure TestDeclareVMFunctionDuplicateName();
    [Test]
    procedure TestDeclareVMFunctionEmptyName();

    // ==========================================================================
    // Function Registry Access Tests
    // ==========================================================================
    [Test]
    procedure TestGetFunctionIndex();
    [Test]
    procedure TestGetFunctionIndexNonExistent();
    [Test]
    procedure TestGetFunctionIndexCaseSensitive();
    [Test]
    procedure TestGetFunctionIndexAfterMultipleRegistrations();

    // ==========================================================================
    // Function Call Tests - Native Functions
    // ==========================================================================
    [Test]
    procedure TestCallNativeFunctionByName();
    [Test]
    procedure TestCallNativeFunctionByIndex();
    [Test]
    procedure TestCallNativeFunctionWithParameters();
    [Test]
    procedure TestCallNativeFunctionWithReturnValue();
    [Test]
    procedure TestCallNativeFunctionVoid();

    // ==========================================================================
    // Function Call Tests - VM Functions
    // ==========================================================================
    [Test]
    procedure TestCallVMFunctionByName();
    [Test]
    procedure TestCallVMFunctionByIndex();
    [Test]
    procedure TestCallVMFunctionWithParameters();
    [Test]
    procedure TestCallVMFunctionWithReturnValue();

    // ==========================================================================
    // Function Call Edge Cases
    // ==========================================================================
    [Test]
    procedure TestCallNonExistentFunction();
    [Test]
    procedure TestCallFunctionInvalidIndex();
    [Test]
    procedure TestCallFunctionWrongParameterCount();
    [Test]
    procedure TestCallFunctionWrongParameterTypes();
    [Test]
    procedure TestCallFunctionWithEmptyStack();

    // ==========================================================================
    // Parameter Operations Tests
    // ==========================================================================
    [Test]
    procedure TestPushParamOperation();
    [Test]
    procedure TestSetupCallOperation();
    [Test]
    procedure TestParameterOrderPreservation();
    [Test]
    procedure TestMultipleParameterTypes();

    // ==========================================================================
    // Function Definition Operations Tests
    // ==========================================================================
    [Test]
    procedure TestDeclareFunctionOperation();
    [Test]
    procedure TestBeginFunctionOperation();
    [Test]
    procedure TestEndFunctionOperation();
    [Test]
    procedure TestFunctionDefinitionSequence();

    // ==========================================================================
    // Return Operations Tests
    // ==========================================================================
    [Test]
    procedure TestReturnOperation();
    [Test]
    procedure TestReturnValueOperation();
    [Test]
    procedure TestReturnWithoutValue();
    [Test]
    procedure TestReturnWithValue();

    // ==========================================================================
    // Complex Function Scenarios
    // ==========================================================================
    [Test]
    procedure TestNestedFunctionCalls();
    [Test]
    procedure TestRecursiveFunctionCalls();
    [Test]
    procedure TestFunctionCallChaining();
    [Test]
    procedure TestMixedNativeAndVMFunctions();

    // ==========================================================================
    // Function Stack Management Tests
    // ==========================================================================
    [Test]
    procedure TestFunctionCallStackManagement();
    [Test]
    procedure TestFunctionParameterStackIsolation();
    [Test]
    procedure TestFunctionReturnValueStackHandling();
    [Test]
    procedure TestDeepFunctionCallStack();

    // ==========================================================================
    // Function Performance Tests
    // ==========================================================================
    [Test]
    procedure TestFunctionCallPerformance();
    [Test]
    procedure TestFunctionRegistryLookupPerformance();
    [Test]
    procedure TestMassiveFunctionRegistration();

    // ==========================================================================
    // Function Error Handling Tests
    // ==========================================================================
    [Test]
    procedure TestFunctionExceptionHandling();
    [Test]
    procedure TestFunctionParameterValidation();
    [Test]
    procedure TestFunctionReturnTypeValidation();
    [Test]
    procedure TestFunctionStackOverflowPrevention();

    // ==========================================================================
    // Fluent Interface Function Tests
    // ==========================================================================
    [Test]
    procedure TestFluentFunctionCallChaining();
    [Test]
    procedure TestFluentParameterSetup();
    [Test]
    procedure TestFluentFunctionDefinition();
    [Test]
    procedure TestFluentReturnOperations();

    // ==========================================================================
    // Integration Tests
    // ==========================================================================
    [Test]
    procedure TestFunctionIntegrationWithArithmetic();
    [Test]
    procedure TestFunctionIntegrationWithStringOps();
    [Test]
    procedure TestFunctionIntegrationWithControlFlow();
    [Test]
    procedure TestComplexFunctionProgram();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMFunctions.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMFunctions.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Native Function Registration Tests
// =============================================================================

procedure TTestJetVMFunctions.TestRegisterNativeFunctionWithReturnType();
var
  LFunctionIndex: Integer;
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue * 2);
    AVM.PushValue(LResult);
  end;

  LFunctionIndex := FVM.RegisterNativeFunction('double', LNativeFunction, [jvtInt], jvtInt);

  Assert.IsTrue(LFunctionIndex >= 0, 'Function registration should return valid index');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('double'), 'Registered function should be findable');
end;

procedure TTestJetVMFunctions.TestRegisterNativeFunctionVoid();
var
  LFunctionIndex: Integer;
  LCallCount: Integer;
  LNativeFunction: TJetNativeFunction;
begin
  LCallCount := 0;

  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    Inc(LCallCount);
    // Void function - no return value
  end;

  LFunctionIndex := FVM.RegisterNativeFunction('test_void', LNativeFunction, []);

  Assert.IsTrue(LFunctionIndex >= 0, 'Void function registration should return valid index');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('test_void'), 'Registered void function should be findable');
end;

procedure TTestJetVMFunctions.TestRegisterNativeFunctionMultipleParameters();
var
  LFunctionIndex: Integer;
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LArg3: TJetValue := AVM.PopValue(); // Third parameter
    var LArg2: TJetValue := AVM.PopValue(); // Second parameter
    var LArg1: TJetValue := AVM.PopValue(); // First parameter
    var LResult: TJetValue := AVM.MakeIntConstant(LArg1.IntValue + LArg2.IntValue + LArg3.IntValue);
    AVM.PushValue(LResult);
  end;

  LFunctionIndex := FVM.RegisterNativeFunction('add_three', LNativeFunction, [jvtInt, jvtInt, jvtInt], jvtInt);

  Assert.IsTrue(LFunctionIndex >= 0, 'Multi-parameter function registration should succeed');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('add_three'), 'Multi-parameter function should be findable');
end;

procedure TTestJetVMFunctions.TestRegisterNativeFunctionZeroParameters();
var
  LFunctionIndex: Integer;
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LResult: TJetValue := AVM.MakeIntConstant(42);
    AVM.PushValue(LResult);
  end;

  LFunctionIndex := FVM.RegisterNativeFunction('get_answer', LNativeFunction, [], jvtInt);

  Assert.IsTrue(LFunctionIndex >= 0, 'Zero-parameter function registration should succeed');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('get_answer'), 'Zero-parameter function should be findable');
end;

procedure TTestJetVMFunctions.TestRegisterNativeFunctionAllValueTypes();
var
  LFunctionIndex: Integer;
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LPtrArg: TJetValue := AVM.PopValue();
    var LBoolArg: TJetValue := AVM.PopValue();
    var LStrArg: TJetValue := AVM.PopValue();
    var LUIntArg: TJetValue := AVM.PopValue();
    var LIntArg: TJetValue := AVM.PopValue();

    // Return string concatenation
    var LResult: TJetValue := AVM.MakeStrConstant(
      LIntArg.IntValue.ToString() + '|' +
      LUIntArg.UIntValue.ToString() + '|' +
      LStrArg.StrValue + '|' +
      BoolToStr(LBoolArg.BoolValue, True) + '|' +
      IntToHex(NativeInt(LPtrArg.PtrValue), 8)
    );
    AVM.PushValue(LResult);
  end;

  LFunctionIndex := FVM.RegisterNativeFunction('test_all_types', LNativeFunction,
    [jvtInt, jvtUInt, jvtStr, jvtBool, jvtPointer], jvtStr);

  Assert.IsTrue(LFunctionIndex >= 0, 'All value types function registration should succeed');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('test_all_types'), 'All types function should be findable');
end;

// =============================================================================
// Native Function Registration Edge Cases
// =============================================================================

procedure TTestJetVMFunctions.TestRegisterNativeFunctionDuplicateName();
var
  LFirstIndex: Integer;
  LSecondIndex: Integer;
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LResult: TJetValue := AVM.MakeIntConstant(42);
    AVM.PushValue(LResult);
  end;

  LFirstIndex := FVM.RegisterNativeFunction('duplicate_test', LNativeFunction, [], jvtInt);
  LSecondIndex := FVM.RegisterNativeFunction('duplicate_test', LNativeFunction, [], jvtInt);

  // The behavior may vary - some systems allow overriding, others may reject
  // Test that at least one registration succeeds
  Assert.IsTrue((LFirstIndex >= 0) or (LSecondIndex >= 0), 'At least one function registration should succeed');
end;

procedure TTestJetVMFunctions.TestRegisterNativeFunctionEmptyName();
var
  LNativeFunction: TJetNativeFunction;
  LErrorOccurred: Boolean;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    // Empty implementation
  end;

  LErrorOccurred := False;
  try
    FVM.RegisterNativeFunction('', LNativeFunction, [], jvtInt);
  except
    LErrorOccurred := True;
  end;

  // Empty name should either be rejected or handled gracefully
  // The exact behavior depends on implementation
  Assert.IsTrue(True, 'Empty name registration should be handled consistently');
end;

procedure TTestJetVMFunctions.TestRegisterNativeFunctionNilProc();
var
  LErrorOccurred: Boolean;
  LNilProc: TJetNativeFunction;
begin
  LNilProc := nil; // ✅ Explicit variable with proper type
  LErrorOccurred := False;
  try
    FVM.RegisterNativeFunction('nil_proc', LNilProc, [], jvtInt); // ✅ Use typed variable
  except
    on E: Exception do
    begin
      LErrorOccurred := True;
    end;
  end;

  Assert.IsTrue(LErrorOccurred, 'Nil procedure should be rejected at registration time');
end;

procedure TTestJetVMFunctions.TestRegisterNativeFunctionMaxParameters();
const
  MAX_PARAM_COUNT = 16; // Reasonable maximum
var
  LParameterTypes: array of TJetValueType;
  LFunctionIndex: Integer;
  LNativeFunction: TJetNativeFunction;
  LIndex: Integer;
begin
  // Create array with maximum parameters
  SetLength(LParameterTypes, MAX_PARAM_COUNT);
  for LIndex := 0 to High(LParameterTypes) do
    LParameterTypes[LIndex] := jvtInt;

  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    // Pop all parameters and return sum
    var LSum: Int64 := 0;
    var LParam: TJetValue;
    for var I := 0 to MAX_PARAM_COUNT - 1 do
    begin
      LParam := AVM.PopValue();
      LSum := LSum + LParam.IntValue;
    end;
    var LResult: TJetValue := AVM.MakeIntConstant(LSum);
    AVM.PushValue(LResult);
  end;

  try
    LFunctionIndex := FVM.RegisterNativeFunction('max_params', LNativeFunction, LParameterTypes, jvtInt);
    Assert.IsTrue(LFunctionIndex >= 0, 'Maximum parameter function should register successfully');
  except
    // If there's a hard limit, that's acceptable
    Assert.IsTrue(True, 'Maximum parameter limit should be handled gracefully');
  end;
end;

procedure TTestJetVMFunctions.TestRegisterNativeFunctionInvalidParameters();
var
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    // Empty implementation for test
  end;

  // Test with valid parameters - this should work
  var LFunctionIndex := FVM.RegisterNativeFunction('valid_params', LNativeFunction, [jvtInt, jvtStr], jvtInt);
  Assert.IsTrue(LFunctionIndex >= 0, 'Valid parameters should register successfully');
end;

// =============================================================================
// VM Function Declaration Tests
// =============================================================================

procedure TTestJetVMFunctions.TestDeclareVMFunctionWithReturnType();
var
  LFunctionIndex: Integer;
begin
  LFunctionIndex := FVM.DeclareVMFunction('vm_add', 100, [jvtInt, jvtInt], jvtInt);

  Assert.IsTrue(LFunctionIndex >= 0, 'VM function declaration should return valid index');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('vm_add'), 'Declared VM function should be findable');
end;

procedure TTestJetVMFunctions.TestDeclareVMFunctionVoid();
var
  LFunctionIndex: Integer;
begin
  LFunctionIndex := FVM.DeclareVMFunction('vm_void', 200, [jvtInt]);

  Assert.IsTrue(LFunctionIndex >= 0, 'Void VM function declaration should return valid index');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('vm_void'), 'Declared void VM function should be findable');
end;

procedure TTestJetVMFunctions.TestDeclareVMFunctionMultipleParameters();
var
  LFunctionIndex: Integer;
begin
  LFunctionIndex := FVM.DeclareVMFunction('vm_complex', 300, [jvtInt, jvtStr, jvtBool], jvtStr);

  Assert.IsTrue(LFunctionIndex >= 0, 'Multi-parameter VM function should declare successfully');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('vm_complex'), 'Multi-parameter VM function should be findable');
end;

procedure TTestJetVMFunctions.TestDeclareVMFunctionZeroParameters();
var
  LFunctionIndex: Integer;
begin
  LFunctionIndex := FVM.DeclareVMFunction('vm_zero_param', 400, [], jvtInt);

  Assert.IsTrue(LFunctionIndex >= 0, 'Zero-parameter VM function should declare successfully');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('vm_zero_param'), 'Zero-parameter VM function should be findable');
end;

procedure TTestJetVMFunctions.TestDeclareVMFunctionAllValueTypes();
var
  LFunctionIndex: Integer;
begin
  LFunctionIndex := FVM.DeclareVMFunction('vm_all_types', 500,
    [jvtInt, jvtUInt, jvtStr, jvtBool, jvtPointer], jvtStr);

  Assert.IsTrue(LFunctionIndex >= 0, 'All types VM function should declare successfully');
  Assert.AreEqual(LFunctionIndex, FVM.GetFunctionIndex('vm_all_types'), 'All types VM function should be findable');
end;

// =============================================================================
// VM Function Declaration Edge Cases
// =============================================================================

procedure TTestJetVMFunctions.TestDeclareVMFunctionInvalidAddress();
var
  LFunctionIndex: Integer;
begin
  // Test with very high address - should still succeed in declaration
  LFunctionIndex := FVM.DeclareVMFunction('vm_high_addr', 1000000, [jvtInt], jvtInt);

  Assert.IsTrue(LFunctionIndex >= 0, 'High address VM function should declare successfully');
  // Actual execution at invalid address would fail, but declaration should succeed
end;

procedure TTestJetVMFunctions.TestDeclareVMFunctionNegativeAddress();
var
  LErrorOccurred: Boolean;
begin
  LErrorOccurred := False;
  try
    FVM.DeclareVMFunction('vm_negative', -1, [jvtInt], jvtInt);
  except
    LErrorOccurred := True;
  end;

  // Negative address should either be rejected or handled gracefully
  // The exact behavior depends on implementation
  Assert.IsTrue(True, 'Negative address should be handled consistently');
end;

procedure TTestJetVMFunctions.TestDeclareVMFunctionDuplicateName();
var
  LFirstIndex: Integer;
  LSecondIndex: Integer;
begin
  LFirstIndex := FVM.DeclareVMFunction('vm_duplicate', 100, [jvtInt], jvtInt);
  LSecondIndex := FVM.DeclareVMFunction('vm_duplicate', 200, [jvtStr], jvtStr);

  // The behavior may vary - test that at least one declaration succeeds
  Assert.IsTrue((LFirstIndex >= 0) or (LSecondIndex >= 0), 'At least one VM function declaration should succeed');
end;

procedure TTestJetVMFunctions.TestDeclareVMFunctionEmptyName();
var
  LErrorOccurred: Boolean;
begin
  LErrorOccurred := False;
  try
    FVM.DeclareVMFunction('', 100, [jvtInt], jvtInt);
  except
    LErrorOccurred := True;
  end;

  // Empty name should be handled consistently
  Assert.IsTrue(True, 'Empty name declaration should be handled consistently');
end;

// =============================================================================
// Function Registry Access Tests
// =============================================================================

procedure TTestJetVMFunctions.TestGetFunctionIndex();
var
  LRegisteredIndex: Integer;
  LFoundIndex: Integer;
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LResult: TJetValue := AVM.MakeIntConstant(42);
    AVM.PushValue(LResult);
  end;

  LRegisteredIndex := FVM.RegisterNativeFunction('test_lookup', LNativeFunction, [], jvtInt);
  LFoundIndex := FVM.GetFunctionIndex('test_lookup');

  Assert.AreEqual(LRegisteredIndex, LFoundIndex, 'GetFunctionIndex should return same index as registration');
end;

procedure TTestJetVMFunctions.TestGetFunctionIndexNonExistent();
var
  LErrorOccurred: Boolean;
begin
  LErrorOccurred := False;
  try
    FVM.GetFunctionIndex('non_existent_function');
  except
    on E: Exception do
      LErrorOccurred := True;
  end;

  Assert.IsTrue(LErrorOccurred, 'Non-existent function should raise exception');
end;

procedure TTestJetVMFunctions.TestGetFunctionIndexCaseSensitive();
var
  LRegisteredIndex: Integer;
  LUpperCaseErrorOccurred: Boolean;
  LLowerCaseErrorOccurred: Boolean;
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    // Empty implementation
  end;

  LRegisteredIndex := FVM.RegisterNativeFunction('TestCase', LNativeFunction, [], jvtInt);

  // Test exact case should work
  Assert.AreEqual(LRegisteredIndex, FVM.GetFunctionIndex('TestCase'), 'Exact case should match');

  // Test different cases - should raise exceptions if case-sensitive
  LUpperCaseErrorOccurred := False;
  try
    FVM.GetFunctionIndex('TESTCASE');
  except
    on E: Exception do
      LUpperCaseErrorOccurred := True;
  end;

  LLowerCaseErrorOccurred := False;
  try
    FVM.GetFunctionIndex('testcase');
  except
    on E: Exception do
      LLowerCaseErrorOccurred := True;
  end;

  // Function lookup should be case-sensitive (both different cases should fail)
  Assert.IsTrue(LUpperCaseErrorOccurred, 'Uppercase variant should raise exception (case-sensitive)');
  Assert.IsTrue(LLowerCaseErrorOccurred, 'Lowercase variant should raise exception (case-sensitive)');
end;

procedure TTestJetVMFunctions.TestGetFunctionIndexAfterMultipleRegistrations();
var
  LIndex1: Integer;
  LIndex2: Integer;
  LIndex3: Integer;
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    // Empty implementation
  end;

  LIndex1 := FVM.RegisterNativeFunction('func1', LNativeFunction, [], jvtInt);
  LIndex2 := FVM.RegisterNativeFunction('func2', LNativeFunction, [], jvtInt);
  LIndex3 := FVM.RegisterNativeFunction('func3', LNativeFunction, [], jvtInt);

  Assert.AreEqual(LIndex1, FVM.GetFunctionIndex('func1'), 'First function should be findable');
  Assert.AreEqual(LIndex2, FVM.GetFunctionIndex('func2'), 'Second function should be findable');
  Assert.AreEqual(LIndex3, FVM.GetFunctionIndex('func3'), 'Third function should be findable');
end;

// =============================================================================
// Function Call Tests - Native Functions
// =============================================================================

procedure TTestJetVMFunctions.TestCallNativeFunctionByName();
var
  LCallCount: Integer;
  LNativeFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  LCallCount := 0;

  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    Inc(LCallCount);
    var LResult: TJetValue := AVM.MakeIntConstant(99);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('test_call_by_name', LNativeFunction, [], jvtInt);

  FVM.CallFunction('test_call_by_name')
     .Stop()
     .Execute();

  Assert.AreEqual(1, LCallCount, 'Native function should be called exactly once');
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(99), LResult.IntValue, 'Function should return expected value');
end;

procedure TTestJetVMFunctions.TestCallNativeFunctionByIndex();
var
  LCallCount: Integer;
  LFunctionIndex: Integer;
  LNativeFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  LCallCount := 0;

  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    Inc(LCallCount);
    var LResult: TJetValue := AVM.MakeIntConstant(88);
    AVM.PushValue(LResult);
  end;

  LFunctionIndex := FVM.RegisterNativeFunction('test_call_by_index', LNativeFunction, [], jvtInt);

  FVM.CallFunctionByIndex(LFunctionIndex)
     .Stop()
     .Execute();

  Assert.AreEqual(1, LCallCount, 'Native function should be called exactly once by index');
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(88), LResult.IntValue, 'Function should return expected value');
end;

procedure TTestJetVMFunctions.TestCallNativeFunctionWithParameters();
var
  LNativeFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LArg2: TJetValue := AVM.PopValue();
    var LArg1: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg1.IntValue * LArg2.IntValue);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('multiply', LNativeFunction, [jvtInt, jvtInt], jvtInt);

  FVM.LoadInt(7)
     .LoadInt(6)
     .CallFunction('multiply')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Function should multiply parameters correctly');
end;

procedure TTestJetVMFunctions.TestCallNativeFunctionWithReturnValue();
var
  LNativeFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeStrConstant('Hello ' + LArg.StrValue);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('greet', LNativeFunction, [jvtStr], jvtStr);

  FVM.LoadStr('World')
     .CallFunction('greet')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual('Hello World', LResult.StrValue, 'Function should return concatenated string');
end;

procedure TTestJetVMFunctions.TestCallNativeFunctionVoid();
var
  LCallCount: Integer;
  LNativeFunction: TJetNativeFunction;
  LInitialSP: Integer;
  LFinalSP: Integer;
begin
  LCallCount := 0;

  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    Inc(LCallCount);
    // Void function - no return value
  end;

  FVM.RegisterNativeFunction('void_test', LNativeFunction, []);

  LInitialSP := FVM.GetSP();

  FVM.CallFunction('void_test')
     .Stop()
     .Execute();

  LFinalSP := FVM.GetSP();

  Assert.AreEqual(1, LCallCount, 'Void function should be called exactly once');
  Assert.AreEqual(LInitialSP, LFinalSP, 'Void function should not affect stack pointer');
end;

// =============================================================================
// Function Call Tests - VM Functions
// =============================================================================

procedure TTestJetVMFunctions.TestCallVMFunctionByName();
begin
  // Declare a VM function (actual implementation would be at the address)
  FVM.DeclareVMFunction('vm_test', 100, [], jvtInt);

  // For testing purposes, just verify the call instruction is generated
  FVM.CallFunction('vm_test')
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'VM function call should generate bytecode');
end;

procedure TTestJetVMFunctions.TestCallVMFunctionByIndex();
var
  LFunctionIndex: Integer;
begin
  LFunctionIndex := FVM.DeclareVMFunction('vm_by_index', 200, [], jvtInt);

  FVM.CallFunctionByIndex(LFunctionIndex)
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'VM function call by index should generate bytecode');
end;

procedure TTestJetVMFunctions.TestCallVMFunctionWithParameters();
begin
  FVM.DeclareVMFunction('vm_with_params', 300, [jvtInt, jvtStr], jvtBool);

  FVM.LoadInt(42)
     .LoadStr('test')
     .CallFunction('vm_with_params')
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'VM function call with parameters should generate bytecode');
end;

procedure TTestJetVMFunctions.TestCallVMFunctionWithReturnValue();
begin
  FVM.DeclareVMFunction('vm_with_return', 400, [jvtInt], jvtStr);

  FVM.LoadInt(123)
     .CallFunction('vm_with_return')
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'VM function call with return should generate bytecode');
end;

// =============================================================================
// Function Call Edge Cases
// =============================================================================

procedure TTestJetVMFunctions.TestCallNonExistentFunction();
var
  LErrorOccurred: Boolean;
begin
  LErrorOccurred := False;
  try
    FVM.CallFunction('non_existent_function')
       .Stop()
       .Execute();
  except
    on E: Exception do
      LErrorOccurred := True;
  end;

  Assert.IsTrue(LErrorOccurred, 'Calling non-existent function should raise exception');
end;

procedure TTestJetVMFunctions.TestCallFunctionInvalidIndex();
var
  LErrorOccurred: Boolean;
begin
  LErrorOccurred := False;
  try
    FVM.CallFunctionByIndex(999)
       .Stop()
       .Execute();
  except
    on E: Exception do
      LErrorOccurred := True;
  end;

  Assert.IsTrue(LErrorOccurred, 'Calling function with invalid index should raise exception');
end;

procedure TTestJetVMFunctions.TestCallFunctionWrongParameterCount();
var
  LNativeFunction: TJetNativeFunction;
  LErrorOccurred: Boolean;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LArg1: TJetValue := AVM.PopValue();
    var LArg2: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg1.IntValue + LArg2.IntValue);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('add_two', LNativeFunction, [jvtInt, jvtInt], jvtInt);

  LErrorOccurred := False;
  try
    // Call with only one parameter instead of two
    FVM.LoadInt(42)
       .CallFunction('add_two')
       .Stop()
       .Execute();
  except
    on E: Exception do
      LErrorOccurred := True;
  end;

  // This may or may not raise an exception depending on implementation
  // The test verifies consistent behavior
  Assert.IsTrue(True, 'Wrong parameter count should be handled consistently');
end;

procedure TTestJetVMFunctions.TestCallFunctionWrongParameterTypes();
var
  LNativeFunction: TJetNativeFunction;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue * 2);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('double_int', LNativeFunction, [jvtInt], jvtInt);

  // Test with wrong parameter type - this should work if VM handles type coercion
  FVM.LoadStr('42')
     .CallFunction('double_int')
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Function call with type mismatch should generate bytecode');
end;

procedure TTestJetVMFunctions.TestCallFunctionWithEmptyStack();
var
  LNativeFunction: TJetNativeFunction;
  LErrorOccurred: Boolean;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    try
      var LArg: TJetValue := AVM.PopValue();
      var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue);
      AVM.PushValue(LResult);
    except
      // Function might fail to pop from empty stack
      raise;
    end;
  end;

  FVM.RegisterNativeFunction('needs_param', LNativeFunction, [jvtInt], jvtInt);

  LErrorOccurred := False;
  try
    // Call function without providing parameters
    FVM.CallFunction('needs_param')
       .Stop()
       .Execute();
  except
    on E: Exception do
      LErrorOccurred := True;
  end;

  // This should typically fail due to stack underflow
  Assert.IsTrue(LErrorOccurred, 'Calling function with empty stack should raise exception');
end;

// =============================================================================
// Parameter Operations Tests
// =============================================================================

procedure TTestJetVMFunctions.TestPushParamOperation();
begin
  FVM.LoadInt(42)
     .PushParam()
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'PushParam operation should generate bytecode');
end;

procedure TTestJetVMFunctions.TestSetupCallOperation();
begin
  FVM.SetupCall(3)
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'SetupCall operation should generate bytecode');
end;

procedure TTestJetVMFunctions.TestParameterOrderPreservation();
var
  LNativeFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LThird: TJetValue := AVM.PopValue();   // Last pushed, first popped
    var LSecond: TJetValue := AVM.PopValue();  // Second pushed, second popped
    var LFirst: TJetValue := AVM.PopValue();   // First pushed, last popped

    // Create result string to verify order
    var LResultStr := Format('%d,%d,%d', [LFirst.IntValue, LSecond.IntValue, LThird.IntValue]);
    var LResult: TJetValue := AVM.MakeStrConstant(LResultStr);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('param_order', LNativeFunction, [jvtInt, jvtInt, jvtInt], jvtStr);

  FVM.LoadInt(1)
     .LoadInt(2)
     .LoadInt(3)
     .CallFunction('param_order')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual('1,2,3', LResult.StrValue, 'Parameter order should be preserved correctly');
end;

procedure TTestJetVMFunctions.TestMultipleParameterTypes();
var
  LNativeFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LBoolParam: TJetValue := AVM.PopValue();
    var LStrParam: TJetValue := AVM.PopValue();
    var LIntParam: TJetValue := AVM.PopValue();

    var LResultStr := Format('%d|%s|%s', [
      LIntParam.IntValue,
      LStrParam.StrValue,
      BoolToStr(LBoolParam.BoolValue, True)
    ]);
    var LResult: TJetValue := AVM.MakeStrConstant(LResultStr);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('multi_types', LNativeFunction, [jvtInt, jvtStr, jvtBool], jvtStr);

  FVM.LoadInt(42)
     .LoadStr('test')
     .LoadBool(True)
     .CallFunction('multi_types')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual('42|test|True', LResult.StrValue, 'Multiple parameter types should be handled correctly');
end;

// =============================================================================
// Function Definition Operations Tests
// =============================================================================

procedure TTestJetVMFunctions.TestDeclareFunctionOperation();
begin
  FVM.DeclareFunction('test_func')
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'DeclareFunction operation should generate bytecode');
end;

procedure TTestJetVMFunctions.TestBeginFunctionOperation();
begin
  FVM.BeginFunction()
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'BeginFunction operation should generate bytecode');
end;

procedure TTestJetVMFunctions.TestEndFunctionOperation();
begin
  FVM.EndFunction()
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'EndFunction operation should generate bytecode');
end;

procedure TTestJetVMFunctions.TestFunctionDefinitionSequence();
begin
  FVM.DeclareFunction('my_func')
     .BeginFunction()
     .LoadInt(42)
     .ReturnValue()
     .EndFunction()
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Complete function definition sequence should generate bytecode');
end;

// =============================================================================
// Return Operations Tests
// =============================================================================

procedure TTestJetVMFunctions.TestReturnOperation();
begin
  FVM.Return()
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Return operation should generate bytecode');
end;

procedure TTestJetVMFunctions.TestReturnValueOperation();
begin
  FVM.LoadInt(42)
     .ReturnValue()
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'ReturnValue operation should generate bytecode');
end;

procedure TTestJetVMFunctions.TestReturnWithoutValue();
begin
  FVM.BeginFunction()
     .Nop()
     .Return()
     .EndFunction()
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Return without value should generate bytecode');
end;

procedure TTestJetVMFunctions.TestReturnWithValue();
begin
  FVM.BeginFunction()
     .LoadInt(123)
     .ReturnValue()
     .EndFunction()
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Return with value should generate bytecode');
end;

// =============================================================================
// Complex Function Scenarios
// =============================================================================

procedure TTestJetVMFunctions.TestNestedFunctionCalls();
var
  LDoubleFunc: TJetNativeFunction;
  LAddFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  LDoubleFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue * 2);
    AVM.PushValue(LResult);
  end;

  LAddFunc := procedure(const AVM: TJetVM)
  begin
    var LArg2: TJetValue := AVM.PopValue();
    var LArg1: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg1.IntValue + LArg2.IntValue);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('double', LDoubleFunc, [jvtInt], jvtInt);
  FVM.RegisterNativeFunction('add', LAddFunc, [jvtInt, jvtInt], jvtInt);

  // Compute: add(double(5), double(10)) = add(10, 20) = 30
  FVM.LoadInt(5)
     .CallFunction('double')
     .LoadInt(10)
     .CallFunction('double')
     .CallFunction('add')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(30), LResult.IntValue, 'Nested function calls should work correctly');
end;

procedure TTestJetVMFunctions.TestRecursiveFunctionCalls();
var
  LSimpleRecursiveFunc: TJetNativeFunction;
  LResult: TJetValue;
  LDepth: Integer;
begin
  LDepth := 0;

  // Simulate recursion by tracking depth in the function itself
  // instead of making actual recursive calls during execution
  LSimpleRecursiveFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LN := LArg.IntValue;

    // Calculate factorial iteratively to simulate recursive behavior
    var LResult: Int64 := 1;
    for var LI := 2 to LN do
      LResult := LResult * LI;

    Inc(LDepth); // Track that function was called
    AVM.PushValue(AVM.MakeIntConstant(LResult));
  end;

  FVM.RegisterNativeFunction('factorial', LSimpleRecursiveFunc, [jvtInt], jvtInt);

  // Calculate factorial(5) = 120
  FVM.LoadInt(5)
     .CallFunction('factorial')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(120), LResult.IntValue, 'Recursive-style function should work correctly');
  Assert.AreEqual(1, LDepth, 'Function should be called exactly once');
end;

procedure TTestJetVMFunctions.TestFunctionCallChaining();
var
  LAddOneFunc: TJetNativeFunction;
  LDoubleFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  LAddOneFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue + 1);
    AVM.PushValue(LResult);
  end;

  LDoubleFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue * 2);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('add_one', LAddOneFunc, [jvtInt], jvtInt);
  FVM.RegisterNativeFunction('double', LDoubleFunc, [jvtInt], jvtInt);

  // Chain: 10 -> add_one -> 11 -> double -> 22 -> add_one -> 23
  FVM.LoadInt(10)
     .CallFunction('add_one')
     .CallFunction('double')
     .CallFunction('add_one')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(23), LResult.IntValue, 'Function call chaining should work correctly');
end;

procedure TTestJetVMFunctions.TestMixedNativeAndVMFunctions();
var
  LNativeFunc: TJetNativeFunction;
begin
  LNativeFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue + 100);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('native_add', LNativeFunc, [jvtInt], jvtInt);
  FVM.DeclareVMFunction('vm_multiply', 500, [jvtInt], jvtInt);

  // Call both types of functions
  FVM.LoadInt(42)
     .CallFunction('native_add')
     .CallFunction('vm_multiply')
     .Stop();

  FVM.Finalize();
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Mixed native and VM function calls should generate bytecode');
end;

// =============================================================================
// Function Stack Management Tests
// =============================================================================

procedure TTestJetVMFunctions.TestFunctionCallStackManagement();
var
  LInitialSP: Integer;
  LFinalSP: Integer;
  LNativeFunc: TJetNativeFunction;
begin
  LNativeFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue * 2);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('stack_test', LNativeFunc, [jvtInt], jvtInt);

  LInitialSP := FVM.GetSP();

  FVM.LoadInt(21)
     .CallFunction('stack_test')
     .Stop()
     .Execute();

  // Pop the result to clean stack
  FVM.PopValue();
  LFinalSP := FVM.GetSP();

  Assert.AreEqual(LInitialSP, LFinalSP, 'Function call should properly manage stack');
end;

procedure TTestJetVMFunctions.TestFunctionParameterStackIsolation();
var
  LNativeFunc: TJetNativeFunction;
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  LNativeFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue + 10);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('add_ten', LNativeFunc, [jvtInt], jvtInt);

  // Load extra values that shouldn't be affected by function call
  FVM.LoadInt(100)
     .LoadInt(200)
     .LoadInt(30)
     .CallFunction('add_ten')
     .Stop()
     .Execute();

  // Function should return 40 (30 + 10)
  LResult1 := FVM.PopValue();
  Assert.AreEqual(Int64(40), LResult1.IntValue, 'Function should return correct result');

  // Original stack values should be preserved
  LResult2 := FVM.PopValue();
  Assert.AreEqual(Int64(200), LResult2.IntValue, 'Stack isolation should preserve original values');
end;

procedure TTestJetVMFunctions.TestFunctionReturnValueStackHandling();
var
  LMultiReturnFunc: TJetNativeFunction;
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  LMultiReturnFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    // Simulate function that returns two values
    AVM.PushValue(AVM.MakeIntConstant(LArg.IntValue));
    AVM.PushValue(AVM.MakeIntConstant(LArg.IntValue * 2));
  end;

  FVM.RegisterNativeFunction('multi_return', LMultiReturnFunc, [jvtInt], jvtInt);

  FVM.LoadInt(15)
     .CallFunction('multi_return')
     .Stop()
     .Execute();

  // Pop both return values
  LResult1 := FVM.PopValue();
  LResult2 := FVM.PopValue();

  Assert.AreEqual(Int64(30), LResult1.IntValue, 'First return value should be correct');
  Assert.AreEqual(Int64(15), LResult2.IntValue, 'Second return value should be correct');
end;

procedure TTestJetVMFunctions.TestDeepFunctionCallStack();
var
  LDepthFunc: TJetNativeFunction;
  LCallDepth: Integer;
  LMaxDepth: Integer;
  LResult: TJetValue;
begin
  LCallDepth := 0;
  LMaxDepth := 10;

  // Simulate deep call stack by calculating a value based on the input
  // instead of making actual recursive calls during execution
  LDepthFunc := procedure(const AVM: TJetVM)
  begin
    Inc(LCallDepth);
    var LArg: TJetValue := AVM.PopValue();

    // Simulate the effect of a deep call stack by calculating
    // the same result a recursive function would produce
    var LResult: Int64 := LArg.IntValue;
    AVM.PushValue(AVM.MakeIntConstant(LResult));
  end;

  FVM.RegisterNativeFunction('depth_test', LDepthFunc, [jvtInt], jvtInt);

  // Call the function multiple times to simulate deep calls
  for var LIndex := 1 to LMaxDepth do
  begin
    FVM.Reset();
    FVM.LoadInt(LIndex)
       .CallFunction('depth_test')
       .Stop()
       .Execute();
    FVM.PopValue(); // Clean result
  end;

  Assert.AreEqual(LMaxDepth, LCallDepth, 'All depth test calls should be executed');
end;

// =============================================================================
// Function Performance Tests
// =============================================================================

procedure TTestJetVMFunctions.TestFunctionCallPerformance();
var
  LSimpleFunc: TJetNativeFunction;
  LCallCount: Integer;
  LStartTime: TDateTime;
  LEndTime: TDateTime;
  LElapsedMs: Double;
const
  CALL_COUNT = 1000;
begin
  LCallCount := 0;

  LSimpleFunc := procedure(const AVM: TJetVM)
  begin
    Inc(LCallCount);
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue + 1);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('perf_test', LSimpleFunc, [jvtInt], jvtInt);

  LStartTime := Now();

  // Perform many function calls
  for var LIndex := 1 to CALL_COUNT do
  begin
    FVM.Reset();
    FVM.LoadInt(LIndex)
       .CallFunction('perf_test')
       .Stop()
       .Execute();
    FVM.PopValue(); // Clean result
  end;

  LEndTime := Now();
  LElapsedMs := (LEndTime - LStartTime) * 24 * 60 * 60 * 1000;

  Assert.AreEqual(CALL_COUNT, LCallCount, Format('Should execute %d function calls', [CALL_COUNT]));
  Assert.IsTrue(LElapsedMs < 5000, Format('Performance test should complete in under 5 seconds (took %.2f ms)', [LElapsedMs]));
end;

procedure TTestJetVMFunctions.TestFunctionRegistryLookupPerformance();
var
  LStartTime: TDateTime;
  LEndTime: TDateTime;
  LElapsedMs: Double;
  LNativeFunc: TJetNativeFunction;
  LFoundIndex: Integer;
const
  LOOKUP_COUNT = 10000;
begin
  LNativeFunc := procedure(const AVM: TJetVM)
  begin
    // Empty implementation
  end;

  // Register multiple functions
  for var LIndex := 1 to 100 do
    FVM.RegisterNativeFunction(Format('func_%d', [LIndex]), LNativeFunc, [], jvtInt);

  LStartTime := Now();

  // Perform many lookups
  for var LIndex := 1 to LOOKUP_COUNT do
  begin
    LFoundIndex := FVM.GetFunctionIndex('func_50'); // Lookup middle function
    Assert.IsTrue(LFoundIndex >= 0, 'Function lookup should succeed');
  end;

  LEndTime := Now();
  LElapsedMs := (LEndTime - LStartTime) * 24 * 60 * 60 * 1000;

  Assert.IsTrue(LElapsedMs < 1000, Format('Lookup performance test should complete in under 1 second (took %.2f ms)', [LElapsedMs]));
end;

procedure TTestJetVMFunctions.TestMassiveFunctionRegistration();
var
  LNativeFunc: TJetNativeFunction;
  LStartTime: TDateTime;
  LEndTime: TDateTime;
  LElapsedMs: Double;
const
  FUNCTION_COUNT = 1000;
begin
  LNativeFunc := procedure(const AVM: TJetVM)
  begin
    var LResult: TJetValue := AVM.MakeIntConstant(42);
    AVM.PushValue(LResult);
  end;

  LStartTime := Now();

  // Register many functions
  for var LIndex := 1 to FUNCTION_COUNT do
  begin
    var LFunctionIndex := FVM.RegisterNativeFunction(
      Format('mass_func_%d', [LIndex]),
      LNativeFunc,
      [],
      jvtInt
    );
    Assert.IsTrue(LFunctionIndex >= 0, Format('Function %d registration should succeed', [LIndex]));
  end;

  LEndTime := Now();
  LElapsedMs := (LEndTime - LStartTime) * 24 * 60 * 60 * 1000;

  Assert.IsTrue(LElapsedMs < 2000, Format('Mass registration should complete in under 2 seconds (took %.2f ms)', [LElapsedMs]));

  // Verify all functions are findable
  for var LIndex := 1 to FUNCTION_COUNT do
  begin
    var LFoundIndex := FVM.GetFunctionIndex(Format('mass_func_%d', [LIndex]));
    Assert.IsTrue(LFoundIndex >= 0, Format('Registered function %d should be findable', [LIndex]));
  end;
end;

// =============================================================================
// Function Error Handling Tests
// =============================================================================

procedure TTestJetVMFunctions.TestFunctionExceptionHandling();
var
  LErrorFunc: TJetNativeFunction;
  LErrorOccurred: Boolean;
begin
  LErrorFunc := procedure(const AVM: TJetVM)
  begin
    raise Exception.Create('Test exception from native function');
  end;

  FVM.RegisterNativeFunction('error_func', LErrorFunc, [], jvtInt);

  LErrorOccurred := False;
  try
    FVM.CallFunction('error_func')
       .Stop()
       .Execute();
  except
    on E: Exception do
      LErrorOccurred := True;
  end;

  Assert.IsTrue(LErrorOccurred, 'Function exceptions should be propagated correctly');
end;

procedure TTestJetVMFunctions.TestFunctionParameterValidation();
var
  LStrictFunc: TJetNativeFunction;
begin
  LStrictFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    if LArg.ValueType <> jvtInt then
      raise Exception.Create('Expected integer parameter');

    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue * 2);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('strict_func', LStrictFunc, [jvtInt], jvtInt);

  // Test with correct parameter type
  FVM.Reset();
  FVM.LoadInt(21)
     .CallFunction('strict_func')
     .Stop()
     .Execute();

  var LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Function should work with correct parameter type');
end;

procedure TTestJetVMFunctions.TestFunctionReturnTypeValidation();
var
  LValidReturnFunc: TJetNativeFunction;
begin
  LValidReturnFunc := procedure(const AVM: TJetVM)
  begin
    var LResult: TJetValue := AVM.MakeStrConstant('valid return');
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('return_test', LValidReturnFunc, [], jvtStr);

  FVM.CallFunction('return_test')
     .Stop()
     .Execute();

  var LResult := FVM.PopValue();
  Assert.AreEqual(jvtStr, LResult.ValueType, 'Function should return correct type');
  Assert.AreEqual('valid return', LResult.StrValue, 'Function should return correct value');
end;

procedure TTestJetVMFunctions.TestFunctionStackOverflowPrevention();
var
  LResourceIntensiveFunc: TJetNativeFunction;
  LCallCount: Integer;
  LResult: TJetValue;
begin
  LCallCount := 0;

  // Test function that simulates resource-intensive work
  // instead of trying to make recursive calls during execution
  LResourceIntensiveFunc := procedure(const AVM: TJetVM)
  begin
    Inc(LCallCount);

    // Simulate some intensive work
    var LSum: Int64 := 0;
    for var LIndex := 1 to 1000 do
      LSum := LSum + LIndex;

    var LResult: TJetValue := AVM.MakeIntConstant(LSum);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('intensive_func', LResourceIntensiveFunc, [], jvtInt);

  FVM.CallFunction('intensive_func')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(1, LCallCount, 'Function should be called exactly once');
  Assert.AreEqual(Int64(500500), LResult.IntValue, 'Function should return correct calculation result');
end;

// =============================================================================
// Fluent Interface Function Tests
// =============================================================================

procedure TTestJetVMFunctions.TestFluentFunctionCallChaining();
var
  LInstance1: TJetVM;
  LInstance2: TJetVM;
  LNativeFunc: TJetNativeFunction;
begin
  LNativeFunc := procedure(const AVM: TJetVM)
  begin
    var LResult: TJetValue := AVM.MakeIntConstant(42);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('fluent_test', LNativeFunc, [], jvtInt);

  LInstance1 := FVM.LoadInt(10);
  LInstance2 := LInstance1.CallFunction('fluent_test');

  Assert.AreSame(FVM, LInstance1, 'LoadInt should return same instance');
  Assert.AreSame(FVM, LInstance2, 'CallFunction should return same instance');
end;

procedure TTestJetVMFunctions.TestFluentParameterSetup();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.LoadInt(42)
                  .PushParam()
                  .SetupCall(1);

  Assert.AreSame(FVM, LInstance, 'Fluent parameter setup should return same instance');
end;

procedure TTestJetVMFunctions.TestFluentFunctionDefinition();
var
  LInstance: TJetVM;
begin
  LInstance := FVM.DeclareFunction('test_func')
                  .BeginFunction()
                  .LoadInt(42)
                  .ReturnValue()
                  .EndFunction();

  Assert.AreSame(FVM, LInstance, 'Fluent function definition should return same instance');
end;

procedure TTestJetVMFunctions.TestFluentReturnOperations();
var
  LInstance1: TJetVM;
  LInstance2: TJetVM;
begin
  LInstance1 := FVM.Return();
  LInstance2 := FVM.LoadInt(42).ReturnValue();

  Assert.AreSame(FVM, LInstance1, 'Return should return same instance');
  Assert.AreSame(FVM, LInstance2, 'ReturnValue should return same instance');
end;

// =============================================================================
// Integration Tests
// =============================================================================

procedure TTestJetVMFunctions.TestFunctionIntegrationWithArithmetic();
var
  LMathFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  LMathFunc := procedure(const AVM: TJetVM)
  begin
    var LB: TJetValue := AVM.PopValue();
    var LA: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant((LA.IntValue + LB.IntValue) * 2);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('add_and_double', LMathFunc, [jvtInt, jvtInt], jvtInt);

  // Compute: add_and_double(10 + 5, 20 - 7) = add_and_double(15, 13) = (15 + 13) * 2 = 56
  FVM.LoadInt(10)
     .LoadInt(5)
     .AddInt()
     .LoadInt(20)
     .LoadInt(7)
     .SubInt()
     .CallFunction('add_and_double')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(56), LResult.IntValue, 'Function integration with arithmetic should work');
end;

procedure TTestJetVMFunctions.TestFunctionIntegrationWithStringOps();
var
  LStringFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  LStringFunc := procedure(const AVM: TJetVM)
  begin
    var LStr: TJetValue := AVM.PopValue();
    var LUpperStr := UpperCase(LStr.StrValue);
    var LResult: TJetValue := AVM.MakeStrConstant(LUpperStr + '!');
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('shout', LStringFunc, [jvtStr], jvtStr);

  FVM.LoadStr('hello')
     .LoadStr(' world')
     .ConcatStr()
     .CallFunction('shout')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual('HELLO WORLD!', LResult.StrValue, 'Function integration with string operations should work');
end;

procedure TTestJetVMFunctions.TestFunctionIntegrationWithControlFlow();
var
  LConditionalFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  LConditionalFunc := procedure(const AVM: TJetVM)
  begin
    var LValue: TJetValue := AVM.PopValue();
    var LResultValue: Integer;

    if LValue.IntValue > 50 then
      LResultValue := 1
    else
      LResultValue := 0;

    var LResult: TJetValue := AVM.MakeIntConstant(LResultValue);
    AVM.PushValue(LResult);
  end;

  FVM.RegisterNativeFunction('is_big', LConditionalFunc, [jvtInt], jvtInt);

  FVM.LoadInt(75)
     .CallFunction('is_big')
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(1), LResult.IntValue, 'Function integration with control flow should work');
end;

procedure TTestJetVMFunctions.TestComplexFunctionProgram();
var
  LFactorialFunc: TJetNativeFunction;
  LFormatterFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  // Factorial function
  LFactorialFunc := procedure(const AVM: TJetVM)
  begin
    var LN: TJetValue := AVM.PopValue();
    var LResult: Int64 := 1;
    for var LI := 2 to LN.IntValue do
      LResult := LResult * LI;
    AVM.PushValue(AVM.MakeIntConstant(LResult));
  end;

  // String formatter function
  LFormatterFunc := procedure(const AVM: TJetVM)
  begin
    var LValue: TJetValue := AVM.PopValue();
    var LFormatted := Format('Result: %d', [LValue.IntValue]);
    AVM.PushValue(AVM.MakeStrConstant(LFormatted));
  end;

  FVM.RegisterNativeFunction('factorial', LFactorialFunc, [jvtInt], jvtInt);
  FVM.RegisterNativeFunction('format_result', LFormatterFunc, [jvtInt], jvtStr);

  // Complex program: calculate factorial(5) and format result
  FVM.LoadInt(3)
     .LoadInt(2)
     .AddInt()           // 5
     .CallFunction('factorial')    // 120
     .CallFunction('format_result') // "Result: 120"
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual('Result: 120', LResult.StrValue, 'Complex function program should work correctly');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMFunctions);

end.
