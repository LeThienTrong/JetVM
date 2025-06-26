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

--------------------------------------------------------------------------------

 📖 For comprehensive documentation, examples, and usage guide, see:
    DEVELOPER-GUIDE.md

 🚀 Quick Start:
    LVM := TJetVM.Create(vlBasic);
    LVM.LoadInt(42).Stop().Execute();
    LResult := LVM.PopValue();
    LVM.Free();

 🎯 Key Features:
    • Stack-based execution with fluent interface
    • Tagged union value system (TJetValue)
    • Multiple validation levels (vlNone to vlSafe)
    • Native Delphi function integration
    • Pascal-style parameter modes (const, var, out)
    • Comprehensive memory management
===============================================================================}

unit JetVM;

{$I JetVM.Defines.inc}

interface

uses
  System.SysUtils,
  System.Classes,
  System.StrUtils,
  System.TypInfo,
  System.Math;

type
  // Value types supported by JetVM
  TJetValueType = (
    jvtInt,      // Int64
    jvtUInt,     // UInt64
    jvtStr,      // string
    jvtBool,     // Boolean
    jvtPStr,     // PString
    jvtPBool,    // PBoolean
    jvtArrayInt, // array of Int64
    jvtArrayUInt,// array of UInt64
    jvtArrayStr, // array of string
    jvtArrayBool,// array of Boolean
    jvtPointer   // Generic pointer
  );

  // Tagged union for maximum performance with native Delphi types
  TJetValue = record
    ValueType: TJetValueType;
    
    // Managed types (outside variant record - RTL managed)
    StrValue: string;
    ArrayIntValue: array of Int64;
    ArrayUIntValue: array of UInt64;
    ArrayStrValue: array of string;
    ArrayBoolValue: array of Boolean;
    
    // Unmanaged types (in variant for space efficiency)
    case Integer of
      0: (IntValue: Int64);
      1: (UIntValue: UInt64);
      2: (BoolValue: Boolean);
      3: (PStrValue: PString);
      4: (PBoolValue: PBoolean);
      5: (PtrValue: Pointer);
  end;

  // Focused opcode set for C-like/Pascal-syntax language
  TJetOpCode = (
    // === LOAD/STORE OPERATIONS ===
    OP_LOAD_CONST,           // Load from constants pool
    OP_LOAD_LOCAL,           // Load local variable
    OP_STORE_LOCAL,          // Store to local variable
    OP_LOAD_GLOBAL,          // Load global/module variable
    OP_STORE_GLOBAL,         // Store to global/module variable
    OP_LOAD_PARAM,           // Load function parameter
    
    // === INTEGER ARITHMETIC ===
    OP_ADD_INT, OP_SUB_INT, OP_MUL_INT, OP_DIV_INT, OP_MOD_INT, OP_NEG_INT,
    OP_INC_INT, OP_DEC_INT, OP_POST_INC_INT, OP_POST_DEC_INT,
    
    // === UNSIGNED INTEGER ARITHMETIC ===
    OP_ADD_UINT, OP_SUB_UINT, OP_MUL_UINT, OP_DIV_UINT, OP_MOD_UINT,
    OP_INC_UINT, OP_DEC_UINT, OP_POST_INC_UINT, OP_POST_DEC_UINT,
    
    // === BITWISE OPERATIONS ===
    OP_AND_INT, OP_OR_INT, OP_XOR_INT, OP_NOT_INT, OP_SHL_INT, OP_SHR_INT,
    OP_AND_UINT, OP_OR_UINT, OP_XOR_UINT, OP_NOT_UINT, OP_SHL_UINT, OP_SHR_UINT,
    
    // === COMPARISONS ===
    OP_EQ_INT, OP_NE_INT, OP_LT_INT, OP_LE_INT, OP_GT_INT, OP_GE_INT,
    OP_EQ_UINT, OP_NE_UINT, OP_LT_UINT, OP_LE_UINT, OP_GT_UINT, OP_GE_UINT,
    OP_EQ_STR, OP_NE_STR, OP_LT_STR, OP_LE_STR, OP_GT_STR, OP_GE_STR,
    OP_EQ_BOOL, OP_NE_BOOL, OP_EQ_PTR, OP_NE_PTR,
    
    // === BOOLEAN LOGIC ===
    OP_AND_BOOL, OP_OR_BOOL, OP_NOT_BOOL,
    
    // === STRING OPERATIONS (Native Delphi) ===
    OP_STR_CONCAT, OP_STR_LENGTH, OP_STR_COPY, OP_STR_POS,
    OP_STR_UPPERCASE, OP_STR_LOWERCASE, OP_STR_TRIM,
    
    // === POINTER OPERATIONS ===
    OP_ADDR_OF, OP_DEREF_PTR, OP_PTR_ADD, OP_PTR_SUB,
    OP_DEREF_PSTR, OP_DEREF_PBOOL, OP_NULL_CHECK,

    // === TYPED POINTER OPERATIONS ===
    OP_LOAD_PTR_INT, OP_LOAD_PTR_UINT, OP_LOAD_PTR_STR, OP_LOAD_PTR_BOOL,
    OP_STORE_PTR_INT, OP_STORE_PTR_UINT, OP_STORE_PTR_STR, OP_STORE_PTR_BOOL,

    // === OFFSET POINTER OPERATIONS (CONVENIENCE) ===
    OP_LOAD_OFFSET_INT, OP_LOAD_OFFSET_UINT, OP_LOAD_OFFSET_STR, OP_LOAD_OFFSET_BOOL,
    OP_STORE_OFFSET_INT, OP_STORE_OFFSET_UINT, OP_STORE_OFFSET_STR, OP_STORE_OFFSET_BOOL,

    // === FIXED ARRAY OPERATIONS ===
    OP_ARRAY_DECLARE_FIXED, OP_ARRAY_GET_FIXED, OP_ARRAY_SET_FIXED,
    OP_ARRAY_ADDR_FIXED, OP_ARRAY_BOUNDS_FIXED,
    
    // === DYNAMIC ARRAY OPERATIONS ===
    OP_ARRAY_DECLARE_DYNAMIC, OP_ARRAY_SETLENGTH, OP_ARRAY_GET_DYNAMIC,
    OP_ARRAY_SET_DYNAMIC, OP_ARRAY_LENGTH, OP_ARRAY_HIGH, OP_ARRAY_LOW,
    
    // === CONTROL FLOW ===
    OP_JMP, OP_JMP_TRUE, OP_JMP_FALSE, OP_JMP_ZERO, OP_JMP_NOT_ZERO,
    OP_CALL_FUNC, OP_RET, OP_RET_VALUE, OP_ENTER_SCOPE, OP_EXIT_SCOPE,
    
    // === PASCAL PARAMETER MODES ===
    // const parameters (read-only)
    OP_PARAM_CONST_INT, OP_PARAM_CONST_UINT, OP_PARAM_CONST_STR,
    OP_PARAM_CONST_BOOL, OP_PARAM_CONST_PTR, OP_PARAM_CONST_ARRAY,
    
    // var parameters (by reference)
    OP_PARAM_VAR_INT, OP_PARAM_VAR_UINT, OP_PARAM_VAR_STR,
    OP_PARAM_VAR_BOOL, OP_PARAM_VAR_PTR, OP_PARAM_VAR_ARRAY,
    
    // out parameters (write-only)
    OP_PARAM_OUT_INT, OP_PARAM_OUT_UINT, OP_PARAM_OUT_STR,
    OP_PARAM_OUT_BOOL, OP_PARAM_OUT_PTR, OP_PARAM_OUT_ARRAY,
    
    // === MEMORY MANAGEMENT ===
    OP_ALLOC, OP_FREE, OP_MEMCPY, OP_MEMSET,
    
    // === TYPE CONVERSION ===
    OP_INT_TO_UINT, OP_UINT_TO_INT, OP_INT_TO_STR, OP_UINT_TO_STR,
    OP_STR_TO_INT, OP_STR_TO_UINT, OP_BOOL_TO_STR, OP_STR_TO_BOOL,
    OP_PTR_TO_INT, OP_INT_TO_PTR,
    
    // === STACK OPERATIONS ===
    OP_PUSH, OP_POP, OP_DUP, OP_SWAP, OP_ROT,

    // === FUNCTION OPERATIONS ===
    OP_CALL_FUNC_BY_NAME,        // Call function by registry index
    OP_CALL_NATIVE,              // Call native Delphi function
    OP_SETUP_CALL,               // Setup function call with parameter count
    OP_PUSH_PARAM,               // Push parameter for function call
    OP_DECLARE_FUNCTION,         // Declare a new function
    OP_BEGIN_FUNCTION,           // Mark function start
    OP_END_FUNCTION,             // Mark function end

    // === VM CONTROL ===
    OP_NOP, OP_HALT

  );

  // Exception for VM runtime errors
  EJetVMError = class(Exception);

  // Validation levels for development vs production
  TJetVMValidationLevel = (
    vlNone,        // Maximum speed - no checks
    vlBasic,       // Only emit-time validation
    vlDevelopment, // Stack tracking, type hints
    vlSafe         // Runtime type checking
  );

  // Parameter modes for Pascal-style parameters
  TJetParamMode = (pmConst, pmVar, pmOut);

  // Label information for forward references
  TLabelInfo = record
    Address: Integer;
    PatchList: array of Integer;
    IsBound: Boolean;
  end;

  // Stack type tracker for development mode
  TStackTypeTracker = class
  private
    FExpectedTypes: array of TJetValueType;
    FDepth: Integer;
  public
    procedure Push(const AType: TJetValueType);
    function Pop(const AType: TJetValueType): Boolean;
    procedure Clear();
    function GetDepth(): Integer;
    function CheckHasAtLeast(const ACount: Integer; const AType: TJetValueType): Boolean;
  end;

  // Forward declaration
  TJetVM = class;

  // Native function callback type
  TJetNativeFunction = procedure(const AVM: TJetVM);

  // Function signature for registry
  TJetFunctionSignature = record
    Name: string;
    Address: Integer;                // Bytecode address for VM functions
    NativeProc: TJetNativeFunction;  // Native procedure pointer
    ParamTypes: array of TJetValueType;
    ParamModes: array of TJetParamMode;
    ReturnType: TJetValueType;
    ParamCount: Integer;
    IsNative: Boolean;
    IsVoid: Boolean;                 // True if function returns no value
  end;

  // Stack frame for function calls
  TStackFrame = record
    ReturnAddress: Integer;
    BasePointer: Integer;
    LocalVarCount: Integer;
    ParamCount: Integer;
    FunctionIndex: Integer;
  end;

  // Function registry for managing functions
  TJetFunctionRegistry = class
  private
    FFunctions: array of TJetFunctionSignature;
    FFunctionCount: Integer;
  public
    constructor Create();
    destructor Destroy(); override;
    function RegisterFunction(const ASignature: TJetFunctionSignature): Integer;
    function FindFunction(const AName: string): Integer;
    function GetFunction(const AIndex: Integer): TJetFunctionSignature;
    function GetFunctionCount(): Integer;
  end;

  // Ultra-fast virtual machine class
  TJetVM = class
  private
    // === HOT EXECUTION DATA (cache-friendly layout) ===
    FPC: Integer;                    // Program counter
    FSP: Integer;                    // Stack pointer
    FBP: Integer;                    // Base pointer (for local variables)
    FRunning: Boolean;               // Execution state
    
    // === CORE DATA STRUCTURES ===
    //FBytecode: array of Byte;        // Instruction stream
    FBytecode: TArray<Byte>;
    FStack: array of TJetValue;      // Operand stack
    FConstants: array of TJetValue;  // Constants pool
    FLocals: array of TJetValue;     // Local variables
    FGlobals: array of TJetValue;    // Global variables
    FCallStack: array of Integer;    // Return addresses
    FCallSP: Integer;                // Call stack pointer

    // === FUNCTION MANAGEMENT ===
    FFunctionRegistry: TJetFunctionRegistry;  // Function registry
    FStackFrames: array of TStackFrame;       // Function call stack frames
    FFrameSP: Integer;                        // Stack frame pointer
    FCurrentFunction: Integer;                // Currently executing function index
    FCallDepth: Integer;                      // Function call nesting depth
    
    // === BYTECODE GENERATION ===
    FBytecodePos: Integer;           // Current position during generation
    FFinalized: Boolean;             // Whether bytecode is finalized
    FLabels: array of TLabelInfo;    // Label management
    FLabelCount: Integer;            // Number of labels created
    FValidationLevel: TJetVMValidationLevel; // Validation mode
    FStackTracker: TStackTypeTracker; // For development mode

    // === BOUNDS CHECKING (Development/Safe modes only) ===
    FBoundsTable: array of record
      Ptr: Pointer;
      Size: Integer;
    end;
    FBoundsCount: Integer;           // Number of tracked allocations
    
    // === EXECUTION METHODS ===
    procedure ExecuteCore(); inline;
    function ReadInt32(): Integer; inline;
    {$HINTS OFF}
    function ReadInt16(): Word; inline;
    function ReadByte(): Byte; inline;
    {$HINTS ON}

    // === ARITHMETIC HELPERS ===
    procedure ExecuteIntArithmetic(const AOpCode: TJetOpCode); inline;
    procedure ExecuteUIntArithmetic(const AOpCode: TJetOpCode); inline;
    procedure ExecuteIntBitwise(const AOpCode: TJetOpCode); inline;
    procedure ExecuteUIntBitwise(const AOpCode: TJetOpCode); inline;
    procedure ExecuteBooleanLogic(const AOpCode: TJetOpCode); inline;
    procedure ExecuteComparison(const AOpCode: TJetOpCode); inline;
    procedure ExecuteStringOp(const AOpCode: TJetOpCode); inline;
    procedure ExecuteFunctionOp(const AOpCode: TJetOpCode); inline;
    procedure CallNativeFunction(const AFunction: TJetFunctionSignature); inline;
    procedure CallVMFunction(const AFunction: TJetFunctionSignature); inline;
    procedure SetupStackFrame(); inline;
    procedure CleanupStackFrame(const AHasReturnValue: Boolean); inline;
    
    // === CONTROL FLOW ===
    procedure ExecuteJump(const AOpCode: TJetOpCode); inline;
    procedure ExecuteCall(const AOpCode: TJetOpCode); inline;
    procedure ExecuteReturn(const AOpCode: TJetOpCode); inline;
    procedure ExecuteScope(const AOpCode: TJetOpCode); inline;
    
    // === POINTER & ARRAY OPERATIONS ===
    procedure ExecutePointerOp(const AOpCode: TJetOpCode); inline;
    procedure ExecuteArrayOp(const AOpCode: TJetOpCode); inline;
    procedure ExecuteTypeConversion(const AOpCode: TJetOpCode); inline;
    procedure ExecuteParameterOp(const AOpCode: TJetOpCode); inline;
    procedure ExecuteMemoryOp(const AOpCode: TJetOpCode); inline;
    
    // === BYTECODE GENERATION HELPERS ===
    procedure EmitByte(const AValue: Byte); inline;
    procedure EmitInt32(const AValue: Integer); inline;
    procedure EmitOpCode(const AOpCode: TJetOpCode); inline;
    procedure CheckCanEmit(); inline;
    procedure PatchLabel(const ALabelId: Integer); inline;
    function AddConstantInternal(const AValue: TJetValue): Integer;
    
    // === VALIDATION HELPERS ===
    procedure ValidateStackTypes(const ARequired: Integer; const AType: TJetValueType); inline;
    
    // === UTILITY ===
    procedure RaiseVMError(const AMessage: string);
    procedure CheckStackUnderflow(const ARequired: Integer); inline;
    procedure CheckStackOverflow(); inline;

    // === BOUNDS CHECKING HELPERS ===
    procedure RegisterAllocation(const APtr: Pointer; const ASize: Integer); inline;
    procedure UnregisterAllocation(const APtr: Pointer); inline;
    //function GetAllocationSize(const APtr: Pointer): Integer; inline;
    procedure CheckBounds(const APtr: Pointer; const AOffset, AAccessSize: Integer); inline;
    procedure ClearBoundsTable(); inline;

  public
    constructor Create(const AValidationLevel: TJetVMValidationLevel = vlBasic);
    destructor Destroy(); override;

    // === BOUNDS CHECKING HELPERS ===
    function GetAllocationSize(const APtr: Pointer): Integer; inline;

    // === BYTECODE MANAGEMENT ===
    procedure LoadBytecode(const ABytecode: array of Byte);
    procedure AddConstant(const AValue: TJetValue);
    function MakeIntConstant(const AValue: Int64): TJetValue;
    function MakeUIntConstant(const AValue: UInt64): TJetValue;
    function MakeStrConstant(const AValue: string): TJetValue;
    function MakeBoolConstant(const AValue: Boolean): TJetValue;
    function MakePtrConstant(const AValue: Pointer): TJetValue;

    // === STACK OPERATIONS ===
    procedure PushValue(const AValue: TJetValue); inline;
    function PopValue(): TJetValue; inline;
    function PeekValue(const AOffset: Integer = 0): TJetValue; inline;

    // === EXECUTION CONTROL ===
    procedure Execute();
    procedure Reset();
    procedure Step();
    procedure Finalize(); // Finalize bytecode for execution
    
    // === FLUENT LOAD OPERATIONS ===
    function LoadInt(const AValue: Int64): TJetVM;
    function LoadUInt(const AValue: UInt64): TJetVM;
    function LoadStr(const AValue: string): TJetVM;
    function LoadBool(const AValue: Boolean): TJetVM;
    function LoadConst(const AIndex: Integer): TJetVM;
    function LoadLocal(const AIndex: Integer): TJetVM;
    function LoadGlobal(const AIndex: Integer): TJetVM;
    function LoadParam(const AIndex: Integer): TJetVM;
    
    // === FLUENT STORE OPERATIONS ===
    function StoreLocal(const AIndex: Integer): TJetVM;
    function StoreGlobal(const AIndex: Integer): TJetVM;
    
    // === FLUENT INTEGER ARITHMETIC ===
    function AddInt(): TJetVM;
    function SubInt(): TJetVM;
    function MulInt(): TJetVM;
    function DivInt(): TJetVM;
    function ModInt(): TJetVM;
    function NegInt(): TJetVM;
    function IncInt(): TJetVM;
    function DecInt(): TJetVM;
    function PostIncInt(): TJetVM;
    function PostDecInt(): TJetVM;
    
    // === FLUENT UNSIGNED INTEGER ARITHMETIC ===
    function AddUInt(): TJetVM;
    function SubUInt(): TJetVM;
    function MulUInt(): TJetVM;
    function DivUInt(): TJetVM;
    function ModUInt(): TJetVM;
    function IncUInt(): TJetVM;
    function DecUInt(): TJetVM;
    function PostIncUInt(): TJetVM;
    function PostDecUInt(): TJetVM;
    
    // === FLUENT INTEGER BITWISE ===
    function AndInt(): TJetVM;
    function OrInt(): TJetVM;
    function XorInt(): TJetVM;
    function NotInt(): TJetVM;
    function ShlInt(): TJetVM;
    function ShrInt(): TJetVM;
    
    // === FLUENT UNSIGNED INTEGER BITWISE ===
    function AndUInt(): TJetVM;
    function OrUInt(): TJetVM;
    function XorUInt(): TJetVM;
    function NotUInt(): TJetVM;
    function ShlUInt(): TJetVM;
    function ShrUInt(): TJetVM;
    
    // === FLUENT INTEGER COMPARISONS ===
    function EqInt(): TJetVM;
    function NeInt(): TJetVM;
    function LtInt(): TJetVM;
    function LeInt(): TJetVM;
    function GtInt(): TJetVM;
    function GeInt(): TJetVM;
    
    // === FLUENT UNSIGNED INTEGER COMPARISONS ===
    function EqUInt(): TJetVM;
    function NeUInt(): TJetVM;
    function LtUInt(): TJetVM;
    function LeUInt(): TJetVM;
    function GtUInt(): TJetVM;
    function GeUInt(): TJetVM;
    
    // === FLUENT STRING OPERATIONS ===
    function ConcatStr(): TJetVM;
    function LenStr(): TJetVM;
    function CopyStr(): TJetVM;
    function PosStr(): TJetVM;
    function UpperStr(): TJetVM;
    function LowerStr(): TJetVM;
    function TrimStr(): TJetVM;
    function EqStr(): TJetVM;
    function NeStr(): TJetVM;
    function LtStr(): TJetVM;
    function LeStr(): TJetVM;
    function GtStr(): TJetVM;
    function GeStr(): TJetVM;
    
    // === FLUENT BOOLEAN OPERATIONS ===
    function AndBool(): TJetVM;
    function OrBool(): TJetVM;
    function NotBool(): TJetVM;
    function EqBool(): TJetVM;
    function NeBool(): TJetVM;
    
    // === FLUENT POINTER OPERATIONS ===
    function AddrOf(): TJetVM;
    function DerefPtr(): TJetVM;
    function PtrAdd(): TJetVM;
    function PtrSub(): TJetVM;
    function DerefPStr(): TJetVM;
    function DerefPBool(): TJetVM;
    function NullCheck(): TJetVM;
    function EqPtr(): TJetVM;
    function NePtr(): TJetVM;

