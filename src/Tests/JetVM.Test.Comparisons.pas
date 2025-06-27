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

unit JetVM.Test.Comparisons;

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
  TTestJetVMComparisons = class(TObject)
  strict private
    FVM: TJetVM;

  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Integer Comparison Tests
    // ==========================================================================
    [Test]
    procedure TestIntEqualityComparison();
    [Test]
    procedure TestIntInequalityComparison();
    [Test]
    procedure TestIntLessThanComparison();
    [Test]
    procedure TestIntLessEqualComparison();
    [Test]
    procedure TestIntGreaterThanComparison();
    [Test]
    procedure TestIntGreaterEqualComparison();

    // ==========================================================================
    // Integer Comparison Edge Cases
    // ==========================================================================
    [Test]
    procedure TestIntComparisonEdgeCases();
    [Test]
    procedure TestIntComparisonZero();
    [Test]
    procedure TestIntComparisonNegativeNumbers();
    [Test]
    procedure TestIntComparisonLargeNumbers();

    // ==========================================================================
    // Unsigned Integer Comparison Tests
    // ==========================================================================
    [Test]
    procedure TestUIntEqualityComparison();
    [Test]
    procedure TestUIntInequalityComparison();
    [Test]
    procedure TestUIntLessThanComparison();
    [Test]
    procedure TestUIntLessEqualComparison();
    [Test]
    procedure TestUIntGreaterThanComparison();
    [Test]
    procedure TestUIntGreaterEqualComparison();

    // ==========================================================================
    // Unsigned Integer Comparison Edge Cases
    // ==========================================================================
    [Test]
    procedure TestUIntComparisonEdgeCases();
    [Test]
    procedure TestUIntComparisonZero();
    [Test]
    procedure TestUIntComparisonLargeNumbers();

    // ==========================================================================
    // String Comparison Tests
    // ==========================================================================
    [Test]
    procedure TestStrEqualityComparison();
    [Test]
    procedure TestStrInequalityComparison();
    [Test]
    procedure TestStrLessThanComparison();
    [Test]
    procedure TestStrLessEqualComparison();
    [Test]
    procedure TestStrGreaterThanComparison();
    [Test]
    procedure TestStrGreaterEqualComparison();

    // ==========================================================================
    // String Comparison Edge Cases
    // ==========================================================================
    [Test]
    procedure TestStrComparisonEmptyStrings();
    [Test]
    procedure TestStrComparisonCaseSensitivity();
    [Test]
    procedure TestStrComparisonSpecialCharacters();
    [Test]
    procedure TestStrComparisonUnicodeStrings();

    // ==========================================================================
    // Boolean Comparison Tests
    // ==========================================================================
    [Test]
    procedure TestBoolEqualityComparison();
    [Test]
    procedure TestBoolInequalityComparison();
    [Test]
    procedure TestBoolComparisonAllCombinations();

    // ==========================================================================
    // Comparison Chaining Tests
    // ==========================================================================
    [Test]
    procedure TestComparisonChaining();
    [Test]
    procedure TestMultipleComparisons();
    [Test]
    procedure TestComparisonWithArithmetic();
    [Test]
    procedure TestComparisonWithLogicalOperations();

    // ==========================================================================
    // Comparison Result Usage Tests
    // ==========================================================================
    [Test]
    procedure TestComparisonInConditionalJumps();
    [Test]
    procedure TestComparisonResultStacking();
    [Test]
    procedure TestComparisonResultDuplication();

    // ==========================================================================
    // Mixed Type Comparison Error Tests
    // ==========================================================================
    [Test]
    procedure TestMixedTypeComparisonErrors();
    [Test]
    procedure TestInsufficientStackComparison();
    [Test]
    procedure TestComparisonWithEmptyStack();

    // ==========================================================================
    // Performance and Complex Expression Tests
    // ==========================================================================
    [Test]
    procedure TestLargeScaleComparisons();
    [Test]
    procedure TestComplexComparisonExpressions();
    [Test]
    procedure TestComparisonPerformance();

    // ==========================================================================
    // Integration with Other Operations Tests
    // ==========================================================================
    [Test]
    procedure TestComparisonWithConstants();
    [Test]
    procedure TestComparisonWithStackOperations();
    [Test]
    procedure TestComparisonWithTypeConversions();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMComparisons.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMComparisons.TearDown();
