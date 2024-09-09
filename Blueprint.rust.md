## Plans 
\
#### **Project Concept: A Simple Binary File Analyzer**
The tool could read binary files (like executables, images, etc.), and give you information about the structure or contents of the file, like:
- File size
- Byte frequency (how often each byte appears)
- Data entropy (for funsies, to show how random the file data is)
- Hex dump (a simple representation of the binary data in hex form)


### Modular Style 

- Module for File size detection
	- [[file_size]]
- Module for Byte Frequency 
- Module for Data entropy 
- Module for Hex dump 
- Module that handles user interfaces either a TUI or command 


```c
cargo new ryzer
```
#### File structure 

```C
binary-analyzer/             # Project root
├── Cargo.toml               # Cargo manifest file
├── src/
│   ├── main.rs              # Main entry point for the Rust program
│   ├── file_size.rs         # Module for file size detection
│   ├── byte_frequency.rs    # Module for byte frequency calculation
│   ├── data_entropy.rs      # Module for data entropy calculation
│   ├── hex_dump.rs          # Module for hex dump
│   └── ui.rs                # Module for user interface (TUI or command-line)
├── C/                       # C programs for testing
│   └── byte_size_test.c     # C program that tests different byte sizes
├── C++/                     # C++ programs for testing
│   └── byte_size_test.cpp   # C++ program that tests different byte sizes
└── tests/                   # Directory for test cases
    └── integration.rs       # Integration tests for the tool
```
#### Practices 

- Modular program in C++ that has different byte sizes 
- Modular program in C that has different byte sizes 
	- Basically programs in C and C++ will be used to test this tool 

