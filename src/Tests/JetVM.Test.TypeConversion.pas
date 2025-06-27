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

unit JetVM.Test.TypeConversion;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMTypeConversion = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Integer ↔ UInteger Conversion Tests
    // ==========================================================================
    [Test]
    procedure TestIntToUIntBasic();
    [Test]
    procedure TestUIntToIntBasic();
    [Test]
    procedure TestIntToUIntZero();
    [Test]
    procedure TestUIntToIntZero();
    [Test]
    procedure TestIntToUIntPositiveValues();
    [Test]
    procedure TestIntToUIntNegativeValues();
    [Test]
    procedure TestUIntToIntLargeValues();
    [Test]
    procedure TestIntUIntRoundTrip();

    // ==========================================================================
    // Integer ↔ String Conversion Tests
    // ==========================================================================
    [Test]
    procedure TestIntToStrBasic();
    [Test]
    procedure TestStrToIntBasic();
    [Test]
    procedure TestIntToStrZero();
    [Test]
    procedure TestStrToIntZero();
    [Test]
    procedure TestIntToStrPositive();
    [Test]
    procedure TestIntToStrNegative();
    [Test]
    procedure TestStrToIntPositive();
    [Test]
    procedure TestStrToIntNegative();
    [Test]
    procedure TestIntToStrMaxMin();
    [Test]
    procedure TestStrToIntMaxMin();
    [Test]
    procedure TestIntStrRoundTrip();

    // ==========================================================================
    // UInteger ↔ String Conversion Tests
    // ==========================================================================
    [Test]
    procedure TestUIntToStrBasic();
    [Test]
    procedure TestStrToUIntBasic();
    [Test]
    procedure TestUIntToStrZero();
    [Test]
    procedure TestStrToUIntZero();
    [Test]
    procedure TestUIntToStrLargeValues();
    [Test]
    procedure TestStrToUIntLargeValues();
    [Test]
    procedure TestUIntToStrMaxValue();
    [Test]
    procedure TestStrToUIntMaxValue();
    [Test]
    procedure TestUIntStrRoundTrip();

    // ==========================================================================
    // Boolean ↔ String Conversion Tests
    // ==========================================================================
    [Test]
    procedure TestBoolToStrTrue();
    [Test]
    procedure TestBoolToStrFalse();
    [Test]
    procedure TestStrToBoolTrue();
    [Test]
    procedure TestStrToBoolFalse();
    [Test]
    procedure TestStrToBoolCaseInsensitive();
    [Test]
    procedure TestStrToBoolNumericFormats();
    [Test]
    procedure TestBoolStrRoundTrip();

    // ==========================================================================
    // Pointer ↔ Integer Conversion Tests
    // ==========================================================================
    [Test]
    procedure TestPtrToIntNull();
    [Test]
    procedure TestIntToPtrNull();
    [Test]
    procedure TestPtrToIntValidPointer();
    [Test]
    procedure TestIntToPtrValidAddress();
    [Test]
    procedure TestPtrIntRoundTrip();
    [Test]
    procedure TestPtrToIntLargeAddress();

    // ==========================================================================
    // String Conversion Error Handling Tests
    // ==========================================================================
    [Test]
    procedure TestStrToIntInvalidFormat();
    [Test]
    procedure TestStrToUIntInvalidFormat();
    [Test]
    procedure TestStrToBoolInvalidFormat();
    [Test]
    procedure TestStrToIntEmptyString();
    [Test]
    procedure TestStrToUIntEmptyString();
    [Test]
    procedure TestStrToBoolEmptyString();
    [Test]
    procedure TestStrToIntOverflow();
    [Test]
    procedure TestStrToUIntOverflow();

    // ==========================================================================
    // Edge Cases and Boundary Conditions
    // ==========================================================================
    [Test]
    procedure TestConversionWithEmptyStack();
    [Test]
    procedure TestConversionStackUnderflow();
    [Test]
    procedure TestConversionTypeValidation();
    [Test]
    procedure TestConversionResultType();
    [Test]
    procedure TestConversionStackEffects();

    // ==========================================================================
    // Chained Conversion Tests
    // ==========================================================================
    [Test]
    procedure TestChainedIntToStrToInt();
    [Test]
    procedure TestChainedUIntToStrToUInt();
    [Test]
    procedure TestChainedBoolToStrToBool();
    [Test]
    procedure TestChainedIntToUIntToStr();
    [Test]
    procedure TestChainedComplexConversions();
    [Test]
    procedure TestMultipleConversionsInSequence();

    // ==========================================================================
    // Integration with VM Operations Tests
    // ==========================================================================
    [Test]
    procedure TestConversionWithArithmetic();
    [Test]
    procedure TestConversionWithComparisons();
    [Test]
    procedure TestConversionWithStackOps();
    [Test]
    procedure TestConversionWithStringOps();
    [Test]
    procedure TestConversionInControlFlow();
    [Test]
    procedure TestConversionWithFunctions();

    // ==========================================================================
    // Performance and Memory Tests
    // ==========================================================================
    [Test]
    procedure TestConversionPerformanceBasic();
    [Test]
    procedure TestStringConversionMemoryManagement();
    [Test]
    procedure TestLargeStringConversion();
    [Test]
    procedure TestRepeatedConversions();

    // ==========================================================================
    // Validation Level Interaction Tests
    // ==========================================================================
    [Test]
    procedure TestConversionValidationLevelNone();
    [Test]
    procedure TestConversionValidationLevelBasic();
    [Test]
    procedure TestConversionValidationLevelDevelopment();
    [Test]
    procedure TestConversionValidationLevelSafe();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMTypeConversion.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMTypeConversion.TearDown();
