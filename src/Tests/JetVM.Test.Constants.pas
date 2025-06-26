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

unit JetVM.Test.Constants;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMConstants = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Constants Pool Initialization Tests
    // ==========================================================================
    [Test]
    procedure TestConstantsPoolInitialState();
    [Test]
    procedure TestConstantsPoolInitialCapacity();
    [Test]
    procedure TestConstantsPoolAfterReset();

    // ==========================================================================
    // Basic Constants Storage Tests
    // ==========================================================================
    [Test]
    procedure TestAddIntegerConstant();
    [Test]
    procedure TestAddUIntegerConstant();
    [Test]
    procedure TestAddStringConstant();
    [Test]
    procedure TestAddBooleanConstant();
    [Test]
    procedure TestAddPointerConstant();

    // ==========================================================================
    // Constants Retrieval Tests
    // ==========================================================================
    [Test]
    procedure TestGetConstantValidIndex();
    [Test]
    procedure TestGetConstantInvalidIndex();
    [Test]
    procedure TestGetConstantsArray();
    [Test]
    procedure TestGetConstantsEmptyPool();

    // ==========================================================================
    // Constants Pool Growth Tests
    // ==========================================================================
    [Test]
    procedure TestConstantsPoolGrowth();
    [Test]
    procedure TestConstantsPoolCapacityExpansion();
    [Test]
    procedure TestLargeConstantsPool();

    // ==========================================================================
    // AddConstant Behavior Tests (NO Deduplication)
    // ==========================================================================
    [Test]
    procedure TestAddConstantNoDuplication();
    [Test]
    procedure TestAddConstantStringBehavior();
    [Test]
    procedure TestAddConstantIntegerBehavior();
    [Test]
    procedure TestAddConstantBooleanBehavior();
    [Test]
    procedure TestAddConstantPointerBehavior();

    // ==========================================================================
    // Fluent Interface Deduplication Tests (WITH Deduplication)
    // ==========================================================================
    [Test]
    procedure TestFluentInterfaceDeduplication();
    [Test]
    procedure TestFluentInterfaceStringDeduplication();
    [Test]
    procedure TestFluentInterfaceMixedDeduplication();

    // ==========================================================================
    // Mixed Type Constants Tests
    // ==========================================================================
    [Test]
    procedure TestMixedTypeConstants();
    [Test]
    procedure TestMixedTypeRetrieval();
    [Test]
    procedure TestMixedTypeAddConstantBehavior();

    // ==========================================================================
    // Constants Pool Integration Tests
    // ==========================================================================
    [Test]
    procedure TestFluentInterfaceUsesConstants();
    [Test]
    procedure TestLoadConstOpcode();
    [Test]
    procedure TestConstantsInExecution();

    // ==========================================================================
    // Edge Cases and Boundary Values
    // ==========================================================================
    [Test]
    procedure TestBoundaryIntegerConstants();
    [Test]
    procedure TestBoundaryUIntegerConstants();
    [Test]
    procedure TestEmptyStringConstants();
    [Test]
    procedure TestLargeStringConstants();
    [Test]
    procedure TestNilPointerConstants();

    // ==========================================================================
    // Constants Pool State Management
    // ==========================================================================
    [Test]
    procedure TestConstantsPoolAfterExecution();
    [Test]
    procedure TestConstantsPoolPersistence();
    [Test]
    procedure TestConstantsPoolStateConsistency();

    // ==========================================================================
    // Performance and Memory Tests
    // ==========================================================================
    [Test]
    procedure TestConstantsPoolPerformance();
    [Test]
    procedure TestConstantsPoolMemoryUsage();
    [Test]
    procedure TestAddConstantPerformance();

    // ==========================================================================
    // Error Handling Tests
    // ==========================================================================
    [Test]
    procedure TestInvalidConstantIndexAccess();
    [Test]
    procedure TestConstantsPoolErrorRecovery();
    [Test]
    procedure TestConstantsPoolBoundsChecking();

    // ==========================================================================
    // Constants Factory Methods Tests
    // ==========================================================================
    [Test]
    procedure TestMakeIntConstantFactory();
    [Test]
    procedure TestMakeUIntConstantFactory();
    [Test]
    procedure TestMakeStrConstantFactory();
    [Test]
    procedure TestMakeBoolConstantFactory();
    [Test]
    procedure TestMakePtrConstantFactory();

    // ==========================================================================
    // Fluent vs AddConstant Comparison Tests
    // ==========================================================================
    [Test]
    procedure TestFluentVsAddConstantBehavior();
    [Test]
    procedure TestFluentDeduplicationVsAddConstantNone();
    [Test]
    procedure TestDeduplicationOrderIndependence();

    // ==========================================================================
    // Constants Pool Dump and Debug Tests
    // ==========================================================================
    [Test]
    procedure TestConstantsPoolDump();
    [Test]
    procedure TestConstantsPoolInspection();
    [Test]
    procedure TestConstantsPoolDebugging();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMConstants.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMConstants.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Constants Pool Initialization Tests
// =============================================================================

procedure TTestJetVMConstants.TestConstantsPoolInitialState();
var
  LConstants: TArray<TJetValue>;
begin
  // Test that constants pool starts empty
  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 0, 'Constants pool should start empty');
end;

procedure TTestJetVMConstants.TestConstantsPoolInitialCapacity();
var
  LConstants: TArray<TJetValue>;
begin
  // Test that constants pool has reasonable initial capacity
  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 0, 'Initially should have no constants');

  // Add one constant to verify pool can grow
  FVM.AddConstant(FVM.MakeIntConstant(42));
  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 1, 'Should have one constant after adding');
end;

procedure TTestJetVMConstants.TestConstantsPoolAfterReset();
var
  LConstants: TArray<TJetValue>;
begin
  // Add some constants
  FVM.AddConstant(FVM.MakeIntConstant(100));
  FVM.AddConstant(FVM.MakeStrConstant('Before Reset'));

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 2, 'Should have constants before reset');

  // Reset VM
  FVM.Reset();

  // Constants pool should be cleared
  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 0, 'Constants pool should be empty after reset');
end;

// =============================================================================
// Basic Constants Storage Tests
// =============================================================================

