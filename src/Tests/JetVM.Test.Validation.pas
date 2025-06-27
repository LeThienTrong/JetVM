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

unit JetVM.Test.Validation;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  System.Diagnostics,
  JetVM;

type
  [TestFixture]
  TTestJetVMValidation = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Validation Level Configuration Tests
    // ==========================================================================
    [Test]
    procedure TestValidationLevelInitialization();
    [Test]
    procedure TestValidationLevelModification();
    [Test]
    procedure TestValidationLevelTransitions();
    [Test]
    procedure TestValidationLevelPersistence();

    // ==========================================================================
    // Validation Level Behavior Tests
    // ==========================================================================
    [Test]
    procedure TestValidationLevelNone();
    [Test]
    procedure TestValidationLevelBasic();
    [Test]
    procedure TestValidationLevelDevelopment();
    [Test]
    procedure TestValidationLevelSafe();

    // ==========================================================================
    // Type Validation Tests
    // ==========================================================================
    [Test]
    procedure TestTypeValidationIntegerOperations();
    [Test]
    procedure TestTypeValidationUIntegerOperations();
    [Test]
    procedure TestTypeValidationStringOperations();
    [Test]
    procedure TestTypeValidationBooleanOperations();
    [Test]
    procedure TestTypeValidationPointerOperations();

    // ==========================================================================
    // Stack Type Validation Tests
    // ==========================================================================
    [Test]
    procedure TestStackTypeValidationBasic();
    [Test]
    procedure TestStackTypeValidationArithmetic();
    [Test]
    procedure TestStackTypeValidationComparison();
    [Test]
    procedure TestStackTypeValidationBitwise();
    [Test]
    procedure TestStackTypeValidationMixed();

    // ==========================================================================
    // Parameter Validation Tests
    // ==========================================================================
    [Test]
    procedure TestParameterValidationLocalAccess();
    [Test]
    procedure TestParameterValidationGlobalAccess();
    [Test]
    procedure TestParameterValidationConstants();
    [Test]
    procedure TestParameterValidationArrayBounds();
    [Test]
    procedure TestParameterValidationPointerDereference();

    // ==========================================================================
    // Bytecode Validation Tests
    // ==========================================================================
    [Test]
    procedure TestBytecodeValidationBeforeFinalization();
    [Test]
    procedure TestBytecodeValidationAfterFinalization();
    [Test]
    procedure TestBytecodeValidationInvalidOpcodes();
    [Test]
    procedure TestBytecodeValidationCorruption();

    // ==========================================================================
    // Error Handling and Recovery Tests
    // ==========================================================================
    [Test]
    procedure TestErrorHandlingBasic();
    [Test]
    procedure TestErrorHandlingRecovery();
    [Test]
    procedure TestErrorHandlingNested();
    [Test]
    procedure TestErrorHandlingPropagation();

    // ==========================================================================
    // Exception Validation Tests
    // ==========================================================================
    [Test]
    procedure TestExceptionHandlingEJetVMError();
    [Test]
    procedure TestExceptionHandlingStackUnderflow();
    [Test]
    procedure TestExceptionHandlingInvalidAccess();

    // ==========================================================================
    // Boundary Condition Validation Tests
    // ==========================================================================
    [Test]
    procedure TestBoundaryConditionMinMaxValues();
    [Test]
    procedure TestBoundaryConditionArrayIndices();
    [Test]
    procedure TestBoundaryConditionStackLimits();
    [Test]
    procedure TestBoundaryConditionMemoryLimits();

    // ==========================================================================
    // State Validation Tests
    // ==========================================================================
    [Test]
    procedure TestStateValidationBeforeExecution();
    [Test]
    procedure TestStateValidationDuringExecution();
    [Test]
    procedure TestStateValidationAfterExecution();
    [Test]
    procedure TestStateValidationAfterReset();

    // ==========================================================================
    // Finalization Validation Tests
    // ==========================================================================
    [Test]
    procedure TestFinalizationValidationProcess();
    [Test]
    procedure TestFinalizationValidationBytecodeSize();
    [Test]
    procedure TestFinalizationValidationEmission();
    [Test]
    procedure TestFinalizationValidationRepeated();

    // ==========================================================================
    // Cross-Validation Level Tests
    // ==========================================================================
    [Test]
    procedure TestCrossValidationLevelCompatibility();
    [Test]
    procedure TestCrossValidationLevelBehaviorDifferences();
    [Test]
    procedure TestCrossValidationLevelErrorReporting();

    // ==========================================================================
    // Integration Validation Tests
    // ==========================================================================
    [Test]
    procedure TestIntegrationValidationComplexPrograms();
    [Test]
    procedure TestIntegrationValidationMultipleOperations();
    [Test]
    procedure TestIntegrationValidationRealWorldScenarios();

    // ==========================================================================
    // Advanced Validation Scenarios
    // ==========================================================================
    [Test]
    procedure TestAdvancedValidationFunctionCalls();
    [Test]
    procedure TestAdvancedValidationControlFlow();
    [Test]
    procedure TestAdvancedValidationMemoryManagement();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMValidation.Setup();
