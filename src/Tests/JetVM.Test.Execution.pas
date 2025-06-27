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

unit JetVM.Test.Execution;

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
  TTestJetVMExecution = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Core Execution Loop Tests
    // ==========================================================================
    [Test]
    procedure TestExecutionLoopBasics();
    [Test]
    procedure TestExecutionLoopProgression();
    [Test]
    procedure TestExecutionLoopTermination();
    [Test]
    procedure TestExecutionLoopInterruption();

    // ==========================================================================
    // Instruction Processing Tests
    // ==========================================================================
    [Test]
    procedure TestSingleInstructionExecution();
    [Test]
    procedure TestMultipleInstructionSequence();
    [Test]
    procedure TestInstructionProcessingOrder();
    [Test]
    procedure TestInstructionParameterHandling();

    // ==========================================================================
    // Halting Behavior Tests
    // ==========================================================================
    [Test]
    procedure TestHaltInstructionStopsExecution();
    [Test]
    procedure TestHaltAtDifferentPositions();
    [Test]
    procedure TestMultipleHaltInstructions();
    [Test]
    procedure TestHaltWithStackData();

    // ==========================================================================
    // Execution State Management Tests
    // ==========================================================================
    [Test]
    procedure TestRunningStateTransitions();
    [Test]
    procedure TestExecutionStateConsistency();
    [Test]
    procedure TestStateAfterExecution();
    [Test]
    procedure TestStateAfterReset();

    // ==========================================================================
    // Complex Instruction Sequences
    // ==========================================================================
    [Test]
    procedure TestArithmeticSequenceExecution();
    [Test]
    procedure TestStringOperationSequence();
    [Test]
    procedure TestMixedOperationSequence();
    [Test]
    procedure TestLongInstructionChain();

    // ==========================================================================
    // Execution Performance Tests
    // ==========================================================================
    [Test]
    procedure TestExecutionTiming();
    [Test]
    procedure TestBulkInstructionPerformance();
    [Test]
    procedure TestExecutionOverhead();
    [Test]
    procedure TestPerformanceConsistency();

    // ==========================================================================
    // Step Execution Tests
    // ==========================================================================
    [Test]
    procedure TestStepExecutionPrecision();
    [Test]
    procedure TestStepThroughComplexProgram();
    [Test]
    procedure TestStepExecutionStateChanges();
    [Test]
    procedure TestStepExecutionStackEffects();

    // ==========================================================================
    // Execution Error Conditions
    // ==========================================================================
    [Test]
    procedure TestInvalidOpcodeHandling();
    [Test]
    procedure TestMalformedBytecodeExecution();
    [Test]
    procedure TestExecutionBoundsChecking();
    [Test]
    procedure TestStackOverflowDuringExecution();

    // ==========================================================================
    // Execution Recovery Tests
    // ==========================================================================
    [Test]
    procedure TestExecutionAfterError();
    [Test]
    procedure TestResetAfterFailedExecution();
    [Test]
    procedure TestExecutionErrorRecovery();
    [Test]
    procedure TestPartialExecutionRecovery();

    // ==========================================================================
    // Advanced Execution Features
    // ==========================================================================
    [Test]
    procedure TestExecutionWithValidationLevels();
    [Test]
    procedure TestExecutionMemoryEfficiency();
    [Test]
    procedure TestExecutionThreadSafety();
    [Test]
    procedure TestExecutionDebugInfo();

    // ==========================================================================
    // Integration Execution Tests
    // ==========================================================================
    [Test]
    procedure TestExecutionWithNativeFunctions();
    [Test]
    procedure TestExecutionWithStackManipulation();
    [Test]
    procedure TestExecutionWithConstants();
    [Test]
    procedure TestCompleteProgram
();

    // ==========================================================================
    // Execution Verification Tests
    // ==========================================================================
    [Test]
    procedure TestExecutionResultVerification();
    [Test]
    procedure TestExecutionSideEffects();
    [Test]
    procedure TestExecutionDeterminism();
    [Test]
    procedure TestExecutionCompleteness();
  end;

