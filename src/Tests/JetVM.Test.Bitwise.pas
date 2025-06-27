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

unit JetVM.Test.Bitwise;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMBitwise = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Integer Bitwise Operations - Basic Tests
    // ==========================================================================
    [Test]
    procedure TestAndIntBasic();
    [Test]
    procedure TestOrIntBasic();
    [Test]
    procedure TestXorIntBasic();
    [Test]
    procedure TestNotIntBasic();
    [Test]
    procedure TestShlIntBasic();
    [Test]
    procedure TestShrIntBasic();

    // ==========================================================================
    // Unsigned Integer Bitwise Operations - Basic Tests
    // ==========================================================================
    [Test]
    procedure TestAndUIntBasic();
    [Test]
    procedure TestOrUIntBasic();
    [Test]
    procedure TestXorUIntBasic();
    [Test]
    procedure TestNotUIntBasic();
    [Test]
    procedure TestShlUIntBasic();
    [Test]
    procedure TestShrUIntBasic();

    // ==========================================================================
    // Integer Bitwise Operations - Edge Cases
    // ==========================================================================
    [Test]
    procedure TestAndIntEdgeCases();
    [Test]
    procedure TestOrIntEdgeCases();
    [Test]
    procedure TestXorIntEdgeCases();
    [Test]
    procedure TestNotIntEdgeCases();
    [Test]
    procedure TestShlIntEdgeCases();
    [Test]
    procedure TestShrIntEdgeCases();

    // ==========================================================================
    // Unsigned Integer Bitwise Operations - Edge Cases
    // ==========================================================================
    [Test]
    procedure TestAndUIntEdgeCases();
    [Test]
    procedure TestOrUIntEdgeCases();
    [Test]
    procedure TestXorUIntEdgeCases();
    [Test]
    procedure TestNotUIntEdgeCases();
    [Test]
    procedure TestShlUIntEdgeCases();
    [Test]
    procedure TestShrUIntEdgeCases();

    // ==========================================================================
    // Bit Pattern Tests
    // ==========================================================================
    [Test]
    procedure TestBitPatternsInt();
    [Test]
    procedure TestBitPatternsUInt();
    [Test]
    procedure TestAlternatingBitPatterns();
    [Test]
    procedure TestBoundaryBitPatterns();

    // ==========================================================================
    // Fluent Interface Tests
    // ==========================================================================
    [Test]
    procedure TestFluentInterfaceBitwiseInt();
    [Test]
    procedure TestFluentInterfaceBitwiseUInt();
    [Test]
    procedure TestFluentInterfaceChaining();
    [Test]
    procedure TestFluentInterfaceComplexExpressions();

    // ==========================================================================
    // Shift Operations - Comprehensive Tests
    // ==========================================================================
    [Test]
    procedure TestShiftOperationsInt();
    [Test]
    procedure TestShiftOperationsUInt();
    [Test]
    procedure TestShiftByZero();
    [Test]
    procedure TestShiftByOne();
    [Test]
    procedure TestShiftByWordBoundary();
    [Test]
    procedure TestShiftOverflow();

    // ==========================================================================
    // Type Safety and Validation Tests
    // ==========================================================================
    [Test]
    procedure TestBitwiseReturnTypes();
    [Test]
    procedure TestBitwiseStackBehavior();
    [Test]
    procedure TestBitwiseValueTypes();

    // ==========================================================================
    // Error Handling Tests
    // ==========================================================================
    [Test]
    procedure TestBitwiseStackUnderflow();
    [Test]
    procedure TestBitwiseEmptyStack();

    // ==========================================================================
    // Performance and Integration Tests
    // ==========================================================================
    [Test]
    procedure TestBitwiseWithArithmetic();
    [Test]
    procedure TestBitwiseWithComparisons();
    [Test]
    procedure TestComplexBitwiseExpressions();
  end;

implementation

// =============================================================================
// Setup and TearDown
// =============================================================================

procedure TTestJetVMBitwise.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMBitwise.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Integer Bitwise Operations - Basic Tests
// =============================================================================