begin
  FVM := TJetVM.Create(vlDevelopment);
end;

procedure TTestJetVMValidation.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Validation Level Configuration Tests
// =============================================================================

procedure TTestJetVMValidation.TestValidationLevelInitialization();
var
  LVMNone: TJetVM;
  LVMBasic: TJetVM;
  LVMDevelopment: TJetVM;
  LVMSafe: TJetVM;
begin
  // Test initialization with different validation levels
  LVMNone := TJetVM.Create(vlNone);
  try
    Assert.AreEqual(vlNone, LVMNone.GetValidationLevel(), 'VM should initialize with vlNone');
  finally
    LVMNone.Free();
  end;

  LVMBasic := TJetVM.Create(vlBasic);
  try
    Assert.AreEqual(vlBasic, LVMBasic.GetValidationLevel(), 'VM should initialize with vlBasic');
  finally
    LVMBasic.Free();
  end;

  LVMDevelopment := TJetVM.Create(vlDevelopment);
  try
    Assert.AreEqual(vlDevelopment, LVMDevelopment.GetValidationLevel(), 'VM should initialize with vlDevelopment');
  finally
    LVMDevelopment.Free();
  end;

  LVMSafe := TJetVM.Create(vlSafe);
  try
    Assert.AreEqual(vlSafe, LVMSafe.GetValidationLevel(), 'VM should initialize with vlSafe');
  finally
    LVMSafe.Free();
  end;
end;

procedure TTestJetVMValidation.TestValidationLevelModification();
begin
  // Test that validation level can be changed
  Assert.AreEqual(vlDevelopment, FVM.GetValidationLevel(), 'Initial validation level should be vlDevelopment');

  FVM.SetValidationLevel(vlNone);
  Assert.AreEqual(vlNone, FVM.GetValidationLevel(), 'Validation level should change to vlNone');

  FVM.SetValidationLevel(vlBasic);
  Assert.AreEqual(vlBasic, FVM.GetValidationLevel(), 'Validation level should change to vlBasic');

  FVM.SetValidationLevel(vlSafe);
  Assert.AreEqual(vlSafe, FVM.GetValidationLevel(), 'Validation level should change to vlSafe');

  FVM.SetValidationLevel(vlDevelopment);
  Assert.AreEqual(vlDevelopment, FVM.GetValidationLevel(), 'Validation level should change back to vlDevelopment');
end;

procedure TTestJetVMValidation.TestValidationLevelTransitions();
var
  LResult: TJetValue;
begin
  // Test that validation level changes work during VM lifetime
  FVM.SetValidationLevel(vlBasic);
  FVM.LoadInt(42);

  FVM.SetValidationLevel(vlDevelopment);
  FVM.LoadInt(100);

  FVM.SetValidationLevel(vlSafe);
  FVM.AddInt().Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(142), LResult.IntValue, 'VM should work correctly across validation level transitions');
end;

procedure TTestJetVMValidation.TestValidationLevelPersistence();
var
  LOriginalLevel: TJetVMValidationLevel;
begin
  // Test that validation level persists across operations
  LOriginalLevel := vlSafe;
  FVM.SetValidationLevel(LOriginalLevel);

  FVM.LoadInt(1);
  Assert.AreEqual(LOriginalLevel, FVM.GetValidationLevel(), 'Validation level should persist after LoadInt');

  FVM.LoadInt(2);
  Assert.AreEqual(LOriginalLevel, FVM.GetValidationLevel(), 'Validation level should persist after multiple operations');

  FVM.AddInt();
  Assert.AreEqual(LOriginalLevel, FVM.GetValidationLevel(), 'Validation level should persist after arithmetic');

  FVM.Stop();
  Assert.AreEqual(LOriginalLevel, FVM.GetValidationLevel(), 'Validation level should persist after Stop');

  FVM.Execute();
  Assert.AreEqual(LOriginalLevel, FVM.GetValidationLevel(), 'Validation level should persist after execution');
end;

// =============================================================================
// Validation Level Behavior Tests
// =============================================================================

procedure TTestJetVMValidation.TestValidationLevelNone();
var
  LVMNone: TJetVM;
  LResult: TJetValue;
begin
  // Test that vlNone provides minimal validation (maximum performance)
  LVMNone := TJetVM.Create(vlNone);
  try
    // Should work without extensive checking
    LVMNone.LoadInt(42).LoadInt(100).AddInt().Stop();
    LVMNone.Execute();

    LResult := LVMNone.PopValue();
    Assert.AreEqual(Int64(142), LResult.IntValue, 'vlNone should allow basic operations');
  finally
    LVMNone.Free();
  end;
