#!/usr/bin/env bash
# Deterministic block on writes to sensitive files.
set -euo pipefail

input=$(cat)
file_path=$(echo "$input" | jq -r '.tool_input.file_path // empty')

[[ -z "$file_path" ]] && exit 0

protected=(
  '\.env$'
  '\.env\.local$'
  '\.env\.production$'
  '\.env\.development$'
  'credentials.*\.json$'
  '\.aws/credentials'
  '\.ssh/'
  '\.gnupg/'
  '\.git/hooks/'
)

for pattern in "${protected[@]}"; do
  if [[ "$file_path" =~ $pattern ]]; then
    echo "BLOCKED by hook: write to protected path" >&2
    echo "Path: $file_path" >&2
    exit 2
  fi
done

exit 0
