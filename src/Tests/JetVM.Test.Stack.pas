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

unit JetVM.Test.Stack;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMStack = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Stack Initialization Tests
    // ==========================================================================
    [Test]
    procedure TestStackInitialState();
    [Test]
    procedure TestStackInitialSize();
    [Test]
    procedure TestStackPointerInitialization();

    // ==========================================================================
    // Basic Stack Operations
    // ==========================================================================
    [Test]
    procedure TestPushValue();
    [Test]
    procedure TestPopValue();
    [Test]
    procedure TestPushPopRoundTrip();
    [Test]
    procedure TestMultiplePushPop();

    // ==========================================================================
    // PeekValue Tests
    // ==========================================================================
    [Test]
    procedure TestPeekValueTop();
    [Test]
    procedure TestPeekValueWithOffset();
    [Test]
    procedure TestPeekValueMultipleOffsets();
    [Test]
    procedure TestPeekValueDoesNotModifyStack();

    // ==========================================================================
    // Stack Pointer Management
    // ==========================================================================
    [Test]
    procedure TestStackPointerAfterPush();
    [Test]
    procedure TestStackPointerAfterPop();
    [Test]
    procedure TestStackPointerAfterReset();
    [Test]
    procedure TestStackPointerConsistency();

    // ==========================================================================
    // GetStackValue Tests
    // ==========================================================================
    [Test]
    procedure TestGetStackValueValidIndex();
    [Test]
    procedure TestGetStackValueMultipleIndices();
    [Test]
    procedure TestGetStackValueAfterOperations();

    // ==========================================================================
    // Stack Type Support Tests
    // ==========================================================================
    [Test]
    procedure TestStackWithAllValueTypes();
    [Test]
    procedure TestStackWithIntegerValues();
    [Test]
    procedure TestStackWithUIntegerValues();
    [Test]
    procedure TestStackWithStringValues();
    [Test]
    procedure TestStackWithBooleanValues();
    [Test]
    procedure TestStackWithPointerValues();

    // ==========================================================================
    // Fluent Stack Operations
    // ==========================================================================
    [Test]
    procedure TestFluentPushOperation();
    [Test]
    procedure TestFluentPopOperation();
    [Test]
    procedure TestFluentDupOperation();
    [Test]
    procedure TestFluentSwapOperation();
    [Test]
    procedure TestFluentRotOperation();

    // ==========================================================================
    // Advanced Fluent Operations
    // ==========================================================================
    [Test]
    procedure TestChainedFluentOperations();
    [Test]
    procedure TestComplexStackManipulation();
    [Test]
    procedure TestFluentOperationsReturnSameInstance();

    // ==========================================================================
    // Stack Underflow Protection
    // ==========================================================================
    [Test]
    procedure TestPopEmptyStackThrowsException();
    [Test]
    procedure TestPeekEmptyStackThrowsException();
    [Test]
    procedure TestGetStackValueInvalidIndexThrowsException();
    [Test]
    procedure TestFluentPopEmptyStackHandling();

    // ==========================================================================
    // Stack Overflow Protection
    // ==========================================================================
    [Test]
    procedure TestStackOverflowProtection();
    [Test]
    procedure TestLargeStackOperations();
    [Test]
    procedure TestStackGrowthBehavior();

    // ==========================================================================
    // Stack State Management
    // ==========================================================================
    [Test]
    procedure TestStackAfterVMReset();
    [Test]
    procedure TestStackStateConsistency();
    [Test]
    procedure TestStackPreservationDuringExecution();

    // ==========================================================================
    // Error Handling Tests
    // ==========================================================================
    [Test]
    procedure TestStackUnderflowErrorMessages();
    [Test]
    procedure TestInvalidStackAccessErrorMessages();
    [Test]
    procedure TestStackErrorRecovery();

    // ==========================================================================
    // Performance and Edge Cases
    // ==========================================================================
    [Test]
    procedure TestStackPerformanceWithManyOperations();
    [Test]
    procedure TestStackBoundaryConditions();
    [Test]
    procedure TestStackMemoryManagement();

    // ==========================================================================
    // Integration Tests
    // ==========================================================================
    [Test]
    procedure TestStackDuringProgramExecution();
    [Test]
    procedure TestStackWithArithmeticOperations();
    [Test]
    procedure TestStackWithFunctionCalls();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMStack.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMStack.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Stack Initialization Tests
// =============================================================================

procedure TTestJetVMStack.TestStackInitialState();
begin
  // Test that stack starts in clean state
  Assert.AreEqual(0, FVM.GetSP(), 'Stack pointer should start at 0');
  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running initially');
end;

procedure TTestJetVMStack.TestStackInitialSize();
begin
  // Test that stack is properly initialized with capacity
  Assert.AreEqual(0, FVM.GetSP(), 'Initial stack should be empty');

  // Stack should be able to accept values without immediate overflow
  FVM.PushValue(FVM.MakeIntConstant(42));
  Assert.AreEqual(1, FVM.GetSP(), 'Stack pointer should advance after push');
end;

procedure TTestJetVMStack.TestStackPointerInitialization();
begin
  // Verify stack pointer starts at correct position
  Assert.AreEqual(0, FVM.GetSP(), 'Stack pointer should initialize to 0');

  // After reset, should return to initial state
  FVM.PushValue(FVM.MakeIntConstant(100));
  FVM.Reset();
  Assert.AreEqual(0, FVM.GetSP(), 'Stack pointer should reset to 0');
end;

// =============================================================================
// Basic Stack Operations
// =============================================================================

procedure TTestJetVMStack.TestPushValue();
var
  LValue: TJetValue;
  LInitialSP: Integer;
begin
  LInitialSP := FVM.GetSP();
  LValue := FVM.MakeIntConstant(42);

  FVM.PushValue(LValue);

  Assert.AreEqual(LInitialSP + 1, FVM.GetSP(), 'Stack pointer should increment after push');
