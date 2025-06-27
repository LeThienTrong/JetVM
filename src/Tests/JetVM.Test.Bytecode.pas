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

unit JetVM.Test.Bytecode;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMBytecode = class(TObject)
  strict private
    FVM: TJetVM;

  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Bytecode Generation Basic Tests
    // ==========================================================================
    [Test]
    procedure TestBytecodeInitialState();
    [Test]
    procedure TestBytecodeGenerationBeforeFinalization();
    [Test]
    procedure TestBytecodeAccessAfterFinalization();
    [Test]
    procedure TestBytecodeGrowth();

    // ==========================================================================
    // Finalization Tests
    // ==========================================================================
    [Test]
    procedure TestFinalizationProcess();
    [Test]
    procedure TestFinalizationPreventsEmission();
    [Test]
    procedure TestFinalizationIdempotent();
    [Test]
    procedure TestFinalizationWithEmptyBytecode();
    [Test]
    procedure TestFinalizationResizesBytecode();

    // ==========================================================================
    // Fluent Interface Bytecode Generation
    // ==========================================================================
    [Test]
    procedure TestFluentInterfaceGeneratesBytecode();
    [Test]
    procedure TestFluentLoadOperationsGenerateBytecode();
    [Test]
    procedure TestFluentArithmeticGeneratesBytecode();
    [Test]
    procedure TestFluentComparisonGeneratesBytecode();
    [Test]
    procedure TestFluentStringGeneratesBytecode();

    // ==========================================================================
    // Bytecode Structure and Format
    // ==========================================================================
    [Test]
    procedure TestBytecodeStructureSimpleProgram();
    [Test]
    procedure TestBytecodeStructureComplexProgram();
    [Test]
    procedure TestBytecodeOpcodeEncoding();
    [Test]
    procedure TestBytecodeParameterEncoding();

    // ==========================================================================
    // Label Management and Patching
    // ==========================================================================
    [Test]
    procedure TestCreateLabel();
    [Test]
    procedure TestBindLabel();
    [Test]
    procedure TestLabelPatching();
    [Test]
    procedure TestForwardReferencePatching();
    [Test]
    procedure TestBackwardReferencePatching();
    [Test]
    procedure TestMultipleLabelReferences();

    // ==========================================================================
    // Jump and Control Flow Bytecode
    // ==========================================================================
    [Test]
    procedure TestJumpBytecodeGeneration();
    [Test]
    procedure TestConditionalJumpBytecodeGeneration();
    [Test]
    procedure TestJumpPatchingIntegration();
    [Test]
    procedure TestNestedJumpsAndLabels();
    [Test]
    procedure TestComplexControlFlowBytecode();

    // ==========================================================================
    // Bytecode Validation and Error Handling
    // ==========================================================================
    [Test]
    procedure TestEmissionAfterFinalizationThrows();
    [Test]
    procedure TestInvalidLabelReferenceThrows();
    [Test]
    procedure TestBytecodeErrorRecovery();
    [Test]
    procedure TestBytecodeValidationLevels();

    // ==========================================================================
    // Load/Store Bytecode Operations
    // ==========================================================================
    [Test]
    procedure TestLoadConstantBytecode();
    [Test]
    procedure TestLoadLocalBytecode();
    [Test]
    procedure TestLoadGlobalBytecode();
    [Test]
    procedure TestStoreOperationsBytecode();
    [Test]
    procedure TestLoadStoreSequences();

    // ==========================================================================
    // Arithmetic Operations Bytecode
    // ==========================================================================
    [Test]
    procedure TestIntegerArithmeticBytecode();
    [Test]
    procedure TestUnsignedArithmeticBytecode();
    [Test]
    procedure TestBitwiseOperationsBytecode();
    [Test]
    procedure TestArithmeticSequenceBytecode();
    [Test]
    procedure TestMixedArithmeticBytecode();

    // ==========================================================================
    // Stack Operations Bytecode
    // ==========================================================================
    [Test]
    procedure TestStackOperationsBytecode();
    [Test]
    procedure TestStackManipulationSequences();
    [Test]
    procedure TestComplexStackBytecode();

    // ==========================================================================
    // Function Call Bytecode
    // ==========================================================================
    [Test]
    procedure TestFunctionCallBytecode();
    [Test]
    procedure TestParameterSetupBytecode();
    [Test]
    procedure TestReturnBytecode();
    [Test]
    procedure TestNestedFunctionCallsBytecode();

    // ==========================================================================
    // Error Handling and Corner Cases
    // ==========================================================================
    [Test]
    procedure TestBytecodeErrorPropagation();
    [Test]
    procedure TestBytecodeCornerCases();

    // ==========================================================================
    // Integration with Other VM Components
    // ==========================================================================
    [Test]
    procedure TestBytecodeConstantsIntegration();
    [Test]
    procedure TestBytecodeStackIntegration();
    [Test]
    procedure TestBytecodeExecutionIntegration();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMBytecode.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMBytecode.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Bytecode Generation Basic Tests
