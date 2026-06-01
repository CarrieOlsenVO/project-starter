#!/usr/bin/env bash
# Verify the template setup is complete. Exit non-zero on any check failure.
set -uo pipefail

fail=0

check() {
  local label="$1"
  local cmd="$2"
  if eval "$cmd" >/dev/null 2>&1; then
    printf "  ok    %s\n" "$label"
  else
    printf "  FAIL  %s\n" "$label"
    fail=1
  fi
}

echo "Verifying tools..."
check "jq runs"                       "jq --version"
check "gitleaks runs"                 "gitleaks version"
check "gh runs"                       "gh --version"

echo "Verifying Claude Code hooks..."
check "validate-commands.sh exists"   "test -f .claude/hooks/validate-commands.sh"
check "validate-commands.sh exec"     "test -x .claude/hooks/validate-commands.sh"
check "protect-files.sh exists"       "test -f .claude/hooks/protect-files.sh"
check "protect-files.sh exec"         "test -x .claude/hooks/protect-files.sh"
check ".claude/settings.json present" "test -f .claude/settings.json"

echo "Verifying git pre-commit hook..."
check "pre-commit script exists"      "test -f .github/hooks/pre-commit"
check "pre-commit script exec"        "test -x .github/hooks/pre-commit"
check ".git/hooks/pre-commit symlink" "test -L .git/hooks/pre-commit"
check ".git/hooks/pre-commit target"  "test -x .git/hooks/pre-commit"

echo "Verifying config files..."
check ".env.example present"          "test -f .env.example"
check ".gitleaks.toml present"        "test -f .gitleaks.toml"
check ".gitignore present"            "test -f .gitignore"

if [[ $fail -ne 0 ]]; then
  echo ""
  echo "Setup is incomplete. See BOOTSTRAP.md."
  exit 1
fi

echo ""
echo "Setup verified."
