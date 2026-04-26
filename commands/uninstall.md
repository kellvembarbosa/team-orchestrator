---
description: Uninstall team-orchestrator artifacts (teams, codex agents, targets file)
argument-hint: [--yes] [--dry-run] [--keep-teams] [--purge-codex-config] [--purge-claude-env]
allowed-tools: Bash
---

Run the uninstall subcommand of the team CLI to remove all team-orchestrator artifacts.

Execute: `bash "${CLAUDE_PLUGIN_ROOT}/bin/team" uninstall $ARGUMENTS`

Notes:
- Default removes all generated team files (claude `teams/*.md`, generated `commands/<team>.md`, codex `~/.codex/agents/*.toml`) and the plugin `.targets.json`.
- Reserved slash commands (new, delete, list, setup-claude, setup-codex, uninstall) are preserved.
- `--dry-run` previews without modifying.
- `--keep-teams` clears only `.targets.json` (and optional env/config purges).
- `--purge-codex-config` removes the `[agents]` block from `~/.codex/config.toml`.
- `--purge-claude-env` removes `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS` from `~/.claude/settings.json`.
- To remove the plugin binary itself afterwards, run `/plugin uninstall team`.
- Non-interactive contexts must pass `--yes`.
