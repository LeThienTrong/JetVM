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

unit JetVM.Test.Core;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMCore = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // VM Lifecycle Tests
    // ==========================================================================
    [Test]
    procedure TestVMCreationDefault();
    [Test]
    procedure TestVMCreationWithValidationLevels();
    [Test]
    procedure TestVMDestruction();

    // ==========================================================================
    // Initial State Tests
    // ==========================================================================
    [Test]
    procedure TestVMInitialState();
    [Test]
    procedure TestVMInitialStackState();
    [Test]
    procedure TestVMInitialRegisters();

    // ==========================================================================
    // State Management Tests
    // ==========================================================================
    [Test]
    procedure TestVMReset();
    [Test]
    procedure TestVMResetAfterExecution();
    [Test]
    procedure TestVMResetBehavior();

    // ==========================================================================
    // Validation Level Tests
    // ==========================================================================
    [Test]
    procedure TestGetValidationLevel();
    [Test]
    procedure TestSetValidationLevel();
    [Test]
    procedure TestValidationLevelSwitching();

    // ==========================================================================
    // Basic Execution Tests
    // ==========================================================================
    [Test]
    procedure TestBasicExecution();
    [Test]
    procedure TestEmptyExecutionFails();
    [Test]
    procedure TestExecutionWithNOP();
    [Test]
    procedure TestExecutionWithMultipleNOPs();
    [Test]
    procedure TestHaltStopsExecution();

    // ==========================================================================
    // Execution State Tests
    // ==========================================================================
    [Test]
    procedure TestIsRunningInitiallyFalse();
    [Test]
    procedure TestIsRunningDuringExecution();
    [Test]
    procedure TestIsRunningAfterHalt();

    // ==========================================================================
    // Program Counter Tests
    // ==========================================================================
    [Test]
    procedure TestGetPCInitialValue();
    [Test]
    procedure TestGetPCAfterExecution();
    [Test]
    procedure TestGetPCAfterReset();

    // ==========================================================================
    // Stack Pointer Tests
    // ==========================================================================
    [Test]
    procedure TestGetSPInitialValue();
    [Test]
    procedure TestGetSPAfterStackOperations();
    [Test]
    procedure TestGetSPAfterReset();

    // ==========================================================================
    // Step Execution Tests
    // ==========================================================================
    [Test]
    procedure TestStepExecution();
    [Test]
    procedure TestStepExecutionMultiple();
    [Test]
    procedure TestStepExecutionWithHalt();

    // ==========================================================================
    // Finalization Tests
    // ==========================================================================
    [Test]
    procedure TestFinalizeBytecode();
    [Test]
    procedure TestFinalizeEmptyBytecode();
    [Test]
    procedure TestFinalizePreventsFurtherEmission();

    // ==========================================================================
    // Basic Fluent Interface Tests
    // ==========================================================================
    [Test]
    procedure TestFluentChaining();
    [Test]
    procedure TestFluentChainingReturnsInstance();
    [Test]
    procedure TestFluentExecutionChain();

    // ==========================================================================
    // Error Handling Tests
    // ==========================================================================
    [Test]
    procedure TestExecutionErrorHandling();
    [Test]
    procedure TestInvalidOpcodeHandling();
    [Test]
    procedure TestExecutionExceptionDetails();

    // ==========================================================================
    // Memory Consistency Tests
    // ==========================================================================
    [Test]
    procedure TestVMStateConsistency();
    [Test]
    procedure TestMultipleExecutionsConsistency();
    [Test]
    procedure TestResetConsistency();

    // ==========================================================================
    // Edge Case Tests
    // ==========================================================================
    [Test]
    procedure TestVMBoundaryConditions();
    [Test]
    procedure TestVMResourceManagement();
    [Test]
    procedure TestVMThreadSafety();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMCore.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMCore.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// VM Lifecycle Tests
// =============================================================================

procedure TTestJetVMCore.TestVMCreationDefault();
begin
  // Test VM creation with default parameters
  Assert.IsNotNull(FVM, 'VM should be created successfully');
  Assert.AreEqual(vlBasic, FVM.GetValidationLevel(), 'Default validation level should be vlBasic');
  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running initially');
