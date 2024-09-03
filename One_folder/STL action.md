- **Prepare a Dockerfile** that installs and configures all necessary services.
- **Set up a Docker Compose file** to manage multiple services and their dependencies.
- **Ensure that tools and vulnerable applications are accessible** and properly configured.


Services We are going to have 

# weak apps and machines

- Juice Shop (To attack and use tools on a JS web app)
- DVWA (to attack and use tools on a web server)
- Metasploitable 


# Tools 
- Nmap
- Nikto 
- Burp Suite 
- ZAP


Separate container for the tools is needed 

Dockerfile for the apps 
```bash 
# Use an official Ubuntu image as a base
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
  git \
  nginx \
  apache2 \
  mysql-server \
  nodejs \
  npm \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Install OWASP Juice Shop
RUN git clone https://github.com/juice-shop/juice-shop.git \
  && cd juice-shop \
  && npm install

# Install DVWA
RUN cd /var/www/html \
  && git clone https://github.com/digininja/DVWA.git \
  && cd DVWA \
  && cp config/config.inc.php.dist config/config.inc.php \
  && sed -i "s/^\$db_password = '';$/\$db_password = 'password';/" config/config.inc.php

# Set up default ports
EXPOSE 3000 80

# Copy configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY apache2.conf /etc/apache2/apache2.conf

# Start services
CMD service nginx start && \
    service apache2 start && \
    cd juice-shop && npm start && \
    tail -f /dev/null
```


Docker file Example of the tools 

```Bash 
# Use an official Ubuntu image as a base
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
  nmap \
  git \
  wget \
  openjdk-11-jdk \
  curl \
  && rm -rf /var/lib/apt/lists/*

# Install OWASP ZAP
RUN wget https://github.com/zaproxy/zaproxy/releases/download/v2.11.1/ZAP_2.11.1_Linux.tar.gz \
  && tar -xzf ZAP_2.11.1_Linux.tar.gz \
  && mv ZAP_2.11.1 /opt/zap

# Install Burp Suite
RUN wget https://portswigger.net/burp/releases/download?product=community&version=2024.2.1&type=jar -O burpsuite.jar

# Install Nikto
RUN git clone https://github.com/sullo/nikto.git /opt/nikto

# Install Metasploit
RUN curl https://raw.githubusercontent.com/rapid7/metasploit-framework/master/scripts/msfupdate | bash

# Set up environment variables
ENV BURP_SUITE_HOME=/app/burp
ENV ZAP_HOME=/opt/zap

# Expose relevant ports
EXPOSE 8080 5000 4444

# Start services
CMD ["/bin/bash"]
```


- As well as a seperate container for Caldera for the blue team side 

