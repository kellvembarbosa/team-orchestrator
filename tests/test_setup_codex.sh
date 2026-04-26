#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

CONFIG="$FAKE_HOME/.codex/config.toml"
AGENTS="$FAKE_HOME/.codex/agents"
TARGETS="$CLAUDE_PLUGIN_ROOT/.targets.json"

"$TEAM" setup-codex
[ -d "$AGENTS" ] || { echo "  agents dir not created" >&2; exit 1; }
assert_file "$CONFIG" "config.toml created"
assert_contains "$CONFIG" "[agents]"
assert_file "$TARGETS" ".targets.json created"
assert_contains "$TARGETS" '"codex"'

"$TEAM" setup-codex
count="$(grep -c '^\[agents\]' "$CONFIG")"
assert_eq "$count" "1" "no duplicate [agents] block"

cat > "$CONFIG" <<EOF
model = "gpt-5"

[agents]
max_threads = 8
EOF
"$TEAM" setup-codex
assert_contains "$CONFIG" 'model = "gpt-5"'
assert_contains "$CONFIG" "max_threads = 8"
count="$(grep -c '^\[agents\]' "$CONFIG")"
assert_eq "$count" "1" "still single [agents]"