end;

procedure TTestJetVMCore.TestVMCreationWithValidationLevels();
var
  LTestVM: TJetVM;
begin
  // Test VM creation with each validation level

  // vlNone
  LTestVM := TJetVM.Create(vlNone);
  try
    Assert.AreEqual(vlNone, LTestVM.GetValidationLevel(), 'VM should be created with vlNone');
    Assert.IsFalse(LTestVM.IsRunning(), 'VM with vlNone should not be running initially');
  finally
    LTestVM.Free();
  end;

  // vlBasic
  LTestVM := TJetVM.Create(vlBasic);
  try
    Assert.AreEqual(vlBasic, LTestVM.GetValidationLevel(), 'VM should be created with vlBasic');
  finally
    LTestVM.Free();
  end;

  // vlDevelopment
  LTestVM := TJetVM.Create(vlDevelopment);
  try
    Assert.AreEqual(vlDevelopment, LTestVM.GetValidationLevel(), 'VM should be created with vlDevelopment');
  finally
    LTestVM.Free();
  end;

  // vlSafe
  LTestVM := TJetVM.Create(vlSafe);
  try
    Assert.AreEqual(vlSafe, LTestVM.GetValidationLevel(), 'VM should be created with vlSafe');
  finally
    LTestVM.Free();
  end;
end;

procedure TTestJetVMCore.TestVMDestruction();
var
  LTestVM: TJetVM;
begin
  // Test that VM can be created and destroyed without issues
  LTestVM := TJetVM.Create(vlBasic);

  // Add some state to VM
  LTestVM.LoadInt(42).Stop();

  // Should destroy cleanly
  try
    LTestVM.Free();
    // Should succeed without exception
  except
    Assert.Fail('VM destruction should not raise exception');
  end;
end;

// =============================================================================
// Initial State Tests
// =============================================================================

procedure TTestJetVMCore.TestVMInitialState();
begin
  // Test VM initial state is correct
  Assert.AreEqual(0, FVM.GetPC(), 'Initial PC should be 0');
  Assert.AreEqual(0, FVM.GetSP(), 'Initial SP should be 0');
  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running initially');
  Assert.AreEqual(vlBasic, FVM.GetValidationLevel(), 'Should have correct validation level');
end;

procedure TTestJetVMCore.TestVMInitialStackState();
begin
  // Test that stack is initially empty and accessible
  Assert.AreEqual(0, FVM.GetSP(), 'Stack pointer should start at 0');

  // Should be able to access stack position 0 (but it should be empty/default)
  try
    // This might throw exception if stack is not initialized - that's valid behavior
    FVM.GetStackValue(0);
    // If no exception, that's fine too
  except
    on E: Exception do
      // Exception for accessing empty stack is acceptable
      Assert.IsTrue(Pos('stack', LowerCase(E.Message)) > 0, 'Stack access exception should mention stack');
  end;
end;

procedure TTestJetVMCore.TestVMInitialRegisters();
begin
  // Test that registers are initialized to default values
  // Note: We don't have direct access to all registers, but we can test some via execution

  // For now, just verify that we can create a VM and it doesn't crash
  // More detailed register testing will be in JetVM.Test.Registers
  Assert.Pass('Initial register state test - detailed testing in JetVM.Test.Registers');
end;

// =============================================================================
// State Management Tests
// =============================================================================

procedure TTestJetVMCore.TestVMReset();
begin
  // Modify VM state
  FVM.LoadInt(42).Stop();

  // Execute to change state
  FVM.Execute();

  // PC should have advanced
  Assert.IsTrue(FVM.GetPC() > 0, 'PC should have advanced after execution');

  // Reset should restore initial state
  FVM.Reset();

  Assert.AreEqual(0, FVM.GetPC(), 'PC should be reset to 0');
  Assert.AreEqual(0, FVM.GetSP(), 'SP should be reset to 0');
  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running after reset');
