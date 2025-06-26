# JetVM Developer Guide

```
      _     _ __   ____  __ ™
   _ | |___| |\ \ / /  \/  |
  | || / -_)  _\ V /| |\/| |
   \__/\___|\__|\_/ |_|  |_|
        Fast Delphi VM
```

**JetVM - High-Performance Virtual Machine for Delphi**  
*Copyright © 2025-present tinyBigGAMES™ LLC*   
All Rights Reserved.

---

## 📋 Table of Contents

1. [Project Overview & Architecture](#1-project-overview--architecture)
2. [Core Value System (TJetValue)](#2-core-value-system-tjetvalue)
3. [Validation Levels & Performance](#3-validation-levels--performance)
4. [Fluent Interface & Bytecode Generation](#4-fluent-interface--bytecode-generation)
5. [Execution Model & Stack Management](#5-execution-model--stack-management)
6. [Function System & Parameter Modes](#6-function-system--parameter-modes)
7. [Memory Management & Bounds Checking](#7-memory-management--bounds-checking)
8. [Practical Usage Examples](#8-practical-usage-examples)
9. [Performance Optimization Guide](#9-performance-optimization-guide)
10. [Best Practices & Common Patterns](#10-best-practices--common-patterns)
11. [Error Handling & Debugging](#11-error-handling--debugging)
12. [Integration Patterns](#12-integration-patterns)

---

## 1. Project Overview & Architecture

JetVM is a high-performance, stack-based virtual machine designed for embedding scripting capabilities into Delphi applications.

### 🚀 Core Features

- **Stack-based execution** with 256 registers
- **Tagged union value system** (TJetValue) for type safety
- **Fluent bytecode generation** interface
- **Pascal-style parameter modes** (const, var, out)
- **Multiple validation levels** (performance vs safety)
- **Comprehensive opcode set** for real-world programming
- **Native Delphi function integration**
- **Memory management** with optional bounds checking

### 🏗️ Architecture Overview

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│  Fluent API     │───▶│  Bytecode Gen   │───▶│  Execution      │
│  (Build Phase)  │    │  (Compile Phase)│    │  (Runtime Phase)│
└─────────────────┘    └─────────────────┘    └─────────────────┘
        │                       │                       │
        ▼                       ▼                       ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ TJetValue       │    │ Constants Pool  │    │ Stack Machine   │
│ Type System     │    │ Label Patching  │    │ Function Calls  │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### 💡 Basic Usage Example

```pascal
procedure TMyApp.RunSimpleCalculation();
var
  LVM: TJetVM;
  LResult: TJetValue;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Build and execute: (10 + 20) * 3
    LVM.LoadInt(10)
       .LoadInt(20)
       .AddInt()
       .LoadInt(3)
       .MulInt()
       .Stop()
       .Execute();
       
    // Get result from stack
    LResult := LVM.PopValue();
    ShowMessage('Result: ' + IntToStr(LResult.IntValue)); // Shows: "90"
  finally
    LVM.Free();
  end;
end;
```

---

## 2. Core Value System (TJetValue)

JetVM uses a tagged union system (TJetValue) for maximum performance while maintaining type safety. All values in the VM are represented as TJetValue.

### 🏷️ Supported Value Types

```pascal
TJetValueType = (
  jvtInt,       // Int64     - 64-bit signed integers
  jvtUInt,      // UInt64    - 64-bit unsigned integers  
  jvtStr,       // string    - Native Delphi strings (managed)
  jvtBool,      // Boolean   - True/False values
  jvtPStr,      // PString   - Pointer to string
  jvtPBool,     // PBoolean  - Pointer to boolean
  jvtArrayInt,  // array of Int64    - Dynamic integer arrays
  jvtArrayUInt, // array of UInt64   - Dynamic unsigned arrays
  jvtArrayStr,  // array of string   - Dynamic string arrays  
  jvtArrayBool, // array of Boolean  - Dynamic boolean arrays
  jvtPointer    // Pointer   - Generic untyped pointer
);
```

### 💾 Memory Layout

- **Managed types** (strings, arrays) are stored outside variant record
- **Unmanaged types** (integers, booleans, pointers) use variant record
- **Automatic memory management** for strings and dynamic arrays
- **Zero-copy pointer operations** where possible

### 🛠️ Value Creation Examples

```pascal
procedure TMyApp.DemonstrateValueCreation();
var
  LVM: TJetVM;
  LIntValue: TJetValue;
  LStrValue: TJetValue;
  LArrayValue: TJetValue;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Create different value types
    LIntValue := LVM.MakeIntConstant(42);
    LStrValue := LVM.MakeStrConstant('Hello, JetVM!');
    
    // Create array manually
    LArrayValue.ValueType := jvtArrayInt;
    SetLength(LArrayValue.ArrayIntValue, 3);
    LArrayValue.ArrayIntValue[0] := 10;
    LArrayValue.ArrayIntValue[1] := 20;
    LArrayValue.ArrayIntValue[2] := 30;
    
    // Add to constants pool
    LVM.AddConstant(LIntValue);
    LVM.AddConstant(LStrValue);
    LVM.AddConstant(LArrayValue);
    
    // Use in program
    LVM.LoadConst(0)  // Load integer constant
       .LoadConst(1)  // Load string constant
       .Stop();
  finally
    LVM.Free();
  end;
end;
```

### 🔍 Value Access Patterns

```pascal
procedure TMyApp.WorkWithValues();
var
  LValue: TJetValue;
begin
  // Always check ValueType before accessing specific fields
  LValue := FVM.PopValue();
  
  case LValue.ValueType of
    jvtInt:     WriteLn('Integer: ', LValue.IntValue);
    jvtUInt:    WriteLn('UInteger: ', LValue.UIntValue);  
    jvtStr:     WriteLn('String: ', LValue.StrValue);
    jvtBool:    WriteLn('Boolean: ', LValue.BoolValue);
    jvtPointer: WriteLn('Pointer: ', IntPtr(LValue.PtrValue));
    jvtArrayInt: 
    begin
      WriteLn('Array length: ', Length(LValue.ArrayIntValue));
      if Length(LValue.ArrayIntValue) > 0 then
        WriteLn('First element: ', LValue.ArrayIntValue[0]);
    end;
  end;
end;
```

---

## 3. Validation Levels & Performance

JetVM offers four validation levels to balance performance with safety:

### 🚀 Validation Level Breakdown

```pascal
TJetVMValidationLevel = (
  vlNone,        // 🔥 MAXIMUM SPEED - No runtime checks
  vlBasic,       // ⚡ RECOMMENDED - Emit-time validation only  
  vlDevelopment, // 🔧 DEBUG MODE - Stack tracking + type hints
  vlSafe         // 🛡️ SAFE MODE - Full runtime type/bounds checking
);
```

### 🏁 Performance Comparison

```pascal
procedure TMyApp.BenchmarkValidationLevels();
var
  LVM: TJetVM;
  LStopwatch: TStopwatch;
  LI: Integer;
begin
  // vlNone - Maximum performance
  LVM := TJetVM.Create(vlNone);
  try
    LStopwatch := TStopwatch.StartNew();
    for LI := 1 to 1000000 do
    begin
      LVM.Reset();
      LVM.LoadInt(LI).LoadInt(LI).AddInt().Stop().Execute();
    end;
    LStopwatch.Stop();
    WriteLn('vlNone: ', LStopwatch.ElapsedMilliseconds, 'ms');
  finally
    LVM.Free();
  end;
  
  // vlBasic - Recommended balance
  LVM := TJetVM.Create(vlBasic);
  try
    LStopwatch := TStopwatch.StartNew();
    for LI := 1 to 1000000 do
    begin
      LVM.Reset();
      LVM.LoadInt(LI).LoadInt(LI).AddInt().Stop().Execute();
    end;
    LStopwatch.Stop();
    WriteLn('vlBasic: ', LStopwatch.ElapsedMilliseconds, 'ms');
  finally
    LVM.Free();
  end;
end;
```

### 🎛️ Choosing the Right Level

```pascal
// Production high-performance code
LVM := TJetVM.Create(vlNone);

// General purpose applications (RECOMMENDED)
LVM := TJetVM.Create(vlBasic);

// During development and testing
LVM := TJetVM.Create(vlDevelopment);

// When processing untrusted code
LVM := TJetVM.Create(vlSafe);
```

### 🔧 Runtime Level Switching

```pascal
procedure TMyApp.DynamicValidationControl();
var
  LVM: TJetVM;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Start with basic validation
    LVM.LoadInt(42).Stop().Execute();
    
    // Switch to safe mode for untrusted operations
    LVM.SetValidationLevel(vlSafe);
    LVM.Reset();
    // ... process untrusted code ...
    
    // Switch back to high performance
    LVM.SetValidationLevel(vlNone);
    LVM.Reset();
    // ... performance-critical operations ...
  finally
    LVM.Free();
  end;
end;
```

---

## 4. Fluent Interface & Bytecode Generation

JetVM features a powerful fluent interface for building programs. All operations return the VM instance, enabling method chaining.

### ⛓️ Fluent Interface Principles

- Every operation returns TJetVM instance
- Methods can be chained infinitely  
- Bytecode is generated during method calls
- Must call Execute() to run the program
- Must call Stop() to properly terminate programs

### 🧮 Arithmetic Operations

```pascal
procedure TMyApp.ArithmeticExamples();
var
  LVM: TJetVM;
  LResult: TJetValue;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Integer arithmetic: (10 + 5) * 3 - 2
    LVM.LoadInt(10)
       .LoadInt(5)
       .AddInt()        // Stack: [15]
       .LoadInt(3)
       .MulInt()        // Stack: [45]
       .LoadInt(2)  
       .SubInt()        // Stack: [43]
       .Stop()
       .Execute();
       
    LResult := LVM.PopValue();
    Assert(LResult.IntValue = 43);
    
    // Unsigned arithmetic with boundary values
    LVM.Reset();
    LVM.LoadUInt(High(UInt64))
       .LoadUInt(1)
       .AddUInt()       // Overflow behavior
       .Stop()
       .Execute();
       
    // String operations
    LVM.Reset();
    LVM.LoadStr('Hello, ')
       .LoadStr('World!')
       .ConcatStr()     // Stack: ['Hello, World!']
       .Stop()
       .Execute();
       
    LResult := LVM.PopValue();
    Assert(LResult.StrValue = 'Hello, World!');
  finally
    LVM.Free();
  end;
end;
```

### 🔀 Control Flow with Labels

```pascal
procedure TMyApp.ControlFlowExample();
var
  LVM: TJetVM;
  LLoopLabel: Integer;
  LEndLabel: Integer;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    LLoopLabel := LVM.CreateLabel();
    LEndLabel := LVM.CreateLabel();
    
    // Simple loop: sum numbers 1 to 10
    LVM.LoadInt(0)           // Accumulator
       .LoadInt(1)           // Counter
       .BindLabel(LLoopLabel)
       .Dup()                // Duplicate counter for comparison
       .LoadInt(10)
       .GtInt()              // Counter > 10?
       .JumpTrue(LEndLabel)  // Exit if true
       .Dup()                // Duplicate counter
       .Rot()                // Bring accumulator to top
       .AddInt()             // Add counter to accumulator
       .Swap()               // Put counter back on top
       .LoadInt(1)
       .AddInt()             // Increment counter
       .Jump(LLoopLabel)     // Loop back
       .BindLabel(LEndLabel)
       .Pop()                // Remove counter, leave sum
       .Stop()
       .Execute();
       
    // Result should be 55 (sum of 1+2+...+10)
    var LResult := LVM.PopValue();
    Assert(LResult.IntValue = 55);
  finally
    LVM.Free();
  end;
end;
```

### 🧩 Complex Fluent Chains

```pascal
procedure TMyApp.ComplexFluentExample();
var
  LVM: TJetVM;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Complex expression with multiple types
    LVM.LoadStr('Result: ')
       .LoadInt(42)
       .LoadInt(8)
       .MulInt()                // 42 * 8 = 336
       .IntToStr()              // Convert to string
       .ConcatStr()             // Concatenate with prefix
       .LoadStr(' is the answer')
       .ConcatStr()             // Final concatenation
       .Stop()
       .Execute();
       
    var LResult := LVM.PopValue();
    Assert(LResult.StrValue = 'Result: 336 is the answer');
  finally
    LVM.Free();
  end;
end;
```

---

## 5. Execution Model & Stack Management

JetVM uses a stack-based execution model with automatic memory management and comprehensive state tracking.

### 📚 Stack Operations

```pascal
procedure TMyApp.StackManipulationDemo();
var
  LVM: TJetVM;
  LValue1, LValue2, LValue3: TJetValue;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Basic stack operations
    LVM.LoadInt(10)
       .LoadInt(20)
       .LoadInt(30)     // Stack: [10, 20, 30] (30 on top)
       .Stop()
       .Execute();
       
    // Access stack values
    LValue3 := LVM.PopValue();  // Gets 30, stack: [10, 20]
    LValue2 := LVM.PopValue();  // Gets 20, stack: [10]
    LValue1 := LVM.PopValue();  // Gets 10, stack: []
    
    Assert(LValue1.IntValue = 10);
    Assert(LValue2.IntValue = 20);
    Assert(LValue3.IntValue = 30);
    
    // Advanced stack manipulation
    LVM.Reset();
    LVM.LoadInt(1)
       .LoadInt(2)
       .LoadInt(3)      // Stack: [1, 2, 3]
       .Dup()           // Stack: [1, 2, 3, 3]
       .Swap()          // Stack: [1, 2, 3, 3]  
       .Rot()           // Stack: [1, 3, 3, 2]
       .Stop()
       .Execute();
  finally
    LVM.Free();
  end;
end;
```

### 🎯 Execution States & Control

```pascal
procedure TMyApp.ExecutionControlDemo();
var
  LVM: TJetVM;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Check initial state
    Assert(LVM.GetPC() = 0, 'PC should start at 0');
    Assert(LVM.GetSP() = 0, 'SP should start at 0');
    Assert(not LVM.IsRunning(), 'Should not be running initially');
    
    // Build program
    LVM.LoadInt(42).Nop().Nop().Stop();
    
    // State before execution
    Assert(LVM.GetPC() = 0, 'PC unchanged before execution');
    
    // Execute program
    LVM.Execute();
    
    // State after execution
    Assert(not LVM.IsRunning(), 'Should not be running after halt');
    Assert(LVM.GetSP() > 0, 'SP should have advanced');
    Assert(LVM.GetPC() > 0, 'PC should have advanced');
    
    // Step-by-step execution
    LVM.Reset();
    LVM.LoadInt(100).LoadInt(200).Stop();
    
    LVM.Step();  // Execute first LoadInt
    Assert(LVM.GetSP() = 1, 'SP should be 1 after first instruction');
    
    LVM.Step();  // Execute second LoadInt  
    Assert(LVM.GetSP() = 2, 'SP should be 2 after second instruction');
    
    LVM.Step();  // Execute Stop
    Assert(not LVM.IsRunning(), 'Should stop after halt');
  finally
    LVM.Free();
  end;
end;
```

### 💾 Memory and State Management

```pascal
procedure TMyApp.StateManagementDemo();
var
  LVM: TJetVM;
  LBytecodeSize1, LBytecodeSize2: UInt64;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Build and finalize program
    LVM.LoadInt(42).LoadStr('test').Stop();
    LBytecodeSize1 := LVM.BytecodeSize();
    
    LVM.Finalize();  // Finalize bytecode
    LBytecodeSize2 := LVM.BytecodeSize();
    
    // Execute finalized program
    LVM.Execute();
    
    // Reset clears execution state but preserves bytecode structure
    LVM.Reset();
    Assert(LVM.GetPC() = 0, 'Reset should clear PC');
    Assert(LVM.GetSP() = 0, 'Reset should clear SP');
    
    // Can execute again after reset
    LVM.LoadInt(100).Stop().Execute();
  finally
    LVM.Free();
  end;
end;
```

---

## 6. Function System & Parameter Modes

JetVM supports both native Delphi functions and VM-based functions with Pascal-style parameter modes (const, var, out).

### 🔧 Native Function Registration

```pascal
// Native function implementation
procedure MyNativePrint(const AVM: TJetVM);
var
  LMessage: TJetValue;
begin
  LMessage := AVM.PopValue();  // Get parameter from stack
  WriteLn(LMessage.StrValue);  // Print to console
end;

procedure MyNativeAdd(const AVM: TJetVM);
var
  LB, LA: TJetValue;
  LResult: TJetValue;
begin
  LB := AVM.PopValue();  // Second parameter
  LA := AVM.PopValue();  // First parameter
  
  LResult := AVM.MakeIntConstant(LA.IntValue + LB.IntValue);
  AVM.PushValue(LResult);  // Push result onto stack
end;

procedure TMyApp.RegisterNativeFunctions();
var
  LVM: TJetVM;
  LPrintFunc, LAddFunc: Integer;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Register void function (no return value)
    LPrintFunc := LVM.RegisterNativeFunction(
      'print', 
      @MyNativePrint,
      [jvtStr]  // One string parameter
    );
    
    // Register function with return value
    LAddFunc := LVM.RegisterNativeFunction(
      'add',
      @MyNativeAdd, 
      [jvtInt, jvtInt],  // Two integer parameters
      jvtInt             // Integer return value
    );
    
    // Use native functions in VM code
    LVM.LoadStr('Hello from native function!')
       .CallFunction('print')    // Calls MyNativePrint
       .LoadInt(10)
       .LoadInt(20) 
       .CallFunction('add')      // Calls MyNativeAdd
       .Stop()
       .Execute();
       
    // Result of add (30) is now on stack
    var LResult := LVM.PopValue();
    Assert(LResult.IntValue = 30);
  finally
    LVM.Free();
  end;
end;
```

### 📞 VM Function Declaration & Calling

```pascal
procedure TMyApp.VMFunctionDemo();
var
  LVM: TJetVM;
  LFuncIndex: Integer;
  LMainLabel, LFuncLabel: Integer;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    LMainLabel := LVM.CreateLabel();
    LFuncLabel := LVM.CreateLabel();
    
    // Declare VM function: multiply(a: Int64, b: Int64): Int64
    LFuncIndex := LVM.DeclareVMFunction(
      'multiply',
      LFuncLabel,        // Will be bound later
      [jvtInt, jvtInt],  // Parameters
      jvtInt             // Return type
    );
    
    // Jump over function definition to main code
    LVM.Jump(LMainLabel);
    
    // Function definition
    LVM.BindLabel(LFuncLabel)
       .BeginFunction()
       .LoadParam(0)      // Load first parameter
       .LoadParam(1)      // Load second parameter
       .MulInt()          // Multiply them
       .ReturnValue()     // Return result
       .EndFunction();
       
    // Main program
    LVM.BindLabel(LMainLabel)
       .LoadInt(6)
       .LoadInt(7)
       .CallFunctionByIndex(LFuncIndex)  // Call multiply(6, 7)
       .Stop()
       .Execute();
       
    // Result should be 42
    var LResult := LVM.PopValue();
    Assert(LResult.IntValue = 42);
  finally
    LVM.Free();
  end;
end;
```

### 🎛️ Parameter Modes (const, var, out)

```pascal
// Native function demonstrating parameter modes
procedure MyParamModeDemo(const AVM: TJetVM);
var
  LConstParam: TJetValue;    // const parameter (read-only)
  LVarParam: TJetValue;      // var parameter (read-write)
  LOutParam: TJetValue;      // out parameter (write-only)
begin
  // Parameters are popped in reverse order
  LOutParam := AVM.PopValue();  // out parameter
  LVarParam := AVM.PopValue();  // var parameter  
  LConstParam := AVM.PopValue(); // const parameter
  
  // Modify var parameter (passed by reference)
  LVarParam.IntValue := LVarParam.IntValue * 2;
  
  // Set out parameter
  LOutParam := AVM.MakeIntConstant(LConstParam.IntValue + LVarParam.IntValue);
  
  // Push modified values back (var and out parameters)
  AVM.PushValue(LVarParam);
  AVM.PushValue(LOutParam);
end;

procedure TMyApp.ParameterModesDemo();
var
  LVM: TJetVM;
  LVar, LOut: Integer;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    LVar := 10;
    
    // Register function with different parameter modes
    LVM.RegisterNativeFunction(
      'paramDemo',
      @MyParamModeDemo,
      [jvtInt, jvtInt, jvtInt]  // Types for const, var, out
    );
    
    // Call with different parameter modes
    LVM.LoadInt(5)           // const parameter
       .LoadInt(LVar)        // var parameter (will be modified)
       .LoadInt(0)           // out parameter (will be set)
       .CallFunction('paramDemo')
       .Stop()
       .Execute();
       
    // Get modified values
    LOut := LVM.PopValue().IntValue;  // out parameter result
    LVar := LVM.PopValue().IntValue;  // modified var parameter
    
    Assert(LVar = 20);  // Original 10 * 2
    Assert(LOut = 25);  // const(5) + var(20)
  finally
    LVM.Free();
  end;
end;
```

---

## 7. Memory Management & Bounds Checking

JetVM provides automatic memory management for managed types and optional bounds checking for pointer operations in safe mode.

### 🧠 Automatic Memory Management

```pascal
procedure TMyApp.MemoryManagementDemo();
var
  LVM: TJetVM;
  LLargeString: string;
  LI: Integer;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Strings are automatically managed
    LVM.LoadStr('Start: ');
    
    // Build large string through concatenation
    for LI := 1 to 1000 do
    begin
      LVM.LoadStr(IntToStr(LI) + ' ')
         .ConcatStr();
    end;
    
    LVM.Stop().Execute();
    
    // String memory is automatically cleaned up
    var LResult := LVM.PopValue();
    Assert(Length(LResult.StrValue) > 1000);
    
    // Arrays are also automatically managed
    LVM.Reset();
    LVM.DeclareDynamicArray(jvtInt)
       .LoadInt(1000)
       .ArraySetLength()        // Create 1000-element array
       .Stop()
       .Execute();
       
    // Array memory is automatically managed
  finally
    LVM.Free();  // All memory automatically cleaned up
  end;
end;
```

### 🛡️ Bounds Checking in Safe Mode

```pascal
procedure TMyApp.BoundsCheckingDemo();
var
  LVM: TJetVM;
  LBuffer: Pointer;
  LSize: Integer;
begin
  LVM := TJetVM.Create(vlSafe);  // Enable bounds checking
  try
    LSize := 1024;
    
    // Allocate memory (tracked in safe mode)
    LVM.LoadInt(LSize)
       .Alloc()             // Allocates and tracks memory
       .Stop()
       .Execute();
       
    LBuffer := LVM.PopValue().PtrValue;
    
    // Safe pointer operations
    LVM.Reset();
    LVM.LoadInt(NativeInt(LBuffer))
       .IntToPtr()          // Convert to pointer
       .LoadInt(0)          // Offset 0
       .LoadInt(42)         // Value to store
       .StoreOffsetInt()    // Safe store with bounds checking
       .Stop();
       
    try
      LVM.Execute();       // Should succeed - within bounds
    except
      Assert(False, 'Within-bounds access should succeed');
    end;
    
    // Unsafe access (out of bounds)
    LVM.Reset();
    LVM.LoadInt(NativeInt(LBuffer))
       .IntToPtr()
       .LoadInt(LSize + 100)  // Offset beyond allocation
       .LoadInt(42)
       .StoreOffsetInt()      // Should fail in safe mode
       .Stop();
       
    try
      LVM.Execute();
      Assert(False, 'Out-of-bounds access should fail in safe mode');
    except
      on E: EJetVMError do
        Assert(Pos('bounds', LowerCase(E.Message)) > 0, 'Should be bounds error');
    end;
    
    // Clean up
    LVM.Reset();
    LVM.LoadInt(NativeInt(LBuffer))
       .IntToPtr()
       .FreeMem()           // Free tracked memory
       .Stop()
       .Execute();
  finally
    LVM.Free();
  end;
end;
```

### 🔍 Memory Debugging Utilities

```pascal
procedure TMyApp.MemoryDebuggingDemo();
var
  LVM: TJetVM;
  LAllocationSize: Integer;
  LPtr: Pointer;
begin
  LVM := TJetVM.Create(vlDevelopment);  // Enable memory tracking
  try
    // Allocate some memory
    LVM.LoadInt(512)
       .Alloc()
       .Stop()
       .Execute();
       
    LPtr := LVM.PopValue().PtrValue;
    
    // Check allocation size
    LAllocationSize := LVM.GetAllocationSize(LPtr);
    Assert(LAllocationSize = 512, 'Should track allocation size');
    
    // Dump VM state for debugging
    LVM.DumpStack();          // Shows current stack contents
    LVM.DumpConstants();      // Shows constants pool
    LVM.DumpFunctionRegistry(); // Shows registered functions
    
    // Disassemble instructions for debugging
    var LDisasm := LVM.DisassembleInstruction(0);
    WriteLn('First instruction: ', LDisasm);
    
    // Clean up
    LVM.Reset();
    LVM.LoadInt(NativeInt(LPtr))
       .IntToPtr()
       .FreeMem()
       .Stop()
       .Execute();
  finally
    LVM.Free();
  end;
end;
```

---

## 8. Practical Usage Examples

Real-world examples demonstrating common JetVM usage patterns.

### 🧮 Calculator Engine

```pascal
TCalculatorEngine = class
private
  FVM: TJetVM;
public
  constructor Create();
  destructor Destroy(); override;
  function EvaluateExpression(const AExpression: string): Double;
end;

constructor TCalculatorEngine.Create();
begin
  inherited Create();
  FVM := TJetVM.Create(vlBasic);
  
  // Register math functions
  FVM.RegisterNativeFunction('sin', @MathSin, [jvtInt], jvtInt);
  FVM.RegisterNativeFunction('cos', @MathCos, [jvtInt], jvtInt);
  FVM.RegisterNativeFunction('sqrt', @MathSqrt, [jvtInt], jvtInt);
end;

function TCalculatorEngine.EvaluateExpression(const AExpression: string): Double;
begin
  // This is a simplified example - real implementation would parse expression
  FVM.Reset();
  
  // Example: evaluate "sin(30) + cos(60) * 2"
  FVM.LoadInt(30)
     .CallFunction('sin')      // sin(30)
     .LoadInt(60)  
     .CallFunction('cos')      // cos(60)
     .LoadInt(2)
     .MulInt()                 // cos(60) * 2
     .AddInt()                 // sin(30) + (cos(60) * 2)
     .Stop()
     .Execute();
     
  var LResult := FVM.PopValue();
  Result := LResult.IntValue;  // Convert to double as needed
end;
```

### 🎮 Game Scripting System

```pascal
TGameScriptEngine = class
private
  FVM: TJetVM;
  FPlayer: TPlayer;
public
  constructor Create(const APlayer: TPlayer);
  destructor Destroy(); override;
  procedure ExecuteScript(const AScriptCode: string);
end;

// Native game functions
procedure GameMovePlayer(const AVM: TJetVM);
var
  LY, LX: TJetValue;
begin
  LY := AVM.PopValue();
  LX := AVM.PopValue();
  // Move player logic here
  WriteLn(Format('Moving player to (%d, %d)', [LX.IntValue, LY.IntValue]));
end;

procedure GameShowMessage(const AVM: TJetVM);
var
  LMessage: TJetValue;
begin
  LMessage := AVM.PopValue();
  ShowMessage(LMessage.StrValue);
end;

constructor TGameScriptEngine.Create(const APlayer: TPlayer);
begin
  inherited Create();
  FPlayer := APlayer;
  FVM := TJetVM.Create(vlSafe);  // Safe mode for user scripts
  
  // Register game API functions
  FVM.RegisterNativeFunction('movePlayer', @GameMovePlayer, [jvtInt, jvtInt]);
  FVM.RegisterNativeFunction('showMessage', @GameShowMessage, [jvtStr]);
  FVM.RegisterNativeFunction('getPlayerX', @GameGetPlayerX, [], jvtInt);
  FVM.RegisterNativeFunction('getPlayerY', @GameGetPlayerY, [], jvtInt);
end;

procedure TGameScriptEngine.ExecuteScript(const AScriptCode: string);
begin
  // This would typically parse AScriptCode and generate bytecode
  // For demonstration, showing direct bytecode generation:
  
  FVM.Reset();
  
  // Example script: "if player.x > 10 then movePlayer(5, 5)"
  FVM.CallFunction('getPlayerX')    // Get current X position
     .LoadInt(10)
     .GtInt()                      // X > 10?
     
  var LEndLabel := FVM.CreateLabel();
  FVM.JumpFalse(LEndLabel)         // Skip if condition false
     .LoadInt(5)
     .LoadInt(5)
     .CallFunction('movePlayer')   // Move to (5,5)
     .BindLabel(LEndLabel)
     .Stop()
     .Execute();
end;
```

### 📊 Data Processing Pipeline

```pascal
TDataProcessor = class
private
  FVM: TJetVM;
public
  constructor Create();
  destructor Destroy(); override;
  function ProcessDataSet(const AData: array of Integer): TArray<Integer>;
end;

constructor TDataProcessor.Create();
begin
  inherited Create();
  FVM := TJetVM.Create(vlBasic);
  
  // Register data processing functions
  FVM.RegisterNativeFunction('filter', @DataFilter, [jvtArrayInt, jvtInt], jvtArrayInt);
  FVM.RegisterNativeFunction('map', @DataMap, [jvtArrayInt], jvtArrayInt);
  FVM.RegisterNativeFunction('reduce', @DataReduce, [jvtArrayInt], jvtInt);
end;

function TDataProcessor.ProcessDataSet(const AData: array of Integer): TArray<Integer>;
var
  LDataValue: TJetValue;
  LI: Integer;
begin
  // Convert input array to TJetValue
  LDataValue.ValueType := jvtArrayInt;
  SetLength(LDataValue.ArrayIntValue, Length(AData));
  for LI := 0 to High(AData) do
    LDataValue.ArrayIntValue[LI] := AData[LI];
    
  FVM.Reset();
  
  // Processing pipeline: filter > 0, map *2, then return
  FVM.PushValue(LDataValue)         // Push input array
     .LoadInt(0)                    // Threshold for filter
     .CallFunction('filter')        // Filter values > 0
     .CallFunction('map')           // Map: multiply each by 2
     .Stop()
     .Execute();
     
  // Convert result back to regular array
  var LResult := FVM.PopValue();
  SetLength(Result, Length(LResult.ArrayIntValue));
  for LI := 0 to High(LResult.ArrayIntValue) do
    Result[LI] := LResult.ArrayIntValue[LI];
end;
```

---

## 9. Performance Optimization Guide

Guidelines for maximizing JetVM performance in different scenarios.

### 🚀 Validation Level Selection

```pascal
// High-frequency operations (game loops, real-time processing)
procedure OptimizeForSpeed();
var
  LVM: TJetVM;
begin
  LVM := TJetVM.Create(vlNone);  // Maximum speed
  try
    // Critical: ensure code is well-tested before using vlNone
    // No runtime safety checks - crashes possible with bad code
    LVM.LoadInt(10).LoadInt(20).AddInt().Stop().Execute();
  finally
    LVM.Free();
  end;
end;

// General applications (recommended default)
procedure BalanceSpeedAndSafety();
var
  LVM: TJetVM;
begin
  LVM := TJetVM.Create(vlBasic);  // Good balance
  try
    // Emit-time validation catches most errors
    // Minimal runtime overhead
    LVM.LoadInt(10).LoadInt(20).AddInt().Stop().Execute();
  finally
    LVM.Free();
  end;
end;

// Untrusted code or development
procedure MaximizeSafety();
var
  LVM: TJetVM;
begin
  LVM := TJetVM.Create(vlSafe);  // Maximum safety
  try
    // Full runtime checking - slower but very safe
    // Use for processing user scripts or during development
    LVM.LoadInt(10).LoadInt(20).AddInt().Stop().Execute();
  finally
    LVM.Free();
  end;
end;
```

### ⚡ Bytecode Optimization Patterns

```pascal
procedure TMyApp.OptimizedBytecodePatterns();
var
  LVM: TJetVM;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // BAD: Multiple constant loads for same value
    LVM.LoadInt(42).LoadInt(42).LoadInt(42);
    
    // GOOD: Load once, then duplicate
    LVM.Reset();
    LVM.LoadInt(42).Dup().Dup();  // More efficient
    
    // BAD: Unnecessary stack manipulation
    LVM.Reset();
    LVM.LoadInt(10).LoadInt(20).Swap().AddInt();
    
    // GOOD: Load in correct order
    LVM.Reset();
    LVM.LoadInt(20).LoadInt(10).AddInt();  // More direct
    
    // BAD: Repeated function calls
    LVM.Reset();
    LVM.LoadStr('Hello').CallFunction('print')
       .LoadStr('Hello').CallFunction('print');
       
    // GOOD: Store common values
    LVM.Reset();
    LVM.LoadStr('Hello').Dup()
       .CallFunction('print')
       .CallFunction('print');
  finally
    LVM.Free();
  end;
end;
```

### 💾 Memory Optimization

```pascal
procedure TMyApp.MemoryOptimizationDemo();
var
  LVM: TJetVM;
  LI: Integer;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Pre-size constants pool for known program size
    for LI := 1 to 100 do
      LVM.AddConstant(LVM.MakeIntConstant(LI));
      
    // Prefer integers over strings when possible
    LVM.LoadInt(42)        // Efficient
       .IntToStr()         // Convert only when needed
       .Stop();
       
    // Reuse VM instances rather than creating/destroying
    for LI := 1 to 1000 do
    begin
      LVM.Reset();  // Reuse instead of Create/Free
      LVM.LoadInt(LI).Stop().Execute();
    end;
    
    // Batch operations when possible
    LVM.Reset();
    for LI := 1 to 10 do
      LVM.LoadInt(LI);     // Build entire program
    LVM.Stop().Execute();  // Then execute once
  finally
    LVM.Free();
  end;
end;
```

### 🔄 Execution Optimization

```pascal
procedure TMyApp.ExecutionOptimizations();
var
  LVM: TJetVM;
  LI: Integer;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Finalize once for repeated execution
    LVM.LoadInt(42).LoadInt(100).AddInt().Stop();
    LVM.Finalize();  // Optimize bytecode once
    
    // Execute multiple times efficiently
    for LI := 1 to 1000000 do
    begin
      LVM.Execute();
      LVM.Reset();   // Quick reset, keeps optimized bytecode
    end;
    
    // Use step execution for debugging only
    if {$IFDEF DEBUG} True {$ELSE} False {$ENDIF} then
    begin
      LVM.Reset();
      while LVM.GetPC() < LVM.BytecodeSize() do
        LVM.Step();  // Step-by-step for debugging
    end
    else
    begin
      LVM.Reset();
      LVM.Execute();  // Full execution for production
    end;
  finally
    LVM.Free();
  end;
end;
```

---

## 10. Best Practices & Common Patterns

Recommended patterns and practices for effective JetVM usage.

### ✅ Recommended Patterns

```pascal
// 1. RAII Pattern for VM Management
TJetVMManager = class
private
  FVM: TJetVM;
public
  constructor Create(const AValidationLevel: TJetVMValidationLevel = vlBasic);
  destructor Destroy(); override;
  property VM: TJetVM read FVM;
end;

constructor TJetVMManager.Create(const AValidationLevel: TJetVMValidationLevel);
begin
  inherited Create();
  FVM := TJetVM.Create(AValidationLevel);
end;

destructor TJetVMManager.Destroy();
begin
  FVM.Free();
  inherited Destroy();
end;

// 2. Program Builder Pattern
TJetProgramBuilder = class
private
  FVM: TJetVM;
  FFinalized: Boolean;
public
  constructor Create(const AVM: TJetVM);
  function AddCalculation(const AValue1, AValue2: Int64): TJetProgramBuilder;
  function AddStringOperation(const AStr1, AStr2: string): TJetProgramBuilder;
  procedure Execute();
end;

function TJetProgramBuilder.AddCalculation(const AValue1, AValue2: Int64): TJetProgramBuilder;
begin
  FVM.LoadInt(AValue1).LoadInt(AValue2).AddInt();
  Result := Self;
end;

procedure TJetProgramBuilder.Execute();
begin
  if not FFinalized then
  begin
    FVM.Stop();
    FVM.Finalize();
    FFinalized := True;
  end;
  FVM.Execute();
end;

// 3. Function Registry Pattern
procedure RegisterCommonFunctions(const AVM: TJetVM);
begin
  // Math functions
  AVM.RegisterNativeFunction('abs', @MathAbs, [jvtInt], jvtInt);
  AVM.RegisterNativeFunction('max', @MathMax, [jvtInt, jvtInt], jvtInt);
  AVM.RegisterNativeFunction('min', @MathMin, [jvtInt, jvtInt], jvtInt);
  
  // String functions
  AVM.RegisterNativeFunction('reverse', @StringReverse, [jvtStr], jvtStr);
  AVM.RegisterNativeFunction('repeat', @StringRepeat, [jvtStr, jvtInt], jvtStr);
  
  // Array functions
  AVM.RegisterNativeFunction('sort', @ArraySort, [jvtArrayInt], jvtArrayInt);
  AVM.RegisterNativeFunction('sum', @ArraySum, [jvtArrayInt], jvtInt);
end;
```

### ❌ Anti-Patterns to Avoid

```pascal
procedure TMyApp.AntiPatternsToAvoid();
var
  LVM: TJetVM;
begin
  // DON'T: Create VM for single operation
  // This is inefficient due to setup/teardown overhead
  LVM := TJetVM.Create(vlBasic);
  LVM.LoadInt(42).Stop().Execute();
  LVM.Free();
  
  // DON'T: Ignore validation levels
  // Using wrong level can cause crashes or poor performance
  LVM := TJetVM.Create(vlNone);  // Dangerous for untrusted code
  // ... process user input without validation
  
  // DON'T: Mix manual stack manipulation with fluent interface
  LVM := TJetVM.Create(vlBasic);
  LVM.LoadInt(42);
  LVM.PushValue(LVM.MakeIntConstant(100));  // Breaks fluent chain
  LVM.AddInt().Stop();  // May cause stack inconsistencies
  
  // DON'T: Forget to handle exceptions
  try
    LVM.LoadInt(1).LoadInt(0).DivInt().Stop().Execute();  // Division by zero
  except
    // Always handle VM exceptions appropriately
  end;
  
  LVM.Free();
end;
```

### 🔧 Error Handling Patterns

```pascal
function TMyApp.SafeExecuteProgram(const AVM: TJetVM): Boolean;
var
  LOriginalLevel: TJetVMValidationLevel;
begin
  Result := False;
  LOriginalLevel := AVM.GetValidationLevel();
  
  try
    // Temporarily increase safety for untrusted operations
    AVM.SetValidationLevel(vlSafe);
    
    AVM.Execute();
    Result := True;
    
  except
    on E: EJetVMError do
    begin
      WriteLn('VM Error: ', E.Message);
      // Log error details
      WriteLn('PC: ', AVM.GetPC());
      WriteLn('SP: ', AVM.GetSP());
      AVM.DumpStack();
    end;
    on E: Exception do
    begin
      WriteLn('Unexpected error: ', E.Message);
      // Handle unexpected errors
    end;
  finally
    // Restore original validation level
    AVM.SetValidationLevel(LOriginalLevel);
  end;
end;
```

### 🎯 Testing Patterns

```pascal
procedure TMyApp.TestingPatterns();
var
  LVM: TJetVM;
  LResult: TJetValue;
begin
  // Use development mode for comprehensive testing
  LVM := TJetVM.Create(vlDevelopment);
  try
    // Test with known inputs
    LVM.LoadInt(10).LoadInt(20).AddInt().Stop().Execute();
    
    LResult := LVM.PopValue();
    Assert(LResult.ValueType = jvtInt, 'Result should be integer');
    Assert(LResult.IntValue = 30, 'Result should be 30');
    
    // Test stack state
    Assert(LVM.GetSP() = 0, 'Stack should be empty after pop');
    
    // Test error conditions
    LVM.Reset();
    try
      LVM.LoadInt(1).LoadInt(0).DivInt().Stop().Execute();
      Assert(False, 'Division by zero should fail');
    except
      on EJetVMError do
        ; // Expected
    end;
  finally
    LVM.Free();
  end;
end;
```

---

## 11. Error Handling & Debugging

Comprehensive error handling and debugging techniques for JetVM.

### 🐛 Debugging Utilities

```pascal
procedure TMyApp.DebuggingExample();
var
  LVM: TJetVM;
  LPC: Integer;
begin
  LVM := TJetVM.Create(vlDevelopment);
  try
    // Build program with debugging info
    LVM.LoadInt(42)
       .LoadInt(100)
       .AddInt()
       .LoadStr('Result: ')
       .Swap()
       .IntToStr()
       .ConcatStr()
       .Stop();
       
    // Debug execution step by step
    WriteLn('=== STEP-BY-STEP EXECUTION ===');
    while LVM.GetPC() < LVM.BytecodeSize() do
    begin
      LPC := LVM.GetPC();
      WriteLn(Format('PC=%d: %s', [LPC, LVM.DisassembleInstruction(LPC)]));
      WriteLn(Format('  SP before: %d', [LVM.GetSP()]));
      
      LVM.Step();
      
      WriteLn(Format('  SP after: %d', [LVM.GetSP()]));
      
      if LVM.GetSP() > 0 then
      begin
        WriteLn('  Stack contents:');
        LVM.DumpStack();
      end;
      WriteLn('');
      
      if not LVM.IsRunning() then Break;
    end;
    
    WriteLn('=== FINAL STATE ===');
    WriteLn('Final PC: ', LVM.GetPC());
    WriteLn('Final SP: ', LVM.GetSP());
    WriteLn('Constants Pool:');
    LVM.DumpConstants();
  finally
    LVM.Free();
  end;
end;
```

### ⚠️ Exception Handling Strategies

```pascal
TJetVMErrorHandler = class
public
  class procedure HandleVMError(const AVM: TJetVM; const AException: EJetVMError);
  class function TryExecute(const AVM: TJetVM; out AError: string): Boolean;
end;

class procedure TJetVMErrorHandler.HandleVMError(const AVM: TJetVM; const AException: EJetVMError);
begin
  WriteLn('=== JETVM ERROR ===');
  WriteLn('Error: ', AException.Message);
  WriteLn('PC: ', AVM.GetPC());
  WriteLn('SP: ', AVM.GetSP());
  WriteLn('Call Depth: ', AVM.GetCallDepth());
  
  if AVM.GetCurrentFunction() >= 0 then
    WriteLn('Current Function: ', AVM.GetCurrentFunction());
    
  WriteLn('');
  WriteLn('Stack contents:');
  AVM.DumpStack();
  
  WriteLn('');
  WriteLn('Recent instructions:');
  var LPC := Max(0, AVM.GetPC() - 3);
  while LPC <= Min(AVM.GetPC() + 2, AVM.BytecodeSize() - 1) do
  begin
    if LPC = AVM.GetPC() then
      Write('>>> ')
    else
      Write('    ');
    WriteLn(AVM.DisassembleInstruction(LPC));
    Inc(LPC);
  end;
end;

class function TJetVMErrorHandler.TryExecute(const AVM: TJetVM; out AError: string): Boolean;
begin
  Result := False;
  AError := '';
  
  try
    AVM.Execute();
    Result := True;
  except
    on E: EJetVMError do
    begin
      AError := E.Message;
      HandleVMError(AVM, E);
    end;
    on E: Exception do
    begin
      AError := 'Unexpected error: ' + E.Message;
      WriteLn('Unexpected error in VM: ', E.Message);
    end;
  end;
end;
```

### 🔍 Validation and Verification

```pascal
procedure TMyApp.ValidationExample();
var
  LVM: TJetVM;
  LOriginalLevel: TJetVMValidationLevel;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    LOriginalLevel := LVM.GetValidationLevel();
    
    // Verify program with increasing validation levels
    LVM.LoadInt(10).LoadInt(20).AddInt().Stop();
    
    // Test with basic validation
    LVM.SetValidationLevel(vlBasic);
    try
      LVM.Execute();
      WriteLn('✓ Program passes vlBasic validation');
    except
      on E: EJetVMError do
        WriteLn('✗ Program fails vlBasic: ', E.Message);
    end;
    
    // Test with development validation
    LVM.Reset();
    LVM.LoadInt(10).LoadInt(20).AddInt().Stop();
    LVM.SetValidationLevel(vlDevelopment);
    try
      LVM.Execute();
      WriteLn('✓ Program passes vlDevelopment validation');
    except
      on E: EJetVMError do
        WriteLn('✗ Program fails vlDevelopment: ', E.Message);
    end;
    
    // Test with safe validation
    LVM.Reset();
    LVM.LoadInt(10).LoadInt(20).AddInt().Stop();
    LVM.SetValidationLevel(vlSafe);
    try
      LVM.Execute();
      WriteLn('✓ Program passes vlSafe validation');
    except
      on E: EJetVMError do
        WriteLn('✗ Program fails vlSafe: ', E.Message);
    end;
    
    // Restore original level
    LVM.SetValidationLevel(LOriginalLevel);
  finally
    LVM.Free();
  end;
end;
```

---

## 12. Integration Patterns

Common patterns for integrating JetVM into larger Delphi applications.

### 🔌 Application Integration

```pascal
// Singleton VM Manager for application-wide scripting
TApplicationScriptManager = class
private
  class var FInstance: TApplicationScriptManager;
  FVM: TJetVM;
  FInitialized: Boolean;
  
  constructor Create();
public
  class function Instance(): TApplicationScriptManager;
  class procedure Finalize();
  
  procedure Initialize();
  function ExecuteScript(const AScript: string): TJetValue;
  procedure RegisterApplicationAPI();
end;

class function TApplicationScriptManager.Instance(): TApplicationScriptManager;
begin
  if not Assigned(FInstance) then
    FInstance := TApplicationScriptManager.Create();
  Result := FInstance;
end;

procedure TApplicationScriptManager.Initialize();
begin
  if FInitialized then Exit;
  
  FVM := TJetVM.Create(vlBasic);
  RegisterApplicationAPI();
  FInitialized := True;
end;

procedure TApplicationScriptManager.RegisterApplicationAPI();
begin
  // Register application-specific functions
  FVM.RegisterNativeFunction('showDialog', @AppShowDialog, [jvtStr]);
  FVM.RegisterNativeFunction('getAppVersion', @AppGetVersion, [], jvtStr);
  FVM.RegisterNativeFunction('getCurrentUser', @AppGetCurrentUser, [], jvtStr);
  FVM.RegisterNativeFunction('saveToFile', @AppSaveToFile, [jvtStr, jvtStr], jvtBool);
end;
```

### 🎮 Plugin Architecture

```pascal
IScriptPlugin = interface
  ['{12345678-1234-1234-1234-123456789ABC}']
  procedure RegisterFunctions(const AVM: TJetVM);
  function GetPluginName(): string;
  function GetPluginVersion(): string;
end;

TScriptPluginManager = class
private
  FPlugins: TList<IScriptPlugin>;
  FVM: TJetVM;
public
  constructor Create(const AVM: TJetVM);
  destructor Destroy(); override;
  
  procedure RegisterPlugin(const APlugin: IScriptPlugin);
  procedure LoadAllPlugins();
  function GetRegisteredFunctions(): TStringList;
end;

procedure TScriptPluginManager.RegisterPlugin(const APlugin: IScriptPlugin);
begin
  FPlugins.Add(APlugin);
  APlugin.RegisterFunctions(FVM);
  WriteLn(Format('Loaded plugin: %s v%s', [APlugin.GetPluginName(), APlugin.GetPluginVersion()]));
end;
```

### 📊 Data Processing Integration

```pascal
TDataPipelineProcessor = class
private
  FVM: TJetVM;
  FProcessingScript: string;
public
  constructor Create();
  destructor Destroy(); override;
  
  procedure SetProcessingScript(const AScript: string);
  function ProcessRecord(const ARecord: TDataRecord): TDataRecord;
  function ProcessBatch(const ABatch: TArray<TDataRecord>): TArray<TDataRecord>;
end;

function TDataPipelineProcessor.ProcessRecord(const ARecord: TDataRecord): TDataRecord;
var
  LInputValue: TJetValue;
  LOutputValue: TJetValue;
begin
  // Convert record to TJetValue
  LInputValue := ConvertRecordToJetValue(ARecord);
  
  FVM.Reset();
  FVM.PushValue(LInputValue);
  // Execute processing script here
  FVM.Execute();
  
  LOutputValue := FVM.PopValue();
  Result := ConvertJetValueToRecord(LOutputValue);
end;
```

### 🌐 Web Service Integration

```pascal
TScriptableWebService = class
private
  FVM: TJetVM;
  FRequestHandlers: TDictionary<string, string>;
public
  constructor Create();
  destructor Destroy(); override;
  
  procedure RegisterEndpoint(const APath, AScript: string);
  function HandleRequest(const APath: string; const AParams: TJSONObject): TJSONObject;
end;

function TScriptableWebService.HandleRequest(const APath: string; const AParams: TJSONObject): TJSONObject;
var
  LScript: string;
  LParamsValue: TJetValue;
  LResultValue: TJetValue;
begin
  if not FRequestHandlers.TryGetValue(APath, LScript) then
    raise Exception.Create('Endpoint not found: ' + APath);
    
  // Convert JSON params to JetValue
  LParamsValue := ConvertJSONToJetValue(AParams);
  
  FVM.Reset();
  FVM.PushValue(LParamsValue);
  // Execute endpoint script
  FVM.Execute();
  
  LResultValue := FVM.PopValue();
  Result := ConvertJetValueToJSON(LResultValue);
end;
```

---

## Conclusion & Quick Reference

### 🚀 Quick Start Checklist

1. ✓ Create VM: `LVM := TJetVM.Create(vlBasic);`
2. ✓ Build program using fluent interface: `LVM.LoadInt(42).Stop();`
3. ✓ Execute: `LVM.Execute();`
4. ✓ Get results: `LResult := LVM.PopValue();`
5. ✓ Clean up: `LVM.Free();`

### 🎯 Validation Level Quick Guide

- **vlNone**: Maximum speed, no safety - production code only
- **vlBasic**: Recommended default - good balance of speed and safety
- **vlDevelopment**: For debugging - stack tracking and type hints
- **vlSafe**: Maximum safety - untrusted code and critical operations

### ⚡ Performance Tips

- Reuse VM instances instead of creating/destroying
- Use vlBasic for general purpose, vlNone only for proven code
- Finalize bytecode once for repeated execution
- Prefer integers over strings when possible
- Batch operations to minimize Execute() calls

### 🔧 Debugging Quick Commands

- `LVM.DumpStack()` - Show current stack state
- `LVM.DisassembleInstruction(PC)` - Show instruction at PC
- `LVM.Step()` - Execute single instruction
- `LVM.GetPC()`, `LVM.GetSP()` - Get current execution state

### 📚 Further Reading

- See unit tests in `JetVM.Test.*` for comprehensive examples
- Check `JetVM.Test.Core` for basic usage patterns
- Review `JetVM.Test.Values` for value system details
- Examine `JetVM.Test.Functions` for function integration examples

### ⚠️ Important Notes

- Always use try/finally blocks for VM cleanup
- Check validation levels before processing untrusted code
- Handle EJetVMError exceptions appropriately
- Test thoroughly before switching to vlNone validation

**Happy scripting with JetVM! 🚀**

---

*For detailed API documentation, see the interface section in JetVM.pas.*  
*For comprehensive examples, see the accompanying test suites.*  
*For performance benchmarks, see JetVM.Test.Performance (when available).*