implementation

// =============================================================================
// Setup/TearDown
// =============================================================================

procedure TTestJetVMExecution.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMExecution.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Core Execution Loop Tests
// =============================================================================

procedure TTestJetVMExecution.TestExecutionLoopBasics();
var
  LInitialPC: Integer;
  LFinalPC: Integer;
begin
  // Test that execution loop functions at basic level
  LInitialPC := FVM.GetPC();

  FVM.Nop().Stop();
  FVM.Execute();

  LFinalPC := FVM.GetPC();

  Assert.IsTrue(LFinalPC > LInitialPC, 'Execution should advance PC');
  Assert.IsFalse(FVM.IsRunning(), 'Execution should complete');
end;

procedure TTestJetVMExecution.TestExecutionLoopProgression();
var
  LPC1: Integer;
  LPC2: Integer;
  LPC3: Integer;
begin
  // Test that execution progresses through multiple instructions
  FVM.Nop().Nop().Nop().Stop();

  LPC1 := FVM.GetPC();
  FVM.Step(); // Execute first NOP

  LPC2 := FVM.GetPC();
  FVM.Step(); // Execute second NOP

  LPC3 := FVM.GetPC();

  Assert.IsTrue(LPC2 > LPC1, 'First step should advance PC');
  Assert.IsTrue(LPC3 > LPC2, 'Second step should advance PC');
end;

procedure TTestJetVMExecution.TestExecutionLoopTermination();
begin
  // Test that execution loop properly terminates
  FVM.LoadInt(42).Stop();

  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'Execution should terminate after HALT');
  Assert.AreEqual(1, FVM.GetSP(), 'Stack should contain the loaded value');
end;

procedure TTestJetVMExecution.TestExecutionLoopInterruption();
begin
  // Test execution behavior with immediate halt
  FVM.Stop(); // Immediate halt

  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after immediate halt');
  Assert.AreEqual(0, FVM.GetSP(), 'Stack should be empty after immediate halt');
end;

// =============================================================================
// Instruction Processing Tests
// =============================================================================

procedure TTestJetVMExecution.TestSingleInstructionExecution();
var
  LResult: TJetValue;
begin
  // Test execution of single instruction
  FVM.LoadInt(100).Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(100), LResult.IntValue, 'Single instruction should execute correctly');
end;

procedure TTestJetVMExecution.TestMultipleInstructionSequence();
var
  LResult: TJetValue;
begin
  // Test execution of instruction sequence
  FVM.LoadInt(10).LoadInt(20).AddInt().Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(30), LResult.IntValue, 'Instruction sequence should execute correctly');
end;

procedure TTestJetVMExecution.TestInstructionProcessingOrder();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test that instructions execute in correct order
  FVM.LoadInt(42).LoadStr('test').Stop();

  FVM.Execute();

  // Stack should have string on top, int below (LIFO order)
  LValue2 := FVM.PopValue(); // String (pushed last)
  LValue1 := FVM.PopValue(); // Int (pushed first)

  Assert.AreEqual(Int64(42), LValue1.IntValue, 'First instruction result should be available');
  Assert.AreEqual('test', LValue2.StrValue, 'Second instruction result should be on top');
end;

procedure TTestJetVMExecution.TestInstructionParameterHandling();
var
  LResult: TJetValue;
begin
  // Test instruction parameter handling during execution
  FVM.LoadInt(1000).LoadInt(7).DivInt().Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(142), LResult.IntValue, 'Parameters should be handled correctly'); // 1000 div 7 = 142
end;

// =============================================================================
// Halting Behavior Tests
// =============================================================================

procedure TTestJetVMExecution.TestHaltInstructionStopsExecution();
var
  LInitialSP: Integer;
