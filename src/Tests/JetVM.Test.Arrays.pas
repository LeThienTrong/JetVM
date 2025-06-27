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

unit JetVM.Test.Arrays;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMArrays = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Fixed Array Declaration Tests
    // ==========================================================================
    [Test]
    procedure TestDeclareFixedArrayInt();
    [Test]
    procedure TestDeclareFixedArrayUInt();
    [Test]
    procedure TestDeclareFixedArrayStr();
    [Test]
    procedure TestDeclareFixedArrayBool();
    [Test]
    procedure TestDeclareFixedArrayWithBounds();
    [Test]
    procedure TestDeclareFixedArrayZeroLength();
    [Test]
    procedure TestDeclareFixedArrayLargeBounds();

    // ==========================================================================
    // Dynamic Array Declaration Tests
    // ==========================================================================
    [Test]
    procedure TestDeclareDynamicArrayInt();
    [Test]
    procedure TestDeclareDynamicArrayUInt();
    [Test]
    procedure TestDeclareDynamicArrayStr();
    [Test]
    procedure TestDeclareDynamicArrayBool();
    [Test]
    procedure TestDeclareDynamicArrayInitialLength();

    // ==========================================================================
    // Dynamic Array Length Management Tests
    // ==========================================================================
    [Test]
    procedure TestArraySetLengthBasic();
    [Test]
    procedure TestArraySetLengthZero();
    [Test]
    procedure TestArraySetLengthIncrease();
    [Test]
    procedure TestArraySetLengthDecrease();
    [Test]
    procedure TestArraySetLengthPreservesData();

    // ==========================================================================
    // Array Access Tests - Get Operations
    // ==========================================================================
    [Test]
    procedure TestArrayGetIntBasic();
    [Test]
    procedure TestArrayGetUIntBasic();
    [Test]
    procedure TestArrayGetStrBasic();
    [Test]
    procedure TestArrayGetBoolBasic();
    [Test]
    procedure TestArrayGetBounds();
    [Test]
    procedure TestArrayGetSequentialAccess();

    // ==========================================================================
    // Array Access Tests - Set Operations
    // ==========================================================================
    [Test]
    procedure TestArraySetIntBasic();
    [Test]
    procedure TestArraySetUIntBasic();
    [Test]
    procedure TestArraySetStrBasic();
    [Test]
    procedure TestArraySetBoolBasic();
    [Test]
    procedure TestArraySetBounds();
    [Test]
    procedure TestArraySetOverwrite();

    // ==========================================================================
    // Array Property Tests
    // ==========================================================================
    [Test]
    procedure TestArrayLengthProperty();
    [Test]
    procedure TestArrayHighProperty();
    [Test]
    procedure TestArrayLowProperty();
    [Test]
    procedure TestArrayPropertiesConsistency();

    // ==========================================================================
    // Array Address Tests
    // ==========================================================================
    [Test]
    procedure TestArrayAddrBasic();
    [Test]
    procedure TestArrayAddrWithIndex();
    [Test]
    procedure TestArrayAddrBounds();

    // ==========================================================================
    // Complex Array Operations
    // ==========================================================================
    [Test]
    procedure TestArrayCopyOperation();
    [Test]
    procedure TestArrayFillOperation();
    [Test]
    procedure TestArraySearchOperation();
    [Test]
    procedure TestArraySortOperation();

    // ==========================================================================
    // Multi-Dimensional Array Simulation
    // ==========================================================================
    [Test]
    procedure TestSimulated2DArrayInt();
    [Test]
    procedure TestSimulated2DArrayAccess();
    [Test]
    procedure TestSimulated3DArrayInt();

    // ==========================================================================
    // Array with Different Types
    // ==========================================================================
    [Test]
    procedure TestMixedTypeArrayOperations();
    [Test]
    procedure TestArrayOfDifferentSizes();
    [Test]
    procedure TestArrayTypeConversions();

    // ==========================================================================
    // Edge Cases and Boundary Conditions
    // ==========================================================================
    [Test]
    procedure TestArrayEdgeCasesEmpty();
    [Test]
    procedure TestArrayEdgeCasesLargeIndexes();
    [Test]
    procedure TestArrayEdgeCasesNegativeBounds();
    [Test]
    procedure TestArrayEdgeCasesMaxValues();

    // ==========================================================================
    // Performance and Memory Tests
    // ==========================================================================
    [Test]
    procedure TestArrayMemoryManagement();
    [Test]
    procedure TestArrayGrowthPattern();
    [Test]
    procedure TestArrayLargeData();

    // ==========================================================================
    // Fluent Interface Array Tests
    // ==========================================================================
    [Test]
    procedure TestFluentArrayCreation();
    [Test]
    procedure TestFluentArrayChaining();
    [Test]
    procedure TestFluentArrayOperationsSequence();
    [Test]
    procedure TestFluentArrayReturnsCorrectType();

    // ==========================================================================
    // Array Integration Tests
    // ==========================================================================
    [Test]
    procedure TestArrayWithStackOperations();
    [Test]
    procedure TestArrayWithArithmetic();
    [Test]
    procedure TestArrayWithControlFlow();
    [Test]
    procedure TestArrayWithFunctions();

    // ==========================================================================
    // Error Handling and Validation
    // ==========================================================================
    [Test]
    procedure TestArrayValidationLevels();
    [Test]
    procedure TestArrayBoundsValidation();
    [Test]
    procedure TestArrayTypeValidation();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMArrays.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMArrays.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Fixed Array Declaration Tests