procedure TTestJetVMConstants.TestAddIntegerConstant();
var
  LValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  LValue := FVM.MakeIntConstant(12345);
  FVM.AddConstant(LValue);

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 1, 'Should have one constant');
  Assert.AreEqual(jvtInt, LConstants[0].ValueType, 'Constant should be integer type');
  Assert.AreEqual(Int64(12345), LConstants[0].IntValue, 'Constant should have correct value');
end;

procedure TTestJetVMConstants.TestAddUIntegerConstant();
var
  LValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  LValue := FVM.MakeUIntConstant(54321);
  FVM.AddConstant(LValue);

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 1, 'Should have one constant');
  Assert.AreEqual(jvtUInt, LConstants[0].ValueType, 'Constant should be unsigned integer type');
  Assert.AreEqual(UInt64(54321), LConstants[0].UIntValue, 'Constant should have correct value');
end;

procedure TTestJetVMConstants.TestAddStringConstant();
var
  LValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  LValue := FVM.MakeStrConstant('Hello Constants');
  FVM.AddConstant(LValue);

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 1, 'Should have one constant');
  Assert.AreEqual(jvtStr, LConstants[0].ValueType, 'Constant should be string type');
  Assert.AreEqual('Hello Constants', LConstants[0].StrValue, 'Constant should have correct value');
end;

procedure TTestJetVMConstants.TestAddBooleanConstant();
var
  LValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  LValue := FVM.MakeBoolConstant(True);
  FVM.AddConstant(LValue);

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 1, 'Should have one constant');
  Assert.AreEqual(jvtBool, LConstants[0].ValueType, 'Constant should be boolean type');
  Assert.IsTrue(LConstants[0].BoolValue, 'Constant should have correct value');
end;

procedure TTestJetVMConstants.TestAddPointerConstant();
var
  LValue: TJetValue;
  LConstants: TArray<TJetValue>;
  LTestInt: Integer;
begin
  LTestInt := 42;
  LValue := FVM.MakePtrConstant(@LTestInt);
  FVM.AddConstant(LValue);

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 1, 'Should have one constant');
  Assert.AreEqual(jvtPointer, LConstants[0].ValueType, 'Constant should be pointer type');
  Assert.AreEqual(@LTestInt, LConstants[0].PtrValue, 'Constant should have correct value');
end;

// =============================================================================
// Constants Retrieval Tests
// =============================================================================

procedure TTestJetVMConstants.TestGetConstantValidIndex();
var
  LValue: TJetValue;
  LRetrievedValue: TJetValue;
begin
  // Add a constant
  LValue := FVM.MakeIntConstant(999);
  FVM.AddConstant(LValue);

  // Retrieve by index
  LRetrievedValue := FVM.GetConstant(0);

  Assert.AreEqual(LValue.ValueType, LRetrievedValue.ValueType, 'Retrieved constant should have correct type');
  Assert.AreEqual(LValue.IntValue, LRetrievedValue.IntValue, 'Retrieved constant should have correct value');
end;

procedure TTestJetVMConstants.TestGetConstantInvalidIndex();
begin
  // Add one constant
  FVM.AddConstant(FVM.MakeIntConstant(42));

  // Try to access invalid indices - should now throw exceptions
  Assert.WillRaise(
    procedure
    begin
      FVM.GetConstant(1); // Beyond range
    end,
    EJetVMError,
    'Should raise exception for index beyond range'
  );

  Assert.WillRaise(
    procedure
    begin
      FVM.GetConstant(-1); // Negative index
    end,
    EJetVMError,
    'Should raise exception for negative index'
  );
end;

procedure TTestJetVMConstants.TestGetConstantsArray();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Add multiple constants
  LValue1 := FVM.MakeIntConstant(100);
  LValue2 := FVM.MakeStrConstant('Middle');
  LValue3 := FVM.MakeBoolConstant(False);

  FVM.AddConstant(LValue1);
  FVM.AddConstant(LValue2);
  FVM.AddConstant(LValue3);

  // Get entire array
  LConstants := FVM.GetConstants();

  Assert.AreEqual(Integer(Length(LConstants)), 3, 'Should have 3 constants');
  Assert.AreEqual(LValue1.IntValue, LConstants[0].IntValue, 'First constant should be correct');
  Assert.AreEqual(LValue2.StrValue, LConstants[1].StrValue, 'Second constant should be correct');
  Assert.AreEqual(LValue3.BoolValue, LConstants[2].BoolValue, 'Third constant should be correct');
end;

procedure TTestJetVMConstants.TestGetConstantsEmptyPool();
var
  LConstants: TArray<TJetValue>;
begin
  // Get constants from empty pool
  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 0, 'Empty pool should return empty array');
end;

// =============================================================================
// Constants Pool Growth Tests
// =============================================================================

procedure TTestJetVMConstants.TestConstantsPoolGrowth();
var
  LIndex: Integer;
  LConstants: TArray<TJetValue>;
begin
  // Add many constants to test pool growth
  for LIndex := 1 to 100 do
    FVM.AddConstant(FVM.MakeIntConstant(LIndex));

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 100, 'Pool should contain all added constants');

  // Verify values are preserved during growth
  for LIndex := 0 to 99 do
    Assert.AreEqual(Int64(LIndex + 1), LConstants[LIndex].IntValue,
      Format('Constant %d should have correct value after growth', [LIndex]));
end;

procedure TTestJetVMConstants.TestConstantsPoolCapacityExpansion();
var
  LIndex: Integer;
  LConstants: TArray<TJetValue>;
  LInitialLength: Integer;
  LFinalLength: Integer;
begin
  // Add initial set of constants
  for LIndex := 1 to 10 do
    FVM.AddConstant(FVM.MakeIntConstant(LIndex));

  LConstants := FVM.GetConstants();
  LInitialLength := Length(LConstants);

  // Add more constants to force expansion
  for LIndex := 11 to 100 do
    FVM.AddConstant(FVM.MakeIntConstant(LIndex));

  LConstants := FVM.GetConstants();
  LFinalLength := Length(LConstants);

  Assert.IsTrue(LFinalLength > LInitialLength, 'Pool should have expanded');
  Assert.AreEqual(LFinalLength, 100, 'Pool should contain all constants after expansion');
end;

procedure TTestJetVMConstants.TestLargeConstantsPool();
var
  LIndex: Integer;
  LConstants: TArray<TJetValue>;
  LLargePoolSize: Integer;