begin
  FVM.Free();
end;

// =============================================================================
// Integer Comparison Tests
// =============================================================================

procedure TTestJetVMComparisons.TestIntEqualityComparison();
var
  LResult: TJetValue;
begin
  // Test equal integers
  FVM.LoadInt(42)
     .LoadInt(42)
     .EqInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'EqInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '42 == 42 should be true');

  // Test unequal integers
  FVM.Reset();
  FVM.LoadInt(42)
     .LoadInt(24)
     .EqInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'EqInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '42 == 24 should be false');
end;

procedure TTestJetVMComparisons.TestIntInequalityComparison();
var
  LResult: TJetValue;
begin
  // Test unequal integers
  FVM.LoadInt(42)
     .LoadInt(24)
     .NeInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'NeInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '42 != 24 should be true');

  // Test equal integers
  FVM.Reset();
  FVM.LoadInt(42)
     .LoadInt(42)
     .NeInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'NeInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '42 != 42 should be false');
end;

procedure TTestJetVMComparisons.TestIntLessThanComparison();
var
  LResult: TJetValue;
begin
  // Test less than
  FVM.LoadInt(10)
     .LoadInt(20)
     .LtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'LtInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '10 < 20 should be true');

  // Test not less than
  FVM.Reset();
  FVM.LoadInt(20)
     .LoadInt(10)
     .LtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'LtInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '20 < 10 should be false');

  // Test equal values
  FVM.Reset();
  FVM.LoadInt(15)
     .LoadInt(15)
     .LtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'LtInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '15 < 15 should be false');
end;

procedure TTestJetVMComparisons.TestIntLessEqualComparison();
var
  LResult: TJetValue;
begin
  // Test less than
  FVM.LoadInt(10)
     .LoadInt(20)
     .LeInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'LeInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '10 <= 20 should be true');

  // Test equal
  FVM.Reset();
  FVM.LoadInt(15)
     .LoadInt(15)
     .LeInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'LeInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '15 <= 15 should be true');

  // Test greater than
  FVM.Reset();
  FVM.LoadInt(20)
     .LoadInt(10)
     .LeInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'LeInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '20 <= 10 should be false');
end;

procedure TTestJetVMComparisons.TestIntGreaterThanComparison();
var
  LResult: TJetValue;
begin
  // Test greater than
  FVM.LoadInt(20)
     .LoadInt(10)
     .GtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'GtInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '20 > 10 should be true');

  // Test not greater than
  FVM.Reset();
  FVM.LoadInt(10)
     .LoadInt(20)
     .GtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'GtInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '10 > 20 should be false');

  // Test equal values
  FVM.Reset();
  FVM.LoadInt(15)
     .LoadInt(15)
     .GtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'GtInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '15 > 15 should be false');
end;

procedure TTestJetVMComparisons.TestIntGreaterEqualComparison();
var
  LResult: TJetValue;
begin
  // Test greater than
  FVM.LoadInt(20)
     .LoadInt(10)
     .GeInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'GeInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '20 >= 10 should be true');

  // Test equal
  FVM.Reset();
  FVM.LoadInt(15)
     .LoadInt(15)
     .GeInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'GeInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '15 >= 15 should be true');

  // Test less than
  FVM.Reset();
  FVM.LoadInt(10)
     .LoadInt(20)
     .GeInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'GeInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '10 >= 20 should be false');
end;

// =============================================================================
// Integer Comparison Edge Cases
// =============================================================================

procedure TTestJetVMComparisons.TestIntComparisonEdgeCases();
var
  LResult: TJetValue;
begin
  // Test maximum positive value
  FVM.LoadInt(High(Int64))
     .LoadInt(High(Int64))
     .EqInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Maximum int64 values should be equal');

  // Test minimum negative value
  FVM.Reset();
  FVM.LoadInt(Low(Int64))
     .LoadInt(Low(Int64))
     .EqInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Minimum int64 values should be equal');

  // Test maximum vs minimum
  FVM.Reset();
  FVM.LoadInt(High(Int64))
     .LoadInt(Low(Int64))
     .GtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Maximum should be greater than minimum');
end;