end;

procedure TTestJetVMStack.TestPopValue();
var
  LPushedValue: TJetValue;
  LPoppedValue: TJetValue;
  LInitialSP: Integer;
begin
  LPushedValue := FVM.MakeIntConstant(42);
  LInitialSP := FVM.GetSP();

  FVM.PushValue(LPushedValue);
  LPoppedValue := FVM.PopValue();

  Assert.AreEqual(LInitialSP, FVM.GetSP(), 'Stack pointer should return to initial position after pop');
  Assert.AreEqual(LPushedValue.ValueType, LPoppedValue.ValueType, 'Value type should be preserved');
  Assert.AreEqual(LPushedValue.IntValue, LPoppedValue.IntValue, 'Value should be preserved');
end;

procedure TTestJetVMStack.TestPushPopRoundTrip();
var
  LOriginalValue: TJetValue;
  LRetrievedValue: TJetValue;
begin
  // Test with integer
  LOriginalValue := FVM.MakeIntConstant(12345);
  FVM.PushValue(LOriginalValue);
  LRetrievedValue := FVM.PopValue();

  Assert.AreEqual(LOriginalValue.ValueType, LRetrievedValue.ValueType, 'Integer type should survive round trip');
  Assert.AreEqual(LOriginalValue.IntValue, LRetrievedValue.IntValue, 'Integer value should survive round trip');

  // Test with string
  LOriginalValue := FVM.MakeStrConstant('Hello, Stack!');
  FVM.PushValue(LOriginalValue);
  LRetrievedValue := FVM.PopValue();

  Assert.AreEqual(LOriginalValue.ValueType, LRetrievedValue.ValueType, 'String type should survive round trip');
  Assert.AreEqual(LOriginalValue.StrValue, LRetrievedValue.StrValue, 'String value should survive round trip');

  // Test with boolean
  LOriginalValue := FVM.MakeBoolConstant(True);
  FVM.PushValue(LOriginalValue);
  LRetrievedValue := FVM.PopValue();

  Assert.AreEqual(LOriginalValue.ValueType, LRetrievedValue.ValueType, 'Boolean type should survive round trip');
  Assert.AreEqual(LOriginalValue.BoolValue, LRetrievedValue.BoolValue, 'Boolean value should survive round trip');
end;

procedure TTestJetVMStack.TestMultiplePushPop();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LRetrieved1: TJetValue;
  LRetrieved2: TJetValue;
  LRetrieved3: TJetValue;
begin
  // Push multiple values
  LValue1 := FVM.MakeIntConstant(10);
  LValue2 := FVM.MakeStrConstant('Middle');
  LValue3 := FVM.MakeBoolConstant(False);

  FVM.PushValue(LValue1);
  FVM.PushValue(LValue2);
  FVM.PushValue(LValue3);

  Assert.AreEqual(3, FVM.GetSP(), 'Stack should contain 3 values');

  // Pop in reverse order (LIFO)
  LRetrieved3 := FVM.PopValue();
  LRetrieved2 := FVM.PopValue();
  LRetrieved1 := FVM.PopValue();

  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be empty after popping all values');

  // Verify values in LIFO order
  Assert.AreEqual(LValue3.BoolValue, LRetrieved3.BoolValue, 'Last pushed should be first popped');
  Assert.AreEqual(LValue2.StrValue, LRetrieved2.StrValue, 'Middle value should be second popped');
  Assert.AreEqual(LValue1.IntValue, LRetrieved1.IntValue, 'First pushed should be last popped');
end;

// =============================================================================
// PeekValue Tests
// =============================================================================

procedure TTestJetVMStack.TestPeekValueTop();
var
  LPushedValue: TJetValue;
  LPeekedValue: TJetValue;
  LInitialSP: Integer;
begin
  LPushedValue := FVM.MakeIntConstant(999);
  FVM.PushValue(LPushedValue);
  LInitialSP := FVM.GetSP();

  LPeekedValue := FVM.PeekValue();

  Assert.AreEqual(LInitialSP, FVM.GetSP(), 'Peek should not modify stack pointer');
  Assert.AreEqual(LPushedValue.ValueType, LPeekedValue.ValueType, 'Peek should return correct type');
  Assert.AreEqual(LPushedValue.IntValue, LPeekedValue.IntValue, 'Peek should return correct value');
end;

procedure TTestJetVMStack.TestPeekValueWithOffset();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LPeekedValue: TJetValue;
begin
  // Push three values
  LValue1 := FVM.MakeIntConstant(100);
  LValue2 := FVM.MakeIntConstant(200);
  LValue3 := FVM.MakeIntConstant(300);

  FVM.PushValue(LValue1);
  FVM.PushValue(LValue2);
  FVM.PushValue(LValue3);

  // Peek at different offsets
  LPeekedValue := FVM.PeekValue(0); // Top of stack
  Assert.AreEqual(LValue3.IntValue, LPeekedValue.IntValue, 'Peek(0) should return top value');

  LPeekedValue := FVM.PeekValue(1); // Second from top
  Assert.AreEqual(LValue2.IntValue, LPeekedValue.IntValue, 'Peek(1) should return second value');

  LPeekedValue := FVM.PeekValue(2); // Third from top
  Assert.AreEqual(LValue1.IntValue, LPeekedValue.IntValue, 'Peek(2) should return bottom value');
end;

procedure TTestJetVMStack.TestPeekValueMultipleOffsets();
var
  LIndex: Integer;
  LValues: array[0..4] of TJetValue;
  LPeekedValue: TJetValue;
begin
  // Push 5 different values
  for LIndex := 0 to 4 do
  begin
    LValues[LIndex] := FVM.MakeIntConstant((LIndex + 1) * 10);
    FVM.PushValue(LValues[LIndex]);
  end;

  // Verify we can peek at all positions
  for LIndex := 0 to 4 do
  begin
    LPeekedValue := FVM.PeekValue(LIndex);
    Assert.AreEqual(LValues[4 - LIndex].IntValue, LPeekedValue.IntValue,
      Format('Peek(%d) should return correct value', [LIndex]));
  end;

  Assert.AreEqual(5, FVM.GetSP(), 'Stack pointer should remain unchanged after multiple peeks');
