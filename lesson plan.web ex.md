### **Week 1: Introduction to Web Exploitation & Basic Vulnerabilities**

- **Objective**: Give an overview of web exploitation and cover common web vulnerabilities like SQL Injection and XSS.
- **Theory**: Teach the basics of web application architecture, client-server interaction, and introduce the OWASP Top 10.
- **Hands-On**: Have students try some basic exercises on TryHackMe (beginner-level rooms) or Hack the Box, focusing on SQL Injection and XSS. You can also show them how to interact with Juice Shop for simple vulnerabilities.

### **Week 2: Deeper Dive into Injection Attacks**

- **Objective**: Focus more deeply on SQL Injection and Command Injection.
- **Theory**: Explain how SQL Injection works, covering blind SQLi, error-based SQLi, and how these vulnerabilities can be exploited.
- **Hands-On**: Use a guided lab on Hack the Box or Juice Shop. Walk them through an SQL injection attack on Juice Shop, demonstrating how to bypass login forms, extract data, or manipulate the backend.

### **Week 3: Cross-Site Scripting (XSS) and CSRF**

- **Objective**: Teach XSS and Cross-Site Request Forgery (CSRF).
- **Theory**: Discuss the difference between stored, reflected, and DOM-based XSS. Introduce CSRF and show real-world examples of both.
- **Hands-On**: Use Juice Shop's XSS challenges or TryHackMe rooms to demonstrate exploiting XSS vulnerabilities and attacking CSRF vulnerabilities. Allow them to create payloads.

### **Week 4: Tools of the Trade & Pentesting Walkthrough**

- **Objective**: Introduce pentesting tools and methodologies for web exploitation.
- **Theory**: Talk about tools like Burp Suite, OWASP ZAP, and Nikto. Discuss their use in real-world web pentesting.
- **Hands-On**: Run a demo using OWASP ZAP to scan Juice Shop for vulnerabilities, then show them how to exploit some of the vulnerabilities found. Let the students run their own scans and identify vulnerabilities.

### **Week 5: CTF Time!**

- **Objective**: Create a CTF that challenges students to apply everything they’ve learned.
- **CTF Design**: Use Juice Shop and create specific challenges, such as:
    - SQL Injection to extract sensitive data.
    - Finding and exploiting XSS vulnerabilities.
    - Bypassing login forms or other access controls.
    - Using Burp Suite to manipulate requests.
- **CTF Format**: Break students into teams or have them compete individually. The goal is to solve as many Juice Shop challenges as possible within the given time.

[[Tools to use]]