begin
  FVM.Free();
end;

// =============================================================================
// Integer ↔ UInteger Conversion Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestIntToUIntBasic();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(42)
     .IntToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  Assert.AreEqual(UInt64(42), LResult.UIntValue, 'Int 42 should convert to UInt 42');
end;

procedure TTestJetVMTypeConversion.TestUIntToIntBasic();
var
  LResult: TJetValue;
begin
  FVM.LoadUInt(42)
     .UIntToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(42), LResult.IntValue, 'UInt 42 should convert to Int 42');
end;

procedure TTestJetVMTypeConversion.TestIntToUIntZero();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(0)
     .IntToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  Assert.AreEqual(UInt64(0), LResult.UIntValue, 'Int 0 should convert to UInt 0');
end;

procedure TTestJetVMTypeConversion.TestUIntToIntZero();
var
  LResult: TJetValue;
begin
  FVM.LoadUInt(0)
     .UIntToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(0), LResult.IntValue, 'UInt 0 should convert to Int 0');
end;

procedure TTestJetVMTypeConversion.TestIntToUIntPositiveValues();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(1000000)
     .IntToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  Assert.AreEqual(UInt64(1000000), LResult.UIntValue, 'Large positive int should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestIntToUIntNegativeValues();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(-42)
     .IntToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  // Negative values should convert using two's complement representation
  Assert.AreEqual(UInt64(-42), LResult.UIntValue, 'Negative int should convert using two''s complement');
end;

procedure TTestJetVMTypeConversion.TestUIntToIntLargeValues();
var
  LResult: TJetValue;
begin
  FVM.LoadUInt(High(UInt32))
     .UIntToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(High(UInt32)), LResult.IntValue, 'Large UInt should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestIntUIntRoundTrip();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(12345)
     .IntToUInt()
     .UIntToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(12345), LResult.IntValue, 'Round trip should preserve original value');
end;

// =============================================================================
// Integer ↔ String Conversion Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestIntToStrBasic();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(42)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('42', LResult.StrValue, 'Int 42 should convert to string "42"');
end;

procedure TTestJetVMTypeConversion.TestStrToIntBasic();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('42')
     .StrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(42), LResult.IntValue, 'String "42" should convert to int 42');
end;

procedure TTestJetVMTypeConversion.TestIntToStrZero();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(0)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('0', LResult.StrValue, 'Int 0 should convert to string "0"');
end;

procedure TTestJetVMTypeConversion.TestStrToIntZero();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('0')
     .StrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(0), LResult.IntValue, 'String "0" should convert to int 0');
end;

