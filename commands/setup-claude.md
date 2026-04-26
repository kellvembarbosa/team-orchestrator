---
description: Enable CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 in ~/.claude/settings.json
allowed-tools: Bash
---

!bash "${CLAUDE_PLUGIN_ROOT}/bin/team" setup-claude

Remind the user that Claude Code v2.1.32+ is required for agent teams, and that they must restart Claude Code for the env var change to take effect.