// === FLUENT TYPED POINTER OPERATIONS ===
    function LoadPtrInt(): TJetVM;
    function LoadPtrUInt(): TJetVM;
    function LoadPtrStr(): TJetVM;
    function LoadPtrBool(): TJetVM;
    function StorePtrInt(): TJetVM;
    function StorePtrUInt(): TJetVM;
    function StorePtrStr(): TJetVM;
    function StorePtrBool(): TJetVM;

    // === FLUENT OFFSET POINTER OPERATIONS ===
    function LoadOffsetInt(): TJetVM;
    function LoadOffsetUInt(): TJetVM;
    function LoadOffsetStr(): TJetVM;
    function LoadOffsetBool(): TJetVM;
    function StoreOffsetInt(): TJetVM;
    function StoreOffsetUInt(): TJetVM;
    function StoreOffsetStr(): TJetVM;
    function StoreOffsetBool(): TJetVM;

    
    // === FLUENT ARRAY OPERATIONS ===
    function DeclareFixedArray(const ALowerBound, AUpperBound: Integer; const AElementType: TJetValueType): TJetVM;
    function DeclareDynamicArray(const AElementType: TJetValueType): TJetVM;
    function ArraySetLength(): TJetVM;
    function ArrayGet(): TJetVM;
    function ArraySet(): TJetVM;
    function ArrayLength(): TJetVM;
    function ArrayHigh(): TJetVM;
    function ArrayLow(): TJetVM;
    function ArrayAddr(): TJetVM;
    
    // === FLUENT TYPE CONVERSION ===
    function IntToUInt(): TJetVM;
    function UIntToInt(): TJetVM;
    function IntToStr(): TJetVM;
    function UIntToStr(): TJetVM;
    function StrToInt(): TJetVM;
    function StrToUInt(): TJetVM;
    function BoolToStr(): TJetVM;
    function StrToBool(): TJetVM;
    function PtrToInt(): TJetVM;
    function IntToPtr(): TJetVM;
    
    // === FLUENT STACK OPERATIONS ===
    function Push(): TJetVM;
    function Pop(): TJetVM;
    function Dup(): TJetVM;
    function Swap(): TJetVM;
    function Rot(): TJetVM;
    
    // === FLUENT LABEL MANAGEMENT ===
    function CreateLabel(): Integer;
    function BindLabel(const ALabelId: Integer): TJetVM;
    
    // === FLUENT CONTROL FLOW ===// === FLUENT FUNCTION OPERATIONS ===
    function CallFunction(const AName: string): TJetVM;
    function CallFunctionByIndex(const AIndex: Integer): TJetVM;
    function SetupCall(const AParamCount: Integer): TJetVM;
    function PushParam(): TJetVM;
    function DeclareFunction(const AName: string): TJetVM;
    function BeginFunction(): TJetVM;
    function EndFunction(): TJetVM;

    // === FLUENT CONTROL FLOW ===
    function Jump(const ALabelId: Integer): TJetVM;
    function JumpTrue(const ALabelId: Integer): TJetVM;
    function JumpFalse(const ALabelId: Integer): TJetVM;
    function JumpZero(const ALabelId: Integer): TJetVM;
    function JumpNotZero(const ALabelId: Integer): TJetVM;
    function Call(const ALabelId: Integer): TJetVM;
    function Return(): TJetVM;
    function ReturnValue(): TJetVM;
    function EnterScope(): TJetVM;
    function ExitScope(): TJetVM;
    
    // === FLUENT PARAMETER OPERATIONS ===
    function ParamConstInt(): TJetVM;
    function ParamConstUInt(): TJetVM;
    function ParamConstStr(): TJetVM;
    function ParamConstBool(): TJetVM;
    function ParamConstPtr(): TJetVM;
    function ParamVarInt(): TJetVM;
    function ParamVarUInt(): TJetVM;
    function ParamVarStr(): TJetVM;
    function ParamVarBool(): TJetVM;
    function ParamVarPtr(): TJetVM;
    function ParamOutInt(): TJetVM;
    function ParamOutUInt(): TJetVM;
    function ParamOutStr(): TJetVM;
    function ParamOutBool(): TJetVM;
    function ParamOutPtr(): TJetVM;
    
    // === FLUENT MEMORY OPERATIONS ===
    function Alloc(): TJetVM;
    function FreeMem(): TJetVM;
    function MemCopy(): TJetVM;
    function MemSet(): TJetVM;

    // === FUNCTION MANAGEMENT ===
    function RegisterNativeFunction(const AName: string; const AProc: TJetNativeFunction;
      const AParamTypes: array of TJetValueType; const AReturnType: TJetValueType): Integer; overload;
    function RegisterNativeFunction(const AName: string; const AProc: TJetNativeFunction;
      const AParamTypes: array of TJetValueType): Integer; overload; // Void function
    function DeclareVMFunction(const AName: string; const AAddress: Integer;
      const AParamTypes: array of TJetValueType; const AReturnType: TJetValueType): Integer; overload;
    function DeclareVMFunction(const AName: string; const AAddress: Integer;
      const AParamTypes: array of TJetValueType): Integer;  overload; // Void function
    function GetFunctionIndex(const AName: string): Integer;

    // === FLUENT VM CONTROL ===
    function Nop(): TJetVM;
    function Stop(): TJetVM;
    
    // === STATE ACCESS ===
    function GetPC(): Integer;
    function GetSP(): Integer;
    function GetStackValue(const AIndex: Integer): TJetValue;
    function GetConstant(const AIndex: Integer): TJetValue;
    function IsRunning(): Boolean;
    function GetValidationLevel(): TJetVMValidationLevel;
    procedure SetValidationLevel(const ALevel: TJetVMValidationLevel);

    //
    function BytecodeSize(): UInt64;

    // === ALIGNMENT HELPERS ===
    function GetTypeSize(const AType: TJetValueType): Integer;
    function GetTypeAlignment(const AType: TJetValueType): Integer;
    function AlignOffset(const AOffset, AAlignment: Integer): Integer;
    function CalculateStructSize(const AFieldTypes: array of TJetValueType): Integer;
    
    // === DEBUGGING ===
    procedure DumpStack();
    procedure DumpConstants();
    procedure DumpFunctionRegistry();
    function DisassembleInstruction(const APC: Integer): string;
    function GetCallDepth(): Integer;
    function GetCurrentFunction(): Integer;
  end;

implementation

const
  DEFAULT_STACK_SIZE = 4096;
  DEFAULT_LOCALS_SIZE = 1024;
  DEFAULT_GLOBALS_SIZE = 1024;
  DEFAULT_CALL_STACK_SIZE = 256;
  DEFAULT_CONSTANTS_SIZE = 512;

{ TStackTypeTracker }

procedure TStackTypeTracker.Push(const AType: TJetValueType);
begin
  if FDepth >= Length(FExpectedTypes) then
  begin
    if Length(FExpectedTypes) = 0 then
      SetLength(FExpectedTypes, 8) // Initial capacity
    else
      SetLength(FExpectedTypes, Length(FExpectedTypes) * 2);
  end;
  FExpectedTypes[FDepth] := AType;
  Inc(FDepth);
end;

function TStackTypeTracker.Pop(const AType: TJetValueType): Boolean;
begin
  Result := False;
  if FDepth > 0 then
  begin
    Dec(FDepth);
    Result := FExpectedTypes[FDepth] = AType;
  end;
end;

procedure TStackTypeTracker.Clear();
begin
  FDepth := 0;
end;

function TStackTypeTracker.GetDepth(): Integer;
begin
  Result := FDepth;
end;

function TStackTypeTracker.CheckHasAtLeast(const ACount: Integer; const AType: TJetValueType): Boolean;
var
  LIndex: Integer;
begin
  Result := False;
  if FDepth >= ACount then
  begin
    Result := True;
    for LIndex := FDepth - ACount to FDepth - 1 do
      if FExpectedTypes[LIndex] <> AType then
      begin
        Result := False;
        Break;
      end;
  end;
end;

{ TJetVM }

constructor TJetVM.Create(const AValidationLevel: TJetVMValidationLevel = vlBasic);
begin
  inherited Create();
  
  FValidationLevel := AValidationLevel;
  FStackTracker := TStackTypeTracker.Create();

  FStackTracker := TStackTypeTracker.Create();
  FFunctionRegistry := TJetFunctionRegistry.Create();
  FFrameSP := 0;
  FCurrentFunction := -1;
  FCallDepth := 0;

  // Pre-allocate all data structures for maximum performance
  SetLength(FStack, DEFAULT_STACK_SIZE);
  SetLength(FLocals, DEFAULT_LOCALS_SIZE);
  SetLength(FGlobals, DEFAULT_GLOBALS_SIZE);
  SetLength(FCallStack, DEFAULT_CALL_STACK_SIZE);
  SetLength(FConstants, DEFAULT_CONSTANTS_SIZE);
  SetLength(FLabels, 64); // Initial label capacity
  
  Reset();
end;

destructor TJetVM.Destroy();
begin
  FStackTracker.Free();
  FFunctionRegistry.Free();
  inherited Destroy();
end;

procedure TJetVM.Reset();
begin
  FPC := 0;
  FSP := 0;
  FBP := 0;
  FCallSP := 0;
  FFrameSP := 0;
  FCurrentFunction := -1;
  FCallDepth := 0;
  FRunning := False;
  FBytecodePos := 0;
  FFinalized := False;
  FLabelCount := 0;
  if Assigned(FStackTracker) then
    FStackTracker.Clear();
  ClearBoundsTable();
end;

procedure TJetVM.LoadBytecode(const ABytecode: array of Byte);
var
  LIndex: Integer;
begin
  SetLength(FBytecode, Length(ABytecode));
  for LIndex := 0 to High(ABytecode) do
    FBytecode[LIndex] := ABytecode[LIndex];
  Reset();
end;

procedure TJetVM.AddConstant(const AValue: TJetValue);
var
  LNewLength: Integer;
begin
  LNewLength := Length(FConstants) + 1;
  SetLength(FConstants, LNewLength);
  FConstants[LNewLength - 1] := AValue;
end;

function TJetVM.MakeIntConstant(const AValue: Int64): TJetValue;
begin
  Result.ValueType := jvtInt;
  Result.IntValue := AValue;
end;

function TJetVM.MakeUIntConstant(const AValue: UInt64): TJetValue;
begin
  Result.ValueType := jvtUInt;
  Result.UIntValue := AValue;
end;

function TJetVM.MakeStrConstant(const AValue: string): TJetValue;
begin
  Result.ValueType := jvtStr;
  Result.StrValue := AValue;
end;

function TJetVM.MakeBoolConstant(const AValue: Boolean): TJetValue;
begin
  Result.ValueType := jvtBool;
  Result.BoolValue := AValue;
end;

function TJetVM.MakePtrConstant(const AValue: Pointer): TJetValue;
begin
  Result.ValueType := jvtPointer;
  Result.PtrValue := AValue;
end;

procedure TJetVM.Execute();
begin
  if not FFinalized then
    Finalize();
    
  FRunning := True;
  try
    ExecuteCore();
  except
    on E: Exception do
    begin
      FRunning := False;
      raise EJetVMError.CreateFmt('VM Error at PC=%d: %s', [FPC, E.Message]);
    end;
  end;
end;

{$R-}{$Q-} // Disable range/overflow checking for maximum speed
procedure TJetVM.ExecuteCore();
var
  LOpCode: TJetOpCode;