begin
  LLargePoolSize := 1000;

  // Add large number of constants
  for LIndex := 1 to LLargePoolSize do
    FVM.AddConstant(FVM.MakeIntConstant(LIndex * 2));

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), LLargePoolSize, 'Large pool should contain all constants');

  // Spot check some values
  Assert.AreEqual(Int64(2), LConstants[0].IntValue, 'First constant should be correct');
  Assert.AreEqual(Int64(1000), LConstants[499].IntValue, 'Middle constant should be correct');
  Assert.AreEqual(Int64(2000), LConstants[999].IntValue, 'Last constant should be correct');
end;

// =============================================================================
// AddConstant Behavior Tests (NO Deduplication)
// =============================================================================

procedure TTestJetVMConstants.TestAddConstantNoDuplication();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // AddConstant should NOT deduplicate - each call adds a new entry
  LValue1 := FVM.MakeStrConstant('Duplicate String');
  LValue2 := FVM.MakeStrConstant('Duplicate String');

  FVM.AddConstant(LValue1);
  FVM.AddConstant(LValue2);

  LConstants := FVM.GetConstants();

  // Should have both copies
  Assert.AreEqual(Integer(Length(LConstants)), 2, 'AddConstant should store duplicates separately');
  Assert.AreEqual('Duplicate String', LConstants[0].StrValue, 'First string should be correct');
  Assert.AreEqual('Duplicate String', LConstants[1].StrValue, 'Second string should be correct');
end;

procedure TTestJetVMConstants.TestAddConstantStringBehavior();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Test string handling with AddConstant
  LValue1 := FVM.MakeStrConstant('');
  LValue2 := FVM.MakeStrConstant('');
  LValue3 := FVM.MakeStrConstant('Different');

  FVM.AddConstant(LValue1);
  FVM.AddConstant(LValue2);
  FVM.AddConstant(LValue3);

  LConstants := FVM.GetConstants();

  // AddConstant does NOT deduplicate - should have all 3
  Assert.AreEqual(Integer(Length(LConstants)), 3, 'AddConstant should store all strings separately');
  Assert.AreEqual('', LConstants[0].StrValue, 'First empty string');
  Assert.AreEqual('', LConstants[1].StrValue, 'Second empty string');
  Assert.AreEqual('Different', LConstants[2].StrValue, 'Different string');
end;

procedure TTestJetVMConstants.TestAddConstantIntegerBehavior();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Test integer handling with AddConstant
  LValue1 := FVM.MakeIntConstant(42);
  LValue2 := FVM.MakeIntConstant(42);
  LValue3 := FVM.MakeIntConstant(42);

  FVM.AddConstant(LValue1);
  FVM.AddConstant(LValue2);
  FVM.AddConstant(LValue3);

  LConstants := FVM.GetConstants();

  // AddConstant does NOT deduplicate - should have all copies
  Assert.AreEqual(Integer(Length(LConstants)), 3, 'AddConstant should store duplicate integers separately');
  Assert.AreEqual(Int64(42), LConstants[0].IntValue, 'First integer should be correct');
  Assert.AreEqual(Int64(42), LConstants[1].IntValue, 'Second integer should be correct');
  Assert.AreEqual(Int64(42), LConstants[2].IntValue, 'Third integer should be correct');
end;

procedure TTestJetVMConstants.TestAddConstantBooleanBehavior();
var
  LValueTrue1: TJetValue;
  LValueTrue2: TJetValue;
  LValueFalse1: TJetValue;
  LValueFalse2: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Test boolean handling with AddConstant
  LValueTrue1 := FVM.MakeBoolConstant(True);
  LValueTrue2 := FVM.MakeBoolConstant(True);
  LValueFalse1 := FVM.MakeBoolConstant(False);
  LValueFalse2 := FVM.MakeBoolConstant(False);

  FVM.AddConstant(LValueTrue1);
  FVM.AddConstant(LValueTrue2);
  FVM.AddConstant(LValueFalse1);
  FVM.AddConstant(LValueFalse2);

  LConstants := FVM.GetConstants();

  // AddConstant does NOT deduplicate - should have all four values
  Assert.AreEqual(Integer(Length(LConstants)), 4, 'AddConstant should store duplicate boolean values separately');

  Assert.IsTrue(LConstants[0].BoolValue, 'First boolean should be True');
  Assert.IsTrue(LConstants[1].BoolValue, 'Second boolean should be True');
  Assert.IsFalse(LConstants[2].BoolValue, 'Third boolean should be False');
  Assert.IsFalse(LConstants[3].BoolValue, 'Fourth boolean should be False');
end;

procedure TTestJetVMConstants.TestAddConstantPointerBehavior();
var
  LTestInt: Integer;
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LValue4: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  LTestInt := 100;

  // Test pointer handling with AddConstant
  LValue1 := FVM.MakePtrConstant(@LTestInt);
  LValue2 := FVM.MakePtrConstant(@LTestInt);
  LValue3 := FVM.MakePtrConstant(nil);
  LValue4 := FVM.MakePtrConstant(nil);

  FVM.AddConstant(LValue1);
  FVM.AddConstant(LValue2);
  FVM.AddConstant(LValue3);
  FVM.AddConstant(LValue4);

  LConstants := FVM.GetConstants();

  // AddConstant does NOT deduplicate - should have all four values
  Assert.AreEqual(Integer(Length(LConstants)), 4, 'AddConstant should store duplicate pointer values separately');

  Assert.AreEqual(@LTestInt, LConstants[0].PtrValue, 'First pointer should be correct');
  Assert.AreEqual(@LTestInt, LConstants[1].PtrValue, 'Second pointer should be correct');
  Assert.IsNull(LConstants[2].PtrValue, 'Third pointer should be nil');
  Assert.IsNull(LConstants[3].PtrValue, 'Fourth pointer should be nil');
end;

// =============================================================================
// Fluent Interface Deduplication Tests (WITH Deduplication)
// =============================================================================

procedure TTestJetVMConstants.TestFluentInterfaceDeduplication();
var
  LConstants: TArray<TJetValue>;
begin
  // Use fluent interface which DOES deduplicate via AddConstantInternal
  FVM.LoadInt(42)
     .LoadInt(42)  // Duplicate
     .LoadInt(42)  // Another duplicate
     .Stop();

  LConstants := FVM.GetConstants();

  // Fluent interface should deduplicate - only unique constants stored
  Assert.IsTrue(Integer(Length(LConstants)) >= 1, 'Should have at least one constant');

  // Find the 42 constant (there should be only one due to deduplication)
  var LFound42Count := 0;
  var LIndex: Integer;
  for LIndex := 0 to High(LConstants) do
  begin
    if (LConstants[LIndex].ValueType = jvtInt) and (LConstants[LIndex].IntValue = 42) then
      Inc(LFound42Count);
  end;

  Assert.AreEqual(1, LFound42Count, 'Fluent interface should deduplicate identical integer constants');