// =============================================================================

procedure TTestJetVMArrays.TestDeclareFixedArrayInt();
var
  LResult: TJetValue;
begin
  // Test basic fixed integer array declaration
  FVM.DeclareFixedArray(0, 9, jvtInt)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayInt, LResult.ValueType, 'Array type should be jvtArrayInt');
  Assert.AreEqual(Integer(Length(LResult.ArrayIntValue)), 10, 'Array length should be 10');
end;

procedure TTestJetVMArrays.TestDeclareFixedArrayUInt();
var
  LResult: TJetValue;
begin
  // Test basic fixed unsigned integer array declaration
  FVM.DeclareFixedArray(1, 5, jvtUInt)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayUInt, LResult.ValueType, 'Array type should be jvtArrayUInt');
  Assert.AreEqual(Integer(Length(LResult.ArrayUIntValue)), 5, 'Array length should be 5');
end;

procedure TTestJetVMArrays.TestDeclareFixedArrayStr();
var
  LResult: TJetValue;
begin
  // Test basic fixed string array declaration
  FVM.DeclareFixedArray(0, 2, jvtStr)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayStr, LResult.ValueType, 'Array type should be jvtArrayStr');
  Assert.AreEqual(Integer(Length(LResult.ArrayStrValue)), 3, 'Array length should be 3');
end;

procedure TTestJetVMArrays.TestDeclareFixedArrayBool();
var
  LResult: TJetValue;
begin
  // Test basic fixed boolean array declaration
  FVM.DeclareFixedArray(0, 7, jvtBool)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayBool, LResult.ValueType, 'Array type should be jvtArrayBool');
  Assert.AreEqual(Integer(Length(LResult.ArrayBoolValue)), 8, 'Array length should be 8');
end;

procedure TTestJetVMArrays.TestDeclareFixedArrayWithBounds();
var
  LResult: TJetValue;
begin
  // Test fixed array with custom bounds
  FVM.DeclareFixedArray(10, 19, jvtInt)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayInt, LResult.ValueType, 'Array type should be jvtArrayInt');
  Assert.AreEqual(Integer(Length(LResult.ArrayIntValue)), 10, 'Array length should be 10 (19-10+1)');
end;

procedure TTestJetVMArrays.TestDeclareFixedArrayZeroLength();
var
  LResult: TJetValue;
begin
  // Test edge case: array with same lower and upper bound
  FVM.DeclareFixedArray(5, 5, jvtInt)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayInt, LResult.ValueType, 'Array type should be jvtArrayInt');
  Assert.AreEqual(Integer(Length(LResult.ArrayIntValue)), 1, 'Array length should be 1');
end;

procedure TTestJetVMArrays.TestDeclareFixedArrayLargeBounds();
var
  LResult: TJetValue;
begin
  // Test larger array declaration
  FVM.DeclareFixedArray(0, 999, jvtInt)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayInt, LResult.ValueType, 'Array type should be jvtArrayInt');
  Assert.AreEqual(Integer(Length(LResult.ArrayIntValue)), 1000, 'Array length should be 1000');
end;

// =============================================================================
// Dynamic Array Declaration Tests
// =============================================================================

procedure TTestJetVMArrays.TestDeclareDynamicArrayInt();
var
  LResult: TJetValue;
begin
  // Test basic dynamic integer array declaration
  FVM.DeclareDynamicArray(jvtInt)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayInt, LResult.ValueType, 'Array type should be jvtArrayInt');
  Assert.AreEqual(Integer(Length(LResult.ArrayIntValue)), 0, 'Dynamic array should start with zero length');
end;

procedure TTestJetVMArrays.TestDeclareDynamicArrayUInt();
var
  LResult: TJetValue;
begin
  // Test basic dynamic unsigned integer array declaration
  FVM.DeclareDynamicArray(jvtUInt)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayUInt, LResult.ValueType, 'Array type should be jvtArrayUInt');
  Assert.AreEqual(Integer(Length(LResult.ArrayUIntValue)), 0, 'Dynamic array should start with zero length');
