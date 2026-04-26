#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

"$TEAM" setup-codex

"$TEAM" new --name designers --instructions "Design system focus" --model sonnet --size 3

CODEX_FILE="$FAKE_HOME/.codex/agents/designers.toml"
assert_file "$CODEX_FILE" "codex toml emitted"
assert_contains "$CODEX_FILE" 'name = "designers"'
assert_contains "$CODEX_FILE" 'model = "sonnet"'
assert_contains "$CODEX_FILE" "developer_instructions"
assert_contains "$CODEX_FILE" "Design system focus"
assert_contains "$CODEX_FILE" "size: 3"

assert_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"     "claude team file"
assert_file "$CLAUDE_PLUGIN_ROOT/commands/designers.md"  "claude spawn cmd"

"$TEAM" new --name api-only --instructions "Backend" --target codex
assert_file    "$FAKE_HOME/.codex/agents/api-only.toml"   "codex-only emitted"
assert_no_file "$CLAUDE_PLUGIN_ROOT/teams/api-only.md"    "claude not written"
assert_no_file "$CLAUDE_PLUGIN_ROOT/commands/api-only.md" "claude cmd not written"

"$TEAM" new --name claude-only --instructions "UI" --target claude
assert_file    "$CLAUDE_PLUGIN_ROOT/teams/claude-only.md"     "claude written"
assert_no_file "$FAKE_HOME/.codex/agents/claude-only.toml"    "codex not written"

if "$TEAM" new --name evil --instructions "has ''' in it" --target codex 2>/dev/null; then
  echo "  triple-quote should be rejected for codex" >&2; exit 1
fi
