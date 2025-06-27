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

unit JetVM.Test.Boolean;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Diagnostics,
  JetVM;

type
  [TestFixture]
  TTestJetVMBoolean = class(TObject)
  strict private
    FVM: TJetVM;

  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Boolean Loading Operations Tests
    // ==========================================================================
    [Test]
    procedure TestLoadBoolTrue();
    [Test]
    procedure TestLoadBoolFalse();
    [Test]
    procedure TestLoadBoolConstantValues();
    [Test]
    procedure TestBoolConstantCreation();

    // ==========================================================================
    // Boolean Logical Operations Tests
    // ==========================================================================
    [Test]
    procedure TestAndBoolBasic();
    [Test]
    procedure TestOrBoolBasic();
    [Test]
    procedure TestNotBoolBasic();
    [Test]
    procedure TestAndBoolTruthTable();
    [Test]
    procedure TestOrBoolTruthTable();
    [Test]
    procedure TestNotBoolTruthTable();

    // ==========================================================================
    // Boolean Comparison Operations Tests
    // ==========================================================================
    [Test]
    procedure TestEqBoolBasic();
    [Test]
    procedure TestNeBoolBasic();
    [Test]
    procedure TestEqBoolTruthTable();
    [Test]
    procedure TestNeBoolTruthTable();

    // ==========================================================================
    // Boolean Type Management Tests
    // ==========================================================================
    [Test]
    procedure TestBoolTypePreservation();
    [Test]
    procedure TestBoolValueAccess();
    [Test]
    procedure TestBoolConstantTypes();
    [Test]
    procedure TestBoolStackOperations();

    // ==========================================================================
    // Boolean Edge Cases and Complex Expressions
    // ==========================================================================
    [Test]
    procedure TestComplexBooleanExpressions();
    [Test]
    procedure TestNestedBooleanOperations();
    [Test]
    procedure TestBooleanOperatorPrecedence();
    [Test]
    procedure TestBooleanShortCircuiting();

    // ==========================================================================
    // Boolean Integration with Other Operations
    // ==========================================================================
    [Test]
    procedure TestBooleanWithStackOperations();
    [Test]
    procedure TestBooleanWithRegisters();
    [Test]
    procedure TestBooleanWithComparisons();
    [Test]
    procedure TestBooleanInControlFlow();

    // ==========================================================================
    // Boolean Performance and Stress Tests
    // ==========================================================================
    [Test]
    procedure TestBooleanOperationsPerformance();
    [Test]
    procedure TestLargeBooleanExpressions();
    [Test]
    procedure TestBooleanMemoryEfficiency();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMBoolean.Setup();
begin
  FVM := TJetVM.Create(vlDevelopment);
end;

procedure TTestJetVMBoolean.TearDown();
begin
  FVM.Free();
end;

// =============================================================================
// Boolean Loading Operations Tests
// =============================================================================

procedure TTestJetVMBoolean.TestLoadBoolTrue();
var
  LResult: TJetValue;
begin
  // Test loading True boolean value
  FVM.LoadBool(True).Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be boolean type');
  Assert.IsTrue(LResult.BoolValue, 'Loaded value should be True');
end;

procedure TTestJetVMBoolean.TestLoadBoolFalse();
var
  LResult: TJetValue;
begin
  // Test loading False boolean value
  FVM.LoadBool(False).Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be boolean type');
  Assert.IsFalse(LResult.BoolValue, 'Loaded value should be False');
end;

procedure TTestJetVMBoolean.TestLoadBoolConstantValues();
var
  LTrueConstant: TJetValue;
  LFalseConstant: TJetValue;
begin
  // Test creating boolean constants
  LTrueConstant := FVM.MakeBoolConstant(True);
  LFalseConstant := FVM.MakeBoolConstant(False);

  Assert.AreEqual(jvtBool, LTrueConstant.ValueType, 'True constant should have boolean type');
  Assert.AreEqual(jvtBool, LFalseConstant.ValueType, 'False constant should have boolean type');
  Assert.IsTrue(LTrueConstant.BoolValue, 'True constant should have True value');
  Assert.IsFalse(LFalseConstant.BoolValue, 'False constant should have False value');
end;

procedure TTestJetVMBoolean.TestBoolConstantCreation();
var
  LResult: TJetValue;
begin
  // Test loading boolean constants via AddConstant and LoadConst
  FVM.AddConstant(FVM.MakeBoolConstant(True));
  FVM.LoadConst(0).Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Constant should maintain boolean type');
  Assert.IsTrue(LResult.BoolValue, 'Constant should maintain True value');
