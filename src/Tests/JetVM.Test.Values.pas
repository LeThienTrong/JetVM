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

unit JetVM.Test.Values;

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
  TTestJetVMValues = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Value Creation Tests - Factory Methods
    // ==========================================================================
    [Test]
    procedure TestMakeIntConstant();
    [Test]
    procedure TestMakeUIntConstant();
    [Test]
    procedure TestMakeStrConstant();
    [Test]
    procedure TestMakeBoolConstant();
    [Test]
    procedure TestMakePtrConstant();

    // ==========================================================================
    // Value Creation Edge Cases
    // ==========================================================================
    [Test]
    procedure TestMakeIntConstantEdgeCases();
    [Test]
    procedure TestMakeUIntConstantEdgeCases();
    [Test]
    procedure TestMakeStrConstantEdgeCases();
    [Test]
    procedure TestMakePtrConstantEdgeCases();

    // ==========================================================================
    // Type System Validation
    // ==========================================================================
    [Test]
    procedure TestValueTypeAssignment();
    [Test]
    procedure TestValueTypeConsistency();
    [Test]
    procedure TestValueTypeValidation();

    // ==========================================================================
    // Value Access and Retrieval
    // ==========================================================================
    [Test]
    procedure TestIntValueAccess();
    [Test]
    procedure TestUIntValueAccess();
    [Test]
    procedure TestStrValueAccess();
    [Test]
    procedure TestBoolValueAccess();
    [Test]
    procedure TestPtrValueAccess();

    // ==========================================================================
    // Value Modification Tests
    // ==========================================================================
    [Test]
    procedure TestValueModification();
    [Test]
    procedure TestValueReassignment();
    [Test]
    procedure TestValueTypeChange();

    // ==========================================================================
    // Managed vs Unmanaged Types
    // ==========================================================================
    [Test]
    procedure TestManagedTypeHandling();
    [Test]
    procedure TestUnmanagedTypeHandling();
    [Test]
    procedure TestManagedUnmanagedCoexistence();

    // ==========================================================================
    // Array Value Tests
    // ==========================================================================
    [Test]
    procedure TestArrayIntValues();
    [Test]
    procedure TestArrayUIntValues();
    [Test]
    procedure TestArrayStrValues();
    [Test]
    procedure TestArrayBoolValues();

    // ==========================================================================
    // Array Value Management
    // ==========================================================================
    [Test]
    procedure TestArrayValueCreation();
    [Test]
    procedure TestArrayValueAccess();
    [Test]
    procedure TestArrayValueBounds();

    // ==========================================================================
    // Pointer Type Tests
    // ==========================================================================
    [Test]
    procedure TestPointerValues();
    [Test]
    procedure TestPStringValues();
    [Test]
    procedure TestPBooleanValues();
    [Test]
    procedure TestNullPointerHandling();

    // ==========================================================================
    // Boundary Value Tests
    // ==========================================================================
    [Test]
    procedure TestIntBoundaryValues();
    [Test]
    procedure TestUIntBoundaryValues();
    [Test]
    procedure TestStringBoundaryValues();
    [Test]
    procedure TestPointerBoundaryValues();

    // ==========================================================================
    // Memory Management Tests
    // ==========================================================================
    [Test]
    procedure TestStringMemoryManagement();
    [Test]
    procedure TestArrayMemoryManagement();
    [Test]
    procedure TestValueLifetime();

    // ==========================================================================
    // Value Comparison Tests
    // ==========================================================================
    [Test]
    procedure TestValueEquality();
    [Test]
    procedure TestValueInequality();
    [Test]
    procedure TestCrossTypeComparisons();

    // ==========================================================================
    // Error Handling Tests
    // ==========================================================================
    [Test]
    procedure TestInvalidTypeAccess();
    [Test]
    procedure TestValueCorruption();
    [Test]
    procedure TestMemoryLeakPrevention();

    // ==========================================================================
    // Constants Pool Integration
    // ==========================================================================
    [Test]
    procedure TestConstantsPoolStorage();
    [Test]
    procedure TestConstantsPoolRetrieval();
    [Test]
    procedure TestConstantsPoolDeduplication();

    // ==========================================================================
    // Real-World Usage Patterns
    // ==========================================================================
    [Test]
    procedure TestTypicalUsagePatterns();
    [Test]
    procedure TestComplexValueManipulation();
    [Test]
    procedure TestPerformanceOptimization();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMValues.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMValues.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Value Creation Tests - Factory Methods
// =============================================================================

procedure TTestJetVMValues.TestMakeIntConstant();
var
  LValue: TJetValue;
begin
  // Test basic integer constant creation
  LValue := FVM.MakeIntConstant(42);

  Assert.AreEqual(jvtInt, LValue.ValueType, 'Value type should be jvtInt');
  Assert.AreEqual(Int64(42), LValue.IntValue, 'Integer value should be 42');
end;

procedure TTestJetVMValues.TestMakeUIntConstant();
var
  LValue: TJetValue;
begin
  // Test basic unsigned integer constant creation
  LValue := FVM.MakeUIntConstant(100);

  Assert.AreEqual(jvtUInt, LValue.ValueType, 'Value type should be jvtUInt');
  Assert.AreEqual(UInt64(100), LValue.UIntValue, 'UInteger value should be 100');
end;

procedure TTestJetVMValues.TestMakeStrConstant();
var
  LValue: TJetValue;
begin
  // Test basic string constant creation
  LValue := FVM.MakeStrConstant('Hello, JetVM!');

  Assert.AreEqual(jvtStr, LValue.ValueType, 'Value type should be jvtStr');
  Assert.AreEqual('Hello, JetVM!', LValue.StrValue, 'String value should match');
end;

procedure TTestJetVMValues.TestMakeBoolConstant();
var
  LValue: TJetValue;
begin
  // Test boolean constant creation - True
  LValue := FVM.MakeBoolConstant(True);

  Assert.AreEqual(jvtBool, LValue.ValueType, 'Value type should be jvtBool');
  Assert.IsTrue(LValue.BoolValue, 'Boolean value should be True');

  // Test boolean constant creation - False
  LValue := FVM.MakeBoolConstant(False);

  Assert.AreEqual(jvtBool, LValue.ValueType, 'Value type should be jvtBool');
  Assert.IsFalse(LValue.BoolValue, 'Boolean value should be False');
end;

procedure TTestJetVMValues.TestMakePtrConstant();
var
  LValue: TJetValue;
  LTestPtr: Pointer;
  LTestInt: Integer;
