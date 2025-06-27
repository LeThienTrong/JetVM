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

unit JetVM.Test.Strings;

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
  TTestJetVMStrings = class(TObject)
  strict private
    FVM: TJetVM;
  public
    [Setup]
    procedure Setup();
    [TearDown]
    procedure TearDown();

    // ==========================================================================
    // Basic String Operations Tests
    // ==========================================================================
    [Test]
    procedure TestStringConcatenation();
    [Test]
    procedure TestStringLength();
    [Test]
    procedure TestStringCopy();
    [Test]
    procedure TestStringPosition();
    [Test]
    procedure TestStringUppercase();
    [Test]
    procedure TestStringLowercase();
    [Test]
    procedure TestStringTrim();

    // ==========================================================================
    // String Operation Edge Cases
    // ==========================================================================
    [Test]
    procedure TestEmptyStringConcatenation();
    [Test]
    procedure TestEmptyStringLength();
    [Test]
    procedure TestEmptyStringCopy();
    [Test]
    procedure TestEmptyStringPosition();
    [Test]
    procedure TestEmptyStringCasing();
    [Test]
    procedure TestEmptyStringTrim();

    // ==========================================================================
    // String Copy Edge Cases
    // ==========================================================================
    [Test]
    procedure TestStringCopyBoundaries();
    [Test]
    procedure TestStringCopyOutOfBounds();
    [Test]
    procedure TestStringCopyZeroLength();
    [Test]
    procedure TestStringCopyNegativeParams();
    [Test]
    procedure TestStringCopyFullString();

    // ==========================================================================
    // String Position Edge Cases
    // ==========================================================================
    [Test]
    procedure TestStringPositionNotFound();
    [Test]
    procedure TestStringPositionAtStart();
    [Test]
    procedure TestStringPositionAtEnd();
    [Test]
    procedure TestStringPositionMultipleOccurrences();
    [Test]
    procedure TestStringPositionCaseSensitive();

    // ==========================================================================
    // String Operation Sequences
    // ==========================================================================
    [Test]
    procedure TestStringConcatenationChain();
    [Test]
    procedure TestStringCasingConversions();
    [Test]
    procedure TestStringTrimAndCaseOperations();
    [Test]
    procedure TestComplexStringManipulation();
    [Test]
    procedure TestStringOperationsWithCopy();

    // ==========================================================================
    // String Comparison Integration
    // ==========================================================================
    [Test]
    procedure TestStringEqualityAfterOperations();
    [Test]
    procedure TestStringComparisonAfterCasing();
    [Test]
    procedure TestStringLengthComparisons();
    [Test]
    procedure TestStringOperationsInConditionals();

    // ==========================================================================
    // Complex String Scenarios
    // ==========================================================================
    [Test]
    procedure TestStringProcessingPipeline();
    [Test]
    procedure TestStringParsingSimulation();
    [Test]
    procedure TestStringFormattingOperations();
    [Test]
    procedure TestStringValidationScenarios();

    // ==========================================================================
    // Special Characters and Unicode
    // ==========================================================================
    [Test]
    procedure TestSpecialCharacters();
    [Test]
    procedure TestWhitespaceHandling();
    [Test]
    procedure TestStringWithNumbers();
    [Test]
    procedure TestStringWithSymbols();

    // ==========================================================================
    // Performance and Memory Tests
    // ==========================================================================
    [Test]
    procedure TestLargeStringOperations();
    [Test]
    procedure TestRepeatedStringOperations();
    [Test]
    procedure TestStringMemoryUsage();
    [Test]
    procedure TestStringPerformanceOptimization();

    // ==========================================================================
    // String Constants Integration
    // ==========================================================================
    [Test]
    procedure TestStringConstantsOperations();
    [Test]
    procedure TestStringConstantsReuse();
    [Test]
    procedure TestMixedStringSourcesOperations();
    [Test]
    procedure TestStringConstantsPerformance();

    // ==========================================================================
    // Error Conditions and Validation
    // ==========================================================================
    [Test]
    procedure TestStringStackUnderflow();
    [Test]
    procedure TestStringTypeValidation();
    [Test]
    procedure TestStringOperationValidation();
    [Test]
    procedure TestStringBoundaryValidation();
  end;