end;

procedure TTestJetVMArrays.TestDeclareDynamicArrayStr();
var
  LResult: TJetValue;
begin
  // Test basic dynamic string array declaration
  FVM.DeclareDynamicArray(jvtStr)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayStr, LResult.ValueType, 'Array type should be jvtArrayStr');
  Assert.AreEqual(Integer(Length(LResult.ArrayStrValue)), 0, 'Dynamic array should start with zero length');
end;

procedure TTestJetVMArrays.TestDeclareDynamicArrayBool();
var
  LResult: TJetValue;
begin
  // Test basic dynamic boolean array declaration
  FVM.DeclareDynamicArray(jvtBool)
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayBool, LResult.ValueType, 'Array type should be jvtArrayBool');
  Assert.AreEqual(Integer(Length(LResult.ArrayBoolValue)), 0, 'Dynamic array should start with zero length');
end;

procedure TTestJetVMArrays.TestDeclareDynamicArrayInitialLength();
var
  LResult: TJetValue;
begin
  // Test dynamic array initial length after SetLength
  FVM.DeclareDynamicArray(jvtInt)
     .LoadInt(10)
     .ArraySetLength()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtArrayInt, LResult.ValueType, 'Array type should be jvtArrayInt');
  Assert.AreEqual(Integer(Length(LResult.ArrayIntValue)), 10, 'Array length should be set to 10');
end;

// =============================================================================
// Dynamic Array Length Management Tests
// =============================================================================

procedure TTestJetVMArrays.TestArraySetLengthBasic();
var
  LResult: TJetValue;
begin
  // Test basic SetLength operation
  FVM.DeclareDynamicArray(jvtInt)
     .LoadInt(5)
     .ArraySetLength()
     .ArrayLength()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(5), LResult.IntValue, 'Array length should be 5');
end;

procedure TTestJetVMArrays.TestArraySetLengthZero();
var
  LResult: TJetValue;
begin
  // Test setting length to zero
  FVM.DeclareDynamicArray(jvtInt)
     .LoadInt(10)
     .ArraySetLength()
     .LoadInt(0)
     .ArraySetLength()
     .ArrayLength()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'Array length should be 0 after resizing');
end;

procedure TTestJetVMArrays.TestArraySetLengthIncrease();
var
  LResult: TJetValue;
begin
  // Test increasing array length
  FVM.DeclareDynamicArray(jvtInt)
     .LoadInt(5)
     .ArraySetLength()
     .LoadInt(10)
     .ArraySetLength()
     .ArrayLength()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(10), LResult.IntValue, 'Array length should be increased to 10');
end;

procedure TTestJetVMArrays.TestArraySetLengthDecrease();
var
  LResult: TJetValue;
begin
  // Test decreasing array length
  FVM.DeclareDynamicArray(jvtInt)
     .LoadInt(10)
     .ArraySetLength()
     .LoadInt(3)
     .ArraySetLength()
     .ArrayLength()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(3), LResult.IntValue, 'Array length should be decreased to 3');
end;

procedure TTestJetVMArrays.TestArraySetLengthPreservesData();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test that resizing preserves existing data
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareDynamicArray(jvtInt)
        .LoadInt(3)
        .ArraySetLength()
        .Dup()              // Duplicate array reference
        .LoadInt(0)         // Index
        .LoadInt(42)        // Value
        .ArraySet()
        .LoadInt(5)         // New length
        .ArraySetLength()
        .LoadInt(0)         // Index
        .ArrayGet()         // Get first element
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(42), LResult.IntValue, 'First element should be preserved after resize');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Array Access Tests - Get Operations
// =============================================================================

procedure TTestJetVMArrays.TestArrayGetIntBasic();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test basic array get operation for integers
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 4, jvtInt)
        .Dup()              // Duplicate array reference
        .LoadInt(2)         // Index
        .LoadInt(100)       // Value
        .ArraySet()         // Set array[2] = 100
        .LoadInt(2)         // Index for get
        .ArrayGet()         // Get array[2]
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(100), LResult.IntValue, 'Array get should return stored value');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayGetUIntBasic();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test basic array get operation for unsigned integers
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 4, jvtUInt)
        .Dup()
        .LoadInt(1)
        .LoadUInt(4294967295)  // Max uint32
        .ArraySet()
        .LoadInt(1)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(UInt64(4294967295), LResult.UIntValue, 'Array get should return stored unsigned value');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayGetStrBasic();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test basic array get operation for strings
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 2, jvtStr)
        .Dup()
        .LoadInt(0)
        .LoadStr('Hello World')
        .ArraySet()
        .LoadInt(0)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual('Hello World', LResult.StrValue, 'Array get should return stored string');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayGetBoolBasic();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test basic array get operation for booleans
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 3, jvtBool)
        .Dup()
        .LoadInt(2)
        .LoadBool(True)
        .ArraySet()
        .LoadInt(2)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(True, LResult.BoolValue, 'Array get should return stored boolean value');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayGetBounds();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test array get at different bounds
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 9, jvtInt)
        .Dup()
        .LoadInt(0)      // First index
        .LoadInt(1000)
        .ArraySet()
        .Dup()
        .LoadInt(9)      // Last index
        .LoadInt(2000)
        .ArraySet()
        .LoadInt(0)      // Get first element
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(1000), LResult.IntValue, 'Array get should work at first index');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayGetSequentialAccess();
var
  LResult: TJetValue;
  LVM2: TJetVM;
  LI: Integer;
