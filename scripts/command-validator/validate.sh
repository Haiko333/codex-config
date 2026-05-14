#!/usr/bin/env bash
# Command validator hook for Codex CLI PreToolUse
# Reads JSON from stdin, validates bash commands, outputs JSON decision.
#
# Actions:
#   - rm -rf patterns → deny (CRITICAL)
#   - sudo/kill/dd/mkfs/fdisk/chmod/chown/su/killall → ask (HIGH)
#   - Everything else → allow

set -euo pipefail

INPUT=$(cat)

TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_name',''))" 2>/dev/null || echo "")

if [ "$TOOL_NAME" != "shell" ] && [ "$TOOL_NAME" != "Bash" ]; then
  exit 0
fi

COMMAND=$(echo "$INPUT" | python3 -c "
import sys, json
d = json.load(sys.stdin)
ti = d.get('tool_input', {})
if isinstance(ti, str):
    import json as j
    ti = j.loads(ti)
print(ti.get('command', ti.get('cmd', '')))
" 2>/dev/null || echo "")

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Check for rm -rf patterns (CRITICAL → deny)
if echo "$COMMAND" | grep -qiP '\brm\s+(-[a-zA-Z]*r[a-zA-Z]*f[a-zA-Z]*|-[a-zA-Z]*f[a-zA-Z]*r[a-zA-Z]*)\s'; then
  echo '{"decision":"deny","reason":"CRITICAL: rm -rf command blocked for safety"}'
  exit 0
fi
if echo "$COMMAND" | grep -qiP '\brm\s+-r\s+-f\s'; then
  echo '{"decision":"deny","reason":"CRITICAL: rm -rf command blocked for safety"}'
  exit 0
fi
if echo "$COMMAND" | grep -qiP '\brm\s+-f\s+-r\s'; then
  echo '{"decision":"deny","reason":"CRITICAL: rm -rf command blocked for safety"}'
  exit 0
fi

# Check for dangerous commands (HIGH → ask)
DANGEROUS="sudo su chmod chown dd mkfs fdisk kill killall"
MAIN_CMD=$(echo "$COMMAND" | awk '{print $1}' | xargs basename 2>/dev/null || echo "$COMMAND" | awk '{print $1}')
MAIN_CMD_LOWER=$(echo "$MAIN_CMD" | tr '[:upper:]' '[:lower:]')

for dc in $DANGEROUS; do
  if [ "$MAIN_CMD_LOWER" = "$dc" ]; then
    echo "{\"decision\":\"ask\",\"reason\":\"HIGH: potentially dangerous command '$dc' requires approval\"}"
    exit 0
  fi
done

# Default: allow
exit 0
