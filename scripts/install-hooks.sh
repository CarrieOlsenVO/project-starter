#!/usr/bin/env bash
# One-time setup: chmod the hooks, install the git pre-commit hook.
set -euo pipefail

chmod +x .claude/hooks/*.sh
chmod +x .github/hooks/pre-commit

mkdir -p .git/hooks
ln -sf ../../.github/hooks/pre-commit .git/hooks/pre-commit

echo "Hooks installed. Verify with: bash scripts/verify-setup.sh"
