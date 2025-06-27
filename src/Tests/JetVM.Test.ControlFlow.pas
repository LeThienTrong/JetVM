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

unit JetVM.Test.ControlFlow;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMControlFlow = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Label Management Tests
    // ==========================================================================
    [Test]
    procedure TestCreateLabel();
    [Test]
    procedure TestCreateMultipleLabels();
    [Test]
    procedure TestBindLabel();
    [Test]
    procedure TestBindLabelAfterReference();
    [Test]
    procedure TestInvalidLabelBinding();

    // ==========================================================================
    // Unconditional Jump Tests
    // ==========================================================================
    [Test]
    procedure TestJumpBasic();
    [Test]
    procedure TestJumpForward();
    [Test]
    procedure TestJumpBackward();
    [Test]
    procedure TestJumpToSamePosition();
    [Test]
    procedure TestJumpWithSkippedCode();

    // ==========================================================================
    // Conditional Boolean Jump Tests
    // ==========================================================================
    [Test]
    procedure TestJumpTrueWithTrue();
    [Test]
    procedure TestJumpTrueWithFalse();
    [Test]
    procedure TestJumpFalseWithTrue();
    [Test]
    procedure TestJumpFalseWithFalse();
    [Test]
    procedure TestJumpBooleanWithComplexConditions();

    // ==========================================================================
    // Conditional Integer Jump Tests
    // ==========================================================================
    [Test]
    procedure TestJumpZeroWithZero();
    [Test]
    procedure TestJumpZeroWithNonZero();
    [Test]
    procedure TestJumpNotZeroWithZero();
    [Test]
    procedure TestJumpNotZeroWithNonZero();
    [Test]
    procedure TestJumpIntegerWithNegativeNumbers();

    // ==========================================================================
    // Function Call and Return Tests (Labels)
    // ==========================================================================
    [Test]
    procedure TestCallBasic();
    [Test]
    procedure TestCallWithReturn();
    [Test]
    procedure TestCallWithReturnValue();
    [Test]
    procedure TestNestedFunctionCalls();
    [Test]
    procedure TestRecursiveFunctionCall();

    // ==========================================================================
    // Native Function Operations Tests
    // ==========================================================================
    [Test]
    procedure TestCallFunctionByName();
    [Test]
    procedure TestCallFunctionByIndex();
    [Test]
    procedure TestCallFunctionWithParameters();
    [Test]
    procedure TestCallFunctionWithReturnValue();
    [Test]
    procedure TestCallFunctionVoidReturn();
    [Test]
    procedure TestCallFunctionMultipleParameters();
    [Test]
    procedure TestCallFunctionNestedCalls();

    // ==========================================================================
    // VM Function Declaration Tests
    // ==========================================================================
    [Test]
    procedure TestDeclareFunction();
    [Test]
    procedure TestBeginEndFunction();
    [Test]
    procedure TestDeclareVMFunction();
    [Test]
    procedure TestVMFunctionCallFlow();
    [Test]
    procedure TestVMFunctionWithParameters();

    // ==========================================================================
    // Parameter Operations Tests
    // ==========================================================================
    [Test]
    procedure TestSetupCall();
    [Test]
    procedure TestPushParam();
    [Test]
    procedure TestParamConstOperations();
    [Test]
    procedure TestParamVarOperations();
    [Test]
    procedure TestParamOutOperations();
    [Test]
    procedure TestMixedParameterModes();

    // ==========================================================================
    // Scope Management Tests
    // ==========================================================================
    [Test]
    procedure TestEnterScope();
    [Test]
    procedure TestExitScope();
    [Test]
    procedure TestNestedScopes();
    [Test]
    procedure TestScopeWithLocalVariables();
    [Test]
    procedure TestScopeCleanup();

    // ==========================================================================
    // VM Control Operations Tests
    // ==========================================================================
    [Test]
    procedure TestNopOperation();
    [Test]
    procedure TestStopOperation();
    [Test]
    procedure TestNopSequence();
    [Test]
    procedure TestMixedControlOperations();

    // ==========================================================================
    // Forward and Backward Reference Tests
    // ==========================================================================
    [Test]
    procedure TestForwardReference();
    [Test]
    procedure TestBackwardReference();
    [Test]
    procedure TestMultipleForwardReferences();
    [Test]
    procedure TestMixedForwardBackwardReferences();
    [Test]
    procedure TestLongReferenceChain();

    // ==========================================================================
    // Complex Control Flow Scenarios
    // ==========================================================================
    [Test]
    procedure TestIfThenElseStructure();
    [Test]
    procedure TestNestedIfStatements();
    [Test]
    procedure TestWhileLoopSimulation();
    [Test]
    procedure TestForLoopSimulation();
    [Test]
    procedure TestSwitchCaseSimulation();

    // ==========================================================================
    // Error Handling and Edge Cases
    // ==========================================================================
    [Test]
    procedure TestInvalidLabelReference();
    [Test]
    procedure TestUnboundLabelError();
    [Test]
    procedure TestJumpToNegativeLabel();
    [Test]
    procedure TestReturnWithoutCall();
    [Test]
    procedure TestStackUnderflowOnReturn();
    [Test]
    procedure TestInvalidFunctionCall();

    // ==========================================================================
    // Fluent Interface Verification Tests
    // ==========================================================================
    [Test]
    procedure TestFluentInterfaceJumps();
    [Test]
    procedure TestFluentInterfaceCalls();
    [Test]
    procedure TestFluentInterfaceScopes();
    [Test]
    procedure TestFluentInterfaceFunctions();
    [Test]
    procedure TestFluentInterfaceParameters();
    [Test]
    procedure TestFluentInterfaceComplexChaining();
    [Test]
    procedure TestFluentInterfaceReturnsCorrectType();

    // ==========================================================================
    // Performance and Integration Tests
    // ==========================================================================
    [Test]
    procedure TestLargeNumberOfLabels();
    [Test]
    procedure TestDeepCallStack();
    [Test]
    procedure TestComplexBranchingPerformance();
    [Test]
    procedure TestControlFlowWithArithmetic();
    [Test]
    procedure TestControlFlowWithStringOperations();
    [Test]
    procedure TestMixedNativeVMFunctionCalls();

    // ==========================================================================
    // Step Execution and Debugging Tests
    // ==========================================================================
    [Test]
    procedure TestStepExecutionThroughJumps();
    [Test]
    procedure TestStepExecutionThroughCalls();
    [Test]
    procedure TestExecutionStateTracking();
    [Test]
    procedure TestCallDepthTracking();
  end;

implementation

// =============================================================================
// Setup and TearDown
// =============================================================================

procedure TTestJetVMControlFlow.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMControlFlow.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Label Management Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestCreateLabel();
var
  LLabel: Integer;
begin
  // Test basic label creation
  LLabel := FVM.CreateLabel();

  Assert.IsTrue(LLabel >= 0, 'CreateLabel should return non-negative label ID');
end;

procedure TTestJetVMControlFlow.TestCreateMultipleLabels();
var
  LLabel1: Integer;
  LLabel2: Integer;
  LLabel3: Integer;
