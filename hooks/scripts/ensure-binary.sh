#!/bin/sh
# Ensure the rai-ast CLI binary is installed.
# Runs at session start when the rai-ast Claude Code plugin is enabled.

BINARY="rai-ast"
DEFAULT_INSTALL="$HOME/.local/bin/$BINARY"

# Already on PATH — nothing to do
if command -v "$BINARY" >/dev/null 2>&1; then
    exit 0
fi

# Already installed at default location — nothing to do
if [ -x "$DEFAULT_INSTALL" ]; then
    exit 0
fi

# Not found — install from GitHub Releases
echo "[rai-ast plugin] Installing $BINARY CLI..."
if curl -fsSL https://raw.githubusercontent.com/rai-ast/agent-studio-cli/main/install.sh | sh; then
    echo "[rai-ast plugin] $BINARY installed to $DEFAULT_INSTALL"
else
    echo "[rai-ast plugin] WARNING: Could not auto-install $BINARY. Run the installer manually:" >&2
    echo "  curl -fsSL https://raw.githubusercontent.com/rai-ast/agent-studio-cli/main/install.sh | bash" >&2
fi
