#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

SETTINGS="$FAKE_HOME/.claude/settings.json"

HOME="$FAKE_HOME" "$TEAM" setup-claude
assert_file "$SETTINGS" "settings.json created"
val="$(jq -r '.env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS' "$SETTINGS")"
assert_eq "$val" "1" "flag set on fresh"

echo '{"theme":"dark","env":{"OTHER":"keep"}}' > "$SETTINGS"
HOME="$FAKE_HOME" "$TEAM" setup-claude
assert_eq "$(jq -r '.theme' "$SETTINGS")" "dark" "theme preserved"
assert_eq "$(jq -r '.env.OTHER' "$SETTINGS")" "keep" "other env preserved"
assert_eq "$(jq -r '.env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS' "$SETTINGS")" "1" "flag added"

HOME="$FAKE_HOME" "$TEAM" setup-claude
assert_eq "$(jq -r '.env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS' "$SETTINGS")" "1" "idempotent"