procedure TTestJetVMComparisons.TestIntComparisonZero();
var
  LResult: TJetValue;
begin
  // Test zero equality
  FVM.LoadInt(0)
     .LoadInt(0)
     .EqInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '0 == 0 should be true');

  // Test positive vs zero
  FVM.Reset();
  FVM.LoadInt(1)
     .LoadInt(0)
     .GtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '1 > 0 should be true');

  // Test negative vs zero
  FVM.Reset();
  FVM.LoadInt(-1)
     .LoadInt(0)
     .LtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '-1 < 0 should be true');
end;

procedure TTestJetVMComparisons.TestIntComparisonNegativeNumbers();
var
  LResult: TJetValue;
begin
  // Test negative vs negative
  FVM.LoadInt(-10)
     .LoadInt(-5)
     .LtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '-10 < -5 should be true');

  // Test negative equality
  FVM.Reset();
  FVM.LoadInt(-42)
     .LoadInt(-42)
     .EqInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '-42 == -42 should be true');

  // Test negative vs positive
  FVM.Reset();
  FVM.LoadInt(-1)
     .LoadInt(1)
     .LtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '-1 < 1 should be true');
end;

procedure TTestJetVMComparisons.TestIntComparisonLargeNumbers();
var
  LResult: TJetValue;
begin
  // Test large numbers
  FVM.LoadInt(1000000000)
     .LoadInt(999999999)
     .GtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '1000000000 > 999999999 should be true');

  // Test very large vs very large
  FVM.Reset();
  FVM.LoadInt(9223372036854775806)  // High(Int64) - 1
     .LoadInt(9223372036854775807)  // High(Int64)
     .LtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Near-maximum values should compare correctly');
end;

// =============================================================================
// Unsigned Integer Comparison Tests
// =============================================================================

procedure TTestJetVMComparisons.TestUIntEqualityComparison();
var
  LResult: TJetValue;
begin
  // Test equal unsigned integers
  FVM.LoadUInt(42)
     .LoadUInt(42)
     .EqUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'EqUInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '42 == 42 should be true');

  // Test unequal unsigned integers
  FVM.Reset();
  FVM.LoadUInt(42)
     .LoadUInt(24)
     .EqUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'EqUInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '42 == 24 should be false');
end;

procedure TTestJetVMComparisons.TestUIntInequalityComparison();
var
  LResult: TJetValue;
begin
  // Test unequal unsigned integers
  FVM.LoadUInt(42)
     .LoadUInt(24)
     .NeUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'NeUInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '42 != 24 should be true');

  // Test equal unsigned integers
  FVM.Reset();
  FVM.LoadUInt(42)
     .LoadUInt(42)
     .NeUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'NeUInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '42 != 42 should be false');
end;

procedure TTestJetVMComparisons.TestUIntLessThanComparison();
var
  LResult: TJetValue;
begin
  // Test less than
  FVM.LoadUInt(10)
     .LoadUInt(20)
     .LtUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'LtUInt should return boolean');
  Assert.IsTrue(LResult.BoolValue, '10 < 20 should be true');

  // Test not less than
  FVM.Reset();
  FVM.LoadUInt(20)
     .LoadUInt(10)
     .LtUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'LtUInt should return boolean');
  Assert.IsFalse(LResult.BoolValue, '20 < 10 should be false');
end;

procedure TTestJetVMComparisons.TestUIntLessEqualComparison();
var
  LResult: TJetValue;
begin
  // Test less than
  FVM.LoadUInt(10)
     .LoadUInt(20)
     .LeUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '10 <= 20 should be true');

  // Test equal
  FVM.Reset();
  FVM.LoadUInt(15)
     .LoadUInt(15)
     .LeUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '15 <= 15 should be true');
end;

procedure TTestJetVMComparisons.TestUIntGreaterThanComparison();
var
  LResult: TJetValue;
begin
  // Test greater than
  FVM.LoadUInt(20)
     .LoadUInt(10)
     .GtUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '20 > 10 should be true');

  // Test not greater than
  FVM.Reset();
  FVM.LoadUInt(10)
     .LoadUInt(20)
     .GtUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsFalse(LResult.BoolValue, '10 > 20 should be false');
end;