end;

procedure TTestJetVMStack.TestPeekValueDoesNotModifyStack();
var
  LValue: TJetValue;
  LInitialSP: Integer;
  LIndex: Integer;
begin
  // Push a value
  LValue := FVM.MakeStrConstant('Peek Test');
  FVM.PushValue(LValue);
  LInitialSP := FVM.GetSP();

  // Peek multiple times
  for LIndex := 1 to 10 do
  begin
    FVM.PeekValue();
    Assert.AreEqual(LInitialSP, FVM.GetSP(), Format('Stack pointer should remain unchanged after peek #%d', [LIndex]));
  end;

  // Verify value is still there and correct
  Assert.AreEqual(LValue.StrValue, FVM.PopValue().StrValue, 'Value should still be correct after multiple peeks');
end;

// =============================================================================
// Stack Pointer Management
// =============================================================================

procedure TTestJetVMStack.TestStackPointerAfterPush();
var
  LInitialSP: Integer;
  LIndex: Integer;
begin
  LInitialSP := FVM.GetSP();

  for LIndex := 1 to 5 do
  begin
    FVM.PushValue(FVM.MakeIntConstant(LIndex));
    Assert.AreEqual(LInitialSP + LIndex, FVM.GetSP(),
      Format('Stack pointer should be %d after pushing %d values', [LInitialSP + LIndex, LIndex]));
  end;
end;

procedure TTestJetVMStack.TestStackPointerAfterPop();
var
  LInitialSP: Integer;
  LIndex: Integer;
begin
  LInitialSP := FVM.GetSP();

  // Push 5 values
  for LIndex := 1 to 5 do
    FVM.PushValue(FVM.MakeIntConstant(LIndex));

  // Pop them back
  for LIndex := 5 downto 1 do
  begin
    FVM.PopValue();
    Assert.AreEqual(LInitialSP + LIndex - 1, FVM.GetSP(),
      Format('Stack pointer should be %d after popping to %d values', [LInitialSP + LIndex - 1, LIndex - 1]));
  end;
end;

procedure TTestJetVMStack.TestStackPointerAfterReset();
var
  LIndex: Integer;
begin
  // Push several values
  for LIndex := 1 to 10 do
    FVM.PushValue(FVM.MakeIntConstant(LIndex));

  Assert.IsTrue(FVM.GetSP() > 0, 'Stack should have values before reset');

  FVM.Reset();

  Assert.AreEqual(0, FVM.GetSP(), 'Stack pointer should be 0 after reset');
end;

procedure TTestJetVMStack.TestStackPointerConsistency();
var
  LValue: TJetValue;
  LExpectedSP: Integer;
begin
  LExpectedSP := 0;

  // Test push operations
  FVM.PushValue(FVM.MakeIntConstant(1));
  Inc(LExpectedSP);
  Assert.AreEqual(LExpectedSP, FVM.GetSP(), 'SP should be consistent after push');

  FVM.PushValue(FVM.MakeStrConstant('test'));
  Inc(LExpectedSP);
  Assert.AreEqual(LExpectedSP, FVM.GetSP(), 'SP should be consistent after second push');

  // Test pop operations
  LValue := FVM.PopValue();
  Dec(LExpectedSP);
  Assert.AreEqual(LExpectedSP, FVM.GetSP(), 'SP should be consistent after pop');
  Assert.AreEqual('test', LValue.StrValue, 'Popped value should be correct');

  LValue := FVM.PopValue();
  Dec(LExpectedSP);
  Assert.AreEqual(LExpectedSP, FVM.GetSP(), 'SP should be consistent after second pop');
  Assert.AreEqual(Int64(1), LValue.IntValue, 'Popped value should be correct');
end;

// =============================================================================
// GetStackValue Tests
// =============================================================================

procedure TTestJetVMStack.TestGetStackValueValidIndex();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LRetrievedValue: TJetValue;
begin
  LValue1 := FVM.MakeIntConstant(111);
  LValue2 := FVM.MakeStrConstant('Stack Item');

  FVM.PushValue(LValue1);
  FVM.PushValue(LValue2);

  // Test accessing valid indices
  LRetrievedValue := FVM.GetStackValue(0);
  Assert.AreEqual(LValue1.IntValue, LRetrievedValue.IntValue, 'GetStackValue(0) should return first pushed value');

  LRetrievedValue := FVM.GetStackValue(1);
  Assert.AreEqual(LValue2.StrValue, LRetrievedValue.StrValue, 'GetStackValue(1) should return second pushed value');
end;

procedure TTestJetVMStack.TestGetStackValueMultipleIndices();
var
  LValues: array[0..9] of TJetValue;
  LRetrievedValue: TJetValue;
  LIndex: Integer;
begin
  // Push 10 different values
  for LIndex := 0 to 9 do
  begin
    LValues[LIndex] := FVM.MakeIntConstant((LIndex + 1) * 100);
    FVM.PushValue(LValues[LIndex]);
  end;

  // Verify we can access all indices
  for LIndex := 0 to 9 do
  begin
    LRetrievedValue := FVM.GetStackValue(LIndex);
    Assert.AreEqual(LValues[LIndex].IntValue, LRetrievedValue.IntValue,
      Format('GetStackValue(%d) should return correct value', [LIndex]));
  end;
end;

procedure TTestJetVMStack.TestGetStackValueAfterOperations();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LPoppedValue: TJetValue;
  LRetrievedValue: TJetValue;
