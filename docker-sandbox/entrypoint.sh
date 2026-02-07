#!/bin/bash
# Entrypoint: writes credentials from env var to tmpfs, clears env, runs claude.
# Credentials never touch the host filesystem.

CREDS_DIR="/home/assessor/.claude"
mkdir -p "$CREDS_DIR"

if [ -n "$CLAUDE_CREDS_JSON" ]; then
    printf '%s' "$CLAUDE_CREDS_JSON" > "$CREDS_DIR/.credentials.json"
    chmod 600 "$CREDS_DIR/.credentials.json"
fi

# Clear secrets from environment before exec — prevents leaking to child processes
unset CLAUDE_CREDS_JSON
unset ANTHROPIC_API_KEY
exec "$@"