procedure TTestJetVMComparisons.TestUIntGreaterEqualComparison();
var
  LResult: TJetValue;
begin
  // Test greater than
  FVM.LoadUInt(20)
     .LoadUInt(10)
     .GeUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '20 >= 10 should be true');

  // Test equal
  FVM.Reset();
  FVM.LoadUInt(15)
     .LoadUInt(15)
     .GeUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '15 >= 15 should be true');
end;

// =============================================================================
// Unsigned Integer Comparison Edge Cases
// =============================================================================

procedure TTestJetVMComparisons.TestUIntComparisonEdgeCases();
var
  LResult: TJetValue;
begin
  // Test maximum value
  FVM.LoadUInt(High(UInt64))
     .LoadUInt(High(UInt64))
     .EqUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Maximum uint64 values should be equal');

  // Test maximum vs zero
  FVM.Reset();
  FVM.LoadUInt(High(UInt64))
     .LoadUInt(0)
     .GtUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Maximum should be greater than zero');
end;

procedure TTestJetVMComparisons.TestUIntComparisonZero();
var
  LResult: TJetValue;
begin
  // Test zero equality
  FVM.LoadUInt(0)
     .LoadUInt(0)
     .EqUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '0 == 0 should be true');

  // Test any value vs zero
  FVM.Reset();
  FVM.LoadUInt(1)
     .LoadUInt(0)
     .GtUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '1 > 0 should be true');
end;

procedure TTestJetVMComparisons.TestUIntComparisonLargeNumbers();
var
  LResult: TJetValue;
begin
  // Test very large numbers
  FVM.LoadUInt(18446744073709551614)  // High(UInt64) - 1
     .LoadUInt(18446744073709551615)  // High(UInt64)
     .LtUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Near-maximum values should compare correctly');
end;

// =============================================================================
// String Comparison Tests
// =============================================================================

procedure TTestJetVMComparisons.TestStrEqualityComparison();
var
  LResult: TJetValue;
begin
  // Test equal strings
  FVM.LoadStr('Hello')
     .LoadStr('Hello')
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'EqStr should return boolean');
  Assert.IsTrue(LResult.BoolValue, 'Identical strings should be equal');

  // Test unequal strings
  FVM.Reset();
  FVM.LoadStr('Hello')
     .LoadStr('World')
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsFalse(LResult.BoolValue, 'Different strings should not be equal');
end;

procedure TTestJetVMComparisons.TestStrInequalityComparison();
var
  LResult: TJetValue;
begin
  // Test unequal strings
  FVM.LoadStr('Hello')
     .LoadStr('World')
     .NeStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Different strings should be not equal');

  // Test equal strings
  FVM.Reset();
  FVM.LoadStr('Hello')
     .LoadStr('Hello')
     .NeStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsFalse(LResult.BoolValue, 'Identical strings should not be not equal');
end;

procedure TTestJetVMComparisons.TestStrLessThanComparison();
var
  LResult: TJetValue;
begin
  // Test lexicographical comparison
  FVM.LoadStr('Apple')
     .LoadStr('Banana')
     .LtStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Apple < Banana should be true');

  // Test reverse order
  FVM.Reset();
  FVM.LoadStr('Zebra')
     .LoadStr('Apple')
     .LtStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsFalse(LResult.BoolValue, 'Zebra < Apple should be false');
end;

procedure TTestJetVMComparisons.TestStrLessEqualComparison();
var
  LResult: TJetValue;
begin
  // Test less than
  FVM.LoadStr('Apple')
     .LoadStr('Banana')
     .LeStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Apple <= Banana should be true');

  // Test equal
  FVM.Reset();
  FVM.LoadStr('Apple')
     .LoadStr('Apple')
     .LeStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Apple <= Apple should be true');
end;

procedure TTestJetVMComparisons.TestStrGreaterThanComparison();
var
  LResult: TJetValue;
begin
  // Test greater than
  FVM.LoadStr('Zebra')
     .LoadStr('Apple')
     .GtStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Zebra > Apple should be true');

  // Test not greater than
  FVM.Reset();
  FVM.LoadStr('Apple')
     .LoadStr('Zebra')
     .GtStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsFalse(LResult.BoolValue, 'Apple > Zebra should be false');
end;