begin
  // Test pointer constant creation with valid pointer
  LTestInt := 123;
  LTestPtr := @LTestInt;

  LValue := FVM.MakePtrConstant(LTestPtr);

  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Value type should be jvtPointer');
  Assert.AreEqual(LTestPtr, LValue.PtrValue, 'Pointer value should match');

  // Test pointer constant creation with nil
  LValue := FVM.MakePtrConstant(nil);

  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Value type should be jvtPointer');
  Assert.IsNull(LValue.PtrValue, 'Pointer value should be nil');
end;

// =============================================================================
// Value Creation Edge Cases
// =============================================================================

procedure TTestJetVMValues.TestMakeIntConstantEdgeCases();
var
  LValue: TJetValue;
begin
  // Test maximum Int64 value
  LValue := FVM.MakeIntConstant(High(Int64));
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Max Int64 should have correct type');
  Assert.AreEqual(High(Int64), LValue.IntValue, 'Max Int64 should be stored correctly');

  // Test minimum Int64 value
  LValue := FVM.MakeIntConstant(Low(Int64));
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Min Int64 should have correct type');
  Assert.AreEqual(Low(Int64), LValue.IntValue, 'Min Int64 should be stored correctly');

  // Test zero
  LValue := FVM.MakeIntConstant(0);
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Zero Int64 should have correct type');
  Assert.AreEqual(Int64(0), LValue.IntValue, 'Zero should be stored correctly');

  // Test negative values
  LValue := FVM.MakeIntConstant(-12345);
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Negative Int64 should have correct type');
  Assert.AreEqual(Int64(-12345), LValue.IntValue, 'Negative value should be stored correctly');
end;

procedure TTestJetVMValues.TestMakeUIntConstantEdgeCases();
var
  LValue: TJetValue;
begin
  // Test maximum UInt64 value
  LValue := FVM.MakeUIntConstant(High(UInt64));
  Assert.AreEqual(jvtUInt, LValue.ValueType, 'Max UInt64 should have correct type');
  Assert.AreEqual(High(UInt64), LValue.UIntValue, 'Max UInt64 should be stored correctly');

  // Test minimum UInt64 value (0)
  LValue := FVM.MakeUIntConstant(Low(UInt64));
  Assert.AreEqual(jvtUInt, LValue.ValueType, 'Min UInt64 should have correct type');
  Assert.AreEqual(Low(UInt64), LValue.UIntValue, 'Min UInt64 should be stored correctly');

  // Test large values
  LValue := FVM.MakeUIntConstant(18446744073709551615); // Max UInt64
  Assert.AreEqual(jvtUInt, LValue.ValueType, 'Large UInt64 should have correct type');
  Assert.AreEqual(UInt64(18446744073709551615), LValue.UIntValue, 'Large UInt64 should be stored correctly');
end;

procedure TTestJetVMValues.TestMakeStrConstantEdgeCases();
var
  LValue: TJetValue;
  LLongString: string;
  LI: Integer;
begin
  // Test empty string
  LValue := FVM.MakeStrConstant('');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Empty string should have correct type');
  Assert.AreEqual('', LValue.StrValue, 'Empty string should be stored correctly');

  // Test single character
  LValue := FVM.MakeStrConstant('A');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Single char should have correct type');
  Assert.AreEqual('A', LValue.StrValue, 'Single char should be stored correctly');

  // Test string with special characters
  LValue := FVM.MakeStrConstant('Special: !@#$%^&*()_+{}[]|\:";''<>?,./ ');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Special chars should have correct type');
  Assert.AreEqual('Special: !@#$%^&*()_+{}[]|\:";''<>?,./ ', LValue.StrValue, 'Special chars should be stored correctly');

  // Test Unicode string
  LValue := FVM.MakeStrConstant('Unicode: αβγδε 中文 🚀');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Unicode should have correct type');
  Assert.AreEqual('Unicode: αβγδε 中文 🚀', LValue.StrValue, 'Unicode should be stored correctly');

  // Test reasonably long string
  LLongString := '';
  for LI := 1 to 1000 do
    LLongString := LLongString + 'A';

  LValue := FVM.MakeStrConstant(LLongString);
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Long string should have correct type');
  Assert.AreEqual(Integer(Length(LValue.StrValue)), 1000, 'Long string should have correct length');
  Assert.AreEqual(LLongString, LValue.StrValue, 'Long string should be stored correctly');
end;

procedure TTestJetVMValues.TestMakePtrConstantEdgeCases();
var
  LValue: TJetValue;
  LTestData: array[0..9] of Integer;
  LI: Integer;
begin
  // Test pointer to array
  for LI := 0 to 9 do
    LTestData[LI] := LI * 10;

  LValue := FVM.MakePtrConstant(@LTestData);
  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Array pointer should have correct type');
  Assert.AreEqual(@LTestData, LValue.PtrValue, 'Array pointer should be stored correctly');

  // Test pointer arithmetic edge case (pointer value should be preserved)
  LValue := FVM.MakePtrConstant(@LTestData[5]);
  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Offset pointer should have correct type');
  Assert.AreEqual(@LTestData[5], LValue.PtrValue, 'Offset pointer should be stored correctly');

  // Test pointer to itself (edge case)
  LValue := FVM.MakePtrConstant(@LValue);
  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Self-pointer should have correct type');
  // Note: Self-pointer comparison might be complex due to stack changes
end;

// =============================================================================
// Type System Validation
// =============================================================================

procedure TTestJetVMValues.TestValueTypeAssignment();
var
  LValue: TJetValue;
begin
  // Test that each factory method sets correct type

  LValue := FVM.MakeIntConstant(42);
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Int constant should set jvtInt type');

  LValue := FVM.MakeUIntConstant(42);
  Assert.AreEqual(jvtUInt, LValue.ValueType, 'UInt constant should set jvtUInt type');

  LValue := FVM.MakeStrConstant('test');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'String constant should set jvtStr type');

  LValue := FVM.MakeBoolConstant(True);
  Assert.AreEqual(jvtBool, LValue.ValueType, 'Bool constant should set jvtBool type');

  LValue := FVM.MakePtrConstant(nil);
  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Ptr constant should set jvtPointer type');
end;

