#!/usr/bin/env bash
set -euo pipefail

PLUGIN_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_ROOT="$(mktemp -d -t teamtest.XXXXXX)"
trap 'rm -rf "$TMP_ROOT"' EXIT

cp -R "$PLUGIN_SRC/.claude-plugin" "$TMP_ROOT/" 2>/dev/null || true
cp -R "$PLUGIN_SRC/bin"            "$TMP_ROOT/" 2>/dev/null || true
cp -R "$PLUGIN_SRC/lib"            "$TMP_ROOT/" 2>/dev/null || true
cp -R "$PLUGIN_SRC/commands"       "$TMP_ROOT/" 2>/dev/null || true
mkdir -p "$TMP_ROOT/teams" "$TMP_ROOT/commands"

export FAKE_HOME="$TMP_ROOT/home"
mkdir -p "$FAKE_HOME/.claude"
export HOME="$FAKE_HOME"

export CLAUDE_PLUGIN_ROOT="$TMP_ROOT"
export TEAM="$TMP_ROOT/bin/team"

assert_eq() {
  if [ "$1" != "$2" ]; then
    echo "  assert_eq FAIL: expected='$2' actual='$1'  ($3)" >&2
    exit 1
  fi
}
assert_file() {
  [ -f "$1" ] || { echo "  assert_file FAIL: missing $1  ($2)" >&2; exit 1; }
}
assert_no_file() {
  [ ! -e "$1" ] || { echo "  assert_no_file FAIL: exists $1  ($2)" >&2; exit 1; }
}
assert_contains() {
  grep -qF "$2" "$1" || { echo "  assert_contains FAIL: '$2' not in $1" >&2; exit 1; }
}
