#!/usr/bin/env bash

claude_emit() {
  local name="$1" instr="$2" model="$3" size="$4"
  local teams_dir="$CLAUDE_PLUGIN_ROOT/teams"
  local cmds_dir="$CLAUDE_PLUGIN_ROOT/commands"
  mkdir -p "$teams_dir" "$cmds_dir"

  {
    echo "---"
    echo "name: $name"
    [ -n "$model" ] && echo "model: $model"
    [ -n "$size" ]  && echo "size: $size"
    echo "---"
    echo
    echo "$instr"
  } > "$teams_dir/$name.md"

  cat > "$cmds_dir/$name.md" <<EOF
---
description: Spawn the $name agent team
argument-hint: [extra instructions]
allowed-tools: Read
---

Spawn an agent team named "$name" using the stored team definition.

1. Read the team configuration from \`\${CLAUDE_PLUGIN_ROOT}/teams/$name.md\`. Frontmatter may include \`model\` and \`size\` hints; body holds the team's instructions.
2. Create an agent team that follows those instructions. Honor \`model\` and \`size\` hints if present.
3. Incorporate this additional user context into the spawn prompt (may be empty): \$ARGUMENTS
EOF
}

claude_remove() {
  local name="$1"
  rm -f "$CLAUDE_PLUGIN_ROOT/teams/$name.md" "$CLAUDE_PLUGIN_ROOT/commands/$name.md"
}

claude_has() {
  local name="$1"
  [ -f "$CLAUDE_PLUGIN_ROOT/teams/$name.md" ]
}

claude_list_names() {
  local d="$CLAUDE_PLUGIN_ROOT/teams"
  [ -d "$d" ] || return 0
  shopt -s nullglob
  local f n
  for f in "$d"/*.md; do
    n="$(basename "$f" .md)"
    echo "$n"
  done
}

claude_remove_all() {
  local n
  for n in $(claude_list_names); do
    claude_remove "$n"
  done
  rmdir "$CLAUDE_PLUGIN_ROOT/teams" 2>/dev/null || true
}