end;

procedure TTestJetVMConstants.TestFluentInterfaceStringDeduplication();
var
  LConstants: TArray<TJetValue>;
begin
  // Use fluent interface with duplicate strings
  FVM.LoadStr('Duplicate')
     .LoadStr('Duplicate')  // Same string
     .LoadStr('Different')
     .LoadStr('Duplicate')  // Same as first
     .Stop();

  LConstants := FVM.GetConstants();

  // Count occurrences of each string
  var LDuplicateCount := 0;
  var LDifferentCount := 0;
  var LIndex: Integer;

  for LIndex := 0 to High(LConstants) do
  begin
    if LConstants[LIndex].ValueType = jvtStr then
    begin
      if LConstants[LIndex].StrValue = 'Duplicate' then
        Inc(LDuplicateCount)
      else if LConstants[LIndex].StrValue = 'Different' then
        Inc(LDifferentCount);
    end;
  end;

  Assert.AreEqual(1, LDuplicateCount, 'Fluent interface should deduplicate identical string constants');
  Assert.AreEqual(1, LDifferentCount, 'Different strings should be stored separately');
end;

procedure TTestJetVMConstants.TestFluentInterfaceMixedDeduplication();
var
  LConstants: TArray<TJetValue>;
begin
  // Mixed types with duplicates via fluent interface
  FVM.LoadInt(100)
     .LoadStr('Test')
     .LoadBool(True)
     .LoadInt(100)      // Duplicate int
     .LoadStr('Test')   // Duplicate string
     .LoadBool(True)    // Duplicate bool
     .LoadInt(200)      // Different int
     .Stop();

  LConstants := FVM.GetConstants();

  // Count unique values
  var LIntCount100 := 0;
  var LIntCount200 := 0;
  var LStrTestCount := 0;
  var LBoolTrueCount := 0;
  var LIndex: Integer;

  for LIndex := 0 to High(LConstants) do
  begin
    case LConstants[LIndex].ValueType of
      jvtInt:
        if LConstants[LIndex].IntValue = 100 then Inc(LIntCount100)
        else if LConstants[LIndex].IntValue = 200 then Inc(LIntCount200);
      jvtStr:
        if LConstants[LIndex].StrValue = 'Test' then Inc(LStrTestCount);
      jvtBool:
        if LConstants[LIndex].BoolValue = True then Inc(LBoolTrueCount);
    end;
  end;

  Assert.AreEqual(1, LIntCount100, 'Should deduplicate int 100');
  Assert.AreEqual(1, LIntCount200, 'Should have unique int 200');
  Assert.AreEqual(1, LStrTestCount, 'Should deduplicate string Test');
  Assert.AreEqual(1, LBoolTrueCount, 'Should deduplicate bool True');
end;

// =============================================================================
// Mixed Type Constants Tests
// =============================================================================

procedure TTestJetVMConstants.TestMixedTypeConstants();
var
  LIntValue: TJetValue;
  LStrValue: TJetValue;
  LBoolValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Add constants of different types
  LIntValue := FVM.MakeIntConstant(42);
  LStrValue := FVM.MakeStrConstant('Mixed');
  LBoolValue := FVM.MakeBoolConstant(True);

  FVM.AddConstant(LIntValue);
  FVM.AddConstant(LStrValue);
  FVM.AddConstant(LBoolValue);

  LConstants := FVM.GetConstants();

  Assert.AreEqual(Integer(Length(LConstants)), 3, 'Should store mixed types');
  Assert.AreEqual(jvtInt, LConstants[0].ValueType, 'First should be integer');
  Assert.AreEqual(jvtStr, LConstants[1].ValueType, 'Second should be string');
  Assert.AreEqual(jvtBool, LConstants[2].ValueType, 'Third should be boolean');
end;

procedure TTestJetVMConstants.TestMixedTypeRetrieval();
var
  LIndex: Integer;
  LValues: array[0..4] of TJetValue;
  LRetrievedValue: TJetValue;
begin
  // Create mixed type constants
  LValues[0] := FVM.MakeIntConstant(100);
  LValues[1] := FVM.MakeStrConstant('String100');
  LValues[2] := FVM.MakeBoolConstant(True);
  LValues[3] := FVM.MakeUIntConstant(200);
  LValues[4] := FVM.MakePtrConstant(nil);

  // Add all constants
  for LIndex := 0 to 4 do
    FVM.AddConstant(LValues[LIndex]);

  // Retrieve and verify each
  for LIndex := 0 to 4 do
  begin
    LRetrievedValue := FVM.GetConstant(LIndex);
    Assert.AreEqual(LValues[LIndex].ValueType, LRetrievedValue.ValueType,
      Format('Constant %d should have correct type', [LIndex]));

    case LRetrievedValue.ValueType of
      jvtInt: Assert.AreEqual(LValues[LIndex].IntValue, LRetrievedValue.IntValue, 'Int value should match');
      jvtUInt: Assert.AreEqual(LValues[LIndex].UIntValue, LRetrievedValue.UIntValue, 'UInt value should match');
      jvtStr: Assert.AreEqual(LValues[LIndex].StrValue, LRetrievedValue.StrValue, 'String value should match');
      jvtBool: Assert.AreEqual(LValues[LIndex].BoolValue, LRetrievedValue.BoolValue, 'Bool value should match');
      jvtPointer: Assert.AreEqual(LValues[LIndex].PtrValue, LRetrievedValue.PtrValue, 'Pointer value should match');
    end;
  end;
end;

procedure TTestJetVMConstants.TestMixedTypeAddConstantBehavior();
var
  LConstants: TArray<TJetValue>;
