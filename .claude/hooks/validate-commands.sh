#!/usr/bin/env bash
# Deterministic block on dangerous shell commands.
# Exit 0 = allow, Exit 2 = block (stderr shown to Claude).
set -euo pipefail

input=$(cat)
command=$(echo "$input" | jq -r '.tool_input.command // empty')

[[ -z "$command" ]] && exit 0

deny_patterns=(
  'rm[[:space:]]+-rf[[:space:]]+/'
  'rm[[:space:]]+-rf[[:space:]]+~'
  'rm[[:space:]]+-rf[[:space:]]+\$HOME'
  'rm[[:space:]]+-rf[[:space:]]+\*'
  'git[[:space:]]+push[[:space:]]+.*--force.*[[:space:]]+(origin/)?main'
  'git[[:space:]]+push[[:space:]]+.*-f[[:space:]]+(origin/)?main'
  'git[[:space:]]+reset[[:space:]]+--hard[[:space:]]+origin/main'
  'curl[[:space:]]+.*\|[[:space:]]*(bash|sh|zsh)'
  'wget[[:space:]]+.*\|[[:space:]]*(bash|sh|zsh)'
  'sudo[[:space:]]+'
  'dd[[:space:]]+if=.*[[:space:]]+of=/dev/'
  'mkfs\.'
  ':\(\)\{[[:space:]]*:\|:&[[:space:]]*\};[[:space:]]*:'
  '--no-verify'
)

for pattern in "${deny_patterns[@]}"; do
  if [[ "$command" =~ $pattern ]]; then
    echo "BLOCKED by hook: command matched dangerous pattern" >&2
    echo "Pattern: $pattern" >&2
    echo "Command: $command" >&2
    exit 2
  fi
done

exit 0