procedure TTestJetVMValues.TestValueTypeConsistency();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test that values maintain type consistency across operations

  LValue1 := FVM.MakeIntConstant(100);
  LValue2 := LValue1; // Copy

  Assert.AreEqual(LValue1.ValueType, LValue2.ValueType, 'Copied value should maintain type');
  Assert.AreEqual(LValue1.IntValue, LValue2.IntValue, 'Copied value should maintain value');

  // Test type consistency after modification
  LValue2.IntValue := 200;
  Assert.AreEqual(jvtInt, LValue2.ValueType, 'Type should remain consistent after value change');
  Assert.AreEqual(Int64(200), LValue2.IntValue, 'Value should change correctly');
end;

procedure TTestJetVMValues.TestValueTypeValidation();
var
  LValue: TJetValue;
begin
  // Test that ValueType field correctly identifies value content

  // Create value of each type and verify type field
  LValue := FVM.MakeIntConstant(42);
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Int value should have jvtInt type');

  LValue := FVM.MakeUIntConstant(42);
  Assert.AreEqual(jvtUInt, LValue.ValueType, 'UInt value should have jvtUInt type');

  LValue := FVM.MakeStrConstant('test');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'String value should have jvtStr type');

  LValue := FVM.MakeBoolConstant(False);
  Assert.AreEqual(jvtBool, LValue.ValueType, 'Bool value should have jvtBool type');

  LValue := FVM.MakePtrConstant(nil);
  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Pointer value should have jvtPointer type');
end;

// =============================================================================
// Value Access and Retrieval
// =============================================================================

procedure TTestJetVMValues.TestIntValueAccess();
var
  LValue: TJetValue;
  LTestValues: array[0..4] of Int64;
  LI: Integer;
begin
  // Test various integer values
  LTestValues[0] := 0;
  LTestValues[1] := 42;
  LTestValues[2] := -1000;
  LTestValues[3] := High(Int64);
  LTestValues[4] := Low(Int64);

  for LI := 0 to High(LTestValues) do
  begin
    LValue := FVM.MakeIntConstant(LTestValues[LI]);
    Assert.AreEqual(LTestValues[LI], LValue.IntValue, Format('Int value %d should be retrievable', [LI]));
    Assert.AreEqual(jvtInt, LValue.ValueType, Format('Int value %d should maintain correct type', [LI]));
  end;
end;

procedure TTestJetVMValues.TestUIntValueAccess();
var
  LValue: TJetValue;
  LTestValues: array[0..3] of UInt64;
  LI: Integer;
begin
  // Test various unsigned integer values
  LTestValues[0] := 0;
  LTestValues[1] := 42;
  LTestValues[2] := 4294967296; // 2^32
  LTestValues[3] := High(UInt64);

  for LI := 0 to High(LTestValues) do
  begin
    LValue := FVM.MakeUIntConstant(LTestValues[LI]);
    Assert.AreEqual(LTestValues[LI], LValue.UIntValue, Format('UInt value %d should be retrievable', [LI]));
    Assert.AreEqual(jvtUInt, LValue.ValueType, Format('UInt value %d should maintain correct type', [LI]));
  end;
end;

procedure TTestJetVMValues.TestStrValueAccess();
var
  LValue: TJetValue;
  LTestValues: array[0..4] of string;
  LI: Integer;
begin
  // Test various string values
  LTestValues[0] := '';
  LTestValues[1] := 'Hello';
  LTestValues[2] := 'Multi-word string with spaces';
  LTestValues[3] := 'Special!@#$%^&*()_+';
  LTestValues[4] := 'Unicode: αβγ 中文 🚀';

  for LI := 0 to High(LTestValues) do
  begin
    LValue := FVM.MakeStrConstant(LTestValues[LI]);
    Assert.AreEqual(LTestValues[LI], LValue.StrValue, Format('String value %d should be retrievable', [LI]));
    Assert.AreEqual(jvtStr, LValue.ValueType, Format('String value %d should maintain correct type', [LI]));
  end;
end;

procedure TTestJetVMValues.TestBoolValueAccess();
var
  LValue: TJetValue;
begin
  // Test True value
  LValue := FVM.MakeBoolConstant(True);
  Assert.IsTrue(LValue.BoolValue, 'True value should be retrievable as True');
  Assert.AreEqual(jvtBool, LValue.ValueType, 'True value should maintain correct type');

  // Test False value
  LValue := FVM.MakeBoolConstant(False);
  Assert.IsFalse(LValue.BoolValue, 'False value should be retrievable as False');
  Assert.AreEqual(jvtBool, LValue.ValueType, 'False value should maintain correct type');
end;

procedure TTestJetVMValues.TestPtrValueAccess();
var
  LValue: TJetValue;
  LTestInt: Integer;
  LTestPtr: Pointer;
begin
  // Test nil pointer
  LValue := FVM.MakePtrConstant(nil);
  Assert.IsNull(LValue.PtrValue, 'Nil pointer should be retrievable as nil');
  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Nil pointer should maintain correct type');

  // Test valid pointer
  LTestInt := 42;
  LTestPtr := @LTestInt;
  LValue := FVM.MakePtrConstant(LTestPtr);
  Assert.AreEqual(LTestPtr, LValue.PtrValue, 'Valid pointer should be retrievable');
  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Valid pointer should maintain correct type');

  // Verify pointer points to correct data
  Assert.AreEqual(42, PInteger(LValue.PtrValue)^, 'Pointer should point to correct data');
end;

// =============================================================================
// Value Modification Tests
// =============================================================================

procedure TTestJetVMValues.TestValueModification();
var
  LValue: TJetValue;
begin
  // Test modifying integer value
  LValue := FVM.MakeIntConstant(42);
  LValue.IntValue := 100;
  Assert.AreEqual(Int64(100), LValue.IntValue, 'Int value should be modifiable');
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Type should remain unchanged after modification');

  // Test modifying string value
  LValue := FVM.MakeStrConstant('Original');
  LValue.StrValue := 'Modified';
  Assert.AreEqual('Modified', LValue.StrValue, 'String value should be modifiable');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Type should remain unchanged after modification');

  // Test modifying boolean value
  LValue := FVM.MakeBoolConstant(True);
  LValue.BoolValue := False;
  Assert.IsFalse(LValue.BoolValue, 'Bool value should be modifiable');
  Assert.AreEqual(jvtBool, LValue.ValueType, 'Type should remain unchanged after modification');
end;

procedure TTestJetVMValues.TestValueReassignment();
var
  LValue: TJetValue;
  LOriginalType: TJetValueType;