procedure TTestJetVMComparisons.TestStrGreaterEqualComparison();
var
  LResult: TJetValue;
begin
  // Test greater than
  FVM.LoadStr('Zebra')
     .LoadStr('Apple')
     .GeStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Zebra >= Apple should be true');

  // Test equal
  FVM.Reset();
  FVM.LoadStr('Apple')
     .LoadStr('Apple')
     .GeStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Apple >= Apple should be true');
end;

// =============================================================================
// String Comparison Edge Cases
// =============================================================================

procedure TTestJetVMComparisons.TestStrComparisonEmptyStrings();
var
  LResult: TJetValue;
begin
  // Test empty string equality
  FVM.LoadStr('')
     .LoadStr('')
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Empty strings should be equal');

  // Test empty vs non-empty
  FVM.Reset();
  FVM.LoadStr('')
     .LoadStr('Test')
     .LtStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Empty string should be less than non-empty');

  // Test non-empty vs empty
  FVM.Reset();
  FVM.LoadStr('Test')
     .LoadStr('')
     .GtStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Non-empty string should be greater than empty');
end;

procedure TTestJetVMComparisons.TestStrComparisonCaseSensitivity();
var
  LResult: TJetValue;
begin
  // Test case sensitivity
  FVM.LoadStr('Hello')
     .LoadStr('hello')
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsFalse(LResult.BoolValue, 'Case-different strings should not be equal');

  // Test case ordering
  FVM.Reset();
  FVM.LoadStr('A')
     .LoadStr('a')
     .LtStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  // Note: Delphi string comparison depends on locale, but typically 'A' < 'a'
  Assert.IsTrue(LResult.BoolValue, 'Uppercase A should be less than lowercase a');
end;

procedure TTestJetVMComparisons.TestStrComparisonSpecialCharacters();
var
  LResult: TJetValue;
begin
  // Test strings with special characters
  FVM.LoadStr('Hello!')
     .LoadStr('Hello@')
     .LtStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, '! should be less than @');

  // Test strings with numbers
  FVM.Reset();
  FVM.LoadStr('Test1')
     .LoadStr('Test2')
     .LtStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Test1 should be less than Test2');
end;

procedure TTestJetVMComparisons.TestStrComparisonUnicodeStrings();
var
  LResult: TJetValue;
begin
  // Test Unicode strings equality
  FVM.LoadStr('Héllo')
     .LoadStr('Héllo')
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Unicode strings should be equal');

  // Test Unicode vs ASCII
  FVM.Reset();
  FVM.LoadStr('Hello')
     .LoadStr('Héllo')
     .NeStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'ASCII and Unicode strings should be different');
end;

// =============================================================================
// Boolean Comparison Tests
// =============================================================================

procedure TTestJetVMComparisons.TestBoolEqualityComparison();
var
  LResult: TJetValue;
begin
  // Test true == true
  FVM.LoadBool(True)
     .LoadBool(True)
     .EqBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'true == true should be true');

  // Test false == false
  FVM.Reset();
  FVM.LoadBool(False)
     .LoadBool(False)
     .EqBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'false == false should be true');

  // Test true == false
  FVM.Reset();
  FVM.LoadBool(True)
     .LoadBool(False)
     .EqBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsFalse(LResult.BoolValue, 'true == false should be false');
end;

procedure TTestJetVMComparisons.TestBoolInequalityComparison();
var
  LResult: TJetValue;
begin
  // Test true != false
  FVM.LoadBool(True)
     .LoadBool(False)
     .NeBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'true != false should be true');

  // Test true != true
  FVM.Reset();
  FVM.LoadBool(True)
     .LoadBool(True)
     .NeBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsFalse(LResult.BoolValue, 'true != true should be false');
end;

procedure TTestJetVMComparisons.TestBoolComparisonAllCombinations();
type
  TBoolTestCase = record
    LValue1: Boolean;
    LValue2: Boolean;
    LExpectedEq: Boolean;
    LExpectedNe: Boolean;
  end;
const
  TestCases: array[0..3] of TBoolTestCase = (
    (LValue1: True; LValue2: True; LExpectedEq: True; LExpectedNe: False),
    (LValue1: True; LValue2: False; LExpectedEq: False; LExpectedNe: True),
    (LValue1: False; LValue2: True; LExpectedEq: False; LExpectedNe: True),
    (LValue1: False; LValue2: False; LExpectedEq: True; LExpectedNe: False)
  );