implementation

// =============================================================================
// Setup and Teardown
// =============================================================================

procedure TTestJetVMStrings.Setup();
begin
  FVM := TJetVM.Create(vlBasic);
end;

procedure TTestJetVMStrings.TearDown();
begin
  FVM.Free();
  FVM := nil;
end;

// =============================================================================
// Basic String Operations Tests
// =============================================================================

procedure TTestJetVMStrings.TestStringConcatenation();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('Hello')
     .LoadStr(' World')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Hello World', LResult.StrValue, 'String concatenation should work correctly');
end;

procedure TTestJetVMStrings.TestStringLength();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('JetVM')
     .LenStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(5), LResult.IntValue, 'String length should be 5');

  FVM.Reset();

  // Test empty string length
  FVM.LoadStr('')
     .LenStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'Empty string length should be 0');
end;

procedure TTestJetVMStrings.TestStringCopy();
var
  LResult: TJetValue;
begin
  // Test Copy('Testing', 2, 4) = 'esti'
  FVM.LoadStr('Testing')
     .LoadInt(2)
     .LoadInt(4)
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('esti', LResult.StrValue, 'String copy should extract correct substring');
end;

procedure TTestJetVMStrings.TestStringPosition();
var
  LResult: TJetValue;
begin
  // Test Pos('VM', 'JetVM') = 4
  FVM.LoadStr('JetVM')
     .LoadStr('VM')
     .PosStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(4), LResult.IntValue, 'String position should be 4');

  FVM.Reset();

  // Test substring not found
  FVM.LoadStr('JetVM')
     .LoadStr('xyz')
     .PosStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'String position should be 0 when not found');
end;

procedure TTestJetVMStrings.TestStringUppercase();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('JetVM Test')
     .UpperStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('JETVM TEST', LResult.StrValue, 'String should be converted to uppercase');
end;

procedure TTestJetVMStrings.TestStringLowercase();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('JetVM Test')
     .LowerStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('jetvm test', LResult.StrValue, 'String should be converted to lowercase');
end;

procedure TTestJetVMStrings.TestStringTrim();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('  JetVM  ')
     .TrimStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('JetVM', LResult.StrValue, 'String should be trimmed of whitespace');

  FVM.Reset();

  // Test string with only whitespace
  FVM.LoadStr('   ')
     .TrimStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('', LResult.StrValue, 'Whitespace-only string should become empty');
end;

// =============================================================================
// String Operation Edge Cases
// =============================================================================

procedure TTestJetVMStrings.TestEmptyStringConcatenation();
var
  LResult: TJetValue;
begin
  // Empty + String
  FVM.LoadStr('')
     .LoadStr('Hello')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Hello', LResult.StrValue, 'Empty string concatenation should work');

  FVM.Reset();

  // String + Empty
  FVM.LoadStr('Hello')
     .LoadStr('')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Hello', LResult.StrValue, 'String + empty should work');

  FVM.Reset();

  // Empty + Empty
  FVM.LoadStr('')
     .LoadStr('')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('', LResult.StrValue, 'Empty + empty should result in empty');
end;

procedure TTestJetVMStrings.TestEmptyStringLength();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('')
     .LenStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'Empty string length should be 0');
end;

procedure TTestJetVMStrings.TestEmptyStringCopy();
var
  LResult: TJetValue;
begin
  // Copy from empty string
  FVM.LoadStr('')
     .LoadInt(1)
     .LoadInt(1)
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('', LResult.StrValue, 'Copy from empty string should return empty');
end;

procedure TTestJetVMStrings.TestEmptyStringPosition();
var
  LResult: TJetValue;
begin
  // Search in empty string
  FVM.LoadStr('')
     .LoadStr('test')
     .PosStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'Position in empty string should be 0');

  FVM.Reset();

  // Search for empty string in non-empty string - In Delphi, Pos('', 'test') = 0
  FVM.LoadStr('test')
     .LoadStr('')
     .PosStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'Empty substring position should be 0 (Delphi behavior)');