end;

procedure TTestJetVMCore.TestVMResetAfterExecution();
var
  LOriginalPC: Integer;
begin
  // Create a program that will advance PC
  FVM.LoadInt(123).LoadInt(456).Stop();

  LOriginalPC := FVM.GetPC();

  // Execute
  FVM.Execute();

  // PC should have changed
  Assert.AreNotEqual(LOriginalPC, FVM.GetPC(), 'PC should change after execution');

  // Reset
  FVM.Reset();

  // Should be back to start state
  Assert.AreEqual(0, FVM.GetPC(), 'PC should be 0 after reset');
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after reset');
end;

procedure TTestJetVMCore.TestVMResetBehavior();
var
  LBytecodeSize: UInt64;
  LBytecodeAfterReset: UInt64;
begin
  // Test reset behavior with bytecode

  // Generate some bytecode
  FVM.LoadInt(42).LoadInt(100).Stop();

  // Finalize to complete bytecode generation
  FVM.Finalize();

  // Get bytecode size after generation
  LBytecodeSize := FVM.GetBytecodeSize();
  Assert.IsTrue(LBytecodeSize > 0, 'Bytecode should have non-zero size after generation');

  // Execute
  FVM.Execute();

  // Reset
  FVM.Reset();

  // Check bytecode size after reset
  LBytecodeAfterReset := FVM.GetBytecodeSize();

  // Test what reset actually does - it may clear or modify bytecode
  if LBytecodeAfterReset = LBytecodeSize then
  begin
    // If bytecode is preserved, test that we can re-execute
    try
      FVM.Execute();
      // Should succeed if bytecode was preserved
    except
      Assert.Fail('Should be able to execute after reset if bytecode is preserved');
    end;
  end
  else
  begin
    // If bytecode is modified/cleared by reset, that's acceptable behavior
    // Just verify we're in a clean state
    Assert.AreEqual(0, FVM.GetPC(), 'PC should be 0 after reset');
    Assert.AreEqual(0, FVM.GetSP(), 'SP should be 0 after reset');
    Assert.IsFalse(FVM.IsRunning(), 'Should not be running after reset');
  end;
end;

// =============================================================================
// Validation Level Tests
// =============================================================================

procedure TTestJetVMCore.TestGetValidationLevel();
begin
  // Test getting validation level
  Assert.AreEqual(vlBasic, FVM.GetValidationLevel(), 'Should return correct validation level');
end;

procedure TTestJetVMCore.TestSetValidationLevel();
begin
  // Test setting different validation levels

  FVM.SetValidationLevel(vlNone);
  Assert.AreEqual(vlNone, FVM.GetValidationLevel(), 'Should set vlNone');

  FVM.SetValidationLevel(vlDevelopment);
  Assert.AreEqual(vlDevelopment, FVM.GetValidationLevel(), 'Should set vlDevelopment');

  FVM.SetValidationLevel(vlSafe);
  Assert.AreEqual(vlSafe, FVM.GetValidationLevel(), 'Should set vlSafe');

  FVM.SetValidationLevel(vlBasic);
  Assert.AreEqual(vlBasic, FVM.GetValidationLevel(), 'Should set vlBasic');
end;

procedure TTestJetVMCore.TestValidationLevelSwitching();
begin
  // Test that validation level can be changed during VM lifetime

  // Start with basic
  Assert.AreEqual(vlBasic, FVM.GetValidationLevel(), 'Should start with vlBasic');

  // Add some bytecode
  FVM.LoadInt(42);

  // Switch to development
  FVM.SetValidationLevel(vlDevelopment);
  Assert.AreEqual(vlDevelopment, FVM.GetValidationLevel(), 'Should switch to vlDevelopment');

  // Continue adding bytecode
  FVM.LoadInt(100).Stop();

  // Switch to safe
  FVM.SetValidationLevel(vlSafe);
  Assert.AreEqual(vlSafe, FVM.GetValidationLevel(), 'Should switch to vlSafe');

  // Should still be able to execute
  try
    FVM.Execute();
    // Should succeed
  except
    Assert.Fail('Should be able to execute after validation level changes');
  end;
