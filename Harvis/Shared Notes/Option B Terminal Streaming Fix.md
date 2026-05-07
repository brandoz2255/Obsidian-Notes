# Option B Terminal Streaming Fix

**Date:** 2026-05-07  
**Branch:** `option-a-subagent-visibility`  
**Commit:** `31677be54`  
**Status:** ✅ FIXED & VERIFIED

---

## Problem

**Option B** (Terminal Streaming) failed silently in Discord. Subagent tool output and opencode terminal commands were executing but **nothing streamed to the user**.

**Option A** (Subagent Visibility via 🔀 emojis) was working perfectly — proved the gateway and Discord platform were fine.

---

## Root Cause

**Event name mismatch** between the terminal stream callback and the delegate relay map.

| Component | Event Name | File |
|---|---|---|
| Terminal Stream Callback | `"subagent.progress"` (dot) | `run_agent.py:4648` |
| Delegate Relay Map | `"subagent_progress"` (underscore) | `delegate_tool.py:525` |

The `_on_terminal_stream` callback fired `"subagent.progress"` events, but `_LEGACY_EVENT_MAP` only recognized `"subagent_progress"`. Unknown events hit the silent drop at line 753:

```python
return  # Unknown event — ignore
```

---

## Fix

Added the dot notation to `_LEGACY_EVENT_MAP` in `delegate_tool.py`:

```python
# Before (line 525):
_LEGACY_EVENT_MAP = {
    "subagent_progress": DelegateEvent.TASK_PROGRESS,
    # ... other entries
}

# After:
_LEGACY_EVENT_MAP = {
    "subagent.progress": DelegateEvent.TASK_PROGRESS,  # ← ADDED
    "subagent_progress": DelegateEvent.TASK_PROGRESS,   # ← kept for backward compat
    # ... other entries
}
```

**Why both?** Backward compatibility + nested subagent relay chains might use either format.

---

## What Was NOT Broken

- ✅ Gateway callback wiring (`set_stream_callback` in `run_agent.py:9784`)
- ✅ Thread-local storage in `base.py`
- ✅ `_wait_for_process` drain logic in `base.py`
- ✅ Discord platform adapter
- ✅ Option A subagent visibility path
- ✅ Opencode source code (was **not** modified — previous session hallucinated that)

---

## Verification

1. Direct opencode with `--format json` → streamed JSON events to Discord ✅
2. Subagent delegate_task with opencode → tool calls visible in Discord ✅
3. 🔧 terminal icons + command output appeared in real-time ✅

---

## Key Takeaways

- String literal mismatches are the silent killer in event relay chains
- Always check both the emitter and the consumer when debugging event drops
- Opencode `--format json` now emits reasoning without `--thinking` flag (master fix `980271258`)
- Docker rebuild with `--no-cache` required to apply fixes to k8s deployment

---

## Related

- [[Option A Subagent Visibility]]
- [[Hermes Gateway Architecture]]
- [[Opencode Integration Notes]]