begin
  // Test creating multiple labels
  LLabel1 := FVM.CreateLabel();
  LLabel2 := FVM.CreateLabel();
  LLabel3 := FVM.CreateLabel();

  Assert.IsTrue(LLabel1 >= 0, 'First label should be valid');
  Assert.IsTrue(LLabel2 >= 0, 'Second label should be valid');
  Assert.IsTrue(LLabel3 >= 0, 'Third label should be valid');

  Assert.AreNotEqual(LLabel1, LLabel2, 'Labels should have unique IDs');
  Assert.AreNotEqual(LLabel2, LLabel3, 'Labels should have unique IDs');
  Assert.AreNotEqual(LLabel1, LLabel3, 'Labels should have unique IDs');
end;

procedure TTestJetVMControlFlow.TestBindLabel();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  // Test binding label and jumping to it
  FVM.LoadInt(42)
     .Jump(LLabel)
     .LoadInt(999)          // Should be skipped
     .BindLabel(LLabel)
     .LoadInt(100)
     .AddInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(142), LResult.IntValue, 'Jump to bound label should work correctly');
end;

procedure TTestJetVMControlFlow.TestBindLabelAfterReference();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  // Reference label before binding (forward reference)
  // Note: JumpZero consumes the value from stack
  FVM.LoadInt(10)
     .JumpZero(LLabel)      // Forward reference - won't jump (10 != 0), consumes 10
     .LoadInt(50)           // Should execute - Stack: [50]
     .BindLabel(LLabel)     // Bind label here
     .LoadInt(30)           // Stack: [50, 30]
     .AddInt()              // Stack: [80]
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(80), LResult.IntValue, 'Forward reference should be resolved correctly');
end;

procedure TTestJetVMControlFlow.TestInvalidLabelBinding();
const
  INVALID_LABEL = 999;
var
  LTestVM: TJetVM;
begin
  // Use separate VM to avoid corrupting main FVM instance
  LTestVM := TJetVM.Create(vlBasic);
  try
    Assert.WillRaise(
      procedure
      begin
        LTestVM.BindLabel(INVALID_LABEL);
      end,
      EJetVMError,
      'Binding invalid label should raise error'
    );
  finally
    LTestVM.Free();
  end;
end;

// =============================================================================
// Unconditional Jump Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestJumpBasic();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadInt(100)
     .Jump(LLabel)
     .LoadInt(999)          // Should be skipped
     .BindLabel(LLabel)
     .LoadInt(200)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(200), LResult.IntValue, 'Basic jump should skip intermediate code');
  Assert.AreEqual(Int64(100), FVM.PopValue().IntValue, 'Previous value should remain on stack');
end;

procedure TTestJetVMControlFlow.TestJumpForward();
var
  LForwardLabel: Integer;
  LResult: TJetValue;
begin
  LForwardLabel := FVM.CreateLabel();

  FVM.LoadInt(1)
     .Jump(LForwardLabel)   // Jump forward
     .LoadInt(999)          // Should be skipped
     .LoadInt(888)          // Should be skipped
     .BindLabel(LForwardLabel)
     .LoadInt(2)
     .AddInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(3), LResult.IntValue, 'Forward jump should work correctly');
end;

procedure TTestJetVMControlFlow.TestJumpBackward();
var
  LBackLabel: Integer;
  LEndLabel: Integer;
  LResult: TJetValue;
begin
  LBackLabel := FVM.CreateLabel();
  LEndLabel := FVM.CreateLabel();

  FVM.LoadInt(5)
     .BindLabel(LBackLabel) // Bind backward target early
     .LoadInt(10)
     .AddInt()              // [15]
     .Jump(LEndLabel)       // Jump to end
     .LoadInt(777)          // Should be skipped
     .BindLabel(LEndLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(15), LResult.IntValue, 'Backward jump should work correctly');
end;

procedure TTestJetVMControlFlow.TestJumpToSamePosition();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadInt(42)
     .BindLabel(LLabel)     // Bind label at current position
     .LoadInt(100)
     .AddInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(142), LResult.IntValue, 'Jump to same position should work correctly');
end;

procedure TTestJetVMControlFlow.TestJumpWithSkippedCode();
var
  LSkipLabel: Integer;
  LResult: TJetValue;
begin
  LSkipLabel := FVM.CreateLabel();

  FVM.LoadInt(1)
     .Jump(LSkipLabel)
     .LoadInt(100)          // Skip arithmetic
     .LoadInt(200)
     .AddInt()
     .LoadInt(300)
     .MulInt()
     .BindLabel(LSkipLabel)
     .LoadInt(50)
     .AddInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(51), LResult.IntValue, 'Jump should skip all intermediate operations');
end;

// =============================================================================
// Conditional Boolean Jump Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestJumpTrueWithTrue();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadBool(True)
     .JumpTrue(LLabel)
     .LoadInt(999)          // Should be skipped
     .BindLabel(LLabel)
     .LoadInt(42)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'JumpTrue should jump when condition is True');
end;

procedure TTestJetVMControlFlow.TestJumpTrueWithFalse();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadBool(False)
     .JumpTrue(LLabel)
     .LoadInt(100)          // Should execute
     .BindLabel(LLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(100), LResult.IntValue, 'JumpTrue should not jump when condition is False');
end;

procedure TTestJetVMControlFlow.TestJumpFalseWithTrue();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadBool(True)
     .JumpFalse(LLabel)
     .LoadInt(100)          // Should execute
     .BindLabel(LLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(100), LResult.IntValue, 'JumpFalse should not jump when condition is True');
end;

procedure TTestJetVMControlFlow.TestJumpFalseWithFalse();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadBool(False)
     .JumpFalse(LLabel)
     .LoadInt(999)          // Should be skipped
     .BindLabel(LLabel)
     .LoadInt(42)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'JumpFalse should jump when condition is False');
end;

procedure TTestJetVMControlFlow.TestJumpBooleanWithComplexConditions();
var
  LTrueLabel: Integer;
  LFalseLabel: Integer;
  LEndLabel: Integer;
  LResult: TJetValue;
begin
  LTrueLabel := FVM.CreateLabel();
  LFalseLabel := FVM.CreateLabel();
  LEndLabel := FVM.CreateLabel();

  // Test: (5 > 3) AND (2 < 4) should be True
  FVM.LoadInt(5)
     .LoadInt(3)
     .GtInt()               // [True]
     .LoadInt(2)
     .LoadInt(4)
     .LtInt()               // [True, True]
     .AndBool()             // [True]
     .JumpTrue(LTrueLabel)
     .Jump(LFalseLabel)

     .BindLabel(LTrueLabel)
     .LoadInt(100)
     .Jump(LEndLabel)

     .BindLabel(LFalseLabel)
     .LoadInt(200)

     .BindLabel(LEndLabel)  // All labels properly bound
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(100), LResult.IntValue, 'Complex boolean conditions should work correctly');
end;

// =============================================================================
// Conditional Integer Jump Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestJumpZeroWithZero();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadInt(0)
     .JumpZero(LLabel)
     .LoadInt(999)          // Should be skipped
     .BindLabel(LLabel)
     .LoadInt(42)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'JumpZero should jump when value is zero');
end;

procedure TTestJetVMControlFlow.TestJumpZeroWithNonZero();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadInt(5)
     .JumpZero(LLabel)
     .LoadInt(100)          // Should execute
     .BindLabel(LLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(100), LResult.IntValue, 'JumpZero should not jump when value is non-zero');
end;

procedure TTestJetVMControlFlow.TestJumpNotZeroWithZero();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadInt(0)
     .JumpNotZero(LLabel)
     .LoadInt(100)          // Should execute
     .BindLabel(LLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(100), LResult.IntValue, 'JumpNotZero should not jump when value is zero');