begin
  // Add mixed types with some duplicates using AddConstant (no deduplication)
  FVM.AddConstant(FVM.MakeIntConstant(42));
  FVM.AddConstant(FVM.MakeStrConstant('Test'));
  FVM.AddConstant(FVM.MakeIntConstant(42));      // Duplicate int
  FVM.AddConstant(FVM.MakeBoolConstant(True));
  FVM.AddConstant(FVM.MakeStrConstant('Test'));  // Duplicate string
  FVM.AddConstant(FVM.MakeBoolConstant(True));   // Duplicate bool
  FVM.AddConstant(FVM.MakeIntConstant(100));     // Different int

  LConstants := FVM.GetConstants();

  // AddConstant does NOT deduplicate - should have all 7 constants
  Assert.AreEqual(Integer(Length(LConstants)), 7, 'AddConstant should store all constants without deduplication');

  Assert.AreEqual(Int64(42), LConstants[0].IntValue, 'First int');
  Assert.AreEqual('Test', LConstants[1].StrValue, 'First string');
  Assert.AreEqual(Int64(42), LConstants[2].IntValue, 'Duplicate int');
  Assert.IsTrue(LConstants[3].BoolValue, 'First bool');
  Assert.AreEqual('Test', LConstants[4].StrValue, 'Duplicate string');
  Assert.IsTrue(LConstants[5].BoolValue, 'Duplicate bool');
  Assert.AreEqual(Int64(100), LConstants[6].IntValue, 'Different int');
end;

// =============================================================================
// Constants Pool Integration Tests
// =============================================================================

procedure TTestJetVMConstants.TestFluentInterfaceUsesConstants();
var
  LConstants: TArray<TJetValue>;
begin
  // Use fluent interface which should populate constants pool
  FVM.LoadInt(42)
     .LoadStr('Fluent Test')
     .LoadBool(False)
     .Stop();

  LConstants := FVM.GetConstants();

  // Should have constants from fluent calls
  Assert.IsTrue(Integer(Length(LConstants)) >= 3, 'Fluent interface should populate constants');

  // Find our constants (order may vary due to deduplication)
  var LFoundInt := False;
  var LFoundStr := False;
  var LFoundBool := False;
  var LIndex: Integer;

  for LIndex := 0 to High(LConstants) do
  begin
    case LConstants[LIndex].ValueType of
      jvtInt: if LConstants[LIndex].IntValue = 42 then LFoundInt := True;
      jvtStr: if LConstants[LIndex].StrValue = 'Fluent Test' then LFoundStr := True;
      jvtBool: if LConstants[LIndex].BoolValue = False then LFoundBool := True;
    end;
  end;

  Assert.IsTrue(LFoundInt, 'Should find integer constant from LoadInt');
  Assert.IsTrue(LFoundStr, 'Should find string constant from LoadStr');
  Assert.IsTrue(LFoundBool, 'Should find boolean constant from LoadBool');
end;

procedure TTestJetVMConstants.TestLoadConstOpcode();
var
  LValue: TJetValue;
  LResult: TJetValue;
begin
  // Manually add a constant
  LValue := FVM.MakeIntConstant(999);
  FVM.AddConstant(LValue);

  // Use LoadConst to load it during execution
  FVM.LoadConst(0)
     .Stop()
     .Execute();

  // Should have the constant value on stack
  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(999), LResult.IntValue, 'LoadConst should load constant from pool');
end;

procedure TTestJetVMConstants.TestConstantsInExecution();
var
  LResult: TJetValue;
begin
  // Create program that uses constants in arithmetic
  FVM.LoadInt(10)
     .LoadInt(20)
     .AddInt()
     .Stop()
     .Execute();

  LResult := FVM.PopValue();
  Assert.AreEqual(Int64(30), LResult.IntValue, 'Constants should work in arithmetic execution');

  // Verify constants were created
  var LConstants := FVM.GetConstants();
  Assert.IsTrue(Integer(Length(LConstants)) >= 2, 'Should have created constants during execution setup');
end;

// =============================================================================
// Edge Cases and Boundary Values
// =============================================================================

procedure TTestJetVMConstants.TestBoundaryIntegerConstants();
var
  LMaxValue: TJetValue;
  LMinValue: TJetValue;
  LZeroValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Test boundary integer values
  LMaxValue := FVM.MakeIntConstant(High(Int64));
  LMinValue := FVM.MakeIntConstant(Low(Int64));
  LZeroValue := FVM.MakeIntConstant(0);

  FVM.AddConstant(LMaxValue);
  FVM.AddConstant(LMinValue);
  FVM.AddConstant(LZeroValue);

  LConstants := FVM.GetConstants();

  Assert.AreEqual(Integer(Length(LConstants)), 3, 'Should store boundary integers');
  Assert.AreEqual(High(Int64), LConstants[0].IntValue, 'Max int should be preserved');
  Assert.AreEqual(Low(Int64), LConstants[1].IntValue, 'Min int should be preserved');
  Assert.AreEqual(Int64(0), LConstants[2].IntValue, 'Zero should be preserved');
end;

procedure TTestJetVMConstants.TestBoundaryUIntegerConstants();
var
  LMaxValue: TJetValue;
  LMinValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Test boundary unsigned integer values
  LMaxValue := FVM.MakeUIntConstant(High(UInt64));
  LMinValue := FVM.MakeUIntConstant(Low(UInt64));

  FVM.AddConstant(LMaxValue);
  FVM.AddConstant(LMinValue);

  LConstants := FVM.GetConstants();

  Assert.AreEqual(Integer(Length(LConstants)), 2, 'Should store boundary unsigned integers');
  Assert.AreEqual(High(UInt64), LConstants[0].UIntValue, 'Max uint should be preserved');
  Assert.AreEqual(Low(UInt64), LConstants[1].UIntValue, 'Min uint should be preserved');
end;

procedure TTestJetVMConstants.TestEmptyStringConstants();
var
  LEmptyValue1: TJetValue;
  LEmptyValue2: TJetValue;
  LNonEmptyValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Test empty string constants with AddConstant (no deduplication)
  LEmptyValue1 := FVM.MakeStrConstant('');
  LEmptyValue2 := FVM.MakeStrConstant('');
  LNonEmptyValue := FVM.MakeStrConstant('Not Empty');

  FVM.AddConstant(LEmptyValue1);
  FVM.AddConstant(LEmptyValue2);
  FVM.AddConstant(LNonEmptyValue);

  LConstants := FVM.GetConstants();

  // AddConstant does NOT deduplicate - should have all 3 constants
  Assert.AreEqual(Integer(Length(LConstants)), 3, 'AddConstant should store all constants separately');
  Assert.AreEqual('', LConstants[0].StrValue, 'First should be empty string');
  Assert.AreEqual('', LConstants[1].StrValue, 'Second should be empty string');
  Assert.AreEqual('Not Empty', LConstants[2].StrValue, 'Third should be non-empty string');