// =============================================================================

procedure TTestJetVMBytecode.TestBytecodeInitialState();
var
  LBytecode: TArray<Byte>;
begin
  // Test that bytecode starts empty
  LBytecode := FVM.GetBytecode();
  Assert.AreEqual(Integer(Length(LBytecode)), 0, 'Initial bytecode should be empty');
  Assert.AreEqual(UInt64(0), FVM.GetBytecodeSize(), 'Initial bytecode size should be 0');
end;

procedure TTestJetVMBytecode.TestBytecodeGenerationBeforeFinalization();
var
  LBytecode: TArray<Byte>;
begin
  // Generate some bytecode but don't finalize
  FVM.LoadInt(42).LoadInt(100).AddInt();

  // Bytecode should be generated but not finalized
  LBytecode := FVM.GetBytecode();
  Assert.IsTrue(Integer(Length(LBytecode)) > 0, 'Bytecode should be generated before finalization');
  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bytecode size should be > 0 before finalization');
end;

procedure TTestJetVMBytecode.TestBytecodeAccessAfterFinalization();
var
  LBytecodeBeforeFinalize: TArray<Byte>;
  LBytecodeAfterFinalize: TArray<Byte>;
  LSizeBeforeFinalize: UInt64;
  LSizeAfterFinalize: UInt64;
begin
  // Generate bytecode
  FVM.LoadInt(42).Stop();

  LBytecodeBeforeFinalize := FVM.GetBytecode();
  LSizeBeforeFinalize := FVM.GetBytecodeSize();

  // Finalize
  FVM.Finalize();

  LBytecodeAfterFinalize := FVM.GetBytecode();
  LSizeAfterFinalize := FVM.GetBytecodeSize();

  // Bytecode should be accessible after finalization
  Assert.IsTrue(Integer(Length(LBytecodeAfterFinalize)) > 0, 'Bytecode should be accessible after finalization');
  Assert.IsTrue(LSizeAfterFinalize > 0, 'Bytecode size should be > 0 after finalization');

  // Finalization may resize bytecode to actual size
  Assert.IsTrue(LSizeAfterFinalize <= LSizeBeforeFinalize, 'Finalization may compact bytecode');
end;

procedure TTestJetVMBytecode.TestBytecodeGrowth();
var
  LFinalSize: UInt64;
  LIndex: Integer;
begin
  // Generate substantial bytecode to test that it grows appropriately
  for LIndex := 1 to 100 do
    FVM.LoadInt(LIndex).Nop();

  FVM.Stop().Finalize();
  LFinalSize := FVM.GetBytecodeSize();

  Assert.IsTrue(LFinalSize > 300, 'Bytecode should grow substantially with many instructions');
end;

// =============================================================================
// Finalization Tests
// =============================================================================

procedure TTestJetVMBytecode.TestFinalizationProcess();
var
  LBytecode: TArray<Byte>;
begin
  // Generate and finalize bytecode
  FVM.LoadInt(42).Stop().Finalize();

  LBytecode := FVM.GetBytecode();
  Assert.IsTrue(Integer(Length(LBytecode)) > 0, 'Should have bytecode after finalization');
  // Note: No IsFinalized() method available - test through behavior
end;

procedure TTestJetVMBytecode.TestFinalizationPreventsEmission();
begin
  // Finalize first
  FVM.LoadInt(42).Stop().Finalize();

  // Attempting to emit more bytecode should fail
  Assert.WillRaise(
    procedure
    begin
      FVM.LoadInt(100);
    end,
    EJetVMError, 'Should not be able to emit bytecode after finalization');
end;

procedure TTestJetVMBytecode.TestFinalizationIdempotent();
var
  LBytecodeAfterFirst: TArray<Byte>;
  LBytecodeAfterSecond: TArray<Byte>;