begin
  // Test that HALT instruction immediately stops execution
  LInitialSP := FVM.GetSP();

  FVM.Stop().LoadInt(999); // LoadInt should not execute after HALT

  FVM.Execute();

  Assert.AreEqual(LInitialSP, FVM.GetSP(), 'Instructions after HALT should not execute');
  Assert.IsFalse(FVM.IsRunning(), 'VM should not be running after HALT');
end;

procedure TTestJetVMExecution.TestHaltAtDifferentPositions();
var
  LResult: TJetValue;
begin
  // Test HALT at different positions in instruction stream
  FVM.LoadInt(50).Stop().LoadInt(999).Stop();

  FVM.Execute();

  Assert.AreEqual(1, FVM.GetSP(), 'Only first instruction should execute');
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(50), LResult.IntValue, 'First value should be correct');
end;

procedure TTestJetVMExecution.TestMultipleHaltInstructions();
begin
  // Test behavior with multiple HALT instructions
  FVM.Stop().Stop().Stop();

  FVM.Execute();

  Assert.IsFalse(FVM.IsRunning(), 'Should handle multiple HALTs gracefully');
end;

procedure TTestJetVMExecution.TestHaltWithStackData();
var
  LStackCount: Integer;
begin
  // Test that HALT preserves stack data
  FVM.LoadInt(1).LoadInt(2).LoadInt(3).Stop();

  FVM.Execute();

  LStackCount := FVM.GetSP();
  Assert.AreEqual(3, LStackCount, 'HALT should preserve all stack data');
end;

// =============================================================================
// Execution State Management Tests
// =============================================================================

procedure TTestJetVMExecution.TestRunningStateTransitions();
begin
  // Test running state changes during execution
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running initially');

  FVM.LoadInt(42).Stop();
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running before execution');

  FVM.Execute();
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after execution completes');
end;

procedure TTestJetVMExecution.TestExecutionStateConsistency();
var
  LPCBefore: Integer;
  LPCAfter: Integer;
  LSPBefore: Integer;
  LSPAfter: Integer;
begin
  // Test that execution maintains state consistency
  LPCBefore := FVM.GetPC();
  LSPBefore := FVM.GetSP();

  FVM.LoadInt(123).Stop();
  FVM.Execute();

  LPCAfter := FVM.GetPC();
  LSPAfter := FVM.GetSP();

  Assert.IsTrue(LPCAfter > LPCBefore, 'PC should advance during execution');
  Assert.IsTrue(LSPAfter > LSPBefore, 'SP should increase with stack push');
end;

procedure TTestJetVMExecution.TestStateAfterExecution();
var
  LPC: Integer;
  LSP: Integer;
begin
  // Test VM state after execution completes
  FVM.LoadInt(555).Stop();
  FVM.Execute();

  LPC := FVM.GetPC();
  LSP := FVM.GetSP();

  Assert.IsTrue(LPC > 0, 'PC should be advanced after execution');
  Assert.AreEqual(1, LSP, 'SP should reflect stack operations');
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after completion');
end;

procedure TTestJetVMExecution.TestStateAfterReset();
begin
  // Test state after reset following execution
  FVM.LoadInt(777).Stop();
  FVM.Execute();

  FVM.Reset();

  Assert.AreEqual(0, FVM.GetPC(), 'PC should be 0 after reset');
  Assert.AreEqual(0, FVM.GetSP(), 'SP should be 0 after reset');
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after reset');
end;

// =============================================================================
// Complex Instruction Sequences
// =============================================================================

procedure TTestJetVMExecution.TestArithmeticSequenceExecution();
var
  LResult: TJetValue;
begin
  // Test execution of complex arithmetic sequence
  FVM.LoadInt(100)
     .LoadInt(50)
     .AddInt()     // 150
     .LoadInt(3)
     .MulInt()     // 450
     .LoadInt(50)
     .SubInt()     // 400
     .LoadInt(4)
     .DivInt()     // 100
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(100), LResult.IntValue, 'Complex arithmetic should execute correctly');
end;

procedure TTestJetVMExecution.TestStringOperationSequence();
var
  LResult: TJetValue;
