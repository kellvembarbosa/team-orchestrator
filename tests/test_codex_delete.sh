#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

"$TEAM" setup-codex
"$TEAM" new --name designers --instructions "x" --model sonnet

assert_file "$FAKE_HOME/.codex/agents/designers.toml"   "precondition codex"
assert_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"    "precondition claude"
assert_contains "$FAKE_HOME/.codex/config.toml" "[agents.designers]"

"$TEAM" delete designers

assert_no_file "$FAKE_HOME/.codex/agents/designers.toml"   "codex removed"
assert_no_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"    "claude removed"
assert_no_file "$CLAUDE_PLUGIN_ROOT/commands/designers.md" "claude cmd removed"
if grep -qF "[agents.designers]" "$FAKE_HOME/.codex/config.toml"; then
  echo "  designers config block should be removed" >&2; exit 1
fi

"$TEAM" new --name solo --instructions "x" --target codex
"$TEAM" delete solo
assert_no_file "$FAKE_HOME/.codex/agents/solo.toml" "codex-only removed"
if grep -qF "[agents.solo]" "$FAKE_HOME/.codex/config.toml"; then
  echo "  solo config block should be removed" >&2; exit 1
fi
