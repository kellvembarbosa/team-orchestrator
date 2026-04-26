#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

"$TEAM" setup-codex
"$TEAM" new --name designers --instructions "x" --model sonnet

assert_file "$FAKE_HOME/.codex/agents/designers.toml"   "precondition codex"
assert_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"    "precondition claude"

"$TEAM" delete designers

assert_no_file "$FAKE_HOME/.codex/agents/designers.toml"   "codex removed"
assert_no_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"    "claude removed"
assert_no_file "$CLAUDE_PLUGIN_ROOT/commands/designers.md" "claude cmd removed"

"$TEAM" new --name solo --instructions "x" --target codex
"$TEAM" delete solo
assert_no_file "$FAKE_HOME/.codex/agents/solo.toml" "codex-only removed"