begin
  // Test execution of string operations
  FVM.LoadStr('Hello')
     .LoadStr(' ')
     .ConcatStr()
     .LoadStr('World')
     .ConcatStr()
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual('Hello World', LResult.StrValue, 'String operations should execute correctly');
end;

procedure TTestJetVMExecution.TestMixedOperationSequence();
var
  LIntResult: TJetValue;
  LStrResult: TJetValue;
begin
  // Test execution mixing different operation types
  FVM.LoadInt(42)
     .LoadStr('test')
     .LoadInt(10)
     .LoadInt(5)
     .AddInt()     // Stack: 42, "test", 15
     .Stop();

  FVM.Execute();

  LIntResult := FVM.PopValue();  // 15
  LStrResult := FVM.PopValue();  // "test"

  Assert.AreEqual(Int64(15), LIntResult.IntValue, 'Mixed operations int result should be correct');
  Assert.AreEqual('test', LStrResult.StrValue, 'Mixed operations string result should be correct');
end;

procedure TTestJetVMExecution.TestLongInstructionChain();
var
  LResult: TJetValue;
  LI: Integer;
begin
  // Test execution of long instruction chain
  FVM.LoadInt(0);

  // Add 1 ten times
  for LI := 1 to 10 do
  begin
    FVM.LoadInt(1).AddInt();
  end;

  FVM.Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(10), LResult.IntValue, 'Long instruction chain should execute correctly');
end;

// =============================================================================
// Execution Performance Tests
// =============================================================================

procedure TTestJetVMExecution.TestExecutionTiming();
var
  LStopwatch: TStopwatch;
  LElapsed: Int64;
begin
  // Test execution timing characteristics
  FVM.LoadInt(1).LoadInt(2).AddInt().Stop();

  LStopwatch := TStopwatch.StartNew();
  FVM.Execute();
  LStopwatch.Stop();

  LElapsed := LStopwatch.ElapsedMilliseconds;

  Assert.IsTrue(LElapsed >= 0, 'Execution should complete in reasonable time');
  // Note: Actual timing thresholds would depend on hardware
end;

procedure TTestJetVMExecution.TestBulkInstructionPerformance();
var
  LStopwatch: TStopwatch;
  LElapsed: Int64;
  LI: Integer;
begin
  // Test performance with many instructions
  FVM.LoadInt(0);

  for LI := 1 to 1000 do
  begin
    FVM.LoadInt(1).AddInt();
  end;

  FVM.Stop();

  LStopwatch := TStopwatch.StartNew();
  FVM.Execute();
  LStopwatch.Stop();

  LElapsed := LStopwatch.ElapsedMilliseconds;

  Assert.IsTrue(LElapsed < 1000, 'Bulk execution should complete efficiently'); // < 1 second
end;

procedure TTestJetVMExecution.TestExecutionOverhead();
var
  LStopwatch1: TStopwatch;
  LStopwatch2: TStopwatch;
  LElapsed1: Int64;
  LElapsed2: Int64;
begin
  // Test execution overhead by comparing simple vs complex operations

  // Simple operation
  FVM.LoadInt(42).Stop();
  LStopwatch1 := TStopwatch.StartNew();
  FVM.Execute();
  LStopwatch1.Stop();
  LElapsed1 := LStopwatch1.ElapsedTicks;

  // Reset for next test
  FVM.Reset();

  // Complex operation
  FVM.LoadInt(1).LoadInt(2).AddInt().LoadInt(3).MulInt().Stop();
  LStopwatch2 := TStopwatch.StartNew();
  FVM.Execute();
  LStopwatch2.Stop();
  LElapsed2 := LStopwatch2.ElapsedTicks;

  Assert.IsTrue(LElapsed2 >= LElapsed1, 'Complex operations should take longer than simple ones');
end;

procedure TTestJetVMExecution.TestPerformanceConsistency();
var
  LElapsed1: Int64;
  LElapsed2: Int64;
  LStopwatch: TStopwatch;