var
  LResult: TJetValue;
  LIndex: Integer;
begin

  for LIndex := 0 to 3 do
  begin
    // Test equality
    FVM.Reset();
    FVM.LoadBool(TestCases[LIndex].LValue1)
       .LoadBool(TestCases[LIndex].LValue2)
       .EqBool()
       .Stop();

    FVM.Execute();
    LResult := FVM.PopValue();

    Assert.AreEqual(TestCases[LIndex].LExpectedEq, LResult.BoolValue,
      Format('EqBool case %d: %s == %s should be %s',
        [LIndex, BoolToStr(TestCases[LIndex].LValue1, True),
         BoolToStr(TestCases[LIndex].LValue2, True),
         BoolToStr(TestCases[LIndex].LExpectedEq, True)]));

    // Test inequality
    FVM.Reset();
    FVM.LoadBool(TestCases[LIndex].LValue1)
       .LoadBool(TestCases[LIndex].LValue2)
       .NeBool()
       .Stop();

    FVM.Execute();
    LResult := FVM.PopValue();

    Assert.AreEqual(TestCases[LIndex].LExpectedNe, LResult.BoolValue,
      Format('NeBool case %d: %s != %s should be %s',
        [LIndex, BoolToStr(TestCases[LIndex].LValue1, True),
         BoolToStr(TestCases[LIndex].LValue2, True),
         BoolToStr(TestCases[LIndex].LExpectedNe, True)]));
  end;
end;

// =============================================================================
// Comparison Chaining Tests
// =============================================================================

procedure TTestJetVMComparisons.TestComparisonChaining();
var
  LResult: TJetValue;
begin
  // Test chained comparisons: (10 > 5) && (5 > 1)
  FVM.LoadInt(10)
     .LoadInt(5)
     .GtInt()           // true
     .LoadInt(5)
     .LoadInt(1)
     .GtInt()           // true
     .AndBool()         // true && true = true
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Chained greater-than comparisons should work');

  // Test failing chain: (10 > 5) && (1 > 5)
  FVM.Reset();
  FVM.LoadInt(10)
     .LoadInt(5)
     .GtInt()           // true
     .LoadInt(1)
     .LoadInt(5)
     .GtInt()           // false
     .AndBool()         // true && false = false
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsFalse(LResult.BoolValue, 'Mixed chained comparisons should work');
end;

procedure TTestJetVMComparisons.TestMultipleComparisons();
var
  LResult: TJetValue;
begin
  // Test multiple different comparisons in sequence
  FVM.LoadInt(10)
     .LoadInt(10)
     .EqInt()           // true
     .LoadStr('Hello')
     .LoadStr('World')
     .NeStr()           // true
     .AndBool()         // true && true = true
     .LoadBool(True)
     .LoadBool(True)
     .EqBool()          // true
     .AndBool()         // true && true = true
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Multiple different comparison types should work');
end;

procedure TTestJetVMComparisons.TestComparisonWithArithmetic();
var
  LResult: TJetValue;
begin
  // Test comparison with arithmetic results: (5 + 3) > (2 * 3)
  FVM.LoadInt(5)
     .LoadInt(3)
     .AddInt()          // 8
     .LoadInt(2)
     .LoadInt(3)
     .MulInt()          // 6
     .GtInt()           // 8 > 6 = true
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Comparison with arithmetic should work');

  // Test more complex expression: ((10 - 5) * 2) == (4 + 6)
  FVM.Reset();
  FVM.LoadInt(10)
     .LoadInt(5)
     .SubInt()          // 5
     .LoadInt(2)
     .MulInt()          // 10
     .LoadInt(4)
     .LoadInt(6)
     .AddInt()          // 10
     .EqInt()           // 10 == 10 = true
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Complex arithmetic comparison should work');
end;

procedure TTestJetVMComparisons.TestComparisonWithLogicalOperations();
var
  LResult: TJetValue;
begin
  // Test comparison combined with logical operations
  FVM.LoadBool(True)
     .LoadBool(False)
     .OrBool()          // true || false = true
     .LoadBool(True)
     .EqBool()          // true == true = true
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Comparison with logical operations should work');

  // Test negation with comparison
  FVM.Reset();
  FVM.LoadInt(5)
     .LoadInt(10)
     .GtInt()           // false
     .NotBool()         // !false = true
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Negated comparison should work');
end;

