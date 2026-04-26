# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.3] - 2026-04-26

### Added
- `team seed` now defaults to **both** `claude` and `codex` targets when `-t/--target` is omitted, instead of relying on `.targets.json` / `~/.codex/` autodetection. Ensures fresh installs register `/team:<name>` slash commands alongside Codex `.toml` agents.
- `team seed` prints the full team registry (via `team list`) after seeding so the user immediately sees every team registered on every target.
- Per-subcommand `-h|--help`: `team new -h`, `team delete -h`, `team delete-all -h`, `team list -h`, `team seed -h`, `team setup-claude -h`, `team setup-codex -h`, `team uninstall -h`. Each prints its own usage.

### Changed
- Bump plugin/marketplace version to `0.1.3`.

## [0.1.2] - 2026-04-26

### Added
- `team delete-all` subcommand and `/team:delete-all` slash command — destructively removes every team across selected targets. Supports `--yes`, `--dry-run`, `-t/--target claude,codex`.
- Refreshed default seed roster in `lib/seed_data.sh` (24 starter teams across UX, product, engineering, growth, business, risk, and security).

### Fixed
- Marketplace `source` field uses relative `"./"` to avoid SSH clone errors during install.

## [0.1.1] - 2026-04-26

### Added
- `team seed` subcommand and `/team:seed` slash command — idempotently provisions the default starter teams. Skips teams that already exist; honors `-t/--target claude,codex`.
- `lib/seed_data.sh` — single source of truth for the default team list (slug + instructions).
- `tests/test_seed.sh` — covers fresh seed, idempotency, partial re-seed, and reserved-name protection.
- `seed` added to the reserved-name regex so it cannot collide with a user team.
- Documentation explaining how mirrored Codex teams are consumed.

### Fixed
- `team list` no longer crashes with `cfiles[@]: unbound variable` when the `teams/` directory is empty (Bash 3.2 `set -u` regression on macOS).
- Mirrored Codex teams are now registered correctly when `setup-codex` runs after teams already exist.

### Changed
- `team --help` lists the new `seed` subcommand.

## [0.1.0] - 2026-04-26

Initial public release.

### Added
- Cross-runtime team orchestration: define once, emit to Claude Code (`/team:<name>` slash commands) and Codex (`~/.codex/agents/<name>.toml` subagents).
- Subcommands: `new`, `delete`, `list`, `setup-claude`, `setup-codex`, `uninstall`.
- Short flags for `team new`: `-n/--name`, `-i/--instructions`, `-m/--model`, `-s/--size`, `-t/--target`.
- Target resolution via `.targets.json`, autodetect of `~/.codex/`, or explicit `--target`.
- `team uninstall` with `--yes`, `--dry-run`, `--keep-teams`, `--purge-codex-config`, `--purge-claude-env`.
- Localized docs: `pt-BR`, `zh-CN`, `zh-TW`, `ja`, `ko`, `tr`.
- Test harness with isolated `$HOME` and `$CLAUDE_PLUGIN_ROOT`; CI-friendly (no network).
- Quick Start in README covering both `/plugin marketplace` and manual install paths.

### Fixed
- Marketplace uses HTTPS git URL with correct `source` discriminator to avoid SSH clone failure on first install.

[0.1.3]: https://github.com/kellvembarbosa/team-orchestrator/releases/tag/v0.1.3
[0.1.2]: https://github.com/kellvembarbosa/team-orchestrator/releases/tag/v0.1.2
[0.1.1]: https://github.com/kellvembarbosa/team-orchestrator/releases/tag/v0.1.1
[0.1.0]: https://github.com/kellvembarbosa/team-orchestrator/releases/tag/v0.1.0
