#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

"$TEAM" new --name designers --instructions "x"
"$TEAM" delete designers

assert_no_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"     "team file removed"
assert_no_file "$CLAUDE_PLUGIN_ROOT/commands/designers.md"  "spawn command removed"

if "$TEAM" delete ghost 2>/dev/null; then
  echo "  delete missing team should fail" >&2; exit 1
fi

for r in new delete list setup-claude; do
  if "$TEAM" delete "$r" 2>/dev/null; then
    echo "  delete reserved '$r' should fail" >&2; exit 1
  fi
done