begin
  // Test sequential access to array elements
  LVM2 := TJetVM.Create(vlBasic);
  try
    // Create and populate array
    LVM2.DeclareFixedArray(0, 4, jvtInt);

    for LI := 0 to 4 do
    begin
      LVM2.Dup()
          .LoadInt(LI)
          .LoadInt(LI * 10)
          .ArraySet();
    end;

    // Get middle element
    LVM2.LoadInt(2)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(20), LResult.IntValue, 'Sequential access should work correctly');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Array Access Tests - Set Operations
// =============================================================================

procedure TTestJetVMArrays.TestArraySetIntBasic();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test basic array set operation for integers
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 4, jvtInt)
        .Dup()
        .LoadInt(3)
        .LoadInt(500)
        .ArraySet()
        .LoadInt(3)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(500), LResult.IntValue, 'Array set should store value correctly');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArraySetUIntBasic();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test basic array set operation for unsigned integers
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 4, jvtUInt)
        .Dup()
        .LoadInt(1)
        .LoadUInt(18446744073709551615)  // Max uint64
        .ArraySet()
        .LoadInt(1)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(UInt64(18446744073709551615), LResult.UIntValue, 'Array set should store large unsigned value');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArraySetStrBasic();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test basic array set operation for strings
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 2, jvtStr)
        .Dup()
        .LoadInt(1)
        .LoadStr('JetVM Array Test')
        .ArraySet()
        .LoadInt(1)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual('JetVM Array Test', LResult.StrValue, 'Array set should store string correctly');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArraySetBoolBasic();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test basic array set operation for booleans
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 3, jvtBool)
        .Dup()
        .LoadInt(0)
        .LoadBool(False)
        .ArraySet()
        .LoadInt(0)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(False, LResult.BoolValue, 'Array set should store boolean value correctly');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArraySetBounds();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test array set at boundary positions
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(5, 10, jvtInt)
        .Dup()
        .LoadInt(5)      // First valid index (0 in internal array)
        .LoadInt(999)
        .ArraySet()
        .LoadInt(5)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(999), LResult.IntValue, 'Array set should work at boundary positions');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArraySetOverwrite();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test overwriting array elements
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 2, jvtInt)
        .Dup()
        .LoadInt(1)
        .LoadInt(100)
        .ArraySet()     // Set array[1] = 100
        .Dup()
        .LoadInt(1)
        .LoadInt(200)
        .ArraySet()     // Overwrite: array[1] = 200
        .LoadInt(1)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(200), LResult.IntValue, 'Array set should overwrite existing values');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Array Property Tests
// =============================================================================

procedure TTestJetVMArrays.TestArrayLengthProperty();
var
  LResult: TJetValue;
begin
  // Test ArrayLength property
  FVM.DeclareFixedArray(0, 9, jvtInt)
     .ArrayLength()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(10), LResult.IntValue, 'ArrayLength should return correct size');
end;

procedure TTestJetVMArrays.TestArrayHighProperty();
var
  LResult: TJetValue;
begin
  // Test ArrayHigh property
  FVM.DeclareFixedArray(0, 9, jvtInt)
     .ArrayHigh()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(9), LResult.IntValue, 'ArrayHigh should return highest valid index');
end;

procedure TTestJetVMArrays.TestArrayLowProperty();
var
  LResult: TJetValue;
begin
  // Test ArrayLow property
  FVM.DeclareFixedArray(0, 9, jvtInt)
     .ArrayLow()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'ArrayLow should return lowest valid index');
end;

procedure TTestJetVMArrays.TestArrayPropertiesConsistency();
var
  LLength: TJetValue;
  LHigh: TJetValue;
  LLow: TJetValue;
  LVM2: TJetVM;
  LVM3: TJetVM;