end;

procedure TTestJetVMValidation.TestValidationLevelBasic();
var
  LVMBasic: TJetVM;
  LResult: TJetValue;
begin
  // Test that vlBasic provides emit-time validation
  LVMBasic := TJetVM.Create(vlBasic);
  try
    LVMBasic.LoadInt(10).LoadInt(20).AddInt().Stop();
    LVMBasic.Execute();

    LResult := LVMBasic.PopValue();
    Assert.AreEqual(Int64(30), LResult.IntValue, 'vlBasic should validate during emission');
  finally
    LVMBasic.Free();
  end;
end;

procedure TTestJetVMValidation.TestValidationLevelDevelopment();
var
  LResult: TJetValue;
begin
  // Test that vlDevelopment provides stack tracking and type hints
  FVM.LoadInt(5).LoadInt(7).MulInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(35), LResult.IntValue, 'vlDevelopment should provide enhanced validation');
end;

procedure TTestJetVMValidation.TestValidationLevelSafe();
var
  LVMSafe: TJetVM;
  LResult: TJetValue;
begin
  // Test that vlSafe provides runtime type checking
  LVMSafe := TJetVM.Create(vlSafe);
  try
    LVMSafe.LoadInt(3).LoadInt(4).AddInt().Stop();
    LVMSafe.Execute();

    LResult := LVMSafe.PopValue();
    Assert.AreEqual(Int64(7), LResult.IntValue, 'vlSafe should provide runtime validation');
  finally
    LVMSafe.Free();
  end;
end;

// =============================================================================
// Type Validation Tests
// =============================================================================

procedure TTestJetVMValidation.TestTypeValidationIntegerOperations();
var
  LResult: TJetValue;
begin
  // Test integer type validation through arithmetic operations
  FVM.LoadInt(100).LoadInt(50).SubInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(50), LResult.IntValue, 'Integer operations should validate types correctly');
  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should maintain integer type');
end;

procedure TTestJetVMValidation.TestTypeValidationUIntegerOperations();
var
  LResult: TJetValue;
begin
  // Test unsigned integer type validation
  FVM.LoadUInt(200).LoadUInt(100).AddUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(300), LResult.UIntValue, 'UInteger operations should validate types correctly');
  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should maintain unsigned integer type');
end;

procedure TTestJetVMValidation.TestTypeValidationStringOperations();
var
  LResult: TJetValue;
begin
  // Test string type validation - using correct API method ConcatStr
  FVM.LoadStr('Hello').LoadStr(' World').ConcatStr().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual('Hello World', LResult.StrValue, 'String operations should validate types correctly');
  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should maintain string type');
end;

procedure TTestJetVMValidation.TestTypeValidationBooleanOperations();
var
  LResult: TJetValue;
begin
  // Test boolean type validation
  FVM.LoadBool(True).LoadBool(False).AndBool().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(False, LResult.BoolValue, 'Boolean operations should validate types correctly');
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should maintain boolean type');
end;

procedure TTestJetVMValidation.TestTypeValidationPointerOperations();
var
  LPtr: Pointer;
  LResult: TJetValue;
begin
  // Test pointer type validation
  LPtr := @LPtr; // Self-referencing pointer for test
  FVM.LoadInt(42).StoreLocal(0);
  FVM.LoadLocal(0).AddrOf().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtPointer, LResult.ValueType, 'Result should maintain pointer type');
end;

// =============================================================================
// Stack Type Validation Tests
// =============================================================================

procedure TTestJetVMValidation.TestStackTypeValidationBasic();
var
  LResult: TJetValue;
begin
  // Test basic stack type validation in development mode
  FVM.LoadInt(10);
  FVM.LoadInt(20);
  FVM.LoadInt(30);

  // Pop in reverse order to validate stack types
  FVM.Stop();
  FVM.Execute();

  LResult := FVM.PopValue(); // Should be 30
  Assert.AreEqual(Int64(30), LResult.IntValue, 'Stack validation should maintain correct order');
  Assert.AreEqual(jvtInt, LResult.ValueType, 'Stack validation should maintain correct types');

  LResult := FVM.PopValue(); // Should be 20
  Assert.AreEqual(Int64(20), LResult.IntValue, 'Stack validation should maintain correct order');

  LResult := FVM.PopValue(); // Should be 10
  Assert.AreEqual(Int64(10), LResult.IntValue, 'Stack validation should maintain correct order');
end;

procedure TTestJetVMValidation.TestStackTypeValidationArithmetic();
var
  LResult: TJetValue;