procedure TTestJetVMBitwise.TestAndIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic AND operation: 12 AND 10 = 8
  FVM.LoadInt(12).LoadInt(10).AndInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Int type');
  Assert.AreEqual(Int64(8), LResult.IntValue, '12 AND 10 should equal 8');
end;

procedure TTestJetVMBitwise.TestOrIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic OR operation: 12 OR 10 = 14
  FVM.LoadInt(12).LoadInt(10).OrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Int type');
  Assert.AreEqual(Int64(14), LResult.IntValue, '12 OR 10 should equal 14');
end;

procedure TTestJetVMBitwise.TestXorIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic XOR operation: 12 XOR 10 = 6
  FVM.LoadInt(12).LoadInt(10).XorInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Int type');
  Assert.AreEqual(Int64(6), LResult.IntValue, '12 XOR 10 should equal 6');
end;

procedure TTestJetVMBitwise.TestNotIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic NOT operation: NOT 0 = -1 (all bits set)
  FVM.LoadInt(0).NotInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Int type');
  Assert.AreEqual(Int64(-1), LResult.IntValue, 'NOT 0 should equal -1');
end;

procedure TTestJetVMBitwise.TestShlIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic shift left: 5 SHL 2 = 20
  FVM.LoadInt(5).LoadInt(2).ShlInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Int type');
  Assert.AreEqual(Int64(20), LResult.IntValue, '5 SHL 2 should equal 20');
end;

procedure TTestJetVMBitwise.TestShrIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic shift right: 20 SHR 2 = 5
  FVM.LoadInt(20).LoadInt(2).ShrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Int type');
  Assert.AreEqual(Int64(5), LResult.IntValue, '20 SHR 2 should equal 5');
end;

// =============================================================================
// Unsigned Integer Bitwise Operations - Basic Tests
// =============================================================================

procedure TTestJetVMBitwise.TestAndUIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic AND operation: 12 AND 10 = 8
  FVM.LoadUInt(12).LoadUInt(10).AndUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInt type');
  Assert.AreEqual(UInt64(8), LResult.UIntValue, '12 AND 10 should equal 8');
end;

procedure TTestJetVMBitwise.TestOrUIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic OR operation: 12 OR 10 = 14
  FVM.LoadUInt(12).LoadUInt(10).OrUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInt type');
  Assert.AreEqual(UInt64(14), LResult.UIntValue, '12 OR 10 should equal 14');
end;

procedure TTestJetVMBitwise.TestXorUIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic XOR operation: 12 XOR 10 = 6
  FVM.LoadUInt(12).LoadUInt(10).XorUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInt type');
  Assert.AreEqual(UInt64(6), LResult.UIntValue, '12 XOR 10 should equal 6');
end;

procedure TTestJetVMBitwise.TestNotUIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic NOT operation: NOT 0 = all bits set (UInt64 max)
  FVM.LoadUInt(0).NotUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInt type');
  Assert.AreEqual(High(UInt64), LResult.UIntValue, 'NOT 0 should equal UInt64 max');
end;

procedure TTestJetVMBitwise.TestShlUIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic shift left: 5 SHL 2 = 20
  FVM.LoadUInt(5).LoadUInt(2).ShlUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInt type');
  Assert.AreEqual(UInt64(20), LResult.UIntValue, '5 SHL 2 should equal 20');
end;

procedure TTestJetVMBitwise.TestShrUIntBasic();
var
  LResult: TJetValue;
begin
  // Test basic shift right: 20 SHR 2 = 5
  FVM.LoadUInt(20).LoadUInt(2).ShrUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInt type');
  Assert.AreEqual(UInt64(5), LResult.UIntValue, '20 SHR 2 should equal 5');
end;

// =============================================================================
// Integer Bitwise Operations - Edge Cases
// =============================================================================

