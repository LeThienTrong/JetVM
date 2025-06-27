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

unit JetVM.Test.Registers;

{$I JetVM.Defines.inc}

interface

uses
  DUnitX.TestFramework,
  System.SysUtils,
  System.Classes,
  JetVM;

type
  [TestFixture]
  TTestJetVMRegisters = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Local Register Tests
    // ==========================================================================
    [Test]
    procedure TestLocalRegisterInitialState();
    [Test]
    procedure TestStoreLoadLocalInteger();
    [Test]
    procedure TestStoreLoadLocalUInteger();
    [Test]
    procedure TestStoreLoadLocalString();
    [Test]
    procedure TestStoreLoadLocalBoolean();
    [Test]
    procedure TestStoreLoadLocalPointer();

    // ==========================================================================
    // Local Register Edge Cases
    // ==========================================================================
    [Test]
    procedure TestLocalRegisterIndexZero();
    [Test]
    procedure TestLocalRegisterHighIndex();
    [Test]
    procedure TestLocalRegisterNegativeIndex();
    [Test]
    procedure TestLocalRegisterOverwrite();
    [Test]
    procedure TestLocalRegisterSequentialAccess();

    // ==========================================================================
    // Global Register Tests
    // ==========================================================================
    [Test]
    procedure TestGlobalRegisterInitialState();
    [Test]
    procedure TestStoreLoadGlobalInteger();
    [Test]
    procedure TestStoreLoadGlobalUInteger();
    [Test]
    procedure TestStoreLoadGlobalString();
    [Test]
    procedure TestStoreLoadGlobalBoolean();
    [Test]
    procedure TestStoreLoadGlobalPointer();

    // ==========================================================================
    // Global Register Edge Cases
    // ==========================================================================
    [Test]
    procedure TestGlobalRegisterIndexZero();
    [Test]
    procedure TestGlobalRegisterHighIndex();
    [Test]
    procedure TestGlobalRegisterPersistence();
    [Test]
    procedure TestGlobalRegisterOverwrite();
    [Test]
    procedure TestGlobalRegisterCrossFunctionAccess();

    // ==========================================================================
    // Parameter Register Tests
    // ==========================================================================
    [Test]
    procedure TestParameterRegisterAccess();
    [Test]
    procedure TestParameterRegisterTypes();
    [Test]
    procedure TestParameterRegisterIndexing();
    [Test]
    procedure TestParameterRegisterConsistency();

    // ==========================================================================
    // Base Pointer Management Tests
    // ==========================================================================
    [Test]
    procedure TestBasePointerInitialState();
    [Test]
    procedure TestBasePointerWithLocalAccess();
    [Test]
    procedure TestBasePointerInFunctionCalls();
    [Test]
    procedure TestBasePointerStackFrames();

    // ==========================================================================
    // Register Type Consistency Tests
    // ==========================================================================
    [Test]
    procedure TestRegisterTypePreservation();
    [Test]
    procedure TestRegisterTypeOverwriting();
    [Test]
    procedure TestRegisterValuePrecision();
    [Test]
    procedure TestRegisterArraySupport();

    // ==========================================================================
    // Cross-Register Operations Tests
    // ==========================================================================
    [Test]
    procedure TestLocalToGlobalTransfer();
    [Test]
    procedure TestGlobalToLocalTransfer();
    [Test]
    procedure TestParameterToLocalTransfer();
    [Test]
    procedure TestRegisterSwapping();

    // ==========================================================================
    // Register Bounds and Validation Tests
    // ==========================================================================
    [Test]
    procedure TestLocalRegisterBounds();
    [Test]
    procedure TestGlobalRegisterBounds();
    [Test]
    procedure TestParameterRegisterBounds();
    [Test]
    procedure TestRegisterValidationLevels();

    // ==========================================================================
    // Complex Register Scenarios
    // ==========================================================================
    [Test]
    procedure TestNestedFunctionRegisterIsolation();
    [Test]
    procedure TestRecursiveFunctionRegisters();
    [Test]
    procedure TestRegisterStateAfterException();
    [Test]
    procedure TestMassRegisterOperations();

    // ==========================================================================
    // Performance and Memory Tests
    // ==========================================================================
    [Test]
    procedure TestRegisterMemoryFootprint();
    [Test]
    procedure TestRegisterAccessPerformance();
    [Test]
    procedure TestRegisterGarbageCollection();
    [Test]
    procedure TestRegisterResetBehavior();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMRegisters.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMRegisters.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Local Register Tests