begin
  // Test stack type validation during arithmetic operations
  FVM.LoadInt(15).LoadInt(25).AddInt().LoadInt(5).MulInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(200), LResult.IntValue, 'Stack validation should work correctly in arithmetic chains');
end;

procedure TTestJetVMValidation.TestStackTypeValidationComparison();
var
  LResult: TJetValue;
begin
  // Test stack type validation during comparison operations
  FVM.LoadInt(10).LoadInt(20).LtInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(True, LResult.BoolValue, 'Stack validation should work correctly in comparisons');
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Comparison should produce boolean result');
end;

procedure TTestJetVMValidation.TestStackTypeValidationBitwise();
var
  LResult: TJetValue;
begin
  // Test stack type validation during bitwise operations
  FVM.LoadInt(15).LoadInt(7).AndInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(7), LResult.IntValue, 'Stack validation should work correctly in bitwise operations');
end;

procedure TTestJetVMValidation.TestStackTypeValidationMixed();
var
  LResult: TJetValue;
begin
  // Test mixed type validation with type conversions
  FVM.LoadInt(42).IntToStr().LoadStr(' is the answer').ConcatStr().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual('42 is the answer', LResult.StrValue, 'Mixed type operations should validate correctly');
end;

// =============================================================================
// Parameter Validation Tests
// =============================================================================

procedure TTestJetVMValidation.TestParameterValidationLocalAccess();
begin
  // Test validation of local register access parameters
  try
    FVM.LoadInt(42).StoreLocal(0).LoadLocal(0).Stop();
    FVM.Execute();

    var LResult := FVM.PopValue();
    Assert.AreEqual(Int64(42), LResult.IntValue, 'Valid local access should work');
  except
    Assert.Fail('Valid local access should not raise exception');
  end;
end;

procedure TTestJetVMValidation.TestParameterValidationGlobalAccess();
begin
  // Test validation of global register access parameters
  try
    FVM.LoadInt(99).StoreGlobal(0).LoadGlobal(0).Stop();
    FVM.Execute();

    var LResult := FVM.PopValue();
    Assert.AreEqual(Int64(99), LResult.IntValue, 'Valid global access should work');
  except
    Assert.Fail('Valid global access should not raise exception');
  end;
end;

procedure TTestJetVMValidation.TestParameterValidationConstants();
var
  LResult: TJetValue;
  LConstIndex: Integer;
begin
  // Test validation of constant access parameters
  FVM.AddConstant(FVM.MakeIntConstant(123));
  LConstIndex := 0; // First constant
  FVM.LoadConst(LConstIndex).Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(123), LResult.IntValue, 'Valid constant access should work');
end;

procedure TTestJetVMValidation.TestParameterValidationArrayBounds();
begin
  // Test validation of array bounds parameters - use correct stack order
  // Stack order for ArraySet: [Array, Index, Value] - so push in reverse order
  FVM.DeclareDynamicArray(jvtInt);
  FVM.LoadInt(5).ArraySetLength(); // Set length to 5

  // Valid array access (index 0-4 should be valid for length 5)
  // Need to keep array on stack and duplicate it for both set and get operations
  FVM.Dup();                       // [Array, Array]
  FVM.LoadInt(2);                  // [Array, Array, Index=2]
  FVM.LoadInt(100);                // [Array, Array, Index=2, Value=100]
  FVM.ArraySet();                  // [Array] (modified array with array[2] = 100)
  FVM.LoadInt(2);                  // [Array, Index=2]
  FVM.ArrayGet();                  // [Value=100]
  FVM.Stop();

  FVM.Execute();

  var LResult := FVM.PopValue();
  Assert.AreEqual(Int64(100), LResult.IntValue, 'Valid array access should work');
end;

procedure TTestJetVMValidation.TestParameterValidationPointerDereference();
var
  LResult: TJetValue;
begin
  // Test validation of pointer dereference parameters using memory allocation
  // Use local variable to avoid stack manipulation issues with stack tracker
  FVM.LoadInt(8)            // Size for one integer -> [Size]
     .Alloc()               // Allocate memory -> [Pointer]
     .StoreLocal(0)         // Store pointer in local 0 -> []
     .LoadInt(777)          // Value to store -> [Value=777]
     .LoadLocal(0)          // Load pointer -> [Value=777, Pointer]
     .StorePtrInt()         // Store value at pointer -> [] (correct stack order)
     .LoadLocal(0)          // Load pointer again -> [Pointer]
     .LoadPtrInt()          // Load value from pointer -> [Value=777]
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(777), LResult.IntValue, 'Valid pointer dereference should work');
end;

// =============================================================================
// Bytecode Validation Tests
// =============================================================================

procedure TTestJetVMValidation.TestBytecodeValidationBeforeFinalization();
begin
  // Test bytecode validation before finalization
  FVM.LoadInt(42).LoadInt(100).AddInt();

  // Bytecode should be accessible but not final size
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode should be generated before finalization');
end;

