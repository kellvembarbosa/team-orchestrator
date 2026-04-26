#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

"$TEAM" new --name a --instructions "x"
assert_file    "$CLAUDE_PLUGIN_ROOT/teams/a.md"  "claude default"
assert_no_file "$FAKE_HOME/.codex/agents/a.toml" "no codex (not set up)"

mkdir -p "$FAKE_HOME/.codex"
"$TEAM" new --name b --instructions "x"
assert_file "$CLAUDE_PLUGIN_ROOT/teams/b.md"     "claude still"
assert_file "$FAKE_HOME/.codex/agents/b.toml"    "codex auto-detected"

if "$TEAM" new --name c --instructions "x" --target foo 2>/dev/null; then
  echo "  unknown target should fail" >&2; exit 1
fi

"$TEAM" new --name d --instructions "x" --target claude,codex
assert_file "$CLAUDE_PLUGIN_ROOT/teams/d.md"     "csv claude"
assert_file "$FAKE_HOME/.codex/agents/d.toml"    "csv codex"
