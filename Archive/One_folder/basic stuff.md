# Fleet notes 

- [x] SQL injection ✅ 2024-05-23
	- [x] What is SQL Injection ✅ 2024-05-23
	- [x] How its done ✅ 2024-05-23
	- [x] why implementing certain commands in  an input box reveals password! ✅ 2024-05-23
- [ ] Cross-site scripting (XSS)
	- [ ] What exactly even is this 
	- [ ] How ddoes this affect HTML 
	- [ ] Why we need to prevent this 
- [ ] Cross-Site Request Forgery (CSRF)
	- [ ] What is this? 
	- [ ] How does it differ from XSS 
	- [ ] why would we need  to prevent this 
- [ ] OWASP ZAP
	- [ ] what does this tool do? 
	- [ ] How does this tool do exactly what it does 
	- [ ] Why is this tool important 


# Notes for our slides and game pla

# SQL injection  

- **SQL Injection (SQLi**):  is a type of web application security vulnerability that allows an attacker to interfere with the queries an application makes to its database.
	- It typically occurs when user input is not properly sanitized, allowing the attacker to inject malicious SQL code into the query.


- SQL Injection is a way hackers exploit web applications by inserting malicious SQL code into input fields to manipulate the database and gain unauthorized access to information.

- **How is it done?**
	- Hackers find input fields (like login boxes or search bars) where they can enter data.
	- They input special SQL commands instead of regular data.
	- If the application doesn’t properly check and clean this input, the database executes these commands, giving hackers access to sensitive data.
	
When you enter a __username__ or **password** withintg a web application the application sends a _SQl Query_ like ->

```sql
SELECT * FROM users WHERE username = 'user' AND password = 'pass';
```

if the input fieds are not properly sanitized the attacker can then type this onto the fields 

- **Username:** `admin`
- **Password:** *``anything' OR '1'='1``*

which changes the  sql query to -> 

```sql
SELECT * FROM users WHERE username = 'admin' AND password = 'anything' OR '1'='1';
```


Something as simple as error chhecking in the user input 

```js
function isValidInput(input) {
    const regex = /^[a-zA-Z0-9]*$/;
    return regex.test(input);
}
```

procedures in the sql would help as well 

```sql
CREATE PROCEDURE GetUser(IN username VARCHAR(255), IN password VARCHAR(255))
BEGIN
    SELECT * FROM users WHERE username = username AND password = password;
END;
```

# OSWASP ZAP 

 This is a tool used to find vulnerabilities such as SQL injction cross site scripting and other issues 

  - ZAP is a proxy that probes the application to llook for vulnerabilities and can be used  as a spider to crawl around teh application to look for endpoints
  