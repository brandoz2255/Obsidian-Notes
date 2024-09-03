### Day 1: Introduction to Coding and Basics (45 minutes)

1. **Intro (5 minutes)**:
    
    - Introduce yourself and explain what a secure software accessor is and what they do.
2. **Basics of VS Code, Text Editors, and Git/GitHub (15 minutes)**:
    
    - **VS Code**:
        - Explain what VS Code is and its importance as an IDE.
    - **Other Text Editors**:
        - Introduce VIM and Kate.
        - Briefly mention their features and differences.
    - **Git/GitHub**:
        - Explain the basics of version control with Git.
        - Show how to clone a repository from GitHub.
        - Demonstrate pushing changes to GitHub and creating a repository.
3. **Introduction to "Hello World" (10 minutes)**:
    
    - **Hello World in JavaScript**:
        - Explain basic data types, variables, and functions in JavaScript.
    - **Hello World in HTML**:
        - Basic structure of an HTML document.
    - **Hello World in HTML, JavaScript, and CSS**:
        - Combining HTML, JavaScript, and CSS in a simple example.
4. **Building a Simple Web App Together (10 minutes)**:
    
    - Walk them through creating a basic to-do list web app.
    - Guide them step-by-step through setting up HTML, adding JavaScript functionality, and styling with CSS.
5. **AI Buddy for HTML and CSS (5 minutes)**:
    
    - Demonstrate how AI tools can help automate HTML and CSS creation.
    - Show examples of AI tools reading and suggesting improvements in the code.
    - Encourage students to experiment with AI-assisted code generation for HTML and CSS.
**AI Enhancement**: Use AI tools to automate HTML/CSS generation, allowing students to focus more on learning JavaScript.

### Day 2: Common Coding Flaws and Fuzzing (45 minutes)

1. **Identifying Basic Common Coding Flaws (20 minutes)**:
    
    - Teach manual identification of SQL Injection and XSS vulnerabilities.
    - Discuss why these vulnerabilities are dangerous and how they can be exploited.
    - Provide code examples to practice identifying flaws.
2. **Automated Fuzzing (15 minutes)**:
    
    - Introduction to fuzzing and its importance.
    - Set up and run a simple fuzzing example using `Jsfuzz`.
    - Explain how fuzzing automates flaw detection.
3. **Additional Tools (5 minutes)**:
    
    - Introduce Burp Suite, Nmap, and Postman for manual and API testing.

**Expansion Ideas**:

- **Advanced Vulnerabilities**: Introduce other vulnerabilities like CSRF (Cross-Site Request Forgery) and IDOR (Insecure Direct Object References).
- **Fuzzing Tools**: Demonstrate additional fuzzing tools or more complex fuzzing scenarios.

**AI Enhancement**: Use AI to identify vulnerability patterns from manual and fuzzing results, enhancing understanding of common security flaw characteristics.

### Day 3: Penetration Testing for Web Applications (45 minutes)

1. **Using OWASP ZAP (15 minutes)**:
    
    - Introduction to penetration testing and its importance.
    - Basic usage of OWASP ZAP to scan for vulnerabilities.
    - Show how to set up OWASP ZAP and run a basic scan.
2. **Burp suite(5 minutes)**: 
	- Introduction to what burp suite is
	- how to set up and use burp suite for web app pent tests
1. **Juice Shop Setup (20 minutes)**:
    
    - Explain what Juice Shop is.
    - Show how to download and run Juice Shop.
        - Docker method (if time is limited): `docker pull bkimminich/juice-shop` and `docker run --rm -p 3000:3000 bkimminich/juice-shop`.
        - Manual setup (if time allows): `git clone` and `npm install` then `npm start`.
    - Explain Docker and its benefits over manual setup.
3. **Additional Tools if time persists (5 minutes)**:
    
    -  Metasploit, and Nikto for penetration testing.

**Expansion Ideas**:

- **Advanced ZAP Features**: Dive deeper into OWASP ZAP’s advanced features like automated scripts and context configurations.
- **Burp Suite Extensions**: Explore extensions for Burp Suite that enhance its functionality.
- **Other Penetration Tools**: Give a brief introduction and demo of other tools like Metasploit and Nikto, with simple exercises.

**AI Enhancement**: Automate penetration testing to improve efficiency and accuracy.

### Day 4: Integrated Quality Assurance Testing (45 minutes)

1. **Quality Assurance Testing (20 minutes)**:
    
    - Analyzing user authentication processes.
    - Identifying potential security weaknesses in authentication (e.g., SQL injection, weak password policies).
    - Discuss common issues like insecure password storage or weak password policies.
2. **AI Enhancements (15 minutes)**:
    
    - Using AI to simulate attacks and improve security.
    - Hands-on practice with AI tools for security assessment.
    - Provide examples where AI tools enhance authentication processes.
3. **Additional Tools (5 minutes)**:
    
    - Introduce Jenkins for continuous integration.
    - Demonstrate Selenium for automated testing.
    - Explain OWASP Dependency-Check for identifying vulnerable dependencies.

**AI Enhancement**: Use AI to simulate types of attacks and enhance authentication security.


[[slides]]