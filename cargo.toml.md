## Cargo.toml

`Cargo.toml` is a manifest file that describes your package and its dependencies[3](https://doc.rust-lang.org/cargo/guide/cargo-toml-vs-cargo-lock.html). It's written by the developer and serves several purposes:

1. Specifies metadata about the package (name, version, authors, etc.)
2. Declares dependencies and their version requirements
3. Configures build settings and features

For example, you might specify a dependency in `Cargo.toml` like this:

```toml
[dependencies]
rand = "0.8.3"
```

- This tells Cargo to use version 0.8.3 or any compatible newer version of the `rand` crate[9](https://internals.rust-lang.org/t/version-control-confusion-in-cargo-lock-and-cargo-toml/17033).
- Go has a similar feature for this