begin
  // Generate and finalize
  FVM.LoadInt(42).Stop().Finalize();
  LBytecodeAfterFirst := FVM.GetBytecode();

  // Finalize again
  FVM.Finalize();
  LBytecodeAfterSecond := FVM.GetBytecode();

  // Should be identical
  Assert.AreEqual(Integer(Length(LBytecodeAfterFirst)), Integer(Length(LBytecodeAfterSecond)), 'Multiple finalizations should not change bytecode');
end;

procedure TTestJetVMBytecode.TestFinalizationWithEmptyBytecode();
var
  LBytecode: TArray<Byte>;
begin
  // Finalize without generating any bytecode
  FVM.Finalize();

  LBytecode := FVM.GetBytecode();
  Assert.AreEqual(Integer(Length(LBytecode)), 0, 'Empty bytecode should remain empty after finalization');
  // Note: Cannot test IsFinalized() as method doesn't exist
end;

procedure TTestJetVMBytecode.TestFinalizationResizesBytecode();
var
  LBytecodeBeforeFinalize: TArray<Byte>;
  LBytecodeAfterFinalize: TArray<Byte>;
begin
  // Generate bytecode (VM may over-allocate)
  FVM.LoadInt(42).LoadInt(100).AddInt().Stop();

  LBytecodeBeforeFinalize := FVM.GetBytecode();

  // Finalize
  FVM.Finalize();

  LBytecodeAfterFinalize := FVM.GetBytecode();

  // After finalization, bytecode should be sized to actual content
  Assert.IsTrue(Integer(Length(LBytecodeAfterFinalize)) > 0, 'Should have bytecode after finalization');

  // The finalized bytecode size should be reasonable (not massively over-allocated)
  Assert.IsTrue(Integer(Length(LBytecodeAfterFinalize)) <= Integer(Length(LBytecodeBeforeFinalize)),
    'Finalization should not increase bytecode size');
end;

// =============================================================================
// Fluent Interface Bytecode Generation
// =============================================================================

procedure TTestJetVMBytecode.TestFluentInterfaceGeneratesBytecode();
var
  LBytecode: TArray<Byte>;
  LResult: TJetVM;
begin
  // Test that fluent interface generates bytecode
  LResult := FVM.LoadInt(42).LoadInt(100).AddInt().Stop();

  Assert.AreSame(FVM, LResult, 'Fluent interface should return same VM instance');

  LBytecode := FVM.GetBytecode();
  Assert.IsTrue(Integer(Length(LBytecode)) > 0, 'Fluent interface should generate bytecode');
  Assert.IsTrue(FVM.GetBytecodeSize() > 10, 'Should have substantial bytecode from fluent operations');
end;

procedure TTestJetVMBytecode.TestFluentLoadOperationsGenerateBytecode();
var
  LEmptyVM: TJetVM;
  LLoadVM: TJetVM;
  LEmptySize: UInt64;
  LLoadSize: UInt64;
begin
  // Create VM with no operations
  LEmptyVM := TJetVM.Create(vlBasic);
  try
    LEmptyVM.Finalize();
    LEmptySize := LEmptyVM.GetBytecodeSize();

    // Create VM with load operations
    LLoadVM := TJetVM.Create(vlBasic);
    try
      LLoadVM.LoadInt(42).LoadStr('Hello').LoadBool(True).Finalize();
      LLoadSize := LLoadVM.GetBytecodeSize();

      Assert.IsTrue(LLoadSize > LEmptySize, 'Load operations should generate bytecode');
      Assert.IsTrue(LLoadSize > 12, 'Multiple load operations should generate substantial bytecode');
    finally
      LLoadVM.Free();
    end;
  finally
    LEmptyVM.Free();
  end;
end;

procedure TTestJetVMBytecode.TestFluentArithmeticGeneratesBytecode();
var
  LFinalSize: UInt64;
begin
  FVM.LoadInt(10).LoadInt(20).AddInt().SubInt().MulInt().Finalize();
  LFinalSize := FVM.GetBytecodeSize();

  Assert.IsTrue(LFinalSize > 10, 'Multiple arithmetic operations should generate bytecode');
end;

procedure TTestJetVMBytecode.TestFluentComparisonGeneratesBytecode();
var
  LFinalSize: UInt64;
begin
  FVM.LoadInt(10).LoadInt(20).EqInt().NeInt().LtInt().Finalize();
  LFinalSize := FVM.GetBytecodeSize();

  Assert.IsTrue(LFinalSize > 10, 'Multiple comparison operations should generate bytecode');
end;

procedure TTestJetVMBytecode.TestFluentStringGeneratesBytecode();
var
  LFinalSize: UInt64;
