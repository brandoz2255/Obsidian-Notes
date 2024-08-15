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
        - **Commands:**

```C
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
```

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
    - **Questions:** Open the floor for any questions or clarifications.
    - **Next Steps:** Brief overview of what to expect in the following week.


### **Week 2: Creating Dockerfiles and Basic Images (1 Hour)**

#### **1. Recap and Objectives (5 minutes)**

- **Objective:** Review Week 1’s content and introduce the concept of Dockerfiles.
- **Content:**
    - **Recap:** Quick review of basic Docker commands and concepts.
    - **Objective:** Learn to create Dockerfiles and build custom Docker images.

#### **2. Introduction to Dockerfiles (15 minutes)**

- **Objective:** Understand the structure and purpose of a Dockerfile.
- **Content:**
    - **Dockerfile Basics:**
        - **FROM:** Base image.
        - **RUN:** Commands to run during the build.
        - **COPY/ADD:** Adding files into the image.
        - **CMD/ENTRYPOINT:** Default command to run.
        - **EXPOSE:** Ports to be opened.
    - **Example Dockerfile:**


```C
# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]
```

#### **3. Hands-On Activity: Creating Your First Dockerfile (25 minutes)**

- **Objective:** Create and build a custom Docker image.
- **Activity:**
    - **Task:**
        - **Create a Simple Dockerfile:** Use the above example to create a Python web app.
        - **Build the Image:** Run `docker build -t my-python-app .`.
        - **Run the Container:** Execute `docker run -p 4000:80 my-python-app`.
    - **Discussion:** Analyze the Dockerfile and the resulting image.

#### **4. Pushing Images to Docker Hub (10 minutes)**

- **Objective:** Learn how to share images via Docker Hub.
- **Content:**
    - **Commands:**
        - **Tag Image:** `docker tag my-python-app username/my-python-app`.
        - **Push Image:** `docker push username/my-python-app`.
    - **Verification:** Confirm that the image is available on Docker Hub.

#### **5. Q&A and Wrap-Up (5 minutes)**

- **Objective:** Address any questions and review key takeaways.
- **Content:**
    - **Review Key Points:** Recap the process of creating and pushing Docker images.
    - **Questions:** Open the floor for any questions or clarifications.
    - **Next Steps:** Preview Week 3’s focus on creating and testing containers.


### **Week 3: Creating and Testing Containers (1 Hour)**

#### **1. Recap and Objectives (5 minutes)**

- **Objective:** Review Week 2’s content and introduce the concept of container testing.
- **Content:**
    - **Recap:** Quick review of Dockerfiles and custom images.
    - **Objective:** Learn to create containers from custom images and test them.

#### **2. Creating and Running Containers (15 minutes)**

- **Objective:** Understand how to run containers from custom images.
- **Content:**
    - **Commands:**
        - **Run a Container:** `docker run -d -p 8080:80 my-python-app`.
        - **Inspect a Container:** `docker inspect container_id`.
        - **Stop and Remove Containers:** `docker stop container_id` and `docker rm container_id`.
    - **Discussion:** Differences between running and stopped containers.

#### **3. Hands-On Activity: Container Testing (25 minutes)**

- **Objective:** Test the functionality and performance of containers.
- **Activity:**
    - **Task:**
        - **Run Multiple Containers:** Deploy multiple instances of `my-python-app`.
        - **Test Connectivity:** Use `curl` or a browser to access the running containers.
        - **Load Testing:** Introduce basic load testing using tools like `ab` (ApacheBench).
    - **Discussion:** Analyze the performance and resource usage.

#### **4. Debugging Containers (10 minutes)**

- **Objective:** Learn basic debugging techniques for containers.
- **Content:**
    - **Commands:**
        - **View Logs:** `docker logs container_id`.
        - **Attach to a Running Container:** `docker exec -it container_id bash`.
        - **Inspect Issues:** Use logs and attached sessions to troubleshoot issues.
    - **Discussion:** Common issues and how to resolve them.

