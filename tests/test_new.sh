#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

"$TEAM" new --name designers --instructions "Design system focus"

assert_file "$CLAUDE_PLUGIN_ROOT/teams/designers.md"     "instructions saved"
assert_file "$CLAUDE_PLUGIN_ROOT/commands/designers.md"  "spawn command generated"
assert_contains "$CLAUDE_PLUGIN_ROOT/teams/designers.md" "Design system focus"
assert_contains "$CLAUDE_PLUGIN_ROOT/commands/designers.md" "designers"

if "$TEAM" new --name designers --instructions "x" 2>/dev/null; then
  echo "  duplicate name should fail" >&2; exit 1
fi

for r in new delete list setup-claude; do
  if "$TEAM" new --name "$r" --instructions "x" 2>/dev/null; then
    echo "  reserved name '$r' should fail" >&2; exit 1
  fi
done

if "$TEAM" new --name "Bad Name" --instructions "x" 2>/dev/null; then
  echo "  invalid slug should fail" >&2; exit 1
fi

"$TEAM" new --name backend --instructions "API work" --model sonnet --size 3
assert_contains "$CLAUDE_PLUGIN_ROOT/teams/backend.md" "model: sonnet"
assert_contains "$CLAUDE_PLUGIN_ROOT/teams/backend.md" "size: 3"
assert_contains "$CLAUDE_PLUGIN_ROOT/teams/backend.md" "API work"