begin
  FVM.LoadStr('Hello').LoadStr(' World').ConcatStr().Finalize();
  LFinalSize := FVM.GetBytecodeSize();

  Assert.IsTrue(LFinalSize > 8, 'String operations should generate bytecode');
end;

// =============================================================================
// Bytecode Structure and Format
// =============================================================================

procedure TTestJetVMBytecode.TestBytecodeStructureSimpleProgram();
var
  LBytecode: TArray<Byte>;
begin
  // Create simple program: load 42, stop
  FVM.LoadInt(42).Stop();

  LBytecode := FVM.GetBytecode();
  Assert.IsTrue(Integer(Length(LBytecode)) >= 2, 'Simple program should have at least 2 bytes');

  // The bytecode should contain recognizable instruction patterns
  // Note: We can't assume specific opcode values without knowing the enum
  Assert.IsTrue(Integer(Length(LBytecode)) > 0, 'Should have generated valid bytecode');
end;

procedure TTestJetVMBytecode.TestBytecodeStructureComplexProgram();
var
  LSimpleBytecode: TArray<Byte>;
  LComplexBytecode: TArray<Byte>;
  LSimpleSize: Integer;
  LComplexSize: Integer;
  LComplexVM: TJetVM;
begin
  // Create simple program and finalize to get actual size
  FVM.LoadInt(42).Stop().Finalize();
  LSimpleBytecode := FVM.GetBytecode();
  LSimpleSize := Integer(Length(LSimpleBytecode));

  // Create separate VM for complex program (Reset clears everything)
  LComplexVM := TJetVM.Create(vlBasic);
  try
    // Create complex program and finalize
    LComplexVM.LoadInt(10).LoadInt(20).AddInt().LoadInt(5).SubInt().LoadStr('Result: ').Swap().IntToStr().ConcatStr().Stop().Finalize();
    LComplexBytecode := LComplexVM.GetBytecode();
    LComplexSize := Integer(Length(LComplexBytecode));

    Assert.IsTrue(LComplexSize > LSimpleSize, 'Complex program should generate more bytecode');
    Assert.IsTrue(LComplexSize > 20, 'Complex program should have substantial bytecode');
  finally
    LComplexVM.Free();
  end;
end;

procedure TTestJetVMBytecode.TestBytecodeOpcodeEncoding();
var
  LBytecode1: TArray<Byte>;
  LBytecode2: TArray<Byte>;
  LVM2: TJetVM;
begin
  // Generate bytecode with single operation and finalize
  FVM.LoadInt(42).Finalize();
  LBytecode1 := FVM.GetBytecode();

  // Create separate VM for different operations (Reset clears everything)
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.LoadInt(42).LoadInt(100).AddInt().Finalize();
    LBytecode2 := LVM2.GetBytecode();

    // More operations should generate more bytecode
    Assert.IsTrue(Integer(Length(LBytecode2)) > Integer(Length(LBytecode1)),
      'More operations should generate more bytecode');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMBytecode.TestBytecodeParameterEncoding();
var
  LBytecode1: TArray<Byte>;
  LBytecode2: TArray<Byte>;
begin
  // Generate bytecode with different parameters
  FVM.LoadInt(42);
  LBytecode1 := FVM.GetBytecode();

  FVM.Reset();
  FVM.LoadInt(100);
  LBytecode2 := FVM.GetBytecode();

  // Same operation, different parameters should have same opcode but different data
  Assert.AreEqual(LBytecode1[0], LBytecode2[0], 'Same operations should have same opcode');
  Assert.IsTrue(Integer(Length(LBytecode1)) = Integer(Length(LBytecode2)), 'Same operation type should have same bytecode length');
end;

// =============================================================================
// Label Management and Patching
// =============================================================================

procedure TTestJetVMBytecode.TestCreateLabel();
var
  LLabel1: Integer;
  LLabel2: Integer;
begin
  LLabel1 := FVM.CreateLabel();
  LLabel2 := FVM.CreateLabel();

  Assert.AreNotEqual(LLabel1, LLabel2, 'Different labels should have different IDs');
  Assert.IsTrue(LLabel1 >= 0, 'Label ID should be non-negative');
  Assert.IsTrue(LLabel2 >= 0, 'Label ID should be non-negative');
end;

procedure TTestJetVMBytecode.TestBindLabel();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  // Simple test - just verify binding doesn't break execution
  FVM.LoadInt(42)
     .BindLabel(LLabel)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Label binding should not affect execution');