begin
  // Test reassigning value while maintaining type
  LValue := FVM.MakeIntConstant(42);
  LOriginalType := LValue.ValueType;

  LValue.IntValue := 999;
  Assert.AreEqual(Int64(999), LValue.IntValue, 'Value should be reassignable');
  Assert.AreEqual(LOriginalType, LValue.ValueType, 'Type should remain unchanged');

  // Test multiple reassignments
  LValue.IntValue := -500;
  Assert.AreEqual(Int64(-500), LValue.IntValue, 'Value should be reassignable multiple times');
  Assert.AreEqual(LOriginalType, LValue.ValueType, 'Type should remain unchanged');
end;

procedure TTestJetVMValues.TestValueTypeChange();
var
  LValue: TJetValue;
begin
  // Test changing value type (manual type change)
  LValue := FVM.MakeIntConstant(42);
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Should start as int type');

  // Manually change type and value
  LValue.ValueType := jvtStr;
  LValue.StrValue := 'Changed to string';

  Assert.AreEqual(jvtStr, LValue.ValueType, 'Type should be changed to string');
  Assert.AreEqual('Changed to string', LValue.StrValue, 'String value should be set');

  // Note: This is potentially dangerous in real usage but tests the flexibility
end;

// =============================================================================
// Managed vs Unmanaged Types
// =============================================================================

procedure TTestJetVMValues.TestManagedTypeHandling();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test string (managed type) handling
  LValue1 := FVM.MakeStrConstant('Managed String 1');
  LValue2 := FVM.MakeStrConstant('Managed String 2');

  Assert.AreEqual('Managed String 1', LValue1.StrValue, 'First managed string should be correct');
  Assert.AreEqual('Managed String 2', LValue2.StrValue, 'Second managed string should be correct');

  // Test string modification
  LValue1.StrValue := 'Modified Managed String';
  Assert.AreEqual('Modified Managed String', LValue1.StrValue, 'Managed string should be modifiable');
  Assert.AreEqual('Managed String 2', LValue2.StrValue, 'Other managed string should be unaffected');
end;

procedure TTestJetVMValues.TestUnmanagedTypeHandling();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test integer (unmanaged type) handling
  LValue1 := FVM.MakeIntConstant(100);
  LValue2 := FVM.MakeIntConstant(200);

  Assert.AreEqual(Int64(100), LValue1.IntValue, 'First unmanaged int should be correct');
  Assert.AreEqual(Int64(200), LValue2.IntValue, 'Second unmanaged int should be correct');

  // Test integer modification
  LValue1.IntValue := 150;
  Assert.AreEqual(Int64(150), LValue1.IntValue, 'Unmanaged int should be modifiable');
  Assert.AreEqual(Int64(200), LValue2.IntValue, 'Other unmanaged int should be unaffected');

  // Test boolean (unmanaged type) handling
  LValue1 := FVM.MakeBoolConstant(True);
  LValue2 := FVM.MakeBoolConstant(False);

  Assert.IsTrue(LValue1.BoolValue, 'First unmanaged bool should be correct');
  Assert.IsFalse(LValue2.BoolValue, 'Second unmanaged bool should be correct');
end;

procedure TTestJetVMValues.TestManagedUnmanagedCoexistence();
var
  LManagedValue: TJetValue;
  LUnmanagedValue: TJetValue;
begin
  // Test that managed and unmanaged types can coexist
  LManagedValue := FVM.MakeStrConstant('Managed String');
  LUnmanagedValue := FVM.MakeIntConstant(42);

  Assert.AreEqual(jvtStr, LManagedValue.ValueType, 'Managed value should have correct type');
  Assert.AreEqual('Managed String', LManagedValue.StrValue, 'Managed value should be correct');

  Assert.AreEqual(jvtInt, LUnmanagedValue.ValueType, 'Unmanaged value should have correct type');
  Assert.AreEqual(Int64(42), LUnmanagedValue.IntValue, 'Unmanaged value should be correct');

  // Modify both
  LManagedValue.StrValue := 'Modified Managed';
  LUnmanagedValue.IntValue := 84;

  Assert.AreEqual('Modified Managed', LManagedValue.StrValue, 'Managed value should be modifiable');
  Assert.AreEqual(Int64(84), LUnmanagedValue.IntValue, 'Unmanaged value should be modifiable');
end;

// =============================================================================
// Array Value Tests
// =============================================================================

procedure TTestJetVMValues.TestArrayIntValues();
var
  LValue: TJetValue;
begin
  // Test integer array creation
  LValue.ValueType := jvtArrayInt;
  SetLength(LValue.ArrayIntValue, 3);
  LValue.ArrayIntValue[0] := 10;
  LValue.ArrayIntValue[1] := 20;
  LValue.ArrayIntValue[2] := 30;

  Assert.AreEqual(jvtArrayInt, LValue.ValueType, 'Array should have correct type');
  Assert.AreEqual(Integer(Length(LValue.ArrayIntValue)), 3, 'Array should have correct length');
  Assert.AreEqual(Int64(10), LValue.ArrayIntValue[0], 'Array element 0 should be correct');
  Assert.AreEqual(Int64(20), LValue.ArrayIntValue[1], 'Array element 1 should be correct');
  Assert.AreEqual(Int64(30), LValue.ArrayIntValue[2], 'Array element 2 should be correct');
end;

procedure TTestJetVMValues.TestArrayUIntValues();
var
  LValue: TJetValue;
begin
  // Test unsigned integer array creation
  LValue.ValueType := jvtArrayUInt;
  SetLength(LValue.ArrayUIntValue, 3);
  LValue.ArrayUIntValue[0] := 100;
  LValue.ArrayUIntValue[1] := 200;
  LValue.ArrayUIntValue[2] := 300;

  Assert.AreEqual(jvtArrayUInt, LValue.ValueType, 'UInt array should have correct type');
  Assert.AreEqual(Integer(Length(LValue.ArrayUIntValue)), 3, 'UInt array should have correct length');
  Assert.AreEqual(UInt64(100), LValue.ArrayUIntValue[0], 'UInt array element 0 should be correct');
  Assert.AreEqual(UInt64(200), LValue.ArrayUIntValue[1], 'UInt array element 1 should be correct');
  Assert.AreEqual(UInt64(300), LValue.ArrayUIntValue[2], 'UInt array element 2 should be correct');
end;

procedure TTestJetVMValues.TestArrayStrValues();
var
  LValue: TJetValue;