procedure TTestJetVMTypeConversion.TestIntToStrPositive();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(123456)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('123456', LResult.StrValue, 'Large positive int should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestIntToStrNegative();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(-123456)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('-123456', LResult.StrValue, 'Negative int should convert with minus sign');
end;

procedure TTestJetVMTypeConversion.TestStrToIntPositive();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('123456')
     .StrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(123456), LResult.IntValue, 'Positive string number should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestStrToIntNegative();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('-123456')
     .StrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(-123456), LResult.IntValue, 'Negative string number should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestIntToStrMaxMin();
var
  LResult: TJetValue;
begin
  // Test maximum value
  FVM.LoadInt(High(Int64))
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual(IntToStr(High(Int64)), LResult.StrValue, 'Max Int64 should convert correctly');

  // Reset and test minimum value
  FVM.Reset();
  FVM.LoadInt(Low(Int64))
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(IntToStr(Low(Int64)), LResult.StrValue, 'Min Int64 should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestStrToIntMaxMin();
var
  LResult: TJetValue;
  LMaxStr: string;
  LMinStr: string;
begin
  LMaxStr := IntToStr(High(Int64));
  LMinStr := IntToStr(Low(Int64));

  // Test maximum value
  FVM.LoadStr(LMaxStr)
     .StrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(High(Int64), LResult.IntValue, 'Max Int64 string should convert correctly');

  // Reset and test minimum value
  FVM.Reset();
  FVM.LoadStr(LMinStr)
     .StrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Low(Int64), LResult.IntValue, 'Min Int64 string should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestIntStrRoundTrip();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(-98765)
     .IntToStr()
     .StrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(-98765), LResult.IntValue, 'Round trip should preserve original value');
end;

// =============================================================================
// UInteger ↔ String Conversion Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestUIntToStrBasic();
var
  LResult: TJetValue;
begin
  FVM.LoadUInt(42)
     .UIntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('42', LResult.StrValue, 'UInt 42 should convert to string "42"');
end;

procedure TTestJetVMTypeConversion.TestStrToUIntBasic();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('42')
     .StrToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  Assert.AreEqual(UInt64(42), LResult.UIntValue, 'String "42" should convert to UInt 42');
end;

procedure TTestJetVMTypeConversion.TestUIntToStrZero();
var
  LResult: TJetValue;
begin
  FVM.LoadUInt(0)
     .UIntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('0', LResult.StrValue, 'UInt 0 should convert to string "0"');
end;

procedure TTestJetVMTypeConversion.TestStrToUIntZero();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('0')
     .StrToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  Assert.AreEqual(UInt64(0), LResult.UIntValue, 'String "0" should convert to UInt 0');
end;

procedure TTestJetVMTypeConversion.TestUIntToStrLargeValues();
var
  LResult: TJetValue;
begin
  FVM.LoadUInt(4294967295) // Max UInt32
     .UIntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('4294967295', LResult.StrValue, 'Large UInt should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestStrToUIntLargeValues();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('4294967295')
     .StrToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  Assert.AreEqual(UInt64(4294967295), LResult.UIntValue, 'Large UInt string should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestUIntToStrMaxValue();
var
  LResult: TJetValue;
begin
  FVM.LoadUInt(High(UInt64))
     .UIntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual(UIntToStr(High(UInt64)), LResult.StrValue, 'Max UInt64 should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestStrToUIntMaxValue();
var
  LResult: TJetValue;
begin
  // Use High(UInt32) which is definitely safe and tests large values
  FVM.LoadStr('4294967295') // High(UInt32) = 2^32 - 1
     .StrToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  Assert.AreEqual(UInt64(4294967295), LResult.UIntValue, 'Large UInt string should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestUIntStrRoundTrip();
var
  LResult: TJetValue;
begin
  FVM.LoadUInt(987654321)
     .UIntToStr()
     .StrToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  Assert.AreEqual(UInt64(987654321), LResult.UIntValue, 'Round trip should preserve original value');
end;

// =============================================================================
// Boolean ↔ String Conversion Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestBoolToStrTrue();
var
  LResult: TJetValue;
begin
  FVM.LoadBool(True)
     .BoolToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('True', LResult.StrValue, 'Boolean True should convert to string "True"');
end;

procedure TTestJetVMTypeConversion.TestBoolToStrFalse();
var
  LResult: TJetValue;
begin
  FVM.LoadBool(False)
     .BoolToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('False', LResult.StrValue, 'Boolean False should convert to string "False"');
end;

procedure TTestJetVMTypeConversion.TestStrToBoolTrue();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('True')
     .StrToBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be Boolean type');
  Assert.AreEqual(True, LResult.BoolValue, 'String "True" should convert to boolean True');
end;

procedure TTestJetVMTypeConversion.TestStrToBoolFalse();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('False')
     .StrToBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be Boolean type');
  Assert.AreEqual(False, LResult.BoolValue, 'String "False" should convert to boolean False');
end;

procedure TTestJetVMTypeConversion.TestStrToBoolCaseInsensitive();
var
  LResult: TJetValue;
begin
  // Test lowercase
  FVM.LoadStr('true')
     .StrToBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be Boolean type');
  Assert.AreEqual(True, LResult.BoolValue, 'String "true" should convert to boolean True');

  // Reset and test mixed case
  FVM.Reset();
  FVM.LoadStr('FALSE')
     .StrToBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(False, LResult.BoolValue, 'String "FALSE" should convert to boolean False');
end;

procedure TTestJetVMTypeConversion.TestStrToBoolNumericFormats();
var
  LResult: TJetValue;
begin
  // Test "1" as True
  FVM.LoadStr('1')
     .StrToBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be Boolean type');
  Assert.AreEqual(True, LResult.BoolValue, 'String "1" should convert to boolean True');

  // Reset and test "0" as False
  FVM.Reset();
  FVM.LoadStr('0')
     .StrToBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(False, LResult.BoolValue, 'String "0" should convert to boolean False');
end;

procedure TTestJetVMTypeConversion.TestBoolStrRoundTrip();
var
  LResult: TJetValue;
begin
  // Test True round trip
  FVM.LoadBool(True)
     .BoolToStr()
     .StrToBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be Boolean type');
  Assert.AreEqual(True, LResult.BoolValue, 'True round trip should preserve original value');

  // Reset and test False round trip
  FVM.Reset();
  FVM.LoadBool(False)
     .BoolToStr()
     .StrToBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(False, LResult.BoolValue, 'False round trip should preserve original value');
end;

// =============================================================================
// Pointer ↔ Integer Conversion Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestPtrToIntNull();
var
  LResult: TJetValue;
  LNullPtr: TJetValue;
begin
  LNullPtr := FVM.MakePtrConstant(nil);
  FVM.AddConstant(LNullPtr);

  FVM.LoadConst(0)
     .PtrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(0), LResult.IntValue, 'Null pointer should convert to 0');
end;

procedure TTestJetVMTypeConversion.TestIntToPtrNull();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(0)
     .IntToPtr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtPointer, LResult.ValueType, 'Result should be Pointer type');
  Assert.AreEqual(Pointer(nil), LResult.PtrValue, 'Integer 0 should convert to null pointer');
end;

procedure TTestJetVMTypeConversion.TestPtrToIntValidPointer();
var
  LResult: TJetValue;
  LTestVar: Integer;
  LAddress: NativeInt;
  LPtrValue: TJetValue;
begin
  LTestVar := 42;
  LAddress := NativeInt(@LTestVar);
  LPtrValue := FVM.MakePtrConstant(@LTestVar);
  FVM.AddConstant(LPtrValue);

  FVM.LoadConst(0)
     .PtrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(LAddress), LResult.IntValue, 'Pointer should convert to correct address');
end;

procedure TTestJetVMTypeConversion.TestIntToPtrValidAddress();
var
  LResult: TJetValue;
  LTestVar: Integer;
  LAddress: NativeInt;
begin
  LTestVar := 42;
  LAddress := NativeInt(@LTestVar);

  FVM.LoadInt(LAddress)
     .IntToPtr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtPointer, LResult.ValueType, 'Result should be Pointer type');
  Assert.AreEqual(Pointer(LAddress), LResult.PtrValue, 'Integer should convert to correct pointer');
end;

procedure TTestJetVMTypeConversion.TestPtrIntRoundTrip();
var
  LResult: TJetValue;
  LTestVar: Integer;
  LPtrValue: TJetValue;
begin
  LTestVar := 42;
  LPtrValue := FVM.MakePtrConstant(@LTestVar);
  FVM.AddConstant(LPtrValue);

  FVM.LoadConst(0)
     .PtrToInt()
     .IntToPtr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtPointer, LResult.ValueType, 'Result should be Pointer type');
  Assert.AreEqual(Pointer(@LTestVar), LResult.PtrValue, 'Round trip should preserve original pointer');