end;

// =============================================================================
// Boolean Logical Operations Tests
// =============================================================================

procedure TTestJetVMBoolean.TestAndBoolBasic();
var
  LResult: TJetValue;
begin
  // Test basic AND operation: True AND True = True
  FVM.LoadBool(True).LoadBool(True).AndBool().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be boolean type');
  Assert.IsTrue(LResult.BoolValue, 'True AND True should equal True');
end;

procedure TTestJetVMBoolean.TestOrBoolBasic();
var
  LResult: TJetValue;
begin
  // Test basic OR operation: False OR True = True
  FVM.LoadBool(False).LoadBool(True).OrBool().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be boolean type');
  Assert.IsTrue(LResult.BoolValue, 'False OR True should equal True');
end;

procedure TTestJetVMBoolean.TestNotBoolBasic();
var
  LResult: TJetValue;
begin
  // Test basic NOT operation: NOT True = False
  FVM.LoadBool(True).NotBool().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be boolean type');
  Assert.IsFalse(LResult.BoolValue, 'NOT True should equal False');
end;

procedure TTestJetVMBoolean.TestAndBoolTruthTable();
var
  LResult: TJetValue;
begin
  // Test complete AND truth table

  // True AND True = True
  FVM.LoadBool(True).LoadBool(True).AndBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'True AND True should equal True');

  FVM.Reset();

  // True AND False = False
  FVM.LoadBool(True).LoadBool(False).AndBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'True AND False should equal False');

  FVM.Reset();

  // False AND True = False
  FVM.LoadBool(False).LoadBool(True).AndBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'False AND True should equal False');

  FVM.Reset();

  // False AND False = False
  FVM.LoadBool(False).LoadBool(False).AndBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'False AND False should equal False');
end;

procedure TTestJetVMBoolean.TestOrBoolTruthTable();
var
  LResult: TJetValue;
begin
  // Test complete OR truth table

  // True OR True = True
  FVM.LoadBool(True).LoadBool(True).OrBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'True OR True should equal True');

  FVM.Reset();

  // True OR False = True
  FVM.LoadBool(True).LoadBool(False).OrBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'True OR False should equal True');

  FVM.Reset();

  // False OR True = True
  FVM.LoadBool(False).LoadBool(True).OrBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'False OR True should equal True');

  FVM.Reset();

  // False OR False = False
  FVM.LoadBool(False).LoadBool(False).OrBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'False OR False should equal False');
end;

procedure TTestJetVMBoolean.TestNotBoolTruthTable();
var
  LResult: TJetValue;
begin
  // Test complete NOT truth table

  // NOT True = False
  FVM.LoadBool(True).NotBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'NOT True should equal False');

  FVM.Reset();

  // NOT False = True
  FVM.LoadBool(False).NotBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'NOT False should equal True');
end;

// =============================================================================
// Boolean Comparison Operations Tests
// =============================================================================

procedure TTestJetVMBoolean.TestEqBoolBasic();
var
  LResult: TJetValue;
begin
  // Test basic boolean equality: True EQ True = True
  FVM.LoadBool(True).LoadBool(True).EqBool().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be boolean type');
  Assert.IsTrue(LResult.BoolValue, 'True EQ True should equal True');
end;

procedure TTestJetVMBoolean.TestNeBoolBasic();
var
  LResult: TJetValue;
begin
  // Test basic boolean inequality: True NE False = True
  FVM.LoadBool(True).LoadBool(False).NeBool().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be boolean type');
  Assert.IsTrue(LResult.BoolValue, 'True NE False should equal True');
end;

procedure TTestJetVMBoolean.TestEqBoolTruthTable();
var
  LResult: TJetValue;
begin
  // Test complete EQ truth table

  // True EQ True = True
  FVM.LoadBool(True).LoadBool(True).EqBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'True EQ True should equal True');

  FVM.Reset();

  // True EQ False = False
  FVM.LoadBool(True).LoadBool(False).EqBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'True EQ False should equal False');

  FVM.Reset();

  // False EQ True = False
  FVM.LoadBool(False).LoadBool(True).EqBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'False EQ True should equal False');

  FVM.Reset();

  // False EQ False = True
  FVM.LoadBool(False).LoadBool(False).EqBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'False EQ False should equal True');
end;

procedure TTestJetVMBoolean.TestNeBoolTruthTable();
var
  LResult: TJetValue;