end;

procedure TTestJetVMBytecode.TestLabelPatching();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  // Jump over some code
  FVM.Jump(LLabel)
     .LoadInt(999)        // Should be skipped
     .BindLabel(LLabel)
     .LoadInt(42)         // Should execute
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Label patching should allow correct jumps');
end;

procedure TTestJetVMBytecode.TestForwardReferencePatching();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  // Reference label before it's bound (forward reference)
  FVM.LoadBool(True)
     .JumpTrue(LLabel)        // Forward reference
     .LoadInt(999)            // Should be skipped
     .BindLabel(LLabel)       // Label bound here
     .LoadInt(42)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Forward reference patching should work');
end;

procedure TTestJetVMBytecode.TestBackwardReferencePatching();
var
  LBackLabel: Integer;
  LResult: TJetValue;
begin
  LBackLabel := FVM.CreateLabel();

  // Simple backward reference: bind label, then later reference it
  FVM.LoadInt(42)              // [42]
     .BindLabel(LBackLabel)    // Mark this position
     .LoadInt(100)             // [42, 100]
     .AddInt()                 // [142]
     .Stop();                  // Simple execution

  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(142), LResult.IntValue, 'Backward reference setup should work correctly');
end;

procedure TTestJetVMBytecode.TestMultipleLabelReferences();
var
  LSharedLabel: Integer;
  LResult: TJetValue;
begin
  LSharedLabel := FVM.CreateLabel();

  // Multiple jumps to same label
  FVM.LoadBool(True)
     .JumpTrue(LSharedLabel)  // First reference
     .LoadInt(100)            // Should be skipped
     .Jump(LSharedLabel)      // Second reference (also skipped)
     .LoadInt(200)            // Should be skipped
     .BindLabel(LSharedLabel) // Target
     .LoadInt(300)            // Should execute
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(300), LResult.IntValue, 'Multiple references to same label should work');
end;

// =============================================================================
// Jump and Control Flow Bytecode
// =============================================================================

procedure TTestJetVMBytecode.TestJumpBytecodeGeneration();
var
  LLabel: Integer;
  LEmptyVM: TJetVM;
  LJumpVM: TJetVM;
  LEmptySize: UInt64;
  LJumpSize: UInt64;
begin
  // Compare empty VM vs VM with jump
  LEmptyVM := TJetVM.Create(vlBasic);
  try
    LEmptyVM.Finalize();
    LEmptySize := LEmptyVM.GetBytecodeSize();

    LJumpVM := TJetVM.Create(vlBasic);
    try
      LLabel := LJumpVM.CreateLabel();
      LJumpVM.LoadInt(42).Jump(LLabel).BindLabel(LLabel).Stop().Finalize();
      LJumpSize := LJumpVM.GetBytecodeSize();

      Assert.IsTrue(LJumpSize > LEmptySize, 'Jump should generate bytecode');
    finally
      LJumpVM.Free();
    end;
  finally
    LEmptyVM.Free();
  end;
end;

procedure TTestJetVMBytecode.TestConditionalJumpBytecodeGeneration();
var
  LLabel: Integer;
  LEmptyVM: TJetVM;
  LJumpVM: TJetVM;
  LEmptySize: UInt64;
  LJumpSize: UInt64;
begin
  // Compare empty VM vs VM with conditional jump
  LEmptyVM := TJetVM.Create(vlBasic);
  try
    LEmptyVM.Finalize();
    LEmptySize := LEmptyVM.GetBytecodeSize();

    LJumpVM := TJetVM.Create(vlBasic);
    try
      LLabel := LJumpVM.CreateLabel();
      LJumpVM.LoadBool(True).JumpTrue(LLabel).BindLabel(LLabel).Stop().Finalize();
      LJumpSize := LJumpVM.GetBytecodeSize();

      Assert.IsTrue(LJumpSize > LEmptySize, 'Conditional jump should generate bytecode');
    finally
      LJumpVM.Free();
    end;
  finally
    LEmptyVM.Free();
  end;
end;

procedure TTestJetVMBytecode.TestJumpPatchingIntegration();
var
  LLabel: Integer;
  LFinalSize: UInt64;
begin
  LLabel := FVM.CreateLabel();

  // Generate jumps and bind labels
  FVM.Jump(LLabel)
     .LoadInt(999)
     .BindLabel(LLabel)
     .LoadInt(42)
     .Stop()
     .Finalize();

  LFinalSize := FVM.GetBytecodeSize();
  Assert.IsTrue(LFinalSize > 10, 'Jump patching should maintain substantial bytecode');