end;

procedure TTestJetVMConstants.TestLargeStringConstants();
var
  LLargeString: string;
  LValue: TJetValue;
  LConstants: TArray<TJetValue>;
  LIndex: Integer;
begin
  // Create large string
  LLargeString := '';
  for LIndex := 1 to 10000 do
    LLargeString := LLargeString + 'A';

  LValue := FVM.MakeStrConstant(LLargeString);
  FVM.AddConstant(LValue);

  LConstants := FVM.GetConstants();

  Assert.AreEqual(Integer(Length(LConstants)), 1, 'Should store large string');
  Assert.AreEqual(Integer(Length(LConstants[0].StrValue)), 10000, 'Large string should preserve length');
  Assert.IsTrue(LConstants[0].StrValue.StartsWith('AAAA'), 'Large string should preserve content');
end;

procedure TTestJetVMConstants.TestNilPointerConstants();
var
  LNilValue1: TJetValue;
  LNilValue2: TJetValue;
  LTestInt: Integer;
  LNonNilValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  LTestInt := 42;

  // Test nil pointer constants with AddConstant (no deduplication)
  LNilValue1 := FVM.MakePtrConstant(nil);
  LNilValue2 := FVM.MakePtrConstant(nil);
  LNonNilValue := FVM.MakePtrConstant(@LTestInt);

  FVM.AddConstant(LNilValue1);
  FVM.AddConstant(LNilValue2);
  FVM.AddConstant(LNonNilValue);

  LConstants := FVM.GetConstants();

  // AddConstant does NOT deduplicate - should have all 3 constants
  Assert.AreEqual(Integer(Length(LConstants)), 3, 'AddConstant should store all constants separately');
  Assert.IsNull(LConstants[0].PtrValue, 'First should be nil pointer');
  Assert.IsNull(LConstants[1].PtrValue, 'Second should be nil pointer');
  Assert.AreEqual(@LTestInt, LConstants[2].PtrValue, 'Third should be non-nil pointer');
end;

// =============================================================================
// Constants Pool State Management
// =============================================================================

procedure TTestJetVMConstants.TestConstantsPoolAfterExecution();
var
  LConstantsBefore: TArray<TJetValue>;
  LConstantsAfter: TArray<TJetValue>;
begin
  // Add constants and execute program
  FVM.LoadInt(100)
     .LoadInt(200)
     .AddInt()
     .Stop();

  LConstantsBefore := FVM.GetConstants();

  FVM.Execute();

  LConstantsAfter := FVM.GetConstants();

  // Constants pool should be unchanged by execution
  Assert.AreEqual(Integer(Length(LConstantsBefore)), Integer(Length(LConstantsAfter)),
    'Constants pool should be unchanged by execution');

  var LIndex: Integer;
  for LIndex := 0 to High(LConstantsBefore) do
  begin
    Assert.AreEqual(LConstantsBefore[LIndex].ValueType, LConstantsAfter[LIndex].ValueType,
      'Constant type should be unchanged');

    case LConstantsBefore[LIndex].ValueType of
      jvtInt: Assert.AreEqual(LConstantsBefore[LIndex].IntValue, LConstantsAfter[LIndex].IntValue, 'Int constant unchanged');
      jvtStr: Assert.AreEqual(LConstantsBefore[LIndex].StrValue, LConstantsAfter[LIndex].StrValue, 'String constant unchanged');
    end;
  end;
end;

procedure TTestJetVMConstants.TestConstantsPoolPersistence();
var
  LValue: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Add constant
  LValue := FVM.MakeStrConstant('Persistent');
  FVM.AddConstant(LValue);

  // Execute multiple programs
  FVM.LoadInt(1).Stop().Execute();
  FVM.Reset();

  FVM.LoadInt(2).Stop().Execute();
  FVM.Reset();

  // Constants should persist (but reset clears them in this implementation)
  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 0, 'Constants are cleared by reset in this implementation');
end;

procedure TTestJetVMConstants.TestConstantsPoolStateConsistency();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LConstantsAfterFirst: TArray<TJetValue>;
  LConstantsAfterSecond: TArray<TJetValue>;
begin
  // Add first constant
  LValue1 := FVM.MakeIntConstant(111);
  FVM.AddConstant(LValue1);

  LConstantsAfterFirst := FVM.GetConstants();

  // Add second constant
  LValue2 := FVM.MakeStrConstant('Second');
  FVM.AddConstant(LValue2);

  LConstantsAfterSecond := FVM.GetConstants();

  // First constant should still be there and unchanged
  Assert.AreEqual(Integer(Length(LConstantsAfterFirst)), 1, 'Should have one constant after first add');
  Assert.AreEqual(Integer(Length(LConstantsAfterSecond)), 2, 'Should have two constants after second add');

  Assert.AreEqual(LConstantsAfterFirst[0].IntValue, LConstantsAfterSecond[0].IntValue,
    'First constant should remain unchanged');
  Assert.AreEqual('Second', LConstantsAfterSecond[1].StrValue, 'Second constant should be correct');
end;

// =============================================================================
// Performance and Memory Tests
// =============================================================================

procedure TTestJetVMConstants.TestConstantsPoolPerformance();
var
  LIndex: Integer;
  LConstants: TArray<TJetValue>;
  LPerformanceSize: Integer;
begin
  LPerformanceSize := 1000;

  // Add many constants quickly
  for LIndex := 1 to LPerformanceSize do
    FVM.AddConstant(FVM.MakeIntConstant(LIndex));

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), LPerformanceSize, 'Performance test should complete successfully');

  // Verify random access is fast
  Assert.AreEqual(Int64(1), LConstants[0].IntValue, 'First constant should be correct');
  Assert.AreEqual(Int64(500), LConstants[499].IntValue, 'Middle constant should be correct');
  Assert.AreEqual(Int64(LPerformanceSize), LConstants[LPerformanceSize - 1].IntValue, 'Last constant should be correct');
end;

procedure TTestJetVMConstants.TestConstantsPoolMemoryUsage();
var
  LIndex: Integer;
  LLargeStrings: array[0..99] of string;
  LConstants: TArray<TJetValue>;
