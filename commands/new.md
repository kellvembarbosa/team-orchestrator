---
description: Create a new agent team and generate its spawn command
argument-hint: --name <slug> --instructions "<text>" [--model <m>] [--size <n>] [--target claude,codex]
allowed-tools: Bash
---

!bash "${CLAUDE_PLUGIN_ROOT}/bin/team" new $ARGUMENTS

After the team is created, advise the user to run `/reload-plugins` so the new `/team:<name>` command becomes available.
