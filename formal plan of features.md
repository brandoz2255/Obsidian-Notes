## 🧠 Project: Jarves – Modular AI-Powered Automation System

### 1. **Core Objectives**

- **Natural Language Processing (NLP) Integration**
    
    - Enhance _browser_ and _OS-level_ automation with NLP to allow verbal or textual task instructions.
    - Example: "Jarves, open GitHub and clone the repo" → executed via browser automation.
    - Browser
    - OS
- **Agentic Micro-Instances**
    
    - Deploy lightweight Jarves agents for specific tasks on various devices (e.g., Pi, Jetson Orin
    - These agents act autonomously, handling localized functions like login tools, RFID scans, or camera feeds.

---

### 2. **Infrastructure and Automation**

- **SEL Automation with Ansible**
    
    - Hosted on **Proxmox** servers.
    - Use **Ansible** to:
        
        - Automate **Terraform-managed** VM deployments.
        - Integrate **REST APIs** to communicate with other systems or micro-agents.
    - Outcome: Easily voice-command VM creation for red or blue team cyber labs.

- **VM Use Cases**
    
    - Red Team Labs (e.g., Kali Linux VMs).
	    - Python REST api for pulling images in case  its DNE
    - Blue Team Labs (e.g., VulnHub machines for hardening).
	    - Python Rest api for pulliing images in case its DNE 
    - Practice environments are dynamically spawned via verbal requests        

---

### 3. **Perception and Interaction**

- **Computer Vision Layer**
    
    - Use **Jetson Orin Nano**, **Raspberry Pi**, or **any USB camera**.        
    - REST API enables:
        
        - Face detection.
        - Context-aware behavior (e.g., identify who's speaking).
    - Optional: Facial verification as part of access control or interaction.        

---

### 4. **Communication with External Tools**

- **Integration with Cline (IDE Tooling/Assistant)**
    
    - Methods of Communication:
        
        - Use **Cline’s API** or **MCP server**.
        - If needed, develop a **custom VS Code extension** (harder, fallback path).            
    - Goal:
        
        - Verbally instruct Jarves to communicate with Cline.
        - Trigger “vibe coding” sessions, e.g.:
            
            - “Jarves, create a Flask app with a login page” → Cline handles code gen                

---

### 5. **Workflow Automation**

- **No-Code & Visual Tools Integration**
    
    - **n8n Workflow Automation:**
        
        - Use Jarves to:
            
            - Generate **JSON-based workflows**.
            - Or perform browser automation to configure in the GUI.
    - **ComfyUI for Blender 3D:**
        
        - Research required on automation interfaces.
        - Jarves to issue verbal commands to construct visual 3D pipelines.            

---

### 6. **Vision Summary**

> A distributed, voice-activated, agent-based AI system capable of:

- Automating everything from VMs to workflows.    
- Communicating with IDEs and assistants.
- Reacting to users via computer vision.
- Scaling via modular micro-instances.

### 7. Possible Concerns 24gb of vram

- Chatterbox uses 7gb of vram sometimes 8 however 8 is max
- I use Mistral it uses 7gb of vram so thats 14 used 
- one possible  workflow have the sscript unload the vram once its done for both ollama and chatterbox 
- another is  putting chatterbox on cpu maybe? 
- mainly because of Devstral to be the AI agent for vibe coding part 
- smaller models could be used for the general automation tasks to??
- Also Jetsons have 8gb of vram so that could also help put chatterbox on one of them with a REST api??
- MAC studio the lab one with 600 gb of ram have ollama there instead and the agents only on PC ? 