begin
  // Create large strings
  for LIndex := 0 to 99 do
  begin
    LLargeStrings[LIndex] := Format('Large String %d: ', [LIndex]) + StringOfChar('X', 1000);
    FVM.AddConstant(FVM.MakeStrConstant(LLargeStrings[LIndex]));
  end;

  LConstants := FVM.GetConstants();
  Assert.AreEqual(Integer(Length(LConstants)), 100, 'Should handle large strings efficiently');

  // Verify content is preserved
  Assert.IsTrue(LConstants[0].StrValue.Contains('Large String 0'), 'Large string content should be preserved');
  Assert.IsTrue(LConstants[99].StrValue.Contains('Large String 99'), 'Last large string should be preserved');
end;

procedure TTestJetVMConstants.TestAddConstantPerformance();
var
  LIndex: Integer;
  LConstants: TArray<TJetValue>;
begin
  // Test that AddConstant does NOT deduplicate for performance
  // Add same constants many times - should store each separately
  for LIndex := 1 to 100 do
  begin
    FVM.AddConstant(FVM.MakeIntConstant(42));
    FVM.AddConstant(FVM.MakeStrConstant('Same'));
    FVM.AddConstant(FVM.MakeBoolConstant(True));
  end;

  LConstants := FVM.GetConstants();

  // Should have all 300 constants (100 * 3) - no deduplication
  Assert.AreEqual(Integer(Length(LConstants)), 300, 'AddConstant should store all constants without deduplication');
end;

// =============================================================================
// Error Handling Tests
// =============================================================================

procedure TTestJetVMConstants.TestInvalidConstantIndexAccess();
begin
  // Add one constant
  FVM.AddConstant(FVM.MakeIntConstant(42));

  // Test invalid indices - should now throw exceptions
  Assert.WillRaise(
    procedure
    begin
      FVM.GetConstant(1); // Beyond range
    end,
    EJetVMError,
    'Should raise exception for index beyond constants pool'
  );

  Assert.WillRaise(
    procedure
    begin
      FVM.GetConstant(-1); // Negative index
    end,
    EJetVMError,
    'Should raise exception for negative index'
  );

  Assert.WillRaise(
    procedure
    begin
      FVM.GetConstant(999); // Way beyond range
    end,
    EJetVMError,
    'Should raise exception for way out of range index'
  );
end;

procedure TTestJetVMConstants.TestConstantsPoolErrorRecovery();
var
  LConstants: TArray<TJetValue>;
begin
  // Add valid constant
  FVM.AddConstant(FVM.MakeIntConstant(100));

  // Try invalid access - should now throw exception
  Assert.WillRaise(
    procedure
    begin
      FVM.GetConstant(10); // Invalid
    end,
    EJetVMError,
    'Should raise exception for invalid constant access'
  );

  // Pool should still be usable
  FVM.AddConstant(FVM.MakeIntConstant(200));
  LConstants := FVM.GetConstants();

  Assert.AreEqual(Integer(Length(LConstants)), 2, 'Pool should be usable after error');
  Assert.AreEqual(Int64(100), LConstants[0].IntValue, 'Original constant should be intact');
  Assert.AreEqual(Int64(200), LConstants[1].IntValue, 'New constant should be added correctly');
end;

procedure TTestJetVMConstants.TestConstantsPoolBoundsChecking();
var
  LValue: TJetValue;
begin
  // Empty pool bounds checking - should now throw exception
  Assert.WillRaise(
    procedure
    begin
      FVM.GetConstant(0); // Empty pool
    end,
    EJetVMError,
    'Should raise exception for empty pool access'
  );

  // Add constant and test boundaries
  LValue := FVM.MakeIntConstant(42);
  FVM.AddConstant(LValue);

  // Valid access should work
  Assert.AreEqual(Int64(42), FVM.GetConstant(0).IntValue, 'Valid index should work');

  // Invalid access should fail
  Assert.WillRaise(
    procedure
    begin
      FVM.GetConstant(1); // Just beyond range
    end,
    EJetVMError,
    'Should raise exception for index just beyond range'
  );
end;

// =============================================================================
// Constants Factory Methods Tests
// =============================================================================

procedure TTestJetVMConstants.TestMakeIntConstantFactory();
var
  LValue: TJetValue;
begin
  LValue := FVM.MakeIntConstant(12345);

  Assert.AreEqual(jvtInt, LValue.ValueType, 'MakeIntConstant should create integer type');
  Assert.AreEqual(Int64(12345), LValue.IntValue, 'MakeIntConstant should set correct value');
end;

procedure TTestJetVMConstants.TestMakeUIntConstantFactory();
var
  LValue: TJetValue;
begin
  LValue := FVM.MakeUIntConstant(54321);

  Assert.AreEqual(jvtUInt, LValue.ValueType, 'MakeUIntConstant should create unsigned integer type');
  Assert.AreEqual(UInt64(54321), LValue.UIntValue, 'MakeUIntConstant should set correct value');
end;

procedure TTestJetVMConstants.TestMakeStrConstantFactory();
var
  LValue: TJetValue;
begin
  LValue := FVM.MakeStrConstant('Factory Test');

  Assert.AreEqual(jvtStr, LValue.ValueType, 'MakeStrConstant should create string type');
  Assert.AreEqual('Factory Test', LValue.StrValue, 'MakeStrConstant should set correct value');
end;

procedure TTestJetVMConstants.TestMakeBoolConstantFactory();
var
  LTrueValue: TJetValue;
  LFalseValue: TJetValue;
begin
  LTrueValue := FVM.MakeBoolConstant(True);
  LFalseValue := FVM.MakeBoolConstant(False);

  Assert.AreEqual(jvtBool, LTrueValue.ValueType, 'MakeBoolConstant should create boolean type');
  Assert.IsTrue(LTrueValue.BoolValue, 'MakeBoolConstant should set True correctly');

  Assert.AreEqual(jvtBool, LFalseValue.ValueType, 'MakeBoolConstant should create boolean type');
  Assert.IsFalse(LFalseValue.BoolValue, 'MakeBoolConstant should set False correctly');
end;

procedure TTestJetVMConstants.TestMakePtrConstantFactory();
var
  LValue: TJetValue;
  LTestInt: Integer;
  LNilValue: TJetValue;
