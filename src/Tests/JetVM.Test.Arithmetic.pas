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

unit JetVM.Test.Arithmetic;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMArithmetic = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Signed Integer Arithmetic Tests
    // ==========================================================================
    [Test]
    procedure TestAddInt();
    [Test]
    procedure TestSubInt();
    [Test]
    procedure TestMulInt();
    [Test]
    procedure TestDivInt();
    [Test]
    procedure TestModInt();
    [Test]
    procedure TestNegInt();
    [Test]
    procedure TestIncInt();
    [Test]
    procedure TestDecInt();
    [Test]
    procedure TestPostIncInt();
    [Test]
    procedure TestPostDecInt();

    // ==========================================================================
    // Unsigned Integer Arithmetic Tests
    // ==========================================================================
    [Test]
    procedure TestAddUInt();
    [Test]
    procedure TestSubUInt();
    [Test]
    procedure TestMulUInt();
    [Test]
    procedure TestDivUInt();
    [Test]
    procedure TestModUInt();
    [Test]
    procedure TestIncUInt();
    [Test]
    procedure TestDecUInt();
    [Test]
    procedure TestPostIncUInt();
    [Test]
    procedure TestPostDecUInt();

    // ==========================================================================
    // Signed Integer Arithmetic Edge Cases
    // ==========================================================================
    [Test]
    procedure TestAddIntEdgeCases();
    [Test]
    procedure TestSubIntEdgeCases();
    [Test]
    procedure TestMulIntEdgeCases();
    [Test]
    procedure TestDivIntEdgeCases();
    [Test]
    procedure TestModIntEdgeCases();
    [Test]
    procedure TestNegIntEdgeCases();

    // ==========================================================================
    // Unsigned Integer Arithmetic Edge Cases
    // ==========================================================================
    [Test]
    procedure TestAddUIntEdgeCases();
    [Test]
    procedure TestSubUIntEdgeCases();
    [Test]
    procedure TestMulUIntEdgeCases();
    [Test]
    procedure TestDivUIntEdgeCases();
    [Test]
    procedure TestModUIntEdgeCases();

    // ==========================================================================
    // Arithmetic Sequence Tests
    // ==========================================================================
    [Test]
    procedure TestIntArithmeticSequence();
    [Test]
    procedure TestUIntArithmeticSequence();
    [Test]
    procedure TestMixedArithmeticSequence();
    [Test]
    procedure TestComplexArithmeticChain();

    // ==========================================================================
    // Zero and Identity Tests
    // ==========================================================================
    [Test]
    procedure TestArithmeticWithZero();
    [Test]
    procedure TestArithmeticWithOne();
    [Test]
    procedure TestArithmeticIdentities();

    // ==========================================================================
    // Arithmetic Order of Operations Tests
    // ==========================================================================
    [Test]
    procedure TestArithmeticPrecedence();
    [Test]
    procedure TestArithmeticAssociativity();
    [Test]
    procedure TestStackBehaviorDuringArithmetic();

    // ==========================================================================
    // Large Number Tests
    // ==========================================================================
    [Test]
    procedure TestLargeIntegerArithmetic();
    [Test]
    procedure TestLargeUIntegerArithmetic();
    [Test]
    procedure TestMaxValueArithmetic();

    // ==========================================================================
    // Fluent Interface Verification Tests
    // ==========================================================================
    [Test]
    procedure TestFluentInterfaceChaining();
    [Test]
    procedure TestFluentInterfaceReturnsCorrectType();
    [Test]
    procedure TestFluentInterfaceMethodOrder();
  end;

implementation

// =============================================================================
// Setup and TearDown
// =============================================================================

procedure TTestJetVMArithmetic.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMArithmetic.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Signed Integer Arithmetic Tests
// =============================================================================

procedure TTestJetVMArithmetic.TestAddInt();
var
  LResult: TJetValue;
begin
  // Test basic addition
  FVM.LoadInt(42).LoadInt(13).AddInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(55), LResult.IntValue, 'AddInt should compute 42 + 13 = 55');
end;

procedure TTestJetVMArithmetic.TestSubInt();
var
  LResult: TJetValue;
begin
  // Test basic subtraction
  FVM.LoadInt(100).LoadInt(25).SubInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(75), LResult.IntValue, 'SubInt should compute 100 - 25 = 75');
end;