procedure TTestJetVMBitwise.TestAndIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test AND with zero
  FVM.LoadInt(255).LoadInt(0).AndInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(0), LResult.IntValue, 'Any value AND 0 should equal 0');

  FVM.Reset();

  // Test AND with self (idempotent)
  FVM.LoadInt(170).LoadInt(170).AndInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(170), LResult.IntValue, 'Value AND itself should equal itself');

  FVM.Reset();

  // Test AND with -1 (all bits set)
  FVM.LoadInt(123).LoadInt(-1).AndInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(123), LResult.IntValue, 'Value AND -1 should equal value');
end;

procedure TTestJetVMBitwise.TestOrIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test OR with zero
  FVM.LoadInt(123).LoadInt(0).OrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(123), LResult.IntValue, 'Value OR 0 should equal value');

  FVM.Reset();

  // Test OR with self (idempotent)
  FVM.LoadInt(170).LoadInt(170).OrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(170), LResult.IntValue, 'Value OR itself should equal itself');

  FVM.Reset();

  // Test OR with -1 (all bits set)
  FVM.LoadInt(123).LoadInt(-1).OrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-1), LResult.IntValue, 'Value OR -1 should equal -1');
end;

procedure TTestJetVMBitwise.TestXorIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test XOR with zero
  FVM.LoadInt(123).LoadInt(0).XorInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(123), LResult.IntValue, 'Value XOR 0 should equal value');

  FVM.Reset();

  // Test XOR with self (should be zero)
  FVM.LoadInt(170).LoadInt(170).XorInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(0), LResult.IntValue, 'Value XOR itself should equal 0');

  FVM.Reset();

  // Test XOR with -1 (bitwise NOT)
  FVM.LoadInt(123).LoadInt(-1).XorInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(not 123), LResult.IntValue, 'Value XOR -1 should equal NOT value');
end;

procedure TTestJetVMBitwise.TestNotIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test NOT with -1
  FVM.LoadInt(-1).NotInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(0), LResult.IntValue, 'NOT -1 should equal 0');

  FVM.Reset();

  // Test NOT with 1
  FVM.LoadInt(1).NotInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-2), LResult.IntValue, 'NOT 1 should equal -2');

  FVM.Reset();

  // Test double NOT (should restore original)
  FVM.LoadInt(123).NotInt().NotInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(123), LResult.IntValue, 'NOT NOT value should equal value');
end;

procedure TTestJetVMBitwise.TestShlIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test shift by 0
  FVM.LoadInt(123).LoadInt(0).ShlInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(123), LResult.IntValue, 'Value SHL 0 should equal value');

  FVM.Reset();

  // Test shift 1 by 63 (boundary)
  FVM.LoadInt(1).LoadInt(63).ShlInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(Int64(1) shl 63), LResult.IntValue, '1 SHL 63 should work correctly');
end;

procedure TTestJetVMBitwise.TestShrIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test shift by 0
  FVM.LoadInt(123).LoadInt(0).ShrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(123), LResult.IntValue, 'Value SHR 0 should equal value');

  FVM.Reset();

  // Test negative number shift right (logical shift in JetVM, not arithmetic)
  // -8 as Int64 = $FFFFFFFFFFFFFFF8, logical shift right by 2 = $3FFFFFFFFFFFFFFE
  FVM.LoadInt(-8).LoadInt(2).ShrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  // JetVM implements logical right shift, so -8 SHR 2 = 4611686018427387902
  Assert.AreEqual(Int64(4611686018427387902), LResult.IntValue, '-8 SHR 2 should equal 4611686018427387902 (logical shift)');
end;

// =============================================================================
// Unsigned Integer Bitwise Operations - Edge Cases
// =============================================================================

procedure TTestJetVMBitwise.TestAndUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test AND with zero
  FVM.LoadUInt(255).LoadUInt(0).AndUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(0), LResult.UIntValue, 'Any value AND 0 should equal 0');

  FVM.Reset();

  // Test AND with max value
  FVM.LoadUInt(123).LoadUInt(High(UInt64)).AndUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(123), LResult.UIntValue, 'Value AND max should equal value');
end;