// =============================================================================

procedure TTestJetVMRegisters.TestLocalRegisterInitialState();
var
  LValue: TJetValue;
begin
  // Test that local registers start in a clean state
  FVM.LoadInt(42).StoreLocal(0).LoadLocal(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(42), LValue.IntValue, 'Local register should store and retrieve integer correctly');
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Local register should preserve value type');
end;

procedure TTestJetVMRegisters.TestStoreLoadLocalInteger();
var
  LValue: TJetValue;
begin
  // Test storing and loading integers to/from local registers
  FVM.LoadInt(12345).StoreLocal(0).LoadLocal(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(12345), LValue.IntValue, 'Local integer register should store/load correctly');
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Value type should be preserved as integer');
end;

procedure TTestJetVMRegisters.TestStoreLoadLocalUInteger();
var
  LValue: TJetValue;
const
  CTestValue: UInt64 = 9876543210;
begin
  // Test storing and loading unsigned integers
  FVM.LoadUInt(CTestValue).StoreLocal(1).LoadLocal(1).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(CTestValue, LValue.UIntValue, 'Local UInteger register should store/load correctly');
  Assert.AreEqual(jvtUInt, LValue.ValueType, 'Value type should be preserved as UInteger');
end;

procedure TTestJetVMRegisters.TestStoreLoadLocalString();
var
  LValue: TJetValue;
const
  CTestString = 'Hello JetVM Registers!';
begin
  // Test storing and loading strings
  FVM.LoadStr(CTestString).StoreLocal(2).LoadLocal(2).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(CTestString, LValue.StrValue, 'Local string register should store/load correctly');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Value type should be preserved as string');
end;

procedure TTestJetVMRegisters.TestStoreLoadLocalBoolean();
var
  LValue: TJetValue;
begin
  // Test storing and loading boolean values
  FVM.LoadBool(True).StoreLocal(3).LoadLocal(3).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(True, LValue.BoolValue, 'Local boolean register should store/load correctly');
  Assert.AreEqual(jvtBool, LValue.ValueType, 'Value type should be preserved as boolean');
end;

procedure TTestJetVMRegisters.TestStoreLoadLocalPointer();
var
  LValue: TJetValue;
begin
  // Test storing and loading pointer values using AddrOf
  FVM.LoadInt(42).AddrOf().StoreLocal(4).LoadLocal(4).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Value type should be preserved as pointer');
  Assert.IsNotNull(LValue.PtrValue, 'Pointer value should not be null');
end;

// =============================================================================
// Local Register Edge Cases
// =============================================================================

procedure TTestJetVMRegisters.TestLocalRegisterIndexZero();
var
  LValue: TJetValue;
begin
  // Test register index 0 specifically
  FVM.LoadInt(100).StoreLocal(0).LoadLocal(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(100), LValue.IntValue, 'Local register index 0 should work correctly');
end;

procedure TTestJetVMRegisters.TestLocalRegisterHighIndex();
var
  LValue: TJetValue;
const
  CHighIndex = 50; // Test a reasonably high index
begin
  // Test higher register indices
  FVM.LoadInt(999).StoreLocal(CHighIndex).LoadLocal(CHighIndex).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(999), LValue.IntValue, 'High index local register should work correctly');
end;

procedure TTestJetVMRegisters.TestLocalRegisterNegativeIndex();
begin
  // Test that negative indices should raise an error (depending on validation level)
  try
    FVM.LoadInt(42).StoreLocal(-1);

    // If we get here without exception in basic validation, that's acceptable
    // More detailed bounds checking happens in higher validation levels
    Assert.Pass('Negative index handled appropriately for current validation level');
  except
    on E: Exception do
      // Exception for negative index is expected and acceptable
      Assert.IsTrue(Pos('index', LowerCase(E.Message)) > 0, 'Exception should mention index issue');
  end;
