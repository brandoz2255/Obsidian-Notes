## 1. **Create a Secret for pgAdmin Credentials**

Create a file named **`pgadmin-secret.yaml`** that stores the default email and password in base64 encoding. For example, if you want to use:

- **Email:** admin@example.com
- **Password:** adminpassword

First, convert these values to base64 (you can use a tool or command-line, e.g., `echo -n 'admin@example.com' | base64` produces `YWRtaW5AZXhhbXBsZS5jb20=` and similarly for the password).

Your **`pgadmin-secret.yaml`** should look like this:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: pgadmin-secret
  namespace: default
type: Opaque
data:
  pgadmin-email: YWRtaW5AZXhhbXBsZS5jb20=
  pgadmin-password: YWRtaW5wYXNzd29yZA==
```

