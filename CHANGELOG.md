# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1] - 2026-04-26

### Added
- `team seed` subcommand and `/team:seed` slash command — idempotently provision 24 default starter teams (UX, product, engineering, growth, business, risk, security). Skips teams that already exist; honors `--target claude,codex`.
- `lib/seed_data.sh` — single source of truth for the default team list (slug + instructions).
- `tests/test_seed.sh` — covers fresh seed (24 created), idempotency (24 skipped), partial re-seed, and reserved-name protection.
- `seed` added to the reserved-name regex so it cannot collide with a user team.

### Fixed
- `team list` no longer crashes with `cfiles[@]: unbound variable` when the `teams/` directory is empty (Bash 3.2 `set -u` regression on macOS).

### Changed
- `team --help` lists the new `seed` subcommand.

## [0.1.0] - 2026-04-26

Initial public release.

### Added
- Cross-runtime team orchestration: define once, emit to Claude Code (`/team:<name>` slash commands) and Codex (`~/.codex/agents/<name>.toml` subagents).
- Subcommands: `new`, `delete`, `list`, `setup-claude`, `setup-codex`, `uninstall`.
- Short flags for `team new`: `-n/--name`, `-i/--instructions`, `-m/--model`, `-s/--size`, `-t/--target`.
- Target resolution via `.targets.json`, auto-detect of `~/.codex/`, or explicit `--target`.
- `team uninstall` with `--yes`, `--dry-run`, `--keep-teams`, `--purge-codex-config`, `--purge-claude-env`.
- Localized docs: `pt-BR`, `zh-CN`, `zh-TW`, `ja`, `ko`, `tr`.
- Test harness with isolated `$HOME` and `$CLAUDE_PLUGIN_ROOT`; CI-friendly (no network).

[0.1.2]: https://github.com/kellvembarbosa/team-orchestrator/releases/tag/v0.1.2
[0.1.2]: https://github.com/kellvembarbosa/team-orchestrator/releases/tag/v0.1.2
[0.1.1]: https://github.com/kellvembarbosa/team-orchestrator/releases/tag/v0.1.1
[0.1.0]: https://github.com/kellvembarbosa/team-orchestrator/releases/tag/v0.1.0
