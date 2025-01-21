- docker-compose file for setting up the server is on the google drive all we need to do now is 
- Configure Docker Compose file to create the server we want such as the basic world and give our character root credentials 
- set up a CI/CD pipeline 
- Add more mods such as 5 mods but test out the usuage for each mod added 
- first add one mod to test the CI/CD pipeline 
- Add Prometheus 
- Add Grafana
- Add another mod 


Documentation 

```yaml
services:
   3   │   minetest:
   4   │     image: lscr.io/linuxserver/minetest:latest
   5   │     container_name: minetest
   6   │     environment:
   7   │       - PUID=1000
   8   │       - PGID=1000
   9   │       - TZ=Etc/UTC
  10   │       - "CLI_ARGS=--gameid devtest" # optional
  11   │     volumes:
  12   │       - /path/to/minetest/data:/config/.minetest
  13   │     ports:
  14   │       - 30000:30000/udp
  15   │     restart: unless-stopped
  16   │ 
```


as king we have a volumes in place as you can see on line 11 we can modify sql database of our minetest server such giving others better permisions or more rules


## SQL

```sql
.schema
```

- The `auth` table contains user information:
    
    - `id`: Primary key for users.
    - `name`: Username (unique).
    - `password`: User's hashed password.
    - `last_login`: Timestamp of the last login.

- The `user_privileges` table contains user privileges:
    
    - `id`: References the `id` in the `auth` table (foreign key).
    - `privilege`: Specific privilege assigned to the user. 

#### Update privileges 

```sql
SELECT id FROM auth WHERE name = 'dulc3';
```

- Verifies users id's from `auth` such as my id in this example 

```sql
SELECT * FROM user_privileges WHERE id = (SELECT id FROM auth WHERE name = 'dulc3');
```

- checks the existing privileges for our specific users 

```sql
INSERT INTO user_privileges (id, privilege)
VALUES ((SELECT id FROM auth WHERE name = 'dulc3'), 'all');
```

- Grants all privileges to a users from the `user_privileges` section

```sql
INSERT INTO user_privileges (id, privilege)
VALUES 
((SELECT id FROM auth WHERE name = 'dulc3'), 'interact'),
((SELECT id FROM auth WHERE name = 'dulc3'), 'fly'),
((SELECT id FROM auth WHERE name = 'dulc3'), 'all');
```

- helps if there are multiple privileges like for example I found out all really does nothing in the mine test server so adding options like fly and interact manually is needed. 

```sql
SELECT * FROM user_privileges WHERE id = (SELECT id FROM auth WHERE name = 'dulc3');
```

- to verify changes

```sql
DELETE FROM user_privileges WHERE id = (SELECT id FROM auth WHERE name = 'dulc3') AND privilege = 'incorrect_privilege';
```

- used to clean up any incorrect usages of these commands 

```sql
PRAGMA table_info(auth);
```

- used to check info from a table

for quick access to the `db` 

```sql
docker exec -it minetest sqlite3 /config/.minetest/auth.sqlite
SELECT * FROM auth;
```



### CI/CD pipeline

- Using Jenkins for the usuages without Github 
- will figure out if git hub actions would be integrate however if might not be
- Docker container of Jenkins would be the easiest way to use this mess 
	- maybe besic docker commands can work such as 

```shell
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins jenkins/jenkins:lts
```

- we could compose this as well unless the need to be separate 

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'docker-compose build'
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
        }
    }
}
```

- pipeline code ^^

## Ansible 
- using playbooks to handle the configurations of this project enviroment 

```shell
project-root/
├── docker-compose.yml         # Minetest main compose file
├── services/                  # Subfolder for additional services
│   ├── jenkins/
│   │   └── docker-compose.yml
│   ├── grafana/
│   │   └── docker-compose.yml
│   ├── prometheus/
│   │   └── docker-compose.yml
├── ansible/                   # Ansible configuration directory
│   ├── playbooks/             # Folder for all playbooks
│   │   ├── deploy-minetest.yml
│   │   ├── deploy-jenkins.yml
│   │   └── deploy-devops.yml
│   ├── roles/                 # Ansible roles for modularity
│   │   ├── minetest/
│   │   │   ├── tasks/
│   │   │   │   ├── main.yml
│   │   │   │   ├── mods.yml
│   │   │   └── templates/
│   │   │       └── minetest.conf.j2
│   │   ├── jenkins/
│   │   │   ├── tasks/
│   │   │   │   └── main.yml
│   │   │   └── templates/
│   │   │       └── jenkins-config.xml.j2
│   └── inventory/             # Ansible inventory file
│       └── hosts.yml
```


we need to consider adding this

**b.** Need help securing Grafana with SSL or integrating alerts for Slack/Discord?