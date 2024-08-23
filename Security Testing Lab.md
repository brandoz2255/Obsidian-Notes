
[[STL action]]
### **1. Define Objectives**

**Objective**: Create a Docker container that hosts vulnerable applications for security testing and practice.

### **2. Choose Vulnerable Applications**

Select a set of vulnerable applications and tools that are commonly used for security testing. Here are some recommendations:

- **OWASP Juice Shop**: A modern web application intentionally designed with security vulnerabilities.
- **Damn Vulnerable Web Application (DVWA)**: A PHP/MySQL web application that is damn vulnerable.
- **Metasploitable**: A Linux-based virtual machine that contains numerous vulnerabilities.
- **VulnHub**: Provides various vulnerable applications and machines (might use this as a source for additional tools).
	- To get more machines if we like to 


Example Dockerfile

```dockerfile
# Use an official Node.js runtime as a parent image
FROM node:16

# Set the working directory in the container
WORKDIR /usr/src/app

# Install necessary packages
RUN apt-get update && apt-get install -y \
  git \
  && rm -rf /var/lib/apt/lists/*

# Clone the OWASP Juice Shop repository
RUN git clone https://github.com/juice-shop/juice-shop.git

# Change working directory to Juice Shop
WORKDIR /usr/src/app/juice-shop

# Install dependencies
RUN npm install

# Expose the application port
EXPOSE 3000

# Define the command to run the application
CMD [ "npm", "start" ]
```


```bash
docker build -t security-testing-lab .
```

```bash
docker run -d -p 3000:3000 security-testing-lab
```

```bash
docker tag security-testing-lab yourusername/security-testing-lab
```

```bash 
docker push yourusername/security-testing-lab
```