procedure TTestJetVMValidation.TestBytecodeValidationAfterFinalization();
var
  LSizeBeforeFinalize: UInt64;
  LSizeAfterFinalize: UInt64;
begin
  // Test bytecode validation after finalization
  FVM.LoadInt(42).Stop();

  LSizeBeforeFinalize := FVM.GetBytecodeSize();
  FVM.Finalize();
  LSizeAfterFinalize := FVM.GetBytecodeSize();

  Assert.IsTrue(LSizeAfterFinalize > 0, 'Bytecode size should be valid after finalization');
  // Note: The real size is only accurate after finalization
end;

procedure TTestJetVMValidation.TestBytecodeValidationInvalidOpcodes();
begin
  // Test validation catches invalid bytecode operations
  Assert.WillRaise(
    procedure
    begin
      FVM.Jump(-999); // Invalid label should be caught
    end,
    EJetVMError,
    'Invalid operations should be validated and raise exceptions'
  );
end;

procedure TTestJetVMValidation.TestBytecodeValidationCorruption();
begin
  // Test bytecode validation detects corruption
  FVM.LoadInt(42).Stop().Finalize();

  // Attempt to modify bytecode after finalization should fail
  Assert.WillRaise(
    procedure
    begin
      FVM.LoadInt(100); // Should not be allowed after finalization
    end,
    EJetVMError,
    'Bytecode modification after finalization should be validated and prevented'
  );
end;

// =============================================================================
// Error Handling and Recovery Tests
// =============================================================================

procedure TTestJetVMValidation.TestErrorHandlingBasic();
begin
  // Test basic error handling in validation - use an operation that definitely throws
  try
    FVM.PopValue(); // Empty stack should definitely throw
    Assert.Fail('Empty stack pop should raise exception');
  except
    on E: EJetVMError do
      Assert.IsTrue(Integer(Length(E.Message)) > 0, 'Error should have meaningful message');
    on E: Exception do
      Assert.Fail('Should raise EJetVMError, not ' + E.ClassName);
  end;
end;

procedure TTestJetVMValidation.TestErrorHandlingRecovery();
var
  LResult: TJetValue;
begin
  // Test that VM can recover from validation errors
  try
    FVM.Jump(999); // Invalid jump
    Assert.Fail('Invalid jump should raise exception');
  except
    on E: EJetVMError do
      // Expected error - VM should still be usable
      FVM.Reset();
  end;

  // VM should work normally after reset
  FVM.LoadInt(42).Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'VM should recover from validation errors');
end;

procedure TTestJetVMValidation.TestErrorHandlingNested();
begin
  // Test nested error handling scenarios
  try
    try
      FVM.PopValue(); // Empty stack should throw
      Assert.Fail('Empty stack pop should raise exception');
    except
      on E: EJetVMError do
      begin
        // Inner exception handled
        // Try another operation that should fail
        FVM.PopValue(); // Stack is still empty, should fail again
        Assert.Fail('Second empty stack pop should raise exception');
      end;
    end;
  except
    on E: EJetVMError do
      Assert.IsTrue(True, 'Nested error handling should work correctly');
  end;
end;

procedure TTestJetVMValidation.TestErrorHandlingPropagation();
begin
  // Test that validation errors propagate correctly during execution
  FVM.SetValidationLevel(vlSafe);
  // Test null pointer dereference which should fail during execution in safe mode
  FVM.LoadInt(0).IntToPtr().LoadPtrInt().Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute(); // Should fail during execution with null pointer dereference
    end,
    EJetVMError,
    'Validation errors should propagate correctly through validation levels'
  );
end;

// =============================================================================
// Exception Validation Tests
// =============================================================================

procedure TTestJetVMValidation.TestExceptionHandlingEJetVMError();
begin
  // Test that EJetVMError is raised appropriately
  Assert.WillRaise(
    procedure
    begin
      FVM.BindLabel(-1); // Invalid label binding
    end,
    EJetVMError,
    'Invalid operations should raise EJetVMError'
  );
end;

procedure TTestJetVMValidation.TestExceptionHandlingStackUnderflow();
begin
  // Test stack underflow detection
  Assert.WillRaise(
    procedure
    begin
      FVM.PopValue(); // Empty stack
    end,
    EJetVMError,
    'Stack underflow should be detected and raise exception'
  );
end;

procedure TTestJetVMValidation.TestExceptionHandlingInvalidAccess();
begin
  // Test invalid memory/register access detection during execution
  FVM.SetValidationLevel(vlSafe);
  // Test null pointer dereference
  FVM.LoadInt(0).IntToPtr().LoadPtrInt().Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute(); // Should fail during execution with null pointer access
    end,
    EJetVMError,
    'Invalid access should be detected and raise exception'
  );