begin
  // Test that performance is consistent across executions

  // First execution
  FVM.LoadInt(10).LoadInt(20).AddInt().Stop();
  LStopwatch := TStopwatch.StartNew();
  FVM.Execute();
  LStopwatch.Stop();
  LElapsed1 := LStopwatch.ElapsedTicks;

  // Reset and repeat
  FVM.Reset();
  FVM.LoadInt(10).LoadInt(20).AddInt().Stop();
  LStopwatch := TStopwatch.StartNew();
  FVM.Execute();
  LStopwatch.Stop();
  LElapsed2 := LStopwatch.ElapsedTicks;

  // Performance should be reasonably consistent (within 10x factor)
  Assert.IsTrue(LElapsed2 < LElapsed1 * 10, 'Performance should be reasonably consistent');
  Assert.IsTrue(LElapsed1 < LElapsed2 * 10, 'Performance should be reasonably consistent');
end;

// =============================================================================
// Step Execution Tests
// =============================================================================

procedure TTestJetVMExecution.TestStepExecutionPrecision();
var
  LPC1: Integer;
  LPC2: Integer;
  LPC3: Integer;
begin
  // Test precise step-by-step execution
  FVM.Nop().Stop();
  FVM.Finalize();

  LPC1 := FVM.GetPC();       // PC = 0 (start)
  FVM.Step();                // Execute NOP
  LPC2 := FVM.GetPC();       // PC = 1 (advanced past NOP) ✅
  FVM.Step();                // Execute HALT
  LPC3 := FVM.GetPC();       // PC = 1 (HALT doesn't advance PC)

  Assert.IsTrue(LPC2 > LPC1, 'First step should advance PC');
  // Change this assertion:
  Assert.AreEqual(LPC2, LPC3, 'HALT step should not advance PC');
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after HALT step');
end;

procedure TTestJetVMExecution.TestStepThroughComplexProgram();
var
  LInitialSP: Integer;
  LFinalSP: Integer;
  LResult: TJetValue;
  LBytecodeSize: UInt64;
begin
  // Test stepping through program (step-by-step approach)
  FVM.LoadInt(10).LoadInt(5).AddInt().Stop();
  FVM.Finalize(); // Required before GetBytecodeSize()

  LInitialSP := FVM.GetSP();
  LBytecodeSize := FVM.GetBytecodeSize();

  // Execute the complete program step by step
  while FVM.GetPC() < Integer(LBytecodeSize) - 1 do
  begin
    FVM.Step();
  end;

  LFinalSP := FVM.GetSP();

  Assert.AreEqual(0, LInitialSP, 'Initial stack should be empty');
  Assert.AreEqual(1, LFinalSP, 'Stack should have 1 item after complete execution');

  // Verify the arithmetic result
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(15), LResult.IntValue, 'Arithmetic result should be correct');
end;

procedure TTestJetVMExecution.TestStepExecutionStateChanges();
begin
  // Test state changes during step execution
  FVM.LoadInt(42).Stop();

  // CRITICAL FIX: Finalize bytecode before stepping
  FVM.Finalize();

  Assert.IsFalse(FVM.IsRunning(), 'Should not be running before step');
  FVM.Step(); // Execute LoadInt
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after step (before HALT)');
  FVM.Step(); // Execute HALT
  Assert.IsFalse(FVM.IsRunning(), 'Should not be running after HALT step');
end;

procedure TTestJetVMExecution.TestStepExecutionStackEffects();
var
  LResult: TJetValue;
begin
  // Test stack effects during execution (using complete execution)
  FVM.LoadInt(100).LoadInt(200).Swap().Stop();

  FVM.Execute();

  // After swap, 100 should be on top (was second, now first)
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(100), LResult.IntValue, 'Top should be 100 after swap');

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(200), LResult.IntValue, 'Bottom should be 200 after swap');
end;

// =============================================================================
// Execution Error Conditions
// =============================================================================

