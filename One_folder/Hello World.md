Create a Project Directory to store Rust code but this is done for every coding project 

```bash
mkdir ~/projects
cd ~/projects
mkdir hello_world
cd hello_world
```


- Prints hello world to the console! 
```rust
fn main() {
    println!("Hello, world!");
}
```

- save the file as main.rs 
- for simple compilation 

```bash
rustc main.rs
./main
Hello, world!
```

- `rustc` compiler is  similar to the `gcc` compiler to C/C++ and clang
- However Rust compiles to binary rather than machine code meaning instead of having a direct conversation with your CPU your making a full published book that any CPU can read 

However `rustc` compiler is used for compiling single modules at a time rather than making whole ass projects that's what cargo is for. 