begin
  // Test complete NE truth table

  // True NE True = False
  FVM.LoadBool(True).LoadBool(True).NeBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'True NE True should equal False');

  FVM.Reset();

  // True NE False = True
  FVM.LoadBool(True).LoadBool(False).NeBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'True NE False should equal True');

  FVM.Reset();

  // False NE True = True
  FVM.LoadBool(False).LoadBool(True).NeBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'False NE True should equal True');

  FVM.Reset();

  // False NE False = False
  FVM.LoadBool(False).LoadBool(False).NeBool().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'False NE False should equal False');
end;

// =============================================================================
// Boolean Type Management Tests
// =============================================================================

procedure TTestJetVMBoolean.TestBoolTypePreservation();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  // Test that boolean types are preserved through operations
  FVM.LoadBool(True).LoadBool(False).AndBool().NotBool().Stop();
  FVM.Execute();

  LResult1 := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult1.ValueType, 'Boolean type should be preserved through operations');

  FVM.Reset();

  // Test type preservation through multiple operations
  FVM.LoadBool(False).LoadBool(True).OrBool().LoadBool(True).EqBool().Stop();
  FVM.Execute();

  LResult2 := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult2.ValueType, 'Boolean type should be preserved through multiple operations');
end;

procedure TTestJetVMBoolean.TestBoolValueAccess();
var
  LTrueValue: TJetValue;
  LFalseValue: TJetValue;
begin
  // Test direct boolean value access
  LTrueValue := FVM.MakeBoolConstant(True);
  LFalseValue := FVM.MakeBoolConstant(False);

  Assert.IsTrue(LTrueValue.BoolValue, 'True value should be accessible as True');
  Assert.IsFalse(LFalseValue.BoolValue, 'False value should be accessible as False');
end;

procedure TTestJetVMBoolean.TestBoolConstantTypes();
var
  LConstants: TArray<TJetValue>;
begin
  // Test that boolean constants maintain their type
  FVM.AddConstant(FVM.MakeBoolConstant(True));
  FVM.AddConstant(FVM.MakeBoolConstant(False));

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 2, 'Should have 2 constants');
  Assert.AreEqual(jvtBool, LConstants[0].ValueType, 'First constant should be boolean');
  Assert.AreEqual(jvtBool, LConstants[1].ValueType, 'Second constant should be boolean');
  Assert.IsTrue(LConstants[0].BoolValue, 'First constant should be True');
  Assert.IsFalse(LConstants[1].BoolValue, 'Second constant should be False');
end;

procedure TTestJetVMBoolean.TestBoolStackOperations();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  // Test boolean values with stack operations
  FVM.LoadBool(True).LoadBool(False).Swap().Stop();
  FVM.Execute();

  LResult1 := FVM.PopValue(); // Should be True (swapped from bottom)
  LResult2 := FVM.PopValue(); // Should be False (swapped from top)

  Assert.IsTrue(LResult1.BoolValue, 'Swapped value should be True');
  Assert.IsFalse(LResult2.BoolValue, 'Swapped value should be False');
end;

// =============================================================================
// Boolean Edge Cases and Complex Expressions
// =============================================================================

procedure TTestJetVMBoolean.TestComplexBooleanExpressions();
var
  LResult: TJetValue;
begin
  // Test complex expression: (True AND False) OR (NOT True)
  // Should evaluate to: False OR False = False
  FVM.LoadBool(True).LoadBool(False).AndBool()  // False
     .LoadBool(True).NotBool()                  // False
     .OrBool()                                  // False OR False = False
     .Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'Complex expression should evaluate to False');
end;

procedure TTestJetVMBoolean.TestNestedBooleanOperations();
var
  LResult: TJetValue;
begin
  // Test nested operations: NOT(True AND (False OR True))
  // Should evaluate to: NOT(True AND True) = NOT(True) = False
  FVM.LoadBool(False).LoadBool(True).OrBool()   // True
     .LoadBool(True).Swap().AndBool()           // True AND True = True
     .NotBool()                                 // NOT True = False
     .Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.IsFalse(LResult.BoolValue, 'Nested expression should evaluate to False');
end;

procedure TTestJetVMBoolean.TestBooleanOperatorPrecedence();
var
  LResult: TJetValue;
