#!/bin/sh
# Self-healing launcher. Files deployed to this folder by tooling can
# arrive without their execute bit or with a quarantine flag — either
# one makes macOS refuse to start the server ("Permission denied" in
# the Claude MCP logs). Repair both on every launch, then hand over.
# The Claude config invokes this via /bin/sh, so this script itself
# needs no execute bit either — the loop is fully closed.
DIR="$(cd "$(dirname "$0")" && pwd)"
chmod +x "$DIR/omnifocus-mcp" 2>/dev/null
xattr -d com.apple.quarantine "$DIR/omnifocus-mcp" 2>/dev/null
exec "$DIR/omnifocus-mcp"