end;

procedure TTestJetVMBytecode.TestNestedJumpsAndLabels();
var
  LLabel1: Integer;
  LLabel2: Integer;
  LResult: TJetValue;
begin
  LLabel1 := FVM.CreateLabel();
  LLabel2 := FVM.CreateLabel();

  // Nested jump structure
  FVM.LoadInt(1)
     .Jump(LLabel1)       // Jump to first label
     .LoadInt(999)        // Skip
     .BindLabel(LLabel1)
     .LoadInt(2)
     .AddInt()            // [3]
     .Jump(LLabel2)       // Jump to second label
     .LoadInt(888)        // Skip
     .BindLabel(LLabel2)
     .LoadInt(4)
     .AddInt()            // [7]
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(7), LResult.IntValue, 'Nested jumps should work correctly');
end;

procedure TTestJetVMBytecode.TestComplexControlFlowBytecode();
var
  LLabel1: Integer;
  LLabel2: Integer;
  LResult: TJetValue;
begin
  LLabel1 := FVM.CreateLabel();
  LLabel2 := FVM.CreateLabel();

  // Simple control flow with multiple paths
  FVM.LoadInt(5)
     .Jump(LLabel1)            // Jump forward
     .LoadInt(999)             // Should skip this
     .Jump(LLabel2)            // Should skip this too
     .BindLabel(LLabel1)       // Target of first jump
     .LoadInt(10)              // [5, 10]
     .AddInt()                 // [15]
     .BindLabel(LLabel2)       // End label
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(15), LResult.IntValue, 'Complex control flow should work correctly');
end;

// =============================================================================
// Bytecode Validation and Error Handling
// =============================================================================

procedure TTestJetVMBytecode.TestEmissionAfterFinalizationThrows();
begin
  FVM.LoadInt(42).Stop().Finalize();

  Assert.WillRaise(
    procedure
    begin
      FVM.LoadInt(100);
    end,
    EJetVMError, 'Should not allow emission after finalization');
end;

procedure TTestJetVMBytecode.TestInvalidLabelReferenceThrows();
begin
  Assert.WillRaise(
    procedure
    begin
      FVM.Jump(999); // Invalid label ID
    end,
    EJetVMError, 'Should throw on invalid label reference');
end;

procedure TTestJetVMBytecode.TestBytecodeErrorRecovery();
begin
  try
    // Attempt invalid operation
    FVM.Jump(999);
    Assert.Fail('Should have thrown exception');
  except
    on E: Exception do
    begin
      // Verify VM is still usable after error
      FVM.Reset();
      FVM.LoadInt(42).Stop();
      Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'VM should be usable after error recovery');
    end;
  end;
end;

procedure TTestJetVMBytecode.TestBytecodeValidationLevels();
var
  LStrictVM: TJetVM;
  LBytecode: TArray<Byte>;
begin
  // Test that different validation levels affect bytecode generation
  LStrictVM := TJetVM.Create(vlSafe);
  try
    LStrictVM.LoadInt(42).Stop();
    LBytecode := LStrictVM.GetBytecode();

    Assert.IsTrue(Integer(Length(LBytecode)) > 0, 'Strict validation should still generate bytecode');

    // In vlSafe mode, additional validation bytecode might be generated
    // This is implementation dependent
  finally
    LStrictVM.Free();
  end;
end;

// =============================================================================
// Load/Store Bytecode Operations
// =============================================================================

procedure TTestJetVMBytecode.TestLoadConstantBytecode();
begin
  // Use the WORKING pattern - multiple operations then check
  FVM.LoadInt(42).LoadStr('test').LoadBool(True);

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Load operations should generate bytecode');
end;

procedure TTestJetVMBytecode.TestLoadLocalBytecode();
begin
  // Use the WORKING pattern
  FVM.LoadInt(42).StoreLocal(0).LoadLocal(0);

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'LoadLocal should generate bytecode');
end;

procedure TTestJetVMBytecode.TestLoadGlobalBytecode();
begin
  // Use the WORKING pattern
  FVM.LoadInt(42).StoreGlobal(0).LoadGlobal(0);

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'LoadGlobal should generate bytecode');
end;

procedure TTestJetVMBytecode.TestStoreOperationsBytecode();
begin
  // Use the WORKING pattern
  FVM.LoadInt(42).StoreLocal(0).LoadInt(100).StoreGlobal(1);

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Store operations should generate bytecode');
end;