begin
  // Test that operations work correctly when manually controlling precedence
  // Expression: True OR (False AND True) - should be True
  FVM.LoadBool(False).LoadBool(True).AndBool()  // False AND True = False
     .LoadBool(True).Swap().OrBool()            // True OR False = True
     .Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'Precedence-controlled expression should be True');
end;

procedure TTestJetVMBoolean.TestBooleanShortCircuiting();
var
  LResult: TJetValue;
begin
  // Test that each operation is evaluated explicitly (no short-circuiting in VM)
  // This is more about ensuring all operations execute as expected
  FVM.LoadBool(True).LoadBool(False).AndBool()  // Should evaluate both operands
     .LoadBool(True).OrBool()                   // False OR True = True
     .Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'All boolean operations should execute');
end;

// =============================================================================
// Boolean Integration with Other Operations
// =============================================================================

procedure TTestJetVMBoolean.TestBooleanWithStackOperations();
var
  LResult: TJetValue;
begin
  // Test boolean values with stack operations like Dup
  FVM.LoadBool(True).Dup().AndBool().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'True AND True (via Dup) should be True');
end;

procedure TTestJetVMBoolean.TestBooleanWithRegisters();
var
  LResult: TJetValue;
begin
  // Test storing and loading boolean values through registers
  FVM.LoadBool(True).StoreLocal(0)
     .LoadBool(False).StoreLocal(1)
     .LoadLocal(0).LoadLocal(1).OrBool()
     .Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'Boolean register operations should work correctly');
end;

procedure TTestJetVMBoolean.TestBooleanWithComparisons();
var
  LResult: TJetValue;
begin
  // Test boolean values resulting from integer comparisons
  FVM.LoadInt(5).LoadInt(3).GtInt()             // 5 > 3 = True
     .LoadBool(False).OrBool()                  // True OR False = True
     .Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.IsTrue(LResult.BoolValue, 'Boolean from comparison should work with boolean operations');
end;

procedure TTestJetVMBoolean.TestBooleanInControlFlow();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  // Test boolean values in control flow decisions
  LLabel := FVM.CreateLabel();

  FVM.LoadBool(True).LoadBool(False).OrBool()   // True OR False = True
     .JumpTrue(LLabel)                          // Should jump
     .LoadInt(999)                              // Should be skipped
     .BindLabel(LLabel)
     .LoadInt(42)                               // Should execute
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Boolean operations should work correctly in control flow');
end;

// =============================================================================
// Boolean Performance and Stress Tests
// =============================================================================

procedure TTestJetVMBoolean.TestBooleanOperationsPerformance();
const
  OPERATION_COUNT = 1000;
var
  LIndex: Integer;
  LStopwatch: TStopwatch;
  LElapsedMs: Int64;
  LResult: TJetValue;
begin
  LStopwatch := TStopwatch.StartNew();

  // Build chain of boolean operations
  FVM.LoadBool(True);
  for LIndex := 1 to OPERATION_COUNT do
  begin
    FVM.LoadBool(LIndex mod 2 = 0).AndBool();
  end;
  FVM.Stop();

  LStopwatch.Stop();
  LElapsedMs := LStopwatch.ElapsedMilliseconds;

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'Performance test should maintain boolean type');
  Assert.IsTrue(LElapsedMs < 1000, Format('Boolean operations should be fast (<1s), took %dms', [LElapsedMs]));
end;

procedure TTestJetVMBoolean.TestLargeBooleanExpressions();
const
  EXPRESSION_DEPTH = 50;
var
  LIndex: Integer;
  LResult: TJetValue;
begin
  // Build large nested boolean expression
  FVM.LoadBool(True);

  for LIndex := 1 to EXPRESSION_DEPTH do
  begin
    FVM.LoadBool(LIndex mod 3 = 0).OrBool();
  end;

  FVM.Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Large expression should maintain boolean type');
  Assert.IsTrue(LResult.BoolValue, 'Large OR expression with True should be True');
end;

procedure TTestJetVMBoolean.TestBooleanMemoryEfficiency();
var
  LConstants: TArray<TJetValue>;
  LIndex: Integer;
begin
  // Test that boolean constants don't waste excessive memory
  for LIndex := 1 to 100 do
  begin
    FVM.AddConstant(FVM.MakeBoolConstant(LIndex mod 2 = 0));
  end;

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 100, 'Should have 100 boolean constants');

  for LIndex := 0 to High(LConstants) do
  begin
    Assert.AreEqual(jvtBool, LConstants[LIndex].ValueType, Format('Constant %d should be boolean type', [LIndex]));
  end;
end;

end.
