`Enums`, are short for enumerations, which are a way to define the type that can be one of several variants. 

- It's like saying, **"This thing can be A, B, or C, but not anything else."**

```rust
enum TrafficLight {
    Red,
    Yellow,
    Green,
}

let current_light = TrafficLight::Red;
```

- In this example, a `TrafficLight` can only be `Red`, `Yellow`, or `Green`[3](https://www.codecademy.com/resources/docs/rust/enums).

## Enums with Data

What makes Rust's `enums` powerful is that each variant can hold different types of data:

```rust 
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}
```

- Here, `Message` can be one of four variants, each with different associated data[2](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html).

## Using Enums and Structs

Let's create a simple game character system using both `enums` and structs:

```rust
struct Character {
    name: String,
    health: u32,
    weapon: Weapon,
}

enum Weapon {
    Sword(u32),
    Bow(u32, u32),
    Staff { magic_power: u32 },
}

let hero = Character {
    name: String::from("Hero"),
    health: 100,
    weapon: Weapon::Sword(15),
};

let mage = Character {
    name: String::from("Mage"),
    health: 80,
    weapon: Weapon::Staff { magic_power: 30 },
};
```

