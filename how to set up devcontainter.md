### Three options for a Devcontainer

# Option one vsCode

- This option is similar to localized `nvim` 
- install the `devcontainers` extension on `vscode`
- this runs `vscode` entirely inside a container and the `extenstion` allows you to use your regular `vscode` interface to make changes to the container 
	- same thing with cursor 


### Example of config

```json
{
  "name": "Node.js Dev Container",
  "image": "mcr.microsoft.com/devcontainers/javascript-node:20",  
  "features": {
    "ghcr.io/devcontainers/features/node:1": {
      "version": "20"
    }
  },
  "forwardPorts": [3000],
  "customizations": {
    "vscode": {
      "extensions": [
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode"
      ]
    }
  },
  "postCreateCommand": "npm install",
  "mounts": [
    "source=${localWorkspaceFolder},target=/workspace,type=bind"
  ]
}
```


### Example Dockerfile

```bash
FROM mcr.microsoft.com/devcontainers/javascript-node:20

# Install additional dependencies if needed
RUN apt-get update && apt-get install -y curl

WORKDIR /workspace
```

----

## Option Two containerized nvim

This option is a containerized `lazyvim` IDE for faster Docker startup and full containerized `enviroment`

- all within the containers shell 
