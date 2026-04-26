---
description: Delete ALL agent teams (claude and/or codex). Destructive — requires --yes.
argument-hint: [--yes] [--dry-run] [--target claude,codex]
allowed-tools: Bash
---

!bash "${CLAUDE_PLUGIN_ROOT}/bin/team" delete-all $ARGUMENTS

After deletion, advise the user to run `/reload-plugins` (claude) and re-scan agents (codex) as needed.