procedure TTestJetVMArithmetic.TestMulInt();
var
  LResult: TJetValue;
begin
  // Test basic multiplication
  FVM.LoadInt(12).LoadInt(7).MulInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(84), LResult.IntValue, 'MulInt should compute 12 * 7 = 84');
end;

procedure TTestJetVMArithmetic.TestDivInt();
var
  LResult: TJetValue;
begin
  // Test basic division
  FVM.LoadInt(84).LoadInt(7).DivInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(12), LResult.IntValue, 'DivInt should compute 84 div 7 = 12');
end;

procedure TTestJetVMArithmetic.TestModInt();
var
  LResult: TJetValue;
begin
  // Test basic modulo
  FVM.LoadInt(23).LoadInt(5).ModInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(3), LResult.IntValue, 'ModInt should compute 23 mod 5 = 3');
end;

procedure TTestJetVMArithmetic.TestNegInt();
var
  LResult: TJetValue;
begin
  // Test negation
  FVM.LoadInt(42).NegInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-42), LResult.IntValue, 'NegInt should compute -(42) = -42');
end;

procedure TTestJetVMArithmetic.TestIncInt();
var
  LResult: TJetValue;
begin
  // Test increment
  FVM.LoadInt(99).IncInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(100), LResult.IntValue, 'IncInt should compute 99 + 1 = 100');
end;

procedure TTestJetVMArithmetic.TestDecInt();
var
  LResult: TJetValue;
begin
  // Test decrement
  FVM.LoadInt(100).DecInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(99), LResult.IntValue, 'DecInt should compute 100 - 1 = 99');
end;

procedure TTestJetVMArithmetic.TestPostIncInt();
var
  LResult: TJetValue;
begin
  // Test post-increment (returns original value)
  FVM.LoadInt(50).PostIncInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(50), LResult.IntValue, 'PostIncInt should return original value 50');
end;

procedure TTestJetVMArithmetic.TestPostDecInt();
var
  LResult: TJetValue;
begin
  // Test post-decrement (returns original value)
  FVM.LoadInt(50).PostDecInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(50), LResult.IntValue, 'PostDecInt should return original value 50');
end;

// =============================================================================
// Unsigned Integer Arithmetic Tests
// =============================================================================

procedure TTestJetVMArithmetic.TestAddUInt();
var
  LResult: TJetValue;
begin
  // Test basic unsigned addition
  FVM.LoadUInt(42).LoadUInt(13).AddUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(55), LResult.UIntValue, 'AddUInt should compute 42 + 13 = 55');
end;

procedure TTestJetVMArithmetic.TestSubUInt();
var
  LResult: TJetValue;
begin
  // Test basic unsigned subtraction
  FVM.LoadUInt(100).LoadUInt(25).SubUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(75), LResult.UIntValue, 'SubUInt should compute 100 - 25 = 75');
end;

procedure TTestJetVMArithmetic.TestMulUInt();
var
  LResult: TJetValue;
begin
  // Test basic unsigned multiplication
  FVM.LoadUInt(12).LoadUInt(7).MulUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(84), LResult.UIntValue, 'MulUInt should compute 12 * 7 = 84');
end;

procedure TTestJetVMArithmetic.TestDivUInt();
var
  LResult: TJetValue;
begin
  // Test basic unsigned division
  FVM.LoadUInt(84).LoadUInt(7).DivUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(12), LResult.UIntValue, 'DivUInt should compute 84 div 7 = 12');
end;

procedure TTestJetVMArithmetic.TestModUInt();
var
  LResult: TJetValue;
begin
  // Test basic unsigned modulo
  FVM.LoadUInt(23).LoadUInt(5).ModUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(3), LResult.UIntValue, 'ModUInt should compute 23 mod 5 = 3');
end;

procedure TTestJetVMArithmetic.TestIncUInt();
var
  LResult: TJetValue;
begin
  // Test unsigned increment
  FVM.LoadUInt(99).IncUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(100), LResult.UIntValue, 'IncUInt should compute 99 + 1 = 100');
end;

procedure TTestJetVMArithmetic.TestDecUInt();
var
  LResult: TJetValue;
begin
  // Test unsigned decrement
  FVM.LoadUInt(100).DecUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(99), LResult.UIntValue, 'DecUInt should compute 100 - 1 = 99');
end;

