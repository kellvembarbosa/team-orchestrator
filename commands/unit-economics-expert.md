---
description: Spawn the unit-economics-expert agent team
argument-hint: [extra instructions]
allowed-tools: Read
---

Spawn an agent team named "unit-economics-expert" using the stored team definition.

1. Read the team configuration from `${CLAUDE_PLUGIN_ROOT}/teams/unit-economics-expert.md`. Frontmatter may include `model` and `size` hints; body holds the team's instructions.
2. Create an agent team that follows those instructions. Honor `model` and `size` hints if present.
3. Incorporate this additional user context into the spawn prompt (may be empty): $ARGUMENTS
