`Minikube` is a tool that allows users to run a single-node `Kubernetes` clusters locally on their machine 

- `Minikube` is a local `Kubernetes` cluster that focuses on making it easy to learn and develop for `kubernetes` 


command to find all docker compose files in the root project directory 

```bash
find . -name "docker-compose.yml" -o -name "*.yaml" -o -name "*.yml" | grep docker
```

then get the contents of the output of this command then run the automated script but if this was just one or 3 docker compose files 

for single file 

```bash
kompose --file /path/to/docker-compose.yml convert

```

multiple files 

```bash
kompose -f /path/to/docker-compose.yml -f /path/to/another-compose-file.yml convert
```

since this project has more than 3 typing all of them would be annoying especially since my `dockerized` services are only going to grow so here is python script to automate it

```python
import os

def get_file_paths():
    file_paths = []
    print("Enter file paths separated by commas or new lines. Type 'n' to stop.")

    while True:
        user_input = input("File paths (or 'n' to stop): ")
        if user_input.strip().lower() == 'n':
            break

        # Split input by commas or new lines and strip whitespace
        paths = [path.strip() for path in user_input.split(',') if path.strip()]
        for path in paths:
            if os.path.exists(path):
                file_paths.append(path)
            else:
                print(f"File {path} not found. Skipping.")

        print(f"Current valid file paths: {len(file_paths)}")

    if not file_paths:
        print("No valid file paths were provided.")
    return file_paths

def convert_compose_files(file_paths, output_directory="kube"):
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)

    for file_path in file_paths:
        print(f"Converting {file_path}...")
        os.system(f"kompose --file {file_path} convert -o {output_directory}")

def main():
    file_paths = get_file_paths()
    if not file_paths:
        print("No valid files were provided. Exiting.")
        return

    convert_compose_files(file_paths)

if __name__ == "__main__":
    main()
```

- the following script converts all the docker-compose files into a `kubernetes` manifest using `kompose`
- puts all the generated `manifest yml` files into a file called `kube`


**Note**: If there are warnings and fatal failures this means that `kompose` it self doesn't what you specified in the compose file such as 
- ports 
- networks 
- links
- etc

Thus manual intervention required research with phind and GPT to figure out the issue 


After everything is good and dandy you can deploy this command 

```bash
# There instead of manually appling each yaml file you can just them all in the directory
kubectl apply -f k8s/
```

if `kube` isn't the name where you put the manifests then change it accordingly

**TIP**: if the `kompose` didn't generate the yml file and it still having issues you can also make it your self 

once made test your file with these commands 

```bash
kubectl apply --dry-run=client -f kube/python-env.yaml
```