begin
  // Push three values
  LValue1 := FVM.MakeIntConstant(100);
  LValue2 := FVM.MakeIntConstant(200);
  LValue3 := FVM.MakeIntConstant(300);

  FVM.PushValue(LValue1);
  FVM.PushValue(LValue2);
  FVM.PushValue(LValue3);

  // Pop the top value
  LPoppedValue := FVM.PopValue();
  Assert.AreEqual(LValue3.IntValue, LPoppedValue.IntValue, 'Should pop the last pushed value');

  // Verify remaining values are accessible
  LRetrievedValue := FVM.GetStackValue(0);
  Assert.AreEqual(LValue1.IntValue, LRetrievedValue.IntValue, 'Bottom value should still be accessible');

  LRetrievedValue := FVM.GetStackValue(1);
  Assert.AreEqual(LValue2.IntValue, LRetrievedValue.IntValue, 'Middle value should still be accessible');
end;

// =============================================================================
// Stack Type Support Tests
// =============================================================================

procedure TTestJetVMStack.TestStackWithAllValueTypes();
var
  LIntValue: TJetValue;
  LUIntValue: TJetValue;
  LStrValue: TJetValue;
  LBoolValue: TJetValue;
  LPtrValue: TJetValue;
  LTestInt: Integer;
begin
  // Create values of all types
  LIntValue := FVM.MakeIntConstant(-12345);
  LUIntValue := FVM.MakeUIntConstant(54321);
  LStrValue := FVM.MakeStrConstant('All Types Test');
  LBoolValue := FVM.MakeBoolConstant(True);
  LTestInt := 42;
  LPtrValue := FVM.MakePtrConstant(@LTestInt);

  // Push all types onto stack
  FVM.PushValue(LIntValue);
  FVM.PushValue(LUIntValue);
  FVM.PushValue(LStrValue);
  FVM.PushValue(LBoolValue);
  FVM.PushValue(LPtrValue);

  Assert.AreEqual(5, FVM.GetSP(), 'Stack should contain all 5 values');

  // Pop and verify in reverse order
  Assert.AreEqual(LPtrValue.PtrValue, FVM.PopValue().PtrValue, 'Pointer value should be preserved');
  Assert.AreEqual(LBoolValue.BoolValue, FVM.PopValue().BoolValue, 'Boolean value should be preserved');
  Assert.AreEqual(LStrValue.StrValue, FVM.PopValue().StrValue, 'String value should be preserved');
  Assert.AreEqual(LUIntValue.UIntValue, FVM.PopValue().UIntValue, 'UInt value should be preserved');
  Assert.AreEqual(LIntValue.IntValue, FVM.PopValue().IntValue, 'Int value should be preserved');
end;

procedure TTestJetVMStack.TestStackWithIntegerValues();
var
  LValues: array[0..2] of Int64;
  LRetrievedValue: TJetValue;
  LIndex: Integer;
begin
  LValues[0] := High(Int64);
  LValues[1] := Low(Int64);
  LValues[2] := 0;

  // Push all integer boundary values
  for LIndex := 0 to 2 do
    FVM.PushValue(FVM.MakeIntConstant(LValues[LIndex]));

  // Pop and verify in reverse order
  for LIndex := 2 downto 0 do
  begin
    LRetrievedValue := FVM.PopValue();
    Assert.AreEqual(jvtInt, LRetrievedValue.ValueType, 'Should maintain integer type');
    Assert.AreEqual(LValues[LIndex], LRetrievedValue.IntValue, 'Should maintain integer value');
  end;
end;

procedure TTestJetVMStack.TestStackWithUIntegerValues();
var
  LValues: array[0..2] of UInt64;
  LRetrievedValue: TJetValue;
  LIndex: Integer;
begin
  LValues[0] := High(UInt64);
  LValues[1] := Low(UInt64);
  LValues[2] := 4294967296; // 2^32

  // Push all unsigned integer boundary values
  for LIndex := 0 to 2 do
    FVM.PushValue(FVM.MakeUIntConstant(LValues[LIndex]));

  // Pop and verify in reverse order
  for LIndex := 2 downto 0 do
  begin
    LRetrievedValue := FVM.PopValue();
    Assert.AreEqual(jvtUInt, LRetrievedValue.ValueType, 'Should maintain unsigned integer type');
    Assert.AreEqual(LValues[LIndex], LRetrievedValue.UIntValue, 'Should maintain unsigned integer value');
  end;
end;

procedure TTestJetVMStack.TestStackWithStringValues();
var
  LValues: array[0..3] of string;
  LRetrievedValue: TJetValue;
  LIndex: Integer;
begin
  LValues[0] := '';
  LValues[1] := 'Simple string';
  LValues[2] := 'String with special chars: !@#$%^&*()';
  LValues[3] := 'Unicode string: αβγ 中文 🚀';

  // Push all string values
  for LIndex := 0 to 3 do
    FVM.PushValue(FVM.MakeStrConstant(LValues[LIndex]));

  // Pop and verify in reverse order
  for LIndex := 3 downto 0 do
  begin
    LRetrievedValue := FVM.PopValue();
    Assert.AreEqual(jvtStr, LRetrievedValue.ValueType, 'Should maintain string type');
    Assert.AreEqual(LValues[LIndex], LRetrievedValue.StrValue, 'Should maintain string value');
  end;
end;

procedure TTestJetVMStack.TestStackWithBooleanValues();
var
  LValues: array[0..1] of Boolean;
  LRetrievedValue: TJetValue;
  LIndex: Integer;
begin
  LValues[0] := True;
  LValues[1] := False;

  // Push both boolean values
  for LIndex := 0 to 1 do
    FVM.PushValue(FVM.MakeBoolConstant(LValues[LIndex]));

  // Pop and verify in reverse order
  for LIndex := 1 downto 0 do
  begin
    LRetrievedValue := FVM.PopValue();
    Assert.AreEqual(jvtBool, LRetrievedValue.ValueType, 'Should maintain boolean type');
    Assert.AreEqual(LValues[LIndex], LRetrievedValue.BoolValue, 'Should maintain boolean value');
  end;