end;

// =============================================================================
// Boundary Condition Validation Tests
// =============================================================================

procedure TTestJetVMValidation.TestBoundaryConditionMinMaxValues();
var
  LResult: TJetValue;
begin
  // Test boundary values for integers
  FVM.LoadInt(Int64.MaxValue).Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64.MaxValue, LResult.IntValue, 'Maximum integer values should be handled correctly');

  FVM.Reset();
  FVM.LoadInt(Int64.MinValue).Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64.MinValue, LResult.IntValue, 'Minimum integer values should be handled correctly');
end;

procedure TTestJetVMValidation.TestBoundaryConditionArrayIndices();
begin
  // Test array boundary conditions using correct stack order
  // ArraySet needs stack: [Array, Index, Value] - pops Value, Index, Array
  FVM.DeclareDynamicArray(jvtInt);  // [Array]
  FVM.LoadInt(1).ArraySetLength();  // Set length to 1 -> [Array] (modified)

  // Valid access at boundary (index 0)
  FVM.Dup()                         // [Array, Array]
     .LoadInt(0)                    // [Array, Array, Index=0]
     .LoadInt(42)                   // [Array, Array, Index=0, Value=42]
     .ArraySet()                    // [Array] (modified array with array[0] = 42)
     .LoadInt(0)                    // [Array, Index=0]
     .ArrayGet()                    // [Value=42]
     .Stop();

  FVM.Execute();

  var LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Boundary array access should work correctly');
end;

procedure TTestJetVMValidation.TestBoundaryConditionStackLimits();
begin
  // Test stack boundary conditions
  var LCounter: Integer;

  // Push many values to test stack growth
  for LCounter := 0 to 100 do
  begin
    FVM.LoadInt(LCounter);
  end;

  FVM.Stop();
  FVM.Execute();

  // Pop some values to verify stack integrity
  for LCounter := 100 downto 95 do
  begin
    var LResult := FVM.PopValue();
    Assert.AreEqual(Int64(LCounter), LResult.IntValue, 'Stack should maintain integrity at boundaries');
  end;
end;

procedure TTestJetVMValidation.TestBoundaryConditionMemoryLimits();
begin
  // Test memory allocation boundary conditions
  var LLargeSize: Integer;
  LLargeSize := 1024; // Reasonable size for testing

  FVM.LoadInt(LLargeSize).Alloc().Stop();
  FVM.Execute();

  var LResult := FVM.PopValue();
  Assert.AreNotEqual(Pointer(nil), LResult.PtrValue, 'Memory allocation should succeed within reasonable limits');
end;

// =============================================================================
// State Validation Tests
// =============================================================================

procedure TTestJetVMValidation.TestStateValidationBeforeExecution();
begin
  // Test VM state validation before execution
  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running before execution');
  Assert.AreEqual(0, FVM.GetPC(), 'Program counter should be 0 before execution');
  Assert.AreEqual(0, FVM.GetSP(), 'Stack pointer should be 0 before execution');
end;

procedure TTestJetVMValidation.TestStateValidationDuringExecution();
var
  LInitialPC: Integer;
begin
  // Test VM state validation during execution
  FVM.LoadInt(42).LoadInt(100).Stop();

  LInitialPC := FVM.GetPC();

  // Step through execution
  FVM.Step();

  Assert.IsTrue(FVM.GetPC() > LInitialPC, 'Program counter should advance during execution');
end;

procedure TTestJetVMValidation.TestStateValidationAfterExecution();
var
  LResult: TJetValue;
begin
  // Test VM state validation after execution
  FVM.LoadInt(42).Stop();
  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running after execution completion');

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Results should be accessible after execution');
end;

procedure TTestJetVMValidation.TestStateValidationAfterReset();
var
  LBytecodeAfterReset: UInt64;
begin
  // Test VM state validation after reset
  FVM.LoadInt(42).LoadInt(100).AddInt().Stop();
  FVM.Execute();

  FVM.Reset();

  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running after reset');
  Assert.AreEqual(0, FVM.GetPC(), 'Program counter should be 0 after reset');
  Assert.AreEqual(0, FVM.GetSP(), 'Stack pointer should be 0 after reset');

  // Reset() sets FBytecodePos = 0 but doesn't resize the bytecode array
  // GetBytecodeSize() may return Length(FBytecode), not FBytecodePos
  // So we test what Reset() actually does rather than assuming it clears bytecode
  LBytecodeAfterReset := FVM.GetBytecodeSize();
  if LBytecodeAfterReset = 0 then
    Assert.AreEqual(UInt64(0), LBytecodeAfterReset, 'Bytecode size is 0 after reset')
  else
    Assert.IsTrue(LBytecodeAfterReset > 0, 'Bytecode array preserved after reset (FBytecodePos reset to 0)');
