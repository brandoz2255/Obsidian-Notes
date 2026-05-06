# Hermes Sub-Agent Visibility

## Problem
When Hermes delegates tasks via `delegate_task`, Discord users see a black box — no progress, no tool calls, just the final response. CLI users see full progress via `KawaiiSpinner`.

## Root Cause
`gateway/run.py` line 12842-12843 filters progress events:
```python
if event_type not in ("tool.started",):
    return
```
This drops all `subagent.*` events before they reach the Discord message queue.

## Option A: Gateway Callback Patch ✅ DONE
**Status:** Implemented and merged to `brandoz2255/harvis-agent` branch `option-a-subagent-visibility`

**What it does:** Added handler for `subagent.tool`, `subagent.thinking`, `subagent.progress` events in the gateway progress callback.

**Result:** Native Hermes delegates now stream progress to Discord with emojis:
- 🔀 for tool/progress events
- 💭 for thinking events

**Branch:** https://github.com/brandoz2255/harvis-agent/compare/option-a-subagent-visibility

## Option B: OpenCode Visibility (External Processes)
**Status:** Not yet implemented. Targeted for web version / future Discord update.

**Why it's harder:**
- OpenCode runs as a terminal subprocess (`opencode run`), NOT a native Hermes sub-agent
- The `terminal_tool` captures stdout/stderr and returns it when complete — no intermediate events
- OpenCode doesn't emit structured events that Hermes can capture

**What would be needed:**
1. Modify `terminal_tool` to stream subprocess output as progress events in real-time
2. Parse OpenCode's output format (file writes, tool calls, thinking) and convert to structured events
3. Feed those into the `progress_queue` the gateway already uses

**Discord-specific challenges:**
- Discord has no native "progress" message type
- Options: edit same message (rate limited), send multiple messages (spammy), use separate thread
- The `progress_queue` infrastructure already works on Discord — just needs the events

**Could it work on Discord?** Yes, absolutely. It's not platform-specific — it's an architecture change to how terminal subprocesses stream output. The same fix would work on Discord AND web.

## Timeline
- Option A: Done 2026-05-06, deployed to harvis-agent fork
- Option B: Planned for web version / future iteration

## Fork Details
- **Repo:** https://github.com/brandoz2255/harvis-agent
- **License:** MIT (fully permissive)
- **Remote setup:** `origin` → brandoz2255/harvis-agent, `upstream` → NousResearch/hermes-agent
- **Local path:** `/workspace/harvis/aidev/hermes/`

## Notes
- User specifically wants to see sub-agent processes, tool calls, and progress in Discord
- CLI already shows this via `KawaiiSpinner` — goal is parity
- Option B is NOT a hard no for Discord — just requires more plumbing
