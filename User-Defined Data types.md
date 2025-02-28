In  Rust, user-defined data types are primarily created with two keywords 

- `struct`
- `enum`

These allows developers to create custom data types specific to their needs. 


## Structs

Structs are used to define custom data structures that group related data together. They can be defined in several ways:

Name field structs 

```rust
struct Person {
    name: String,
    age: u32,
}
```

tuple structs 

```rust
struct Point(i32, i32);
```

Unit structs without any fields 

```rust
struct Unit;
```

- [[Structs in Rust]]
## `Enums`

`Enums` allow you to define a type that can be one of several variants[6](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html). Each variant can optionally have associated data:

```rust
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}
```

- [[Enums in Rust]]
## Traits

While not strictly a data type, traits in Rust are used to define shared behavior across different types. They can be used to create trait objects, which allow for dynamic dispatch[2](https://www.possiblerust.com/guide/enum-or-trait-object):

```rust 
trait Animal {
    fn make_sound(&self);
}

struct Dog;
impl Animal for Dog {
    fn make_sound(&self) {
        println!("Woof!");
    }
}
```

## Constants and Statics

Although not user-defined types per se, constants and statics are ways to define custom values:

``` rust 
const MAX_POINTS: u32 = 100_000;
static COMPANY_NAME: &str = "Rust Corp";
```

