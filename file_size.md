### Key points to consider:

- Rust uses structs instead of classes
- We'll use the `std::fs` module for file operations
- Error handling is crucial in Rust

- struct that represents the file information 

```Rust
#[derive(Debug)]
struct FileInfo {
    name: String,
    path: String,
    size: u64,
}
```

then four functions 

- we need to put the functions in the impl FileInfo struct 
- fileInfo function 

1. `detect_file_size`: This is the main function that opens a file, reads its content, and calculates its size.

2. `FileInfo`: This struct represents the file information, including the filename and size.

3. `new`: This method creates a new `FileInfo` instance with the given filename.

```Rust
// src/file_size.rs

pub mod file_size {
    use std::fs::{File, Metadata};
    use std::io::{Read, Result};

    pub struct FileInfo {
        name: String,
        size: u64,
    }

    impl FileInfo {
        pub fn new(name: &str) -> Self {
            Self {
                name: name.to_string(),
                size: 0,
            }
        }
    }

    pub fn detect_file_size(file_path: &str) -> Result<FileInfo> {
        let file = File::open(file_path)?;
        let metadata = File::metadata(file_path)?;
        
        let mut file_info = FileInfo::new(file_path);

        // Read the first 1024 bytes to estimate the file size
        let mut buf = vec![0; 1024];
        file.read(&mut buf)?;

        file_info.size = buf.len() as u64;

        Ok(file_info)
    }
}

```

Notes ^ 


---

### **file_size Module Overview**

The `file_size` module is responsible for determining and providing information about the size of a given binary file. This module will serve as one of the core components of your binary file analyzer tool, allowing users to quickly ascertain the size of any file they analyze.
### **Responsibilities of the `file_size` Module**

1. **Retrieve File Size:**
    
    - Determine the size of a specified file in bytes.
2. **Provide File Size Information:**
    
    - Optionally, format the file size into human-readable formats (e.g., KB, MB, GB) for better user experience.
3. **Handle Errors Gracefully:**
    
    - Manage potential errors such as file not found, permission issues, or unreadable files

#### 1. `get_file_size`

**Purpose:** Retrieve the size of a file in bytes.

**Description:**

- Takes a file path as input.
- Opens the file and retrieves its metadata.
- Extracts the file size in bytes from the metadata.
- Returns the size or an appropriate error if the operation fails.

```rust
pub fn get_file_size(file_path: &str) -> Result<u64, std::io::Error>
```

#### 2. `get_file_size_human_readable`

**Purpose:** Convert the file size from bytes to a human-readable format (e.g., KB, MB, GB).


**Description:**

- Utilizes `get_file_size` to obtain the file size in bytes.
- Converts the byte size into a more understandable format.
- Returns the formatted string or an error if file size retrieval fails.

```rust
pub fn get_file_size_human_readable(file_path: &str) -> Result<String, std::io::Error>
```



#### 3. `print_file_size`

**Purpose:** Print the file size directly to the console, either in bytes or a human-readable format based on user preference.


**Description:**

- Takes a file path and a boolean indicating whether to use a human-readable format.
- Retrieves the file size using `get_file_size` or `get_file_size_human_readable`.
- Prints the size to the console.
- Returns an error if file size retrieval fails.


```rust
pub fn print_file_size(file_path: &str, human_readable: bool) -> Result<(), std::io::Error>
```

