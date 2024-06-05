

**Definition**: `Fuzzing` *is an automated testing technique used to find security vulnerabilities* by inputting large amounts of random data, or "`fuzz`," 

- Think of a software program as a lock.
- Fuzzing is like trying thousands of random keys to see which ones might unlock it (i.e., cause the software to behave unexpectedly).
- Just as testing different keys helps identify weaknesses in a lock, fuzzing helps uncover vulnerabilities in software.

**Importance**:

- Helps identify security vulnerabilities that might be missed with traditional testing methods.
- Effective in uncovering edge cases and potential exploits.
- Automates the process of discovering vulnerabilities.


How to install (if not already in Pi)

```C
npm install -g jsfuzz
```

basic command syntax
``` C
jsfuzz --file path/to/your/script.js --function functionName
```



**Example** -> 

Script.js
```JS
function functionName(input) {
    if (input === 'vulnerable') throw new Error('Vulnerability found!');
}
module.exports = functionName;
```

Example syntax usage -> 

```C
jsfuzz --file script.js --function functionName
```

# Slide 9 


**Definition**: Quality Assurance (QA) testing ensures that the software meets specified requirements and is free of defects.

- Imagine building a house. QA testing is like having a building inspector who checks the structure for any flaws or weaknesses, ensuring it’s safe and built to code.
- Just as a building inspector ensures the safety and stability of a house, QA testing ensures the security and reliability of software.



**Importance**:

- Ensures software reliability and performance.
- Identifies security weaknesses and vulnerabilities.
- Enhances user satisfaction and trust.


**Analyzing User Authentication Processes**

- **Why Focus on Authentication?**
    - Authentication is a critical component of security.
    - Ensures that only authorized users can access the system.

- **Common Issues**:
    - Weak password policies.
    - Insecure password storage.
    - Vulnerabilities like SQL injection.


**Example Vulnerabilities**:

- **SQL Injection**: Allows attackers to manipulate the database through malicious input.

```HTML
<form action="/login" method="post">
    <input type="text" name="username" placeholder="Username">
    <input type="password" name="password" placeholder="Password">
    <button type="submit">Login</button>
</form>
```




JS code

```JS
app.post('/login', function(req, res) {
    let username = req.body.username;
    let password = req.body.password;
    let query = `SELECT * FROM users WHERE username = '${username}' AND password = '${password}'`;
    db.query(query, function(error, results) {
        if (results.length > 0) {
            res.send('Login successful');
        } else {
            res.send('Login failed');
        }
    });
});
```



**Cross-Site Scripting (XSS)**: Allows attackers to inject malicious scripts into web pages viewed by other users.

```HTML
<input type="text" id="userInput">
<button onclick="displayInput()">Submit</button>
<p id="output"></p>
```

```JS
function displayInput() {
    let userInput = document.getElementById('userInput').value;
    document.getElementById('output').innerHTML = userInput;
}
```


# Intro to OWASP ZAP 

**Definition**: OWASP ZAP (Zed Attack Proxy) is an open-source web application security scanner. It helps identify vulnerabilities in web applications by simulating various attack scenarios.

- Imagine OWASP ZAP as a security guard who checks all the doors and windows of a building (the web application) to ensure they are locked and secure.
- Just like a security guard finds and reports potential entry points for intruders, OWASP ZAP identifies vulnerabilities that attackers could exploit.



**Importance**:

- Automates the process of finding security vulnerabilities.
- Provides comprehensive coverage for different types of attacks.
- Useful for both beginners and experienced security professionals.


**Definition**: A *proxy server* acts as an intermediary between your computer and the internet

- Imagine sending a letter (`HTTP request`) through a middleman `(proxy server`) who reads the letter, checks it for issues, and then sends it to the recipient (`web server`).
- The recipient responds, and the middleman intercepts the response, checks it, and then delivers it to you.
- This way, any potential issues in the letter or the response can be identified and addressed by the middleman.


# notes 
NICE framework slides 
NIST GLOSSARY GET DEF FROM THERE 
add check for understanding 
Thinking like adversary 
teach them somethign 
showing them someting 
let go therough it 