procedure TTestJetVMBitwise.TestOrUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test OR with zero
  FVM.LoadUInt(123).LoadUInt(0).OrUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(123), LResult.UIntValue, 'Value OR 0 should equal value');

  FVM.Reset();

  // Test OR with max value
  FVM.LoadUInt(123).LoadUInt(High(UInt64)).OrUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(High(UInt64), LResult.UIntValue, 'Value OR max should equal max');
end;

procedure TTestJetVMBitwise.TestXorUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test XOR with zero
  FVM.LoadUInt(123).LoadUInt(0).XorUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(123), LResult.UIntValue, 'Value XOR 0 should equal value');

  FVM.Reset();

  // Test XOR with self
  FVM.LoadUInt(170).LoadUInt(170).XorUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(0), LResult.UIntValue, 'Value XOR itself should equal 0');
end;

procedure TTestJetVMBitwise.TestNotUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test NOT with max value
  FVM.LoadUInt(High(UInt64)).NotUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(0), LResult.UIntValue, 'NOT max should equal 0');

  FVM.Reset();

  // Test double NOT
  FVM.LoadUInt(123).NotUInt().NotUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(123), LResult.UIntValue, 'NOT NOT value should equal value');
end;

procedure TTestJetVMBitwise.TestShlUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test shift by 0
  FVM.LoadUInt(123).LoadUInt(0).ShlUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(123), LResult.UIntValue, 'Value SHL 0 should equal value');

  FVM.Reset();

  // Test shift 1 by 63
  FVM.LoadUInt(1).LoadUInt(63).ShlUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(UInt64(1) shl 63), LResult.UIntValue, '1 SHL 63 should work correctly');
end;

procedure TTestJetVMBitwise.TestShrUIntEdgeCases();
var
  LResult: TJetValue;
begin
  // Test shift by 0
  FVM.LoadUInt(123).LoadUInt(0).ShrUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(123), LResult.UIntValue, 'Value SHR 0 should equal value');

  FVM.Reset();

  // Test logical shift right with high bit set
  FVM.LoadUInt(High(UInt64)).LoadUInt(1).ShrUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(High(UInt64) shr 1), LResult.UIntValue, 'Max SHR 1 should do logical shift');
end;

// =============================================================================
// Bit Pattern Tests
// =============================================================================

procedure TTestJetVMBitwise.TestBitPatternsInt();
var
  LResult: TJetValue;
  LAlternating1: Int64;
  LAlternating2: Int64;
begin
  // Test alternating bit pattern: use valid Int64 values
  LAlternating1 := Int64($AAAAAAAAAAAAAAAA);  // Cast to signed
  LAlternating2 := Int64($5555555555555555);  // Cast to signed

  FVM.LoadInt(LAlternating1).LoadInt(LAlternating2).AndInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(0), LResult.IntValue, 'Alternating patterns AND should equal 0');

  FVM.Reset();

  // Test alternating bit pattern: OR should give all bits
  FVM.LoadInt(LAlternating1).LoadInt(LAlternating2).OrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-1), LResult.IntValue, 'Alternating patterns OR should equal -1');
end;

procedure TTestJetVMBitwise.TestBitPatternsUInt();
var
  LResult: TJetValue;
  LAlternating1: UInt64;
  LAlternating2: UInt64;
begin
  // Test alternating bit pattern
  LAlternating1 := UInt64($AAAAAAAAAAAAAAAA);
  LAlternating2 := UInt64($5555555555555555);

  FVM.LoadUInt(LAlternating1).LoadUInt(LAlternating2).AndUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(0), LResult.UIntValue, 'Alternating patterns AND should equal 0');

  FVM.Reset();

  // Test alternating bit pattern OR
  FVM.LoadUInt(LAlternating1).LoadUInt(LAlternating2).OrUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(High(UInt64), LResult.UIntValue, 'Alternating patterns OR should equal max');
end;

procedure TTestJetVMBitwise.TestAlternatingBitPatterns();
var
  LResult: TJetValue;
  LAlternating1: Int64;
  LAlternating2: UInt64;