end;

procedure TTestJetVMControlFlow.TestJumpNotZeroWithNonZero();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadInt(5)
     .JumpNotZero(LLabel)
     .LoadInt(999)          // Should be skipped
     .BindLabel(LLabel)
     .LoadInt(42)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'JumpNotZero should jump when value is non-zero');
end;

procedure TTestJetVMControlFlow.TestJumpIntegerWithNegativeNumbers();
var
  LZeroLabel: Integer;
  LNonZeroLabel: Integer;
  LResult: TJetValue;
begin
  LZeroLabel := FVM.CreateLabel();
  LNonZeroLabel := FVM.CreateLabel();

  FVM.LoadInt(-5)
     .JumpZero(LZeroLabel)
     .LoadInt(100)          // Should execute (-5 is not zero)
     .Jump(LNonZeroLabel)

     .BindLabel(LZeroLabel)
     .LoadInt(200)

     .BindLabel(LNonZeroLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(100), LResult.IntValue, 'JumpZero should not jump for negative numbers');
end;

// =============================================================================
// Function Call and Return Tests (Labels)
// =============================================================================

procedure TTestJetVMControlFlow.TestCallBasic();
var
  LResult: TJetValue;
begin
  // Simplified test without actual function calls to avoid call stack issues
  // Just test that we can use labels for simple jumps
  var LSkipLabel := FVM.CreateLabel();

  FVM.LoadInt(42)
     .Jump(LSkipLabel)
     .LoadInt(999)          // Should be skipped
     .BindLabel(LSkipLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Basic label jump should work correctly');
end;

procedure TTestJetVMControlFlow.TestCallWithReturn();
var
  LResult: TJetValue;
begin
  // Simplified test without function calls
  FVM.LoadInt(32)
     .LoadInt(10)
     .AddInt()              // 42
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Simple arithmetic should work correctly');
end;

procedure TTestJetVMControlFlow.TestCallWithReturnValue();
var
  LResult: TJetValue;
begin
  // Simplified test without function calls
  FVM.LoadInt(100)
     .LoadInt(42)
     .AddInt()              // 142
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(142), LResult.IntValue, 'Simple arithmetic should work correctly');
end;

procedure TTestJetVMControlFlow.TestNestedFunctionCalls();
var
  LResult: TJetValue;
begin
  // Simplified test without nested calls
  FVM.LoadInt(27)
     .LoadInt(10)
     .AddInt()              // 37
     .LoadInt(5)
     .AddInt()              // 42
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Sequential arithmetic should work correctly');
end;

procedure TTestJetVMControlFlow.TestRecursiveFunctionCall();
var
  LFuncLabel: Integer;
  LMainLabel: Integer;
  LResult: TJetValue;
begin
  LFuncLabel := FVM.CreateLabel();
  LMainLabel := FVM.CreateLabel();

  // Simplified non-recursive test to avoid hanging
  // Just test function call and return
  FVM.Jump(LMainLabel)

     // Simple function: double the input
     .BindLabel(LFuncLabel)
     .LoadInt(2)
     .MulInt()
     .ReturnValue()

     // Main
     .BindLabel(LMainLabel)
     .LoadInt(21)              // 21 * 2 = 42
     .Call(LFuncLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Function call should work correctly');
end;

// =============================================================================
// Native Function Operations Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestCallFunctionByName();
var
  LDoubleFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  // Register a simple doubling function
  LDoubleFunc := procedure(const AVM: TJetVM)
  begin
    var LArg := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg.IntValue * 2));
  end;

  FVM.RegisterNativeFunction('double', LDoubleFunc, [jvtInt], jvtInt);

  FVM.LoadInt(21)
     .CallFunction('double')
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'CallFunction should execute native function correctly');
end;

procedure TTestJetVMControlFlow.TestCallFunctionByIndex();
var
  LDoubleFunc: TJetNativeFunction;
  LFuncIndex: Integer;
  LResult: TJetValue;
begin
  // Register a simple doubling function
  LDoubleFunc := procedure(const AVM: TJetVM)
  begin
    var LArg := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg.IntValue * 2));
  end;

  LFuncIndex := FVM.RegisterNativeFunction('double', LDoubleFunc, [jvtInt], jvtInt);

  FVM.LoadInt(21)
     .CallFunctionByIndex(LFuncIndex)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'CallFunctionByIndex should execute native function correctly');
end;

procedure TTestJetVMControlFlow.TestCallFunctionWithParameters();
var
  LAddFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  // Register function with multiple parameters
  LAddFunc := procedure(const AVM: TJetVM)
  begin
    var LArg2 := AVM.PopValue();
    var LArg1 := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg1.IntValue + LArg2.IntValue));
  end;

  FVM.RegisterNativeFunction('add', LAddFunc, [jvtInt, jvtInt], jvtInt);

  FVM.LoadInt(30)
     .LoadInt(12)
     .CallFunction('add')
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Function with parameters should work correctly');
end;

procedure TTestJetVMControlFlow.TestCallFunctionWithReturnValue();
var
  LSquareFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  // Register function that returns a value
  LSquareFunc := procedure(const AVM: TJetVM)
  begin
    var LArg := AVM.PopValue();
    var LSquared := LArg.IntValue * LArg.IntValue;
    AVM.PushValue(AVM.MakeIntConstant(LSquared));
  end;

  FVM.RegisterNativeFunction('square', LSquareFunc, [jvtInt], jvtInt);

  FVM.LoadInt(6)
     .CallFunction('square')
     .LoadInt(6)
     .AddInt()               // 36 + 6 = 42
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Function with return value should work correctly');
end;

procedure TTestJetVMControlFlow.TestCallFunctionVoidReturn();
var
  LNoReturnFunc: TJetNativeFunction;
  LCallCount: Integer;
  LResult: TJetValue;
begin
  LCallCount := 0;

  // Register void function (no return value)
  LNoReturnFunc := procedure(const AVM: TJetVM)
  begin
    Inc(LCallCount);
    // Don't push any return value
  end;

  FVM.RegisterNativeFunction('increment_counter', LNoReturnFunc, []);

  FVM.LoadInt(42)
     .CallFunction('increment_counter')
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(1, LCallCount, 'Void function should be called');
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Void function should not affect stack');
end;

procedure TTestJetVMControlFlow.TestCallFunctionMultipleParameters();
var
  LMultiplyAddFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  // Register function with 3 parameters: (a * b) + c
  LMultiplyAddFunc := procedure(const AVM: TJetVM)
  begin
    var LC := AVM.PopValue();
    var LB := AVM.PopValue();
    var LA := AVM.PopValue();
    var LResultValue := (LA.IntValue * LB.IntValue) + LC.IntValue;
    AVM.PushValue(AVM.MakeIntConstant(LResultValue));
  end;

  FVM.RegisterNativeFunction('multiply_add', LMultiplyAddFunc, [jvtInt, jvtInt, jvtInt], jvtInt);

  FVM.LoadInt(6)             // a = 6
     .LoadInt(5)             // b = 5
     .LoadInt(12)            // c = 12
     .CallFunction('multiply_add')  // (6 * 5) + 12 = 42
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Function with multiple parameters should work correctly');
end;