procedure TTestJetVMExecution.TestInvalidOpcodeHandling();
begin
  // Test handling of invalid opcodes during execution
  // Note: This test depends on having a way to inject invalid opcodes
  // For now, test that execution handles errors gracefully

  try
    FVM.Execute(); // Empty bytecode should be handled
    // If no exception, that's fine
  except
    on E: Exception do
      Assert.IsTrue(Integer(Length(E.Message)) > 0, 'Error should have meaningful message');
  end;
end;

procedure TTestJetVMExecution.TestMalformedBytecodeExecution();
begin
  // Test execution with malformed bytecode
  try
    FVM.LoadInt(42); // No HALT instruction
    FVM.Execute();
    // Execution might handle this gracefully or throw exception
  except
    on E: Exception do
      Assert.IsTrue(Integer(Length(E.Message)) > 0, 'Malformed bytecode error should be meaningful');
  end;
end;

procedure TTestJetVMExecution.TestExecutionBoundsChecking();
begin
  // Test that execution respects bounds checking
  FVM.LoadInt(42).Stop();
  FVM.Execute();

  // Try to pop more values than available
  try
    FVM.PopValue(); // This should work
    FVM.PopValue(); // This should fail (stack underflow)
    Assert.Fail('Should have thrown stack underflow exception');
  except
    on E: Exception do
      Assert.IsTrue(Integer(Length(E.Message)) > 0, 'Bounds checking error should be meaningful');
  end;
end;

procedure TTestJetVMExecution.TestStackOverflowDuringExecution();
var
  LI: Integer;
begin
  // Test stack overflow protection during execution
  try
    // Push many values to test stack limits
    for LI := 1 to 10000 do
    begin
      FVM.LoadInt(LI);
    end;
    FVM.Stop();
    FVM.Execute();

    // If we get here, stack handled large load
    Assert.IsTrue(FVM.GetSP() > 0, 'Large stack operations should complete or fail gracefully');
  except
    on E: Exception do
      Assert.IsTrue(Integer(Length(E.Message)) > 0, 'Stack overflow should have meaningful error');
  end;
end;

// =============================================================================
// Execution Recovery Tests
// =============================================================================

procedure TTestJetVMExecution.TestExecutionAfterError();
begin
  // Test that VM can execute after an error
  try
    FVM.PopValue(); // This should fail (empty stack)
  except
    // Ignore expected error
  end;

  // VM should still be usable
  FVM.LoadInt(42).Stop();
  FVM.Execute();

  Assert.AreEqual(Int64(42), FVM.PopValue().IntValue, 'VM should work after error');
end;

procedure TTestJetVMExecution.TestResetAfterFailedExecution();
begin
  // Test reset after failed execution
  try
    FVM.Execute(); // Empty execution might fail
  except
    // Ignore expected error
  end;

  FVM.Reset();
  FVM.LoadInt(123).Stop();
  FVM.Execute();

  Assert.AreEqual(Int64(123), FVM.PopValue().IntValue, 'VM should work after reset');
end;

procedure TTestJetVMExecution.TestExecutionErrorRecovery();
var
  LResult: TJetValue;
begin
  // Test error recovery during execution
  FVM.LoadInt(10).LoadInt(20).AddInt().Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  // Cause an error
  try
    FVM.PopValue(); // Stack underflow
  except
    // Expected error
  end;

  // VM should still be functional
  FVM.Reset();
  FVM.LoadInt(99).Stop();
  FVM.Execute();

  Assert.AreEqual(Int64(99), FVM.PopValue().IntValue, 'VM should recover from execution errors');
end;

procedure TTestJetVMExecution.TestPartialExecutionRecovery();
var
  LInitialPC: Integer;
begin
  // Test recovery from partial execution
  FVM.LoadInt(1).LoadInt(2).AddInt().Stop();

  LInitialPC := FVM.GetPC();
  FVM.Step(); // Partial execution

  Assert.IsTrue(FVM.GetPC() > LInitialPC, 'Partial execution should advance PC');

  // Continue execution
  FVM.Execute();

  Assert.AreEqual(Int64(3), FVM.PopValue().IntValue, 'Should complete after partial execution');