end;

procedure TTestJetVMStrings.TestEmptyStringCasing();
var
  LResult: TJetValue;
begin
  // Uppercase empty string
  FVM.LoadStr('')
     .UpperStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('', LResult.StrValue, 'Uppercase of empty string should be empty');

  FVM.Reset();

  // Lowercase empty string
  FVM.LoadStr('')
     .LowerStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('', LResult.StrValue, 'Lowercase of empty string should be empty');
end;

procedure TTestJetVMStrings.TestEmptyStringTrim();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('')
     .TrimStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('', LResult.StrValue, 'Trim of empty string should be empty');
end;

// =============================================================================
// String Copy Edge Cases
// =============================================================================

procedure TTestJetVMStrings.TestStringCopyBoundaries();
var
  LResult: TJetValue;
begin
  // Copy from start
  FVM.LoadStr('Testing')
     .LoadInt(1)
     .LoadInt(3)
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Tes', LResult.StrValue, 'Copy from start should work');

  FVM.Reset();

  // Copy to end
  FVM.LoadStr('Testing')
     .LoadInt(5)
     .LoadInt(10)  // Length exceeds string
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('ing', LResult.StrValue, 'Copy to end should work even with excess length');
end;

procedure TTestJetVMStrings.TestStringCopyOutOfBounds();
var
  LResult: TJetValue;
begin
  // Start position beyond string length
  FVM.LoadStr('Test')
     .LoadInt(10)
     .LoadInt(5)
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('', LResult.StrValue, 'Copy beyond string should return empty');
end;

procedure TTestJetVMStrings.TestStringCopyZeroLength();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('Testing')
     .LoadInt(3)
     .LoadInt(0)
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('', LResult.StrValue, 'Copy with zero length should return empty');
end;

procedure TTestJetVMStrings.TestStringCopyNegativeParams();
var
  LResult: TJetValue;
begin
  // Negative start position - In Delphi, Copy('Testing', -1, 3) typically returns first 3 chars
  FVM.LoadStr('Testing')
     .LoadInt(-1)
     .LoadInt(3)
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  // Delphi Copy with negative start typically treats it as 1, so should get 'Tes'
  Assert.AreEqual('Tes', LResult.StrValue, 'Copy with negative start should return substring from beginning');

  FVM.Reset();

  // Negative length
  FVM.LoadStr('Testing')
     .LoadInt(2)
     .LoadInt(-1)
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('', LResult.StrValue, 'Copy with negative length should return empty');
end;

procedure TTestJetVMStrings.TestStringCopyFullString();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('Testing')
     .LoadInt(1)
     .LoadInt(100)  // Excessive length
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Testing', LResult.StrValue, 'Copy with excessive length should return full string');
end;

// =============================================================================
// String Position Edge Cases
// =============================================================================

procedure TTestJetVMStrings.TestStringPositionNotFound();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('JetVM')
     .LoadStr('xyz')
     .PosStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'Position of non-existent substring should be 0');
end;

procedure TTestJetVMStrings.TestStringPositionAtStart();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('JetVM')
     .LoadStr('Jet')
     .PosStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(1), LResult.IntValue, 'Position at start should be 1');
end;

procedure TTestJetVMStrings.TestStringPositionAtEnd();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('JetVM')
     .LoadStr('VM')
     .PosStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(4), LResult.IntValue, 'Position at end should be correct');
end;

procedure TTestJetVMStrings.TestStringPositionMultipleOccurrences();
var
  LResult: TJetValue;
begin
  // Pos should return first occurrence
  FVM.LoadStr('ababab')
     .LoadStr('ab')
     .PosStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(1), LResult.IntValue, 'Position should return first occurrence');
end;

procedure TTestJetVMStrings.TestStringPositionCaseSensitive();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('JetVM')
     .LoadStr('jetvm')
     .PosStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(0), LResult.IntValue, 'Position should be case-sensitive');
end;

// =============================================================================
// String Operation Sequences
// =============================================================================