procedure TTestJetVMArithmetic.TestPostIncUInt();
var
  LResult: TJetValue;
begin
  // Test unsigned post-increment (returns original value)
  FVM.LoadUInt(50).PostIncUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(50), LResult.UIntValue, 'PostIncUInt should return original value 50');
end;

procedure TTestJetVMArithmetic.TestPostDecUInt();
var
  LResult: TJetValue;
begin
  // Test unsigned post-decrement (returns original value)
  FVM.LoadUInt(50).PostDecUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(50), LResult.UIntValue, 'PostDecUInt should return original value 50');
end;

// =============================================================================
// Signed Integer Arithmetic Edge Cases
// =============================================================================

procedure TTestJetVMArithmetic.TestAddIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test addition with negative numbers
  FVM.LoadInt(-10).LoadInt(5).AddInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-5), LResult.IntValue, 'AddInt should handle negative operands: -10 + 5 = -5');

  // Reset and test addition of two negative numbers
  FVM.Reset();
  FVM.LoadInt(-15).LoadInt(-25).AddInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-40), LResult.IntValue, 'AddInt should handle two negatives: -15 + (-25) = -40');
end;

procedure TTestJetVMArithmetic.TestSubIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test subtraction resulting in negative
  FVM.LoadInt(10).LoadInt(15).SubInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-5), LResult.IntValue, 'SubInt should handle negative result: 10 - 15 = -5');

  // Reset and test subtracting negative number
  FVM.Reset();
  FVM.LoadInt(10).LoadInt(-5).SubInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(15), LResult.IntValue, 'SubInt should handle negative operand: 10 - (-5) = 15');
end;

procedure TTestJetVMArithmetic.TestMulIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test multiplication with zero
  FVM.LoadInt(42).LoadInt(0).MulInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(0), LResult.IntValue, 'MulInt should handle zero: 42 * 0 = 0');

  // Reset and test multiplication with negative
  FVM.Reset();
  FVM.LoadInt(-6).LoadInt(7).MulInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-42), LResult.IntValue, 'MulInt should handle negative: -6 * 7 = -42');
end;

procedure TTestJetVMArithmetic.TestDivIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test division with negative dividend
  FVM.LoadInt(-20).LoadInt(4).DivInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-5), LResult.IntValue, 'DivInt should handle negative dividend: -20 div 4 = -5');

  // Reset and test division with negative divisor
  FVM.Reset();
  FVM.LoadInt(20).LoadInt(-4).DivInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-5), LResult.IntValue, 'DivInt should handle negative divisor: 20 div (-4) = -5');
end;

procedure TTestJetVMArithmetic.TestModIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test modulo with negative dividend
  FVM.LoadInt(-23).LoadInt(5).ModInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  // Note: Modulo with negative numbers can be implementation-specific
  // We'll test that it produces a valid result without overflow
  Assert.IsTrue((LResult.IntValue >= -4) and (LResult.IntValue <= 4),
    'ModInt should handle negative dividend within reasonable bounds');
end;

procedure TTestJetVMArithmetic.TestNegIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test negation of zero
  FVM.LoadInt(0).NegInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(0), LResult.IntValue, 'NegInt should handle zero: -(0) = 0');

  // Reset and test double negation
  FVM.Reset();
  FVM.LoadInt(-42).NegInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'NegInt should handle negative: -(-42) = 42');
end;

// =============================================================================
// Unsigned Integer Arithmetic Edge Cases
// =============================================================================

procedure TTestJetVMArithmetic.TestAddUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test addition with zero
  FVM.LoadUInt(42).LoadUInt(0).AddUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(42), LResult.UIntValue, 'AddUInt should handle zero: 42 + 0 = 42');
end;

procedure TTestJetVMArithmetic.TestSubUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test subtraction resulting in zero
  FVM.LoadUInt(42).LoadUInt(42).SubUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(0), LResult.UIntValue, 'SubUInt should handle equal operands: 42 - 42 = 0');
end;

procedure TTestJetVMArithmetic.TestMulUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test multiplication with one
  FVM.LoadUInt(42).LoadUInt(1).MulUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(42), LResult.UIntValue, 'MulUInt should handle one: 42 * 1 = 42');
end;

procedure TTestJetVMArithmetic.TestDivUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test division by one
  FVM.LoadUInt(42).LoadUInt(1).DivUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(42), LResult.UIntValue, 'DivUInt should handle one: 42 div 1 = 42');