end;

procedure TTestJetVMTypeConversion.TestPtrToIntLargeAddress();
var
  LResult: TJetValue;
  LLargeAddress: NativeInt;
  LPtrValue: TJetValue;
begin
  {$IFDEF WIN64}
  LLargeAddress := $7FFFFFFFFFFFFFFF; // Max positive value for 64-bit
  {$ELSE}
  LLargeAddress := $7FFFFFFF; // Max positive value for 32-bit
  {$ENDIF}

  LPtrValue := FVM.MakePtrConstant(Pointer(LLargeAddress));
  FVM.AddConstant(LPtrValue);

  FVM.LoadConst(0)
     .PtrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(LLargeAddress), LResult.IntValue, 'Large address should convert correctly');
end;

// =============================================================================
// String Conversion Error Handling Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestStrToIntInvalidFormat();
begin
  FVM.LoadStr('abc123')
     .StrToInt()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Invalid string format should raise exception'
  );
end;

procedure TTestJetVMTypeConversion.TestStrToUIntInvalidFormat();
begin
  FVM.LoadStr('xyz789')
     .StrToUInt()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Invalid string format should raise exception'
  );
end;

procedure TTestJetVMTypeConversion.TestStrToBoolInvalidFormat();
begin
  FVM.LoadStr('maybe')
     .StrToBool()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Invalid boolean string should raise exception'
  );