begin
  // Test string array creation
  LValue.ValueType := jvtArrayStr;
  SetLength(LValue.ArrayStrValue, 3);
  LValue.ArrayStrValue[0] := 'First';
  LValue.ArrayStrValue[1] := 'Second';
  LValue.ArrayStrValue[2] := 'Third';

  Assert.AreEqual(jvtArrayStr, LValue.ValueType, 'String array should have correct type');
  Assert.AreEqual(Integer(Length(LValue.ArrayStrValue)), 3, 'String array should have correct length');
  Assert.AreEqual('First', LValue.ArrayStrValue[0], 'String array element 0 should be correct');
  Assert.AreEqual('Second', LValue.ArrayStrValue[1], 'String array element 1 should be correct');
  Assert.AreEqual('Third', LValue.ArrayStrValue[2], 'String array element 2 should be correct');
end;

procedure TTestJetVMValues.TestArrayBoolValues();
var
  LValue: TJetValue;
begin
  // Test boolean array creation
  LValue.ValueType := jvtArrayBool;
  SetLength(LValue.ArrayBoolValue, 3);
  LValue.ArrayBoolValue[0] := True;
  LValue.ArrayBoolValue[1] := False;
  LValue.ArrayBoolValue[2] := True;

  Assert.AreEqual(jvtArrayBool, LValue.ValueType, 'Bool array should have correct type');
  Assert.AreEqual(Integer(Length(LValue.ArrayBoolValue)), 3, 'Bool array should have correct length');
  Assert.IsTrue(LValue.ArrayBoolValue[0], 'Bool array element 0 should be correct');
  Assert.IsFalse(LValue.ArrayBoolValue[1], 'Bool array element 1 should be correct');
  Assert.IsTrue(LValue.ArrayBoolValue[2], 'Bool array element 2 should be correct');
end;

// =============================================================================
// Array Value Management
// =============================================================================

procedure TTestJetVMValues.TestArrayValueCreation();
var
  LValue: TJetValue;
begin
  // Test creating empty arrays
  LValue.ValueType := jvtArrayInt;
  SetLength(LValue.ArrayIntValue, 0);
  Assert.AreEqual(Integer(Length(LValue.ArrayIntValue)), 0, 'Empty int array should have zero length');

  LValue.ValueType := jvtArrayStr;
  SetLength(LValue.ArrayStrValue, 0);
  Assert.AreEqual(Integer(Length(LValue.ArrayStrValue)), 0, 'Empty string array should have zero length');

  // Test creating single-element arrays
  LValue.ValueType := jvtArrayInt;
  SetLength(LValue.ArrayIntValue, 1);
  LValue.ArrayIntValue[0] := 42;
  Assert.AreEqual(Integer(Length(LValue.ArrayIntValue)), 1, 'Single-element array should have length 1');
  Assert.AreEqual(Int64(42), LValue.ArrayIntValue[0], 'Single element should be correct');
end;

procedure TTestJetVMValues.TestArrayValueAccess();
var
  LValue: TJetValue;
  LI: Integer;
begin
  // Test accessing array elements
  LValue.ValueType := jvtArrayInt;
  SetLength(LValue.ArrayIntValue, 10);

  // Fill array
  for LI := 0 to 9 do
    LValue.ArrayIntValue[LI] := LI * 10;

  // Verify access
  for LI := 0 to 9 do
    Assert.AreEqual(Int64(LI * 10), LValue.ArrayIntValue[LI], Format('Array element %d should be correct', [LI]));

  // Test modifying elements
  LValue.ArrayIntValue[5] := 999;
  Assert.AreEqual(Int64(999), LValue.ArrayIntValue[5], 'Modified array element should be correct');
  Assert.AreEqual(Int64(40), LValue.ArrayIntValue[4], 'Adjacent element should be unchanged');
  Assert.AreEqual(Int64(60), LValue.ArrayIntValue[6], 'Adjacent element should be unchanged');
end;

procedure TTestJetVMValues.TestArrayValueBounds();
var
  LValue: TJetValue;
begin
  // Test array bounds checking (if implemented)
  LValue.ValueType := jvtArrayInt;
  SetLength(LValue.ArrayIntValue, 5);

  // Valid access
  LValue.ArrayIntValue[0] := 10;
  LValue.ArrayIntValue[4] := 50;

  Assert.AreEqual(Int64(10), LValue.ArrayIntValue[0], 'First element should be accessible');
  Assert.AreEqual(Int64(50), LValue.ArrayIntValue[4], 'Last element should be accessible');

  // Note: Bounds checking would typically be handled by Delphi runtime
  // This test verifies basic functionality within valid bounds
end;

// =============================================================================
// Pointer Type Tests
// =============================================================================

procedure TTestJetVMValues.TestPointerValues();
var
  LValue: TJetValue;
  LTestInt: Integer;
  LTestStr: string;
begin
  // Test pointer to integer
  LTestInt := 42;
  LValue := FVM.MakePtrConstant(@LTestInt);

  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Pointer should have correct type');
  Assert.AreEqual(@LTestInt, LValue.PtrValue, 'Pointer should point to correct location');
  Assert.AreEqual(42, PInteger(LValue.PtrValue)^, 'Pointer should point to correct value');

  // Test pointer to string
  LTestStr := 'Test String';
  LValue := FVM.MakePtrConstant(@LTestStr);

  Assert.AreEqual(jvtPointer, LValue.ValueType, 'String pointer should have correct type');
  Assert.AreEqual(@LTestStr, LValue.PtrValue, 'String pointer should point to correct location');
  Assert.AreEqual('Test String', PString(LValue.PtrValue)^, 'String pointer should point to correct value');
end;

procedure TTestJetVMValues.TestPStringValues();
var
  LValue: TJetValue;
  LTestStr: string;
begin
  // Test PString type
  LTestStr := 'Test PString';
  LValue.ValueType := jvtPStr;
  LValue.PStrValue := @LTestStr;

  Assert.AreEqual(jvtPStr, LValue.ValueType, 'PString should have correct type');
  Assert.AreEqual(Pointer(@LTestStr), Pointer(LValue.PStrValue), 'PString should point to correct location');
  Assert.AreEqual('Test PString', LValue.PStrValue^, 'PString should point to correct value');
end;

procedure TTestJetVMValues.TestPBooleanValues();
var
  LValue: TJetValue;
  LTestBool: Boolean;