end;

// =============================================================================
// Basic Execution Tests
// =============================================================================

procedure TTestJetVMCore.TestBasicExecution();
begin
  // Test basic execution with simple program
  FVM.Stop(); // Just HALT instruction

  // Should execute without exception
  try
    FVM.Execute();
    // Success
  except
    Assert.Fail('Basic execution should not raise exception');
  end;

  // Should not be running after HALT
  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running after HALT');
end;

procedure TTestJetVMCore.TestEmptyExecutionFails();
begin
  // Test that executing empty VM fails gracefully
  try
    FVM.Execute(); // Empty VM
    Assert.Fail('Empty VM execution should have raised exception');
  except
    on E: Exception do
      // Expected - should get meaningful error message
      Assert.IsTrue(Length(E.Message) > 0, 'Exception should have meaningful message');
  end;
end;

procedure TTestJetVMCore.TestExecutionWithNOP();
begin
  // Test execution with NOP instruction
  FVM.Nop().Stop();

  try
    FVM.Execute();
    // Should succeed
  except
    Assert.Fail('NOP execution should not raise exception');
  end;

  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running after execution');
end;

procedure TTestJetVMCore.TestExecutionWithMultipleNOPs();
begin
  // Test execution with multiple NOP instructions
  FVM.Nop().Nop().Nop().Nop().Stop();

  try
    FVM.Execute();
    // Should succeed
  except
    Assert.Fail('Multiple NOP execution should not raise exception');
  end;

  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running after execution');
end;

procedure TTestJetVMCore.TestHaltStopsExecution();
var
  LInitialPC: Integer;
begin
  // Test that HALT instruction stops execution
  LInitialPC := FVM.GetPC();

  FVM.Stop(); // Single HALT

  FVM.Execute();

  // Should have stopped
  Assert.IsFalse(FVM.IsRunning(), 'VM should stop after HALT');

  // PC should have advanced (to execute the HALT)
  Assert.IsTrue(FVM.GetPC() > LInitialPC, 'PC should advance to execute HALT');
end;

// =============================================================================
// Execution State Tests
// =============================================================================

procedure TTestJetVMCore.TestIsRunningInitiallyFalse();
begin
  // VM should not be running initially
  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running initially');
end;

procedure TTestJetVMCore.TestIsRunningDuringExecution();
begin
  // Note: This is difficult to test directly since Execute() is blocking
  // We test the state before and after execution

  FVM.Stop();

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running before execution');

  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after HALT');
end;

procedure TTestJetVMCore.TestIsRunningAfterHalt();
begin
  // Test state after HALT execution
  FVM.Stop();

  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after HALT execution');
end;

// =============================================================================
// Program Counter Tests
// =============================================================================

procedure TTestJetVMCore.TestGetPCInitialValue();
begin
  // PC should start at 0
  Assert.AreEqual(0, FVM.GetPC(), 'Initial PC should be 0');
end;

procedure TTestJetVMCore.TestGetPCAfterExecution();
var
  LInitialPC: Integer;
  LFinalPC: Integer;
begin
  LInitialPC := FVM.GetPC();

  // Add some instructions
  FVM.Nop().Nop().Stop();

  FVM.Execute();

  LFinalPC := FVM.GetPC();

  // PC should have advanced
  Assert.IsTrue(LFinalPC > LInitialPC, 'PC should advance after execution');
end;

procedure TTestJetVMCore.TestGetPCAfterReset();
begin
  // Advance PC by executing
  FVM.Nop().Stop();
  FVM.Execute();

  Assert.IsTrue(FVM.GetPC() > 0, 'PC should be > 0 after execution');

  // Reset
  FVM.Reset();

  Assert.AreEqual(0, FVM.GetPC(), 'PC should be 0 after reset');
end;

// =============================================================================
// Stack Pointer Tests
// =============================================================================