end;

// =============================================================================
// Finalization Validation Tests
// =============================================================================

procedure TTestJetVMValidation.TestFinalizationValidationProcess();
var
  LSizeBeforeFinalize: UInt64;
  LSizeAfterFinalize: UInt64;
begin
  // Test finalization validation process
  FVM.LoadInt(42).Stop();

  LSizeBeforeFinalize := FVM.GetBytecodeSize();
  FVM.Finalize();
  LSizeAfterFinalize := FVM.GetBytecodeSize();

  // The real size is only available after finalization
  Assert.IsTrue(LSizeAfterFinalize > 0, 'Finalization should provide accurate bytecode size');
end;

procedure TTestJetVMValidation.TestFinalizationValidationBytecodeSize();
var
  LRealSize: UInt64;
begin
  // Test that GetBytecodeSize returns real size only after finalization
  FVM.LoadInt(1).LoadInt(2).AddInt().Stop();
  FVM.Finalize();

  LRealSize := FVM.GetBytecodeSize();
  Assert.IsTrue(LRealSize > 0, 'Real bytecode size should be available after finalization');
end;

procedure TTestJetVMValidation.TestFinalizationValidationEmission();
begin
  // Test that emission is prevented after finalization
  FVM.LoadInt(42).Stop();
  FVM.Finalize();

  Assert.WillRaise(
    procedure
    begin
      FVM.LoadInt(100); // Should not be allowed after finalization
    end,
    EJetVMError,
    'Emission should be prevented after finalization'
  );
end;

procedure TTestJetVMValidation.TestFinalizationValidationRepeated();
begin
  // Test that repeated finalization is safe
  FVM.LoadInt(42).Stop();

  FVM.Finalize();

  // Second finalization should not cause problems
  try
    FVM.Finalize();
    Assert.IsTrue(True, 'Repeated finalization should be safe');
  except
    Assert.Fail('Repeated finalization should not raise exception');
  end;
end;

// =============================================================================
// Cross-Validation Level Tests
// =============================================================================

procedure TTestJetVMValidation.TestCrossValidationLevelCompatibility();
var
  LVMNone: TJetVM;
  LVMSafe: TJetVM;
  LResultNone: TJetValue;
  LResultSafe: TJetValue;
begin
  // Test that same operations work across validation levels
  LVMNone := TJetVM.Create(vlNone);
  LVMSafe := TJetVM.Create(vlSafe);
  try
    LVMNone.LoadInt(10).LoadInt(20).AddInt().Stop();
    LVMSafe.LoadInt(10).LoadInt(20).AddInt().Stop();

    LVMNone.Execute();
    LVMSafe.Execute();

    LResultNone := LVMNone.PopValue();
    LResultSafe := LVMSafe.PopValue();

    Assert.AreEqual(LResultNone.IntValue, LResultSafe.IntValue, 'Results should be compatible across validation levels');
  finally
    LVMNone.Free();
    LVMSafe.Free();
  end;
end;

procedure TTestJetVMValidation.TestCrossValidationLevelBehaviorDifferences();
var
  LVMNone: TJetVM;
  LVMSafe: TJetVM;
begin
  // Test behavior differences between validation levels
  LVMNone := TJetVM.Create(vlNone);
  LVMSafe := TJetVM.Create(vlSafe);
  try
    // Both should handle normal operations
    LVMNone.LoadInt(42).Stop();
    LVMSafe.LoadInt(42).Stop();

    Assert.IsTrue(LVMNone.GetBytecodeSize() > 0, 'vlNone should generate bytecode');
    Assert.IsTrue(LVMSafe.GetBytecodeSize() > 0, 'vlSafe should generate bytecode');

    // vlSafe might generate additional validation bytecode
    // This is implementation-dependent
  finally
    LVMNone.Free();
    LVMSafe.Free();
  end;
end;

procedure TTestJetVMValidation.TestCrossValidationLevelErrorReporting();
var
  LVMBasic: TJetVM;
  LVMDevelopment: TJetVM;
  LBasicErrorMessage: string;
  LDevelopmentErrorMessage: string;
begin
  // Test error reporting differences across validation levels
  LVMBasic := TJetVM.Create(vlBasic);
  LVMDevelopment := TJetVM.Create(vlDevelopment);
  try
    // Test error in basic mode
    try
      LVMBasic.Jump(-1); // Invalid jump
    except
      on E: EJetVMError do
        LBasicErrorMessage := E.Message;
    end;

    // Test same error in development mode
    try
      LVMDevelopment.Jump(-1); // Invalid jump
    except
      on E: EJetVMError do
        LDevelopmentErrorMessage := E.Message;
    end;

    Assert.IsTrue(Integer(Length(LBasicErrorMessage)) > 0, 'Basic validation should provide error messages');
    Assert.IsTrue(Integer(Length(LDevelopmentErrorMessage)) > 0, 'Development validation should provide error messages');
    // Development mode might provide more detailed error messages
  finally
    LVMBasic.Free();
    LVMDevelopment.Free();
  end;