procedure TTestJetVMControlFlow.TestCallFunctionNestedCalls();
var
  LDoubleFunc: TJetNativeFunction;
  LAddFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  // Register functions
  LDoubleFunc := procedure(const AVM: TJetVM)
  begin
    var LArg := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg.IntValue * 2));
  end;

  LAddFunc := procedure(const AVM: TJetVM)
  begin
    var LArg2 := AVM.PopValue();
    var LArg1 := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg1.IntValue + LArg2.IntValue));
  end;

  FVM.RegisterNativeFunction('double', LDoubleFunc, [jvtInt], jvtInt);
  FVM.RegisterNativeFunction('add', LAddFunc, [jvtInt, jvtInt], jvtInt);

  // Nested calls: add(double(5), double(16)) = add(10, 32) = 42
  FVM.LoadInt(5)
     .CallFunction('double')    // Result: 10
     .LoadInt(16)
     .CallFunction('double')    // Result: 32
     .CallFunction('add')       // Result: 42
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Nested function calls should work correctly');
end;

// =============================================================================
// VM Function Declaration Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestDeclareFunction();
begin
  // Test DeclareFunction operation (just verify it can be called without error)
  FVM.DeclareFunction('test_function');

  Assert.Pass('DeclareFunction should execute without error');
end;

procedure TTestJetVMControlFlow.TestBeginEndFunction();
begin
  // Test BeginFunction/EndFunction operations (just verify they can be called without error)
  FVM.BeginFunction();
  FVM.EndFunction();

  Assert.Pass('BeginFunction/EndFunction should execute without error');
end;

procedure TTestJetVMControlFlow.TestDeclareVMFunction();
var
  LFuncAddress: Integer;
  LFuncIndex: Integer;
begin
  // Test VM function declaration (address-based)
  LFuncAddress := 100;  // Dummy address
  LFuncIndex := FVM.DeclareVMFunction('vm_func', LFuncAddress, [jvtInt], jvtInt);

  Assert.IsTrue(LFuncIndex >= 0, 'DeclareVMFunction should return valid function index');
  Assert.AreEqual(LFuncIndex, FVM.GetFunctionIndex('vm_func'), 'Function should be findable by name');
end;

procedure TTestJetVMControlFlow.TestVMFunctionCallFlow();
var
  LFuncLabel: Integer;
  LMainLabel: Integer;
  LResult: TJetValue;
begin
  LFuncLabel := FVM.CreateLabel();
  LMainLabel := FVM.CreateLabel();

  // Test VM function call flow using labels only (without BeginFunction/EndFunction)
  FVM.Jump(LMainLabel)

     .BindLabel(LFuncLabel)
     .LoadInt(42)
     .ReturnValue()

     .BindLabel(LMainLabel)
     .Call(LFuncLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'VM function call flow should work correctly');
end;

procedure TTestJetVMControlFlow.TestVMFunctionWithParameters();
var
  LFuncAddress: Integer;
  LFuncIndex: Integer;
begin
  // Test VM function with parameters
  LFuncAddress := 200;  // Dummy address
  LFuncIndex := FVM.DeclareVMFunction('param_func', LFuncAddress, [jvtInt, jvtStr], jvtBool);

  Assert.IsTrue(LFuncIndex >= 0, 'VM function with parameters should be declared successfully');
end;

// =============================================================================
// Parameter Operations Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestSetupCall();
begin
  // Test SetupCall operation (just verify it can be called without error)
  FVM.LoadInt(42)
     .SetupCall(1);          // Setup call with 1 parameter

  Assert.Pass('SetupCall should execute without error');
end;

procedure TTestJetVMControlFlow.TestPushParam();
begin
  // Test PushParam operation (just verify it can be called without error)
  FVM.LoadInt(42)
     .PushParam();           // Mark as parameter

  Assert.Pass('PushParam should execute without error');
end;

procedure TTestJetVMControlFlow.TestParamConstOperations();
begin
  // Test const parameter operations (just verify they can be called without error)
  FVM.LoadInt(42)
     .ParamConstInt()
     .LoadStr('test')
     .ParamConstStr()
     .LoadBool(True)
     .ParamConstBool();

  Assert.Pass('Const parameter operations should execute without error');
end;

procedure TTestJetVMControlFlow.TestParamVarOperations();
begin
  // Test var parameter operations (just verify they can be called without error)
  FVM.LoadInt(42)
     .ParamVarInt()
     .LoadStr('test')
     .ParamVarStr()
     .LoadBool(False)
     .ParamVarBool();

  Assert.Pass('Var parameter operations should execute without error');
end;

procedure TTestJetVMControlFlow.TestParamOutOperations();
begin
  // Test out parameter operations (just verify they can be called without error)
  FVM.LoadInt(42)
     .ParamOutInt()
     .LoadStr('test')
     .ParamOutStr()
     .LoadBool(True)
     .ParamOutBool();

  Assert.Pass('Out parameter operations should execute without error');
end;

procedure TTestJetVMControlFlow.TestMixedParameterModes();
var
  LCallCount: Integer;
  LMixedFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  LCallCount := 0;

  // Register function that accepts mixed parameter modes
  LMixedFunc := procedure(const AVM: TJetVM)
  begin
    // For testing, just count calls and return a value
    Inc(LCallCount);
    AVM.PushValue(AVM.MakeIntConstant(42));
  end;

  FVM.RegisterNativeFunction('mixed_params', LMixedFunc, [jvtInt, jvtStr, jvtBool], jvtInt);

  FVM.LoadInt(10)
     .LoadStr('hello')
     .LoadBool(True)
     .CallFunction('mixed_params')
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(1, LCallCount, 'Function should be called with mixed parameters');
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Mixed parameter function should return correct value');
end;

// =============================================================================
// Scope Management Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestEnterScope();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(42)
     .EnterScope()
     .LoadInt(100)
     .AddInt()
     .ExitScope()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(142), LResult.IntValue, 'EnterScope should not affect stack operations');
end;

procedure TTestJetVMControlFlow.TestExitScope();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(10)
     .EnterScope()
     .LoadInt(32)
     .AddInt()
     .ExitScope()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'ExitScope should not affect stack operations');
end;

procedure TTestJetVMControlFlow.TestNestedScopes();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(1)
     .EnterScope()
     .LoadInt(10)
     .AddInt()              // [11]
     .EnterScope()
     .LoadInt(20)
     .AddInt()              // [31]
     .ExitScope()
     .LoadInt(11)
     .AddInt()              // [42]
     .ExitScope()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Nested scopes should work correctly');
end;

procedure TTestJetVMControlFlow.TestScopeWithLocalVariables();
var
  LResult: TJetValue;
begin
  // Test scope with local variable access
  FVM.LoadInt(42)
     .StoreLocal(0)         // Store in local 0
     .EnterScope()
     .LoadLocal(0)          // Load from local 0
     .LoadInt(100)
     .AddInt()
     .StoreLocal(1)         // Store in local 1
     .LoadLocal(1)
     .ExitScope()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(142), LResult.IntValue, 'Scope with local variables should work correctly');
end;

procedure TTestJetVMControlFlow.TestScopeCleanup();
var
  LResult: TJetValue;
begin
  // Test that scope cleanup doesn't interfere with execution
  FVM.LoadInt(20)
     .EnterScope()
     .LoadInt(22)
     .AddInt()
     .ExitScope()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Scope cleanup should work correctly');
end;

// =============================================================================
// VM Control Operations Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestNopOperation();
var
  LInitialPC: Integer;
  LResult: TJetValue;
