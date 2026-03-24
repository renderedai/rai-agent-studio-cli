#!/bin/sh
# Install the rai-ast CLI binary and the rai-ast Claude Code skill.
# One-liner usage:
#   curl -fsSL https://raw.githubusercontent.com/renderedai/rai-agent-studio-cli/main/install-claude-skill.sh | bash

set -e

REPO="renderedai/rai-agent-studio-cli"
SKILL_DIR="${HOME}/.claude/skills/rai-ast"
BIN_DIR="${SKILL_DIR}/bin"
SKILL_URL="https://raw.githubusercontent.com/${REPO}/main/skills/rai-ast/SKILL.md"

# ── 1. Install the CLI binary into the skill directory ───────────────────────
echo "Installing rai-ast CLI..."
RENDEREDAI_INSTALL_DIR="$BIN_DIR" \
RENDEREDAI_SKIP_DOCS=1 \
RENDEREDAI_SKIP_PATH_HINT=1 \
  curl -fsSL "https://raw.githubusercontent.com/${REPO}/main/install.sh" | sh

# ── 2. Install the Claude Code skill ────────────────────────────────────────
echo ""
echo "Installing rai-ast skill for Claude Code..."
mkdir -p "$SKILL_DIR"

if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$SKILL_URL" -o "${SKILL_DIR}/SKILL.md"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "${SKILL_DIR}/SKILL.md" "$SKILL_URL"
else
    echo "ERROR: curl or wget is required to download the skill." >&2
    exit 1
fi

# ── 3. Best-effort symlink to ~/.local/bin ───────────────────────────────────
SYMLINK_TARGET="${HOME}/.local/bin/rai-ast"
SYMLINK_DIR="$(dirname "$SYMLINK_TARGET")"
SYMLINK_MSG=""
if [ -d "$SYMLINK_DIR" ] && [ -w "$SYMLINK_DIR" ]; then
    ln -sf "${BIN_DIR}/rai-ast" "$SYMLINK_TARGET" 2>/dev/null && \
        SYMLINK_MSG="  Symlink    : ${SYMLINK_TARGET} -> ${BIN_DIR}/rai-ast"
fi

# ── Done ─────────────────────────────────────────────────────────────────────
echo ""
echo "Done!"
echo ""
echo "  Binary     : ${BIN_DIR}/rai-ast"
echo "  Skill      : ${SKILL_DIR}/SKILL.md"
if [ -n "$SYMLINK_MSG" ]; then
    echo "$SYMLINK_MSG"
fi
echo ""
echo "Reload Claude Code to activate the /rai-ast skill."