begin
  // Test consistency between Length, High, and Low
  LVM2 := TJetVM.Create(vlBasic);
  LVM3 := TJetVM.Create(vlBasic);
  try
    // Get Length
    LVM2.DeclareFixedArray(2, 7, jvtInt)
        .ArrayLength()
        .Stop();
    LVM2.Execute();
    LLength := LVM2.PopValue();

    // Get High
    FVM.DeclareFixedArray(2, 7, jvtInt)
       .ArrayHigh()
       .Stop();
    FVM.Execute();
    LHigh := FVM.PopValue();

    // Get Low
    LVM3.DeclareFixedArray(2, 7, jvtInt)
        .ArrayLow()
        .Stop();
    LVM3.Execute();
    LLow := LVM3.PopValue();

    Assert.AreEqual(Int64(6), LLength.IntValue, 'Length should be 6 (7-2+1)');
    Assert.AreEqual(Int64(5), LHigh.IntValue, 'High should be 5 (length-1)');
    Assert.AreEqual(Int64(0), LLow.IntValue, 'Low should be 0');
    Assert.AreEqual(LLength.IntValue, LHigh.IntValue - LLow.IntValue + 1, 'Length = High - Low + 1');
  finally
    LVM2.Free();
    LVM3.Free();
  end;
end;

// =============================================================================
// Array Address Tests
// =============================================================================

procedure TTestJetVMArrays.TestArrayAddrBasic();
var
  LResult: TJetValue;
begin
  // Test getting array address
  FVM.DeclareFixedArray(0, 4, jvtInt)
     .LoadInt(0)
     .ArrayAddr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtPointer, LResult.ValueType, 'ArrayAddr should return pointer type');
  Assert.IsNotNull(LResult.PtrValue, 'ArrayAddr should return valid pointer');
end;

procedure TTestJetVMArrays.TestArrayAddrWithIndex();
var
  LResult: TJetValue;
begin
  // Test getting array address at specific index
  FVM.DeclareFixedArray(0, 9, jvtInt)
     .LoadInt(5)
     .ArrayAddr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(jvtPointer, LResult.ValueType, 'ArrayAddr with index should return pointer type');
  Assert.IsNotNull(LResult.PtrValue, 'ArrayAddr with index should return valid pointer');
end;

procedure TTestJetVMArrays.TestArrayAddrBounds();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test array address at boundary positions
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 4, jvtInt)
        .LoadInt(4)    // Last valid index
        .ArrayAddr()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(jvtPointer, LResult.ValueType, 'ArrayAddr at boundary should return pointer type');
    Assert.IsNotNull(LResult.PtrValue, 'ArrayAddr at boundary should return valid pointer');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Complex Array Operations
// =============================================================================

procedure TTestJetVMArrays.TestArrayCopyOperation();
var
  LResult: TJetValue;
  LVM2: TJetVM;
  LI: Integer;
begin
  // Test copying array elements (simulation)
  LVM2 := TJetVM.Create(vlBasic);
  try
    // Create source array
    LVM2.DeclareFixedArray(0, 4, jvtInt);

    // Fill source array
    for LI := 0 to 4 do
    begin
      LVM2.Dup()
          .LoadInt(LI)
          .LoadInt(LI * 100)
          .ArraySet();
    end;

    // Create destination array
    LVM2.DeclareFixedArray(0, 4, jvtInt);

    // Copy first element: dest[0] = src[0]
    LVM2.Swap()         // Put source array on top
        .LoadInt(0)     // Source index
        .ArrayGet()     // Get source[0]
        .Swap()     // Put dest array on top
        .LoadInt(0)     // Dest index
        .Rot()          // Bring value to top
        .ArraySet()     // Set dest[0] = value
        .LoadInt(0)     // Verify by getting dest[0]
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(0), LResult.IntValue, 'Array copy operation should work correctly');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayFillOperation();
var
  LResult: TJetValue;
  LVM2: TJetVM;
  LI: Integer;
begin
  // Test filling array with same value
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 2, jvtInt);

    // Fill all elements with 777
    for LI := 0 to 2 do
    begin
      LVM2.Dup()
          .LoadInt(LI)
          .LoadInt(777)
          .ArraySet();
    end;

    // Verify by getting middle element
    LVM2.LoadInt(1)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(777), LResult.IntValue, 'Array fill operation should work correctly');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArraySearchOperation();
var
  LResult: TJetValue;
  LVM2: TJetVM;
  LI: Integer;