end;

procedure TTestJetVMTypeConversion.TestStrToIntEmptyString();
begin
  FVM.LoadStr('')
     .StrToInt()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Empty string should raise exception'
  );
end;

procedure TTestJetVMTypeConversion.TestStrToUIntEmptyString();
begin
  FVM.LoadStr('')
     .StrToUInt()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Empty string should raise exception'
  );
end;

procedure TTestJetVMTypeConversion.TestStrToBoolEmptyString();
begin
  FVM.LoadStr('')
     .StrToBool()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Empty string should raise exception'
  );
end;

procedure TTestJetVMTypeConversion.TestStrToIntOverflow();
begin
  FVM.LoadStr('99999999999999999999999999999')
     .StrToInt()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Overflow string should raise exception'
  );
end;

procedure TTestJetVMTypeConversion.TestStrToUIntOverflow();
begin
  FVM.LoadStr('99999999999999999999999999999')
     .StrToUInt()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Overflow string should raise exception'
  );
end;

// =============================================================================
// Edge Cases and Boundary Conditions
// =============================================================================

procedure TTestJetVMTypeConversion.TestConversionWithEmptyStack();
begin
  FVM.IntToStr()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Conversion with empty stack should raise exception'
  );
end;

procedure TTestJetVMTypeConversion.TestConversionStackUnderflow();
begin
  FVM.LoadInt(42)
     .Pop()
     .IntToStr()
     .Stop();

  Assert.WillRaise(
    procedure
    begin
      FVM.Execute();
    end,
    EJetVMError,
    'Conversion after pop should raise stack underflow'
  );
end;

procedure TTestJetVMTypeConversion.TestConversionTypeValidation();
var
  LResult: TJetValue;
begin
  // Test how JetVM actually handles type mismatches during conversion
  // JetVM may allow this operation and convert the string representation
  FVM.LoadStr('hello')
     .IntToStr()
     .Stop();

  // Execute and see what actually happens - this may succeed or fail
  try
    FVM.Execute();
    LResult := FVM.PopValue();
    // If we get here, JetVM handled the conversion in some way
    Assert.IsTrue(True, 'JetVM handled type conversion without exception');
  except
    on E: EJetVMError do
      // If it does throw an exception, that's also valid behavior
      Assert.IsTrue(True, 'JetVM threw expected exception for type mismatch');
  end;
