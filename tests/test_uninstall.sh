#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

"$TEAM" setup-codex
"$TEAM" new --name designers --instructions "design"
"$TEAM" new --name backend   --instructions "api" --target codex
"$TEAM" new --name frontend  --instructions "ui"  --target claude

cat > "$FAKE_HOME/.codex/agents/orphan.toml" <<EOF
name = "orphan"
description = "manual"
developer_instructions = '''x'''
EOF

assert_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"        "pre claude team"
assert_file "$CLAUDE_PLUGIN_ROOT/commands/designers.md"     "pre claude cmd"
assert_file "$FAKE_HOME/.codex/agents/designers.toml"       "pre codex team"
assert_file "$FAKE_HOME/.codex/agents/backend.toml"         "pre codex-only"
assert_file "$CLAUDE_PLUGIN_ROOT/teams/frontend.md"         "pre claude-only team"
assert_file "$FAKE_HOME/.codex/agents/orphan.toml"          "pre orphan"
assert_file "$CLAUDE_PLUGIN_ROOT/.targets.json"             "pre targets"

"$TEAM" uninstall --yes --dry-run >/dev/null
assert_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"        "dry-run keeps team"
assert_file "$FAKE_HOME/.codex/agents/orphan.toml"          "dry-run keeps orphan"
assert_file "$CLAUDE_PLUGIN_ROOT/.targets.json"             "dry-run keeps targets"

"$TEAM" uninstall --yes >/dev/null

assert_no_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"     "claude team removed"
assert_no_file "$CLAUDE_PLUGIN_ROOT/commands/designers.md"  "claude cmd removed"
assert_no_file "$CLAUDE_PLUGIN_ROOT/teams/frontend.md"      "claude-only removed"
assert_no_file "$FAKE_HOME/.codex/agents/designers.toml"    "codex shared removed"
assert_no_file "$FAKE_HOME/.codex/agents/backend.toml"      "codex-only removed"
assert_no_file "$FAKE_HOME/.codex/agents/orphan.toml"       "orphan removed"
assert_no_file "$CLAUDE_PLUGIN_ROOT/.targets.json"          "targets removed"

assert_file "$CLAUDE_PLUGIN_ROOT/commands/new.md"          "reserved new.md kept"
assert_file "$CLAUDE_PLUGIN_ROOT/commands/delete.md"       "reserved delete.md kept"
assert_file "$CLAUDE_PLUGIN_ROOT/commands/list.md"         "reserved list.md kept"
assert_file "$CLAUDE_PLUGIN_ROOT/commands/setup-claude.md" "reserved setup-claude.md kept"
assert_file "$CLAUDE_PLUGIN_ROOT/commands/setup-codex.md"  "reserved setup-codex.md kept"

assert_file "$FAKE_HOME/.codex/config.toml"                 "codex config kept"
assert_contains "$FAKE_HOME/.codex/config.toml" "[agents]"

"$TEAM" uninstall --yes >/dev/null

if "$TEAM" new --name uninstall --instructions "x" 2>/dev/null; then
  echo "  reserved name 'uninstall' should fail" >&2; exit 1
fi

"$TEAM" setup-codex
cat > "$FAKE_HOME/.codex/config.toml" <<EOF
model = "gpt-5"
foo = "bar"

[agents]
max_threads = 6
max_depth = 1
job_max_runtime_seconds = 1800

[other]
keep = "me"
EOF
"$TEAM" uninstall --yes --purge-codex-config >/dev/null
assert_file "$FAKE_HOME/.codex/config.toml" "config still exists"
if grep -q '^\[agents\]' "$FAKE_HOME/.codex/config.toml"; then
  echo "  [agents] block should be purged" >&2; exit 1
fi
assert_contains "$FAKE_HOME/.codex/config.toml" "[other]"
assert_contains "$FAKE_HOME/.codex/config.toml" 'model = "gpt-5"'

mkdir -p "$FAKE_HOME/.claude"
cat > "$FAKE_HOME/.claude/settings.json" <<EOF
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1",
    "OTHER": "keep"
  },
  "model": "sonnet"
}
EOF
"$TEAM" uninstall --yes --purge-claude-env >/dev/null
val="$(jq -r '.env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS // "absent"' "$FAKE_HOME/.claude/settings.json")"
assert_eq "$val" "absent" "env var purged"
val2="$(jq -r '.env.OTHER' "$FAKE_HOME/.claude/settings.json")"
assert_eq "$val2" "keep" "other env preserved"
val3="$(jq -r '.model' "$FAKE_HOME/.claude/settings.json")"
assert_eq "$val3" "sonnet" "top-level keys preserved"

"$TEAM" setup-codex
"$TEAM" new --name kept --instructions "keep me"
assert_file "$CLAUDE_PLUGIN_ROOT/teams/kept.md" "pre keep"
"$TEAM" uninstall --yes --keep-teams >/dev/null
assert_file    "$CLAUDE_PLUGIN_ROOT/teams/kept.md"     "keep-teams kept claude"
assert_file    "$FAKE_HOME/.codex/agents/kept.toml"    "keep-teams kept codex"
assert_no_file "$CLAUDE_PLUGIN_ROOT/.targets.json"     "keep-teams cleared targets"