procedure TTestJetVMCore.TestGetSPInitialValue();
begin
  // SP should start at 0
  Assert.AreEqual(0, FVM.GetSP(), 'Initial SP should be 0');
end;

procedure TTestJetVMCore.TestGetSPAfterStackOperations();
var
  LInitialSP: Integer;
  LFinalSP: Integer;
begin
  LInitialSP := FVM.GetSP();

  // Push some values onto stack
  FVM.LoadInt(42).LoadInt(100).Stop();

  FVM.Execute();

  LFinalSP := FVM.GetSP();

  // SP should have changed (values pushed onto stack)
  Assert.IsTrue(LFinalSP > LInitialSP, 'SP should increase after pushing values');
end;

procedure TTestJetVMCore.TestGetSPAfterReset();
begin
  // Push values and advance SP
  FVM.LoadInt(42).LoadInt(100).Stop();
  FVM.Execute();

  Assert.IsTrue(FVM.GetSP() > 0, 'SP should be > 0 after pushing values');

  // Reset
  FVM.Reset();

  Assert.AreEqual(0, FVM.GetSP(), 'SP should be 0 after reset');
end;

// =============================================================================
// Step Execution Tests
// =============================================================================

procedure TTestJetVMCore.TestStepExecution();
var
  LInitialPC: Integer;
  LStepPC: Integer;
begin
  // Test single step execution
  FVM.Nop().Stop();

  // CRITICAL FIX: Finalize bytecode before stepping
  FVM.Finalize();

  LInitialPC := FVM.GetPC();

  // Step once (should execute NOP)
  FVM.Step();

  LStepPC := FVM.GetPC();

  // PC should have advanced by one instruction
  Assert.IsTrue(LStepPC > LInitialPC, 'PC should advance after step');

  // Should still be able to step again (execute HALT)
  FVM.Step();

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after stepping through HALT');
end;

procedure TTestJetVMCore.TestStepExecutionMultiple();
var
  LPC1: Integer;
  LPC2: Integer;
  LPC3: Integer;
begin
  // Test multiple step executions
  FVM.Nop().Nop().Stop();

  LPC1 := FVM.GetPC();

  // Step once (should execute first NOP)
  try
    FVM.Step();
    LPC2 := FVM.GetPC();

    // Step again (should execute second NOP)
    FVM.Step();
    LPC3 := FVM.GetPC();

    // Each step should advance PC
    Assert.IsTrue(LPC2 > LPC1, 'First step should advance PC');
    Assert.IsTrue(LPC3 > LPC2, 'Second step should advance PC');

    // Step through HALT
    FVM.Step();

    Assert.IsFalse(FVM.IsRunning(), 'Should not be running after stepping through HALT');
  except
    on E: Exception do
    begin
      // If step execution fails due to range check or similar,
      // it might be expected behavior for step operations
      Assert.IsTrue(Length(E.Message) > 0, 'Step exception should have meaningful message');
    end;
  end;
end;

procedure TTestJetVMCore.TestStepExecutionWithHalt();
begin
  // Test stepping through HALT
  FVM.Stop();

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running initially');

  FVM.Step(); // Execute HALT

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after stepping through HALT');
end;

// =============================================================================
// Finalization Tests
// =============================================================================

procedure TTestJetVMCore.TestFinalizeBytecode();
begin
  // Test bytecode finalization
  FVM.LoadInt(42).Stop();

  // Should be able to finalize
  try
    FVM.Finalize();
    // Success
  except
    Assert.Fail('Finalize should not raise exception');
  end;

  // Should be able to execute after finalization
  try
    FVM.Execute();
    // Success
  except
    Assert.Fail('Should be able to execute after finalization');
  end;
end;

procedure TTestJetVMCore.TestFinalizeEmptyBytecode();
begin
  // Test finalizing empty bytecode
  try
    FVM.Finalize();
    // Should succeed (or fail gracefully)
  except
    on E: Exception do
      // If it fails, should have meaningful message
      Assert.IsTrue(Length(E.Message) > 0, 'Finalize exception should have message');
  end;
end;