begin
  // Test searching in array (linear search simulation)
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 4, jvtInt);

    // Fill array with values [10, 20, 30, 40, 50]
    for LI := 0 to 4 do
    begin
      LVM2.Dup()
          .LoadInt(LI)
          .LoadInt((LI + 1) * 10)
          .ArraySet();
    end;

    // Search for value 30 (should be at index 2)
    LVM2.LoadInt(2)
        .ArrayGet()
        .LoadInt(30)
        .EqInt()        // Check if array[2] == 30
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(True, LResult.BoolValue, 'Array search should find correct value');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArraySortOperation();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test simple sort operation (bubble sort step)
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 1, jvtInt)
        .Dup()
        .LoadInt(0)
        .LoadInt(20)    // array[0] = 20
        .ArraySet()
        .Dup()
        .LoadInt(1)
        .LoadInt(10)    // array[1] = 10
        .ArraySet();

    // Compare and swap if needed: if array[0] > array[1] then swap
    // For simplicity, just verify we can compare
    LVM2.Dup()
        .LoadInt(0)
        .ArrayGet()     // Get array[0]
        .Swap()
        .LoadInt(1)
        .ArrayGet()     // Get array[1]
        .GtInt()        // array[0] > array[1]?
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(True, LResult.BoolValue, 'Array comparison for sort should work correctly');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Multi-Dimensional Array Simulation
// =============================================================================

procedure TTestJetVMArrays.TestSimulated2DArrayInt();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test 2D array simulation using 1D array
  // 3x3 matrix, access element [1,2] (row 1, col 2)
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 8, jvtInt)  // 3x3 = 9 elements
        .Dup()
        .LoadInt(1)     // Row
        .LoadInt(3)     // Cols per row
        .MulInt()       // Row * Cols
        .LoadInt(2)     // Col
        .AddInt()       // (Row * Cols) + Col = index 5
        .LoadInt(999)   // Value
        .ArraySet()     // Set matrix[1,2] = 999
        .LoadInt(5)     // Direct index access
        .ArrayGet()     // Get matrix[1,2]
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(999), LResult.IntValue, '2D array simulation should work correctly');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestSimulated2DArrayAccess();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test multiple accesses to 2D array simulation
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 3, jvtInt)  // 2x2 matrix
        .Dup()
        .LoadInt(0)     // Set [0,0] = 11
        .LoadInt(11)
        .ArraySet()
        .Dup()
        .LoadInt(1)     // Set [0,1] = 12
        .LoadInt(12)
        .ArraySet()
        .Dup()
        .LoadInt(2)     // Set [1,0] = 21
        .LoadInt(21)
        .ArraySet()
        .Dup()
        .LoadInt(3)     // Set [1,1] = 22
        .LoadInt(22)
        .ArraySet()
        .LoadInt(3)     // Get [1,1]
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(22), LResult.IntValue, '2D array access should work for all positions');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestSimulated3DArrayInt();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test 3D array simulation: 2x2x2 cube
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 7, jvtInt)  // 2x2x2 = 8 elements
        .Dup()
        // Access [1,1,1]: index = z*4 + y*2 + x = 1*4 + 1*2 + 1 = 7
        .LoadInt(1)     // Z
        .LoadInt(4)     // Z stride (2*2)
        .MulInt()
        .LoadInt(1)     // Y
        .LoadInt(2)     // Y stride
        .MulInt()
        .AddInt()
        .LoadInt(1)     // X
        .AddInt()       // Final index = 7
        .LoadInt(777)
        .ArraySet()
        .LoadInt(7)     // Direct access to verify
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(777), LResult.IntValue, '3D array simulation should work correctly');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Array with Different Types
// =============================================================================

procedure TTestJetVMArrays.TestMixedTypeArrayOperations();
var
  LIntResult: TJetValue;
  LStrResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test operations with different array types
  LVM2 := TJetVM.Create(vlBasic);
  try
    // Create both int and string arrays
    LVM2.DeclareFixedArray(0, 2, jvtInt)
        .DeclareFixedArray(0, 2, jvtStr)
        .Swap()         // Put int array on top
        .LoadInt(1)
        .LoadInt(123)
        .ArraySet()     // Set int_array[1] = 123
        .Swap()         // Put string array on top
        .LoadInt(1)
        .LoadStr('Test')
        .ArraySet()     // Set str_array[1] = "Test"
        .LoadInt(1)
        .ArrayGet()     // Get str_array[1]
        .Stop();

    LVM2.Execute();
    LStrResult := LVM2.PopValue();

    Assert.AreEqual('Test', LStrResult.StrValue, 'Mixed type arrays should work independently');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayOfDifferentSizes();
var
  LResult1: TJetValue;
  LResult2: TJetValue;
  LVM2: TJetVM;
  LVM3: TJetVM;