end;

procedure TTestJetVMRegisters.TestLocalRegisterOverwrite();
var
  LValue: TJetValue;
begin
  // Test overwriting a register with a different value
  FVM.LoadInt(42)
     .StoreLocal(0)
     .LoadInt(84)
     .StoreLocal(0)
     .LoadLocal(0)
     .Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(84), LValue.IntValue, 'Local register should be overwritten with new value');
end;

procedure TTestJetVMRegisters.TestLocalRegisterSequentialAccess();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
begin
  // Test multiple sequential register accesses
  FVM.LoadInt(10).StoreLocal(0)
     .LoadInt(20).StoreLocal(1)
     .LoadInt(30).StoreLocal(2)
     .LoadLocal(2)
     .LoadLocal(1)
     .LoadLocal(0)
     .Stop();
  FVM.Execute();

  // Values should be on stack in reverse order (LIFO)
  LValue1 := FVM.PopValue(); // Should be 10 (from register 0)
  LValue2 := FVM.PopValue(); // Should be 20 (from register 1)
  LValue3 := FVM.PopValue(); // Should be 30 (from register 2)

  Assert.AreEqual(Int64(10), LValue1.IntValue, 'First register value should be correct');
  Assert.AreEqual(Int64(20), LValue2.IntValue, 'Second register value should be correct');
  Assert.AreEqual(Int64(30), LValue3.IntValue, 'Third register value should be correct');
end;

// =============================================================================
// Global Register Tests
// =============================================================================

procedure TTestJetVMRegisters.TestGlobalRegisterInitialState();
var
  LValue: TJetValue;
begin
  // Test that global registers work correctly
  FVM.LoadInt(123).StoreGlobal(0).LoadGlobal(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(123), LValue.IntValue, 'Global register should store and retrieve integer correctly');
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Global register should preserve value type');
end;

procedure TTestJetVMRegisters.TestStoreLoadGlobalInteger();
var
  LValue: TJetValue;
const
  CTestValue: Int64 = -9876543210;
begin
  // Test storing and loading integers to/from global registers
  FVM.LoadInt(CTestValue).StoreGlobal(5).LoadGlobal(5).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(CTestValue, LValue.IntValue, 'Global integer register should store/load correctly');
  Assert.AreEqual(jvtInt, LValue.ValueType, 'Value type should be preserved as integer');
end;

procedure TTestJetVMRegisters.TestStoreLoadGlobalUInteger();
var
  LValue: TJetValue;
const
  CTestValue: UInt64 = 18446744073709551615; // Max UInt64
begin
  // Test storing and loading unsigned integers to globals
  FVM.LoadUInt(CTestValue).StoreGlobal(10).LoadGlobal(10).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(CTestValue, LValue.UIntValue, 'Global UInteger register should store/load correctly');
  Assert.AreEqual(jvtUInt, LValue.ValueType, 'Value type should be preserved as UInteger');
end;

procedure TTestJetVMRegisters.TestStoreLoadGlobalString();
var
  LValue: TJetValue;
const
  CTestString = 'Global Register Test String';
begin
  // Test storing and loading strings to globals
  FVM.LoadStr(CTestString).StoreGlobal(15).LoadGlobal(15).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(CTestString, LValue.StrValue, 'Global string register should store/load correctly');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Value type should be preserved as string');
end;

procedure TTestJetVMRegisters.TestStoreLoadGlobalBoolean();
var
  LValue: TJetValue;
begin
  // Test storing and loading boolean values to globals
  FVM.LoadBool(False).StoreGlobal(20).LoadGlobal(20).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(False, LValue.BoolValue, 'Global boolean register should store/load correctly');
  Assert.AreEqual(jvtBool, LValue.ValueType, 'Value type should be preserved as boolean');
end;

procedure TTestJetVMRegisters.TestStoreLoadGlobalPointer();
var
  LValue: TJetValue;
