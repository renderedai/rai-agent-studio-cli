#!/bin/sh
# Install the rai-ast CLI binary and the rai-ast Gemini CLI skill.
# One-liner usage:
#   curl -fsSL https://raw.githubusercontent.com/renderedai/rai-agent-studio-cli/main/install-gemini-skill.sh | bash

set -e

REPO="renderedai/rai-agent-studio-cli"
SKILL_DIR="${HOME}/.gemini/skills/rai-ast"
SKILL_URL="https://raw.githubusercontent.com/${REPO}/main/skills/rai-ast/SKILL.md"

# ── 1. Install the CLI binary ──────────────────────────────────────────────────
echo "Installing rai-ast CLI..."
curl -fsSL "https://raw.githubusercontent.com/${REPO}/main/install.sh" | sh

# ── 2. Install the Gemini CLI skill ───────────────────────────────────────────
echo ""
echo "Installing rai-ast skill for Gemini CLI..."
mkdir -p "$SKILL_DIR"

if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$SKILL_URL" -o "${SKILL_DIR}/SKILL.md"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "${SKILL_DIR}/SKILL.md" "$SKILL_URL"
else
    echo "ERROR: curl or wget is required to download the skill." >&2
    exit 1
fi

# ── Done ───────────────────────────────────────────────────────────────────────
echo ""
echo "Done!"
echo ""
echo "  CLI binary : $(which rai-ast 2>/dev/null || echo "${HOME}/.local/bin/rai-ast")"
echo "  Skill      : ${SKILL_DIR}/SKILL.md"
echo "  Docs       : ${HOME}/.rai-ast/docs/rai-ast.md"
echo ""
echo "Restart Gemini CLI to activate the rai-ast skill."
echo ""
echo "Tip: install as a full extension instead (includes context file):"
echo "  gemini extensions install https://github.com/renderedai/rai-agent-studio-cli"