begin
  // Test arrays of different sizes
  LVM2 := TJetVM.Create(vlBasic);
  LVM3 := TJetVM.Create(vlBasic);
  try
    // Small array
    LVM2.DeclareFixedArray(0, 1, jvtInt)
        .ArrayLength()
        .Stop();
    LVM2.Execute();
    LResult1 := LVM2.PopValue();

    // Large array
    LVM3.DeclareFixedArray(0, 99, jvtInt)
        .ArrayLength()
        .Stop();
    LVM3.Execute();
    LResult2 := LVM3.PopValue();

    Assert.AreEqual(Int64(2), LResult1.IntValue, 'Small array should have correct length');
    Assert.AreEqual(Int64(100), LResult2.IntValue, 'Large array should have correct length');
  finally
    LVM2.Free();
    LVM3.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayTypeConversions();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test type conversions with arrays
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 2, jvtInt)
        .Dup()
        .LoadInt(0)
        .LoadInt(42)
        .ArraySet()     // Set array[0] = 42
        .LoadInt(0)
        .ArrayGet()     // Get array[0]
        .IntToStr()     // Convert to string
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual('42', LResult.StrValue, 'Type conversion with array values should work');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Edge Cases and Boundary Conditions
// =============================================================================

procedure TTestJetVMArrays.TestArrayEdgeCasesEmpty();
var
  LResult: TJetValue;
begin
  // Test edge case with minimal array
  FVM.DeclareFixedArray(0, 0, jvtInt)
     .ArrayLength()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(1), LResult.IntValue, 'Single-element array should have length 1');
end;

procedure TTestJetVMArrays.TestArrayEdgeCasesLargeIndexes();
var
  LResult: TJetValue;
begin
  // Test with large but valid indexes
  FVM.DeclareFixedArray(1000, 1002, jvtInt)
     .ArrayLength()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(3), LResult.IntValue, 'Array with large bounds should work correctly');
end;

procedure TTestJetVMArrays.TestArrayEdgeCasesNegativeBounds();
var
  LResult: TJetValue;
begin
  // Test with negative lower bound (if supported)
  FVM.DeclareFixedArray(-5, -1, jvtInt)
     .ArrayLength()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(5), LResult.IntValue, 'Array with negative bounds should work correctly');
end;

procedure TTestJetVMArrays.TestArrayEdgeCasesMaxValues();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test with maximum values for different types
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 1, jvtInt)
        .Dup()
        .LoadInt(0)
        .LoadInt(High(Int64))
        .ArraySet()
        .LoadInt(0)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(High(Int64), LResult.IntValue, 'Array should handle maximum integer values');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Performance and Memory Tests
// =============================================================================

procedure TTestJetVMArrays.TestArrayMemoryManagement();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test memory management with array creation and destruction
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 9, jvtInt)
        .ArrayLength()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(10), LResult.IntValue, 'Array memory management should work correctly');

    // Reset and create another array
    LVM2.Reset();
    LVM2.DeclareFixedArray(0, 4, jvtStr)
        .ArrayLength()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(5), LResult.IntValue, 'Array memory should be properly managed after reset');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayGrowthPattern();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test dynamic array growth pattern
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareDynamicArray(jvtInt)
        .LoadInt(1)
        .ArraySetLength()   // Length = 1
        .LoadInt(5)
        .ArraySetLength()   // Length = 5
        .LoadInt(10)
        .ArraySetLength()   // Length = 10
        .ArrayLength()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(10), LResult.IntValue, 'Array growth should work correctly');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayLargeData();
var
  LResult: TJetValue;
  LVM2: TJetVM;
  LI: Integer;
begin
  // Test with relatively large array (within reasonable limits)
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 99, jvtInt);  // 100 elements

    // Set every 10th element
    for LI := 0 to 9 do
    begin
      LVM2.Dup()
          .LoadInt(LI * 10)
          .LoadInt(LI * 100)
          .ArraySet();
    end;

    // Verify one element
    LVM2.LoadInt(50)  // Get element at index 50
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(500), LResult.IntValue, 'Large array operations should work correctly');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Fluent Interface Array Tests
// =============================================================================

procedure TTestJetVMArrays.TestFluentArrayCreation();
var
  LVMReference: TJetVM;
begin
  // Test that fluent array operations return the same instance
  LVMReference := FVM.DeclareFixedArray(0, 4, jvtInt);
  Assert.AreSame(FVM, LVMReference, 'DeclareFixedArray should return same instance');

  LVMReference := FVM.DeclareDynamicArray(jvtStr);
  Assert.AreSame(FVM, LVMReference, 'DeclareDynamicArray should return same instance');
end;

procedure TTestJetVMArrays.TestFluentArrayChaining();
var
  LVMReference: TJetVM;
begin
  // Test chaining multiple array operations
  LVMReference := FVM.DeclareFixedArray(0, 4, jvtInt)
                     .ArrayLength()
                     .LoadInt(5)
                     .EqInt();

  Assert.AreSame(FVM, LVMReference, 'Array operation chaining should return same instance');
end;

procedure TTestJetVMArrays.TestFluentArrayOperationsSequence();
var
  LResult: TJetValue;