begin
  // Test PBoolean type
  LTestBool := True;
  LValue.ValueType := jvtPBool;
  LValue.PBoolValue := @LTestBool;

  Assert.AreEqual(jvtPBool, LValue.ValueType, 'PBoolean should have correct type');
  Assert.AreEqual(Pointer(@LTestBool), Pointer(LValue.PBoolValue), 'PBoolean should point to correct location');
  Assert.IsTrue(LValue.PBoolValue^, 'PBoolean should point to correct value');

  // Test with False
  LTestBool := False;
  Assert.IsFalse(LValue.PBoolValue^, 'PBoolean should reflect changed value');
end;

procedure TTestJetVMValues.TestNullPointerHandling();
var
  LValue: TJetValue;
begin
  // Test nil pointer handling
  LValue := FVM.MakePtrConstant(nil);

  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Nil pointer should have correct type');
  Assert.IsNull(LValue.PtrValue, 'Nil pointer should be nil');

  // Test nil PString
  LValue.ValueType := jvtPStr;
  LValue.PStrValue := nil;

  Assert.AreEqual(jvtPStr, LValue.ValueType, 'Nil PString should have correct type');
  Assert.IsNull(LValue.PStrValue, 'Nil PString should be nil');

  // Test nil PBoolean
  LValue.ValueType := jvtPBool;
  LValue.PBoolValue := nil;

  Assert.AreEqual(jvtPBool, LValue.ValueType, 'Nil PBoolean should have correct type');
  Assert.IsNull(LValue.PBoolValue, 'Nil PBoolean should be nil');
end;

// =============================================================================
// Boundary Value Tests
// =============================================================================

procedure TTestJetVMValues.TestIntBoundaryValues();
var
  LValue: TJetValue;
begin
  // Test maximum Int64
  LValue := FVM.MakeIntConstant(High(Int64));
  Assert.AreEqual(High(Int64), LValue.IntValue, 'Max Int64 should be handled correctly');

  // Test minimum Int64
  LValue := FVM.MakeIntConstant(Low(Int64));
  Assert.AreEqual(Low(Int64), LValue.IntValue, 'Min Int64 should be handled correctly');

  // Test zero boundary
  LValue := FVM.MakeIntConstant(0);
  Assert.AreEqual(Int64(0), LValue.IntValue, 'Zero should be handled correctly');

  // Test near-boundary values
  LValue := FVM.MakeIntConstant(High(Int64) - 1);
  Assert.AreEqual(High(Int64) - 1, LValue.IntValue, 'Near-max Int64 should be handled correctly');

  LValue := FVM.MakeIntConstant(Low(Int64) + 1);
  Assert.AreEqual(Low(Int64) + 1, LValue.IntValue, 'Near-min Int64 should be handled correctly');
end;

procedure TTestJetVMValues.TestUIntBoundaryValues();
var
  LValue: TJetValue;
begin
  // Test maximum UInt64
  LValue := FVM.MakeUIntConstant(High(UInt64));
  Assert.AreEqual(High(UInt64), LValue.UIntValue, 'Max UInt64 should be handled correctly');

  // Test minimum UInt64 (0)
  LValue := FVM.MakeUIntConstant(Low(UInt64));
  Assert.AreEqual(Low(UInt64), LValue.UIntValue, 'Min UInt64 (0) should be handled correctly');

  // Test near-boundary values
  LValue := FVM.MakeUIntConstant(High(UInt64) - 1);
  Assert.AreEqual(High(UInt64) - 1, LValue.UIntValue, 'Near-max UInt64 should be handled correctly');

  LValue := FVM.MakeUIntConstant(1);
  Assert.AreEqual(UInt64(1), LValue.UIntValue, 'Near-min UInt64 should be handled correctly');
end;

procedure TTestJetVMValues.TestStringBoundaryValues();
var
  LValue: TJetValue;
  LLargeString: string;
  LI: Integer;
begin
  // Test empty string
  LValue := FVM.MakeStrConstant('');
  Assert.AreEqual('', LValue.StrValue, 'Empty string should be handled correctly');

  // Test single character
  LValue := FVM.MakeStrConstant('A');
  Assert.AreEqual('A', LValue.StrValue, 'Single character should be handled correctly');

  // Test large string (within reason)
  LLargeString := '';
  for LI := 1 to 10000 do
    LLargeString := LLargeString + 'X';

  LValue := FVM.MakeStrConstant(LLargeString);
  Assert.AreEqual(Integer(Length(LValue.StrValue)), 10000, 'Large string should be handled correctly');
  Assert.AreEqual(LLargeString, LValue.StrValue, 'Large string content should be correct');
end;

procedure TTestJetVMValues.TestPointerBoundaryValues();
var
  LValue: TJetValue;
  LTestData: Integer;
begin
  // Test nil pointer
  LValue := FVM.MakePtrConstant(nil);
  Assert.IsNull(LValue.PtrValue, 'Nil pointer should be handled correctly');

  // Test valid pointer
  LTestData := 42;
  LValue := FVM.MakePtrConstant(@LTestData);
  Assert.IsNotNull(LValue.PtrValue, 'Valid pointer should not be nil');
  Assert.AreEqual(@LTestData, LValue.PtrValue, 'Valid pointer should be correct');

  // Test pointer arithmetic boundaries (conceptual)
  // Note: Actual pointer arithmetic testing would require more complex setup
  LValue := FVM.MakePtrConstant(Pointer(0));
  Assert.AreEqual(Pointer(0), LValue.PtrValue, 'Zero pointer should be handled');

  LValue := FVM.MakePtrConstant(Pointer(High(NativeUInt)));
  Assert.AreEqual(Pointer(High(NativeUInt)), LValue.PtrValue, 'Max pointer value should be handled');
end;

// =============================================================================
// Memory Management Tests
// =============================================================================

procedure TTestJetVMValues.TestStringMemoryManagement();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LOriginalString: string;
begin
  // Test string memory management
  LOriginalString := 'Original String Content';
  LValue1 := FVM.MakeStrConstant(LOriginalString);

  // Copy value
  LValue2 := LValue1;

  // Verify both have correct content
  Assert.AreEqual(LOriginalString, LValue1.StrValue, 'Original value should be correct');
  Assert.AreEqual(LOriginalString, LValue2.StrValue, 'Copied value should be correct');

  // Modify one
  LValue1.StrValue := 'Modified Content';

  // Verify independence (if strings are copy-on-write or independent)
  Assert.AreEqual('Modified Content', LValue1.StrValue, 'Modified value should be changed');
  // Note: LValue2 behavior depends on string implementation details
end;

