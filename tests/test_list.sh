#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

out="$("$TEAM" list)"
[ -z "$out" ] || echo "$out" | grep -qi "no teams" || { echo "  empty list output unexpected: $out" >&2; exit 1; }

rmdir "$CLAUDE_PLUGIN_ROOT/teams"
out="$("$TEAM" list)"
echo "$out" | grep -qi "no teams" || { echo "  missing teams dir output unexpected: $out" >&2; exit 1; }
mkdir -p "$CLAUDE_PLUGIN_ROOT/teams"

"$TEAM" new --name alpha --instructions "A"
"$TEAM" new --name beta  --instructions "B" --model sonnet --size 2

out="$("$TEAM" list)"
echo "$out" | grep -q alpha  || { echo "  list missing alpha" >&2; exit 1; }
echo "$out" | grep -q beta   || { echo "  list missing beta"  >&2; exit 1; }
echo "$out" | grep -q sonnet || { echo "  list missing model" >&2; exit 1; }