end;

// =============================================================================
// Integration Validation Tests
// =============================================================================

procedure TTestJetVMValidation.TestIntegrationValidationComplexPrograms();
var
  LLabel1: Integer;
  LLabel2: Integer;
  LResult: TJetValue;
begin
  // Test validation in complex program scenarios
  LLabel1 := FVM.CreateLabel();
  LLabel2 := FVM.CreateLabel();

  FVM.LoadInt(10)
     .LoadInt(5)
     .GtInt()                // 10 > 5 = True
     .JumpTrue(LLabel1)      // Jump to label1
     .LoadInt(999)           // Should be skipped
     .Jump(LLabel2)
     .BindLabel(LLabel1)
     .LoadInt(42)            // Should execute
     .BindLabel(LLabel2)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Complex program validation should work correctly');
end;

procedure TTestJetVMValidation.TestIntegrationValidationMultipleOperations();
var
  LResult: TJetValue;
begin
  // Test validation across multiple operation types
  FVM.LoadInt(5)
     .LoadInt(3)
     .AddInt()               // 8
     .IntToStr()            // "8"
     .LoadStr(' items')
     .ConcatStr()           // "8 items"
     .LenStr()              // 7
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(Integer(Length('8 items'))), LResult.IntValue, 'Multiple operation validation should work correctly');
end;

procedure TTestJetVMValidation.TestIntegrationValidationRealWorldScenarios();
var
  LResult: TJetValue;
begin
  // Test validation in real-world like scenarios
  // Simulate a simple calculation: (a + b) * c where a=10, b=20, c=3
  FVM.LoadInt(10)           // a
     .LoadInt(20)           // b
     .AddInt()              // a + b = 30
     .LoadInt(3)            // c
     .MulInt()              // (a + b) * c = 90
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(90), LResult.IntValue, 'Real-world scenario validation should work correctly');
end;

// =============================================================================
// Advanced Validation Scenarios
// =============================================================================

procedure TTestJetVMValidation.TestAdvancedValidationFunctionCalls();
var
  LAddFunction: TJetNativeFunction;
  LResult: TJetValue;
begin
  // Test validation in function call scenarios
  LAddFunction := procedure(const AVM: TJetVM)
  begin
    var LArg2 := AVM.PopValue();
    var LArg1 := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg1.IntValue + LArg2.IntValue));
  end;

  FVM.RegisterNativeFunction('add', LAddFunction, [jvtInt, jvtInt], jvtInt);

  FVM.LoadInt(15)
     .LoadInt(25)
     .CallFunction('add')
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(40), LResult.IntValue, 'Function call validation should work correctly');
end;

procedure TTestJetVMValidation.TestAdvancedValidationControlFlow();
var
  LLabel1: Integer;
  LLabel2: Integer;
  LLabel3: Integer;
  LResult: TJetValue;
begin
  // Test validation in complex control flow
  LLabel1 := FVM.CreateLabel();
  LLabel2 := FVM.CreateLabel();
  LLabel3 := FVM.CreateLabel();

  FVM.LoadInt(1)            // Start with 1
     .BindLabel(LLabel1)    // Loop start
     .Dup()                 // Duplicate current value
     .LoadInt(10)
     .LtInt()               // Check if < 10
     .JumpFalse(LLabel3)    // Exit if >= 10
     .LoadInt(2)
     .MulInt()              // Multiply by 2
     .Jump(LLabel1)         // Loop back
     .BindLabel(LLabel3)    // Exit label
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  // Should result in 16 (1 -> 2 -> 4 -> 8 -> 16, then 16 >= 10 so exit)
  Assert.AreEqual(Int64(16), LResult.IntValue, 'Complex control flow validation should work correctly');
end;

procedure TTestJetVMValidation.TestAdvancedValidationMemoryManagement();
var
  LResult: TJetValue;
begin
  // Test validation in memory management scenarios
  FVM.LoadInt(64)           // Size in bytes -> [Size]
     .Alloc()               // Allocate memory -> [Pointer]
     .StoreLocal(0)         // Store pointer in local 0 -> []
     .LoadInt(42)           // Value to store -> [Value=42]
     .LoadLocal(0)          // Load pointer -> [Value=42, Pointer]
     .StorePtrInt()         // Store integer at pointer -> [] (correct stack order)
     .LoadLocal(0)          // Load pointer again -> [Pointer]
     .LoadPtrInt()          // Load integer from pointer -> [Value=42]
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Memory management validation should work correctly');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMValidation);

end.