procedure TTestJetVMStrings.TestStringConcatenationChain();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('Jet')
     .LoadStr('VM')
     .ConcatStr()
     .LoadStr(' Test')
     .ConcatStr()
     .LoadStr(' Suite')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('JetVM Test Suite', LResult.StrValue, 'String concatenation chain should work');
end;

procedure TTestJetVMStrings.TestStringCasingConversions();
var
  LResult: TJetValue;
begin
  // Test upper then lower
  FVM.LoadStr('JetVM')
     .UpperStr()
     .LowerStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('jetvm', LResult.StrValue, 'Upper then lower conversion should work');

  FVM.Reset();

  // Test lower then upper
  FVM.LoadStr('JetVM')
     .LowerStr()
     .UpperStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('JETVM', LResult.StrValue, 'Lower then upper conversion should work');
end;

procedure TTestJetVMStrings.TestStringTrimAndCaseOperations();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('  JetVM  ')
     .TrimStr()
     .UpperStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('JETVM', LResult.StrValue, 'Trim then uppercase should work');

  FVM.Reset();

  FVM.LoadStr('  Mixed Case  ')
     .UpperStr()
     .TrimStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('MIXED CASE', LResult.StrValue, 'Uppercase then trim should work');
end;

procedure TTestJetVMStrings.TestComplexStringManipulation();
var
  LResult: TJetValue;
begin
  // Complex scenario: Take a string, trim it, convert to upper, then get length
  FVM.LoadStr('  JetVM Test  ')
     .TrimStr()        // 'JetVM Test'
     .UpperStr()       // 'JETVM TEST'
     .LenStr()         // 10
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(10), LResult.IntValue, 'Complex string manipulation should work');
end;

procedure TTestJetVMStrings.TestStringOperationsWithCopy();
var
  LResult: TJetValue;
begin
  // Take substring then convert to uppercase
  FVM.LoadStr('  JetVM Test  ')
     .LoadInt(3)
     .LoadInt(5)
     .CopyStr()        // 'JetVM'
     .UpperStr()       // 'JETVM'
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('JETVM', LResult.StrValue, 'Copy then uppercase should work');
end;

// =============================================================================
// String Comparison Integration
// =============================================================================

procedure TTestJetVMStrings.TestStringEqualityAfterOperations();
var
  LResult: TJetValue;
begin
  // Compare strings after operations
  FVM.LoadStr('JetVM')
     .UpperStr()
     .LoadStr('JETVM')
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(True, LResult.BoolValue, 'String equality after operations should work');
end;

procedure TTestJetVMStrings.TestStringComparisonAfterCasing();
var
  LResult: TJetValue;
begin
  // Case-insensitive comparison simulation
  FVM.LoadStr('JetVM')
     .UpperStr()
     .LoadStr('jetvm')
     .UpperStr()
     .EqStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(True, LResult.BoolValue, 'Case-insensitive comparison should work');
end;

procedure TTestJetVMStrings.TestStringLengthComparisons();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('JetVM')
     .LenStr()
     .LoadInt(5)
     .EqInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(True, LResult.BoolValue, 'String length comparison should work');
end;

procedure TTestJetVMStrings.TestStringOperationsInConditionals();
var
  LResult: TJetValue;
  LLabel1: Integer;
  LLabel2: Integer;
begin
  LLabel1 := FVM.CreateLabel();
  LLabel2 := FVM.CreateLabel();

  // Simple conditional: check if string length equals 4
  FVM.LoadStr('Test')       // Stack: ['Test']
     .LenStr()              // Stack: [4]
     .LoadInt(4)            // Stack: [4, 4]
     .EqInt()               // Stack: [true] (4 == 4)
     .JumpFalse(LLabel1)    // Don't jump since true
     .LoadStr('Equal')      // True path: Stack: ['Equal']
     .Jump(LLabel2)         // Jump to end
     .BindLabel(LLabel1)    // False path
     .LoadStr('NotEqual')   // False path: Stack: ['NotEqual']
     .BindLabel(LLabel2)    // End label
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  // 'Test' has length 4, so should get 'Equal'
  Assert.AreEqual('Equal', LResult.StrValue, 'String operations in conditionals should work');