begin
  while FRunning and (FPC < Length(FBytecode)) do
  begin
    LOpCode := TJetOpCode(FBytecode[FPC]);
    Inc(FPC);
    
    case LOpCode of
      // === LOAD OPERATIONS ===
      OP_LOAD_CONST:
      begin
        PushValue(FConstants[ReadInt32()]);
      end;
      
      OP_LOAD_LOCAL:
      begin
        PushValue(FLocals[FBP + ReadInt32()]);
      end;
      
      OP_LOAD_GLOBAL:
      begin
        PushValue(FGlobals[ReadInt32()]);
      end;
      
      OP_LOAD_PARAM:
      begin
        PushValue(FLocals[ReadInt32()]);
      end;
      
      OP_STORE_LOCAL:
      begin
        FLocals[FBP + ReadInt32()] := PopValue();
      end;
      
      OP_STORE_GLOBAL:
      begin
        FGlobals[ReadInt32()] := PopValue();
      end;
      
      // === ARITHMETIC OPERATIONS ===
      OP_ADD_INT..OP_POST_DEC_INT:
        ExecuteIntArithmetic(LOpCode);
      
      OP_ADD_UINT..OP_POST_DEC_UINT:
        ExecuteUIntArithmetic(LOpCode);
      
      // === BITWISE OPERATIONS ===
      OP_AND_INT..OP_SHR_INT:
        ExecuteIntBitwise(LOpCode);
        
      OP_AND_UINT..OP_SHR_UINT:
        ExecuteUIntBitwise(LOpCode);
      
      // === BOOLEAN LOGIC ===
      OP_AND_BOOL..OP_NOT_BOOL:
        ExecuteBooleanLogic(LOpCode);
      
      // === COMPARISONS ===
      OP_EQ_INT..OP_GE_INT,
      OP_EQ_UINT..OP_GE_UINT,
      OP_EQ_STR..OP_GE_STR,
      OP_EQ_BOOL..OP_NE_BOOL,
      OP_EQ_PTR..OP_NE_PTR:
        ExecuteComparison(LOpCode);
      
      // === STRING OPERATIONS ===
      OP_STR_CONCAT..OP_STR_TRIM:
        ExecuteStringOp(LOpCode);
      
      // === POINTER OPERATIONS ===
      OP_ADDR_OF..OP_STORE_OFFSET_BOOL:
        ExecutePointerOp(LOpCode);

      // === ARRAY OPERATIONS ===
      OP_ARRAY_DECLARE_FIXED..OP_ARRAY_LOW:
        ExecuteArrayOp(LOpCode);

      // === CONTROL FLOW ===
      OP_JMP..OP_JMP_NOT_ZERO:
        ExecuteJump(LOpCode);
      
      OP_CALL_FUNC:
        ExecuteCall(LOpCode);
      
      OP_RET, OP_RET_VALUE:
        ExecuteReturn(LOpCode);
        
      OP_ENTER_SCOPE, OP_EXIT_SCOPE:
        ExecuteScope(LOpCode);
      
      // === PARAMETER OPERATIONS ===
      OP_PARAM_CONST_INT..OP_PARAM_OUT_ARRAY:
        ExecuteParameterOp(LOpCode);
      
      // === MEMORY OPERATIONS ===
      OP_ALLOC..OP_MEMSET:
        ExecuteMemoryOp(LOpCode);
      
      // === TYPE CONVERSION ===
      OP_INT_TO_UINT..OP_INT_TO_PTR:
        ExecuteTypeConversion(LOpCode);
      
      // === STACK OPERATIONS ===
      OP_PUSH:
      begin
        PushValue(PeekValue());
      end;
      
      OP_POP:
      begin
        PopValue();
      end;
      
      OP_DUP:
      begin
        PushValue(PeekValue());
      end;
      
      OP_SWAP:
      begin
        var LValue1 := PopValue();
        var LValue2 := PopValue();
        PushValue(LValue1);
        PushValue(LValue2);
      end;
      
      OP_ROT:
      begin
        var LValue1 := PopValue();
        var LValue2 := PopValue();
        var LValue3 := PopValue();
        PushValue(LValue2);
        PushValue(LValue1);
        PushValue(LValue3);
      end;

      // === FUNCTION OPERATIONS ===
      OP_CALL_FUNC_BY_NAME, OP_CALL_NATIVE, OP_SETUP_CALL, OP_PUSH_PARAM,
      OP_DECLARE_FUNCTION, OP_BEGIN_FUNCTION, OP_END_FUNCTION:
        ExecuteFunctionOp(LOpCode);

      // === VM CONTROL ===
      OP_NOP:
        ; // Do nothing
      
      OP_HALT:
        FRunning := False;
      
      else
        RaiseVMError(Format('Unknown opcode: %d', [Ord(LOpCode)]));
    end;
  end;
end;
{$R+}{$Q+} // Re-enable range/overflow checking

function TJetVM.ReadInt32(): Integer;
begin
  Result := PInteger(@FBytecode[FPC])^;
  Inc(FPC, 4);
end;

function TJetVM.ReadInt16(): Word;
begin
  Result := PWord(@FBytecode[FPC])^;
  Inc(FPC, 2);
end;

function TJetVM.ReadByte(): Byte;
begin
  Result := FBytecode[FPC];
  Inc(FPC);
end;

procedure TJetVM.PushValue(const AValue: TJetValue);
begin
  CheckStackOverflow();
  FStack[FSP] := AValue;
  Inc(FSP);
end;

function TJetVM.PopValue(): TJetValue;
begin
  CheckStackUnderflow(1);
  Dec(FSP);
  Result := FStack[FSP];
end;

function TJetVM.PeekValue(const AOffset: Integer = 0): TJetValue;
begin
  CheckStackUnderflow(AOffset + 1);
  Result := FStack[FSP - 1 - AOffset];
end;

procedure TJetVM.ExecuteIntArithmetic(const AOpCode: TJetOpCode);
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LResult: TJetValue;
begin
  LResult.ValueType := jvtInt;
  
  case AOpCode of
    OP_NEG_INT, OP_INC_INT, OP_DEC_INT, OP_POST_INC_INT, OP_POST_DEC_INT:
    begin
      LValue1 := PopValue();
      case AOpCode of
        OP_NEG_INT: LResult.IntValue := -LValue1.IntValue;
        OP_INC_INT: LResult.IntValue := LValue1.IntValue + 1;
        OP_DEC_INT: LResult.IntValue := LValue1.IntValue - 1;
        OP_POST_INC_INT: begin
          LResult.IntValue := LValue1.IntValue;
          LValue1.IntValue := LValue1.IntValue + 1;
          // Store back incremented value (would need local variable reference)
        end;
        OP_POST_DEC_INT: begin
          LResult.IntValue := LValue1.IntValue;
          LValue1.IntValue := LValue1.IntValue - 1;
          // Store back decremented value (would need local variable reference)
        end;
      end;
    end
    else
    begin
      LValue2 := PopValue();
      LValue1 := PopValue();
      case AOpCode of
        OP_ADD_INT: LResult.IntValue := LValue1.IntValue + LValue2.IntValue;
        OP_SUB_INT: LResult.IntValue := LValue1.IntValue - LValue2.IntValue;
        OP_MUL_INT: LResult.IntValue := LValue1.IntValue * LValue2.IntValue;
        OP_DIV_INT: LResult.IntValue := LValue1.IntValue div LValue2.IntValue;
        OP_MOD_INT: LResult.IntValue := LValue1.IntValue mod LValue2.IntValue;
      end;
    end;
  end;
  
  PushValue(LResult);
end;

procedure TJetVM.ExecuteUIntArithmetic(const AOpCode: TJetOpCode);
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LResult: TJetValue;
begin
  LResult.ValueType := jvtUInt;
  
  case AOpCode of
    OP_INC_UINT, OP_DEC_UINT, OP_POST_INC_UINT, OP_POST_DEC_UINT:
    begin
      LValue1 := PopValue();
      case AOpCode of
        OP_INC_UINT: LResult.UIntValue := LValue1.UIntValue + 1;
        OP_DEC_UINT: LResult.UIntValue := LValue1.UIntValue - 1;
        OP_POST_INC_UINT: begin
          LResult.UIntValue := LValue1.UIntValue;
          LValue1.UIntValue := LValue1.UIntValue + 1;
        end;
        OP_POST_DEC_UINT: begin
          LResult.UIntValue := LValue1.UIntValue;
          LValue1.UIntValue := LValue1.UIntValue - 1;
        end;
      end;
    end
    else
    begin
      LValue2 := PopValue();
      LValue1 := PopValue();
      case AOpCode of
        OP_ADD_UINT: LResult.UIntValue := LValue1.UIntValue + LValue2.UIntValue;
        OP_SUB_UINT: LResult.UIntValue := LValue1.UIntValue - LValue2.UIntValue;
        OP_MUL_UINT: LResult.UIntValue := LValue1.UIntValue * LValue2.UIntValue;
        OP_DIV_UINT: LResult.UIntValue := LValue1.UIntValue div LValue2.UIntValue;
        OP_MOD_UINT: LResult.UIntValue := LValue1.UIntValue mod LValue2.UIntValue;
      end;
    end;
  end;
  
  PushValue(LResult);
end;

procedure TJetVM.ExecuteIntBitwise(const AOpCode: TJetOpCode);
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LResult: TJetValue;
begin
  LResult.ValueType := jvtInt;
  
  case AOpCode of
    OP_NOT_INT:
    begin
      LValue1 := PopValue();
      LResult.IntValue := not LValue1.IntValue;
    end
    else
    begin
      LValue2 := PopValue();
      LValue1 := PopValue();
      case AOpCode of
        OP_AND_INT: LResult.IntValue := LValue1.IntValue and LValue2.IntValue;
        OP_OR_INT:  LResult.IntValue := LValue1.IntValue or LValue2.IntValue;
        OP_XOR_INT: LResult.IntValue := LValue1.IntValue xor LValue2.IntValue;
        OP_SHL_INT: LResult.IntValue := LValue1.IntValue shl LValue2.IntValue;
        OP_SHR_INT: LResult.IntValue := LValue1.IntValue shr LValue2.IntValue;
      end;
    end;
  end;
  
  PushValue(LResult);
end;

procedure TJetVM.ExecuteUIntBitwise(const AOpCode: TJetOpCode);
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LResult: TJetValue;
begin
  LResult.ValueType := jvtUInt;

  case AOpCode of
    OP_NOT_UINT:
    begin
      LValue1 := PopValue();
      LResult.UIntValue := not LValue1.UIntValue;
    end
    else
    begin
      LValue2 := PopValue();
      LValue1 := PopValue();
      case AOpCode of
        OP_AND_UINT: LResult.UIntValue := LValue1.UIntValue and LValue2.UIntValue;
        OP_OR_UINT:  LResult.UIntValue := LValue1.UIntValue or LValue2.UIntValue;
        OP_XOR_UINT: LResult.UIntValue := LValue1.UIntValue xor LValue2.UIntValue;
        OP_SHL_UINT: LResult.UIntValue := LValue1.UIntValue shl LValue2.UIntValue;
        OP_SHR_UINT: LResult.UIntValue := LValue1.UIntValue shr LValue2.UIntValue;
      end;
    end;
  end;

  PushValue(LResult);
end;

procedure TJetVM.ExecuteBooleanLogic(const AOpCode: TJetOpCode);
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LResult: TJetValue;
begin
  LResult.ValueType := jvtBool;
  
  case AOpCode of
    OP_NOT_BOOL:
    begin
      LValue1 := PopValue();
      LResult.BoolValue := not LValue1.BoolValue;
    end
    else
    begin
      LValue2 := PopValue();
      LValue1 := PopValue();
      case AOpCode of
        OP_AND_BOOL: LResult.BoolValue := LValue1.BoolValue and LValue2.BoolValue;
        OP_OR_BOOL:  LResult.BoolValue := LValue1.BoolValue or LValue2.BoolValue;
      end;
    end;
  end;
  
  PushValue(LResult);
end;

procedure TJetVM.ExecuteComparison(const AOpCode: TJetOpCode);
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LResult: TJetValue;
begin
  LValue2 := PopValue();
  LValue1 := PopValue();
  
  LResult.ValueType := jvtBool;
  
  case AOpCode of
    // Integer comparisons
    OP_EQ_INT: LResult.BoolValue := LValue1.IntValue = LValue2.IntValue;
    OP_NE_INT: LResult.BoolValue := LValue1.IntValue <> LValue2.IntValue;
    OP_LT_INT: LResult.BoolValue := LValue1.IntValue < LValue2.IntValue;
    OP_LE_INT: LResult.BoolValue := LValue1.IntValue <= LValue2.IntValue;
    OP_GT_INT: LResult.BoolValue := LValue1.IntValue > LValue2.IntValue;
    OP_GE_INT: LResult.BoolValue := LValue1.IntValue >= LValue2.IntValue;
    
    // UInteger comparisons
    OP_EQ_UINT: LResult.BoolValue := LValue1.UIntValue = LValue2.UIntValue;
    OP_NE_UINT: LResult.BoolValue := LValue1.UIntValue <> LValue2.UIntValue;
    OP_LT_UINT: LResult.BoolValue := LValue1.UIntValue < LValue2.UIntValue;
    OP_LE_UINT: LResult.BoolValue := LValue1.UIntValue <= LValue2.UIntValue;
    OP_GT_UINT: LResult.BoolValue := LValue1.UIntValue > LValue2.UIntValue;
    OP_GE_UINT: LResult.BoolValue := LValue1.UIntValue >= LValue2.UIntValue;
    
    // String comparisons (native Delphi string comparison)
    OP_EQ_STR: LResult.BoolValue := LValue1.StrValue = LValue2.StrValue;
    OP_NE_STR: LResult.BoolValue := LValue1.StrValue <> LValue2.StrValue;
    OP_LT_STR: LResult.BoolValue := LValue1.StrValue < LValue2.StrValue;
    OP_LE_STR: LResult.BoolValue := LValue1.StrValue <= LValue2.StrValue;
    OP_GT_STR: LResult.BoolValue := LValue1.StrValue > LValue2.StrValue;
    OP_GE_STR: LResult.BoolValue := LValue1.StrValue >= LValue2.StrValue;
    
    // Boolean comparisons
    OP_EQ_BOOL: LResult.BoolValue := LValue1.BoolValue = LValue2.BoolValue;
    OP_NE_BOOL: LResult.BoolValue := LValue1.BoolValue <> LValue2.BoolValue;
    
    // Pointer comparisons
    OP_EQ_PTR: LResult.BoolValue := LValue1.PtrValue = LValue2.PtrValue;
    OP_NE_PTR: LResult.BoolValue := LValue1.PtrValue <> LValue2.PtrValue;
  end;
  
  PushValue(LResult);
end;

procedure TJetVM.ExecuteStringOp(const AOpCode: TJetOpCode);
var
  LValue1: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LResult: TJetValue;
begin
  case AOpCode of
    OP_STR_CONCAT:
    begin
      LValue2 := PopValue();
      LValue1 := PopValue();
      LResult.ValueType := jvtStr;
      LResult.StrValue := LValue1.StrValue + LValue2.StrValue; // Native Delphi concatenation
    end;
    
    OP_STR_LENGTH:
    begin
      LValue1 := PopValue();
      LResult.ValueType := jvtInt;
      LResult.IntValue := Length(LValue1.StrValue); // Native Delphi Length
    end;
    
    OP_STR_COPY:
    begin
      LValue3 := PopValue(); // Length
      LValue2 := PopValue(); // Start
      LValue1 := PopValue(); // String
      LResult.ValueType := jvtStr;
      LResult.StrValue := Copy(LValue1.StrValue, LValue2.IntValue, LValue3.IntValue); // Native Delphi Copy
    end;
    
    OP_STR_POS:
    begin
      LValue2 := PopValue(); // Substring
      LValue1 := PopValue(); // String
      LResult.ValueType := jvtInt;
      LResult.IntValue := Pos(LValue2.StrValue, LValue1.StrValue); // Native Delphi Pos
    end;
    
    OP_STR_UPPERCASE:
    begin
      LValue1 := PopValue();
      LResult.ValueType := jvtStr;
      LResult.StrValue := UpperCase(LValue1.StrValue); // Native Delphi UpperCase
    end;
    
    OP_STR_LOWERCASE:
    begin
      LValue1 := PopValue();
      LResult.ValueType := jvtStr;
      LResult.StrValue := LowerCase(LValue1.StrValue); // Native Delphi LowerCase
    end;
    
    OP_STR_TRIM:
    begin
      LValue1 := PopValue();
      LResult.ValueType := jvtStr;
      LResult.StrValue := Trim(LValue1.StrValue); // Native Delphi Trim
    end;
  end;
  
  PushValue(LResult);
end;

procedure TJetVM.ExecuteFunctionOp(const AOpCode: TJetOpCode);
var
  LFunctionIndex: Integer;
  LFunction: TJetFunctionSignature;
  LParamCount: Integer;