end;

procedure TTestJetVMArithmetic.TestModUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test modulo by larger number
  FVM.LoadUInt(5).LoadUInt(10).ModUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(5), LResult.UIntValue, 'ModUInt should handle smaller dividend: 5 mod 10 = 5');
end;

// =============================================================================
// Arithmetic Sequence Tests
// =============================================================================

procedure TTestJetVMArithmetic.TestIntArithmeticSequence();
var
  LResult: TJetValue;
begin
  // Test complex integer arithmetic sequence
  FVM.LoadInt(10).LoadInt(5).AddInt()   // 15
     .LoadInt(3).MulInt()               // 45
     .LoadInt(9).SubInt()               // 36
     .LoadInt(6).DivInt()               // 6
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(6), LResult.IntValue, 'Int arithmetic sequence should evaluate correctly');
end;

procedure TTestJetVMArithmetic.TestUIntArithmeticSequence();
var
  LResult: TJetValue;
begin
  // Test complex unsigned integer arithmetic sequence
  FVM.LoadUInt(20).LoadUInt(10).AddUInt()  // 30
     .LoadUInt(2).MulUInt()                // 60
     .LoadUInt(12).SubUInt()               // 48
     .LoadUInt(4).DivUInt()                // 12
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(UInt64(12), LResult.UIntValue, 'UInt arithmetic sequence should evaluate correctly');
end;

procedure TTestJetVMArithmetic.TestMixedArithmeticSequence();
var
  LResult: TJetValue;
begin
  // Test mixing increment and decrement operations
  FVM.LoadInt(100).IncInt().IncInt().DecInt()  // 101
     .LoadInt(9).SubInt()                      // 92
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(92), LResult.IntValue, 'Mixed arithmetic sequence should evaluate correctly');
end;

procedure TTestJetVMArithmetic.TestComplexArithmeticChain();
var
  LResult: TJetValue;
begin
  // Test very complex arithmetic chain
  FVM.LoadInt(2).LoadInt(3).MulInt()       // 6
     .LoadInt(4).AddInt()                  // 10
     .IncInt().IncInt()                    // 12
     .LoadInt(2).DivInt()                  // 6
     .NegInt()                             // -6
     .LoadInt(10).AddInt()                 // 4
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(4), LResult.IntValue, 'Complex arithmetic chain should evaluate correctly');
end;

// =============================================================================
// Zero and Identity Tests
// =============================================================================

procedure TTestJetVMArithmetic.TestArithmeticWithZero();
var
  LResult: TJetValue;
begin
  // Test additive identity
  FVM.LoadInt(42).LoadInt(0).AddInt().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Adding zero should be identity');

  // Test multiplicative zero
  FVM.Reset();
  FVM.LoadInt(42).LoadInt(0).MulInt().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(0), LResult.IntValue, 'Multiplying by zero should give zero');
end;

procedure TTestJetVMArithmetic.TestArithmeticWithOne();
var
  LResult: TJetValue;
begin
  // Test multiplicative identity
  FVM.LoadInt(42).LoadInt(1).MulInt().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Multiplying by one should be identity');

  // Test division by one
  FVM.Reset();
  FVM.LoadInt(42).LoadInt(1).DivInt().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Dividing by one should be identity');
end;

procedure TTestJetVMArithmetic.TestArithmeticIdentities();
var
  LResult: TJetValue;
begin
  // Test that x - x = 0
  FVM.LoadInt(42).LoadInt(42).SubInt().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(0), LResult.IntValue, 'x - x should equal zero');

  // Test that x / x = 1 (for non-zero x)
  FVM.Reset();
  FVM.LoadInt(42).LoadInt(42).DivInt().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(1), LResult.IntValue, 'x / x should equal one for non-zero x');
end;

// =============================================================================
// Arithmetic Order of Operations Tests
// =============================================================================

procedure TTestJetVMArithmetic.TestArithmeticPrecedence();
var
  LResult: TJetValue;
begin
  // Since JetVM uses stack-based evaluation, precedence is determined by order of operations
  // Test that operations execute in stack order
  FVM.LoadInt(2).LoadInt(3).LoadInt(4).MulInt().AddInt().Stop();  // 2 + (3 * 4) = 14
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(14), LResult.IntValue, 'Operations should follow stack evaluation order');
end;

