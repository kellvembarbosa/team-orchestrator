#!/usr/bin/env bash
. "$(dirname "$0")/_helper.sh"

mkdir -p "$FAKE_HOME/.codex"
"$TEAM" new --name shared      --instructions "both"
"$TEAM" new --name claude-only --instructions "x" --target claude
"$TEAM" new --name codex-only  --instructions "x" --target codex

cat > "$FAKE_HOME/.codex/agents/orphan.toml" <<EOF
name = "orphan"
description = "manual"
developer_instructions = '''hello'''
EOF

out="$("$TEAM" list)"
echo "$out" | grep -q shared       || { echo "  missing shared" >&2; exit 1; }
echo "$out" | grep -q claude-only  || { echo "  missing claude-only" >&2; exit 1; }
echo "$out" | grep -q codex-only   || { echo "  missing codex-only" >&2; exit 1; }
echo "$out" | grep -q orphan       || { echo "  missing orphan" >&2; exit 1; }
echo "$out" | grep -q CLAUDE       || { echo "  missing CLAUDE column" >&2; exit 1; }
echo "$out" | grep -q CODEX        || { echo "  missing CODEX column"  >&2; exit 1; }