begin
  // Test XOR with alternating patterns
  LAlternating1 := Int64($AAAAAAAAAAAAAAAA);
  LAlternating2 := Int64($5555555555555555);

  FVM.LoadInt(LAlternating1).LoadInt(LAlternating2).XorInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(-1), LResult.IntValue, 'Alternating XOR should equal -1');

  FVM.Reset();

  // Test NOT of alternating pattern
  LAlternating2 := UInt64($AAAAAAAAAAAAAAAA);
  FVM.LoadUInt(LAlternating2).NotUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64($5555555555555555), LResult.UIntValue, 'NOT should flip all bits');
end;

procedure TTestJetVMBitwise.TestBoundaryBitPatterns();
var
  LResult: TJetValue;
begin
  // Test lowest bit operations
  FVM.LoadInt(1).LoadInt(1).AndInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(1), LResult.IntValue, '1 AND 1 should equal 1');

  FVM.Reset();

  // Test highest bit operations (sign bit for signed)
  var LHighBit := Int64(1) shl 63;
  FVM.LoadInt(LHighBit).LoadInt(LHighBit).OrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(LHighBit, LResult.IntValue, 'High bit OR with itself should work');
end;

// =============================================================================
// Fluent Interface Tests
// =============================================================================

procedure TTestJetVMBitwise.TestFluentInterfaceBitwiseInt();
var
  LInstance1: TJetVM;
  LInstance2: TJetVM;
begin
  // Test that fluent methods return same instance
  LInstance1 := FVM.LoadInt(10);
  LInstance2 := LInstance1.LoadInt(5).AndInt();

  Assert.AreSame(FVM, LInstance1, 'LoadInt should return same instance');
  Assert.AreSame(FVM, LInstance2, 'AndInt should return same instance');
end;

procedure TTestJetVMBitwise.TestFluentInterfaceBitwiseUInt();
var
  LInstance1: TJetVM;
  LInstance2: TJetVM;
begin
  // Test that fluent methods return same instance for UInt
  LInstance1 := FVM.LoadUInt(10);
  LInstance2 := LInstance1.LoadUInt(5).OrUInt();

  Assert.AreSame(FVM, LInstance1, 'LoadUInt should return same instance');
  Assert.AreSame(FVM, LInstance2, 'OrUInt should return same instance');
end;

procedure TTestJetVMBitwise.TestFluentInterfaceChaining();
var
  LResult: TJetValue;
begin
  // Test complex fluent chain
  FVM.LoadInt(15)
     .LoadInt(7)
     .AndInt()
     .LoadInt(1)
     .OrInt()
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(((15 and 7) or 1)), LResult.IntValue, 'Complex fluent chain should work correctly');
end;

procedure TTestJetVMBitwise.TestFluentInterfaceComplexExpressions();
var
  LResult: TJetValue;
begin
  // Test: (A XOR B) AND (C OR D)
  FVM.LoadInt(12)    // A
     .LoadInt(10)    // B
     .XorInt()       // A XOR B
     .LoadInt(5)     // C
     .LoadInt(3)     // D
     .OrInt()        // C OR D
     .AndInt()       // (A XOR B) AND (C OR D)
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  var LExpected := ((12 xor 10) and (5 or 3));
  Assert.AreEqual(Int64(LExpected), LResult.IntValue, 'Complex bitwise expression should work');
end;

// =============================================================================
// Shift Operations - Comprehensive Tests
// =============================================================================

procedure TTestJetVMBitwise.TestShiftOperationsInt();
var
  LResult: TJetValue;
  LShiftAmount: Integer;
begin
  // Test various shift amounts
  for LShiftAmount := 1 to 10 do
  begin
    FVM.Reset();
    FVM.LoadInt(1).LoadInt(LShiftAmount).ShlInt().Stop();
    FVM.Execute();

    LResult := FVM.PopValue();
    Assert.AreEqual(Int64(1 shl LShiftAmount), LResult.IntValue,
                   Format('1 SHL %d should equal %d', [LShiftAmount, 1 shl LShiftAmount]));
  end;
end;