#### **5. Q&A and Wrap-Up (5 minutes)**

- **Objective:** Address any questions and review key takeaways.
- **Content:**
    - **Review Key Points:** Recap container creation, testing, and debugging.
    - **Questions:** Open the floor for any questions or clarifications.
    - **Next Steps:** Introduce Week 4’s focus on networking and Docker Compose.

---

### **Week 4: Docker Networking and Docker Compose (1 Hour)**

#### **1. Recap and Objectives (5 minutes)**

- **Objective:** Review Week 3’s content and introduce Docker networking and Compose.
- **Content:**
    - **Recap:** Quick review of container creation and testing.
    - **Objective:** Learn to manage container networking and orchestrate multi-container applications.

#### **2. Introduction to Docker Networking (15 minutes)**

- **Objective:** Understand Docker’s networking capabilities.
- **Content:**
    - **Network Types:**
        - **Bridge:** Default network for containers on a single host.
        - **Host:** Container shares the host’s network stack.
        - **Overlay:** Multi-host networking using a cluster of Docker engines.
    - **Commands:**
        - **List Networks:** `docker network ls`.
        - **Inspect Network:** `docker network inspect bridge`.
        - **Create Network:** `docker network create my-network`.
    - **Discussion:** How and when to use different network types.

#### **3. Introduction to Docker Compose (15 minutes)**

- **Objective:** Understand Docker Compose and its role in managing multi-container applications.
- **Content:**
    - **What is Docker Compose?**
        - Tool for defining and running multi-container Docker applications.
    - **Compose Basics:**
        - **docker-compose.yml:** YAML file that defines services, networks, and volumes.
        - **Commands:**
            - **Start Services:** `docker-compose up`.
            - **Stop Services:** `docker-compose down`.
    - **Example docker-compose.yml:**
```C
version: '3'
services:
  web:
    image: my-python-app
    ports:
      - "8080:80"
  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: example

```

#### **4. Hands-On Activity: Multi-Container Setup with Compose (20 minutes)**

- **Objective:** Build and run a multi-container application using Docker Compose.
- **Activity:**
    - **Task:**
        - **Create a Compose File:** Use the example to define a web and database service.
        - **Deploy the Application:** Run `docker-compose up` and verify both containers are running.
        - **Test Networking:** Ensure the web service can communicate with the database.
    - **Discussion:** Analyze the output and networking between containers.

#### **5. Q&A and Wrap-Up (5 minutes)**

- **Objective:** Address any questions and review key takeaways.
- **Content:**
    - **Review Key Points:** Recap Docker networking and Compose.
    - **Questions:** Open the floor for any questions or clarifications.
    - **Next Steps:** Introduce Week 5’s focus on securing Docker images and containers.

### **Week 5: Securing Docker Images and Containers (1 Hour)**

#### **1. Recap and Objectives (5 minutes)**

- **Objective:** Review Week 4’s content and introduce Docker security best practices.
- **Content:**
    - **Recap:** Quick review of Docker networking and Compose.
    - **Objective:** Learn to secure Docker images and containers.

#### **2. Docker Security Fundamentals (15 minutes)**

- **Objective:** Understand the basics of securing Docker environments.
- **Content:**
    - **Security Practices:**
        - **Minimize Image Size:** Use minimal base images.
        - **User Permissions:** Run containers as non-root users.
        - **Secrets Management:** Securely handle sensitive data.
        - **Regular Updates:** Keep images and containers up to date.
    - **Security Tools:**
        - **Docker Bench for Security:** Automate security checks.
        - **Clair:** Vulnerability scanning tool for Docker images.
    - **Commands:**
        - **Scan for Vulnerabilities:** `docker scan my-python-app`.

#### **3. Hands-On Activity: Securing a Container (25 minutes)**

- **Objective:** Apply security best practices to an existing Docker container.
- **Activity:**
    - **Task:**
        - **Minimize Image:** Refactor Dockerfile to use a smaller base image.
        - **Run as Non-Root:** Update Dockerfile to use a non-root user.
        - **Scan for Vulnerabilities:** Use `docker scan` or Clair to identify issues.
    - **Discussion:** Analyze the security posture of the updated container.

