#!/usr/bin/env bash
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
PASS=0; FAIL=0; FAILED=()
for t in "$HERE"/test_*.sh; do
  name="$(basename "$t")"
  if bash "$t"; then
    echo "PASS $name"; PASS=$((PASS+1))
  else
    echo "FAIL $name"; FAIL=$((FAIL+1)); FAILED+=("$name")
  fi
done
echo "---"
echo "Passed: $PASS  Failed: $FAIL"
[ $FAIL -eq 0 ] || { printf 'Failed tests:\n'; printf '  %s\n' "${FAILED[@]}"; exit 1; }