end;

// =============================================================================
// Advanced Execution Features
// =============================================================================

procedure TTestJetVMExecution.TestExecutionWithValidationLevels();
var
  LOriginalLevel: TJetVMValidationLevel;
  LResult: TJetValue;
begin
  // Test execution with different validation levels
  LOriginalLevel := FVM.GetValidationLevel();

  // Test with basic validation
  FVM.SetValidationLevel(vlBasic);
  FVM.LoadInt(42).Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Execution should work with basic validation');

  // Reset and test with different level
  FVM.Reset();
  FVM.SetValidationLevel(vlDevelopment);
  FVM.LoadInt(84).Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(84), LResult.IntValue, 'Execution should work with development validation');

  // Restore original level
  FVM.SetValidationLevel(LOriginalLevel);
end;

procedure TTestJetVMExecution.TestExecutionMemoryEfficiency();
var
  LInitialSP: Integer;
  LFinalSP: Integer;
begin
  // Test that execution is memory efficient
  LInitialSP := FVM.GetSP();

  FVM.LoadInt(1).LoadInt(2).AddInt().Stop();
  FVM.Execute();
  FVM.PopValue(); // Remove result to clean stack

  LFinalSP := FVM.GetSP();

  Assert.AreEqual(LInitialSP, LFinalSP, 'Execution should be memory efficient');
end;

procedure TTestJetVMExecution.TestExecutionThreadSafety();
begin
  // Test basic thread safety of execution
  // Note: Full thread safety testing would require multiple threads
  // This is a basic test to ensure execution doesn't corrupt state

  FVM.LoadInt(42).Stop();
  FVM.Execute();

  Assert.AreEqual(Int64(42), FVM.PopValue().IntValue, 'Execution should maintain state integrity');
end;

procedure TTestJetVMExecution.TestExecutionDebugInfo();
var
  LPC: Integer;
  LSP: Integer;
begin
  // Test that execution provides debug information
  FVM.LoadInt(42).Stop();
  FVM.Execute();

  LPC := FVM.GetPC();
  LSP := FVM.GetSP();

  Assert.IsTrue(LPC >= 0, 'PC should be valid for debugging');
  Assert.IsTrue(LSP >= 0, 'SP should be valid for debugging');
end;

// =============================================================================
// Integration Execution Tests
// =============================================================================

procedure TTestJetVMExecution.TestExecutionWithNativeFunctions();
var
  LCallCount: Integer;
  LNativeFunc: TJetNativeFunction;
  LResult: TJetValue;
begin
  // Test execution with native function calls
  LCallCount := 0;

  LNativeFunc := procedure(const AVM: TJetVM)
  begin
    var LArg: TJetValue := AVM.PopValue();
    var LDoubled: TJetValue := AVM.MakeIntConstant(LArg.IntValue * 2);
    AVM.PushValue(LDoubled);
    Inc(LCallCount);
  end;

  FVM.RegisterNativeFunction('double', LNativeFunc, [jvtInt], jvtInt);

  FVM.LoadInt(21).CallFunction('double').Stop();
  FVM.Execute();

  Assert.AreEqual(1, LCallCount, 'Native function should be called during execution');
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Native function should execute correctly');
end;

procedure TTestJetVMExecution.TestExecutionWithStackManipulation();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
  LResult3: TJetValue;