#### **4. Implementing Network Policies (10 minutes)**

- **Objective:** Learn to enforce security policies on Docker networks.
- **Content:**
    - **Network Segmentation:** Isolate containers with different security levels.
    - **Firewalls:** Configure iptables or Docker’s built-in firewall to restrict access.
    - **Commands:**
        - **Create Isolated Network:** `docker network create --internal my-secure-network`.
        - **Assign Containers:** Deploy containers to the isolated network.
    - **Discussion:** The importance of network segmentation in securing Docker environments.

#### **5. Q&A and Wrap-Up (5 minutes)**

- **Objective:** Address any questions and review key takeaways.
- **Content:**
    - **Review Key Points:** Recap Docker security practices.
    - **Questions:** Open the floor for any questions or clarifications.
    - **Next Steps:** Introduce Week 6’s focus on Kubernetes basics and environment setup.




### **Week 6: Introduction to Kubernetes and Environment Setup (1 Hour)**

#### **1. Recap and Objectives (5 minutes)**

- **Objective:** Review Week 5’s content and introduce Kubernetes.
- **Content:**
    - **Recap:** Quick review of Docker security best practices.
    - **Objective:** Understand Kubernetes basics and prepare the environment.

#### **2. Introduction to Kubernetes (15 minutes)**

- **Objective:** Understand what Kubernetes is and its role in container orchestration.
- **Content:**
    - **What is Kubernetes?**
        - Open-source platform for automating deployment, scaling, and management of containerized applications.
    - **Core Concepts:**
        - **Pods:** The smallest deployable units in Kubernetes.
        - **Services:** Expose and load-balance containers to the outside world.
        - **Deployments:** Manage the deployment of Pods.
        - **Namespaces:** Virtual clusters within a Kubernetes cluster.
    - **Comparison with Docker:** How Kubernetes builds on Docker’s capabilities.

#### **3. Kubernetes Environment Setup (20 minutes)**

- **Objective:** Set up a local Kubernetes environment.
- **Content:**
    - **Minikube Setup:**
        - Install Minikube (lightweight Kubernetes implementation).
        - **Commands:**

```C
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start
```

#### **4. Hands-On Activity: Deploying a Simple App on Kubernetes (15 minutes)**

- **Objective:** Deploy a simple application on Kubernetes.
- **Activity:**
    - **Task:**
        - **Create a Pod:** Use `kubectl run my-python-app --image=my-python-app --port=80`.
        - **Expose the Pod:** Run `kubectl expose pod my-python-app --type=NodePort`.
        - **Access the App:** Use Minikube IP and NodePort to access the running app.
    - **Discussion:** The differences between Docker and Kubernetes deployments.

#### **5. Q&A and Wrap-Up (5 minutes)**

- **Objective:** Address any questions and review key takeaways.
- **Content:**
    - **Review Key Points:** Recap Kubernetes basics and environment setup.
    - **Questions:** Open the floor for any questions or clarifications.
    - **Next Steps:** Introduce Week 7’s focus on deploying a container with Kubernetes.

---

### **Week 7: Deploying and Managing Containers with Kubernetes (1 Hour)**

#### **1. Recap and Objectives (5 minutes)**

- **Objective:** Review Week 6’s content and focus on container deployment with Kubernetes.
- **Content:**
    - **Recap:** Quick review of Kubernetes basics.
    - **Objective:** Deploy and manage a container using Kubernetes.

#### **2. Kubernetes Deployments and Services (15 minutes)**

