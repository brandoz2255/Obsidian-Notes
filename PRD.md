# 📝 Product Requirements Document (PRD)

## 📌 Project Name: **Jarvis**

> **Jarvis** is an AI-powered, voice-interactive assistant built to automate `cybersecurity` workflows, assist research, and provide intelligent system orchestration using a modular, cross-platform, `Dockerized` architecture.

---

## 🎯 Goals & Objectives

- Build an **MVP AI assistant** that works **locally**, **securely**, and is **fully containerized**
- Ensure **cross-device compatibility**: Windows 11 (4090), Mac Studio, `Jetson` Orin Nano, `VPS`
- Use **Docker MCP Toolkit** for tool discovery, orchestration, and cross-service communication
- Integrate **voice interface**, **LLM inference**, **computer vision**, **workflow automation**, and **search**

---

## 🧱 Tech Stack (with Versions)

| **Component**                  | **Purpose**                         | **Version**         | **Deployment Method**      |
| ------------------------------ | ----------------------------------- | ------------------- | -------------------------- |
| **Docker Engine**              | Container runtime                   | `v24.0+`            | Installed on all nodes     |
| **Docker Compose**             | Multi-service orchestration         | `v2.24+`            | `docker compose` CLI       |
| **Docker MCP Toolkit**         | MCP server registry & client access | `Beta` (May 2024)   | Enabled via Docker Desktop |
| **Ubuntu Server**              | VPS backend OS                      | `20.04 LTS`         | DigitalOcean               |
| **Windows 11 Pro**             | Main dev & GPU inference host       | `22H2`              | Native                     |
| **Mac Studio (M2 Max)**        | Automation & UI                     | `macOS Sonoma`      | Native                     |
| **Jetson Orin Nano**           | Edge vision & robotics              | `JetPack SDK 6.0`   | Native + Docker            |
| **LLM Inference (Ollama)**     | Serve Mistral/LLama3 locally        | `Ollama v0.1.32`    | Docker or native           |
| **n8n**                        | Automation workflows                | `v1.51.0`           | Docker                     |
| **Chatterbox**                 | TTS voice output                    | Custom Docker build | Docker                     |
| **Elasticsearch**              | Search engine for RAG               | `v8.12.2`           | Docker                     |
| **Continue.dev**               | LLM IDE agent for dev automation    | `v0.9.x`            | VSCode Plugin              |
| **Claude Desktop (Anthropic)** | LLM Client (MCP-capable)            | June 2024 release   | Desktop App                |
| **Cursor IDE**                 | AI-native development environment   | `v0.33.0`           | Native (Free tier)         |
| **Python**                     | Model inference, TTS, CV glue logic | `v3.10+`            | In containers              |
| **Node.js**                    | n8n + TTS API                       | `v18.x LTS`         | In containers              |


---

## 🛠 Core Functional Components

### 1. 🧠 **LLM Backend**

- Hosted on 4090 PC using Ollama
- Models: `llama3`, `mistral`, `gemma`, or `openchat`
- Accessible via MCP tag

### 2. 🤖 **Computer Vision + Robotics**

- Jetson Orin Nano: Detect face/gestures, receive commands from n8n    
- Uses OpenCV, TensorRT
- MCP-exposed CV microservice

### 3. 🔄 **Workflow Orchestration**

- `n8n` runs on Mac Studio or 4090
- Automates: Email parsing, task generation, robot control
- MCP label: `mcp/n8n`

### 4. 🔊 **Voice Interface**

- Uses **Chatterbox** (Resemble.ai TTS, open-source version)
- Accepts text → outputs audio locally
- Optional: Whisper for voice-to-text

### 5. 🔍 **Private Search Engine**

- Runs on VPS using Elasticsearch
- Accepts LLM queries, responds with local knowledge base or RAG sources
- Can be swapped with custom FastAPI + SQLite engine


### 6. 🧭 **MCP Client Interface**

- Claude Desktop, Continue.dev, or custom GUI
- Connects to MCP Toolkit on main workstation
- Test and invoke tools visually

---

## 📦 Deployment Requirements

### 📁 File Structure (Condensed)

```bash
project-harvis/
├── docker-compose.yml
├── .env
├── services/
│   ├── llm-backend/
│   ├── vision-service/
│   ├── tts-chatterbox/
│   ├── orchestrator-n8n/
│   ├── private-search/
│   └── gui-interface/
project-harvis/
├── docker-compose.yml
├── .env
├── services/
│   ├── llm-backend/
│   ├── vision-service/
│   ├── tts-chatterbox/
│   ├── orchestrator-n8n/
│   ├── private-search/
│   └── gui-interface/
```

---

## 🔒 Security & Access Control

| Feature                 | Status                              |
| ----------------------- | ----------------------------------- |
| Container isolation     | ✔️ via Docker namespaces            |
| Network segmentation    | ✔️ Docker Compose internal networks |
| API auth (n8n, TTS)     | ✔️ via headers & tokens             |
| No cloud dependency     | ✔️                                  |
| VPN/SSH Tunnels for VPS | ✔️                                  |
| Secrets in `.env` files | ✔️                                  |

## 🔄 Portability Goals

| Feature                  | Notes                                     |
| ------------------------ | ----------------------------------------- |
| Fully containerized      | Every service built with Dockerfile       |
| Works on Win/Mac/Linux   | MCP & Docker Compose supported across all |
| External config files    | All environment vars extracted            |
| Reproducible deployments | With `docker-compose up` and README setup |
| Git-tracked infra        | Everything in Git repo (infra-as-code)    |


## 🛣️ Roadmap

| Phase | Goal                                              |
| ----- | ------------------------------------------------- |
| MVP-1 | Local Docker MCP discovery, n8n + LLM + TTS       |
| MVP-2 | Add Jetson CV + remote VPS search                 |
| MVP-3 | GUI dashboard + voice interaction                 |
| MVP-4 | Modular plugin framework, AI skill chaining       |
| MVP-5 | Harvis deployment pack for labs & research groups |

---

## 📚 External Tools & Docs

- [Docker MCP Toolkit](https://docs.docker.com/ai/mcp-catalog-and-toolkit/toolkit/)
- n8n Workflows
- Ollama Models
- [Chatterbox TTS](https://github.com/resemble-ai/chatterbox)
- [Continue.dev](https://continue.dev/)
- [Cursor IDE](https://cursor.sh/)
- [Jetson SDK](https://developer.nvidia.com/embedded/jetpack)