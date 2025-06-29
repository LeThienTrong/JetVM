# JetVM: High-Performance Delphi Virtual Machine for Scripting 🚀

![JetVM](https://img.shields.io/badge/JetVM-Fast%20Delphi%20VM-blue?style=flat&logo=delphi)

Welcome to the JetVM repository! You can find the latest releases [here](https://github.com/LeThienTrong/JetVM/releases). Download and execute the files to get started.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Examples](#examples)
- [Contributing](#contributing)
- [License](#license)
- [Support](#support)

## Overview

JetVM is a high-performance, stack-based virtual machine designed for Delphi developers. It allows for efficient execution of scripts while offering a range of features that enhance its usability. With JetVM, you can embed scripting capabilities into your applications seamlessly.

## Features

- **Fast Execution**: JetVM is optimized for speed, making it suitable for applications that require quick script execution.
- **Tagged Union Values**: Supports complex data types, allowing for more versatile scripting.
- **Fluent Bytecode Generation**: Simplifies the process of generating bytecode, making it easier to develop and maintain scripts.
- **Pascal Parameter Modes**: Supports `const`, `var`, and `out` parameter modes for better function handling.
- **Validation Levels**: Offers different levels of validation to ensure script integrity.
- **Native Function Integration**: Easily integrate native Delphi functions into your scripts.
- **Memory Management**: Efficient memory handling to optimize performance.
- **Real-Time Debugging**: Debug scripts on the fly, making it easier to find and fix issues.

## Installation

To install JetVM, follow these steps:

1. **Clone the Repository**: 
   ```bash
   git clone https://github.com/LeThienTrong/JetVM.git
   ```

2. **Navigate to the Directory**:
   ```bash
   cd JetVM
   ```

3. **Build the Project**: Use your Delphi IDE to build the project. Ensure you have the necessary libraries and dependencies installed.

4. **Run the Example**: After building, you can run the example scripts provided in the `examples` folder.

## Usage

Using JetVM is straightforward. Here’s a basic example to get you started:

1. **Initialize the VM**:
   ```pascal
   var
     VM: TJetVM;
   begin
     VM := TJetVM.Create;
     try
       // Your code here
     finally
       VM.Free;
     end;
   end;
   ```

2. **Load a Script**:
   ```pascal
   VM.LoadScript('your_script.jet');
   ```

3. **Execute the Script**:
   ```pascal
   VM.Execute;
   ```

4. **Access Results**:
   ```pascal
   var
     Result: Variant;
   Result := VM.GetResult;
   ```

## Examples

Explore the `examples` folder for various scripts demonstrating JetVM's capabilities. Here are a few highlights:

### Simple Script Execution

```pascal
// Example of a simple script
var
  a: Integer;
  b: Integer;
begin
  a := 10;
  b := 20;
  Result := a + b; // Result will be 30
end;
```

### Using Native Functions

You can call native Delphi functions from your scripts. For example:

```pascal
function Add(a, b: Integer): Integer;
begin
  Result := a + b;
end;

// In your script
var
  sum: Integer;
begin
  sum := Add(5, 10); // sum will be 15
end;
```

### Real-Time Debugging

JetVM supports real-time debugging. You can set breakpoints and inspect variables during script execution. This feature is invaluable for troubleshooting complex scripts.

## Contributing

We welcome contributions to JetVM. To contribute:

1. Fork the repository.
2. Create a new branch for your feature or fix.
3. Make your changes and commit them.
4. Push your changes and create a pull request.

Please ensure your code follows the existing style and includes tests where applicable.

## License

JetVM is licensed under the MIT License. See the `LICENSE` file for more details.

## Support

For support, please check the [Issues](https://github.com/LeThienTrong/JetVM/issues) section of the repository. You can also find discussions and FAQs that may help you troubleshoot.

For the latest updates and releases, visit the [Releases](https://github.com/LeThienTrong/JetVM/releases) section. Download and execute the files to get the most recent features and fixes.

---

Feel free to explore the repository, test the features, and integrate JetVM into your Delphi projects. Happy coding!