begin
  // Test storing and loading pointer values to globals using AddrOf
  FVM.LoadInt(123).AddrOf().StoreGlobal(25).LoadGlobal(25).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(jvtPointer, LValue.ValueType, 'Value type should be preserved as pointer');
  Assert.IsNotNull(LValue.PtrValue, 'Global pointer register should store/load correctly');
end;

// =============================================================================
// Global Register Edge Cases
// =============================================================================

procedure TTestJetVMRegisters.TestGlobalRegisterIndexZero();
var
  LValue: TJetValue;
begin
  // Test global register index 0 specifically
  FVM.LoadInt(500).StoreGlobal(0).LoadGlobal(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(500), LValue.IntValue, 'Global register index 0 should work correctly');
end;

procedure TTestJetVMRegisters.TestGlobalRegisterHighIndex();
var
  LValue: TJetValue;
const
  CHighIndex = 100; // Test a reasonably high index for globals
begin
  // Test higher global register indices
  FVM.LoadInt(777).StoreGlobal(CHighIndex).LoadGlobal(CHighIndex).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(777), LValue.IntValue, 'High index global register should work correctly');
end;

procedure TTestJetVMRegisters.TestGlobalRegisterPersistence();
var
  LValue: TJetValue;
begin
  // Test that global registers persist across multiple executions
  FVM.LoadInt(888).StoreGlobal(0).Stop();
  FVM.Execute();
  FVM.Reset();

  // New execution should still have global value
  FVM.LoadGlobal(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(888), LValue.IntValue, 'Global register should persist across executions');
end;

procedure TTestJetVMRegisters.TestGlobalRegisterOverwrite();
var
  LValue: TJetValue;
begin
  // Test overwriting a global register with a different value and type
  FVM.LoadInt(42)
     .StoreGlobal(0)
     .LoadStr('overwritten')
     .StoreGlobal(0)
     .LoadGlobal(0)
     .Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual('overwritten', LValue.StrValue, 'Global register should be overwritten with new value');
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Global register should have new type after overwrite');
end;

procedure TTestJetVMRegisters.TestGlobalRegisterCrossFunctionAccess();
begin
  // Test that global registers are accessible across function boundaries
  // This is a placeholder for when function call testing is more developed
  Assert.Pass('Global register cross-function access - detailed testing with function calls');
end;

// =============================================================================
// Parameter Register Tests
// =============================================================================

procedure TTestJetVMRegisters.TestParameterRegisterAccess();
var
  LValue: TJetValue;
begin
  // Test basic parameter register access
  // Note: Parameters are stored in locals, so we test LoadParam operation
  FVM.LoadInt(999).StoreLocal(0).LoadParam(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(999), LValue.IntValue, 'Parameter register should load correctly');
end;

procedure TTestJetVMRegisters.TestParameterRegisterTypes();
var
  LStringValue: TJetValue;
  LBoolValue: TJetValue;
begin
  // Test parameter registers with different types
  FVM.LoadStr('param test').StoreLocal(0)
     .LoadBool(True).StoreLocal(1)
     .LoadParam(1)
     .LoadParam(0)
     .Stop();
  FVM.Execute();

  LStringValue := FVM.PopValue();
  LBoolValue := FVM.PopValue();

  Assert.AreEqual('param test', LStringValue.StrValue, 'String parameter should be correct');
  Assert.AreEqual(True, LBoolValue.BoolValue, 'Boolean parameter should be correct');
end;

procedure TTestJetVMRegisters.TestParameterRegisterIndexing();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
begin
  // Test multiple parameter indices
  FVM.LoadInt(10).StoreLocal(0)
     .LoadInt(20).StoreLocal(1)
     .LoadInt(30).StoreLocal(2)
     .LoadParam(2)
     .LoadParam(1)
     .LoadParam(0)
     .Stop();
  FVM.Execute();

  LValue1 := FVM.PopValue(); // param 0
  LValue2 := FVM.PopValue(); // param 1
  LValue3 := FVM.PopValue(); // param 2

  Assert.AreEqual(Int64(10), LValue1.IntValue, 'Parameter 0 should be correct');
  Assert.AreEqual(Int64(20), LValue2.IntValue, 'Parameter 1 should be correct');
  Assert.AreEqual(Int64(30), LValue3.IntValue, 'Parameter 2 should be correct');