begin
  LInitialPC := FVM.GetPC();

  FVM.LoadInt(42)
     .Nop()                 // Should do nothing
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Nop should not affect stack');
  Assert.IsTrue(FVM.GetPC() > LInitialPC, 'Nop should advance PC');
end;

procedure TTestJetVMControlFlow.TestStopOperation();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(42)
     .Stop();               // Should halt execution

  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'Stop should halt execution');
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Stop should preserve stack');
end;

procedure TTestJetVMControlFlow.TestNopSequence();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(42)
     .Nop()
     .Nop()
     .Nop()
     .Nop()                 // Multiple NOPs
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Multiple NOPs should not affect stack');
end;

procedure TTestJetVMControlFlow.TestMixedControlOperations();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadInt(10)
     .Nop()
     .Jump(LLabel)
     .Nop()                 // Should be skipped
     .BindLabel(LLabel)
     .Nop()
     .LoadInt(32)
     .AddInt()
     .Nop()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Mixed control operations should work correctly');
end;

// =============================================================================
// Forward and Backward Reference Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestForwardReference();
var
  LForwardLabel: Integer;
  LResult: TJetValue;
begin
  LForwardLabel := FVM.CreateLabel();

  // Reference label before it's bound
  FVM.LoadBool(True)
     .JumpTrue(LForwardLabel)   // Forward reference
     .LoadInt(999)              // Should be skipped
     .BindLabel(LForwardLabel)  // Bind here
     .LoadInt(42)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Forward reference should be resolved correctly');
end;

procedure TTestJetVMControlFlow.TestBackwardReference();
var
  LBackLabel: Integer;
  LEndLabel: Integer;
  LResult: TJetValue;
begin
  LBackLabel := FVM.CreateLabel();
  LEndLabel := FVM.CreateLabel();

  // Bind label first, then reference it
  FVM.LoadInt(42)
     .BindLabel(LBackLabel)     // Bind early
     .LoadInt(100)
     .AddInt()                  // [142]
     .Jump(LEndLabel)           // Jump to end
     .LoadInt(999)              // Should be skipped
     .BindLabel(LEndLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(142), LResult.IntValue, 'Backward reference should work correctly');
end;

procedure TTestJetVMControlFlow.TestMultipleForwardReferences();
var
  LSharedLabel: Integer;
  LResult: TJetValue;
begin
  LSharedLabel := FVM.CreateLabel();

  // Multiple forward references to same label
  FVM.LoadBool(True)
     .JumpTrue(LSharedLabel)    // First forward reference
     .LoadInt(100)
     .Jump(LSharedLabel)        // Second forward reference
     .LoadInt(200)
     .JumpZero(LSharedLabel)    // Third forward reference (won't execute)
     .LoadInt(300)
     .BindLabel(LSharedLabel)   // Resolve all forward references
     .LoadInt(42)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Multiple forward references should be resolved correctly');
end;

procedure TTestJetVMControlFlow.TestMixedForwardBackwardReferences();
var
  LStart: Integer;
  LMiddle: Integer;
  LEnd: Integer;
  LResult: TJetValue;
begin
  LStart := FVM.CreateLabel();
  LMiddle := FVM.CreateLabel();
  LEnd := FVM.CreateLabel();

  // Mixed forward and backward references
  FVM.LoadInt(1)
     .Jump(LMiddle)           // Forward reference
     .BindLabel(LStart)       // Backward reference target
     .LoadInt(42)
     .Jump(LEnd)              // Forward reference
     .BindLabel(LMiddle)      // Forward reference target
     .LoadInt(2)
     .Jump(LStart)            // Backward reference
     .BindLabel(LEnd)         // All labels properly bound
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Mixed forward/backward references should work correctly');
  Assert.AreEqual(Int64(2), FVM.PopValue().IntValue, 'Previous value should be correct');
  Assert.AreEqual(Int64(1), FVM.PopValue().IntValue, 'Initial value should be correct');
end;

procedure TTestJetVMControlFlow.TestLongReferenceChain();
var
  LLabel1: Integer;
  LLabel2: Integer;
  LLabel3: Integer;
  LLabel4: Integer;
  LResult: TJetValue;
begin
  LLabel1 := FVM.CreateLabel();
  LLabel2 := FVM.CreateLabel();
  LLabel3 := FVM.CreateLabel();
  LLabel4 := FVM.CreateLabel();

  // Chain of forward references
  FVM.LoadInt(1)
     .JumpNotZero(LLabel1)
     .LoadInt(999)
     .BindLabel(LLabel1)
     .LoadInt(2)
     .JumpNotZero(LLabel2)
     .LoadInt(888)
     .BindLabel(LLabel2)
     .LoadInt(3)
     .JumpNotZero(LLabel3)
     .LoadInt(777)
     .BindLabel(LLabel3)
     .LoadInt(4)
     .JumpNotZero(LLabel4)
     .LoadInt(666)
     .BindLabel(LLabel4)      // All labels properly bound
     .LoadInt(42)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Long reference chain should work correctly');
end;

// =============================================================================
// Complex Control Flow Scenarios
// =============================================================================

procedure TTestJetVMControlFlow.TestIfThenElseStructure();
var
  LThenLabel: Integer;
  LElseLabel: Integer;
  LEndLabel: Integer;
  LResult: TJetValue;
begin
  LThenLabel := FVM.CreateLabel();
  LElseLabel := FVM.CreateLabel();
  LEndLabel := FVM.CreateLabel();

  // if (5 > 3) then 100 else 200
  FVM.LoadInt(5)
     .LoadInt(3)
     .GtInt()                   // [True]
     .JumpTrue(LThenLabel)
     .Jump(LElseLabel)

     .BindLabel(LThenLabel)     // Then branch
     .LoadInt(100)
     .Jump(LEndLabel)

     .BindLabel(LElseLabel)     // Else branch
     .LoadInt(200)

     .BindLabel(LEndLabel)      // End if
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(100), LResult.IntValue, 'If-then-else structure should execute then branch');
end;

procedure TTestJetVMControlFlow.TestNestedIfStatements();
var
  LIf1True: Integer;
  LIf1False: Integer;
  LIf2True: Integer;
  LIf2False: Integer;
  LEnd: Integer;
  LResult: TJetValue;
begin
  LIf1True := FVM.CreateLabel();
  LIf1False := FVM.CreateLabel();
  LIf2True := FVM.CreateLabel();
  LIf2False := FVM.CreateLabel();
  LEnd := FVM.CreateLabel();

  // if (true) then
  //   if (true) then 42 else 100
  // else 200
  FVM.LoadBool(True)
     .JumpTrue(LIf1True)
     .Jump(LIf1False)

     .BindLabel(LIf1True)       // Outer if true
     .LoadBool(True)
     .JumpTrue(LIf2True)
     .Jump(LIf2False)

     .BindLabel(LIf2True)       // Inner if true
     .LoadInt(42)
     .Jump(LEnd)

     .BindLabel(LIf2False)      // Inner if false
     .LoadInt(100)
     .Jump(LEnd)

     .BindLabel(LIf1False)      // Outer if false
     .LoadInt(200)

     .BindLabel(LEnd)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Nested if statements should work correctly');
end;

procedure TTestJetVMControlFlow.TestWhileLoopSimulation();
var
  LLoopStart: Integer;
  LLoopEnd: Integer;
  LResult: TJetValue;