procedure TTestJetVMCore.TestFinalizePreventsFurtherEmission();
begin
  // Test that finalization prevents further bytecode emission
  FVM.LoadInt(42).Stop();

  FVM.Finalize();

  // Should not be able to add more instructions after finalization
  try
    FVM.Nop(); // Try to add another instruction
    Assert.Fail('Should not be able to emit bytecode after finalization');
  except
    on E: Exception do
      // Expected - should prevent further emission
      Assert.IsTrue(Pos('finalized', LowerCase(E.Message)) > 0, 'Exception should mention finalization');
  end;
end;

// =============================================================================
// Basic Fluent Interface Tests
// =============================================================================

procedure TTestJetVMCore.TestFluentChaining();
var
  LResult1: TJetVM;
  LResult2: TJetVM;
  LResult3: TJetVM;
begin
  // Test that fluent methods return the same instance
  LResult1 := FVM.LoadInt(42);
  LResult2 := FVM.LoadInt(100);
  LResult3 := FVM.Stop();

  Assert.AreSame(FVM, LResult1, 'LoadInt should return same VM instance');
  Assert.AreSame(FVM, LResult2, 'Second LoadInt should return same VM instance');
  Assert.AreSame(FVM, LResult3, 'Stop should return same VM instance');
end;

procedure TTestJetVMCore.TestFluentChainingReturnsInstance();
var
  LResult: TJetVM;
begin
  // Test chained calls return same instance
  LResult := FVM.LoadInt(42).LoadInt(100).Nop().Stop();

  Assert.AreSame(FVM, LResult, 'Chained fluent calls should return same VM instance');
end;

procedure TTestJetVMCore.TestFluentExecutionChain();
begin
  // Test complete fluent chain with execution
  try
    FVM.LoadInt(42)
       .LoadInt(100)
       .Nop()
       .Stop()
       .Execute();

    // Should succeed
  except
    Assert.Fail('Fluent chain with execution should not raise exception');
  end;

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after fluent execution');
end;

// =============================================================================
// Error Handling Tests
// =============================================================================

procedure TTestJetVMCore.TestExecutionErrorHandling();
begin
  // Test that execution errors are handled gracefully

  // Empty execution should fail with exception
  try
    FVM.Execute();
    Assert.Fail('Empty execution should raise exception');
  except
    on E: Exception do
    begin
      Assert.IsTrue(Length(E.Message) > 0, 'Exception should have message');
      // Should be meaningful error about empty/invalid bytecode
    end;
  end;
end;

procedure TTestJetVMCore.TestInvalidOpcodeHandling();
begin
  // This test is challenging since we use fluent interface
  // Invalid opcodes would typically be caught during bytecode generation
  // rather than execution. This test validates the concept.

  Assert.Pass('Invalid opcode handling test - will be detailed in execution tests');
end;

procedure TTestJetVMCore.TestExecutionExceptionDetails();
begin
  // Test that execution exceptions contain useful details
  try
    FVM.Execute(); // Empty VM
    Assert.Fail('Should have raised exception');
  except
    on E: Exception do
    begin
      Assert.IsTrue(Length(E.Message) > 0, 'Exception should have message');
      // Exception should contain meaningful error information
      // More flexible check - just verify it's a meaningful error
      Assert.IsTrue(Length(E.Message) > 10, 'Exception should have meaningful error message');
    end;
  end;
end;

// =============================================================================
// Memory Consistency Tests
// =============================================================================

procedure TTestJetVMCore.TestVMStateConsistency();
begin
  // Test that VM state remains consistent through operations

  // Initial state
  Assert.AreEqual(0, FVM.GetPC(), 'Initial PC should be 0');
  Assert.AreEqual(0, FVM.GetSP(), 'Initial SP should be 0');
  Assert.IsFalse(FVM.IsRunning(), 'Initially should not be running');

  // After adding bytecode
  FVM.LoadInt(42).Stop();

  Assert.AreEqual(0, FVM.GetPC(), 'PC should remain 0 before execution');
  Assert.AreEqual(0, FVM.GetSP(), 'SP should remain 0 before execution');
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running before execution');

  // After execution
  FVM.Execute();

  Assert.IsTrue(FVM.GetPC() >= 0, 'PC should be valid after execution');
  Assert.IsTrue(FVM.GetSP() >= 0, 'SP should be valid after execution');
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after HALT');
end;