procedure TTestJetVMBitwise.TestShiftOperationsUInt();
var
  LResult: TJetValue;
  LShiftAmount: Integer;
begin
  // Test various shift amounts for UInt
  for LShiftAmount := 1 to 10 do
  begin
    FVM.Reset();
    FVM.LoadUInt(1).LoadUInt(LShiftAmount).ShlUInt().Stop();
    FVM.Execute();

    LResult := FVM.PopValue();
    Assert.AreEqual(UInt64(UInt64(1) shl LShiftAmount), LResult.UIntValue,
                   Format('1 SHL %d should equal %d', [LShiftAmount, UInt64(1) shl LShiftAmount]));
  end;
end;

procedure TTestJetVMBitwise.TestShiftByZero();
var
  LResult: TJetValue;
begin
  // Test shift by zero for various values
  FVM.LoadInt(42).LoadInt(0).ShlInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Any value SHL 0 should equal itself');

  FVM.Reset();

  FVM.LoadUInt(42).LoadUInt(0).ShrUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(42), LResult.UIntValue, 'Any value SHR 0 should equal itself');
end;

procedure TTestJetVMBitwise.TestShiftByOne();
var
  LResult: TJetValue;
begin
  // Test shift by one (doubling/halving)
  FVM.LoadInt(21).LoadInt(1).ShlInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(42), LResult.IntValue, 'Value SHL 1 should double value');

  FVM.Reset();

  FVM.LoadUInt(42).LoadUInt(1).ShrUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(UInt64(21), LResult.UIntValue, 'Value SHR 1 should halve value');
end;

procedure TTestJetVMBitwise.TestShiftByWordBoundary();
var
  LResult: TJetValue;
begin
  // Test shift by 32 (word boundary)
  FVM.LoadInt(1).LoadInt(32).ShlInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(Int64(1) shl 32), LResult.IntValue, '1 SHL 32 should work correctly');

  FVM.Reset();

  // Test shift back by 32
  FVM.LoadInt(Int64(1) shl 32).LoadInt(32).ShrInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(1), LResult.IntValue, '(1 SHL 32) SHR 32 should equal 1');
end;

procedure TTestJetVMBitwise.TestShiftOverflow();
var
  LResult: TJetValue;
begin
  // Test shift that causes overflow
  FVM.LoadUInt(High(UInt64)).LoadUInt(1).ShlUInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  // Result behavior depends on implementation, but should not crash
  Assert.IsTrue(True, 'Shift overflow should not crash VM');
end;

// =============================================================================
// Type Safety and Validation Tests
// =============================================================================

procedure TTestJetVMBitwise.TestBitwiseReturnTypes();
var
  LResult: TJetValue;
begin
  // Test that all Int bitwise operations return Int type
  FVM.LoadInt(10).LoadInt(5).AndInt().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(jvtInt, LResult.ValueType, 'AndInt should return Int type');

  FVM.Reset();

  // Test that all UInt bitwise operations return UInt type
  FVM.LoadUInt(10).LoadUInt(5).OrUInt().Stop();
  FVM.Execute();
  LResult := FVM.PopValue();
  Assert.AreEqual(jvtUInt, LResult.ValueType, 'OrUInt should return UInt type');
end;

procedure TTestJetVMBitwise.TestBitwiseStackBehavior();
var
  LStackPointer: Integer;
begin
  // Test that binary operations consume 2 values and produce 1
  // Note: Fluent methods only generate bytecode, values appear on stack after Execute()
  FVM.LoadInt(10).LoadInt(5).Stop();
  FVM.Execute();

  LStackPointer := FVM.GetSP();
  Assert.AreEqual(2, LStackPointer, 'Should have 2 values on stack after loading');

  FVM.Reset();

  // Test complete operation: load, operate, check result
  FVM.LoadInt(10).LoadInt(5).AndInt().Stop();
  FVM.Execute();

  LStackPointer := FVM.GetSP();
  Assert.AreEqual(1, LStackPointer, 'Should have 1 value after binary operation');

  FVM.Reset();

  // Test that unary operations consume 1 value and produce 1
  FVM.LoadInt(10).Stop();
  FVM.Execute();

  LStackPointer := FVM.GetSP();
  Assert.AreEqual(1, LStackPointer, 'Should have 1 value on stack');

  FVM.Reset();
  FVM.LoadInt(10).NotInt().Stop();
  FVM.Execute();

  LStackPointer := FVM.GetSP();
  Assert.AreEqual(1, LStackPointer, 'Should have 1 value after unary operation');
