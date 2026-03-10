#!/bin/sh
# Install the rai-ast CLI binary and the rai-ast OpenAI Codex skill.
# One-liner usage:
#   curl -fsSL https://raw.githubusercontent.com/renderedai/agent-studio-cli/main/install-codex-skill.sh | bash

set -e

REPO="renderedai/agent-studio-cli"
SKILL_DIR="${HOME}/.codex/skills/rai-ast"
SKILL_URL="https://raw.githubusercontent.com/${REPO}/main/skills/rai-ast/SKILL.md"
OPENAI_YAML_URL="https://raw.githubusercontent.com/${REPO}/main/skills/rai-ast/agents/openai.yaml"

# ── 1. Install the CLI binary ──────────────────────────────────────────────────
echo "Installing rai-ast CLI..."
curl -fsSL "https://raw.githubusercontent.com/${REPO}/main/install.sh" | sh

# ── 2. Install the Codex skill ─────────────────────────────────────────────────
echo ""
echo "Installing rai-ast skill for OpenAI Codex..."
mkdir -p "${SKILL_DIR}/agents"

if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$SKILL_URL" -o "${SKILL_DIR}/SKILL.md"
    curl -fsSL "$OPENAI_YAML_URL" -o "${SKILL_DIR}/agents/openai.yaml"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "${SKILL_DIR}/SKILL.md" "$SKILL_URL"
    wget -qO "${SKILL_DIR}/agents/openai.yaml" "$OPENAI_YAML_URL"
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
echo "Restart Codex to activate the rai-ast skill."