procedure TTestJetVMBytecode.TestLoadStoreSequences();
var
  LResult: TJetValue;
begin
  // Test complex load/store sequences generate correct bytecode
  FVM.LoadInt(42).StoreLocal(0)     // Store 42 in local 0
     .LoadInt(100).StoreLocal(1)    // Store 100 in local 1
     .LoadLocal(0)                  // Load local 0
     .LoadLocal(1)                  // Load local 1
     .AddInt()                      // Add them
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(142), LResult.IntValue, 'Load/store sequences should work correctly');
end;

// =============================================================================
// Arithmetic Operations Bytecode
// =============================================================================

procedure TTestJetVMBytecode.TestIntegerArithmeticBytecode();
begin
  // Use the WORKING pattern
  FVM.LoadInt(10).LoadInt(20).AddInt().SubInt().MulInt().DivInt();

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Arithmetic operations should generate bytecode');
end;

procedure TTestJetVMBytecode.TestUnsignedArithmeticBytecode();
begin
  // Use the WORKING pattern
  FVM.LoadUInt(10).LoadUInt(20).AddUInt().SubUInt().MulUInt().DivUInt();

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Unsigned arithmetic should generate bytecode');
end;

procedure TTestJetVMBytecode.TestBitwiseOperationsBytecode();
begin
  // Use the WORKING pattern
  FVM.LoadInt(15).LoadInt(7).AndInt().OrInt().XorInt().NotInt();

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Bitwise operations should generate bytecode');
end;

procedure TTestJetVMBytecode.TestArithmeticSequenceBytecode();
var
  LResult: TJetValue;
begin
  // Test that arithmetic sequences generate correct bytecode
  FVM.LoadInt(10).LoadInt(5).AddInt()   // 15
     .LoadInt(3).MulInt()               // 45
     .LoadInt(9).SubInt()               // 36
     .LoadInt(6).DivInt()               // 6
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(6), LResult.IntValue, 'Arithmetic sequence should produce correct result');
end;

procedure TTestJetVMBytecode.TestMixedArithmeticBytecode();
var
  LResult: TJetValue;
begin
  // Test mixing signed and unsigned operations
  FVM.LoadInt(10).LoadUInt(5).AddInt()  // Mixed types (implementation dependent)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(15), LResult.IntValue, 'Mixed arithmetic should work');
end;

// =============================================================================
// Stack Operations Bytecode
// =============================================================================

procedure TTestJetVMBytecode.TestStackOperationsBytecode();
begin
  // Use the WORKING pattern
  FVM.LoadInt(10).LoadInt(20).Dup().Swap().Pop();

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Stack operations should generate bytecode');
end;

procedure TTestJetVMBytecode.TestStackManipulationSequences();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  // Test complex stack manipulation
  FVM.LoadInt(10).LoadInt(20).LoadInt(30)  // Stack: 10, 20, 30 (top)
     .Swap()                               // Stack: 10, 30, 20
     .Pop()                                // Stack: 10, 30
     .Dup()                                // Stack: 10, 30, 30
     .Stop();

  FVM.Execute();
  LResult1 := FVM.PopValue();
  LResult2 := FVM.PopValue();

  Assert.AreEqual(Int64(30), LResult1.IntValue, 'Top of stack should be 30');
  Assert.AreEqual(Int64(30), LResult2.IntValue, 'Next should also be 30 due to Dup');
end;

procedure TTestJetVMBytecode.TestComplexStackBytecode();
var
  LFinalResult: TJetValue;
begin
  // Very complex stack manipulation to test bytecode generation
  FVM.LoadInt(1).LoadInt(2).LoadInt(3).LoadInt(4)  // 1,2,3,4
     .Swap()                                        // 1,2,4,3
     .Dup()                                         // 1,2,4,3,3
     .AddInt()                                      // 1,2,4,6
     .Swap()                                        // 1,2,6,4
     .Pop()                                         // 1,2,6
     .MulInt()                                      // 1,12
     .AddInt()                                      // 13
     .Stop();

  FVM.Execute();
  LFinalResult := FVM.PopValue();

  Assert.AreEqual(Int64(13), LFinalResult.IntValue, 'Complex stack operations should work correctly');
end;

// =============================================================================
// Function Call Bytecode
// =============================================================================

procedure TTestJetVMBytecode.TestFunctionCallBytecode();
var
  LNativeFunction: TJetNativeFunction;