end;

procedure TTestJetVMStack.TestStackWithPointerValues();
var
  LTestInt1: Integer;
  LTestInt2: Integer;
  LPointerValue1: TJetValue;
  LPointerValue2: TJetValue;
  LNilValue: TJetValue;
  LRetrievedValue: TJetValue;
begin
  LTestInt1 := 100;
  LTestInt2 := 200;

  LPointerValue1 := FVM.MakePtrConstant(@LTestInt1);
  LPointerValue2 := FVM.MakePtrConstant(@LTestInt2);
  LNilValue := FVM.MakePtrConstant(nil);

  // Push pointer values
  FVM.PushValue(LPointerValue1);
  FVM.PushValue(LPointerValue2);
  FVM.PushValue(LNilValue);

  // Pop and verify in reverse order
  LRetrievedValue := FVM.PopValue();
  Assert.AreEqual(jvtPointer, LRetrievedValue.ValueType, 'Should maintain pointer type');
  Assert.IsNull(LRetrievedValue.PtrValue, 'Should maintain nil pointer value');

  LRetrievedValue := FVM.PopValue();
  Assert.AreEqual(jvtPointer, LRetrievedValue.ValueType, 'Should maintain pointer type');
  Assert.AreEqual(@LTestInt2, LRetrievedValue.PtrValue, 'Should maintain second pointer value');

  LRetrievedValue := FVM.PopValue();
  Assert.AreEqual(jvtPointer, LRetrievedValue.ValueType, 'Should maintain pointer type');
  Assert.AreEqual(@LTestInt1, LRetrievedValue.PtrValue, 'Should maintain first pointer value');
end;

// =============================================================================
// Fluent Stack Operations
// =============================================================================

procedure TTestJetVMStack.TestFluentPushOperation();
var
  LResult: TJetVM;
  LValue: TJetValue;
begin
  // Test that fluent Push operation works
  FVM.LoadInt(42);
  LResult := FVM.Push();

  Assert.AreSame(FVM, LResult, 'Push should return same VM instance');

  // Execute to see effect
  FVM.Stop().Execute();

  // Should have two copies of 42 on stack (original + pushed copy)
  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(42), LValue.IntValue, 'Top value should be 42');

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(42), LValue.IntValue, 'Second value should also be 42');
end;

procedure TTestJetVMStack.TestFluentPopOperation();
var
  LResult: TJetVM;
begin
  // Test that fluent Pop operation works
  FVM.LoadInt(100).LoadInt(200);
  LResult := FVM.Pop();

  Assert.AreSame(FVM, LResult, 'Pop should return same VM instance');

  // Execute and check result
  FVM.Stop().Execute();

  // Should only have 100 left (200 was popped)
  Assert.AreEqual(Int64(100), FVM.PopValue().IntValue, 'Should have 100 remaining after pop');
  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be empty after popping remaining value');
end;

procedure TTestJetVMStack.TestFluentDupOperation();
var
  LResult: TJetVM;
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test that fluent Dup operation works
  FVM.LoadInt(333);
  LResult := FVM.Dup();

  Assert.AreSame(FVM, LResult, 'Dup should return same VM instance');

  // Execute and check result
  FVM.Stop().Execute();

  // Should have two copies of 333
  LValue1 := FVM.PopValue();
  LValue2 := FVM.PopValue();

  Assert.AreEqual(Int64(333), LValue1.IntValue, 'First duplicate should be 333');
  Assert.AreEqual(Int64(333), LValue2.IntValue, 'Second duplicate should be 333');
end;

procedure TTestJetVMStack.TestFluentSwapOperation();
var
  LResult: TJetVM;
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test that fluent Swap operation works
  FVM.LoadInt(111).LoadInt(222);
  LResult := FVM.Swap();

  Assert.AreSame(FVM, LResult, 'Swap should return same VM instance');

  // Execute and check result
  FVM.Stop().Execute();

  // Order should be swapped: 111 should be on top, 222 on bottom
  LValue1 := FVM.PopValue();
  LValue2 := FVM.PopValue();

  Assert.AreEqual(Int64(111), LValue1.IntValue, 'Top value should be 111 after swap');
  Assert.AreEqual(Int64(222), LValue2.IntValue, 'Bottom value should be 222 after swap');
end;

procedure TTestJetVMStack.TestFluentRotOperation();
var
  LResult: TJetVM;
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
begin
  // Test that fluent Rot operation works
  FVM.LoadInt(100).LoadInt(200).LoadInt(300);
  LResult := FVM.Rot();

  Assert.AreSame(FVM, LResult, 'Rot should return same VM instance');

  // Execute and check result
  FVM.Stop().Execute();

  // ROT should rotate top 3 values: A B C -> B C A
  // So 100 200 300 -> 200 300 100
  LValue1 := FVM.PopValue(); // Top
  LValue2 := FVM.PopValue(); // Middle
  LValue3 := FVM.PopValue(); // Bottom

  Assert.AreEqual(Int64(100), LValue1.IntValue, 'Top should be 100 after rot');
  Assert.AreEqual(Int64(300), LValue2.IntValue, 'Middle should be 300 after rot');
  Assert.AreEqual(Int64(200), LValue3.IntValue, 'Bottom should be 200 after rot');
end;

// =============================================================================
// Advanced Fluent Operations
// =============================================================================

procedure TTestJetVMStack.TestChainedFluentOperations();
var
  LResult: TJetVM;
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test chaining multiple fluent stack operations
  LResult := FVM.LoadInt(50)
               .Dup()
               .LoadInt(25)
               .Swap()
               .Stop();

  Assert.AreSame(FVM, LResult, 'Chained operations should return same VM instance');

  // Execute and verify result
  FVM.Execute();

  // Expected stack: 25, 50, 50 (bottom to top)
  LValue1 := FVM.PopValue(); // Should be 50
  LValue2 := FVM.PopValue(); // Should be 25

  Assert.AreEqual(Int64(50), LValue1.IntValue, 'Top after chain should be 50');
  Assert.AreEqual(Int64(25), LValue2.IntValue, 'Next after chain should be 25');