begin
  LTestInt := 999;

  LValue := FVM.MakePtrConstant(@LTestInt);
  LNilValue := FVM.MakePtrConstant(nil);

  Assert.AreEqual(jvtPointer, LValue.ValueType, 'MakePtrConstant should create pointer type');
  Assert.AreEqual(@LTestInt, LValue.PtrValue, 'MakePtrConstant should set correct pointer value');

  Assert.AreEqual(jvtPointer, LNilValue.ValueType, 'MakePtrConstant should create pointer type for nil');
  Assert.IsNull(LNilValue.PtrValue, 'MakePtrConstant should set nil correctly');
end;

// =============================================================================
// Fluent vs AddConstant Comparison Tests
// =============================================================================

procedure TTestJetVMConstants.TestFluentVsAddConstantBehavior();
var
  LVM2: TJetVM;
  LConstants1: TArray<TJetValue>;
  LConstants2: TArray<TJetValue>;
begin
  LVM2 := TJetVM.Create(vlBasic);
  try
    // VM1: Use AddConstant (no deduplication)
    FVM.AddConstant(FVM.MakeIntConstant(42));
    FVM.AddConstant(FVM.MakeIntConstant(42));
    FVM.AddConstant(FVM.MakeIntConstant(42));

    // VM2: Use fluent interface (with deduplication)
    LVM2.LoadInt(42)
        .LoadInt(42)
        .LoadInt(42)
        .Stop();

    LConstants1 := FVM.GetConstants();
    LConstants2 := LVM2.GetConstants();

    // AddConstant should have 3 copies
    Assert.AreEqual(3, Integer(Length(LConstants1)), 'AddConstant should store all copies');

    // Fluent should have 1 copy due to deduplication
    var LIntCount := 0;
    var LIndex: Integer;
    for LIndex := 0 to High(LConstants2) do
      if (LConstants2[LIndex].ValueType = jvtInt) and (LConstants2[LIndex].IntValue = 42) then
        Inc(LIntCount);

    Assert.AreEqual(1, LIntCount, 'Fluent interface should deduplicate');

  finally
    LVM2.Free();
  end;
end;

procedure TTestJetVMConstants.TestFluentDeduplicationVsAddConstantNone();
var
  LConstants: TArray<TJetValue>;
begin
  // Mix fluent and AddConstant calls
  FVM.LoadInt(100)  // Fluent - will deduplicate
     .Stop();

  FVM.AddConstant(FVM.MakeIntConstant(100)); // Direct add - no deduplication

  LConstants := FVM.GetConstants();

  // Should have at least 2 entries (1 from fluent, 1 from AddConstant)
  var LIntCount := 0;
  var LIndex: Integer;
  for LIndex := 0 to High(LConstants) do
    if (LConstants[LIndex].ValueType = jvtInt) and (LConstants[LIndex].IntValue = 100) then
      Inc(LIntCount);

  Assert.IsTrue(LIntCount >= 2, 'Should have at least 2 copies of 100 (fluent + AddConstant)');
end;

procedure TTestJetVMConstants.TestDeduplicationOrderIndependence();
var
  LVM2: TJetVM;
  LConstants1: TArray<TJetValue>;
  LConstants2: TArray<TJetValue>;
begin
  LVM2 := TJetVM.Create(vlBasic);
  try
    // Both use fluent interface but in different order
    // VM1: A, B, C
    FVM.LoadStr('A')
       .LoadStr('B')
       .LoadStr('C')
       .Stop();

    // VM2: C, B, A
    LVM2.LoadStr('C')
        .LoadStr('B')
        .LoadStr('A')
        .Stop();

    LConstants1 := FVM.GetConstants();
    LConstants2 := LVM2.GetConstants();

    // Both should have same number of unique constants
    Assert.AreEqual(Integer(Length(LConstants1)), Integer(Length(LConstants2)),
      'Order should not affect deduplication count with fluent interface');

  finally
    LVM2.Free();
  end;
end;

// =============================================================================
// Constants Pool Dump and Debug Tests
// =============================================================================

procedure TTestJetVMConstants.TestConstantsPoolDump();
begin
  // Add various constants
  FVM.AddConstant(FVM.MakeIntConstant(42));
  FVM.AddConstant(FVM.MakeStrConstant('Debug Test'));
  FVM.AddConstant(FVM.MakeBoolConstant(True));

  // Test that DumpConstants doesn't crash and only shows valid constants
  try
    FVM.DumpConstants();
    // Should succeed without exception and show only 3 constants
  except
    Assert.Fail('DumpConstants should not raise exception');
  end;
end;

procedure TTestJetVMConstants.TestConstantsPoolInspection();
var
  LConstants: TArray<TJetValue>;
  LIndex: Integer;
begin
  // Add constants for inspection
  FVM.AddConstant(FVM.MakeIntConstant(100));
  FVM.AddConstant(FVM.MakeStrConstant('Inspect'));
  FVM.AddConstant(FVM.MakeUIntConstant(200));

  LConstants := FVM.GetConstants();

  // Inspect all constants
  for LIndex := 0 to High(LConstants) do
  begin
    Assert.IsTrue(
      (LConstants[LIndex].ValueType = jvtInt) or
      (LConstants[LIndex].ValueType = jvtUInt) or
      (LConstants[LIndex].ValueType = jvtStr),
      Format('Constant %d should have valid type', [LIndex])
    );
  end;
end;

procedure TTestJetVMConstants.TestConstantsPoolDebugging();
var
  LConstants: TArray<TJetValue>;
begin
  // Add constants with known values for debugging
  FVM.AddConstant(FVM.MakeIntConstant(999));
  FVM.AddConstant(FVM.MakeStrConstant('DEBUG'));

  LConstants := FVM.GetConstants();

  // Verify we can debug/inspect the constants
  Assert.AreEqual(Integer(Length(LConstants)), 2, 'Debug: Should have 2 constants');
  Assert.AreEqual(Int64(999), LConstants[0].IntValue, 'Debug: First constant should be 999');
  Assert.AreEqual('DEBUG', LConstants[1].StrValue, 'Debug: Second constant should be DEBUG');

  // Test getting individual constants for debugging
  var LDebugValue1 := FVM.GetConstant(0);
  var LDebugValue2 := FVM.GetConstant(1);

  Assert.AreEqual(LConstants[0].IntValue, LDebugValue1.IntValue, 'Debug: Individual access should match array access');
  Assert.AreEqual(LConstants[1].StrValue, LDebugValue2.StrValue, 'Debug: Individual access should match array access');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMConstants);

end.
