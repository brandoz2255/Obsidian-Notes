### **Preparation Tips**

- **Week 1:** Ensure Docker is pre-installed or provide installation instructions.
- **Week 2:** Prepare Dockerfiles and basic images for students to use.
- **Week 3:** Guide students in creating and testing their first container.
- **Week 4:** Prepare a sample `docker-compose.yml` file and test networking setups.
- **Week 5:** Provide guidance on securing Docker images and containers.
- **Week 6:** Introduce Kubernetes concepts and prepare the environment.
- **Week 7:** Deploy and manage one of the containers using Kubernetes.
- **Week 8:** Integrate all three containers with Kubernetes for orchestration.



#### **Week 1: Introduction to Docker and Setup**

- **Objective:** Understand Docker and get everything set up.
- **Content:**
    - **What is Docker?** Brief overview and benefits in cybersecurity.
    - **Docker Components:** Images, containers, Dockerfile, Docker Hub.
    - **Installation:** Quick setup for Docker Desktop or Docker Engine.
    - **Basic Commands:** `docker --version`, `docker pull`, `docker run`, `docker ps`.
- **Activity:** Ensure everyone installs Docker and runs their first container (e.g., `hello-world` image).

# WEEK 1

### **Week 1: Docker Crash Course - Revised Plan (1 Hour)**

#### **1. Introduction to Docker (15 minutes)**

- **Objective:** Understand Docker’s fundamentals, history, and its importance in cybersecurity.
- **Content:**
    - **What is [[Docker]]?**
        - Definition and core concepts (containers, images, Dockerfile, Docker Hub).
    - **[[History of Docker]]:**
        - Origin story and evolution.
        - Key milestones in Docker’s development.
    - **Importance in Cybersecurity:**
        - **Isolation:** Containers isolate applications, minimizing the risk of security breaches.
        - **Consistency:** Ensures uniformity across different stages of development and deployment.
        - **Rapid Deployment:** Facilitates quick, efficient deployment and scaling.
    - **Benefits:**
        - **Flexibility:** Works across various environments.
        - **Efficiency:** Lightweight compared to VMs.
        - **Portability:** Moves seamlessly between environments.
        - **Financial Value:** Enhances job prospects and salary potential in tech roles.

#### **2. Docker Installation and Setup (15 minutes)**

- **Objective:** Install Docker and ensure it’s working on participants’ machines.
- **Content:**
    - **Ubuntu CLI Setup:**
        - **Commands**:

``` C++
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```

