#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

# fresh seed creates 24 teams
out="$("$TEAM" seed)"
echo "$out" | grep -q "created=24" || { echo "  expected created=24, got: $out" >&2; exit 1; }
echo "$out" | grep -q "skipped=0"  || { echo "  expected skipped=0, got: $out"  >&2; exit 1; }

# spot-check files
for n in ux-flow-specialist backend-architect security-engineer devils-advocate; do
  assert_file "$CLAUDE_PLUGIN_ROOT/teams/$n.md"     "seed team file: $n"
  assert_file "$CLAUDE_PLUGIN_ROOT/commands/$n.md"  "seed spawn command: $n"
done

# idempotent: re-run skips all
out="$("$TEAM" seed)"
echo "$out" | grep -q "created=0"   || { echo "  re-run created!=0: $out" >&2; exit 1; }
echo "$out" | grep -q "skipped=24"  || { echo "  re-run skipped!=24: $out" >&2; exit 1; }

# partial: delete one, re-seed creates only that one
"$TEAM" delete ux-flow-specialist
out="$("$TEAM" seed)"
echo "$out" | grep -q "created=1"   || { echo "  partial created!=1: $out" >&2; exit 1; }
echo "$out" | grep -q "skipped=23"  || { echo "  partial skipped!=23: $out" >&2; exit 1; }

# reserved name
if "$TEAM" new --name seed --instructions "x" 2>/dev/null; then
  echo "  reserved name 'seed' should fail" >&2; exit 1
fi