end;

// =============================================================================
// Complex String Scenarios
// =============================================================================

procedure TTestJetVMStrings.TestStringProcessingPipeline();
var
  LResult: TJetValue;
begin
  // Simulate processing pipeline: trim -> lowercase -> check if contains 'jet'
  FVM.LoadStr('  JetVM Framework  ')
     .TrimStr()                    // 'JetVM Framework'
     .LowerStr()                   // 'jetvm framework'
     .LoadStr('jet')
     .PosStr()                     // Position of 'jet' (should be 1)
     .LoadInt(0)
     .GtInt()                      // Check if position > 0
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(True, LResult.BoolValue, 'String processing pipeline should work');
end;

procedure TTestJetVMStrings.TestStringParsingSimulation();
var
  LResult: TJetValue;
begin
  // Simulate parsing: extract first word from sentence
  FVM.LoadStr('JetVM is great')
     .LoadStr(' ')
     .PosStr()                     // Find position of space (6)
     .LoadInt(1)
     .SubInt()                     // Position - 1 = 5 (length of first word)
     .StoreLocal(0)                // Store the length in local 0
     .LoadStr('JetVM is great')    // Push string again
     .LoadInt(1)                   // Start position
     .LoadLocal(0)                 // Load the calculated length
     .CopyStr()                    // Extract first word
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('JetVM', LResult.StrValue, 'String parsing simulation should work');
end;

procedure TTestJetVMStrings.TestStringFormattingOperations();
var
  LResult: TJetValue;
begin
  // Simulate formatting: wrap text in brackets and convert to uppercase
  FVM.LoadStr('[')
     .LoadStr('JetVM')
     .ConcatStr()
     .LoadStr(']')
     .ConcatStr()
     .UpperStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('[JETVM]', LResult.StrValue, 'String formatting operations should work');
end;

procedure TTestJetVMStrings.TestStringValidationScenarios();
var
  LResult: TJetValue;
begin
  // Validate string: check if trimmed length > 0
  FVM.LoadStr('   ')
     .TrimStr()
     .LenStr()
     .LoadInt(0)
     .GtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(False, LResult.BoolValue, 'String validation should detect empty content');

  FVM.Reset();

  FVM.LoadStr('  JetVM  ')
     .TrimStr()
     .LenStr()
     .LoadInt(0)
     .GtInt()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(True, LResult.BoolValue, 'String validation should detect valid content');
end;

// =============================================================================
// Special Characters and Unicode
// =============================================================================

procedure TTestJetVMStrings.TestSpecialCharacters();
var
  LResult: TJetValue;
begin
  // Test with special characters
  FVM.LoadStr('Hello')
     .LoadStr('!')
     .ConcatStr()
     .LoadStr('@#$%')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Hello!@#$%', LResult.StrValue, 'Special characters should be handled correctly');
end;

procedure TTestJetVMStrings.TestWhitespaceHandling();
var
  LResult: TJetValue;
begin
  // Test various whitespace characters
  FVM.LoadStr(#9 + 'Tab' + #13#10 + 'NewLine' + #32)
     .TrimStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Tab' + #13#10 + 'NewLine', LResult.StrValue, 'Whitespace handling should work correctly');
end;

procedure TTestJetVMStrings.TestStringWithNumbers();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('Version')
     .LoadStr('1.0')
     .ConcatStr()
     .LoadStr('Build123')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Version1.0Build123', LResult.StrValue, 'Strings with numbers should work correctly');
end;

procedure TTestJetVMStrings.TestStringWithSymbols();
var
  LResult: TJetValue;
begin
  FVM.LoadStr('C++')
     .LoadStr(' & ')
     .ConcatStr()
     .LoadStr('C#')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('C++ & C#', LResult.StrValue, 'Strings with programming symbols should work');
end;

// =============================================================================
// Performance and Memory Tests
// =============================================================================

procedure TTestJetVMStrings.TestLargeStringOperations();
var
  LResult: TJetValue;
  LLargeString: string;
begin
  // Create a large string
  LLargeString := StringOfChar('A', 1000);

  FVM.LoadStr(LLargeString)
     .LoadStr('B')
     .ConcatStr()
     .LenStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(1001), LResult.IntValue, 'Large string operations should work correctly');
