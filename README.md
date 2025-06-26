![JetVMl](media/jetvm.jpg)  
[![Chat on Discord](https://img.shields.io/discord/754884471324672040?style=for-the-badge)](https://discord.gg/tPWjMwK)
[![Follow on Bluesky](https://img.shields.io/badge/Bluesky-tinyBigGAMES-blue?style=for-the-badge&logo=bluesky)](https://bsky.app/profile/tinybiggames.com)

> 🚧 **This repository is currently under construction.**
>
> JetVM is actively being developed and rapidly evolving. Some features mentioned in this documentation may not yet be fully implemented, and both APIs and internal structure are subject to change as we continue to improve and expand the library.
>
> Your contributions, feedback, and issue reports are highly valued and will help shape NitroVM into the ultimate Pascal development platform!


# 🚀 JetVM - Fast Delphi Virtual Machine
JetVM is a A high-performance, stack-based virtual machine with native Delphi integration. It bridges the gap between performance and safety. Execute bytecode with configurable validation levels, from maximum speed to fully bounds-checked safe execution.

## ✨ Features

### 🎯 **Native Delphi Integration**
- Uses native Delphi strings and memory management
- Seamless integration with existing Delphi functions
- Call native Delphi procedures directly from VM code
- Zero external dependencies

### ⚡ **Performance-Focused**
- Cache-friendly data layout for hot execution paths
- Multiple validation levels for speed vs safety tradeoffs
- Optimized execution core with selective bounds checking
- Tagged union design for maximum type performance

### 🛡️ **Configurable Safety**
```pascal
// Choose your safety level:
TJetVMValidationLevel = (
  vlNone,        // Maximum speed - no checks
  vlBasic,       // Emit-time validation only  
  vlDevelopment, // Stack tracking, type hints
  vlSafe         // Full runtime bounds checking
);
```

### 🔧 **Modern Fluent API**
```pascal
// Beautiful, chainable bytecode generation
VM := TJetVM.Create(vlDevelopment);
try
  VM.LoadInt(42)
    .LoadInt(100)
    .AddInt()
    .StoreLocal(0)
    .CallFunction('PrintResult')
    .Stop()
    .Execute();
finally
  VM.Free;
end;
```

### 🎨 **Rich Type System**
- **Integers**: Int64 & UInt64 with full arithmetic
- **Strings**: Native Delphi string operations (Concat, Length, Copy, Pos, etc.)
- **Booleans**: Logical operations and flow control
- **Pointers**: Type-safe pointer operations with bounds checking
- **Arrays**: Dynamic and fixed arrays with element access

### 📊 **Comprehensive Bytecode Support**
- **140+ optimized opcodes** covering all core operations
- **Fluent assembly interface** for readable code generation
- **Compile-time validation** with detailed error reporting
- **Label management** with forward reference resolution

## 🎯 Use Cases

JetVM excels in scenarios requiring **safe execution** of **untrusted code**:

- **🎮 Game Scripting**: Player mods, AI behaviors, quest systems  
- **📊 Data Processing**: User-defined calculations, transformations, filters
- **🔌 Plugin Systems**: Safe execution of third-party plugins and extensions
- **📈 Calculators**: Advanced calculation engines with custom functions

## 📈 Project Status

### 🚀 **Current State**
- **Core Infrastructure**: ✅ Production Ready (100% test coverage)
- **Value System**: ✅ Fully Implemented (67 comprehensive tests)
- **Stack Operations**: ✅ Complete & Validated (49 comprehensive tests)
- **Constants Pool**: ✅ Complete & Tested (50 comprehensive tests)
- **Bytecode Generation**: ✅ Complete & Fluent (48 comprehensive tests)

### 🎯 **Development Roadmap**
- **Q1 2025**: Complete core test suite (Phases 1-5) ✅ **COMPLETE**
- **Q2 2025**: Advanced opcode implementation & optimization
- **Q3 2025**: Performance benchmarking & real-world integration examples
- **Q4 2025**: Plugin architecture & ecosystem development tools

### ⚡ **Performance Benchmarks**
Based on current test results:
- **VM Creation**: Sub-millisecond startup time
- **Value Operations**: Microsecond-level execution  
- **Bulk Processing**: 10,000+ operations in <5000ms
- **Memory Management**: Zero leak indicators in stress tests
- **Test Execution**: 0.0003s average per test (257 tests in 0.069s)

### 🏆 **Quality Metrics**
- **Zero Defects**: No bugs detected in tested components
- **100% Pass Rate**: All 257 tests consistently passing
- **Enterprise Ready**: Robust error handling and edge case management
- **Memory Safe**: Comprehensive bounds checking and leak prevention

*See [TEST-REPORT.md](TEST-REPORT.md) for detailed performance analysis and quality metrics.*

## 🚀 Quick Start

### Basic Usage

```pascal
uses
  JetVM;

var
  LVM: TJetVM;
  LResult: TJetValue;
begin
  LVM := TJetVM.Create(vlBasic);
  try
    // Simple arithmetic: 10 + 32 = 42
    LVM.LoadInt(10)
       .LoadInt(32)
       .AddInt()
       .Stop();
       
    LVM.Execute();
    
    // Get result from stack
    LResult := LVM.PeekValue();
    WriteLn('Result: ', LResult.IntValue); // Output: 42
  finally
    LVM.Free;
  end;
end;
```

### String Operations

```pascal
// String manipulation with native Delphi functions
LVM.LoadStr('Hello, ')
   .LoadStr('World!')
   .ConcatStr()
   .UpperStr()
   .Stop();
   
LVM.Execute();
LResult := LVM.PeekValue();
WriteLn(LResult.StrValue); // Output: HELLO, WORLD!
```

### Native Function Integration

```pascal
// Register a native Delphi function
procedure MyPrintLine(const AVM: TJetVM);
var
  LValue: TJetValue;
begin
  LValue := AVM.PopValue();
  WriteLn('VM Output: ', LValue.StrValue);
end;

// Register and use in VM code
LVM.RegisterNativeFunction('println', @MyPrintLine, [jvtStr]);

LVM.LoadStr('Hello from VM!')
   .CallNative('println')
   .Stop();
   
LVM.Execute(); // Output: VM Output: Hello from VM!
```

### Advanced: Conditional Logic

```pascal
// if (x > 10) then result := x * 2 else result := x + 5
LVM.LoadInt(15)        // Load x = 15
   .Dup()              // Duplicate for comparison
   .LoadInt(10)        // Load comparison value
   .GreaterThanInt()   // x > 10?
   .JumpIfFalse('else_branch')
   
   // True branch: x * 2
   .LoadInt(2)
   .MultiplyInt()
   .Jump('end')
   
   .Label('else_branch')
   // False branch: x + 5  
   .LoadInt(5)
   .AddInt()
   
   .Label('end')
   .Stop();

LVM.Execute();
LResult := LVM.PeekValue();
WriteLn('Result: ', LResult.IntValue); // Output: 30
```

## 📖 Documentation

### 📚 **Comprehensive Developer Guide**
**[DEVELOPER-GUIDE.md](DEVELOPER-GUIDE.md)** contains **12 detailed sections**:

| Section | Content | Pages |
|---------|---------|-------|
| 🏗️ **Architecture** | Project overview, core features, performance characteristics | 📄📄 |
| 💎 **Value System** | TJetValue tagged union, memory layout, type safety | 📄📄📄 |
| 🛡️ **Validation Levels** | Performance vs safety, level switching, benchmarks | 📄📄 |
| ⛓️ **Fluent Interface** | Bytecode generation, method chaining, complex expressions | 📄📄📄 |
| 🎯 **Execution Model** | Stack machine, state management, control flow | 📄📄📄 |
| 📞 **Function System** | Native integration, VM functions, parameter modes | 📄📄📄 |
| 🧠 **Memory Management** | Automatic cleanup, bounds checking, debugging utilities | 📄📄 |
| 🎪 **Practical Examples** | Calculator engines, game scripting, data processing | 📄📄📄📄 |
| ⚡ **Performance Guide** | Optimization strategies, validation selection, benchmarking | 📄📄 |
| ✅ **Best Practices** | Recommended patterns, anti-patterns, testing strategies | 📄📄📄 |
| 🐛 **Error Handling** | Debugging utilities, exception strategies, validation | 📄📄 |
| 🔌 **Integration** | Application integration, plugin architecture, web services | 📄📄📄 |

### 📊 **Current Test Coverage Report**
**[TEST-REPORT.md](TEST-REPORT.md)** provides comprehensive analysis:

#### ✅ **Test Results Summary**
- **257 tests executed** with **100% pass rate**
- **0.069 seconds total execution time** (0.0003s average per test)
- **Zero defects** detected in core functionality
- **Enterprise-grade stability** demonstrated

#### 📋 **Component Coverage Matrix**
| Component | Coverage | Status | Test Count |
|-----------|----------|--------|------------|
| **VM Core** | 100% | ✅ Complete | 43 tests |
| **TJetValue System** | 100% | ✅ Complete | 67 tests |
| **Stack Operations** | 100% | ✅ Complete | 49 tests |
| **Constants Pool** | 100% | ✅ Complete | 50 tests |
| **Bytecode Generation** | 100% | ✅ Complete | 48 tests |

#### 🎯 **Development Phases**
- ✅ **Phase 1**: Core Infrastructure (43 tests) - **COMPLETE**
- ✅ **Phase 2**: Values System (67 tests) - **COMPLETE**
- ✅ **Phase 3**: Stack Operations (49 tests) - **COMPLETE**
- ✅ **Phase 4**: Constants Pool (50 tests) - **COMPLETE**
- ✅ **Phase 5**: Bytecode Generation (48 tests) - **COMPLETE**

#### ⚡ **Performance Metrics**
- **VM Creation**: Sub-millisecond startup
- **Value Operations**: Microsecond-level execution
- **Bulk Operations**: 10,000+ in <5000ms
- **Memory Safety**: Zero leak indicators

### 🔧 **API Reference**
- **Inline Documentation**: Comprehensive comments in `JetVM.pas`
- **Interface Definitions**: All public methods documented
- **Usage Examples**: Code samples for every major feature

## 🧪 Testing & Quality Assurance

JetVM maintains **enterprise-grade quality** through comprehensive testing:

### ✅ **Current Test Status**
- **257 tests** with **100% pass rate** _(Perfect success rate!)_
- **0.069 seconds execution time** - enables rapid development cycles
- **Zero defects** detected in core functionality
- **Lightning performance** - 0.0003s average per test

### 📋 **Test Coverage Breakdown**
| Component | Tests | Coverage | Status |
|-----------|-------|----------|--------|
| **VM Core & Lifecycle** | 43 | 100% | ✅ Production Ready |
| **TJetValue System** | 67 | 100% | ✅ All Types Covered |
| **Stack Operations** | 49 | 100% | ✅ Fully Validated |
| **Constants Pool** | 50 | 100% | ✅ Complete Management |
| **Bytecode Generation** | 48 | 100% | ✅ Fluent Interface Ready |

### 🎯 **Quality Indicators**
- **Coverage Depth**: Comprehensive edge case testing including boundary values
- **Assertion Quality**: Meaningful validation criteria with specific expected results
- **Error Scenarios**: Proper exception testing and graceful failure handling
- **Performance**: Baseline characteristics established for regression detection

### 🚀 **Test Phases Progress**
```
Phase 1: Core Infrastructure   ✅ 43 tests (100% pass)
Phase 2: Values System         ✅ 67 tests (100% pass)
Phase 3: Stack Operations      ✅ 49 tests (100% pass)
Phase 4: Constants Pool        ✅ 50 tests (100% pass)
Phase 5: Bytecode Generation   ✅ 48 tests (100% pass)
Integration Testing            ⏳ Planned Q2 2025
Performance Benchmarks         ⏳ Planned Q2 2025
```

### 📊 **Test Execution**
Run the comprehensive test suite:
```bash
# Execute all tests with custom logger
JetVMTests.exe

# Example output:
# ================================================================================
#                            🚀 JETVM TEST SUITE                            
# ================================================================================
# 📦 JetVM.Test.Core.TTestJetVMCore
# ✓ TestVMCreationDefault
# ✓ TestVMCreationWithValidationLevels
# ✓ TestBasicExecution
# [... 257 total tests across 5 fixtures ...]
# ================================================================================
#                            ✅ ALL TESTS PASSED
# ================================================================================
# Tests Found: 257 | Tests Passed: 257 | Duration: 0.069s
```

**See [TEST-REPORT.md](TEST-REPORT.md) for detailed analysis and performance metrics.**

## 📦 Installation

### Prerequisites
- **Delphi XE2** or later (requires modern generics, Unicode, and 64-bit support)
- **Tested with**: Delphi 12 on Windows 11 (24H2)
- **Platform Support**: Windows (tested and supported)
- **Dependencies**: None (pure Delphi implementation)

### Setup
1. **Clone the repository:**
   ```bash
   git clone https://github.com/tinyBigGAMES/JetVM.git
   cd JetVM
   ```

2. **Add to your Delphi project:**
   - Add `JetVM.pas` to your project
   - Include `JetVM.Defines.inc` in your project path
   - Add `JetVM` to your uses clause

3. **Optional: Include test framework:**
   ```pascal
   // For comprehensive testing (optional)
   uses
     JetVM.Test.Core,
     JetVM.Test.Values,
     JetVM.Test.Logger;  // Custom DUnitX logger
   ```

4. **Verify installation:**
   ```pascal
   // Quick verification
   var LVM := TJetVM.Create(vlBasic);
   try
     LVM.LoadInt(42).Stop().Execute();
     Assert(LVM.PopValue().IntValue = 42);
   finally
     LVM.Free;
   end;
   ```

## 📚 Documentation Overview

### Core Classes & Interfaces

#### **`TJetVM`** - Main Virtual Machine
```pascal
// Essential Methods
procedure Execute();              // Run the VM
procedure Step();                 // Single-step execution
procedure Reset();                // Reset VM state
procedure Finalize();             // Finalize bytecode

// State Access
function GetPC(): Integer;        // Program Counter
function GetSP(): Integer;        // Stack Pointer
function IsRunning(): Boolean;    // Execution state

// Stack Operations
procedure PushValue(const AValue: TJetValue);
function PopValue(): TJetValue;
function PeekValue(const AOffset: Integer = 0): TJetValue;
```

#### **`TJetValue`** - Tagged Union Type System
```pascal
// Value Types
TJetValueType = (jvtInt, jvtUInt, jvtStr, jvtBool, jvtPointer, 
                jvtArrayInt, jvtArrayUInt, jvtArrayStr, jvtArrayBool);

// Factory Methods
function MakeIntConstant(const AValue: Int64): TJetValue;
function MakeStrConstant(const AValue: string): TJetValue;
// ... additional factory methods
```

#### **`TJetFunctionRegistry`** - Function Management
```pascal
// Function Registration
function RegisterNativeFunction(const AName: string; 
  const AProc: TJetNativeFunction; 
  const AParamTypes: array of TJetValueType;
  const AReturnType: TJetValueType): Integer;
```

### Instruction Set Categories

| Category | Instructions | Description | Examples |
|----------|-------------|-------------|----------|
| **Load/Store** | `LoadInt`, `LoadStr`, `StoreLocal`, `StoreGlobal` | Data movement | Variable access |
| **Arithmetic** | `AddInt`, `SubInt`, `MulInt`, `DivInt`, `ModInt` | Math operations | Calculations |
| **Comparison** | `EqInt`, `LtInt`, `GtInt`, `EqStr`, `LtStr` | Value comparisons | Conditionals |
| **Control Flow** | `Jump`, `JumpTrue`, `JumpFalse`, `Call`, `Return` | Program flow | Loops, functions |
| **String Ops** | `ConcatStr`, `LenStr`, `UpperStr`, `LowerStr` | String manipulation | Text processing |
| **Memory** | `Alloc`, `FreeMem`, `MemCopy`, `LoadPtrInt` | Memory management | Pointer operations |
| **Arrays** | `ArrayGet`, `ArraySet`, `ArrayLength` | Array operations | Data structures |
| **Functions** | `CallFunction`, `RegisterNativeFunction` | Function calls | Native integration |

## 🤝 Contributing

We welcome contributions! Our codebase maintains **100% test coverage** and **enterprise-grade quality**.

### 🚀 **Quick Contribution Guide**

1. **Fork & Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/JetVM.git
   cd JetVM
   ```

2. **Follow Our Standards** _(See [DEVELOPER-GUIDE.md](DEVELOPER-GUIDE.md) Section 10)_
   ```pascal
   // Delphi Conventions (CRITICAL)
   var
     LValue: TJetValue;     // Local variables start with 'L'
     LResult: Integer;      // Each variable on separate line
   
   procedure MyProc(const AParam: string);  // Parameters start with 'A'
   ```

3. **Add Comprehensive Tests**
   ```pascal
   // Follow existing test patterns
   [Test]
   procedure TestYourNewFeature();
   begin
     Assert.AreEqual(Expected, Actual, 'Meaningful error message');
   end;
   ```

4. **Ensure Quality**
   ```bash
   # All tests must pass
   JetVMTests.exe
   # Expected: 100% pass rate maintained
   ```

### 📋 **Coding Standards**
- **Naming**: `L` prefix for locals, `A` prefix for parameters
- **Declarations**: Each variable on separate line, no inline `var`
- **Parameters**: Always `const` unless `var`/`out` needed
- **Testing**: Comprehensive tests for all new functionality
- **Documentation**: Update relevant guides and inline docs

### 🎯 **Contribution Areas**
- 🔧 **Core Features**: New opcodes, optimization improvements
- 📚 **Documentation**: Examples, tutorials, API documentation
- 🧪 **Testing**: Additional test cases, performance benchmarks
- 🎨 **Tooling**: Development utilities, debugging aids
- 🌍 **Examples**: Real-world usage demonstrations

### 🌍 **Platform Testing Needed**
- 🪟 **Windows**: ✅ Fully supported and tested
- 🐧 **Linux**: ❓ Community testing welcome  
- 🍎 **macOS**: ❓ Community testing welcome

*Help us expand platform support by testing JetVM on Linux/macOS and reporting results! Since JetVM uses pure Delphi code, it may work on other platforms but needs validation.*

### 🏆 **Contributors**

<a href="https://github.com/tinyBigGAMES/JetVM/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=tinyBigGAMES/JetVM&max=500&columns=20&anon=1" />
</a>

*Join our growing community of developers building the future of Delphi scripting!*

## 📄 License

This project is licensed under the **BSD 3-Clause License** - see the [LICENSE](LICENSE) file for details.

```
BSD 3-Clause License

Copyright © 2025-present tinyBigGAMES™ LLC
All Rights Reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice
2. Redistributions in binary form must reproduce the above copyright notice
3. Neither the name of the copyright holder nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.
```

## 📞 Support & Community

### 📚 **Documentation & Resources**
- 📖 **[DEVELOPER-GUIDE.md](DEVELOPER-GUIDE.md)** - 12-section comprehensive development guide
- 📊 **[TEST-REPORT.md](TEST-REPORT.md)** - Current test coverage & performance metrics
- 🔧 **API Reference** - Inline documentation in `JetVM.pas`
- 📋 **Examples** - Real-world usage patterns in test suites

### 💬 **Community Channels**
- 🐛 **Issues**: [GitHub Issues](https://github.com/tinyBigGAMES/JetVM/issues) - Bug reports & feature requests
- 💬 **Discussions**: [GitHub Discussions](https://github.com/tinyBigGAMES/JetVM/discussions) - General questions & ideas
- 💬 **Discord**: [Join our community](https://discord.gg/tPWjMwK) - Real-time chat & support
- 🐦 **Bluesky**: [@tinybiggames.com](https://bsky.app/profile/tinybiggames.com) - Updates & announcements

### ❓ **Frequently Asked Questions**

**Q: What Delphi versions are supported?**  
A: Delphi XE2 (2012) or later. Requires modern generics support and 64-bit compilation capabilities. Actively tested with Delphi 12 on Windows 11 (24H2).

**Q: What platforms are supported?**  
A: Currently Windows only (actively developed and tested). While JetVM uses pure Delphi code that may work on Linux/macOS, these platforms are untested and unsupported. Community testing and feedback for other platforms is welcome.

**Q: How does performance compare to other VMs?**  
A: Current benchmarks show sub-millisecond VM creation and microsecond-level value operations (0.0003s average per test). Comprehensive performance benchmarking is planned for Q2 2025. See [TEST-REPORT.md](TEST-REPORT.md) for current measured performance data.

**Q: Is JetVM suitable for production use?**  
A: Yes! Core infrastructure has 100% test coverage and zero detected defects.

**Q: Can I integrate my existing Delphi functions?**  
A: Absolutely! Native function integration is a core feature with simple registration.

**Q: What's the memory overhead?**  
A: Minimal. Uses native Delphi types and tagged unions for efficiency.

## 🌟 Acknowledgments

- 💖 **Built with love** for the Delphi community
- 🎯 **Inspired by** modern VM design principles (V8, LuaJIT, .NET CLR)
- 🚀 **Focused on** practical, real-world usage scenarios
- 🏆 **Committed to** enterprise-grade quality and performance
- 🌍 **Supporting** the future of Delphi application development

### 🎖️ **Special Thanks**
- **Delphi Community** - For continued support and feedback
- **Beta Testers** - Early adopters who helped shape JetVM
- **Contributors** - Everyone who has submitted issues, PRs, and improvements

---

**Made with ❤️ by [tinyBigGAMES™](https://github.com/tinyBigGAMES)**

*Empowering Delphi developers with high-performance, safe scripting capabilities.* 🚀