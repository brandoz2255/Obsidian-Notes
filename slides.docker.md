

```ts
// next.config.ts
const nextConfig = {
  env: {
    GITHUB_USERNAME: process.env.GITHUB_USERNAME,
  },
  trailingSlash: true, // Optional: Keep if required for GitHub Pages compatibility
  // output: 'export',  // Comment out or remove to enable SSR instead of static export
};

module.exports = nextConfig;
```



```C
# Use the official Node.js image as a base
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Next.js app for production
RUN npm run build

# Expose port 3000 to allow access to the app
EXPOSE 3000

# Define the command to start the Next.js app in production
CMD ["npm", "start"]
```






Explanation:

- `FROM node:18-alpine` uses a lightweight Node.js image as the base.
- `WORKDIR /app` sets the working directory inside the container.
- `COPY package*.json ./` copies the `package.json` and `package-lock.json` files to install dependencies without copying the entire project.
- `RUN npm install` installs the dependencies.
- `COPY . .` copies the remaining application code into the container.

- `EXPOSE 3000` exposes port `3000` to allow access to the app.
- `CMD ["npm","run", "start"]` starts the Next.js application in Development mode.```











Explanation:

- build: context: `.` uses the current directory as the build context.
    
- ports: - `"3000:3000"` maps the container’s port `3000` to port `3000` on your machine.
    
- volumes: - `.:/app` mounts the current directory (.) to `/app` in the container, making local changes immediately available in the container.
    
- - `/app/node_modules` keeps the container’s node_modules separate from the host machine to prevent conflicts.
    

command: `npm run dev` runs the development server with hot-reloading.



```C
# Use the official Node.js image as a base
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./
RUN npm install

# Copy the application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Set the default command to start Next.js in development mode
CMD ["npm", "run", "dev"]
```



---


# CCDC Hands-on #1

## Session Objectives
- Master the process of gathering critical system information
- Practice efficient documentation under time pressure
- Build muscle memory for initial system assessment

## Time Breakdown (60 minutes total)

### 0-5 minutes: Initial Setup
- Teams connect to systems
- Open documentation templates
- Start timing/tracking tools

### 5-20 minutes: Windows System Assignment
**Required Information to Gather:**
- Local Administrator password Change
- Domain Administrator password Change
- List of local users and group memberships
- Running services 
- Startup items/programs
- Shared folder permissions
- Installed software list
- Windows version and patch level
- Active firewall rules
- Scheduled tasks

**Commands to Practice:**
```powershell
net user
net localgroup administrators
wmic product get name,version
netstat -ano
Get-Service | Where-Object {$_.Status -eq "Running"}
Get-ChildItem "C:\Program Files" -Recurse
Get-SmbShare -IncludeHidden
Get-NetFirewallRule | Where-Object {$_.Enabled -eq 'True'}
```

### 20-35 minutes: Linux System Assignment
**Required Information to Gather:**
- Root password
- User accounts in /etc/passwd
- SSH configuration
- Running services
- Open ports
- Installed packages
- Cron jobs
- File system mounts
- Network configuration
- Active processes

**Commands to Practice:**
```bash
cat /etc/passwd
cat /etc/shadow
ss -tulpn
ps aux
lastlog
find / -perm -4000 2>/dev/null
crontab -l
df -h
netstat -tulpn
dpkg -l || rpm -qa
```

### 35-50 minutes: Network Device Assignment
**Required Information to Document:**
- Enable/privileged password
- SNMP community strings
- Access control lists
- Interface configurations
- Routing tables
- VLAN configurations
- Logging settings
- NTP configuration (Can lead to kerb errors)
- Authentication methods
- Backup configurations

### 50-55 minutes: Documentation Review
**Checklist:**
- All passwords documented
- Network diagrams started
- Critical services identified
- Security concerns noted
- Missing information listed
- Initial action items created

### 55-60 minutes: After Action Review
- Identify information gaps
- Note time bottlenecks
- List improvement areas
- Update documentation templates