end;

procedure TTestJetVMStrings.TestRepeatedStringOperations();
var
  LResult: TJetValue;
  LStopwatch: TStopwatch;
  LElapsedMs: Int64;
  LIndex: Integer;
begin
  LStopwatch := TStopwatch.StartNew();

  // Build a string by repeated concatenation
  FVM.LoadStr('Start');

  for LIndex := 1 to 100 do
  begin
    FVM.LoadStr('X').ConcatStr();
  end;

  FVM.LenStr().Stop();

  LStopwatch.Stop();
  LElapsedMs := LStopwatch.ElapsedMilliseconds;

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(105), LResult.IntValue, 'Repeated string operations should work correctly');
  Assert.IsTrue(LElapsedMs < 1000, Format('Repeated operations should be fast (<1s), took %dms', [LElapsedMs]));
end;

procedure TTestJetVMStrings.TestStringMemoryUsage();
var
  LResult: TJetValue;
  LConstants: TArray<TJetValue>;
begin
  // Test that string constants are managed properly
  FVM.LoadStr('Test1')
     .LoadStr('Test2')
     .LoadStr('Test1')  // Duplicate - should reuse constant
     .ConcatStr()       // 'Test2Test1'
     .LoadStr('Test2')
     .ConcatStr()       // 'Test2Test1Test2'
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Test2Test1Test2', LResult.StrValue, 'String memory usage test should work');

  // Check constants pool
  LConstants := FVM.GetConstants();
  Assert.IsTrue(Integer(Length(LConstants)) >= 2, 'String constants should be managed efficiently');
end;

procedure TTestJetVMStrings.TestStringPerformanceOptimization();
var
  LResult: TJetValue;
  LStopwatch: TStopwatch;
  LElapsedMs: Int64;
begin
  LStopwatch := TStopwatch.StartNew();

  // Test complex string operations performance
  FVM.LoadStr('  Performance Test String  ')
     .TrimStr()
     .UpperStr()
     .LoadStr('PERFORMANCE')
     .PosStr()
     .LoadInt(0)
     .GtInt()
     .Stop();

  LStopwatch.Stop();
  LElapsedMs := LStopwatch.ElapsedMilliseconds;

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(True, LResult.BoolValue, 'Performance optimization test should work');
  Assert.IsTrue(LElapsedMs < 100, Format('String operations should be fast (<100ms), took %dms', [LElapsedMs]));
end;

// =============================================================================
// String Constants Integration
// =============================================================================

procedure TTestJetVMStrings.TestStringConstantsOperations();
var
  LResult: TJetValue;
begin
  // Add constants explicitly
  FVM.AddConstant(FVM.MakeStrConstant('Constant1'));
  FVM.AddConstant(FVM.MakeStrConstant('Constant2'));

  FVM.LoadConst(0)  // First constant (index 0)
     .LoadConst(1)  // Second constant (index 1)
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('Constant1Constant2', LResult.StrValue, 'String constants operations should work');
end;

procedure TTestJetVMStrings.TestStringConstantsReuse();
var
  LResult: TJetValue;
begin
  // Use the same constant multiple times
  FVM.AddConstant(FVM.MakeStrConstant('Reused'));

  FVM.LoadConst(0)  // Same constant index 0
     .LoadConst(0)  // Same constant index 0
     .ConcatStr()
     .LoadConst(0)  // Same constant index 0
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('ReusedReusedReused', LResult.StrValue, 'String constants reuse should work');
end;

procedure TTestJetVMStrings.TestMixedStringSourcesOperations();
var
  LResult: TJetValue;
begin
  // Mix fluent interface strings with explicit constants
  FVM.AddConstant(FVM.MakeStrConstant('Constant'));

  FVM.LoadStr('Fluent')
     .LoadConst(0)  // Constant at index 0
     .ConcatStr()
     .LoadStr('Mixed')
     .ConcatStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual('FluentConstantMixed', LResult.StrValue, 'Mixed string sources should work');