begin
  case AOpCode of
    OP_CALL_FUNC_BY_NAME:
    begin
      LFunctionIndex := ReadInt32();
      LFunction := FFunctionRegistry.GetFunction(LFunctionIndex);

      if LFunction.IsNative then
        CallNativeFunction(LFunction)
      else
        CallVMFunction(LFunction);
    end;

    OP_CALL_NATIVE:
    begin
      LFunctionIndex := ReadInt32();
      LFunction := FFunctionRegistry.GetFunction(LFunctionIndex);
      CallNativeFunction(LFunction);
    end;

    OP_SETUP_CALL:
    begin
      LParamCount := ReadInt32();
      // Parameters are already on stack, just validate count
      CheckStackUnderflow(LParamCount);
    end;

    OP_PUSH_PARAM:
    begin
      // Parameter value is already on stack from previous operations
      // This opcode is mainly for validation in development mode
      if FValidationLevel >= vlDevelopment then
        FStackTracker.Push(jvtInt); // Generic type for now
    end;

    OP_DECLARE_FUNCTION:
    begin
      // Function declaration is handled at compile time
      // This opcode marks function boundaries in bytecode
    end;

    OP_BEGIN_FUNCTION:
    begin
      // Set up new stack frame
      SetupStackFrame();
    end;

    OP_END_FUNCTION:
    begin
      // Clean up stack frame (without return value)
      CleanupStackFrame(False);
    end;

    else
      RaiseVMError(Format('Unknown function opcode: %d', [Ord(AOpCode)]));
  end;
end;

procedure TJetVM.CallNativeFunction(const AFunction: TJetFunctionSignature);
var
  LIndex: Integer;
  LParamValues: array of TJetValue;
begin
  // Validate parameter count
  CheckStackUnderflow(AFunction.ParamCount);

  // Pop parameters in reverse order (last parameter first)
  SetLength(LParamValues, AFunction.ParamCount);
  for LIndex := AFunction.ParamCount - 1 downto 0 do
  begin
    LParamValues[LIndex] := PopValue();

    // Type validation in development mode
    if (FValidationLevel >= vlDevelopment) and
       (LIndex < Length(AFunction.ParamTypes)) and
       (LParamValues[LIndex].ValueType <> AFunction.ParamTypes[LIndex]) then
      RaiseVMError(Format('Parameter %d type mismatch: expected %d, got %d',
        [LIndex, Ord(AFunction.ParamTypes[LIndex]), Ord(LParamValues[LIndex].ValueType)]));
  end;

  // Restore parameters to stack in original order for native function
  for LIndex := 0 to AFunction.ParamCount - 1 do
    PushValue(LParamValues[LIndex]);

  // Call the native function
  if Assigned(AFunction.NativeProc) then
  begin
    Inc(FCallDepth);
    try
      AFunction.NativeProc(Self);
    finally
      Dec(FCallDepth);
    end;
  end
  else
    RaiseVMError('Native function pointer is nil');
end;

procedure TJetVM.CallVMFunction(const AFunction: TJetFunctionSignature);
var
  LIndex: Integer;
  LParamValues: array of TJetValue;
begin
  // Validate parameter count
  CheckStackUnderflow(AFunction.ParamCount);

  // Pop parameters in reverse order (last parameter first)
  SetLength(LParamValues, AFunction.ParamCount);
  for LIndex := AFunction.ParamCount - 1 downto 0 do
  begin
    LParamValues[LIndex] := PopValue();

    // Type validation in development mode
    if (FValidationLevel >= vlDevelopment) and
       (LIndex < Length(AFunction.ParamTypes)) and
       (LParamValues[LIndex].ValueType <> AFunction.ParamTypes[LIndex]) then
      RaiseVMError(Format('Parameter %d type mismatch: expected %d, got %d',
        [LIndex, Ord(AFunction.ParamTypes[LIndex]), Ord(LParamValues[LIndex].ValueType)]));
  end;

  // Set up stack frame
  SetupStackFrame();

  // Store parameters in local variables (parameters start at index 0)
  for LIndex := 0 to AFunction.ParamCount - 1 do
    FLocals[FBP + LIndex] := LParamValues[LIndex];

  // Push return address
  if FCallSP >= Length(FCallStack) then
    SetLength(FCallStack, Length(FCallStack) * 2);

  FCallStack[FCallSP] := FPC;
  Inc(FCallSP);
  Inc(FCallDepth);

  // Jump to function address
  FPC := AFunction.Address;
end;

procedure TJetVM.SetupStackFrame();
var
  LFrame: TStackFrame;
begin
  // Create new stack frame
  LFrame.ReturnAddress := FPC;
  LFrame.BasePointer := FBP;
  LFrame.LocalVarCount := 0;  // Will be set by function prologue
  LFrame.ParamCount := 0;     // Will be set by calling code
  LFrame.FunctionIndex := FCurrentFunction;

  // Push frame onto frame stack
  if FFrameSP >= Length(FStackFrames) then
    SetLength(FStackFrames, Length(FStackFrames) * 2);

  FStackFrames[FFrameSP] := LFrame;
  Inc(FFrameSP);

  // Set new base pointer to current stack position
  FBP := FSP;
end;

procedure TJetVM.CleanupStackFrame(const AHasReturnValue: Boolean);
var
  LFrame: TStackFrame;
  LReturnValue: TJetValue;
begin
  // Save return value if present
  if AHasReturnValue then
    LReturnValue := PopValue();

  // Restore previous stack frame
  if FFrameSP > 0 then
  begin
    Dec(FFrameSP);
    LFrame := FStackFrames[FFrameSP];

    // Restore base pointer
    FBP := LFrame.BasePointer;

    // Restore previous function context
    FCurrentFunction := LFrame.FunctionIndex;
    Dec(FCallDepth);
  end;

  // Restore return value if present
  if AHasReturnValue then
    PushValue(LReturnValue);
end;

function TJetVM.RegisterNativeFunction(const AName: string; const AProc: TJetNativeFunction;
  const AParamTypes: array of TJetValueType; const AReturnType: TJetValueType): Integer;
var
  LSignature: TJetFunctionSignature;
  LIndex: Integer;
begin
  LSignature.Name := AName;
  LSignature.Address := -1;  // Not used for native functions
  LSignature.NativeProc := AProc;
  LSignature.ReturnType := AReturnType;
  LSignature.ParamCount := Length(AParamTypes);
  LSignature.IsNative := True;
  LSignature.IsVoid := False;

  SetLength(LSignature.ParamTypes, Length(AParamTypes));
  SetLength(LSignature.ParamModes, Length(AParamTypes));
  for LIndex := 0 to High(AParamTypes) do
  begin
    LSignature.ParamTypes[LIndex] := AParamTypes[LIndex];
    LSignature.ParamModes[LIndex] := pmConst; // Default to const parameters
  end;

  Result := FFunctionRegistry.RegisterFunction(LSignature);
end;

function TJetVM.RegisterNativeFunction(const AName: string; const AProc: TJetNativeFunction;
  const AParamTypes: array of TJetValueType): Integer;
var
  LSignature: TJetFunctionSignature;
  LIndex: Integer;
begin
  LSignature.Name := AName;
  LSignature.Address := -1;  // Not used for native functions
  LSignature.NativeProc := AProc;
  LSignature.ReturnType := jvtInt; // Dummy return type for void functions
  LSignature.ParamCount := Length(AParamTypes);
  LSignature.IsNative := True;
  LSignature.IsVoid := True;

  SetLength(LSignature.ParamTypes, Length(AParamTypes));
  SetLength(LSignature.ParamModes, Length(AParamTypes));
  for LIndex := 0 to High(AParamTypes) do
  begin
    LSignature.ParamTypes[LIndex] := AParamTypes[LIndex];
    LSignature.ParamModes[LIndex] := pmConst; // Default to const parameters
  end;

  Result := FFunctionRegistry.RegisterFunction(LSignature);
end;

function TJetVM.DeclareVMFunction(const AName: string; const AAddress: Integer;
  const AParamTypes: array of TJetValueType; const AReturnType: TJetValueType): Integer;
var
  LSignature: TJetFunctionSignature;
  LIndex: Integer;
begin
  LSignature.Name := AName;
  LSignature.Address := AAddress;
  LSignature.NativeProc := nil; // Not used for VM functions
  LSignature.ReturnType := AReturnType;
  LSignature.ParamCount := Length(AParamTypes);
  LSignature.IsNative := False;
  LSignature.IsVoid := False;

  SetLength(LSignature.ParamTypes, Length(AParamTypes));
  SetLength(LSignature.ParamModes, Length(AParamTypes));
  for LIndex := 0 to High(AParamTypes) do
  begin
    LSignature.ParamTypes[LIndex] := AParamTypes[LIndex];
    LSignature.ParamModes[LIndex] := pmConst; // Default to const parameters
  end;

  Result := FFunctionRegistry.RegisterFunction(LSignature);
end;

function TJetVM.DeclareVMFunction(const AName: string; const AAddress: Integer;
  const AParamTypes: array of TJetValueType): Integer;
var
  LSignature: TJetFunctionSignature;
  LIndex: Integer;
begin
  LSignature.Name := AName;
  LSignature.Address := AAddress;
  LSignature.NativeProc := nil; // Not used for VM functions
  LSignature.ReturnType := jvtInt; // Dummy return type for void functions
  LSignature.ParamCount := Length(AParamTypes);
  LSignature.IsNative := False;
  LSignature.IsVoid := True;

  SetLength(LSignature.ParamTypes, Length(AParamTypes));
  SetLength(LSignature.ParamModes, Length(AParamTypes));
  for LIndex := 0 to High(AParamTypes) do
  begin
    LSignature.ParamTypes[LIndex] := AParamTypes[LIndex];
    LSignature.ParamModes[LIndex] := pmConst; // Default to const parameters
  end;

  Result := FFunctionRegistry.RegisterFunction(LSignature);
end;

function TJetVM.GetFunctionIndex(const AName: string): Integer;
begin
  Result := FFunctionRegistry.FindFunction(AName);
  if Result = -1 then
    RaiseVMError('Function not found: ' + AName);
end;

function TJetVM.CallFunction(const AName: string): TJetVM;
var
  LFunctionIndex: Integer;
begin
  CheckCanEmit();

  LFunctionIndex := FFunctionRegistry.FindFunction(AName);
  if LFunctionIndex = -1 then
    raise EJetVMError.Create('Function not found: ' + AName);

  EmitOpCode(OP_CALL_FUNC_BY_NAME);
  EmitInt32(LFunctionIndex);
  Result := Self;
end;

function TJetVM.CallFunctionByIndex(const AIndex: Integer): TJetVM;
begin
  CheckCanEmit();

  if (AIndex < 0) or (AIndex >= FFunctionRegistry.GetFunctionCount()) then
    raise EJetVMError.CreateFmt('Invalid function index: %d', [AIndex]);

  EmitOpCode(OP_CALL_FUNC_BY_NAME);
  EmitInt32(AIndex);
  Result := Self;
end;

function TJetVM.PushParam(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtInt); // Generic type tracking

  EmitOpCode(OP_PUSH_PARAM);
  Result := Self;
end;

function TJetVM.DeclareFunction(const AName: string): TJetVM;
begin
  CheckCanEmit();

  // This is mainly a marker for development/debugging
  // Actual function registration happens via RegisterXXXFunction methods
  EmitOpCode(OP_DECLARE_FUNCTION);

  // Store function name as string constant for debugging
  var LConstIndex := AddConstantInternal(MakeStrConstant(AName));
  EmitInt32(LConstIndex);
  Result := Self;
end;

function TJetVM.BeginFunction(): TJetVM;
begin
  CheckCanEmit();

  EmitOpCode(OP_BEGIN_FUNCTION);
  Result := Self;
end;

function TJetVM.EndFunction(): TJetVM;
begin
  CheckCanEmit();

  EmitOpCode(OP_END_FUNCTION);
  Result := Self;
end;

procedure TJetVM.DumpFunctionRegistry();
var
  LIndex: Integer;
  LFunction: TJetFunctionSignature;
  LParamIndex: Integer;
begin
  Writeln('=== FUNCTION REGISTRY DUMP ===');
  Writeln('Function Count: ', FFunctionRegistry.GetFunctionCount());

  for LIndex := 0 to FFunctionRegistry.GetFunctionCount() - 1 do
  begin
    LFunction := FFunctionRegistry.GetFunction(LIndex);
    Write('Function[', LIndex, ']: ', LFunction.Name);

    if LFunction.IsNative then
      Write(' (Native)')
    else
      Write(' (VM, Address: ', LFunction.Address, ')');

    if LFunction.IsVoid then
      Write(' -> void')
    else
      Write(' -> ', GetEnumName(TypeInfo(TJetValueType), Ord(LFunction.ReturnType)));

    Write(' Params(', LFunction.ParamCount, '): ');
    for LParamIndex := 0 to LFunction.ParamCount - 1 do
    begin
      if LParamIndex > 0 then Write(', ');
      if LParamIndex < Length(LFunction.ParamTypes) then
        Write(GetEnumName(TypeInfo(TJetValueType), Ord(LFunction.ParamTypes[LParamIndex])))
      else
        Write('?');
    end;
    Writeln;
  end;
  Writeln('Call Depth: ', FCallDepth);
  Writeln('Frame SP: ', FFrameSP);
  Writeln('=============================');
end;

function TJetVM.GetCallDepth(): Integer;
begin
  Result := FCallDepth;
end;

function TJetVM.GetCurrentFunction(): Integer;
begin
  Result := FCurrentFunction;
end;

function TJetVM.SetupCall(const AParamCount: Integer): TJetVM;
begin
  CheckCanEmit();

  EmitOpCode(OP_SETUP_CALL);
  EmitInt32(AParamCount);
  Result := Self;
end;

procedure TJetVM.ExecuteJump(const AOpCode: TJetOpCode);
var
  LTargetPC: Integer;
  LCondition: TJetValue;
begin
  LTargetPC := ReadInt32();
  
  case AOpCode of
    OP_JMP:
      FPC := LTargetPC;
    
    OP_JMP_TRUE:
    begin
      LCondition := PopValue();
      if LCondition.BoolValue then
        FPC := LTargetPC;
    end;
    
    OP_JMP_FALSE:
    begin
      LCondition := PopValue();
      if not LCondition.BoolValue then
        FPC := LTargetPC;
    end;
    
    OP_JMP_ZERO:
    begin
      LCondition := PopValue();
      if LCondition.IntValue = 0 then
        FPC := LTargetPC;
    end;
    
    OP_JMP_NOT_ZERO:
    begin
      LCondition := PopValue();
      if LCondition.IntValue <> 0 then
        FPC := LTargetPC;
    end;
  end;
end;

procedure TJetVM.ExecuteCall(const AOpCode: TJetOpCode);
var
  LTargetPC: Integer;
begin
  LTargetPC := ReadInt32();
  
  // Push return address
  if FCallSP >= Length(FCallStack) then
    SetLength(FCallStack, Length(FCallStack) * 2);
  
  FCallStack[FCallSP] := FPC;
  Inc(FCallSP);
  
  FPC := LTargetPC;
end;

procedure TJetVM.ExecuteReturn(const AOpCode: TJetOpCode);
begin
  case AOpCode of
    OP_RET_VALUE:
    begin
      // Return with value - CleanupStackFrame will preserve the return value
      CleanupStackFrame(True);

      // Restore return address if we have call stack entries
      if FCallSP > 0 then
      begin
        Dec(FCallSP);
        FPC := FCallStack[FCallSP];
      end
      else
        FRunning := False; // Program end
    end;

    OP_RET:
    begin
      // Return without value
      CleanupStackFrame(False);

      // Restore return address if we have call stack entries
      if FCallSP > 0 then
      begin
        Dec(FCallSP);
        FPC := FCallStack[FCallSP];
      end
      else
        FRunning := False; // Program end
    end;
  end;
end;

procedure TJetVM.ExecuteScope(const AOpCode: TJetOpCode);
begin
  case AOpCode of
    OP_ENTER_SCOPE:
    begin
      // Save current base pointer on call stack
      if FCallSP >= Length(FCallStack) then
        SetLength(FCallStack, Length(FCallStack) * 2);
      FCallStack[FCallSP] := FBP;
      Inc(FCallSP);
      FBP := FSP; // New base pointer
    end;
    
    OP_EXIT_SCOPE:
    begin
      if FCallSP > 0 then
      begin
        Dec(FCallSP);
        FBP := FCallStack[FCallSP]; // Restore base pointer
      end;
    end;
  end;
end;

procedure TJetVM.ExecutePointerOp(const AOpCode: TJetOpCode);
var
  LValue: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LResult: TJetValue;
