---
description: Delete an agent team and its spawn command
argument-hint: <name>
allowed-tools: Bash
---

!bash "${CLAUDE_PLUGIN_ROOT}/bin/team" delete $ARGUMENTS

After deletion, advise the user to run `/reload-plugins`.