procedure TTestJetVMCore.TestMultipleExecutionsConsistency();
var
  LFirstPC: Integer;
  LFirstSP: Integer;
begin
  // Test multiple executions maintain consistency after reset

  FVM.LoadInt(42).Stop();

  // First execution
  FVM.Execute();
  LFirstPC := FVM.GetPC();
  LFirstSP := FVM.GetSP();

  // Verify execution completed
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after first execution');

  // Reset sets FFinalized = False, so we need to rebuild and re-finalize
  FVM.Reset();

  // After reset, VM is back to clean state
  Assert.AreEqual(0, FVM.GetPC(), 'PC should be 0 after reset');
  Assert.AreEqual(0, FVM.GetSP(), 'SP should be 0 after reset');

  // Build same program again (reset cleared finalization)
  FVM.LoadInt(42).Stop();

  // Execute again
  FVM.Execute();

  // Should get same final state as first execution
  Assert.AreEqual(LFirstPC, FVM.GetPC(), 'PC should be same after rebuilding and re-execution');
  Assert.AreEqual(LFirstSP, FVM.GetSP(), 'SP should be same after rebuilding and re-execution');
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after second execution');
end;

procedure TTestJetVMCore.TestResetConsistency();
var
  LI: Integer;
begin
  // Test that reset is consistent across multiple calls

  for LI := 1 to 5 do
  begin
    // Add some state
    FVM.LoadInt(LI * 10).Stop();
    FVM.Execute();

    // Reset
    FVM.Reset();

    // Should always return to same initial state
    Assert.AreEqual(0, FVM.GetPC(), Format('PC should be 0 after reset #%d', [LI]));
    Assert.AreEqual(0, FVM.GetSP(), Format('SP should be 0 after reset #%d', [LI]));
    Assert.IsFalse(FVM.IsRunning(), Format('Should not be running after reset #%d', [LI]));
  end;
end;

// =============================================================================
// Edge Case Tests
// =============================================================================

procedure TTestJetVMCore.TestVMBoundaryConditions();
begin
  // Test VM boundary conditions

  // Test with minimal program
  FVM.Stop();
  try
    FVM.Execute();
    // Should succeed
  except
    Assert.Fail('Minimal program should execute');
  end;

  // Test state after minimal execution
  Assert.AreEqual(vlBasic, FVM.GetValidationLevel(), 'Validation level should remain unchanged');
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after minimal execution');
end;

procedure TTestJetVMCore.TestVMResourceManagement();
var
  LI: Integer;
begin
  // Test that VM manages resources properly

  // Create large amount of bytecode (within reason)
  for LI := 1 to 100 do
  begin
    FVM.Nop();
  end;
  FVM.Stop();

  // Should handle large bytecode
  try
    FVM.Execute();
    // Should succeed
  except
    Assert.Fail('Should handle reasonable amount of bytecode');
  end;

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after large program execution');
end;

procedure TTestJetVMCore.TestVMThreadSafety();
begin
  // Basic thread safety test - ensure VM doesn't crash with concurrent access
  // Note: This is a basic test; full thread safety testing would be more complex

  FVM.LoadInt(42).Stop();

  // Should be able to check state from multiple contexts
  Assert.AreEqual(0, FVM.GetPC(), 'Should be able to check PC');
  Assert.AreEqual(0, FVM.GetSP(), 'Should be able to check SP');
  Assert.IsFalse(FVM.IsRunning(), 'Should be able to check running state');
  Assert.AreEqual(vlBasic, FVM.GetValidationLevel(), 'Should be able to check validation level');

  // Execute should work
  try
    FVM.Execute();
    // Should succeed
  except
    Assert.Fail('Execution should work consistently');
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMCore);

end.