- - **Verification:** Run `docker --version` to confirm installation.
- **Windows GUI Setup:**
    - **Steps:**
        - Download Docker Desktop from [Docker’s website](https://www.docker.com/).
        - Follow the installation prompts.
        - **Verification:** Open PowerShell or Command Prompt and run `docker --version`.

#### **3. Basic Docker Commands and Concepts (20 minutes)**

- **Objective:** Learn and practice essential Docker commands.
- **Content:**
    - **`docker --version`:** Check Docker version.
    - **`docker pull [image]`:** Download a Docker image (e.g., `docker pull hello-world`).
    - **`docker run [image]`:** Run a container from an image (e.g., `docker run hello-world`).
    - **`docker ps`:** List running containers.
    - **Docker Basics:**
        - **Images vs. Containers:** What they are and how they differ.
        - **Dockerfile:** Brief overview of creating Docker images.

#### **4. Hands-On Activity: Running the Hello World Container (10 minutes)**

- **Objective:** Verify Docker installation and get hands-on experience.
- **Activity:**
    - **Task:**
        - **Pull the Hello World Image:** `docker pull hello-world`.
        - **Run the Hello World Container:** `docker run hello-world`.
    - **Discussion:** Explain the output and what it means.

#### **5. Q&A and Wrap-Up (10 minutes)**

- **Objective:** Address any questions and review key takeaways.
- **Content:**
    - **Review Key Points:** Recap what Docker is, why it’s useful, and basic commands.
    - **Que
    - stions:** Open the floor for any questions or clarifications.
    - **Next Steps:** Brief overview of what to expect in the following week.


## **Week 2: Docker Basics and Creating Containers**

#### **1. Review of Docker Setup (10 minutes)**

- **Objective:** Ensure everyone is comfortable with Docker installation and basic commands.
- **Content:**
    - **Recap:** Quick review of Docker installation steps and basic commands (`docker --version`, `docker pull`, `docker run`, `docker ps`).
    - **Troubleshooting:** Address any issues encountered during Week 1.

#### **2. Understanding Docker Images and Containers (15 minutes)**

- **Objective:** Learn the differences between images and containers and how to manage them.
- **Content:**
    - **Docker Images:**
        - Definition and how they are built.
        - How to search for images on Docker Hub (`docker search [keyword]`).
    - **Docker Containers:**
        - Definition and lifecycle (created, running, stopped).
        - How to inspect containers using `docker inspect`.
    - **Managing Images and Containers:**
        - **List Images:** `docker images`.
        - **Remove Images:** `docker rmi [image_id]`.
        - **List Containers:** `docker ps -a`.
        - **Remove Containers:** `docker rm [container_id]`.

#### **3. Hands-On Activity: Running and Managing Containers (20 minutes)**

- **Objective:** Practice running and managing Docker containers.
- **Activity:**
    - **Create and Run Containers:**
        - **Run a Simple Web Server:** Use `docker run -d -p 8080:80 nginx` to start an Nginx web server.
        - **Verify:** Open a web browser and go to `http://localhost:8080` to see the Nginx welcome page.
    - **Managing Containers:**
        - **List Running Containers:** `docker ps`.
        - **Stop a Container:** `docker stop [container_id]`.
        - **Remove a Container:** `docker rm [container_id]`.
    - **Inspect Containers:**
        - Use `docker inspect [container_id]` to view detailed container information.

#### **4. Introduction to Dockerfile (10 minutes)**

- **Objective:** Understand the basics of creating a Dockerfile to build custom Docker images.
- **Content:**
    - **What is a Dockerfile?**
        - Definition and purpose.
        - Basic Dockerfile structure (FROM, RUN, CMD, EXPOSE).
    - **Simple Dockerfile Example:**
        - Create a Dockerfile that builds a custom image (e.g., a simple Python app).
        - Basic Dockerfile:

```C++
FROM python:3.8-slim
COPY app.py /app/
WORKDIR /app
RUN pip install flask
CMD ["python", "app.py"]

```


#### **5. Q&A and Wrap-Up (5 minutes)**

- **Objective:** Address questions and summarize the key points of the session.
- **Content:**
    - **Review Key Points:** Recap managing images and containers, and introduce Dockerfile basics.
    - **Questions:** Open the floor for any questions or clarifications.
    - **Next Steps:** Brief overview of what to expect in Week 3.

### **Preparation Checklist**

- **Materials:**
    - Presentation slides on Docker images, containers, and Dockerfile basics.
    - Example Dockerfile and sample code for the hands-on activity.
- **Setup:**
    - Ensure all participants can access Docker Hub and run Docker commands.
    - Prepare a demo environment to illustrate creating and running containers.


## **Week 4: Docker Networking and Orchestration**

#### **1. Introduction to Docker Networking (15 minutes)**

- **Objective:** Understand how Docker manages networking and how to configure networks for containers.
- **Content:**
    - **Docker Networking Basics:**
        - **Network Types:** Overview of bridge, host, overlay, and macvlan networks.
        - **Network Drivers:** How Docker uses different network drivers.
    - **Creating and Using Docker Networks:**
        - **Create a Network:** `docker network create [network_name]`.
        - **List Networks:** `docker network ls`.
        - **Inspect a Network:** `docker network inspect [network_name]`.
        - **Connect Containers to Networks:** Use the `--network` option with `docker run`.

#### **2. Hands-On Activity: Configuring Docker Networks (20 minutes)**

- **Objective:** Practice setting up and configuring Docker networks for container communication.
- **Activity:**
    - **Create a Network:**
        - Command: `docker network create my-network`.
    - **Run Containers on the Network:**
        - Start two containers on the same network using `--network my-network` (e.g., `docker run -d --name container1 --network my-network nginx` and `docker run -d --name container2 --network my-network alpine`).
    - **Test Communication:**
        - Use `docker exec` to access one container and `ping` the other container by name (e.g., `docker exec -it container1 ping container2`).

#### **3. Introduction to Docker Compose (15 minutes)**

- **Objective:** Learn how to use Docker Compose for managing multi-container applications.
- **Content:**
    - **What is Docker Compose?**
        - Definition and benefits for defining and running multi-container Docker applications.
    - **Basic Concepts:**
        - **docker-compose.yml:** The configuration file for Docker Compose.
        - **Key Components:** Services, networks, and volumes.
    - **Simple Example:**
        - Example `docker-compose.yml` file:
```C++
version: '3'
services:
  web:
    build:
      context: ./web
    ports:
      - "8080:80"
  backend:
    build:
      context: ./backend
    depends_on:
      - db
  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: example
      MYSQL_DATABASE: mydb
```


- **Explanation of Configuration:**
            - **Build Context:** Specify where Docker should look for Dockerfiles.
            - **Ports:** Map container ports to host ports.
            - **Depends On:** Define dependencies between services.

#### **4. Hands-On Activity: Build and Run the Project (15 minutes)**

- **Objective:** Build and deploy the Dockerized web application using Docker Compose.
- **Activity:**
    - **Build and Run:**
        - **Navigate to Project Directory:** `cd web-app`.
        - **Build and Start Services:** `docker-compose up --build`.
        - **Verify:** Check if services are running (`docker-compose ps`).
    - **Testing:**
        - **Access the Web Application:** Open a browser and go to `http://localhost:8080` to see the web server.
        - **Check Backend Service:** Ensure the backend service is working and connected to the database.

#### **5. Troubleshooting and Optimization (5 minutes)**

- **Objective:** Address any issues and discuss optimization strategies.
- **Content:**
    - **Common Issues:**
        - Troubleshoot common problems (e.g., connection issues, build errors).
    - **Optimization Tips:**
        - Use smaller base images.
        - Minimize the number of layers in Dockerfiles.

#### **6. Q&A and Wrap-Up (5 minutes)**

- **Objective:** Summarize the project and address final questions.
- **Content:**
    - **Review Key Points:** Recap the project components, Docker Compose configuration, and deployment process.
    - **Questions:** Open the floor for any final questions or clarifications.



### **Week 6: Practical Project - Incident Management Dashboard**

#### **1. Introduction to the Project (10 minutes)**

- **Objective:** Introduce the final project and its relevance to cybersecurity.
- **Content:**
    - **Project Description:**
        - Build an incident management dashboard web app.
        - **Components:** Dashboard to display incidents, manage incident status, and visualize basic metrics.
    - **Cybersecurity Theme:**
        - **Incident Management:** Mimics real-world tools used for managing and tracking cybersecurity incidents.
        - **Learning Outcomes:** Understanding web app basics, Dockerizing the app, and handling data with Flask.

#### **2. Project Setup and Configuration (15 minutes)**

- **Objective:** Set up the project environment and create initial files.
- **Content:**
    - **Directory Structure:**
        - Create a project directory (e.g., `incident-dashboard/`).
        - Subdirectories: `templates/`, `static/` (for HTML, CSS).
    - **Basic Files:**
        - **HTML Template (index.html):**
```HTML
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Incident Management Dashboard</title>
  <link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
</head>
<body>
  <h1>Incident Management Dashboard</h1>
  <div id="incidents">
    <!-- Incident data will be injected here -->
  </div>
</body>
</html>

```

- **CSS (style.css):**
```CSS
body {
  font-family: Arial, sans-serif;
  margin: 20px;
}
h1 {
  color: #333;
}
#incidents {
  margin-top: 20px;
}
```

#### **3. Developing the Flask Application (15 minutes)**

- **Objective:** Set up a basic Flask app to serve the HTML page and handle data.
- **Content:**
    - **Flask Setup:**
        - **app.py:**

```Python
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
    # Example incident data
    incidents = [
        {'id': 1, 'title': 'Phishing Attack', 'status': 'Open'},
        {'id': 2, 'title': 'Malware Incident', 'status': 'Resolved'}
    ]
    return render_template('index.html', incidents=incidents)

if __name__ == '__main__':
    app.run(debug=True)
```
 -  **Explanation:**
    - Serving the `index.html` template.
    - Injecting sample incident data into the template.

#### **4. Dockerizing the Web App (10 minutes)**

- **Objective:** Create Docker configuration for the Flask app.
- **Content:**
    - **Dockerfile:**

```C++
FROM python:3.8-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["flask", "run", "--host=0.0.0.0"]
```

- Requiremennts.txt
```C++
Flask==2.1.1
```


**docker-compose.yml:**

```C++
version: '3'
services:
  web:
    build: .
    ports:
      - "5000:5000"
```

#### **5. Hands-On Activity: Building and Running the Project (10 minutes)**

- **Objective:** Build and deploy the incident management dashboard using Docker.
- **Activity:**
    - **Run Docker Compose:**
        - **Navigate to Project Directory:** `cd incident-dashboard`.
        - **Build and Start Services:** `docker-compose up --build`.
        - **Verify:** Open a browser and go to `http://localhost:5000` to view the dashboard.

#### **6. Q&A and Wrap-Up (10 minutes)**

- **Objective:** Address questions and review the project.
- **Content:**
    - **Review Key Points:** Recap the project setup, Dockerization, and deployment process.
    - **Questions:** Open the floor for any final questions or clarifications.
    - **Feedback:** Gather feedback on the workshop and discuss any future learning opportunities.