# Harvis Script Compiler

> Bytecode-compiled scripting language in **C++17**, inspired by TypeScript/Go with **gradual typing**.
> 
> 📁 **Repo:** `/workspace/compiler/`
> 🏷️ Tags: #compiler #language #cpp #bytecode #project

---

## Architecture Pipeline

```
Source Code → Lexer → AST → Bytecode → Stack VM → Execution
```

### Pipeline Components

| Phase | Component | Lines | Status |
|-------|-----------|-------|--------|
| 1 | **Lexer** (tokenizer) | 1,579 | ✅ Complete |
| 2 | **Parser + AST** | 1,700 | ✅ Complete |
| 3 | **Bytecode Compiler** | 800+ | ✅ Complete |
| 4 | **Stack VM** | 650+ | ✅ Recursion Fixed |
| 5 | **Standard Library** | — | 🚧 In Progress |
| 6 | **Closures & Upvalues** | — | ❌ Not Started |
| 7 | **Garbage Collection** | — | ❌ Not Started |
| — | **TOTAL** | ~4,900 | |

---

## What Works (May 2026)

- ✅ **Lexer:** Full tokenization (keywords, literals, operators, comments, unicode escapes)
- ✅ **Parser:** 20+ expression types, 15+ statement types, precedence climbing
- ✅ **Compiler:** 40+ opcodes, symbol tables, constant pool, jump patching
- ✅ **VM:** Stack-based execution, recursion (fib/factorial work), function calls
- ✅ **Classes:** Constructor, methods, inheritance (`extends`)
- ✅ **Generics:** Generic structs/functions with monomorphization
- ✅ **Concurrency:** Goroutines + channels (goroutine race conditions fixed)
- ✅ **Error handling:** try/catch/throw, defer
- ✅ **Switch/case**, break/continue, bitwise operators
- ✅ **Test suite:** `bash run_tests.sh` → 5 passed

### Recent Fixes (Checkpoint 2026-05-03)
- Recursion bug: OP_RETURN stack frame cleanup for nested calls
- OP_CALL handler: callee position corruption fix
- OP_DEFERRED_RETURN: proper deferred call stack cleanup

### Remaining Issues
1. `test_comprehensive.hs` line 73: `.length` and `.push()` not implemented
2. Array methods (length, push, pop) needed
3. Complete Phase 5 (Standard Library)

---

## Project Structure

```
compiler/
├── src/
│   ├── core/           # types.h/.cpp, error.h, scanner.h
│   ├── lexer/          # token.h/.cpp, lexer.h/.cpp
│   ├── ast/            # ast.h, ast.cpp, ast_visitor.h
│   ├── parser/         # parser.h, parser.cpp
│   ├── compiler/       # opcode.h, chunk.h, compiler.h/.cpp
│   ├── vm/             # object.h, vm.h/.cpp
│   └── main.cpp        # CLI entry point
├── stdlib/             # math.hs, strings.hs, fmt.hs
├── build/              # CMake output
├── examples/           # example .hs files
├── test_basic/         # arithmetic tests
├── test_classes/       # class tests
├── test_concurrency/   # channel/goroutine tests
├── test_exceptions/    # try/catch tests
├── test_generics/      # generic tests
├── test_modules/       # import/export tests
├── run_tests.sh        # test runner
└── Makefile            # build shortcut
```

---

## Build & Test

```bash
cd /workspace/compiler

# Build
make
# or: cmake -S . -B build && cmake --build build -j$(nproc)

# Run a script
./build/hs script.hs

# Test suite
bash run_tests.sh
```

---

## Language Features

### Variables
```hs
let x = 42;          // block-scoped, mutable
const PI = 3.14;     // block-scoped, immutable
var old = true;      // function-scoped (legacy)
```

### Functions
```hs
function add(a, b) { return a + b; }
let multiply = (a, b) => a * b;
```

### Classes
```hs
class Person {
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
    greet() { return "Hi, I'm " + this.name; }
}
let alice = new Person("Alice", 30);
```

### Generics
```hs
struct Box<T> { value: T }
let box = new Box<number> { value: 42 };

function identity<T>(x: T): T { return x; }
let result = identity<number>(100);
```

### Concurrency (Go-style)
```hs
go func() {
    channel <- "hello"
}()
msg := <-channel
```

### Control Flow
```hs
if (x > 10) { } else if (x > 5) { } else { }
while (condition) { }
for (let i = 0; i < 10; i++) { }
switch (day) { case 1: break; default: }
```

### Error Handling
```hs
try { /* risky */ } catch (e) { print(e) } finally { }
throw "error";
defer cleanup();
```

---

## Bytecode Example

**Source:**
```hs
let a = 1 + 2;
let b = 3 * 4;
let c = a + b;
```

**Bytecode:**
```
   0 | OP_CONST_NUMBER | 1    → push 1
   2 | OP_CONST_NUMBER | 2    → push 2
   4 | OP_ADD            → 3
   5 | OP_SET_LOCAL    | 0    → a = 3
   7 | OP_CONST_NUMBER | 3
   9 | OP_CONST_NUMBER | 4
  11 | OP_MULTIPLY       → 12
  12 | OP_SET_LOCAL    | 1    → b = 12
  14 | OP_GET_LOCAL    | 0    → load a
  16 | OP_GET_LOCAL    | 1    → load b
  18 | OP_ADD            → 15
  19 | OP_SET_LOCAL    | 2    → c = 15
  21 | OP_RETURN         → done
```

---

## Key Design Decisions

1. **C++17** — wide compiler support, no C++20/23 deps
2. **Stack-based VM** — simpler, denser bytecode, easier extension
3. **Gradual typing** — optional type annotations, dynamic runtime
4. **Go + TypeScript hybrid** — goroutines/channels + classes/interfaces/generics
5. **Visitor pattern** — clean AST traversal
6. **Precedence climbing** — efficient expression parsing

---

## Roadmap

- [x] Phase A: Fix broken features (try/catch, select, goroutines, imports, classes)
- [x] Phase B: New features (error handling, stdlib, performance)
- [x] Phase C: Testing & debugging (basic, exceptions, concurrency, modules, classes)
- [x] Phase D: Generics (structs, functions, monomorphization)
- [ ] Phase 5: Standard Library (Math, String, Array methods)
- [ ] Phase 6: Closures & upvalues
- [ ] Phase 7: Garbage collection
- [ ] Phase 8: Type system enforcement

---

## References

- [[Harvis Script - Implementation Status]]
- [[Harvis Script - Language Reference]]
- [[Harvis Script - Development Guide]]
- [[Harvis Script - Current Syntax]]
