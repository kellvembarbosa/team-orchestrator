---
description: Set up Codex (~/.codex/agents/) as an additional team target
allowed-tools: Bash
---

!bash "${CLAUDE_PLUGIN_ROOT}/bin/team" setup-codex

After this runs, every `/team:new` will also write a `~/.codex/agents/<name>.toml` so Codex can spawn the same teams as subagents. Codex doesn't use slash commands — invoke a team there with natural language: "spawn the <name> subagent".