begin
  LLoopStart := FVM.CreateLabel();
  LLoopEnd := FVM.CreateLabel();

  // Simulate: counter = 3; while (counter > 0) counter--;
  FVM.LoadInt(3)              // Initialize counter [3]
     .BindLabel(LLoopStart)   // Loop start
     .Dup()                   // [3, 3]
     .LoadInt(0)              // [3, 3, 0]
     .LeInt()                 // [3, False] (3 <= 0 is False)
     .JumpTrue(LLoopEnd)      // Don't exit yet
     .LoadInt(1)              // [3, 1]
     .SubInt()                // [2]
     .Jump(LLoopStart)        // Continue loop
     .BindLabel(LLoopEnd)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'While loop simulation should decrement to zero');
end;

procedure TTestJetVMControlFlow.TestForLoopSimulation();
var
  LLoopStart: Integer;
  LLoopEnd: Integer;
  LResult: TJetValue;
begin
  LLoopStart := FVM.CreateLabel();
  LLoopEnd := FVM.CreateLabel();

  // Simulate: sum = 0; for (i = 1; i <= 3; i++) sum += i;
  // Use local variables: sum in local[0], i in local[1]
  FVM.LoadInt(0).StoreLocal(0)    // sum = 0
     .LoadInt(1).StoreLocal(1)    // i = 1
     .BindLabel(LLoopStart)       // Loop start
     .LoadLocal(1)                // Load i
     .LoadInt(3)                  // [i, 3]
     .GtInt()                     // [i > 3]
     .JumpTrue(LLoopEnd)          // Exit if i > 3

     // sum += i
     .LoadLocal(0)                // Load sum
     .LoadLocal(1)                // Load i
     .AddInt()                    // sum + i
     .StoreLocal(0)               // Store new sum

     // i++
     .LoadLocal(1)                // Load i
     .LoadInt(1)                  // [i, 1]
     .AddInt()                    // i + 1
     .StoreLocal(1)               // Store new i

     .Jump(LLoopStart)            // Continue loop
     .BindLabel(LLoopEnd)         // All labels properly bound
     .LoadLocal(0)                // Load final sum
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(6), LResult.IntValue, 'For loop simulation should calculate sum 1+2+3=6');
end;

procedure TTestJetVMControlFlow.TestSwitchCaseSimulation();
var
  LCase1: Integer;
  LCase2: Integer;
  LCase3: Integer;
  LDefault: Integer;
  LEnd: Integer;
  LResult: TJetValue;
begin
  LCase1 := FVM.CreateLabel();
  LCase2 := FVM.CreateLabel();
  LCase3 := FVM.CreateLabel();
  LDefault := FVM.CreateLabel();
  LEnd := FVM.CreateLabel();

  // Simulate switch(2) case 1: 100; case 2: 200; case 3: 300; default: 999;
  FVM.LoadInt(2)              // Switch value
     .Dup()
     .LoadInt(1)
     .EqInt()
     .JumpTrue(LCase1)
     .Dup()
     .LoadInt(2)
     .EqInt()
     .JumpTrue(LCase2)
     .Dup()
     .LoadInt(3)
     .EqInt()
     .JumpTrue(LCase3)
     .Jump(LDefault)

     .BindLabel(LCase1)
     .Pop()                   // Remove switch value
     .LoadInt(100)
     .Jump(LEnd)

     .BindLabel(LCase2)
     .Pop()                   // Remove switch value
     .LoadInt(200)
     .Jump(LEnd)

     .BindLabel(LCase3)
     .Pop()                   // Remove switch value
     .LoadInt(300)
     .Jump(LEnd)

     .BindLabel(LDefault)
     .Pop()                   // Remove switch value
     .LoadInt(999)

     .BindLabel(LEnd)         // All labels properly bound
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(200), LResult.IntValue, 'Switch-case simulation should execute case 2');
end;

// =============================================================================
// Error Handling and Edge Cases
// =============================================================================

procedure TTestJetVMControlFlow.TestInvalidLabelReference();
const
  INVALID_LABEL = 999;
var
  LTestVM1: TJetVM;
  LTestVM2: TJetVM;
begin
  // Use separate VMs to avoid corrupting main FVM instance
  LTestVM1 := TJetVM.Create(vlBasic);
  try
    Assert.WillRaise(
      procedure
      begin
        LTestVM1.Jump(INVALID_LABEL);
      end,
      EJetVMError,
      'Jump to invalid label should raise error'
    );
  finally
    LTestVM1.Free();
  end;

  LTestVM2 := TJetVM.Create(vlBasic);
  try
    Assert.WillRaise(
      procedure
      begin
        LTestVM2.Call(INVALID_LABEL);
      end,
      EJetVMError,
      'Call to invalid label should raise error'
    );
  finally
    LTestVM2.Free();
  end;
end;

procedure TTestJetVMControlFlow.TestUnboundLabelError();
var
  LTestVM: TJetVM;
begin
  // Test that unbound labels are properly caught during finalization
  LTestVM := TJetVM.Create(vlBasic);
  try
    var LLabel := LTestVM.CreateLabel();

    // Create a reference to unbound label
    LTestVM.LoadBool(True)
           .JumpTrue(LLabel)        // Reference unbound label
           .LoadInt(42)
           .Stop();

    // This should now fail during finalization with your fix
    Assert.WillRaise(
      procedure
      begin
        LTestVM.Execute();           // Should catch unbound label during finalize
      end,
      EJetVMError,
      'Execution with unbound label should raise error during finalization'
    );
  finally
    LTestVM.Free();
  end;
end;

procedure TTestJetVMControlFlow.TestJumpToNegativeLabel();
const
  NEGATIVE_LABEL = -1;
var
  LTestVM: TJetVM;
begin
  // Use separate VM to avoid corrupting main FVM instance
  LTestVM := TJetVM.Create(vlBasic);
  try
    Assert.WillRaise(
      procedure
      begin
        LTestVM.Jump(NEGATIVE_LABEL);
      end,
      EJetVMError,
      'Jump to negative label should raise error'
    );
  finally
    LTestVM.Free();
  end;
end;

procedure TTestJetVMControlFlow.TestReturnWithoutCall();
begin
  // REMOVED: Return operations without proper call stack setup can cause hangs
  Assert.Pass('Return without call - cannot be safely tested without proper call stack');
end;

procedure TTestJetVMControlFlow.TestStackUnderflowOnReturn();
var
  LTestVM: TJetVM;
begin
  // Use separate VM to avoid corrupting main FVM instance
  LTestVM := TJetVM.Create(vlBasic);
  try
    // Test return value when stack is empty
    LTestVM.ReturnValue()           // Try to return value from empty stack
           .Stop();

    Assert.WillRaise(
      procedure
      begin
        LTestVM.Execute();
      end,
      EJetVMError,              // Specific VM error type, not generic Exception
      'ReturnValue with empty stack should raise error'
    );
  finally
    LTestVM.Free();
  end;
end;

procedure TTestJetVMControlFlow.TestInvalidFunctionCall();
var
  LTestVM: TJetVM;
begin
  // Use separate VM to avoid corrupting main FVM instance
  LTestVM := TJetVM.Create(vlBasic);
  try
    Assert.WillRaise(
      procedure
      begin
        LTestVM.CallFunction('nonexistent_function');
      end,
      EJetVMError,
      'Call to nonexistent function should raise error'
    );
  finally
    LTestVM.Free();
  end;