begin
  case AOpCode of
    OP_ADDR_OF:
    begin
      LValue := PopValue();
      LResult.ValueType := jvtPointer;
      case LValue.ValueType of
        jvtStr: LResult.PtrValue := Pointer(LValue.StrValue);
        jvtPStr: LResult.PtrValue := LValue.PStrValue;
        jvtPBool: LResult.PtrValue := LValue.PBoolValue;
        else LResult.PtrValue := @LValue;
      end;
      PushValue(LResult);
    end;

    OP_DEREF_PTR:
    begin
      LValue := PopValue();
      LResult.ValueType := jvtPointer;
      LResult.PtrValue := PPointer(LValue.PtrValue)^;
      PushValue(LResult);
    end;

    OP_DEREF_PSTR:
    begin
      LValue := PopValue();
      LResult.ValueType := jvtStr;
      LResult.StrValue := LValue.PStrValue^;
      PushValue(LResult);
    end;

    OP_DEREF_PBOOL:
    begin
      LValue := PopValue();
      LResult.ValueType := jvtBool;
      LResult.BoolValue := LValue.PBoolValue^;
      PushValue(LResult);
    end;

    OP_NULL_CHECK:
    begin
      LValue := PopValue();
      LResult.ValueType := jvtBool;
      LResult.BoolValue := LValue.PtrValue = nil;
      PushValue(LResult);
    end;

    OP_PTR_ADD:
    begin
      LValue2 := PopValue(); // Offset
      LValue := PopValue();  // Pointer
      LResult.ValueType := jvtPointer;
      LResult.PtrValue := Pointer(NativeInt(LValue.PtrValue) + LValue2.IntValue);
      PushValue(LResult);
    end;

    OP_PTR_SUB:
    begin
      LValue2 := PopValue(); // Offset
      LValue := PopValue();  // Pointer
      LResult.ValueType := jvtPointer;
      LResult.PtrValue := Pointer(NativeInt(LValue.PtrValue) - LValue2.IntValue);
      PushValue(LResult);
    end;

    // === TYPED POINTER LOADS ===
    OP_LOAD_PTR_INT:
    begin
      LValue := PopValue(); // Pointer
      LResult.ValueType := jvtInt;
      LResult.IntValue := PInt64(LValue.PtrValue)^;
      PushValue(LResult);
    end;

    OP_LOAD_PTR_UINT:
    begin
      LValue := PopValue(); // Pointer
      LResult.ValueType := jvtUInt;
      LResult.UIntValue := PUInt64(LValue.PtrValue)^;
      PushValue(LResult);
    end;

    OP_LOAD_PTR_STR:
    begin
      LValue := PopValue(); // Pointer
      LResult.ValueType := jvtStr;
      LResult.StrValue := PString(LValue.PtrValue)^;
      PushValue(LResult);
    end;

    OP_LOAD_PTR_BOOL:
    begin
      LValue := PopValue(); // Pointer
      LResult.ValueType := jvtBool;
      LResult.BoolValue := PBoolean(LValue.PtrValue)^;
      PushValue(LResult);
    end;

    // === TYPED POINTER STORES ===
    OP_STORE_PTR_INT:
    begin
      LValue2 := PopValue(); // Pointer
      LValue := PopValue();  // Value
      PInt64(LValue2.PtrValue)^ := LValue.IntValue;
    end;

    OP_STORE_PTR_UINT:
    begin
      LValue2 := PopValue(); // Pointer
      LValue := PopValue();  // Value
      PUInt64(LValue2.PtrValue)^ := LValue.UIntValue;
    end;

    OP_STORE_PTR_STR:
    begin
      LValue2 := PopValue(); // Pointer
      LValue := PopValue();  // Value
      PString(LValue2.PtrValue)^ := LValue.StrValue;
    end;

    OP_STORE_PTR_BOOL:
    begin
      LValue2 := PopValue(); // Pointer
      LValue := PopValue();  // Value
      PBoolean(LValue2.PtrValue)^ := LValue.BoolValue;
    end;

// === OFFSET OPERATIONS (CONVENIENCE) ===
    OP_LOAD_OFFSET_INT:
    begin
      LValue2 := PopValue(); // Offset
      LValue := PopValue();  // Pointer

      // Bounds checking in safe mode
      CheckBounds(LValue.PtrValue, LValue2.IntValue, 8); // Int64 = 8 bytes

      LResult.ValueType := jvtInt;
      LResult.IntValue := PInt64(Pointer(NativeInt(LValue.PtrValue) + LValue2.IntValue))^;
      PushValue(LResult);
    end;

    OP_LOAD_OFFSET_UINT:
    begin
      LValue2 := PopValue(); // Offset
      LValue := PopValue();  // Pointer

      // Bounds checking in safe mode
      CheckBounds(LValue.PtrValue, LValue2.IntValue, 8); // UInt64 = 8 bytes

      LResult.ValueType := jvtUInt;
      LResult.UIntValue := PUInt64(Pointer(NativeInt(LValue.PtrValue) + LValue2.IntValue))^;
      PushValue(LResult);
    end;

    OP_LOAD_OFFSET_STR:
    begin
      LValue2 := PopValue(); // Offset
      LValue := PopValue();  // Pointer

      // Bounds checking in safe mode
      CheckBounds(LValue.PtrValue, LValue2.IntValue, SizeOf(Pointer)); // String = pointer size

      LResult.ValueType := jvtStr;
      LResult.StrValue := PString(Pointer(NativeInt(LValue.PtrValue) + LValue2.IntValue))^;
      PushValue(LResult);
    end;

    OP_LOAD_OFFSET_BOOL:
    begin
      LValue2 := PopValue(); // Offset
      LValue := PopValue();  // Pointer

      // Bounds checking in safe mode
      CheckBounds(LValue.PtrValue, LValue2.IntValue, 1); // Boolean = 1 byte

      LResult.ValueType := jvtBool;
      LResult.BoolValue := PBoolean(Pointer(NativeInt(LValue.PtrValue) + LValue2.IntValue))^;
      PushValue(LResult);
    end;

    OP_STORE_OFFSET_INT:
    begin
      LValue3 := PopValue(); // Offset
      LValue2 := PopValue(); // Pointer
      LValue := PopValue();  // Value

      // Bounds checking in safe mode
      CheckBounds(LValue2.PtrValue, LValue3.IntValue, 8); // Int64 = 8 bytes

      PInt64(Pointer(NativeInt(LValue2.PtrValue) + LValue3.IntValue))^ := LValue.IntValue;
    end;

    OP_STORE_OFFSET_UINT:
    begin
      LValue3 := PopValue(); // Offset
      LValue2 := PopValue(); // Pointer
      LValue := PopValue();  // Value

      // Bounds checking in safe mode
      CheckBounds(LValue2.PtrValue, LValue3.IntValue, 8); // UInt64 = 8 bytes

      PUInt64(Pointer(NativeInt(LValue2.PtrValue) + LValue3.IntValue))^ := LValue.UIntValue;
    end;

    OP_STORE_OFFSET_STR:
    begin
      LValue3 := PopValue(); // Offset
      LValue2 := PopValue(); // Pointer
      LValue := PopValue();  // Value

      // Bounds checking in safe mode
      CheckBounds(LValue2.PtrValue, LValue3.IntValue, SizeOf(Pointer)); // String = pointer size

      PString(Pointer(NativeInt(LValue2.PtrValue) + LValue3.IntValue))^ := LValue.StrValue;
    end;

    OP_STORE_OFFSET_BOOL:
    begin
      LValue3 := PopValue(); // Offset
      LValue2 := PopValue(); // Pointer
      LValue := PopValue();  // Value

      // Bounds checking in safe mode
      CheckBounds(LValue2.PtrValue, LValue3.IntValue, 1); // Boolean = 1 byte

      PBoolean(Pointer(NativeInt(LValue2.PtrValue) + LValue3.IntValue))^ := LValue.BoolValue;
    end;
  end;
end;

procedure TJetVM.ExecuteArrayOp(const AOpCode: TJetOpCode);
var
  LValue: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LResult: TJetValue;
  LIndex: Integer;
  LLowerBound: Integer;
  LUpperBound: Integer;
  LElementType: TJetValueType;
begin
  case AOpCode of
    OP_ARRAY_DECLARE_FIXED:
    begin
      LValue3 := PopValue(); // Element type
      LValue2 := PopValue(); // Upper bound
      LValue := PopValue();  // Lower bound
      LLowerBound := LValue.IntValue;
      LUpperBound := LValue2.IntValue;
      LElementType := TJetValueType(LValue3.IntValue);
      
      case LElementType of
        jvtInt:
        begin
          LResult.ValueType := jvtArrayInt;
          SetLength(LResult.ArrayIntValue, LUpperBound - LLowerBound + 1);
        end;
        jvtUInt:
        begin
          LResult.ValueType := jvtArrayUInt;
          SetLength(LResult.ArrayUIntValue, LUpperBound - LLowerBound + 1);
        end;
        jvtStr:
        begin
          LResult.ValueType := jvtArrayStr;
          SetLength(LResult.ArrayStrValue, LUpperBound - LLowerBound + 1);
        end;
        jvtBool:
        begin
          LResult.ValueType := jvtArrayBool;
          SetLength(LResult.ArrayBoolValue, LUpperBound - LLowerBound + 1);
        end;
      end;
      PushValue(LResult);
    end;
    
    OP_ARRAY_DECLARE_DYNAMIC:
    begin
      LValue := PopValue(); // Element type
      LElementType := TJetValueType(LValue.IntValue);
      
      case LElementType of
        jvtInt: LResult.ValueType := jvtArrayInt;
        jvtUInt: LResult.ValueType := jvtArrayUInt;
        jvtStr: LResult.ValueType := jvtArrayStr;
        jvtBool: LResult.ValueType := jvtArrayBool;
      end;
      PushValue(LResult);
    end;
    
    OP_ARRAY_GET_FIXED, OP_ARRAY_GET_DYNAMIC:
    begin
      LValue2 := PopValue(); // Index
      LValue := PopValue();  // Array
      LIndex := LValue2.IntValue;
      
      case LValue.ValueType of
        jvtArrayInt:
        begin
          LResult.ValueType := jvtInt;
          LResult.IntValue := LValue.ArrayIntValue[LIndex];
        end;
        jvtArrayUInt:
        begin
          LResult.ValueType := jvtUInt;
          LResult.UIntValue := LValue.ArrayUIntValue[LIndex];
        end;
        jvtArrayStr:
        begin
          LResult.ValueType := jvtStr;
          LResult.StrValue := LValue.ArrayStrValue[LIndex];
        end;
        jvtArrayBool:
        begin
          LResult.ValueType := jvtBool;
          LResult.BoolValue := LValue.ArrayBoolValue[LIndex];
        end;
      end;
      PushValue(LResult);
    end;
    
    OP_ARRAY_SET_FIXED, OP_ARRAY_SET_DYNAMIC:
    begin
      LValue3 := PopValue(); // Value
      LValue2 := PopValue(); // Index
      LValue := PopValue();  // Array
      LIndex := LValue2.IntValue;
      
      case LValue.ValueType of
        jvtArrayInt: LValue.ArrayIntValue[LIndex] := LValue3.IntValue;
        jvtArrayUInt: LValue.ArrayUIntValue[LIndex] := LValue3.UIntValue;
        jvtArrayStr: LValue.ArrayStrValue[LIndex] := LValue3.StrValue;
        jvtArrayBool: LValue.ArrayBoolValue[LIndex] := LValue3.BoolValue;
      end;
      PushValue(LValue);
    end;
    
    OP_ARRAY_ADDR_FIXED:
    begin
      LValue2 := PopValue(); // Index
      LValue := PopValue();  // Array
      LIndex := LValue2.IntValue;
      
      LResult.ValueType := jvtPointer;
      case LValue.ValueType of
        jvtArrayInt: LResult.PtrValue := @LValue.ArrayIntValue[LIndex];
        jvtArrayUInt: LResult.PtrValue := @LValue.ArrayUIntValue[LIndex];
        jvtArrayStr: LResult.PtrValue := @LValue.ArrayStrValue[LIndex];
        jvtArrayBool: LResult.PtrValue := @LValue.ArrayBoolValue[LIndex];
      end;
      PushValue(LResult);
    end;
    
    OP_ARRAY_BOUNDS_FIXED:
    begin
      LValue := PopValue(); // Array
      // Return bounds as two integers on stack
      LResult.ValueType := jvtInt;
      LResult.IntValue := 0; // Lower bound
      PushValue(LResult);
      
      case LValue.ValueType of
        jvtArrayInt: LResult.IntValue := High(LValue.ArrayIntValue);
        jvtArrayUInt: LResult.IntValue := High(LValue.ArrayUIntValue);
        jvtArrayStr: LResult.IntValue := High(LValue.ArrayStrValue);
        jvtArrayBool: LResult.IntValue := High(LValue.ArrayBoolValue);
      end;
      PushValue(LResult);
    end;
    
    OP_ARRAY_SETLENGTH:
    begin
      LValue2 := PopValue(); // New length
      LValue := PopValue();  // Array
      case LValue.ValueType of
        jvtArrayInt: SetLength(LValue.ArrayIntValue, LValue2.IntValue);
        jvtArrayUInt: SetLength(LValue.ArrayUIntValue, LValue2.IntValue);
        jvtArrayStr: SetLength(LValue.ArrayStrValue, LValue2.IntValue);
        jvtArrayBool: SetLength(LValue.ArrayBoolValue, LValue2.IntValue);
      end;
      PushValue(LValue);
    end;
    
    OP_ARRAY_LENGTH:
    begin
      LValue := PopValue();
      LResult.ValueType := jvtInt;
      case LValue.ValueType of
        jvtArrayInt: LResult.IntValue := Length(LValue.ArrayIntValue);
        jvtArrayUInt: LResult.IntValue := Length(LValue.ArrayUIntValue);
        jvtArrayStr: LResult.IntValue := Length(LValue.ArrayStrValue);
        jvtArrayBool: LResult.IntValue := Length(LValue.ArrayBoolValue);
      end;
      PushValue(LResult);
    end;
    
    OP_ARRAY_HIGH:
    begin
      LValue := PopValue();
      LResult.ValueType := jvtInt;
      case LValue.ValueType of
        jvtArrayInt: LResult.IntValue := High(LValue.ArrayIntValue);
        jvtArrayUInt: LResult.IntValue := High(LValue.ArrayUIntValue);
        jvtArrayStr: LResult.IntValue := High(LValue.ArrayStrValue);
        jvtArrayBool: LResult.IntValue := High(LValue.ArrayBoolValue);
      end;
      PushValue(LResult);
    end;
    
    OP_ARRAY_LOW:
    begin
      LValue := PopValue();
      LResult.ValueType := jvtInt;
      case LValue.ValueType of
        jvtArrayInt: LResult.IntValue := Low(LValue.ArrayIntValue);
        jvtArrayUInt: LResult.IntValue := Low(LValue.ArrayUIntValue);
        jvtArrayStr: LResult.IntValue := Low(LValue.ArrayStrValue);
        jvtArrayBool: LResult.IntValue := Low(LValue.ArrayBoolValue);
      end;
      PushValue(LResult);
    end;
  end;
end;

procedure TJetVM.ExecuteParameterOp(const AOpCode: TJetOpCode);
var
  LParamIndex: Integer;
  LValue: TJetValue;
begin
  LParamIndex := ReadInt32();
  
  case AOpCode of
    // Const parameters (pass by value)
    OP_PARAM_CONST_INT, OP_PARAM_CONST_UINT, OP_PARAM_CONST_STR,
    OP_PARAM_CONST_BOOL, OP_PARAM_CONST_PTR, OP_PARAM_CONST_ARRAY:
    begin
      LValue := PopValue();
      FLocals[LParamIndex] := LValue;
    end;
    
    // Var parameters (pass by reference)
    OP_PARAM_VAR_INT, OP_PARAM_VAR_UINT, OP_PARAM_VAR_STR,
    OP_PARAM_VAR_BOOL, OP_PARAM_VAR_PTR, OP_PARAM_VAR_ARRAY:
    begin
      LValue := PopValue();
      // Store reference/pointer to original variable
      FLocals[LParamIndex] := LValue;
    end;
    
    // Out parameters (write-only)
    OP_PARAM_OUT_INT, OP_PARAM_OUT_UINT, OP_PARAM_OUT_STR,
    OP_PARAM_OUT_BOOL, OP_PARAM_OUT_PTR, OP_PARAM_OUT_ARRAY:
    begin
      // Initialize with default value
      case AOpCode of
        OP_PARAM_OUT_INT: 
        begin
          LValue.ValueType := jvtInt;
          LValue.IntValue := 0;
        end;
        OP_PARAM_OUT_UINT: 
        begin
          LValue.ValueType := jvtUInt;
          LValue.UIntValue := 0;
        end;
        OP_PARAM_OUT_STR: 
        begin
          LValue.ValueType := jvtStr;
          LValue.StrValue := '';
        end;
        OP_PARAM_OUT_BOOL: 
        begin
          LValue.ValueType := jvtBool;
          LValue.BoolValue := False;
        end;
        OP_PARAM_OUT_PTR: 
        begin
          LValue.ValueType := jvtPointer;
          LValue.PtrValue := nil;
        end;
      end;
      FLocals[LParamIndex] := LValue;
    end;
  end;
end;