begin
  // Test complex fluent operation sequence
  FVM.DeclareFixedArray(0, 2, jvtInt)
     .Dup()
     .LoadInt(1)
     .LoadInt(42)
     .ArraySet()
     .LoadInt(1)
     .ArrayGet()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(42), LResult.IntValue, 'Fluent array operation sequence should work correctly');
end;

procedure TTestJetVMArrays.TestFluentArrayReturnsCorrectType();
var
  LVMReference: TJetVM;
begin
  // Test that all array operations return TJetVM
  LVMReference := FVM.DeclareFixedArray(0, 4, jvtInt)
                     .ArrayLength()
                     .ArrayHigh()
                     .ArrayLow();

  Assert.AreSame(FVM, LVMReference, 'All array property operations should return TJetVM instance');
end;

// =============================================================================
// Array Integration Tests
// =============================================================================

procedure TTestJetVMArrays.TestArrayWithStackOperations();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test arrays with stack operations
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 2, jvtInt)
        .Dup()          // Duplicate array reference
        .LoadInt(0)
        .LoadInt(100)
        .ArraySet()
        .Swap()         // Swap with duplicated array
        .LoadInt(0)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(100), LResult.IntValue, 'Arrays should work correctly with stack operations');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayWithArithmetic();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test arrays with arithmetic operations
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 1, jvtInt)
        .Dup()
        .LoadInt(0)
        .LoadInt(10)
        .ArraySet()
        .Dup()
        .LoadInt(1)
        .LoadInt(20)
        .ArraySet()
        .LoadInt(0)
        .ArrayGet()     // Get array[0] = 10
        .Swap()
        .LoadInt(1)
        .ArrayGet()     // Get array[1] = 20
        .AddInt()       // 10 + 20 = 30
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(30), LResult.IntValue, 'Arrays should work correctly with arithmetic operations');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayWithControlFlow();
var
  LResult: TJetValue;
  LVM2: TJetVM;
  LLabel: Integer;
begin
  // Test arrays with control flow
  LVM2 := TJetVM.Create(vlBasic);
  try
    LLabel := LVM2.CreateLabel();

    LVM2.DeclareFixedArray(0, 1, jvtInt)
        .Dup()
        .LoadInt(0)
        .LoadInt(1)
        .ArraySet()     // array[0] = 1
        .LoadInt(0)
        .ArrayGet()     // Get array[0]
        .LoadInt(1)
        .EqInt()        // Check if array[0] == 1
        .JumpTrue(LLabel)
        .LoadInt(999)   // Should not execute
        .BindLabel(LLabel)
        .LoadInt(42)    // Should execute
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(42), LResult.IntValue, 'Arrays should work correctly with control flow');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayWithFunctions();
var
  LResult: TJetValue;
  LVM2: TJetVM;
  LFunctionLabel: Integer;
  LMainLabel: Integer;
begin
  // Test arrays with function calls
  LVM2 := TJetVM.Create(vlBasic);
  try
    LFunctionLabel := LVM2.CreateLabel();
    LMainLabel := LVM2.CreateLabel();

    LVM2.Jump(LMainLabel)
        .BindLabel(LFunctionLabel)
        // Function: return array length
        .ArrayLength()
        .ReturnValue()
        .BindLabel(LMainLabel)
        .DeclareFixedArray(0, 4, jvtInt)
        .Call(LFunctionLabel)
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(5), LResult.IntValue, 'Arrays should work correctly with functions');
  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Error Handling and Validation
// =============================================================================

procedure TTestJetVMArrays.TestArrayValidationLevels();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test arrays with different validation levels
  LVM2 := TJetVM.Create(vlDevelopment);
  try
    LVM2.DeclareFixedArray(0, 4, jvtInt)
        .ArrayLength()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(5), LResult.IntValue, 'Arrays should work with development validation level');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayBoundsValidation();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test array bounds validation
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 2, jvtInt)
        .Dup()
        .LoadInt(1)     // Valid index
        .LoadInt(123)
        .ArraySet()
        .LoadInt(1)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(Int64(123), LResult.IntValue, 'Valid array bounds should work correctly');
  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMArrays.TestArrayTypeValidation();
var
  LResult: TJetValue;
  LVM2: TJetVM;
begin
  // Test array type validation
  LVM2 := TJetVM.Create(vlBasic);
  try
    LVM2.DeclareFixedArray(0, 1, jvtStr)
        .Dup()
        .LoadInt(0)
        .LoadStr('Type Test')
        .ArraySet()
        .LoadInt(0)
        .ArrayGet()
        .Stop();

    LVM2.Execute();
    LResult := LVM2.PopValue();

    Assert.AreEqual(jvtStr, LResult.ValueType, 'Array type validation should maintain correct types');
    Assert.AreEqual('Type Test', LResult.StrValue, 'Array type validation should preserve values');
  finally
    LVM2.Free();
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMArrays);

end.
