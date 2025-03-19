what I did in the docker commit 

## Docker ngircd Hardening Documentation

### Objective
To secure `ngircd` container by replacing weak passwords with strong, complex ones and saving the changes to a new Docker image.

### Steps Taken
1. **Access the Container**:
   - Used `docker exec -it ngircd /bin/sh` to enter the container.

2. **Update Weak Passwords**:
   - Opened `/etc/ngircd/ngircd.conf` to locate and update `OperatorPassword` and `Password` fields.
   - Replaced weak passwords with strong passwords:
     - `OperatorPassword = "OingoBoingo"`
     - `Password = "OingoBoingo"`

3. **Restart Service in Container**:
   - Used `pkill ngircd` and `ngircd` commands to restart the service and apply the configuration changes.

4. **Save Changes with Docker Commit**:
   - Exited the container and used `docker commit ngircd ngircd:secure` to create a new image.

5. **Restart the Container Using the New Image**:
   - Stopped and removed the original container, then launched a new container using `ngircd:secure`.

### Verification
- Tested by connecting to port 6667 to confirm the server required updated credentials.