end;

procedure TTestJetVMStrings.TestStringConstantsPerformance();
var
  LResult: TJetValue;
  LStopwatch: TStopwatch;
  LElapsedMs: Int64;
  LIndex: Integer;
begin
  LStopwatch := TStopwatch.StartNew();

  // Create constant once, use many times
  FVM.AddConstant(FVM.MakeStrConstant('Fast'));

  FVM.LoadStr('Start');

  for LIndex := 1 to 50 do
  begin
    FVM.LoadConst(0).ConcatStr();  // Constant at index 0
  end;

  FVM.LenStr().Stop();

  LStopwatch.Stop();
  LElapsedMs := LStopwatch.ElapsedMilliseconds;

  FVM.Execute();
  LResult := FVM.PopValue();

  Assert.AreEqual(Int64(205), LResult.IntValue, 'String constants performance test should work');
  Assert.IsTrue(LElapsedMs < 500, Format('Constants should be fast (<500ms), took %dms', [LElapsedMs]));
end;

// =============================================================================
// Error Conditions and Validation
// =============================================================================

procedure TTestJetVMStrings.TestStringStackUnderflow();
var
  LExceptionRaised: Boolean;
  LTestVM: TJetVM;
begin
  // Stack validation works better at development level
  LTestVM := TJetVM.Create(vlDevelopment);
  try
    LExceptionRaised := False;

    try
      // Try to perform string operation without enough values on stack
      LTestVM.LoadStr('Test')
             .ConcatStr()  // This should fail - needs 2 strings
             .Stop();
      LTestVM.Execute();
    except
      on E: Exception do
        LExceptionRaised := True;
    end;

    Assert.IsTrue(LExceptionRaised, 'String stack underflow should raise exception');
  finally
    LTestVM.Free();
  end;
end;

procedure TTestJetVMStrings.TestStringTypeValidation();
var
  LExceptionRaised: Boolean;
  LTestVM: TJetVM;
begin
  // Type validation only works at vlDevelopment or higher
  LTestVM := TJetVM.Create(vlDevelopment);
  try
    LExceptionRaised := False;

    try
      // Try to perform string operation on wrong type
      LTestVM.LoadInt(42)
             .LoadStr('Test')
             .ConcatStr()  // This should fail - first value is not string
             .Stop();
      LTestVM.Execute();
    except
      on E: Exception do
        LExceptionRaised := True;
    end;

    Assert.IsTrue(LExceptionRaised, 'String type validation should raise exception at development level');
  finally
    LTestVM.Free();
  end;
end;

procedure TTestJetVMStrings.TestStringOperationValidation();
var
  LExceptionRaised: Boolean;
  LTestVM: TJetVM;
begin
  // Parameter validation works at development level
  LTestVM := TJetVM.Create(vlDevelopment);
  try
    LExceptionRaised := False;

    try
      // Try string operation with insufficient parameters
      LTestVM.LoadStr('Test')
             .CopyStr()  // This should fail - needs 3 parameters (string, start, length)
             .Stop();
      LTestVM.Execute();
    except
      on E: Exception do
        LExceptionRaised := True;
    end;

    Assert.IsTrue(LExceptionRaised, 'String operation validation should raise exception');
  finally
    LTestVM.Free();
  end;
end;

procedure TTestJetVMStrings.TestStringBoundaryValidation();
var
  LResult: TJetValue;
begin
  // Test that boundary conditions are handled gracefully (not necessarily exceptions)
  FVM.LoadStr('Test')
     .LoadInt(MaxInt)
     .LoadInt(MaxInt)
     .CopyStr()
     .Stop();

  FVM.Execute();
  LResult := FVM.PopValue();

  // Should handle gracefully and return empty string or similar
  Assert.IsNotNull(LResult.StrValue, 'String boundary validation should handle gracefully');
end;

initialization
  TDUnitX.RegisterTestFixture(TTestJetVMStrings);

end.
