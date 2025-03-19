## Cargo.lock

`Cargo.lock` is an automatically generated file that contains exact information about your dependencies[3](https://doc.rust-lang.org/cargo/guide/cargo-toml-vs-cargo-lock.html). Its main purposes are:

1. Ensuring deterministic builds by locking dependency versions
2. Providing a snapshot of the exact dependency tree used in a successful build

`Cargo.lock` is maintained by Cargo and should not be manually edited[3](https://doc.rust-lang.org/cargo/guide/cargo-toml-vs-cargo-lock.html).