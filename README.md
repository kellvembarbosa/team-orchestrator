# team-orchestrator

> If you like it, please support us with a simple share on your social networks — especially on [x.com](https://x.com).

> **Orchestrate agent teams across multiple AI coding CLIs.** Define an agent team once, run it on Claude Code (slash commands) and Codex (subagents) — with one source of truth and a contributor-friendly path to add more runtimes.

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Plugin](https://img.shields.io/badge/Claude_Code-plugin-7C4DFF)](https://code.claude.com/docs/en/plugins)
[![Codex](https://img.shields.io/badge/Codex-subagents-10A37F)](https://developers.openai.com/codex/subagents)
[![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#add-a-new-runtime)

**Languages**: **English** · [Português (BR)](docs/pt-BR.md) · [简体中文](docs/zh-CN.md) · [繁體中文](docs/zh-TW.md) · [日本語](docs/ja.md) · [한국어](docs/ko.md) · [Türkçe](docs/tr.md)

---

## The pain

[Claude Code agent teams](https://code.claude.com/docs/en/agent-teams) are powerful — but every team means writing YAML by hand, dropping it in the right folder, reloading plugins. Get a team that *works*? It's stuck in that one repo. Next project: blank page. Want the same team on Codex? Different format, different folder, do it all again.

## The fix

Write the team once. Use it anywhere.

**Create** — start the instruction with `One teammate on` (Claude) or `Use agents on` (Codex). The prefix tells the runtime how to spawn the team:

```text
# Claude Code team
/team:new --name reviewers \
  --instructions "One teammate on code review with agents focused on correctness, security, and missing tests." \
  --model sonnet --size 3

# Claude Code team
/team:new --name designers \
  --instructions "One teammate on product design with agents focused on UX, visual hierarchy, and component reuse." \
  --model sonnet --size 3

# Codex team (mirrored)
/team:new --name auditors \
  --instructions "Use agents on security auditing focused on auth flows, input validation, and dependency risk." \
  --model gpt-5.4 --size 3 --target codex
```

**Use in Claude Code** — slash or natural language:

```text
/team:reviewers check the auth refactor in PR #42
/team:designers redesign the dashboard empty state

# or just:
spawn the reviewers team on the current diff
have designers propose 3 variants for the pricing page
```

**Use in Codex** — same teams, mirrored automatically:

```text
Use the reviewers subagent on this branch.
Spawn designers and have them critique the new onboarding screens.
```

One definition. Both runtimes. Saved forever.

## Why

Every modern AI coding CLI is shipping its own multi-agent / sub-agent system: Claude Code has [agent teams](https://code.claude.com/docs/en/agent-teams), Codex has [subagents](https://developers.openai.com/codex/subagents), and more are coming (Gemini CLI, Qwen Code, opencode, etc).

The definitions are conceptually similar — a name, a role/instructions, optionally a model and team size — but every CLI uses a **different file format, location, and invocation pattern**. Keep two of them in sync by hand and you're already losing.

`team-orchestrator` fixes that: write the team definition once, the plugin emits the right artifacts for every supported runtime.

## What it does

| Runtime | Format | Invocation |
|---|---|---|
| Claude Code | `commands/<name>.md` + `teams/<name>.md` (markdown + YAML) | `/team:<name>` slash command |
| Codex | `~/.codex/agents/<name>.toml` (TOML) | natural-language ("spawn the `<name>` subagent") |
| _Your CLI_ | _your format_ | _your invocation_ — **PRs welcome** |

A single command — `/team:new --name designers --instructions "..." --model sonnet --size 3` — writes to all enabled runtimes.

## Quick Start

Get up and running in under 2 minutes.

### Step 1 — Install the plugin

**Recommended: Claude Code plugin marketplace** (one-line install, auto-updates):

```bash
# Inside Claude Code:
/plugin marketplace add https://github.com/kellvembarbosa/team-orchestrator
/plugin install team@team-orchestrator
```

After install, the `/team:*` commands are available. If they don't appear, run `/reload-plugins`.

**Alternative: local development (`--plugin-dir`)** — best for hacking on the plugin or running an unreleased branch:

```bash
git clone https://github.com/kellvembarbosa/team-orchestrator.git
claude --plugin-dir ./team-orchestrator
```

**Alternative: fully manual install** — clone into your user Claude config:

```bash
git clone https://github.com/kellvembarbosa/team-orchestrator.git ~/.claude/plugins/team-orchestrator
# Restart Claude Code, then verify with /plugin list.
```

```powershell
# Windows PowerShell — manual install
New-Item -ItemType Directory -Force -Path "$HOME/.claude/plugins" | Out-Null
git clone https://github.com/kellvembarbosa/team-orchestrator.git "$HOME/.claude/plugins/team-orchestrator"
# Restart Claude Code, then verify with /plugin list.
```

### Step 2 — Enable runtimes

```text
/team:setup-claude              # required: sets CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
/team:setup-codex               # optional: also mirror to ~/.codex/agents/
```

Restart Claude Code after `setup-claude` so the env var takes effect.

### Step 3 — Create your first team

```text
/team:new --name designers \
  --instructions "Frontend, UX, and visual design team. Coordinate on the component library." \
  --model sonnet --size 3
/reload-plugins
/team:designers focus on the dashboard redesign
```

In Codex, prompt naturally: *"spawn the `designers` subagent"*.

## Using Teams In Codex

Codex does not load Claude slash commands. The `/team:*` commands are only the
management surface provided by the Claude Code plugin. For Codex, this plugin
mirrors each team into Codex's native subagent configuration.

### 1. Enable Codex mirroring

Run this once from Claude Code:

```text
/team:setup-codex
```

This creates `~/.codex/agents/`, ensures `~/.codex/config.toml` has an
`[agents]` block, and stores Codex as an enabled target in the plugin state.

### 2. Create a team for Codex

Create the team normally after mirroring is enabled:

```text
/team:new --name designers \
  --instructions "Frontend, UX, and visual design team. Coordinate on the component library." \
  --model gpt-5.4 --size 3
```

Or write only to Codex:

```text
/team:new --name reviewers \
  --instructions "Review code for correctness, security, and missing tests." \
  --model gpt-5.4 --target codex
```

The generated Codex files are:

```text
~/.codex/agents/designers.toml
~/.codex/config.toml              # contains [agents.designers]
```

### 3. Restart Codex

Codex reads agent definitions when a session starts. After creating or deleting
a team, restart/reopen Codex so it reloads `~/.codex/config.toml`.

### 4. Invoke the team in Codex

Ask for the subagent by name in natural language:

```text
Use the designers subagent to review this dashboard implementation.
```

```text
Spawn the reviewers agent and have it check the current diff.
```

```text
Use codex-demo to confirm which agent handled this task.
```

In Codex CLI builds with the multi-agent UI enabled, `/agent` can also show the
available agents. The names should match the `[agents.<name>]` entries in
`~/.codex/config.toml`.

### Naming note

Three identifiers, one project — they're related but **not interchangeable**:

| Surface | Identifier |
|---|---|
| GitHub source repo | `kellvembarbosa/team-orchestrator` |
| Claude Code marketplace | `team-orchestrator` |
| `/plugin install` id | `team@team-orchestrator` |
| Slash-command namespace | `/team:*` (singular — the plugin's `name` field) |

`/plugin install` keys off the plugin id (`team@team-orchestrator`); the slash commands key off the plugin's `name` (`team`). So all of `/team:new`, `/team:delete`, `/team:list`, `/team:setup-codex`, and per-team `/team:<yourname>` stay singular regardless of the marketplace name.

After `/team:new` or `/team:delete`, run `/reload-plugins` so the generated/removed slash command appears/disappears.

## Commands

| Command | Purpose |
|---|---|
| `/team:setup-claude` | Set `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in `~/.claude/settings.json` |
| `/team:setup-codex` | Create `~/.codex/agents/`, seed `[agents]` in `~/.codex/config.toml`, enable Codex mirroring |
| `/team:new --name <slug> --instructions "<text>" [--model <m>] [--size <n>] [--target claude,codex]` | Create a team and emit to selected runtimes |
| `/team:seed [--target claude,codex]` | Seed the 24 default starter teams (UX, product, engineering, growth, business, risk, security). Idempotent — skips existing. |
| `/team:delete <name>` | Remove from every runtime where it exists |
| `/team:list` | List all teams with per-runtime presence (also surfaces orphan Codex agents) |
| `/team:uninstall [--yes] [--dry-run] [--keep-teams] [--purge-codex-config] [--purge-claude-env]` | Remove generated teams and plugin state. `--dry-run` previews; `--keep-teams` retains team files; `--purge-codex-config` strips the `[agents]` block from `~/.codex/config.toml`; `--purge-claude-env` removes the experimental flag from `~/.claude/settings.json`. |
| `/team:<name> [extra]` | Spawn the team on Claude Code (auto-generated by `team:new`) |

## Target resolution

When `--target` is omitted, runtimes are picked in this order:

1. `<plugin-root>/.targets.json` if present (set by `/team:setup-codex`)
2. Auto-detect: always `claude`; add `codex` if `~/.codex/` exists
3. Default: `claude` only

Pass `--target codex` or `--target claude,codex` to override per-call.

## Add a new runtime

**The plugin is built to grow.** Adding support for a new AI coding CLI is a focused PR — usually under 200 lines.

1. **Read the runtime's docs**, identify how it stores agent / subagent / persona definitions (file format, location, required fields).
2. **Create `lib/emit_<runtime>.sh`** with these four functions:
   ```bash
   <runtime>_setup()          # one-time setup (dirs, config seeding)
   <runtime>_emit name instr model size   # write the agent file
   <runtime>_remove name      # delete the agent file
   <runtime>_has name         # return 0 if agent exists
   ```
3. **Wire it up** in `bin/team`:
   - Source the new lib
   - Add to `KNOWN_TARGETS` in `lib/targets.sh`
   - Extend the `case` blocks in `cmd_new`, `cmd_delete`, `cmd_list`
   - Add a `cmd_setup_<runtime>` subcommand
4. **Drop a slash command** at `commands/setup-<runtime>.md` mirroring the existing setup commands.
5. **Add tests** at `tests/test_<runtime>_*.sh` following the pattern of `test_codex_*.sh`.
6. **Update**: this README's runtime table + the language switcher docs in `docs/`.

Open the PR — even a draft. Maintainers will help finish it.

Examples to study:
- Claude integration: [`lib/emit_claude.sh`](lib/emit_claude.sh)
- Codex integration: [`lib/emit_codex.sh`](lib/emit_codex.sh)
- Tests: [`tests/test_codex_new.sh`](tests/test_codex_new.sh)

## Storage

| Runtime | Path | Format |
|---|---|---|
| Claude Code | `<plugin-root>/teams/<name>.md` | YAML frontmatter + body |
| Claude Code | `<plugin-root>/commands/<name>.md` | Slash-command markdown |
| Codex | `~/.codex/agents/<name>.toml` | TOML |
| Plugin state | `<plugin-root>/.targets.json` | `{"claude":bool,"codex":bool}` |

## Tests

```bash
bash tests/run.sh
```

Requires `bash` and `jq`. No other dependencies. CI-friendly (no network, no sudo).

## Requirements

- Claude Code v2.1.32+ for agent teams (`/team:setup-claude` sets the experimental flag)
- Codex CLI for the Codex mirror (optional)
- `jq` on PATH

## Caveats

- Codex agents are user-scoped only (`~/.codex/agents/`). Project-scoped (`.codex/agents/`) is on the roadmap.
- Instructions cannot contain `'''` — TOML conflict. Use `"""` or rephrase.
- `--size` is honored natively by Claude agent teams; on Codex it appears as a hint in the agent description (you ask Codex to spawn N).

## Contributing

PRs welcome — especially:

- New runtime adapters (see [Add a new runtime](#add-a-new-runtime))
- More language translations under `docs/`
- Edge-case tests
- Bug fixes

Code follows TDD: failing test first, minimal implementation, refactor. See `tests/` for the pattern.

## License

[Apache License 2.0](LICENSE) © 2026 Kellvem Barbosa

---

**Keywords**: claude code, claude code plugin, codex, openai codex, agent teams, multi-agent, subagents, ai orchestration, llm tools, ai coding cli, anthropic, multi-runtime, agent management, sub agent, claude agent, codex agent, ai pair programming