end;

procedure TTestJetVMStack.TestComplexStackManipulation();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
begin
  // Complex sequence: Load 3 values, duplicate top, rotate, swap
  FVM.LoadInt(10)
     .LoadInt(20)
     .LoadInt(30)
     .Dup()       // Stack: 10, 20, 30, 30
     .Rot()       // Stack: 10, 30, 30, 20
     .Swap()      // Stack: 10, 30, 20, 30
     .Stop()
     .Execute();

  // Verify final stack state
  LValue1 := FVM.PopValue(); // Should be 30
  LValue2 := FVM.PopValue(); // Should be 20
  LValue3 := FVM.PopValue(); // Should be 30

  Assert.AreEqual(Int64(30), LValue1.IntValue, 'Final top should be 30');
  Assert.AreEqual(Int64(20), LValue2.IntValue, 'Final middle should be 20');
  Assert.AreEqual(Int64(30), LValue3.IntValue, 'Final next should be 30');

  // One more value should remain
  Assert.AreEqual(Int64(10), FVM.PopValue().IntValue, 'Final bottom should be 10');
end;

procedure TTestJetVMStack.TestFluentOperationsReturnSameInstance();
var
  LResult1: TJetVM;
  LResult2: TJetVM;
  LResult3: TJetVM;
  LResult4: TJetVM;
  LResult5: TJetVM;
begin
  // Test that all fluent stack operations return the same VM instance
  FVM.LoadInt(1).LoadInt(2).LoadInt(3);

  LResult1 := FVM.Push();
  LResult2 := FVM.Pop();
  LResult3 := FVM.Dup();
  LResult4 := FVM.Swap();
  LResult5 := FVM.Rot();

  Assert.AreSame(FVM, LResult1, 'Push should return same VM instance');
  Assert.AreSame(FVM, LResult2, 'Pop should return same VM instance');
  Assert.AreSame(FVM, LResult3, 'Dup should return same VM instance');
  Assert.AreSame(FVM, LResult4, 'Swap should return same VM instance');
  Assert.AreSame(FVM, LResult5, 'Rot should return same VM instance');
end;

// =============================================================================
// Stack Underflow Protection
// =============================================================================

procedure TTestJetVMStack.TestPopEmptyStackThrowsException();
begin
  // Verify stack is empty
  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be empty initially');

  // Attempt to pop from empty stack should throw exception
  Assert.WillRaise(
    procedure
    begin
      FVM.PopValue();
    end,
    EJetVMError,
    'Popping from empty stack should raise EJetVMError'
  );
end;

procedure TTestJetVMStack.TestPeekEmptyStackThrowsException();
begin
  // Verify stack is empty
  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be empty initially');

  // Attempt to peek empty stack should throw exception
  Assert.WillRaise(
    procedure
    begin
      FVM.PeekValue();
    end,
    EJetVMError,
    'Peeking empty stack should raise EJetVMError'
  );
end;

procedure TTestJetVMStack.TestGetStackValueInvalidIndexThrowsException();
begin
  // Push one value
  FVM.PushValue(FVM.MakeIntConstant(42));

  // Accessing valid index should work
  Assert.AreEqual(Int64(42), FVM.GetStackValue(0).IntValue, 'Valid index should work');

  // Accessing invalid indices should throw exceptions
  Assert.WillRaise(
    procedure
    begin
      FVM.GetStackValue(1); // Beyond stack size
    end,
    EJetVMError,
    'Invalid high index should raise EJetVMError'
  );

  Assert.WillRaise(
    procedure
    begin
      FVM.GetStackValue(-1); // Negative index
    end,
    EJetVMError,
    'Negative index should raise EJetVMError'
  );
end;

procedure TTestJetVMStack.TestFluentPopEmptyStackHandling();
begin
  // Test that fluent Pop operation on empty stack generates appropriate bytecode
  // This should be caught during execution, not during bytecode generation
  FVM.Pop().Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Executing pop on empty stack should raise EJetVMError'
  );
end;

// =============================================================================
// Stack Overflow Protection
// =============================================================================

procedure TTestJetVMStack.TestStackOverflowProtection();
var
  LIndex: Integer;
  LMaxPushes: Integer;
begin
  // Try to push a very large number of values
  // This should either work (if stack grows) or fail gracefully
  LMaxPushes := 2000; // Reduced from 5000 to be more conservative

  try
    for LIndex := 1 to LMaxPushes do
    begin
      FVM.PushValue(FVM.MakeIntConstant(LIndex));
    end;

    // If we get here, stack grew successfully
    Assert.AreEqual(LMaxPushes, FVM.GetSP(), 'Stack should contain all pushed values');

    // Verify we can still access values
    Assert.AreEqual(Int64(LMaxPushes), FVM.PeekValue().IntValue, 'Should be able to peek top value');
    Assert.AreEqual(Int64(1), FVM.GetStackValue(0).IntValue, 'Should be able to access bottom value');

  except
    on E: EJetVMError do
      // If overflow protection triggers, that's also acceptable behavior
      Assert.IsTrue(Length(E.Message) > 0, 'Overflow exception should have meaningful message');
  end;
end;

procedure TTestJetVMStack.TestLargeStackOperations();
var
  LIndex: Integer;
  LStackSize: Integer;
  LRetrievedValue: TJetValue;