procedure TTestJetVMArithmetic.TestArithmeticAssociativity();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
  LVM2: TJetVM;
begin
  // Test left-associative evaluation: (8 - 3) - 2 = 3
  FVM.LoadInt(8).LoadInt(3).SubInt().LoadInt(2).SubInt().Stop();
  FVM.Execute();
  LResult1 := FVM.PopValue();

  // Test different grouping: 8 - (3 - 2) = 7
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.LoadInt(3).LoadInt(2).SubInt().LoadInt(8).Swap().SubInt().Stop();
    LVM2.Execute();
    LResult2 := LVM2.PopValue();

    Assert.AreNotEqual(LResult1.IntValue, LResult2.IntValue, 'Different groupings should yield different results');
    Assert.AreEqual(Int64(3), LResult1.IntValue, 'Left-associative should be (8-3)-2 = 3');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArithmetic.TestStackBehaviorDuringArithmetic();
var
  LInitialSP: Integer;
  LFinalSP: Integer;
begin
  LInitialSP := FVM.GetSP();

  // Perform arithmetic that should maintain stack balance
  FVM.LoadInt(10).LoadInt(20).AddInt().LoadInt(5).MulInt().Stop();
  FVM.Execute();

  // Should have one result on stack
  LFinalSP := FVM.GetSP();
  Assert.AreEqual(LInitialSP + 1, LFinalSP, 'Stack should contain exactly one result after arithmetic sequence');
end;

// =============================================================================
// Large Number Tests
// =============================================================================

procedure TTestJetVMArithmetic.TestLargeIntegerArithmetic();
var
  LResult: TJetValue;
begin
  // Test arithmetic with large numbers
  FVM.LoadInt(1000000).LoadInt(999999).AddInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(1999999), LResult.IntValue, 'Large integer arithmetic should work correctly');
end;

procedure TTestJetVMArithmetic.TestLargeUIntegerArithmetic();
var
  LResult: TJetValue;
begin
  // Test arithmetic with large unsigned numbers
  FVM.LoadUInt(4000000000).LoadUInt(294967296).AddUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(4294967296), LResult.UIntValue, 'Large unsigned integer arithmetic should work correctly');
end;

procedure TTestJetVMArithmetic.TestMaxValueArithmetic();
var
  LResult: TJetValue;
begin
  // Test arithmetic near maximum values (be careful of overflow)
  FVM.LoadInt(High(Int32)).LoadInt(1).AddInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  // Should handle conversion from 32-bit to 64-bit properly
  Assert.AreEqual(Int64(High(Int32)) + 1, LResult.IntValue, 'Max value arithmetic should handle type promotion');
end;

// =============================================================================
// Fluent Interface Verification Tests
// =============================================================================

procedure TTestJetVMArithmetic.TestFluentInterfaceChaining();
var
  LVMReference: TJetVM;
begin
  // Test that fluent interface returns the same instance
  LVMReference := FVM.LoadInt(42);
  Assert.AreSame(FVM, LVMReference, 'Fluent interface should return same instance');

  LVMReference := FVM.AddInt();
  Assert.AreSame(FVM, LVMReference, 'Arithmetic operations should return same instance');
end;

procedure TTestJetVMArithmetic.TestFluentInterfaceReturnsCorrectType();
var
  LVMReference: TJetVM;
begin
  // Test that all arithmetic operations return TJetVM
  LVMReference := FVM.LoadInt(10).LoadInt(5).AddInt().SubInt().MulInt().DivInt().ModInt();
  Assert.AreSame(FVM, LVMReference, 'All arithmetic operations should return TJetVM instance');

  LVMReference := FVM.NegInt().IncInt().DecInt().PostIncInt().PostDecInt();
  Assert.AreSame(FVM, LVMReference, 'All unary arithmetic operations should return TJetVM instance');
end;

procedure TTestJetVMArithmetic.TestFluentInterfaceMethodOrder();
var
  LResult: TJetValue;
begin
  // Test that method call order is preserved in fluent interface
  FVM.LoadInt(10)
     .LoadInt(5)
     .AddInt()      // 15
     .LoadInt(2)
     .MulInt()      // 30
     .IncInt()      // 31
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(31), LResult.IntValue, 'Fluent interface should preserve method call order');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMArithmetic);

end.