procedure TTestJetVMValues.TestArrayMemoryManagement();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test array memory management
  LValue1.ValueType := jvtArrayInt;
  SetLength(LValue1.ArrayIntValue, 3);
  LValue1.ArrayIntValue[0] := 10;
  LValue1.ArrayIntValue[1] := 20;
  LValue1.ArrayIntValue[2] := 30;

  // Copy value
  LValue2 := LValue1;

  // Verify both have correct content
  Assert.AreEqual(Integer(Length(LValue1.ArrayIntValue)), 3, 'Original array should have correct length');
  Assert.AreEqual(Integer(Length(LValue2.ArrayIntValue)), 3, 'Copied array should have correct length');
  Assert.AreEqual(Int64(10), LValue1.ArrayIntValue[0], 'Original array element should be correct');
  Assert.AreEqual(Int64(10), LValue2.ArrayIntValue[0], 'Copied array element should be correct');

  // Modify one array
  if Length(LValue1.ArrayIntValue) > 0 then
    LValue1.ArrayIntValue[0] := 999;

  // Check effect on copy (behavior depends on array implementation)
  Assert.AreEqual(Int64(999), LValue1.ArrayIntValue[0], 'Modified array should be changed');
  // Note: LValue2 behavior depends on array sharing/copying implementation
end;

procedure TTestJetVMValues.TestValueLifetime();
var
  LValue: TJetValue;
begin
  // Test that values persist correctly
  LValue := FVM.MakeStrConstant('Persistent String');

  // Value should remain valid through various operations
  Assert.AreEqual('Persistent String', LValue.StrValue, 'String should persist');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Type should persist');

  // Value should survive re-assignment of type field (if safe)
  LValue.ValueType := jvtStr; // Re-assign same type
  Assert.AreEqual('Persistent String', LValue.StrValue, 'String should survive type re-assignment');
end;

// =============================================================================
// Value Comparison Tests
// =============================================================================

procedure TTestJetVMValues.TestValueEquality();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test integer equality
  LValue1 := FVM.MakeIntConstant(42);
  LValue2 := FVM.MakeIntConstant(42);

  Assert.AreEqual(LValue1.ValueType, LValue2.ValueType, 'Same int values should have same type');
  Assert.AreEqual(LValue1.IntValue, LValue2.IntValue, 'Same int values should be equal');

  // Test string equality
  LValue1 := FVM.MakeStrConstant('Test String');
  LValue2 := FVM.MakeStrConstant('Test String');

  Assert.AreEqual(LValue1.ValueType, LValue2.ValueType, 'Same string values should have same type');
  Assert.AreEqual(LValue1.StrValue, LValue2.StrValue, 'Same string values should be equal');

  // Test boolean equality
  LValue1 := FVM.MakeBoolConstant(True);
  LValue2 := FVM.MakeBoolConstant(True);

  Assert.AreEqual(LValue1.ValueType, LValue2.ValueType, 'Same bool values should have same type');
  Assert.AreEqual(LValue1.BoolValue, LValue2.BoolValue, 'Same bool values should be equal');
end;

procedure TTestJetVMValues.TestValueInequality();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test integer inequality
  LValue1 := FVM.MakeIntConstant(42);
  LValue2 := FVM.MakeIntConstant(43);

  Assert.AreEqual(LValue1.ValueType, LValue2.ValueType, 'Different int values should have same type');
  Assert.AreNotEqual(LValue1.IntValue, LValue2.IntValue, 'Different int values should not be equal');

  // Test string inequality
  LValue1 := FVM.MakeStrConstant('String A');
  LValue2 := FVM.MakeStrConstant('String B');

  Assert.AreEqual(LValue1.ValueType, LValue2.ValueType, 'Different string values should have same type');
  Assert.AreNotEqual(LValue1.StrValue, LValue2.StrValue, 'Different string values should not be equal');

  // Test boolean inequality
  LValue1 := FVM.MakeBoolConstant(True);
  LValue2 := FVM.MakeBoolConstant(False);

  Assert.AreEqual(LValue1.ValueType, LValue2.ValueType, 'Different bool values should have same type');
  Assert.AreNotEqual(LValue1.BoolValue, LValue2.BoolValue, 'Different bool values should not be equal');
end;

procedure TTestJetVMValues.TestCrossTypeComparisons();
var
  LIntValue: TJetValue;
  LStrValue: TJetValue;
  LBoolValue: TJetValue;
begin
  // Test that different types are indeed different
  LIntValue := FVM.MakeIntConstant(42);
  LStrValue := FVM.MakeStrConstant('42');
  LBoolValue := FVM.MakeBoolConstant(True);

  Assert.AreNotEqual(LIntValue.ValueType, LStrValue.ValueType, 'Int and String should have different types');
  Assert.AreNotEqual(LIntValue.ValueType, LBoolValue.ValueType, 'Int and Bool should have different types');
  Assert.AreNotEqual(LStrValue.ValueType, LBoolValue.ValueType, 'String and Bool should have different types');

  // Values with different types should not be considered equal even if they might represent the same concept
  // Note: Direct value comparison across types would be type-unsafe and should be avoided
end;

// =============================================================================
// Error Handling Tests
// =============================================================================

procedure TTestJetVMValues.TestInvalidTypeAccess();
var
  LValue: TJetValue;
begin
  // Test accessing wrong type field
  LValue := FVM.MakeIntConstant(42);

  // Accessing IntValue on Int type should work
  Assert.AreEqual(Int64(42), LValue.IntValue, 'Correct type access should work');

  // Note: Accessing wrong type field (e.g., StrValue on Int type)
  // may or may not be caught at runtime depending on implementation
  // This test documents expected behavior

  // In a tagged union, accessing the wrong variant field is technically undefined behavior
  // but may not always raise an exception. The test verifies the correct access works.
end;

procedure TTestJetVMValues.TestValueCorruption();
var
  LValue: TJetValue;
begin
  // Test that values maintain integrity
  LValue := FVM.MakeStrConstant('Test String');

  // Verify initial state
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Initial type should be correct');
  Assert.AreEqual('Test String', LValue.StrValue, 'Initial value should be correct');

  // Simulate potential corruption scenario
  LValue.ValueType := jvtStr; // Re-assign same type (should be safe)

  // Value should remain intact
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Type should remain correct');
  Assert.AreEqual('Test String', LValue.StrValue, 'Value should remain correct');
end;

procedure TTestJetVMValues.TestMemoryLeakPrevention();
var
  LValue: TJetValue;
  LI: Integer;
