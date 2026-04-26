---
description: Seed the 24 default starter teams (idempotent — skips existing)
argument-hint: [--target claude,codex]
allowed-tools: Bash
---

!bash "${CLAUDE_PLUGIN_ROOT}/bin/team" seed $ARGUMENTS

After seeding, advise the user to run `/reload-plugins` so the newly generated `/team:<name>` commands become available.
