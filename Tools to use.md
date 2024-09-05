### **Tools to Teach**

1. **Nikto**:
    
    - **Purpose**: A straightforward web server scanner that checks for outdated versions, misconfigurations, and known vulnerabilities.
    - **Why Include**: It's quick and simple, a good introductory tool that shows immediate results.
    - **Demo**: You can scan a website and walk through the results, highlighting why it's useful in reconnaissance and vulnerability identification.
2. **Burp Suite**:
    
    - **Purpose**: A full-featured web vulnerability scanner and proxy tool. It allows students to inspect, modify, and intercept traffic between the browser and web server.
    - **Why Include**: This is a must-have tool for any web pentester. It’s powerful, and students will benefit from learning how to use features like the proxy, intruder, and repeater.
    - **Demo**: Show them how to intercept requests and modify them, especially in cases like XSS or SQLi testing.
3. **OWASP ZAP**:
    
    - **Purpose**: Like Burp Suite, ZAP is another web vulnerability scanner but is open-source and focuses more on automated scanning.
    - **Why Include**: It's free, has automated features, and integrates easily into CI/CD pipelines for DevSecOps (a nice touch for students thinking ahead).
    - **Demo**: Walk them through setting up an automated scan, finding vulnerabilities, and demonstrating how to exploit them.
4. **ffuf** (Fuzz Faster U Fool):
    
    - **Purpose**: A tool for brute-forcing web applications (like discovering directories, files, or parameters).
    - **Why Include**: It's lightweight and great for demonstrating the power of fuzzing. It's useful when you're looking for hidden paths or files on a web server.
    - **Demo**: Use ffuf to brute-force hidden directories or parameters on Juice Shop or Hack the Box machines


[[Documentation for the tools]]