// =============================================================================
// Comparison Result Usage Tests
// =============================================================================

procedure TTestJetVMComparisons.TestComparisonInConditionalJumps();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  // Test using comparison result for conditional jump
  FVM.LoadInt(10)
     .LoadInt(5)
     .GtInt()           // true
     .JumpTrue(LLabel)  // Should jump
     .LoadInt(999)      // Should skip
     .BindLabel(LLabel)
     .LoadInt(42)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Conditional jump with comparison should work');
end;

procedure TTestJetVMComparisons.TestComparisonResultStacking();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  // Test stacking multiple comparison results
  FVM.LoadInt(10)
     .LoadInt(5)
     .GtInt()           // true
     .LoadInt(3)
     .LoadInt(7)
     .LtInt()           // true
     .Stop();

  FVM.Execute();

  // Pop both results
  LResult1 := FVM.PopValue();
  LResult2 := FVM.PopValue();

  Assert.IsTrue(LResult1.BoolValue, 'First comparison result should be true');
  Assert.IsTrue(LResult2.BoolValue, 'Second comparison result should be true');
end;

procedure TTestJetVMComparisons.TestComparisonResultDuplication();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  // Test duplicating comparison results
  FVM.LoadInt(10)
     .LoadInt(5)
     .GtInt()           // true
     .Dup()             // duplicate the result
     .Stop();

  FVM.Execute();

  // Pop both copies
  LResult1 := FVM.PopValue();
  LResult2 := FVM.PopValue();

  Assert.IsTrue(LResult1.BoolValue, 'First copy should be true');
  Assert.IsTrue(LResult2.BoolValue, 'Second copy should be true');
end;

// =============================================================================
// Mixed Type Comparison Error Tests
// =============================================================================

procedure TTestJetVMComparisons.TestMixedTypeComparisonErrors();
begin
  // Test integer comparison with insufficient stack should raise error in development mode
  FVM.Free();
  FVM := TJetVM.Create(vlDevelopment);

  Assert.WillRaise(
    procedure begin
      FVM.LoadInt(42)   // Only one value
         .EqInt()       // Needs two values
         .Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'Integer comparison with insufficient stack should raise error'
  );

  // Test string comparison with insufficient stack
  Assert.WillRaise(
    procedure begin
      FVM.Reset();
      FVM.LoadStr('Test') // Only one value
         .EqStr()         // Needs two values
         .Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'String comparison with insufficient stack should raise error'
  );
end;

procedure TTestJetVMComparisons.TestInsufficientStackComparison();
begin
  // Switch to development mode for stack validation
  FVM.Free();
  FVM := TJetVM.Create(vlDevelopment);

  Assert.WillRaise(
    procedure begin
      FVM.EqInt()       // No values on stack
         .Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'Comparison with empty stack should raise error'
  );
end;

procedure TTestJetVMComparisons.TestComparisonWithEmptyStack();
begin
  // Test all comparison operations with empty stack in development mode
  FVM.Free();
  FVM := TJetVM.Create(vlDevelopment);

  Assert.WillRaise(
    procedure begin
      FVM.LtInt().Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'LtInt with empty stack should raise error'
  );

  Assert.WillRaise(
    procedure begin
      FVM.Reset();
      FVM.GeUInt().Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'GeUInt with empty stack should raise error'
  );

  Assert.WillRaise(
    procedure begin
      FVM.Reset();
      FVM.NeStr().Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'NeStr with empty stack should raise error'
  );
end;

// =============================================================================
// Performance and Complex Expression Tests
// =============================================================================

procedure TTestJetVMComparisons.TestLargeScaleComparisons();
const
  COMPARISON_COUNT = 1000;
var
  LIndex: Integer;
  LResult: TJetValue;
  LExpectedResult: Boolean;
begin
  // Build large chain of comparisons
  LExpectedResult := True;

  FVM.LoadBool(True);

  for LIndex := 1 to COMPARISON_COUNT do
  begin
    FVM.LoadInt(LIndex)
       .LoadInt(LIndex)
       .EqInt()           // Each comparison returns true
       .AndBool();        // Chain with AND
  end;

  FVM.Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(LExpectedResult, LResult.BoolValue,
    Format('Large scale comparison chain (%d comparisons) should work', [COMPARISON_COUNT]));