procedure TJetVM.ExecuteMemoryOp(const AOpCode: TJetOpCode);
var
  LValue: TJetValue;
  LValue2: TJetValue;
  LValue3: TJetValue;
  LResult: TJetValue;
  LSize: Integer;
begin
  case AOpCode of
    OP_ALLOC:
    begin
      LValue := PopValue(); // Size
      LSize := LValue.IntValue;
      LResult.ValueType := jvtPointer;
      GetMem(LResult.PtrValue, LSize);

      // Register allocation for bounds checking
      RegisterAllocation(LResult.PtrValue, LSize);

      PushValue(LResult);
    end;
    
    OP_FREE:
    begin
      LValue := PopValue(); // Pointer
      if LValue.PtrValue <> nil then
      begin
        // Unregister allocation for bounds checking
        UnregisterAllocation(LValue.PtrValue);
        System.FreeMem(LValue.PtrValue);
      end;
    end;
    
    OP_MEMCPY:
    begin
      LValue3 := PopValue(); // Size
      LValue2 := PopValue(); // Source
      LValue := PopValue();  // Destination
      Move(LValue2.PtrValue^, LValue.PtrValue^, LValue3.IntValue);
    end;
    
    OP_MEMSET:
    begin
      LValue3 := PopValue(); // Size
      LValue2 := PopValue(); // Value
      LValue := PopValue();  // Destination
      FillChar(LValue.PtrValue^, LValue3.IntValue, LValue2.IntValue);
    end;
  end;
end;

procedure TJetVM.ExecuteTypeConversion(const AOpCode: TJetOpCode);
var
  LValue: TJetValue;
  LResult: TJetValue;
begin
  LValue := PopValue();
  
  case AOpCode of
    OP_INT_TO_UINT:
    begin
      LResult.ValueType := jvtUInt;
      LResult.UIntValue := UInt64(LValue.IntValue);
    end;
    
    OP_UINT_TO_INT:
    begin
      LResult.ValueType := jvtInt;
      LResult.IntValue := Int64(LValue.UIntValue);
    end;
    
    OP_INT_TO_STR:
    begin
      LResult.ValueType := jvtStr;
      LResult.StrValue := System.SysUtils.IntToStr(LValue.IntValue); // Native Delphi conversion
    end;

    OP_UINT_TO_STR:
    begin
      LResult.ValueType := jvtStr;
      LResult.StrValue := System.SysUtils.UIntToStr(LValue.UIntValue); // Native Delphi conversion
    end;

    OP_STR_TO_INT:
    begin
      LResult.ValueType := jvtInt;
      LResult.IntValue := StrToInt64(LValue.StrValue); // Native Delphi conversion
    end;

    OP_STR_TO_UINT:
    begin
      LResult.ValueType := jvtUInt;
      LResult.IntValue := StrToUInt64(LValue.StrValue); // Native Delphi conversion
    end;
    
    OP_BOOL_TO_STR:
    begin
      LResult.ValueType := jvtStr;
      if LValue.BoolValue then
        LResult.StrValue := 'True'
      else
        LResult.StrValue := 'False';
    end;
    
    OP_STR_TO_BOOL:
    begin
      LResult.ValueType := jvtBool;
      LResult.BoolValue := System.SysUtils.StrToBool(LValue.StrValue); // Native Delphi conversion
    end;

    OP_PTR_TO_INT:
    begin
      LResult.ValueType := jvtInt;
      LResult.IntValue := NativeInt(LValue.PtrValue);
    end;
    
    OP_INT_TO_PTR:
    begin
      LResult.ValueType := jvtPointer;
      LResult.PtrValue := Pointer(LValue.IntValue);
    end;
  end;
  
  PushValue(LResult);
end;

// === BYTECODE GENERATION HELPERS ===

procedure TJetVM.EmitByte(const AValue: Byte);
begin
  CheckCanEmit();
  if FBytecodePos >= Length(FBytecode) then
  begin
    if Length(FBytecode) = 0 then
      SetLength(FBytecode, 1024) // Initial capacity
    else
      SetLength(FBytecode, Length(FBytecode) * 2);
  end;
  FBytecode[FBytecodePos] := AValue;
  Inc(FBytecodePos);
end;

procedure TJetVM.EmitInt32(const AValue: Integer);
begin
  CheckCanEmit();
  if FBytecodePos + 4 > Length(FBytecode) then
    SetLength(FBytecode, Length(FBytecode) * 2);
  PInteger(@FBytecode[FBytecodePos])^ := AValue;
  Inc(FBytecodePos, 4);
end;

procedure TJetVM.EmitOpCode(const AOpCode: TJetOpCode);
begin
  EmitByte(Ord(AOpCode));
end;

procedure TJetVM.CheckCanEmit();
begin
  if FFinalized then
    raise EJetVMError.Create('Cannot emit bytecode - VM is finalized for execution');
end;

procedure TJetVM.PatchLabel(const ALabelId: Integer);
var
  LIndex: Integer;
  LPatchAddress: Integer;
begin
  if (ALabelId >= 0) and (ALabelId < FLabelCount) and FLabels[ALabelId].IsBound then
  begin
    for LIndex := 0 to High(FLabels[ALabelId].PatchList) do
    begin
      LPatchAddress := FLabels[ALabelId].PatchList[LIndex];
      PInteger(@FBytecode[LPatchAddress])^ := FLabels[ALabelId].Address;
    end;
    SetLength(FLabels[ALabelId].PatchList, 0);
  end;
end;

function TJetVM.AddConstantInternal(const AValue: TJetValue): Integer;
var
  LIndex: Integer;
begin
  // Check if constant already exists (optimization)
  for LIndex := 0 to High(FConstants) do
  begin
    if (FConstants[LIndex].ValueType = AValue.ValueType) then
    begin
      case AValue.ValueType of
        jvtInt: if FConstants[LIndex].IntValue = AValue.IntValue then Exit(LIndex);
        jvtUInt: if FConstants[LIndex].UIntValue = AValue.UIntValue then Exit(LIndex);
        jvtStr: if FConstants[LIndex].StrValue = AValue.StrValue then Exit(LIndex);
        jvtBool: if FConstants[LIndex].BoolValue = AValue.BoolValue then Exit(LIndex);
      end;
    end;
  end;
  
  // Add new constant
  Result := Length(FConstants);
  SetLength(FConstants, Result + 1);
  FConstants[Result] := AValue;
end;

procedure TJetVM.ValidateStackTypes(const ARequired: Integer; const AType: TJetValueType);
begin
  if (FValidationLevel >= vlDevelopment) and Assigned(FStackTracker) then
  begin
    if not FStackTracker.CheckHasAtLeast(ARequired, AType) then
      raise EJetVMError.CreateFmt('Stack type validation failed - expected %d values of type %d', 
        [ARequired, Ord(AType)]);
  end;
end;

procedure TJetVM.Finalize();
var
  LIndex: Integer;
begin
  // Patch all bound labels
  for LIndex := 0 to FLabelCount - 1 do
    PatchLabel(LIndex);
    
  // Resize bytecode to actual size
  SetLength(FBytecode, FBytecodePos);
  FFinalized := True;
end;

function TJetVM.CreateLabel(): Integer;
begin
  Result := FLabelCount;
  
  if FLabelCount >= Length(FLabels) then
    SetLength(FLabels, Length(FLabels) * 2);
    
  FLabels[Result].Address := -1;
  FLabels[Result].IsBound := False;
  SetLength(FLabels[Result].PatchList, 0);
  Inc(FLabelCount);
end;

// === COMPLETE FLUENT INTERFACE IMPLEMENTATION ===

function TJetVM.LoadInt(const AValue: Int64): TJetVM;
var
  LConstIndex: Integer;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtInt);
    
  LConstIndex := AddConstantInternal(MakeIntConstant(AValue));
  EmitOpCode(OP_LOAD_CONST);
  EmitInt32(LConstIndex);
  Result := Self;
end;

function TJetVM.LoadUInt(const AValue: UInt64): TJetVM;
var
  LConstIndex: Integer;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtUInt);
    
  LConstIndex := AddConstantInternal(MakeUIntConstant(AValue));
  EmitOpCode(OP_LOAD_CONST);
  EmitInt32(LConstIndex);
  Result := Self;
end;

function TJetVM.LoadStr(const AValue: string): TJetVM;
var
  LConstIndex: Integer;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtStr);
    
  LConstIndex := AddConstantInternal(MakeStrConstant(AValue));
  EmitOpCode(OP_LOAD_CONST);
  EmitInt32(LConstIndex);
  Result := Self;
end;

function TJetVM.LoadBool(const AValue: Boolean): TJetVM;
var
  LConstIndex: Integer;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtBool);
    
  LConstIndex := AddConstantInternal(MakeBoolConstant(AValue));
  EmitOpCode(OP_LOAD_CONST);
  EmitInt32(LConstIndex);
  Result := Self;
end;

function TJetVM.LoadConst(const AIndex: Integer): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_LOAD_CONST);
  EmitInt32(AIndex);
  Result := Self;
end;

function TJetVM.LoadLocal(const AIndex: Integer): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_LOAD_LOCAL);
  EmitInt32(AIndex);
  Result := Self;
end;

function TJetVM.LoadGlobal(const AIndex: Integer): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_LOAD_GLOBAL);
  EmitInt32(AIndex);
  Result := Self;
end;

function TJetVM.LoadParam(const AIndex: Integer): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_LOAD_PARAM);
  EmitInt32(AIndex);
  Result := Self;
end;

function TJetVM.StoreLocal(const AIndex: Integer): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtInt); // Pop any type for now
    
  EmitOpCode(OP_STORE_LOCAL);
  EmitInt32(AIndex);
  Result := Self;
end;

function TJetVM.StoreGlobal(const AIndex: Integer): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtInt); // Pop any type for now
    
  EmitOpCode(OP_STORE_GLOBAL);
  EmitInt32(AIndex);
  Result := Self;
end;

// === INTEGER ARITHMETIC ===

function TJetVM.AddInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_ADD_INT);
  Result := Self;
end;

function TJetVM.SubInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_SUB_INT);
  Result := Self;
end;

function TJetVM.MulInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_MUL_INT);
  Result := Self;
end;

function TJetVM.DivInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_DIV_INT);
  Result := Self;
end;

function TJetVM.ModInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_MOD_INT);
  Result := Self;
end;

function TJetVM.NegInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_NEG_INT);
  Result := Self;
end;

function TJetVM.IncInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_INC_INT);
  Result := Self;
end;

function TJetVM.DecInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_DEC_INT);
  Result := Self;
end;

function TJetVM.PostIncInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_POST_INC_INT);
  Result := Self;
end;

function TJetVM.PostDecInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_POST_DEC_INT);
  Result := Self;
end;

// === UNSIGNED INTEGER ARITHMETIC ===

function TJetVM.AddUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_ADD_UINT);
  Result := Self;
end;

function TJetVM.SubUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_SUB_UINT);
  Result := Self;
end;

function TJetVM.MulUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_MUL_UINT);
  Result := Self;
end;

function TJetVM.DivUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_DIV_UINT);
  Result := Self;
end;

function TJetVM.ModUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_MOD_UINT);
  Result := Self;
end;

function TJetVM.IncUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_INC_UINT);
  Result := Self;
end;

function TJetVM.DecUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_DEC_UINT);
  Result := Self;
end;

function TJetVM.PostIncUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_POST_INC_UINT);
  Result := Self;
end;

function TJetVM.PostDecUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_POST_DEC_UINT);
  Result := Self;
end;

// === INTEGER BITWISE OPERATIONS ===

function TJetVM.AndInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_AND_INT);
  Result := Self;
end;

function TJetVM.OrInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_OR_INT);
  Result := Self;
end;

function TJetVM.XorInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_XOR_INT);
  Result := Self;
end;

function TJetVM.NotInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_NOT_INT);
  Result := Self;
end;

function TJetVM.ShlInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_SHL_INT);
  Result := Self;
end;

function TJetVM.ShrInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_SHR_INT);
  Result := Self;
end;

// === UNSIGNED INTEGER BITWISE OPERATIONS ===

function TJetVM.AndUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_AND_UINT);
  Result := Self;
end;

function TJetVM.OrUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_OR_UINT);
  Result := Self;
end;

function TJetVM.XorUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_XOR_UINT);
  Result := Self;
end;

function TJetVM.NotUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_NOT_UINT);
  Result := Self;
end;

function TJetVM.ShlUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_SHL_UINT);
  Result := Self;
end;

function TJetVM.ShrUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_SHR_UINT);
  Result := Self;
end;

// === INTEGER COMPARISONS ===

function TJetVM.EqInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_EQ_INT);
  Result := Self;
end;

function TJetVM.NeInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_NE_INT);
  Result := Self;
end;

function TJetVM.LtInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_LT_INT);
  Result := Self;
end;

function TJetVM.LeInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_LE_INT);
  Result := Self;
end;

function TJetVM.GtInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_GT_INT);
  Result := Self;
end;

function TJetVM.GeInt(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_GE_INT);
  Result := Self;
end;

// === UNSIGNED INTEGER COMPARISONS ===

function TJetVM.EqUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_EQ_UINT);
  Result := Self;
end;

function TJetVM.NeUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_NE_UINT);
  Result := Self;
end;

function TJetVM.LtUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_LT_UINT);
  Result := Self;
end;

function TJetVM.LeUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_LE_UINT);
  Result := Self;
end;

function TJetVM.GtUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_GT_UINT);
  Result := Self;
end;

function TJetVM.GeUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_GE_UINT);
  Result := Self;
end;

// === STRING OPERATIONS ===

function TJetVM.ConcatStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtStr);
  end;
  
  EmitOpCode(OP_STR_CONCAT);
  Result := Self;
end;

function TJetVM.LenStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_STR_LENGTH);
  Result := Self;
end;

function TJetVM.CopyStr(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt); // Length
    FStackTracker.Pop(jvtInt); // Start
    FStackTracker.Pop(jvtStr); // String
    FStackTracker.Push(jvtStr);
  end;
  
  EmitOpCode(OP_STR_COPY);
  Result := Self;
end;

function TJetVM.PosStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr); // Substring
    FStackTracker.Pop(jvtStr); // String
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_STR_POS);
  Result := Self;
end;

function TJetVM.UpperStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtStr);
  end;
  
  EmitOpCode(OP_STR_UPPERCASE);
  Result := Self;
end;

function TJetVM.LowerStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtStr);
  end;
  
  EmitOpCode(OP_STR_LOWERCASE);
  Result := Self;
end;

function TJetVM.TrimStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtStr);
  end;
  
  EmitOpCode(OP_STR_TRIM);
  Result := Self;
end;

function TJetVM.EqStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_EQ_STR);
  Result := Self;
end;

function TJetVM.NeStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_NE_STR);
  Result := Self;
end;

function TJetVM.LtStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_LT_STR);
  Result := Self;
end;

function TJetVM.LeStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_LE_STR);
  Result := Self;
end;

function TJetVM.GtStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_GT_STR);
  Result := Self;
end;

function TJetVM.GeStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_GE_STR);
  Result := Self;
end;

// === BOOLEAN OPERATIONS ===

function TJetVM.AndBool(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtBool);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtBool);
    FStackTracker.Pop(jvtBool);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_AND_BOOL);
  Result := Self;
end;

function TJetVM.OrBool(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtBool);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtBool);
    FStackTracker.Pop(jvtBool);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_OR_BOOL);
  Result := Self;
end;

function TJetVM.NotBool(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtBool);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtBool);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_NOT_BOOL);
  Result := Self;
end;

function TJetVM.EqBool(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtBool);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtBool);
    FStackTracker.Pop(jvtBool);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_EQ_BOOL);
  Result := Self;
end;

function TJetVM.NeBool(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtBool);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtBool);
    FStackTracker.Pop(jvtBool);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_NE_BOOL);
  Result := Self;
end;

// === POINTER OPERATIONS ===

function TJetVM.AddrOf(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    // Pop any type, push pointer
    FStackTracker.Push(jvtPointer);
  end;
  
  EmitOpCode(OP_ADDR_OF);
  Result := Self;
end;

function TJetVM.DerefPtr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtPointer);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Push(jvtPointer);
  end;
  
  EmitOpCode(OP_DEREF_PTR);
  Result := Self;
end;

function TJetVM.PtrAdd(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Push(jvtPointer);
  end;
  
  EmitOpCode(OP_PTR_ADD);
  Result := Self;
end;

function TJetVM.PtrSub(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Push(jvtPointer);
  end;
  
  EmitOpCode(OP_PTR_SUB);
  Result := Self;
end;

function TJetVM.DerefPStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtPStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPStr);
    FStackTracker.Push(jvtStr);
  end;
  
  EmitOpCode(OP_DEREF_PSTR);
  Result := Self;
end;

function TJetVM.DerefPBool(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtPBool);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPBool);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_DEREF_PBOOL);
  Result := Self;