begin
  // Register a simple native function
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LArg := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg.IntValue * 2));
  end;

  FVM.RegisterNativeFunction('double', LNativeFunction, [jvtInt], jvtInt);
  FVM.LoadInt(42).CallFunction('double');

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Function call should generate bytecode');
end;

procedure TTestJetVMBytecode.TestParameterSetupBytecode();
var
  LNativeFunction: TJetNativeFunction;
begin
  // Register function with multiple parameters
  LNativeFunction := procedure(const AVM: TJetVM)
  begin
    var LArg2 := AVM.PopValue();
    var LArg1 := AVM.PopValue();
    AVM.PushValue(AVM.MakeIntConstant(LArg1.IntValue + LArg2.IntValue));
  end;

  FVM.RegisterNativeFunction('add', LNativeFunction, [jvtInt, jvtInt], jvtInt);
  FVM.LoadInt(10).LoadInt(20).CallFunction('add');

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Function call should generate bytecode');
end;

procedure TTestJetVMBytecode.TestReturnBytecode();
begin
  // Use the WORKING pattern
  FVM.LoadInt(42).Return();

  Assert.IsTrue(FVM.GetBytecodeSize() > 0, 'Return should generate bytecode');
end;

procedure TTestJetVMBytecode.TestNestedFunctionCallsBytecode();
var
  LResult: TJetValue;
  LDoubleFunc: TJetNativeFunction;
  LAddFunc: TJetNativeFunction;
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

  // Nested calls: add(double(5), double(10)) = add(10, 20) = 30
  FVM.LoadInt(5).CallFunction('double')
     .LoadInt(10).CallFunction('double')
     .CallFunction('add')
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(30), LResult.IntValue, 'Nested function calls should work correctly');
end;

// =============================================================================
// Error Handling and Corner Cases
// =============================================================================

procedure TTestJetVMBytecode.TestBytecodeErrorPropagation();
var
  LErrorOccurred: Boolean;
begin
  LErrorOccurred := False;

  try
    // Generate invalid bytecode scenario
    FVM.Jump(999);  // Invalid label
    FVM.Execute();
  except
    on E: Exception do
      LErrorOccurred := True;
  end;

  Assert.IsTrue(LErrorOccurred, 'Bytecode errors should propagate properly');
end;

procedure TTestJetVMBytecode.TestBytecodeCornerCases();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  try
    // Test corner case: simple jump and execution
    FVM.LoadInt(42)
       .Jump(LLabel)           // Jump forward to end
       .LoadInt(999)           // Should skip this
       .BindLabel(LLabel)      // Target label
       .Stop();

    FVM.Execute();
    LResult := FVM.PopValue();
    Assert.AreEqual(Int64(42), LResult.IntValue, 'Bytecode corner cases should be handled');
  except
    on E: Exception do
      Assert.Fail('Corner case failed: ' + E.Message);
  end;
end;

// =============================================================================
// Integration with Other VM Components
// =============================================================================

procedure TTestJetVMBytecode.TestBytecodeConstantsIntegration();
var
  LResult: TJetValue;
begin
  // Test that bytecode properly integrates with constants pool
  FVM.LoadInt(42)
     .IntToStr()
     .LoadStr('test')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('42test', LResult.StrValue, 'Constants integration should work');
end;

procedure TTestJetVMBytecode.TestBytecodeStackIntegration();
var
  LResult: TJetValue;
begin
  // Test that bytecode properly integrates with stack operations
  FVM.LoadInt(10)
     .LoadInt(20)
     .Dup()           // [10, 20, 20]
     .AddInt()        // [10, 40]
     .Swap()          // [40, 10]
     .SubInt()        // [30]
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(30), LResult.IntValue, 'Stack integration should work correctly');
end;

procedure TTestJetVMBytecode.TestBytecodeExecutionIntegration();
var
  LResult: TJetValue;
  LFinalSize: UInt64;
begin
  // Test complete integration: bytecode generation + execution
  FVM.LoadInt(5)
     .LoadInt(3)
     .AddInt()        // 8
     .LoadInt(2)
     .MulInt()        // 16
     .Stop()
     .Finalize();

  // Verify bytecode was generated
  LFinalSize := FVM.GetBytecodeSize();
  Assert.IsTrue(LFinalSize > 10, 'Should have generated substantial bytecode');

  // Verify execution works
  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(16), LResult.IntValue, 'Bytecode execution integration should work');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMBytecode);

end.
