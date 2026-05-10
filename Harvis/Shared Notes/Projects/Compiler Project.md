# Compiler Project — Harvis Script

> Bytecode-compiled scripting language in C++17, TypeScript/Go-inspired with gradual typing.
>
> 📁 `/workspace/compiler/`
> 🏷️ #compiler #language #cpp #bytecode #project

---

## Architecture

```
Source → Lexer → AST → Bytecode → Stack VM → Execution
```

### Phases

| # | Component | Lines | Status |
|---|-----------|-------|--------|
| 1 | Lexer (tokenizer) | 1,579 | ✅ |
| 2 | Parser + AST | 1,700 | ✅ |
| 3 | Bytecode Compiler | 800+ | ✅ |
| 4 | Stack VM | 650+ | ✅ (recursion fixed) |
| 5 | Standard Library | — | 🚧 |
| 6 | Closures & Upvalues | — | ❌ |
| 7 | Garbage Collection | — | ❌ |

**Total:** ~4,900 lines across 18 source files.

---

## What Works (May 2026)

- ✅ Full lexer: keywords, literals, operators, unicode escapes, comments
- ✅ Parser: 20+ expr types, 15+ stmt types, precedence climbing
- ✅ Compiler: 40+ opcodes, symbol tables, constant pool, jump patching
- ✅ VM: stack execution, recursion (fib/factorial), function calls
- ✅ Classes with inheritance, constructors, methods
- ✅ Generics: `struct Box<T>`, `func identity<T>()`, monomorphization
- ✅ Concurrency: goroutines + channels
- ✅ try/catch/throw, defer, switch/case, break/continue, bitwise ops
- ✅ Test runner: `bash run_tests.sh` → 5 passed

### Checkpoint 2026-05-03 Fixes
- OP_RETURN stack frame cleanup (recursion)
- OP_CALL callee position corruption
- OP_DEFERRED_RETURN deferred call stack cleanup

### Remaining Issues
1. `.length` and `.push()` on arrays not implemented
2. `test_comprehensive.hs` line 73 fails (missing array methods)
3. Phase 5 stdlib incomplete (Math, String, Array)

---

## Project Structure

```
compiler/
├── src/
│   ├── core/       # types.h/.cpp, error.h, scanner.h
│   ├── lexer/      # token.h/.cpp, lexer.h/.cpp
│   ├── ast/        # ast.h, ast.cpp, ast_visitor.h
│   ├── parser/     # parser.h, parser.cpp
│   ├── compiler/   # opcode.h, chunk.h, compiler.h/.cpp
│   ├── vm/         # object.h, vm.h/.cpp
│   └── main.cpp
├── stdlib/         # math.hs, strings.hs, fmt.hs
├── examples/
├── test_basic/     # arithmetic
├── test_classes/   # classes
├── test_concurrency/
├── test_exceptions/
├── test_generics/
├── test_modules/
├── run_tests.sh
└── Makefile
```

---

## Build & Run

```bash
cd /workspace/compiler
make
./build/hs script.hs
bash run_tests.sh
```

---

## Language Samples

### Variables & Functions
```hs
let x = 42;
const PI = 3.14;

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
```

### Concurrency (Go-style)
```hs
go func() { channel <- "hello" }()
msg := <-channel
```

### Error Handling
```hs
try { /* risky */ } catch (e) { print(e) } finally { }
throw "error";
defer cleanup();
```

---

## Bytecode Example

```hs
let a = 1 + 2;
let b = 3 * 4;
let c = a + b;
```

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

## Design Decisions

1. **C++17** — wide support, no C++20/23 deps
2. **Stack VM** — simpler, denser bytecode
3. **Gradual typing** — optional annotations, dynamic runtime
4. **Go + TS hybrid** — goroutines/channels + classes/generics
5. **Visitor pattern** — clean AST traversal
6. **Precedence climbing** — efficient expr parsing

---

## Roadmap

- [x] Fix broken features (try/catch, select, goroutines, classes)
- [x] Stdlib basics (math, strings, fmt)
- [x] Test suite (5 tests passing)
- [x] Generics (structs, functions, monomorphization)
- [ ] Array methods (`.length`, `.push`, `.pop`)
- [ ] Complete stdlib (Phase 5)
- [ ] Closures & upvalues (Phase 6)
- [ ] Garbage collection (Phase 7)
- [ ] Type system enforcement (Phase 8)

---

## Source Docs

All source docs live in `/workspace/compiler/`:
- `README.md` — full project overview
- `IMPLEMENTATION_STATUS.md` — detailed phase status
- `LANGUAGE_REFERENCE.md` — full syntax reference
- `CURRENT_SYNTAX.md` — what actually works now
- `DEVELOPMENT.md` — how to add features
- `PHASES.md` — phase plan tracking
- `CHECKPOINT_2026-05-03.md` — latest checkpoint