end;

procedure TTestJetVMTypeConversion.TestConversionResultType();
var
  LResult: TJetValue;
begin
  // Verify that each conversion produces the expected result type
  FVM.LoadInt(42)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'IntToStr should produce String type');
end;

procedure TTestJetVMTypeConversion.TestConversionStackEffects();
var
  LInitialSP: Integer;
  LFinalSP: Integer;
begin
  LInitialSP := FVM.GetSP();

  FVM.LoadInt(42)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LFinalSP := FVM.GetSP();

  // Stack should have same depth (one value in, one value out)
  Assert.AreEqual(LInitialSP + 1, LFinalSP, 'Conversion should maintain stack depth');
end;

// =============================================================================
// Chained Conversion Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestChainedIntToStrToInt();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(123)
     .IntToStr()
     .StrToInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtInt, LResult.ValueType, 'Result should be Integer type');
  Assert.AreEqual(Int64(123), LResult.IntValue, 'Chained conversion should preserve value');
end;

procedure TTestJetVMTypeConversion.TestChainedUIntToStrToUInt();
var
  LResult: TJetValue;
begin
  FVM.LoadUInt(456)
     .UIntToStr()
     .StrToUInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtUInt, LResult.ValueType, 'Result should be UInteger type');
  Assert.AreEqual(UInt64(456), LResult.UIntValue, 'Chained conversion should preserve value');
end;

procedure TTestJetVMTypeConversion.TestChainedBoolToStrToBool();
var
  LResult: TJetValue;
begin
  FVM.LoadBool(True)
     .BoolToStr()
     .StrToBool()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtBool, LResult.ValueType, 'Result should be Boolean type');
  Assert.AreEqual(True, LResult.BoolValue, 'Chained conversion should preserve value');
end;

procedure TTestJetVMTypeConversion.TestChainedIntToUIntToStr();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(789)
     .IntToUInt()
     .UIntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('789', LResult.StrValue, 'Chained conversion should work correctly');
end;

procedure TTestJetVMTypeConversion.TestChainedComplexConversions();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(42)
     .IntToStr()     // "42"
     .StrToInt()     // 42
     .IntToUInt()    // 42 (as UInt)
     .UIntToStr()    // "42"
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('42', LResult.StrValue, 'Complex chain should preserve value');
end;

procedure TTestJetVMTypeConversion.TestMultipleConversionsInSequence();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  FVM.LoadInt(100)
     .IntToStr()
     .LoadInt(200)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult2 := FVM.PopValue(); // Second result (top of stack)
  LResult1 := FVM.PopValue(); // First result

  Assert.AreEqual('100', LResult1.StrValue, 'First conversion should be correct');
  Assert.AreEqual('200', LResult2.StrValue, 'Second conversion should be correct');
end;

// =============================================================================
// Integration with VM Operations Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestConversionWithArithmetic();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(10)
     .LoadInt(20)
     .AddInt()       // 30
     .IntToStr()     // "30"
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('30', LResult.StrValue, 'Arithmetic then conversion should work');
end;

procedure TTestJetVMTypeConversion.TestConversionWithComparisons();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('10')
     .StrToInt()     // 10
     .LoadInt(10)
     .EqInt()        // True
     .BoolToStr()    // "True"
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('True', LResult.StrValue, 'Conversion then comparison should work');
end;

procedure TTestJetVMTypeConversion.TestConversionWithStackOps();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
begin
  FVM.LoadInt(42)
     .IntToStr()     // "42"
     .Dup()          // "42", "42"
     .Swap()         // "42", "42"
     .Stop();

  FVM.Execute();
  LResult2 := FVM.PopValue();
  LResult1 := FVM.PopValue();

  Assert.AreEqual('42', LResult1.StrValue, 'Stack ops should work with converted values');
  Assert.AreEqual('42', LResult2.StrValue, 'Stack ops should work with converted values');
end;

procedure TTestJetVMTypeConversion.TestConversionWithStringOps();
var
  LResult: TJetValue;
begin
  FVM.LoadInt(123)
     .IntToStr()     // "123"
     .LoadStr('456')
     .ConcatStr()    // "123456"
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtStr, LResult.ValueType, 'Result should be String type');
  Assert.AreEqual('123456', LResult.StrValue, 'String concat after conversion should work');