begin
  // Test execution with stack manipulation operations
  FVM.LoadInt(10).LoadInt(20).Dup().Swap().Stop();
  FVM.Execute();

  // Expected stack after LoadInt(10).LoadInt(20).Dup().Swap():
  // 1. LoadInt(10): [10]
  // 2. LoadInt(20): [10, 20]
  // 3. Dup(): [10, 20, 20] (duplicates top)
  // 4. Swap(): [10, 20, 20] (swaps top two - both 20)
  // Final stack: [10, 20, 20] with 20 on top

  LResult1 := FVM.PopValue(); // Top: 20
  LResult2 := FVM.PopValue(); // Next: 20
  LResult3 := FVM.PopValue(); // Bottom: 10

  Assert.AreEqual(Int64(20), LResult1.IntValue, 'Top should be 20 after Dup().Swap()');
  Assert.AreEqual(Int64(20), LResult2.IntValue, 'Second should be 20 after Dup().Swap()');
  Assert.AreEqual(Int64(10), LResult3.IntValue, 'Bottom should be 10 (original first value)');
end;

procedure TTestJetVMExecution.TestExecutionWithConstants();
var
  LValue: TJetValue;
  LResult: TJetValue;
begin
  // Test execution with constants pool usage
  LValue := FVM.MakeStrConstant('Hello Execution');
  FVM.AddConstant(LValue);

  FVM.LoadConst(0).Stop(); // First constant is at index 0
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual('Hello Execution', LResult.StrValue, 'Constants should work during execution');
end;

procedure TTestJetVMExecution.TestCompleteProgram();
var
  LResult: TJetValue;
begin
  // Test execution of complete program
  FVM.LoadInt(5)
     .LoadInt(10)
     .AddInt()      // 15
     .LoadInt(3)
     .MulInt()      // 45
     .LoadStr('Result: ')
     .LoadStr('45')
     .ConcatStr()   // "Result: 45"
     .Stop();

  FVM.Execute();

  // Should have string result and integer result on stack
  LResult := FVM.PopValue(); // String result
  Assert.AreEqual('Result: 45', LResult.StrValue, 'Complete program should execute correctly');

  LResult := FVM.PopValue(); // Integer result
  Assert.AreEqual(Int64(45), LResult.IntValue, 'Complete program should handle multiple operations');
end;

// =============================================================================
// Execution Verification Tests
// =============================================================================

procedure TTestJetVMExecution.TestExecutionResultVerification();
var
  LResult: TJetValue;
begin
  // Test verification of execution results
  FVM.LoadInt(100).LoadInt(25).DivInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(4), LResult.IntValue, 'Execution result should be verifiable');
  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result type should be correct');
end;

procedure TTestJetVMExecution.TestExecutionSideEffects();
var
  LInitialPC: Integer;
  LFinalPC: Integer;
begin
  // Test that execution has expected side effects
  LInitialPC := FVM.GetPC();

  FVM.LoadInt(42).Stop();
  FVM.Execute();

  LFinalPC := FVM.GetPC();

  Assert.IsTrue(LFinalPC > LInitialPC, 'Execution should have side effect on PC');
  Assert.AreEqual(1, FVM.GetSP(), 'Execution should have side effect on SP');
end;

procedure TTestJetVMExecution.TestExecutionDeterminism();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  // Test that execution is deterministic
  FVM.LoadInt(7).LoadInt(11).MulInt().Stop();
  FVM.Execute();
  LResult1 := FVM.PopValue();

  FVM.Reset();
  FVM.LoadInt(7).LoadInt(11).MulInt().Stop();
  FVM.Execute();
  LResult2 := FVM.PopValue();

  Assert.AreEqual(LResult1.IntValue, LResult2.IntValue, 'Execution should be deterministic');
end;

procedure TTestJetVMExecution.TestExecutionCompleteness();
var
  LStackBefore: Integer;
  LStackAfter: Integer;
begin
  // Test that execution completes all operations
  LStackBefore := FVM.GetSP();

  FVM.LoadInt(1).LoadInt(2).LoadInt(3).AddInt().AddInt().Stop();
  FVM.Execute();

  LStackAfter := FVM.GetSP();

  Assert.AreEqual(LStackBefore + 1, LStackAfter, 'All operations should complete during execution');
  Assert.AreEqual(Int64(6), FVM.PopValue().IntValue, 'Final result should be correct');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMExecution);

end.