end;

procedure TTestJetVMComparisons.TestComplexComparisonExpressions();
var
  LResult: TJetValue;
begin
  // Test complex expression: ((a > b) && (c == d)) || ((e < f) && (g != h))
  // Let: a=10, b=5, c=7, d=7, e=3, f=8, g=1, h=2
  // Expected: ((true) && (true)) || ((true) && (true)) = true

  FVM.LoadInt(10)        // a
     .LoadInt(5)         // b
     .GtInt()            // a > b = true
     .LoadInt(7)         // c
     .LoadInt(7)         // d
     .EqInt()            // c == d = true
     .AndBool()          // (a > b) && (c == d) = true
     .LoadInt(3)         // e
     .LoadInt(8)         // f
     .LtInt()            // e < f = true
     .LoadInt(1)         // g
     .LoadInt(2)         // h
     .NeInt()            // g != h = true
     .AndBool()          // (e < f) && (g != h) = true
     .OrBool()           // left || right = true
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Complex comparison expression should evaluate correctly');
end;

procedure TTestJetVMComparisons.TestComparisonPerformance();
const
  PERFORMANCE_ITERATIONS = 10000;
var
  LIndex: Integer;
  LResult: TJetValue;
  LStopwatch: TStopwatch;
  LElapsedMs: Int64;
begin
  LStopwatch := TStopwatch.StartNew();

  // Perform many comparison operations
  for LIndex := 1 to PERFORMANCE_ITERATIONS do
  begin
    FVM.Reset();
    FVM.LoadInt(LIndex)
       .LoadInt(LIndex div 2)
       .GtInt()
       .Stop();

    FVM.Execute();
    LResult := FVM.PopValue();

    // Verify result is correct
    Assert.AreEqual(LIndex > (LIndex div 2), LResult.BoolValue,
      Format('Performance test iteration %d should be correct', [LIndex]));
  end;

  LStopwatch.Stop();
  LElapsedMs := LStopwatch.ElapsedMilliseconds;

  // Performance should be reasonable (less than 5 seconds for 10000 iterations)
  Assert.IsTrue(LElapsedMs < 5000,
    Format('Performance test should complete in reasonable time (took %dms)', [LElapsedMs]));
end;

// =============================================================================
// Integration with Other Operations Tests
// =============================================================================

procedure TTestJetVMComparisons.TestComparisonWithConstants();
var
  LResult: TJetValue;
begin
  // Add constants and use them in comparisons
  FVM.AddConstant(FVM.MakeIntConstant(42));

  FVM.LoadConst(0)  // First constant is at index 0
     .LoadInt(42)
     .EqInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Comparison with constants should work');

  // Test string constant comparison
  FVM.Reset();
  FVM.AddConstant(FVM.MakeStrConstant('Hello'));

  FVM.LoadConst(0)  // First constant is at index 0
     .LoadStr('Hello')
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'String constant comparison should work');
end;

procedure TTestJetVMComparisons.TestComparisonWithStackOperations();
var
  LResult: TJetValue;
begin
  // Test comparison with stack manipulation
  FVM.LoadInt(10)
     .LoadInt(20)
     .Dup()             // [10, 20, 20]
     .LoadInt(20)
     .EqInt()           // [10, 20, true]
     .Swap()            // [10, true, 20]
     .LoadInt(10)
     .EqInt()           // [10, true, false]
     .OrBool()          // [10, true]
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Comparison with stack operations should work');
  Assert.AreEqual(Int64(10), FVM.PopValue().IntValue, 'Stack should maintain other values');
end;

procedure TTestJetVMComparisons.TestComparisonWithTypeConversions();
var
  LResult: TJetValue;
begin
  // Test comparison with type conversion
  FVM.LoadInt(42)
     .IntToStr()
     .LoadStr('42')
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Comparison with type conversion should work');

  // Test boolean to string comparison
  FVM.Reset();
  FVM.LoadBool(True)
     .BoolToStr()
     .LoadStr('True')
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.IsTrue(LResult.BoolValue, 'Boolean to string comparison should work');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMComparisons);

end.