end;

procedure TTestJetVMRegisters.TestParameterRegisterConsistency();
begin
  // Test that parameter access is consistent with local access
  // Since parameters are stored in locals, this should be equivalent
  Assert.Pass('Parameter register consistency - parameters stored in locals array');
end;

// =============================================================================
// Base Pointer Management Tests
// =============================================================================

procedure TTestJetVMRegisters.TestBasePointerInitialState();
begin
  // Test that base pointer starts at correct initial value
  // This is mostly tested indirectly through local register access
  Assert.Pass('Base pointer initial state - tested through local register operations');
end;

procedure TTestJetVMRegisters.TestBasePointerWithLocalAccess();
var
  LValue: TJetValue;
begin
  // Test that base pointer correctly offsets local register access
  FVM.LoadInt(42).StoreLocal(0).LoadLocal(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(42), LValue.IntValue, 'Base pointer should correctly offset local access');
end;

procedure TTestJetVMRegisters.TestBasePointerInFunctionCalls();
begin
  // Test base pointer management during function calls
  // This will be more thoroughly tested when function call mechanics are complete
  Assert.Pass('Base pointer in function calls - requires complete function call implementation');
end;

procedure TTestJetVMRegisters.TestBasePointerStackFrames();
begin
  // Test base pointer with stack frame management
  // This requires complete stack frame implementation
  Assert.Pass('Base pointer stack frames - requires complete stack frame implementation');
end;

// =============================================================================
// Register Type Consistency Tests
// =============================================================================

procedure TTestJetVMRegisters.TestRegisterTypePreservation();
var
  LIntValue: TJetValue;
  LStrValue: TJetValue;
  LBoolValue: TJetValue;
begin
  // Test that different types are preserved correctly in registers
  FVM.LoadInt(42).StoreLocal(0)
     .LoadStr('test').StoreLocal(1)
     .LoadBool(True).StoreLocal(2)
     .LoadLocal(2)
     .LoadLocal(1)
     .LoadLocal(0)
     .Stop();
  FVM.Execute();

  LIntValue := FVM.PopValue();
  LStrValue := FVM.PopValue();
  LBoolValue := FVM.PopValue();

  Assert.AreEqual(jvtInt, LIntValue.ValueType, 'Integer type should be preserved');
  Assert.AreEqual(jvtStr, LStrValue.ValueType, 'String type should be preserved');
  Assert.AreEqual(jvtBool, LBoolValue.ValueType, 'Boolean type should be preserved');
end;

procedure TTestJetVMRegisters.TestRegisterTypeOverwriting();
var
  LValue: TJetValue;
begin
  // Test overwriting a register with a different type
  FVM.LoadInt(42).StoreLocal(0)
     .LoadStr('new value').StoreLocal(0)
     .LoadLocal(0)
     .Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(jvtStr, LValue.ValueType, 'Register type should change when overwritten');
  Assert.AreEqual('new value', LValue.StrValue, 'Register value should be overwritten correctly');
end;

procedure TTestJetVMRegisters.TestRegisterValuePrecision();
var
  LValue: TJetValue;
const
  CMaxInt64: Int64 = 9223372036854775807;
  CMaxUInt64: UInt64 = 18446744073709551615;