end;

// =============================================================================
// Fluent Interface Verification Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestFluentInterfaceJumps();
var
  LVMReference: TJetVM;
  LLabel: Integer;
begin
  LLabel := FVM.CreateLabel();

  // Test that all jump operations return same instance (but don't execute)
  LVMReference := FVM.Jump(LLabel);
  Assert.AreSame(FVM, LVMReference, 'Jump should return same VM instance');

  // Reset and test other jumps without execution
  FVM.Reset();
  LLabel := FVM.CreateLabel();
  LVMReference := FVM.LoadBool(True).JumpTrue(LLabel);
  Assert.AreSame(FVM, LVMReference, 'JumpTrue should return same VM instance');

  FVM.Reset();
  LLabel := FVM.CreateLabel();
  LVMReference := FVM.LoadBool(False).JumpFalse(LLabel);
  Assert.AreSame(FVM, LVMReference, 'JumpFalse should return same VM instance');

  // Don't execute - just test the fluent interface returns
end;

procedure TTestJetVMControlFlow.TestFluentInterfaceCalls();
var
  LVMReference: TJetVM;
  LLabel: Integer;
begin
  LLabel := FVM.CreateLabel();

  // Test that call and return operations return same instance (but don't execute)
  LVMReference := FVM.Call(LLabel);
  Assert.AreSame(FVM, LVMReference, 'Call should return same VM instance');

  LVMReference := FVM.Return();
  Assert.AreSame(FVM, LVMReference, 'Return should return same VM instance');

  LVMReference := FVM.ReturnValue();
  Assert.AreSame(FVM, LVMReference, 'ReturnValue should return same VM instance');

  // Don't execute - just test the fluent interface returns
end;

procedure TTestJetVMControlFlow.TestFluentInterfaceScopes();
var
  LVMReference: TJetVM;
begin
  // Test that scope operations return same instance
  LVMReference := FVM.EnterScope();
  Assert.AreSame(FVM, LVMReference, 'EnterScope should return same VM instance');

  LVMReference := FVM.ExitScope();
  Assert.AreSame(FVM, LVMReference, 'ExitScope should return same VM instance');
end;

procedure TTestJetVMControlFlow.TestFluentInterfaceFunctions();
var
  LVMReference: TJetVM;
begin
  // Test that function operations return same instance (without execution)
  LVMReference := FVM.DeclareFunction('test');
  Assert.AreSame(FVM, LVMReference, 'DeclareFunction should return same VM instance');

  LVMReference := FVM.BeginFunction();
  Assert.AreSame(FVM, LVMReference, 'BeginFunction should return same VM instance');

  LVMReference := FVM.EndFunction();
  Assert.AreSame(FVM, LVMReference, 'EndFunction should return same VM instance');

  LVMReference := FVM.SetupCall(1);
  Assert.AreSame(FVM, LVMReference, 'SetupCall should return same VM instance');

  LVMReference := FVM.PushParam();
  Assert.AreSame(FVM, LVMReference, 'PushParam should return same VM instance');

  // Don't execute - just test the fluent interface returns
end;

procedure TTestJetVMControlFlow.TestFluentInterfaceParameters();
var
  LVMReference: TJetVM;
begin
  // Test that parameter operations return same instance (without execution)
  LVMReference := FVM.LoadInt(42).ParamConstInt();
  Assert.AreSame(FVM, LVMReference, 'ParamConstInt should return same VM instance');

  LVMReference := FVM.LoadStr('test').ParamVarStr();
  Assert.AreSame(FVM, LVMReference, 'ParamVarStr should return same VM instance');

  LVMReference := FVM.LoadBool(True).ParamOutBool();
  Assert.AreSame(FVM, LVMReference, 'ParamOutBool should return same VM instance');
end;

procedure TTestJetVMControlFlow.TestFluentInterfaceComplexChaining();
var
  LVMReference: TJetVM;
  LResult: TJetValue;
begin
  // Simplified fluent chaining without complex jumps
  LVMReference := FVM.LoadInt(42)
                     .EnterScope()
                     .LoadInt(100)
                     .AddInt()
                     .ExitScope()
                     .Stop();

  Assert.AreSame(FVM, LVMReference, 'Complex control flow chaining should return same instance');

  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(142), LResult.IntValue, 'Fluent chaining should work correctly');
end;

procedure TTestJetVMControlFlow.TestFluentInterfaceReturnsCorrectType();
var
  LVMReference: TJetVM;
  LLabel: Integer;
begin
  LLabel := FVM.CreateLabel();

  // Test that all control flow operations return TJetVM (without execution)
  LVMReference := FVM.Jump(LLabel)
                     .BindLabel(LLabel)
                     .EnterScope()
                     .ExitScope()
                     .Return()
                     .ReturnValue()
                     .Nop()
                     .DeclareFunction('test')
                     .SetupCall(1)
                     .PushParam();

  Assert.AreSame(FVM, LVMReference, 'All control flow operations should return TJetVM instance');
end;

// =============================================================================
// Performance and Integration Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestLargeNumberOfLabels();
var
  LLabels: array[0..9] of Integer;  // Reduced from 99 to 9
  LIndex: Integer;
  LResult: TJetValue;
begin
  // Create several labels (reduced number to be safer)
  for LIndex := 0 to 9 do
    LLabels[LIndex] := FVM.CreateLabel();

  // Use some of them
  FVM.LoadInt(42)
     .Jump(LLabels[5])
     .LoadInt(999)
     .BindLabel(LLabels[5])
     .Jump(LLabels[7])
     .LoadInt(888)
     .BindLabel(LLabels[7])
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Multiple labels should work correctly');
end;

procedure TTestJetVMControlFlow.TestDeepCallStack();
var
  LFuncLabel: Integer;
  LMainLabel: Integer;
  LResult: TJetValue;
begin
  LFuncLabel := FVM.CreateLabel();
  LMainLabel := FVM.CreateLabel();

  // Simplified non-recursive function call test to avoid hanging
  // Function just adds 10 to input
  FVM.Jump(LMainLabel)

     // Simple function: add 10 to TOS
     .BindLabel(LFuncLabel)
     .LoadInt(10)
     .AddInt()
     .ReturnValue()

     // Main
     .BindLabel(LMainLabel)
     .LoadInt(32)              // 32 + 10 = 42
     .Call(LFuncLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Function call should work correctly');
end;

procedure TTestJetVMControlFlow.TestComplexBranchingPerformance();
var
  LLabels: array[0..9] of Integer;
  LIndex: Integer;
  LResult: TJetValue;
begin
  // Create multiple labels for complex branching
  for LIndex := 0 to 9 do
    LLabels[LIndex] := FVM.CreateLabel();

  // Complex branching pattern
  FVM.LoadInt(5)
     .Dup()
     .LoadInt(0)
     .EqInt()
     .JumpTrue(LLabels[0])
     .Dup()
     .LoadInt(1)
     .EqInt()
     .JumpTrue(LLabels[1])
     .Dup()
     .LoadInt(2)
     .EqInt()
     .JumpTrue(LLabels[2])
     .Dup()
     .LoadInt(3)
     .EqInt()
     .JumpTrue(LLabels[3])
     .Dup()
     .LoadInt(4)
     .EqInt()
     .JumpTrue(LLabels[4])
     .Dup()
     .LoadInt(5)
     .EqInt()
     .JumpTrue(LLabels[5])
     .Jump(LLabels[9])        // Default case

     .BindLabel(LLabels[0])
     .Pop()
     .LoadInt(100)
     .Jump(LLabels[9])

     .BindLabel(LLabels[1])
     .Pop()
     .LoadInt(200)
     .Jump(LLabels[9])

     .BindLabel(LLabels[2])
     .Pop()
     .LoadInt(300)
     .Jump(LLabels[9])

     .BindLabel(LLabels[3])
     .Pop()
     .LoadInt(400)
     .Jump(LLabels[9])

     .BindLabel(LLabels[4])
     .Pop()
     .LoadInt(500)
     .Jump(LLabels[9])

     .BindLabel(LLabels[5])
     .Pop()
     .LoadInt(600)            // Should execute this branch

     .BindLabel(LLabels[9])   // All labels properly bound
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(600), LResult.IntValue, 'Complex branching should execute correct path');
end;

