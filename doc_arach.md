
[[info]]
# Pyrachnaphobia
## 1. **Project Overview**

I am  building a web scraper/crawler backend in Python (Flask/FastAPI) and deploying it using Docker. The backend interacts with PostgreSQL and integrates with pgAdmin for database management. Prometheus and Grafana are planned for monitoring, and Kubernetes will handle orchestration.


#### Containerized services 

- PostgreSQL 
- Pgadmin 
- Grafana 
- Prometheus 
- Juice Shop 
- Watchtower
- Back end 
- Front end 

Majority managed by docker-compose to remove the necessity of manually typing docker build and run commands 

All these services orchestrated by Kubernetes (K8's) using **minikube** 

[[minikube]]

[[Kube install]]


----

#### Current code 

 **scraper.py (Web Scraper Class)**
- Contains logic for:
    
    - Dynamic content scraping with Selenium
        
    - User-Agent rotation
        
    - Proxy support
        
    - Rate limiting


**scraper_helper.py (Helper Module)**

- Handles:
    
    - Configuration loading (YAML/JSON)
        
    - Logging setup
        
    - Saving results (JSON/CSV)
        
    - Selenium WebDriver management
        

**usr.py (Testing Framework)**

- Classes for login, product scraping, vulnerability detection
    
- Automated tests using Selenium to interact with Juice Shop

### Planned  Iaas services

- Terraform (utilize AWS) | post testing
- Vagras (local VM's)
- Ansible to maintain configuration

on x11 do 

```
xhost +local:docker
```