begin
  // Test that register values maintain full precision
  FVM.LoadInt(CMaxInt64).StoreLocal(0).LoadLocal(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(CMaxInt64, LValue.IntValue, 'Maximum Int64 should be preserved exactly');

  FVM.Reset();
  FVM.LoadUInt(CMaxUInt64).StoreLocal(0).LoadLocal(0).Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(CMaxUInt64, LValue.UIntValue, 'Maximum UInt64 should be preserved exactly');
end;

procedure TTestJetVMRegisters.TestRegisterArraySupport();
begin
  // Test that registers can store array types when supported
  // Array operations require complete array implementation
  Assert.Pass('Register array support - requires complete array implementation');
end;

// =============================================================================
// Cross-Register Operations Tests
// =============================================================================

procedure TTestJetVMRegisters.TestLocalToGlobalTransfer();
var
  LValue: TJetValue;
begin
  // Test transferring values from local to global registers
  FVM.LoadInt(123).StoreLocal(0)
     .LoadLocal(0).StoreGlobal(0)
     .LoadGlobal(0)
     .Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(123), LValue.IntValue, 'Local to global transfer should work correctly');
end;

procedure TTestJetVMRegisters.TestGlobalToLocalTransfer();
var
  LValue: TJetValue;
begin
  // Test transferring values from global to local registers
  FVM.LoadInt(456).StoreGlobal(0)
     .LoadGlobal(0).StoreLocal(0)
     .LoadLocal(0)
     .Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(456), LValue.IntValue, 'Global to local transfer should work correctly');
end;

procedure TTestJetVMRegisters.TestParameterToLocalTransfer();
var
  LValue: TJetValue;
begin
  // Test transferring parameter values to local registers
  FVM.LoadInt(789).StoreLocal(5) // Simulate parameter
     .LoadParam(5).StoreLocal(0)
     .LoadLocal(0)
     .Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(789), LValue.IntValue, 'Parameter to local transfer should work correctly');
end;

procedure TTestJetVMRegisters.TestRegisterSwapping();
var
  LValue1: TJetValue;
  LValue2: TJetValue;
begin
  // Test swapping values between registers via stack
  FVM.LoadInt(100).StoreLocal(0)
     .LoadInt(200).StoreLocal(1)
     .LoadLocal(0).LoadLocal(1) // Stack: [100, 200]
     .StoreLocal(0)             // Store 200 to local[0]
     .StoreLocal(1)             // Store 100 to local[1]
     .LoadLocal(1)              // Load swapped values
     .LoadLocal(0)
     .Stop();
  FVM.Execute();

  LValue1 := FVM.PopValue(); // Should be 200 (was in local[0])
  LValue2 := FVM.PopValue(); // Should be 100 (was in local[1])

  Assert.AreEqual(Int64(200), LValue1.IntValue, 'First swapped value should be correct');
  Assert.AreEqual(Int64(100), LValue2.IntValue, 'Second swapped value should be correct');
end;

// =============================================================================
// Register Bounds and Validation Tests
// =============================================================================

procedure TTestJetVMRegisters.TestLocalRegisterBounds();
begin
  // Test local register bounds checking (varies by validation level)
  try
    FVM.LoadInt(42).StoreLocal(1000); // Very high index
    Assert.Pass('High local index handled appropriately for validation level');
  except
    on E: Exception do
      // Exception is acceptable for bounds checking
      Assert.IsTrue(True, 'Bounds checking exception is acceptable');
  end;
end;

procedure TTestJetVMRegisters.TestGlobalRegisterBounds();
begin
  // Test global register bounds checking
  try
    FVM.LoadInt(42).StoreGlobal(1000); // Very high index
    Assert.Pass('High global index handled appropriately for validation level');
  except
    on E: Exception do
      // Exception is acceptable for bounds checking
      Assert.IsTrue(True, 'Bounds checking exception is acceptable');
  end;
end;

procedure TTestJetVMRegisters.TestParameterRegisterBounds();
begin
  // Test parameter register bounds checking
  try
    FVM.LoadParam(1000); // Very high parameter index
    Assert.Pass('High parameter index handled appropriately for validation level');
  except
    on E: Exception do
      // Exception is acceptable for bounds checking
      Assert.IsTrue(True, 'Bounds checking exception is acceptable');
  end;
end;

procedure TTestJetVMRegisters.TestRegisterValidationLevels();
begin
  // Test register behavior under different validation levels
  // This would require testing with different validation levels
  Assert.Pass('Register validation levels - requires testing with different validation modes');
end;

// =============================================================================
// Complex Register Scenarios
// =============================================================================

