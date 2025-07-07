## ✅ **v1 Goals Recap** — "Chat-to-Code IDE"

### Interface:

- 🗨️ Left side: `Chat UI` powered by `Mistral 7B (vLLM)`
- 💻 Right side: Editable code window (Monaco, Ace, or CodeMirror)
- 🔄 Real-time sync: Model sees and incorporates **your edits**
- 🗂️ Project tree view: Mistral understands the project structure (like a dev agent)

---

## 🤖 Will vLLM alone handle this?

❌ **Nope. vLLM is not enough on its own for this.**

vLLM just runs the model. It:

- **Responds to prompts**
- Keeps **local context** (during one request or chat session)
- Has **no access to files, project trees, or your edits** unless you explicitly **feed it** that info


## 🧠 So YES — you’ll need a **Python backend** to act as the bridge:

|🔧 Feature|Who Handles It|
|---|---|
|Chat prompt & completions|vLLM|
|File edit tracking|Python backend|
|Code history + changes context|Python backend|
|Project tree generation|Python backend|
|Prompt augmentation with current file contents|Python backend|