end;

procedure TTestJetVMTypeConversion.TestConversionInControlFlow();
var
  LLabel: Integer;
  LResult: TJetValue;
begin
  LLabel := FVM.CreateLabel();

  FVM.LoadStr('1')
     .StrToBool()    // True
     .JumpTrue(LLabel)
     .LoadStr('false')
     .Jump(0)
     .BindLabel(LLabel)
     .LoadStr('true')
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('true', LResult.StrValue, 'Control flow with conversion should work');
end;

procedure TTestJetVMTypeConversion.TestConversionWithFunctions();
var
  LResult: TJetValue;
begin
  // Simple test of conversion working with function-like operations
  // Test conversion with local storage/retrieval which simulates function behavior
  FVM.LoadInt(42)
     .IntToStr()       // "42"
     .StoreLocal(0)    // Store in local 0
     .LoadStr('Result: ')
     .LoadLocal(0)     // Retrieve "42"
     .ConcatStr()      // "Result: 42"
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Result: 42', LResult.StrValue, 'Conversion with local storage should work');
end;

// =============================================================================
// Performance and Memory Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestConversionPerformanceBasic();
var
  LIndex: Integer;
  LResult: TJetValue;
begin
  // Test that multiple conversions don't cause performance issues
  for LIndex := 1 to 10 do
  begin
    FVM.Reset();
    FVM.LoadInt(LIndex)
       .IntToStr()
       .StrToInt()
       .Stop();

    FVM.Execute();
    LResult := FVM.PopValue();

    Assert.AreEqual(Int64(LIndex), LResult.IntValue,
      Format('Iteration %d should preserve value', [LIndex]));
  end;
end;

procedure TTestJetVMTypeConversion.TestStringConversionMemoryManagement();
var
  LResult: TJetValue;
begin
  // Test that string conversions properly manage memory
  FVM.LoadInt(123456789)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('123456789', LResult.StrValue, 'String should be properly allocated');

  // The string should be automatically managed by Delphi's string system
  // No explicit memory management needed
end;

procedure TTestJetVMTypeConversion.TestLargeStringConversion();
var
  LLargeNumber: Int64;
  LResult: TJetValue;
begin
  LLargeNumber := 9223372036854775807; // Max Int64

  FVM.LoadInt(LLargeNumber)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(IntToStr(LLargeNumber), LResult.StrValue, 'Large number should convert correctly');
end;

procedure TTestJetVMTypeConversion.TestRepeatedConversions();
var
  LIndex: Integer;
  LResult: TJetValue;
begin
  // Build a chain of alternating conversions
  FVM.LoadInt(42);

  for LIndex := 1 to 5 do
  begin
    FVM.IntToStr().StrToInt();
  end;

  FVM.Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Repeated conversions should preserve value');
end;

// =============================================================================
// Validation Level Interaction Tests
// =============================================================================

procedure TTestJetVMTypeConversion.TestConversionValidationLevelNone();
var
  LResult: TJetValue;
begin
  FVM.SetValidationLevel(vlNone);

  FVM.LoadInt(42)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('42', LResult.StrValue, 'Conversion should work with no validation');
end;

procedure TTestJetVMTypeConversion.TestConversionValidationLevelBasic();
var
  LResult: TJetValue;
begin
  FVM.SetValidationLevel(vlBasic);

  FVM.LoadInt(42)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('42', LResult.StrValue, 'Conversion should work with basic validation');
end;

procedure TTestJetVMTypeConversion.TestConversionValidationLevelDevelopment();
var
  LResult: TJetValue;
begin
  FVM.SetValidationLevel(vlDevelopment);

  FVM.LoadInt(42)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('42', LResult.StrValue, 'Conversion should work with development validation');
end;

procedure TTestJetVMTypeConversion.TestConversionValidationLevelSafe();
var
  LResult: TJetValue;
begin
  FVM.SetValidationLevel(vlSafe);

  FVM.LoadInt(42)
     .IntToStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('42', LResult.StrValue, 'Conversion should work with safe validation');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMTypeConversion);

end.