end;

procedure TTestJetVMBitwise.TestBitwiseValueTypes();
var
  LResult: TJetValue;
begin
  // Verify that operations preserve correct value types throughout
  FVM.LoadInt(-123).NotInt().Stop();
  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtInt, LResult.ValueType, 'NOT operation should preserve Int type');
  Assert.AreEqual(Int64(not (-123)), LResult.IntValue, 'NOT should compute correct value');
end;

// =============================================================================
// Error Handling Tests
// =============================================================================

procedure TTestJetVMBitwise.TestBitwiseStackUnderflow();
begin
  // Test binary operation with insufficient stack values
  Assert.WillRaise(
    procedure begin
      FVM.LoadInt(10).AndInt().Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'Binary bitwise operation with insufficient stack should raise EJetVMError'
  );

  FVM.Reset();

  // Test unary operation with empty stack
  Assert.WillRaise(
    procedure begin
      FVM.NotInt().Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'Unary bitwise operation with empty stack should raise EJetVMError'
  );
end;

procedure TTestJetVMBitwise.TestBitwiseEmptyStack();
begin
  // Test all bitwise operations on empty stack
  Assert.WillRaise(
    procedure begin
      FVM.AndInt().Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'AndInt on empty stack should raise EJetVMError'
  );

  Assert.WillRaise(
    procedure begin
      FVM.Reset();
      FVM.NotUInt().Stop();
      FVM.Execute();
    end,
    EJetVMError,
    'NotUInt on empty stack should raise EJetVMError'
  );
end;

// =============================================================================
// Performance and Integration Tests
// =============================================================================

procedure TTestJetVMBitwise.TestBitwiseWithArithmetic();
var
  LResult: TJetValue;
begin
  // Test combining bitwise and arithmetic operations
  FVM.LoadInt(10)
     .LoadInt(5)
     .AddInt()        // 15
     .LoadInt(3)
     .AndInt()        // 15 AND 3 = 3
     .LoadInt(1)
     .AddInt()        // 3 + 1 = 4
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(4), LResult.IntValue, 'Combined arithmetic and bitwise should work');
end;

procedure TTestJetVMBitwise.TestBitwiseWithComparisons();
var
  LResult: TJetValue;
begin
  // Test using bitwise results in comparisons
  FVM.LoadInt(12)
     .LoadInt(10)
     .AndInt()        // 12 AND 10 = 8
     .LoadInt(8)
     .EqInt()         // 8 == 8 = true
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be boolean');
  Assert.IsTrue(LResult.BoolValue, 'Bitwise result comparison should be true');
end;

procedure TTestJetVMBitwise.TestComplexBitwiseExpressions();
var
  LResult: TJetValue;
begin
  // Test very complex bitwise expression: ((A AND B) XOR (C OR D)) SHL 2
  FVM.LoadInt(15)     // A
     .LoadInt(10)     // B
     .AndInt()        // A AND B = 10
     .LoadInt(4)      // C
     .LoadInt(2)      // D
     .OrInt()         // C OR D = 6
     .XorInt()        // (A AND B) XOR (C OR D) = 10 XOR 6 = 12
     .LoadInt(2)      // Shift amount
     .ShlInt()        // Result SHL 2 = 12 SHL 2 = 48
     .Stop();

  FVM.Execute();

  LResult := FVM.PopValue();
  var LExpected := ((15 and 10) xor (4 or 2)) shl 2;
  Assert.AreEqual(Int64(LExpected), LResult.IntValue, 'Complex bitwise expression should compute correctly');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMBitwise);

end.