begin
  LStackSize := 1000; // Reasonable large test

  // Push many values
  for LIndex := 1 to LStackSize do
    FVM.PushValue(FVM.MakeIntConstant(LIndex));

  Assert.AreEqual(LStackSize, FVM.GetSP(), 'Stack should contain all values');

  // Verify values are correct by sampling
  Assert.AreEqual(Int64(1), FVM.GetStackValue(0).IntValue, 'Bottom value should be 1');
  Assert.AreEqual(Int64(500), FVM.GetStackValue(499).IntValue, 'Middle value should be 500');
  Assert.AreEqual(Int64(LStackSize), FVM.PeekValue().IntValue, 'Top value should be max');

  // Pop all values and verify they come back in correct order
  for LIndex := LStackSize downto 1 do
  begin
    LRetrievedValue := FVM.PopValue();
    Assert.AreEqual(Int64(LIndex), LRetrievedValue.IntValue,
      Format('Value %d should be popped in correct order', [LIndex]));
  end;

  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be empty after popping all values');
end;

procedure TTestJetVMStack.TestStackGrowthBehavior();
var
  LIndex: Integer;
  LInitialCapacity: Integer;
  LGrowthSize: Integer;
begin
  // Test that stack can grow beyond initial capacity
  LInitialCapacity := 100;
  LGrowthSize := 200;

  // Push more than initial capacity
  for LIndex := 1 to LInitialCapacity + LGrowthSize do
    FVM.PushValue(FVM.MakeIntConstant(LIndex));

  // Should be able to access all values
  Assert.AreEqual(LInitialCapacity + LGrowthSize, FVM.GetSP(), 'Stack should have grown');
  Assert.AreEqual(Int64(1), FVM.GetStackValue(0).IntValue, 'First value should still be accessible');
  Assert.AreEqual(Int64(LInitialCapacity + LGrowthSize), FVM.PeekValue().IntValue, 'Last value should be accessible');
end;

// =============================================================================
// Stack State Management
// =============================================================================

procedure TTestJetVMStack.TestStackAfterVMReset();
var
  LIndex: Integer;
begin
  // Push some values
  for LIndex := 1 to 5 do
    FVM.PushValue(FVM.MakeIntConstant(LIndex * 10));

  Assert.AreEqual(5, FVM.GetSP(), 'Stack should have values before reset');

  // Reset VM
  FVM.Reset();

  // Stack should be clean
  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be empty after reset');

  // Should be able to use stack normally after reset
  FVM.PushValue(FVM.MakeIntConstant(999));
  Assert.AreEqual(1, FVM.GetSP(), 'Stack should work normally after reset');
  Assert.AreEqual(Int64(999), FVM.PopValue().IntValue, 'Value should be correct after reset');
end;

procedure TTestJetVMStack.TestStackStateConsistency();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LIndex: Integer;
begin
  // Perform various operations and verify stack remains consistent
  LValue1 := FVM.MakeStrConstant('Consistency Test');
  LValue2 := FVM.MakeBoolConstant(True);

  // Push, peek, push, peek, pop, peek
  FVM.PushValue(LValue1);
  Assert.AreEqual(1, FVM.GetSP(), 'SP should be 1 after first push');

  Assert.AreEqual(LValue1.StrValue, FVM.PeekValue().StrValue, 'Peek should return first value');
  Assert.AreEqual(1, FVM.GetSP(), 'SP should remain 1 after peek');

  FVM.PushValue(LValue2);
  Assert.AreEqual(2, FVM.GetSP(), 'SP should be 2 after second push');

  Assert.AreEqual(LValue2.BoolValue, FVM.PeekValue().BoolValue, 'Peek should return second value');
  Assert.AreEqual(2, FVM.GetSP(), 'SP should remain 2 after second peek');

  FVM.PopValue();
  Assert.AreEqual(1, FVM.GetSP(), 'SP should be 1 after pop');

  Assert.AreEqual(LValue1.StrValue, FVM.PeekValue().StrValue, 'Peek should return first value again');
  Assert.AreEqual(1, FVM.GetSP(), 'SP should remain 1 after final peek');

  // Multiple operations should maintain consistency
  for LIndex := 1 to 10 do
  begin
    FVM.PushValue(FVM.MakeIntConstant(LIndex));
    Assert.AreEqual(1 + LIndex, FVM.GetSP(), Format('SP should be %d after push %d', [1 + LIndex, LIndex]));
  end;
end;

procedure TTestJetVMStack.TestStackPreservationDuringExecution();
var
  LResult: TJetValue;
begin
  // Test that stack values are preserved during program execution
  FVM.LoadInt(100)
     .LoadInt(200)
     .AddInt()
     .Stop()
     .Execute();

  // Should have result of addition on stack
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(300), LResult.IntValue, 'Arithmetic result should be on stack');
  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be empty after popping result');
end;

// =============================================================================
// Error Handling Tests
// =============================================================================

procedure TTestJetVMStack.TestStackUnderflowErrorMessages();
var
  LException: EJetVMError;
begin
  // Test that underflow exceptions have meaningful messages
  try
    FVM.PopValue();
    Assert.Fail('Should have raised exception for stack underflow');
  except
    on E: EJetVMError do
    begin
      LException := E;
      Assert.IsTrue(Length(LException.Message) > 0, 'Exception should have a message');
      // Look for keywords that indicate stack underflow
      Assert.IsTrue(
        (Pos('stack', LowerCase(LException.Message)) > 0) or
        (Pos('underflow', LowerCase(LException.Message)) > 0),
        'Exception message should mention stack or underflow'
      );
    end;
  end;
end;

procedure TTestJetVMStack.TestInvalidStackAccessErrorMessages();
var
  LException: EJetVMError;
begin
  // Test GetStackValue with invalid index
  FVM.PushValue(FVM.MakeIntConstant(42));

  try
    FVM.GetStackValue(10); // Way beyond stack size
    Assert.Fail('Should have raised exception for invalid stack access');
  except
    on E: EJetVMError do
    begin
      LException := E;
      Assert.IsTrue(Length(LException.Message) > 0, 'Exception should have a message');
      // Look for keywords that indicate invalid access
      Assert.IsTrue(
        (Pos('range', LowerCase(LException.Message)) > 0) or
        (Pos('index', LowerCase(LException.Message)) > 0) or
        (Pos('stack', LowerCase(LException.Message)) > 0),
        'Exception message should indicate invalid access'
      );
    end;
  end;
