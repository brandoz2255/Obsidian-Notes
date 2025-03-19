- `chmod +x autoBuild.sh`

use this command to run the bash script to build the backend live container 

- it builds and runs the docker container at port 8080 

![[Pasted image 20250220122509.png]]\

```Dockerfile
# Stage 1: Build Environment
FROM rust:1.65 as builder

# Install cargo-watch for live reloading
RUN cargo install cargo-watch

WORKDIR /usr/src/app

# Copy the dependency manifests
COPY Cargo.toml Cargo.lock ./

# Create a dummy main file to cache dependencies
RUN mkdir src && echo "fn main() { println!(\"build cache\"); }" > src/main.rs
RUN cargo build --release
RUN rm -rf src

# Stage 2: Development Environment
FROM rust:1.65

WORKDIR /usr/src/app

# Copy source code from the host (mounting this volume later will make it live)
COPY . .

# Install cargo-watch (or copy from builder stage if desired)
RUN cargo install cargo-watch

# Expose the port your backend listens on (e.g., 8080)
EXPOSE 8080

# Use cargo-watch to recompile and run on file changes
CMD ["cargo", "watch", "-x", "run"]
```

- For the back-end 


## For the Front end 

```Dockerfile
# Use the official Node.js 18 Alpine image
FROM node:18-alpine

WORKDIR /app

# Copy package files and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the source code (changes will be reflected via volume mount)
COPY . .

# Expose port 3000 (default for Next.js)
EXPOSE 3000

# Start Next.js in development mode
CMD ["npm", "run", "dev"]
```

