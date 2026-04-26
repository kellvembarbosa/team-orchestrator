#!/usr/bin/env bash
TARGETS_FILE="${CLAUDE_PLUGIN_ROOT:-.}/.targets.json"
KNOWN_TARGETS="claude codex"

targets_validate_csv() {
  local csv="$1" t
  IFS=',' read -ra arr <<< "$csv"
  for t in "${arr[@]}"; do
    case " $KNOWN_TARGETS " in
      *" $t "*) ;;
      *) echo "team: unknown target '$t' (known: $KNOWN_TARGETS)" >&2; return 1 ;;
    esac
  done
}

targets_resolve() {
  local explicit="${1:-}"
  if [ -n "$explicit" ]; then
    targets_validate_csv "$explicit" || return 1
    echo "$explicit" | tr ',' ' '
    return
  fi
  if [ -f "$TARGETS_FILE" ]; then
    local out=""
    [ "$(jq -r '.claude // false' "$TARGETS_FILE")" = "true" ] && out="$out claude"
    [ "$(jq -r '.codex  // false' "$TARGETS_FILE")" = "true" ] && out="$out codex"
    if [ -n "$out" ]; then echo "$out"; return; fi
  fi
  local out="claude"
  [ -d "${HOME}/.codex" ] && out="$out codex"
  echo "$out"
}

targets_persist_codex() {
  mkdir -p "$(dirname "$TARGETS_FILE")"
  local current='{}'
  [ -f "$TARGETS_FILE" ] && current="$(cat "$TARGETS_FILE")"
  echo "$current" | jq '. + {claude: (.claude // true), codex: true}' > "$TARGETS_FILE.tmp"
  mv "$TARGETS_FILE.tmp" "$TARGETS_FILE"
}
