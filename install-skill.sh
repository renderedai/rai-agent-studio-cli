#!/bin/sh
# DEPRECATED: Use install-claude-skill.sh instead.
# This wrapper exists for backward compatibility with existing URLs.
echo "NOTE: install-skill.sh is deprecated. Use install-claude-skill.sh instead."
echo ""

REPO="renderedai/rai-agent-studio-cli"
curl -fsSL "https://raw.githubusercontent.com/${REPO}/main/install-claude-skill.sh" | sh