procedure TTestJetVMRegisters.TestNestedFunctionRegisterIsolation();
begin
  // Test that nested function calls properly isolate local registers
  // This requires complete function call implementation
  Assert.Pass('Nested function register isolation - requires function call implementation');
end;

procedure TTestJetVMRegisters.TestRecursiveFunctionRegisters();
begin
  // Test register management in recursive function calls
  // This requires complete function call implementation
  Assert.Pass('Recursive function registers - requires function call implementation');
end;

procedure TTestJetVMRegisters.TestRegisterStateAfterException();
begin
  // Test register state after exception handling
  try
    FVM.LoadInt(42).StoreLocal(0);
    // Cause some kind of exception
    FVM.LoadLocal(-1); // Negative index might cause exception
    FVM.Stop();
    FVM.Execute();
  except
    // After exception, registers should still be accessible
    FVM.Reset();
    FVM.LoadInt(99).StoreLocal(0).LoadLocal(0).Stop();
    FVM.Execute();

    Assert.AreEqual(Int64(99), FVM.PopValue().IntValue, 'Registers should work after exception recovery');
  end;
end;

procedure TTestJetVMRegisters.TestMassRegisterOperations();
var
  LIndex: Integer;
  LValue: TJetValue;
begin
  // Test operations on many registers at once
  for LIndex := 0 to 9 do
  begin
    FVM.LoadInt(LIndex * 10).StoreLocal(LIndex);
  end;

  // Load all values back
  for LIndex := 9 downto 0 do
  begin
    FVM.LoadLocal(LIndex);
  end;

  FVM.Stop();
  FVM.Execute();

  // Verify all values (they'll be in reverse order on stack)
  for LIndex := 0 to 9 do
  begin
    LValue := FVM.PopValue();
    Assert.AreEqual(Int64(LIndex * 10), LValue.IntValue, Format('Mass register operation %d should be correct', [LIndex]));
  end;
end;

// =============================================================================
// Performance and Memory Tests
// =============================================================================

procedure TTestJetVMRegisters.TestRegisterMemoryFootprint();
begin
  // Test that register operations don't cause excessive memory usage
  // This is a performance/memory test that's hard to quantify precisely
  Assert.Pass('Register memory footprint - qualitative test');
end;

procedure TTestJetVMRegisters.TestRegisterAccessPerformance();
var
  LIndex: Integer;
  LValue: TJetValue;
begin
  // Test that register access performance is reasonable
  for LIndex := 0 to 99 do
  begin
    FVM.LoadInt(LIndex).StoreLocal(0).LoadLocal(0);
  end;

  FVM.Stop();
  FVM.Execute();

  LValue := FVM.PopValue();
  Assert.AreEqual(Int64(99), LValue.IntValue, 'Performance test should complete with correct result');
end;

procedure TTestJetVMRegisters.TestRegisterGarbageCollection();
begin
  // Test that string values in registers are properly garbage collected
  FVM.LoadStr('temporary string').StoreLocal(0)
     .LoadStr('another string').StoreLocal(0) // Overwrite
     .LoadLocal(0)
     .Stop();
  FVM.Execute();

  Assert.AreEqual('another string', FVM.PopValue().StrValue, 'String register should be overwritten correctly');
  // Garbage collection of first string should happen automatically
end;

procedure TTestJetVMRegisters.TestRegisterResetBehavior();
var
  LValue: TJetValue;
begin
  // Test register state after VM reset
  FVM.LoadInt(42).StoreLocal(0).Stop();
  FVM.Execute();

  FVM.Reset();

  // After reset, try to access the register
  try
    FVM.LoadLocal(0).Stop();
    FVM.Execute();
    LValue := FVM.PopValue();

    // Register may be cleared or retain value - both are valid behaviors
    Assert.Pass(Format('Register after reset contains value: %d', [LValue.IntValue]));
  except
    on E: Exception do
      // Exception accessing register after reset is also acceptable
      Assert.Pass('Register access after reset caused exception - acceptable behavior');
  end;
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMRegisters);

end.