end;

function TJetVM.NullCheck(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtPointer);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_NULL_CHECK);
  Result := Self;
end;

function TJetVM.EqPtr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtPointer);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_EQ_PTR);
  Result := Self;
end;

function TJetVM.NePtr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(2, jvtPointer);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_NE_PTR);
  Result := Self;
end;

// === TYPED POINTER OPERATIONS ===

function TJetVM.LoadPtrInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtPointer);

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Push(jvtInt);
  end;

  EmitOpCode(OP_LOAD_PTR_INT);
  Result := Self;
end;

function TJetVM.LoadPtrUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtPointer);

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Push(jvtUInt);
  end;

  EmitOpCode(OP_LOAD_PTR_UINT);
  Result := Self;
end;

function TJetVM.LoadPtrStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtPointer);

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Push(jvtStr);
  end;

  EmitOpCode(OP_LOAD_PTR_STR);
  Result := Self;
end;

function TJetVM.LoadPtrBool(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtPointer);

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Push(jvtBool);
  end;

  EmitOpCode(OP_LOAD_PTR_BOOL);
  Result := Self;
end;

function TJetVM.StorePtrInt(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Pop(jvtInt);     // Value
  end;

  EmitOpCode(OP_STORE_PTR_INT);
  Result := Self;
end;

function TJetVM.StorePtrUInt(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Pop(jvtUInt);    // Value
  end;

  EmitOpCode(OP_STORE_PTR_UINT);
  Result := Self;
end;

function TJetVM.StorePtrStr(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Pop(jvtStr);     // Value
  end;

  EmitOpCode(OP_STORE_PTR_STR);
  Result := Self;
end;

function TJetVM.StorePtrBool(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Pop(jvtBool);    // Value
  end;

  EmitOpCode(OP_STORE_PTR_BOOL);
  Result := Self;
end;

// === OFFSET POINTER OPERATIONS ===

function TJetVM.LoadOffsetInt(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Push(jvtInt);    // Result
  end;

  EmitOpCode(OP_LOAD_OFFSET_INT);
  Result := Self;
end;

function TJetVM.LoadOffsetUInt(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Push(jvtUInt);   // Result
  end;

  EmitOpCode(OP_LOAD_OFFSET_UINT);
  Result := Self;
end;

function TJetVM.LoadOffsetStr(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Push(jvtStr);    // Result
  end;

  EmitOpCode(OP_LOAD_OFFSET_STR);
  Result := Self;
end;

function TJetVM.LoadOffsetBool(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Push(jvtBool);   // Result
  end;

  EmitOpCode(OP_LOAD_OFFSET_BOOL);
  Result := Self;
end;

function TJetVM.StoreOffsetInt(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Pop(jvtInt);     // Value
  end;

  EmitOpCode(OP_STORE_OFFSET_INT);
  Result := Self;
end;

function TJetVM.StoreOffsetUInt(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Pop(jvtUInt);    // Value
  end;

  EmitOpCode(OP_STORE_OFFSET_UINT);
  Result := Self;
end;

function TJetVM.StoreOffsetStr(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Pop(jvtStr);     // Value
  end;

  EmitOpCode(OP_STORE_OFFSET_STR);
  Result := Self;
end;

function TJetVM.StoreOffsetBool(): TJetVM;
begin
  CheckCanEmit();

  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Offset
    FStackTracker.Pop(jvtPointer); // Pointer
    FStackTracker.Pop(jvtBool);    // Value
  end;

  EmitOpCode(OP_STORE_OFFSET_BOOL);
  Result := Self;
end;

// === ARRAY OPERATIONS ===

function TJetVM.DeclareFixedArray(const ALowerBound, AUpperBound: Integer; const AElementType: TJetValueType): TJetVM;
begin
  CheckCanEmit();
  
  LoadInt(ALowerBound);
  LoadInt(AUpperBound);
  LoadInt(Ord(AElementType));
  
  if FValidationLevel >= vlDevelopment then
  begin
    case AElementType of
      jvtInt: FStackTracker.Push(jvtArrayInt);
      jvtUInt: FStackTracker.Push(jvtArrayUInt);
      jvtStr: FStackTracker.Push(jvtArrayStr);
      jvtBool: FStackTracker.Push(jvtArrayBool);
    end;
  end;
  
  EmitOpCode(OP_ARRAY_DECLARE_FIXED);
  Result := Self;
end;

function TJetVM.DeclareDynamicArray(const AElementType: TJetValueType): TJetVM;
begin
  CheckCanEmit();
  
  LoadInt(Ord(AElementType));
  
  if FValidationLevel >= vlDevelopment then
  begin
    case AElementType of
      jvtInt: FStackTracker.Push(jvtArrayInt);
      jvtUInt: FStackTracker.Push(jvtArrayUInt);
      jvtStr: FStackTracker.Push(jvtArrayStr);
      jvtBool: FStackTracker.Push(jvtArrayBool);
    end;
  end;
  
  EmitOpCode(OP_ARRAY_DECLARE_DYNAMIC);
  Result := Self;
end;

function TJetVM.ArraySetLength(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt); // Length
    // Array stays on stack but is modified
  end;
  
  EmitOpCode(OP_ARRAY_SETLENGTH);
  Result := Self;
end;

function TJetVM.ArrayGet(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt); // Index
    // Array type determines result type
  end;
  
  EmitOpCode(OP_ARRAY_GET_DYNAMIC);
  Result := Self;
end;

function TJetVM.ArraySet(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    // Value, Index, Array
    FStackTracker.Pop(jvtInt); // Value type varies
    FStackTracker.Pop(jvtInt); // Index
    // Array stays on stack
  end;
  
  EmitOpCode(OP_ARRAY_SET_DYNAMIC);
  Result := Self;
end;

function TJetVM.ArrayLength(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_ARRAY_LENGTH);
  Result := Self;
end;

function TJetVM.ArrayHigh(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_ARRAY_HIGH);
  Result := Self;
end;

function TJetVM.ArrayLow(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_ARRAY_LOW);
  Result := Self;
end;

function TJetVM.ArrayAddr(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt); // Index
    FStackTracker.Push(jvtPointer);
  end;
  
  EmitOpCode(OP_ARRAY_ADDR_FIXED);
  Result := Self;
end;

// === TYPE CONVERSION ===

function TJetVM.IntToUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_INT_TO_UINT);
  Result := Self;
end;

function TJetVM.UIntToInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_UINT_TO_INT);
  Result := Self;
end;

function TJetVM.IntToStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtStr);
  end;
  
  EmitOpCode(OP_INT_TO_STR);
  Result := Self;
end;

function TJetVM.UIntToStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtUInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtUInt);
    FStackTracker.Push(jvtStr);
  end;
  
  EmitOpCode(OP_UINT_TO_STR);
  Result := Self;
end;

function TJetVM.StrToInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_STR_TO_INT);
  Result := Self;
end;

function TJetVM.StrToUInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtUInt);
  end;
  
  EmitOpCode(OP_STR_TO_UINT);
  Result := Self;
end;

function TJetVM.BoolToStr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtBool);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtBool);
    FStackTracker.Push(jvtStr);
  end;
  
  EmitOpCode(OP_BOOL_TO_STR);
  Result := Self;
end;

function TJetVM.StrToBool(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtStr);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtStr);
    FStackTracker.Push(jvtBool);
  end;
  
  EmitOpCode(OP_STR_TO_BOOL);
  Result := Self;
end;

function TJetVM.PtrToInt(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtPointer);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtPointer);
    FStackTracker.Push(jvtInt);
  end;
  
  EmitOpCode(OP_PTR_TO_INT);
  Result := Self;
end;

function TJetVM.IntToPtr(): TJetVM;
begin
  CheckCanEmit();
  ValidateStackTypes(1, jvtInt);
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);
    FStackTracker.Push(jvtPointer);
  end;
  
  EmitOpCode(OP_INT_TO_PTR);
  Result := Self;
end;

// === STACK OPERATIONS ===

function TJetVM.Push(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_PUSH);
  Result := Self;
end;

function TJetVM.Pop(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtInt); // Pop any type
    
  EmitOpCode(OP_POP);
  Result := Self;
end;

function TJetVM.Dup(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_DUP);
  Result := Self;
end;

function TJetVM.Swap(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_SWAP);
  Result := Self;
end;

function TJetVM.Rot(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_ROT);
  Result := Self;
end;

// === LABEL MANAGEMENT ===

function TJetVM.BindLabel(const ALabelId: Integer): TJetVM;
begin
  CheckCanEmit();
  if (ALabelId >= 0) and (ALabelId < FLabelCount) then
  begin
    FLabels[ALabelId].Address := FBytecodePos;
    FLabels[ALabelId].IsBound := True;
    PatchLabel(ALabelId);
  end
  else
    raise EJetVMError.CreateFmt('Invalid label ID: %d', [ALabelId]);
  Result := Self;
end;

// === CONTROL FLOW ===

function TJetVM.Jump(const ALabelId: Integer): TJetVM;
var
  LPatchIndex: Integer;
begin
  CheckCanEmit();
  EmitOpCode(OP_JMP);
  
  if (ALabelId >= 0) and (ALabelId < FLabelCount) then
  begin
    if FLabels[ALabelId].IsBound then
      EmitInt32(FLabels[ALabelId].Address)
    else
    begin
      LPatchIndex := Length(FLabels[ALabelId].PatchList);
      SetLength(FLabels[ALabelId].PatchList, LPatchIndex + 1);
      FLabels[ALabelId].PatchList[LPatchIndex] := FBytecodePos;
      EmitInt32(0); // Placeholder
    end;
  end
  else
    raise EJetVMError.CreateFmt('Invalid label ID: %d', [ALabelId]);
    
  Result := Self;
end;

function TJetVM.JumpTrue(const ALabelId: Integer): TJetVM;
var
  LPatchIndex: Integer;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtBool);
    
  EmitOpCode(OP_JMP_TRUE);
  
  if (ALabelId >= 0) and (ALabelId < FLabelCount) then
  begin
    if FLabels[ALabelId].IsBound then
      EmitInt32(FLabels[ALabelId].Address)
    else
    begin
      LPatchIndex := Length(FLabels[ALabelId].PatchList);
      SetLength(FLabels[ALabelId].PatchList, LPatchIndex + 1);
      FLabels[ALabelId].PatchList[LPatchIndex] := FBytecodePos;
      EmitInt32(0);
    end;
  end
  else
    raise EJetVMError.CreateFmt('Invalid label ID: %d', [ALabelId]);
    
  Result := Self;
end;

function TJetVM.JumpFalse(const ALabelId: Integer): TJetVM;
var
  LPatchIndex: Integer;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtBool);
    
  EmitOpCode(OP_JMP_FALSE);
  
  if (ALabelId >= 0) and (ALabelId < FLabelCount) then
  begin
    if FLabels[ALabelId].IsBound then
      EmitInt32(FLabels[ALabelId].Address)
    else
    begin
      LPatchIndex := Length(FLabels[ALabelId].PatchList);
      SetLength(FLabels[ALabelId].PatchList, LPatchIndex + 1);
      FLabels[ALabelId].PatchList[LPatchIndex] := FBytecodePos;
      EmitInt32(0);
    end;
  end
  else
    raise EJetVMError.CreateFmt('Invalid label ID: %d', [ALabelId]);
    
  Result := Self;
end;

function TJetVM.JumpZero(const ALabelId: Integer): TJetVM;
var
  LPatchIndex: Integer;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtInt);
    
  EmitOpCode(OP_JMP_ZERO);
  
  if (ALabelId >= 0) and (ALabelId < FLabelCount) then
  begin
    if FLabels[ALabelId].IsBound then
      EmitInt32(FLabels[ALabelId].Address)
    else
    begin
      LPatchIndex := Length(FLabels[ALabelId].PatchList);
      SetLength(FLabels[ALabelId].PatchList, LPatchIndex + 1);
      FLabels[ALabelId].PatchList[LPatchIndex] := FBytecodePos;
      EmitInt32(0);
    end;
  end
  else
    raise EJetVMError.CreateFmt('Invalid label ID: %d', [ALabelId]);
    
  Result := Self;
end;

function TJetVM.JumpNotZero(const ALabelId: Integer): TJetVM;
var
  LPatchIndex: Integer;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtInt);
    
  EmitOpCode(OP_JMP_NOT_ZERO);
  
  if (ALabelId >= 0) and (ALabelId < FLabelCount) then
  begin
    if FLabels[ALabelId].IsBound then
      EmitInt32(FLabels[ALabelId].Address)
    else
    begin
      LPatchIndex := Length(FLabels[ALabelId].PatchList);
      SetLength(FLabels[ALabelId].PatchList, LPatchIndex + 1);
      FLabels[ALabelId].PatchList[LPatchIndex] := FBytecodePos;
      EmitInt32(0);
    end;
  end
  else
    raise EJetVMError.CreateFmt('Invalid label ID: %d', [ALabelId]);
    
  Result := Self;
end;

function TJetVM.Call(const ALabelId: Integer): TJetVM;
var
  LPatchIndex: Integer;
begin
  CheckCanEmit();
  EmitOpCode(OP_CALL_FUNC);
  
  if (ALabelId >= 0) and (ALabelId < FLabelCount) then
  begin
    if FLabels[ALabelId].IsBound then
      EmitInt32(FLabels[ALabelId].Address)
    else
    begin
      LPatchIndex := Length(FLabels[ALabelId].PatchList);
      SetLength(FLabels[ALabelId].PatchList, LPatchIndex + 1);
      FLabels[ALabelId].PatchList[LPatchIndex] := FBytecodePos;
      EmitInt32(0);
    end;
  end
  else
    raise EJetVMError.CreateFmt('Invalid label ID: %d', [ALabelId]);
    
  Result := Self;
end;

function TJetVM.Return(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_RET);
  Result := Self;
end;

function TJetVM.ReturnValue(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtInt); // Pop return value (any type)
    
  EmitOpCode(OP_RET_VALUE);
  Result := Self;
end;

function TJetVM.EnterScope(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_ENTER_SCOPE);
  Result := Self;
end;

function TJetVM.ExitScope(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_EXIT_SCOPE);
  Result := Self;
end;

// === PARAMETER OPERATIONS ===

function TJetVM.ParamConstInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtInt);
    
  EmitOpCode(OP_PARAM_CONST_INT);
  EmitInt32(0); // Parameter index placeholder - would be set by higher-level compiler
  Result := Self;
end;

function TJetVM.ParamConstUInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtUInt);
    
  EmitOpCode(OP_PARAM_CONST_UINT);
  EmitInt32(0); // Parameter index placeholder
  Result := Self;
end;

function TJetVM.ParamConstStr(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtStr);
    
  EmitOpCode(OP_PARAM_CONST_STR);
  EmitInt32(0); // Parameter index placeholder
  Result := Self;
end;

function TJetVM.ParamConstBool(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtBool);
    
  EmitOpCode(OP_PARAM_CONST_BOOL);
  EmitInt32(0); // Parameter index placeholder
  Result := Self;
end;

function TJetVM.ParamConstPtr(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtPointer);
    
  EmitOpCode(OP_PARAM_CONST_PTR);
  EmitInt32(0); // Parameter index placeholder
  Result := Self;
end;

function TJetVM.ParamVarInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtInt);
    
  EmitOpCode(OP_PARAM_VAR_INT);
  EmitInt32(0); // Parameter index placeholder
  Result := Self;
end;

function TJetVM.ParamVarUInt(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtUInt);
    
  EmitOpCode(OP_PARAM_VAR_UINT);
  EmitInt32(0); // Parameter index placeholder
  Result := Self;
end;

function TJetVM.ParamVarStr(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtStr);
    
  EmitOpCode(OP_PARAM_VAR_STR);
  EmitInt32(0); // Parameter index placeholder
  Result := Self;
end;

function TJetVM.ParamVarBool(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtBool);
    
  EmitOpCode(OP_PARAM_VAR_BOOL);
  EmitInt32(0); // Parameter index placeholder
  Result := Self;
end;

function TJetVM.ParamVarPtr(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtPointer);
    
  EmitOpCode(OP_PARAM_VAR_PTR);
  EmitInt32(0); // Parameter index placeholder
  Result := Self;
end;

function TJetVM.ParamOutInt(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_PARAM_OUT_INT);
  EmitInt32(0); // Parameter index placeholder
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtInt);
    
  Result := Self;
end;

function TJetVM.ParamOutUInt(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_PARAM_OUT_UINT);
  EmitInt32(0); // Parameter index placeholder
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtUInt);
    
  Result := Self;