- **Objective:** Understand how to deploy and manage containers in Kubernetes.
- **Content:**
    - **Deployments:**
        - Define and manage Pod deployment with `Deployment` objects.
        - **Commands:** `kubectl create deployment my-deployment --image=my-python-app`.
    - **Services:**
        - Expose Pods using `Service` objects for network access.
        - **Commands:** `kubectl expose deployment my-deployment --type=LoadBalancer --port=8080`.
    - **Scaling:**
        - Scale the number of Pods based on load.
        - **Commands:** `kubectl scale deployment my-deployment --replicas=3`.
    - **Discussion:** How deployments and services work together in Kubernetes.

#### **3. Hands-On Activity: Scaling and Managing Containers (20 minutes)**

- **Objective:** Deploy, scale, and manage a containerized application.
- **Activity:**
    - **Task:**
        - **Deploy an Application:** Use the `my-python-app` image.
        - **Expose the Application:** Create a service to access the app externally.
        - **Scale the Deployment:** Adjust the replica count to handle increased load.
    - **Discussion:** Analyze the application’s performance after scaling.

#### **4. Implementing Health Checks and Autoscaling (10 minutes)**

- **Objective:** Ensure containers are healthy and scale automatically.
- **Content:**
    - **Health Checks:**
        - Configure liveness and readiness probes.
        - **Commands:**
            - Add health checks in the `Deployment` YAML.
    - **Autoscaling:**
        - Automatically scale based on CPU usage.
        - **Commands:** `kubectl autoscale deployment my-deployment --min=2 --max=5 --cpu-percent=80`.
    - **Discussion:** Importance of health checks and autoscaling for robust applications.

#### **5. Q&A and Wrap-Up (5 minutes)**

- **Objective:** Address any questions and review key takeaways.
- **Content:**
    - **Review Key Points:** Recap Kubernetes deployments and scaling.
    - **Questions:** Open the floor for any questions or clarifications.
    - **Next Steps:** Introduce Week 8’s focus on integrating all containers with Kubernetes.



### **Week 8: Integrating and Orchestrating All Containers with Kubernetes (1 Hour)**

#### **1. Recap and Objectives (5 minutes)**

- **Objective:** Review Week 7’s content and focus on integrating and orchestrating all containers.
- **Content:**
    - **Recap:** Quick review of Kubernetes container management.
    - **Objective:** Integrate and orchestrate all three containers created throughout the workshop.

#### **2. Overview of Project Containers (10 minutes)**

- **Objective:** Recap the three containers developed during the workshop.
- **Content:**
    - **Honeypot Container:** Review its purpose and setup.
    - **Security Testing Lab Container:** Recap its function and components.
    - **Incident Response Container:** Revisit its design and tools.
    - **Discussion:** How these containers can be integrated and used together.

#### **3. Hands-On Activity: Kubernetes Orchestration (35 minutes)**

- **Objective:** Integrate and orchestrate all containers with Kubernetes.
- **Activity:**
    - **Task:**
        - **Deploy All Containers:** Use Kubernetes to deploy the Honeypot, Security Testing Lab, and Incident Response containers.
        - **Set Up Networking:** Ensure the containers can communicate as needed, but maintain isolation where necessary.
        - **Selective Activation:** Implement selective container activation based on the needs (e.g., only run the Honeypot or Incident Response containers).
        - **Monitor and Test:** Ensure everything is running correctly and test the setup with simulated attacks or scenarios.
    - **Discussion:** Analyze the integration and any potential vulnerabilities or performance issues.

#### **4. Final Review and Next Steps (10 minutes)**

- **Objective:** Wrap up the workshop and discuss future projects or learning paths.
- **Content:**
    - **Review Key Points:** Recap the entire workshop from Docker basics to Kubernetes orchestration.
    - **Next Steps:** Encourage students to explore advanced Kubernetes topics, security best practices, and contribute to the final project.
    - **Questions:** Open the floor for final questions or clarifications.

#### **5. Conclusion and Feedback (5 minutes)**

- **Objective:** Conclude the workshop and gather feedback.
- **Content:**
    - **Thank Students:** Acknowledge their hard work and participation.
    - **Collect Feedback:** Request feedback on the workshop content and structure.
    - **Future Opportunities:** Discuss potential follow-up workshops or collaborative projects.