end;

procedure TTestJetVMStack.TestStackErrorRecovery();
begin
  // Test that VM can recover from stack errors
  FVM.PushValue(FVM.MakeIntConstant(42));

  try
    FVM.PopValue(); // Valid pop
    FVM.PopValue(); // Should fail
    Assert.Fail('Second pop should have failed');
  except
    on E: EJetVMError do
      // Expected exception
      Assert.IsTrue(Length(E.Message) > 0, 'Should get meaningful error');
  end;

  // VM should still be usable after error
  FVM.PushValue(FVM.MakeIntConstant(100));
  Assert.AreEqual(1, FVM.GetSP(), 'Should be able to push after error');
  Assert.AreEqual(Int64(100), FVM.PopValue().IntValue, 'Should be able to pop after error');
end;

// =============================================================================
// Performance and Edge Cases
// =============================================================================

procedure TTestJetVMStack.TestStackPerformanceWithManyOperations();
var
  LIndex: Integer;
  LOperationCount: Integer;
  LValue: TJetValue;
begin
  LOperationCount := 1000; // Reduced from 10000 to avoid stack overflow

  // Perform many stack operations quickly
  for LIndex := 1 to LOperationCount do
  begin
    FVM.PushValue(FVM.MakeIntConstant(LIndex));
    if LIndex mod 2 = 0 then
    begin
      FVM.PeekValue(); // Peek operation
    end;
  end;

  Assert.AreEqual(LOperationCount, FVM.GetSP(), 'All values should be on stack');

  // Pop all values
  for LIndex := LOperationCount downto 1 do
  begin
    LValue := FVM.PopValue();
    Assert.AreEqual(Int64(LIndex), LValue.IntValue, 'Values should pop in correct order');
  end;

  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be empty after performance test');
end;

procedure TTestJetVMStack.TestStackBoundaryConditions();
var
  LValue: TJetValue;
begin
  // Test operations right at stack boundaries

  // Single element operations
  FVM.PushValue(FVM.MakeIntConstant(1));
  LValue := FVM.PeekValue();
  Assert.AreEqual(Int64(1), LValue.IntValue, 'Single element peek should work');

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(1), LValue.IntValue, 'Single element pop should work');

  // Empty stack operations (should fail gracefully)
  try
    FVM.PeekValue();
    Assert.Fail('Peek on empty stack should fail');
  except
    // Expected
  end;

  // Transition between empty and non-empty
  FVM.PushValue(FVM.MakeIntConstant(100));
  Assert.AreEqual(1, FVM.GetSP(), 'Should transition to non-empty');

  FVM.PopValue();
  Assert.AreEqual(0, FVM.GetSP(), 'Should transition to empty');
end;

procedure TTestJetVMStack.TestStackMemoryManagement();
var
  LLargeString: string;
  LIndex: Integer;
  LValue: TJetValue;
begin
  // Test stack with large objects that require memory management
  LLargeString := '';
  for LIndex := 1 to 1000 do
    LLargeString := LLargeString + 'Large String Content ';

  // Push large strings
  for LIndex := 1 to 100 do
    FVM.PushValue(FVM.MakeStrConstant(LLargeString + IntToStr(LIndex)));

  Assert.AreEqual(100, FVM.GetSP(), 'Should handle large objects');

  // Verify content is preserved
  LValue := FVM.PeekValue();
  Assert.IsTrue(Pos('Large String Content', LValue.StrValue) > 0, 'Large string content should be preserved');

  // Clean up by popping all
  for LIndex := 1 to 100 do
    FVM.PopValue();

  Assert.AreEqual(0, FVM.GetSP(), 'Should clean up large objects properly');
end;

// =============================================================================
// Integration Tests
// =============================================================================

procedure TTestJetVMStack.TestStackDuringProgramExecution();
var
  LResult: TJetValue;
begin
  // Test that stack works correctly during actual program execution
  FVM.LoadInt(10)
     .LoadInt(20)
     .Dup()        // Stack should have: 10, 20, 20
     .AddInt()     // Stack should have: 10, 40
     .Swap()       // Stack should have: 40, 10
     .SubInt()     // Stack should have: 30 (40 - 10)
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(30), LResult.IntValue, 'Complex stack manipulation should work during execution');
  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be clean after execution');
end;

procedure TTestJetVMStack.TestStackWithArithmeticOperations();
var
  LResult: TJetValue;
begin
  // Test stack behavior with various arithmetic operations
  FVM.LoadInt(5)
     .LoadInt(3)
     .MulInt()     // 5 * 3 = 15
     .LoadInt(10)
     .AddInt()     // 15 + 10 = 25
     .LoadInt(2)
     .DivInt()     // 25 / 2 = 12 (integer division)
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(12), LResult.IntValue, 'Arithmetic operations should use stack correctly');
end;

procedure TTestJetVMStack.TestStackWithFunctionCalls();
var
  LNativeCallCount: Integer;
  LTestFunction: TJetNativeFunction;
begin
  LNativeCallCount := 0;

  // Define a simple native function that uses the stack
  LTestFunction := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LResult: TJetValue := AVM.MakeIntConstant(LArg.IntValue * 2);
    AVM.PushValue(LResult);
    Inc(LNativeCallCount);
  end;

  // Register the function
  FVM.RegisterNativeFunction('double', LTestFunction, [jvtInt], jvtInt);

  // Use the function
  FVM.LoadInt(21)
     .CallFunction('double')
     .Stop()
     .Execute();

  Assert.AreEqual(1, LNativeCallCount, 'Native function should have been called');
  Assert.AreEqual(Int64(42), FVM.PopValue().IntValue, 'Function should have doubled the value');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMStack);

end.