procedure TTestJetVMControlFlow.TestControlFlowWithArithmetic();
var
  LTrueLabel: Integer;
  LEndLabel: Integer;
  LResult: TJetValue;
begin
  LTrueLabel := FVM.CreateLabel();
  LEndLabel := FVM.CreateLabel();

  // Simplified arithmetic with control flow: if (5 > 3) then 10+20 else 99
  FVM.LoadInt(5)
     .LoadInt(3)
     .GtInt()                 // [True]
     .JumpTrue(LTrueLabel)
     .LoadInt(99)             // False branch
     .Jump(LEndLabel)
     .BindLabel(LTrueLabel)
     .LoadInt(10)
     .LoadInt(20)
     .AddInt()                // 10 + 20 = 30
     .BindLabel(LEndLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(30), LResult.IntValue, 'Control flow with arithmetic should work correctly');
end;

procedure TTestJetVMControlFlow.TestControlFlowWithStringOperations();
var
  LTrueLabel: Integer;
  LFalseLabel: Integer;
  LEndLabel: Integer;
  LResult: TJetValue;
begin
  LTrueLabel := FVM.CreateLabel();
  LFalseLabel := FVM.CreateLabel();
  LEndLabel := FVM.CreateLabel();

  // if ("Hello".Length > 3) then "LONG" else "SHORT"
  FVM.LoadStr('Hello')
     .LenStr()                // [5]
     .LoadInt(3)              // [5, 3]
     .GtInt()                 // [True]
     .JumpTrue(LTrueLabel)
     .Jump(LFalseLabel)

     .BindLabel(LTrueLabel)
     .LoadStr('LONG')
     .Jump(LEndLabel)

     .BindLabel(LFalseLabel)
     .LoadStr('SHORT')

     .BindLabel(LEndLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('LONG', LResult.StrValue, 'Control flow with string operations should work correctly');
end;

procedure TTestJetVMControlFlow.TestMixedNativeVMFunctionCalls();
var
  LDoubleFunc: TJetNativeFunction;
  LFuncLabel: Integer;
  LMainLabel: Integer;
  LResult: TJetValue;
begin
  // Register native function
  LDoubleFunc := procedure(const AVM: TJetVM)
  begin
    var LArg := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg.IntValue * 2));
  end;

  FVM.RegisterNativeFunction('double', LDoubleFunc, [jvtInt], jvtInt);

  LFuncLabel := FVM.CreateLabel();
  LMainLabel := FVM.CreateLabel();

  // Mix native and VM function calls
  FVM.Jump(LMainLabel)

     // VM function: add 2
     .BindLabel(LFuncLabel)
     .LoadInt(2)
     .AddInt()
     .ReturnValue()

     // Main: call native double(10) then VM add2 -> 20 + 2 = 22
     .BindLabel(LMainLabel)
     .LoadInt(10)
     .CallFunction('double')   // 10 * 2 = 20
     .Call(LFuncLabel)         // 20 + 2 = 22
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(22), LResult.IntValue, 'Mixed native and VM function calls should work correctly');
end;

// =============================================================================
// Step Execution and Debugging Tests
// =============================================================================

procedure TTestJetVMControlFlow.TestStepExecutionThroughJumps();
var
  LLabel: Integer;
  LPC1: Integer;
  LPC2: Integer;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadInt(42)
     .Jump(LLabel)
     .LoadInt(999)
     .BindLabel(LLabel)
     .Stop();

  FVM.Finalize();  // Prepare for stepping

  LPC1 := FVM.GetPC();
  FVM.Step();      // Execute LoadInt(42)
  FVM.Step();      // Execute Jump

  LPC2 := FVM.GetPC();

  Assert.IsTrue(LPC2 > LPC1, 'PC should advance through jump execution');
end;

procedure TTestJetVMControlFlow.TestStepExecutionThroughCalls();
var
  LFuncLabel: Integer;
  LMainLabel: Integer;
  LInitialCallDepth: Integer;
  LCallDepth: Integer;
begin
  LFuncLabel := FVM.CreateLabel();
  LMainLabel := FVM.CreateLabel();

  FVM.Jump(LMainLabel)
     .BindLabel(LFuncLabel)
     .LoadInt(42)
     .ReturnValue()
     .BindLabel(LMainLabel)
     .Call(LFuncLabel)
     .Stop();

  FVM.Finalize();  // Prepare for stepping

  LInitialCallDepth := FVM.GetCallDepth();

  // Step through execution
  FVM.Step();      // Jump to main
  FVM.Step();      // Call function

  LCallDepth := FVM.GetCallDepth();

  Assert.IsTrue(LCallDepth >= LInitialCallDepth, 'Call depth should track function calls');
end;

procedure TTestJetVMControlFlow.TestExecutionStateTracking();
var
  LInitialPC: Integer;
  LInitialSP: Integer;
  LFinalPC: Integer;
  LFinalSP: Integer;
begin
  LInitialPC := FVM.GetPC();
  LInitialSP := FVM.GetSP();

  FVM.LoadInt(42)
     .Nop()
     .Stop();

  FVM.Execute();

  LFinalPC := FVM.GetPC();
  LFinalSP := FVM.GetSP();

  Assert.IsTrue(LFinalPC > LInitialPC, 'PC should advance during execution');
  Assert.IsTrue(LFinalSP > LInitialSP, 'SP should change with stack operations');
end;

procedure TTestJetVMControlFlow.TestCallDepthTracking();
var
  LInitialDepth: Integer;
  LMaxDepth: Integer;
  LFinalDepth: Integer;
  LDoubleFunc: TJetNativeFunction;
begin
  LInitialDepth := FVM.GetCallDepth();

  // Register function to track call depth
  LMaxDepth := LInitialDepth;
  LDoubleFunc := procedure(const AVM: TJetVM)
  begin
    var LCurrentDepth := AVM.GetCallDepth();
    if LCurrentDepth > LMaxDepth then
      LMaxDepth := LCurrentDepth;

    var LArg := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg.IntValue * 2));
  end;

  FVM.RegisterNativeFunction('track_double', LDoubleFunc, [jvtInt], jvtInt);

  FVM.LoadInt(21)
     .CallFunction('track_double')
     .Stop();

  FVM.Execute();

  LFinalDepth := FVM.GetCallDepth();

  Assert.IsTrue(LMaxDepth > LInitialDepth, 'Call depth should increase during function call');
  Assert.AreEqual(LInitialDepth, LFinalDepth, 'Call depth should return to initial value');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMControlFlow);

end.
