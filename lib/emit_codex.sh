#!/usr/bin/env bash

codex_dir()        { echo "${HOME}/.codex"; }
codex_agents_dir() { echo "$(codex_dir)/agents"; }
codex_config()     { echo "$(codex_dir)/config.toml"; }

codex_setup() {
  local d cfg
  d="$(codex_agents_dir)"
  cfg="$(codex_config)"
  mkdir -p "$d"
  if [ ! -f "$cfg" ]; then
    cat > "$cfg" <<'EOF'
[agents]
max_threads = 6
max_depth = 1
job_max_runtime_seconds = 1800
EOF
  elif ! grep -q '^\[agents\]' "$cfg"; then
    {
      echo
      echo "[agents]"
      echo "max_threads = 6"
      echo "max_depth = 1"
      echo "job_max_runtime_seconds = 1800"
    } >> "$cfg"
  fi
  echo "Codex agents dir: $d"
  echo "Codex config:     $cfg"
}

codex_emit() {
  local name="$1" instr="$2" model="$3" size="$4"
  if printf '%s' "$instr" | grep -qF "'''"; then
    echo "team: instructions cannot contain triple-quote ''' (TOML conflict)" >&2
    return 1
  fi
  local d
  d="$(codex_agents_dir)"
  mkdir -p "$d"
  local desc_first desc
  desc_first="$(printf '%s' "$instr" | head -n1)"
  desc="$desc_first"
  [ -n "$size" ] && desc="$desc (recommended size: $size)"

  {
    echo "name = \"$name\""
    echo "description = \"$(printf '%s' "$desc" | sed 's/"/\\"/g')\""
    [ -n "$model" ] && echo "model = \"$model\""
    echo "developer_instructions = '''"
    echo "$instr"
    [ -n "$size" ] && { echo ""; echo "(size hint: $size — spawn this many in parallel when invoked)"; }
    echo "'''"
  } > "$d/$name.toml"
}

codex_remove() {
  local name="$1"
  rm -f "$(codex_agents_dir)/$name.toml"
}

codex_has() {
  local name="$1"
  [ -f "$(codex_agents_dir)/$name.toml" ]
}

codex_list_orphans() {
  local d f n
  d="$(codex_agents_dir)"
  [ -d "$d" ] || return 0
  shopt -s nullglob
  for f in "$d"/*.toml; do
    n="$(basename "$f" .toml)"
    [ -f "$CLAUDE_PLUGIN_ROOT/teams/$n.md" ] || echo "$n"
  done
}