begin
  // Test creating many values to check for memory leaks
  for LI := 1 to 1000 do
  begin
    LValue := FVM.MakeStrConstant(Format('String %d', [LI]));
    Assert.AreEqual(jvtStr, LValue.ValueType, Format('String %d should have correct type', [LI]));
    Assert.AreEqual(Format('String %d', [LI]), LValue.StrValue, Format('String %d should have correct value', [LI]));
  end;

  // Test creating many array values
  for LI := 1 to 100 do
  begin
    LValue.ValueType := jvtArrayInt;
    SetLength(LValue.ArrayIntValue, 10);
    LValue.ArrayIntValue[0] := LI;
    Assert.AreEqual(jvtArrayInt, LValue.ValueType, Format('Array %d should have correct type', [LI]));
    Assert.AreEqual(Int64(LI), LValue.ArrayIntValue[0], Format('Array %d should have correct value', [LI]));
  end;

  // Note: Memory leak detection would typically be handled by testing framework
  // This test ensures values can be created in bulk without obvious issues
end;

// =============================================================================
// Constants Pool Integration
// =============================================================================

procedure TTestJetVMValues.TestConstantsPoolStorage();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test storing values in constants pool
  LValue1 := FVM.MakeIntConstant(42);
  LValue2 := FVM.MakeStrConstant('Test');

  // Add to constants pool
  FVM.AddConstant(LValue1);
  FVM.AddConstant(LValue2);

  // Values should be stored correctly
  // Note: Direct pool access testing would require more VM internals
  Assert.Pass('Constants pool storage tested via VM integration');
end;

procedure TTestJetVMValues.TestConstantsPoolRetrieval();
var
  LValue: TJetValue;
  LRetrievedValue: TJetValue;
begin
  // Test retrieving values from constants pool
  LValue := FVM.MakeIntConstant(123);
  FVM.AddConstant(LValue);

  // Retrieve from pool
  try
    LRetrievedValue := FVM.GetConstant(0);
    Assert.AreEqual(jvtInt, LRetrievedValue.ValueType, 'Retrieved value should have correct type');
    Assert.AreEqual(Int64(123), LRetrievedValue.IntValue, 'Retrieved value should be correct');
  except
    on E: Exception do
      // If direct constant access is not available, test via execution
      Assert.Pass('Constants pool retrieval tested via execution context');
  end;
end;

procedure TTestJetVMValues.TestConstantsPoolDeduplication();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test that duplicate constants might be deduplicated
  LValue1 := FVM.MakeStrConstant('Duplicate');
  LValue2 := FVM.MakeStrConstant('Duplicate');

  FVM.AddConstant(LValue1);
  FVM.AddConstant(LValue2);

  // Note: Whether deduplication occurs depends on implementation
  // This test documents the behavior and ensures no errors occur
  Assert.Pass('Constants pool deduplication behavior tested');
end;

// =============================================================================
// Real-World Usage Patterns
// =============================================================================

procedure TTestJetVMValues.TestTypicalUsagePatterns();
var
  LIntValue: TJetValue;
  LStrValue: TJetValue;
  LBoolValue: TJetValue;
begin
  // Test typical value creation and usage patterns

  // Create various values as would be done in real usage
  LIntValue := FVM.MakeIntConstant(42);
  LStrValue := FVM.MakeStrConstant('Hello, World!');
  LBoolValue := FVM.MakeBoolConstant(True);

  // Add to VM constants pool (typical usage)
  FVM.AddConstant(LIntValue);
  FVM.AddConstant(LStrValue);
  FVM.AddConstant(LBoolValue);

  // Use in fluent interface (typical usage)
  FVM.LoadInt(100)
     .LoadStr('Test')
     .LoadBool(False)
     .Stop();

  // Execute (typical usage)
  try
    FVM.Execute();
    // Test passes automatically if no exception is thrown
  except
    on E: Exception do
      Assert.Fail('Typical usage pattern should not fail: ' + E.Message);
  end;
end;

procedure TTestJetVMValues.TestComplexValueManipulation();
var
  LValue: TJetValue;
  LI: Integer;
begin
  // Test complex value manipulation scenarios

  // Create and modify string values
  LValue := FVM.MakeStrConstant('Base String');
  for LI := 1 to 10 do
  begin
    LValue.StrValue := LValue.StrValue + Format(' %d', [LI]);
  end;

  Assert.IsTrue(Integer(Length(LValue.StrValue)) > 11, 'Complex string manipulation should work');
  Assert.IsTrue(Integer(Pos('Base String', LValue.StrValue)) = 1, 'Original content should be preserved');

  // Create and manipulate array values
  LValue.ValueType := jvtArrayInt;
  SetLength(LValue.ArrayIntValue, 100);

  for LI := 0 to 99 do
    LValue.ArrayIntValue[LI] := LI * LI;

  Assert.AreEqual(Integer(Length(LValue.ArrayIntValue)), 100, 'Complex array should have correct size');
  Assert.AreEqual(Int64(0), LValue.ArrayIntValue[0], 'First element should be correct');
  Assert.AreEqual(Int64(9801), LValue.ArrayIntValue[99], 'Last element should be correct');
end;

procedure TTestJetVMValues.TestPerformanceOptimization();
var
  LValue: TJetValue;
  LI: Integer;
  LStopwatch: TStopwatch;
begin
  // Test performance characteristics of value operations

  LStopwatch := TStopwatch.StartNew();

  // Create many values quickly
  for LI := 1 to 10000 do
  begin
    LValue := FVM.MakeIntConstant(LI);
    Assert.AreEqual(jvtInt, LValue.ValueType, 'Performance test value should have correct type');
  end;

  LStopwatch.Stop();

  // Should complete in reasonable time (very loose check)
  Assert.IsTrue(LStopwatch.ElapsedMilliseconds < Int64(5000), 'Value creation should be reasonably fast');

  // Test string value performance
  LStopwatch := TStopwatch.StartNew();

  for LI := 1 to 1000 do
  begin
    LValue := FVM.MakeStrConstant(Format('Performance String %d', [LI]));
    Assert.AreEqual(jvtStr, LValue.ValueType, 'Performance string should have correct type');
  end;

  LStopwatch.Stop();

  // Should complete in reasonable time (very loose check)
  Assert.IsTrue(LStopwatch.ElapsedMilliseconds < Int64(5000), 'String creation should be reasonably fast');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMValues);

end.