end;

function TJetVM.ParamOutStr(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_PARAM_OUT_STR);
  EmitInt32(0); // Parameter index placeholder
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtStr);
    
  Result := Self;
end;

function TJetVM.ParamOutBool(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_PARAM_OUT_BOOL);
  EmitInt32(0); // Parameter index placeholder
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtBool);
    
  Result := Self;
end;

function TJetVM.ParamOutPtr(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_PARAM_OUT_PTR);
  EmitInt32(0); // Parameter index placeholder
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Push(jvtPointer);
    
  Result := Self;
end;

// === MEMORY OPERATIONS ===

function TJetVM.Alloc(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt); // Size
    FStackTracker.Push(jvtPointer); // Allocated pointer
  end;
  
  EmitOpCode(OP_ALLOC);
  Result := Self;
end;

function TJetVM.FreeMem(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
    FStackTracker.Pop(jvtPointer); // Pointer to free
    
  EmitOpCode(OP_FREE);
  Result := Self;
end;

function TJetVM.MemCopy(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Size
    FStackTracker.Pop(jvtPointer); // Source
    FStackTracker.Pop(jvtPointer); // Destination
  end;
  
  EmitOpCode(OP_MEMCPY);
  Result := Self;
end;

function TJetVM.MemSet(): TJetVM;
begin
  CheckCanEmit();
  
  if FValidationLevel >= vlDevelopment then
  begin
    FStackTracker.Pop(jvtInt);     // Size
    FStackTracker.Pop(jvtInt);     // Value
    FStackTracker.Pop(jvtPointer); // Destination
  end;
  
  EmitOpCode(OP_MEMSET);
  Result := Self;
end;

// === VM CONTROL ===

function TJetVM.Nop(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_NOP);
  Result := Self;
end;

function TJetVM.Stop(): TJetVM;
begin
  CheckCanEmit();
  EmitOpCode(OP_HALT);
  Result := Self;
end;

// === STATE ACCESS ===

function TJetVM.GetPC(): Integer;
begin
  Result := FPC;
end;

function TJetVM.GetSP(): Integer;
begin
  Result := FSP;
end;

function TJetVM.GetStackValue(const AIndex: Integer): TJetValue;
begin
  if (AIndex >= 0) and (AIndex < FSP) then
    Result := FStack[AIndex]
  else
    RaiseVMError('Stack index out of range');
end;

function TJetVM.GetConstant(const AIndex: Integer): TJetValue;
begin
  if (AIndex >= 0) and (AIndex < Length(FConstants)) then
    Result := FConstants[AIndex]
  else
    RaiseVMError('Constant index out of range');
end;

function TJetVM.IsRunning(): Boolean;
begin
  Result := FRunning;
end;

function TJetVM.GetValidationLevel(): TJetVMValidationLevel;
begin
  Result := FValidationLevel;
end;

procedure TJetVM.SetValidationLevel(const ALevel: TJetVMValidationLevel);
begin
  FValidationLevel := ALevel;
end;

function TJetVM.BytecodeSize(): UInt64;
begin
  Result := Length(FBytecode);
end;

{ Alignment Helper Methods }

function TJetVM.GetTypeSize(const AType: TJetValueType): Integer;
begin
  case AType of
    jvtInt, jvtUInt: Result := 8;              // 64-bit integers
    jvtStr: Result := SizeOf(Pointer);         // String is a pointer
    jvtBool: Result := 1;                      // Boolean
    jvtPointer: Result := SizeOf(Pointer);     // Generic pointer
    jvtPStr: Result := SizeOf(Pointer);        // PString pointer
    jvtPBool: Result := SizeOf(Pointer);       // PBoolean pointer
    jvtArrayInt: Result := SizeOf(Pointer);    // Dynamic array is a pointer
    jvtArrayUInt: Result := SizeOf(Pointer);   // Dynamic array is a pointer
    jvtArrayStr: Result := SizeOf(Pointer);    // Dynamic array is a pointer
    jvtArrayBool: Result := SizeOf(Pointer);   // Dynamic array is a pointer
    else Result := SizeOf(Pointer);            // Safe default
  end;
end;

function TJetVM.GetTypeAlignment(const AType: TJetValueType): Integer;
begin
  case AType of
    jvtInt, jvtUInt: Result := 8;              // 8-byte aligned on 64-bit
    jvtStr, jvtPointer: Result := SizeOf(Pointer); // Pointer aligned
    jvtPStr, jvtPBool: Result := SizeOf(Pointer);  // Pointer aligned
    jvtArrayInt, jvtArrayUInt: Result := SizeOf(Pointer); // Pointer aligned
    jvtArrayStr, jvtArrayBool: Result := SizeOf(Pointer); // Pointer aligned
    jvtBool: Result := 1;                      // No alignment requirement
    else Result := SizeOf(Pointer);            // Safe default
  end;
end;

function TJetVM.AlignOffset(const AOffset, AAlignment: Integer): Integer;
begin
  if AAlignment <= 1 then
    Result := AOffset
  else
    Result := (AOffset + AAlignment - 1) and not (AAlignment - 1);
end;

function TJetVM.CalculateStructSize(const AFieldTypes: array of TJetValueType): Integer;
var
  LIndex: Integer;
  LCurrentOffset: Integer;
  LFieldSize: Integer;
  LFieldAlignment: Integer;
begin
  LCurrentOffset := 0;

  // Calculate offset for each field with proper alignment
  for LIndex := 0 to High(AFieldTypes) do
  begin
    LFieldAlignment := GetTypeAlignment(AFieldTypes[LIndex]);
    LCurrentOffset := AlignOffset(LCurrentOffset, LFieldAlignment);

    LFieldSize := GetTypeSize(AFieldTypes[LIndex]);
    LCurrentOffset := LCurrentOffset + LFieldSize;
  end;

  // Align the total size to the strictest alignment requirement
  LFieldAlignment := SizeOf(Pointer); // Default struct alignment
  for LIndex := 0 to High(AFieldTypes) do
  begin
    LFieldAlignment := Max(LFieldAlignment, GetTypeAlignment(AFieldTypes[LIndex]));
  end;

  Result := AlignOffset(LCurrentOffset, LFieldAlignment);
end;

procedure TJetVM.Step();
begin
  if FPC < Length(FBytecode) then
  begin
    FRunning := True;
    ExecuteCore();
    FRunning := False;
  end;
end;

procedure TJetVM.DumpStack();
var
  LIndex: Integer;
begin
  Writeln('=== STACK DUMP ===');
  Writeln('SP: ', FSP);
  for LIndex := 0 to FSP - 1 do
  begin
    Write('Stack[', LIndex, ']: ');
    case FStack[LIndex].ValueType of
      jvtInt:     Writeln('Int64(', FStack[LIndex].IntValue, ')');
      jvtUInt:    Writeln('UInt64(', FStack[LIndex].UIntValue, ')');
      jvtStr:     Writeln('String("', FStack[LIndex].StrValue, '")');
      jvtBool:    Writeln('Boolean(', FStack[LIndex].BoolValue, ')');
      jvtPStr:    Writeln('PString(', IntPtr(FStack[LIndex].PStrValue), ')');
      jvtPBool:   Writeln('PBoolean(', IntPtr(FStack[LIndex].PBoolValue), ')');
      jvtPointer: Writeln('Pointer(', IntPtr(FStack[LIndex].PtrValue), ')');
      jvtArrayInt: Writeln('Array[Int64] Length(', Length(FStack[LIndex].ArrayIntValue), ')');
      jvtArrayUInt: Writeln('Array[UInt64] Length(', Length(FStack[LIndex].ArrayUIntValue), ')');
      jvtArrayStr: Writeln('Array[String] Length(', Length(FStack[LIndex].ArrayStrValue), ')');
      jvtArrayBool: Writeln('Array[Boolean] Length(', Length(FStack[LIndex].ArrayBoolValue), ')');
    end;
  end;
  Writeln('================');
end;

procedure TJetVM.DumpConstants();
var
  LIndex: Integer;
begin
  Writeln('=== CONSTANTS DUMP ===');
  for LIndex := 0 to High(FConstants) do
  begin
    Write('Const[', LIndex, ']: ');
    case FConstants[LIndex].ValueType of
      jvtInt:     Writeln('Int64(', FConstants[LIndex].IntValue, ')');
      jvtUInt:    Writeln('UInt64(', FConstants[LIndex].UIntValue, ')');
      jvtStr:     Writeln('String("', FConstants[LIndex].StrValue, '")');
      jvtBool:    Writeln('Boolean(', FConstants[LIndex].BoolValue, ')');
      jvtPointer: Writeln('Pointer(', IntPtr(FConstants[LIndex].PtrValue), ')');
      jvtArrayInt: Writeln('Array[Int64] Length(', Length(FConstants[LIndex].ArrayIntValue), ')');
      jvtArrayUInt: Writeln('Array[UInt64] Length(', Length(FConstants[LIndex].ArrayUIntValue), ')');
      jvtArrayStr: Writeln('Array[String] Length(', Length(FConstants[LIndex].ArrayStrValue), ')');
      jvtArrayBool: Writeln('Array[Boolean] Length(', Length(FConstants[LIndex].ArrayBoolValue), ')');
    end;
  end;
  Writeln('====================');
end;

function TJetVM.DisassembleInstruction(const APC: Integer): string;
var
  LOpCode: TJetOpCode;
  LTempPC: Integer;
  LValue: Integer;
begin
  if APC < Length(FBytecode) then
  begin
    LOpCode := TJetOpCode(FBytecode[APC]);
    LTempPC := APC + 1;

    case LOpCode of
      OP_LOAD_CONST, OP_LOAD_LOCAL, OP_LOAD_GLOBAL, OP_LOAD_PARAM,
      OP_STORE_LOCAL, OP_STORE_GLOBAL:
      begin
        if LTempPC + 4 <= Length(FBytecode) then
        begin
          LValue := PInteger(@FBytecode[LTempPC])^;
          Result := Format('PC=%d: %s %d', [APC, GetEnumName(TypeInfo(TJetOpCode), Ord(LOpCode)), LValue]);
        end
        else
          Result := Format('PC=%d: %s <incomplete>', [APC, GetEnumName(TypeInfo(TJetOpCode), Ord(LOpCode))]);
      end;

      OP_CALL_FUNC_BY_NAME, OP_CALL_NATIVE, OP_SETUP_CALL:
      begin
        if LTempPC + 4 <= Length(FBytecode) then
        begin
          LValue := PInteger(@FBytecode[LTempPC])^;
          if LOpCode = OP_CALL_FUNC_BY_NAME then
          begin
            if (LValue >= 0) and (LValue < FFunctionRegistry.GetFunctionCount()) then
              Result := Format('PC=%d: %s %d (%s)', [APC, GetEnumName(TypeInfo(TJetOpCode), Ord(LOpCode)),
                LValue, FFunctionRegistry.GetFunction(LValue).Name])
            else
              Result := Format('PC=%d: %s %d (invalid)', [APC, GetEnumName(TypeInfo(TJetOpCode), Ord(LOpCode)), LValue]);
          end
          else
            Result := Format('PC=%d: %s %d', [APC, GetEnumName(TypeInfo(TJetOpCode), Ord(LOpCode)), LValue]);
        end
        else
          Result := Format('PC=%d: %s <incomplete>', [APC, GetEnumName(TypeInfo(TJetOpCode), Ord(LOpCode))]);
      end;

      else
        Result := Format('PC=%d: %s', [APC, GetEnumName(TypeInfo(TJetOpCode), Ord(LOpCode))]);
    end;
  end
  else
    Result := 'PC out of range';
end;
procedure TJetVM.RaiseVMError(const AMessage: string);
begin
  raise EJetVMError.CreateFmt('VM Error at PC=%d: %s', [FPC, AMessage]);
end;

procedure TJetVM.CheckStackUnderflow(const ARequired: Integer);
begin
  if FSP < ARequired then
    RaiseVMError('Stack underflow');
end;

procedure TJetVM.CheckStackOverflow();
begin
  if FSP >= Length(FStack) then
    RaiseVMError('Stack overflow');
end;

{ Bounds Checking Helper Methods }

procedure TJetVM.RegisterAllocation(const APtr: Pointer; const ASize: Integer);
var
  LIndex: Integer;
begin
  // Only track allocations in development/safe modes
  if FValidationLevel < vlDevelopment then
    Exit;

  if APtr = nil then
    Exit;

  // Expand bounds table if needed
  if FBoundsCount >= Length(FBoundsTable) then
  begin
    if Length(FBoundsTable) = 0 then
      SetLength(FBoundsTable, 32)
    else
      SetLength(FBoundsTable, Length(FBoundsTable) * 2);
  end;

  // Check if allocation already exists (replace it)
  for LIndex := 0 to FBoundsCount - 1 do
  begin
    if FBoundsTable[LIndex].Ptr = APtr then
    begin
      FBoundsTable[LIndex].Size := ASize;
      Exit;
    end;
  end;

  // Add new allocation
  FBoundsTable[FBoundsCount].Ptr := APtr;
  FBoundsTable[FBoundsCount].Size := ASize;
  Inc(FBoundsCount);
end;

procedure TJetVM.UnregisterAllocation(const APtr: Pointer);
var
  LIndex: Integer;
begin
  // Only track allocations in development/safe modes
  if FValidationLevel < vlDevelopment then
    Exit;

  if APtr = nil then
    Exit;

  // Find and remove allocation
  for LIndex := 0 to FBoundsCount - 1 do
  begin
    if FBoundsTable[LIndex].Ptr = APtr then
    begin
      // Move last entry to this position
      if LIndex < FBoundsCount - 1 then
        FBoundsTable[LIndex] := FBoundsTable[FBoundsCount - 1];
      Dec(FBoundsCount);
      Exit;
    end;
  end;
end;

function TJetVM.GetAllocationSize(const APtr: Pointer): Integer;
var
  LIndex: Integer;
begin
  Result := -1; // Unknown size

  // Only track allocations in development/safe modes
  if FValidationLevel < vlDevelopment then
    Exit;

  if APtr = nil then
    Exit;

  // Find allocation
  for LIndex := 0 to FBoundsCount - 1 do
  begin
    if FBoundsTable[LIndex].Ptr = APtr then
    begin
      Result := FBoundsTable[LIndex].Size;
      Exit;
    end;
  end;
end;

procedure TJetVM.CheckBounds(const APtr: Pointer; const AOffset, AAccessSize: Integer);
var
  LAllocSize: Integer;
begin
  // Only check bounds in safe mode
  if FValidationLevel < vlSafe then
    Exit;

  if APtr = nil then
    RaiseVMError('Null pointer access');

  if AOffset < 0 then
    RaiseVMError(Format('Negative offset access: %d', [AOffset]));

  LAllocSize := GetAllocationSize(APtr);
  if LAllocSize > 0 then // Known allocation
  begin
    if AOffset + AAccessSize > LAllocSize then
      RaiseVMError(Format('Bounds violation: accessing %d bytes at offset %d, but allocation is only %d bytes',
        [AAccessSize, AOffset, LAllocSize]));
  end;
  // If allocation size unknown, we can't check bounds (allow it)
end;

procedure TJetVM.ClearBoundsTable();
begin
  FBoundsCount := 0;
  SetLength(FBoundsTable, 0);
end;

{ TJetFunctionRegistry }

constructor TJetFunctionRegistry.Create();
begin
  inherited Create();
  FFunctionCount := 0;
  SetLength(FFunctions, 16); // Initial capacity
end;

destructor TJetFunctionRegistry.Destroy();
begin
  SetLength(FFunctions, 0);
  inherited Destroy();
end;

function TJetFunctionRegistry.RegisterFunction(const ASignature: TJetFunctionSignature): Integer;
begin
  if FFunctionCount >= Length(FFunctions) then
    SetLength(FFunctions, Length(FFunctions) * 2);

  Result := FFunctionCount;
  FFunctions[Result] := ASignature;
  Inc(FFunctionCount);
end;

function TJetFunctionRegistry.FindFunction(const AName: string): Integer;
var
  LIndex: Integer;
begin
  Result := -1;
  for LIndex := 0 to FFunctionCount - 1 do
  begin
    if FFunctions[LIndex].Name = AName then
    begin
      Result := LIndex;
      Break;
    end;
  end;
end;

function TJetFunctionRegistry.GetFunction(const AIndex: Integer): TJetFunctionSignature;
begin
  if (AIndex >= 0) and (AIndex < FFunctionCount) then
    Result := FFunctions[AIndex]
  else
    raise EJetVMError.CreateFmt('Invalid function index: %d', [AIndex]);
end;

function TJetFunctionRegistry.GetFunctionCount(): Integer;
begin
  Result := FFunctionCount;
end;

end.