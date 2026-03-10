# Rendered.ai Agent Studio CLI (rai-ast)

A CLI for authenticating and working with the Rendered.ai Agent Studio platform.

## Binary

The CLI binary is `rai-ast`. Resolve it in this order:

```bash
command -v rai-ast                     # already on PATH
$HOME/.local/bin/rai-ast               # default install location
```

If neither exists, install it:

```bash
curl -fsSL https://raw.githubusercontent.com/renderedai/agent-studio-cli/main/install.sh | bash
```

## Key Commands

```bash
rai-ast auth login      # Log in via browser (OAuth2 PKCE relay)
rai-ast auth register   # Create a new account
rai-ast auth whoami     # Show current authenticated user
rai-ast auth logout     # Clear stored credentials
rai-ast workspaces get  # List workspaces
rai-ast status          # Check platform status
```

## Environment Variables

```bash
RENDEREDAI_MANAGER_URL   # Required for auth login/register
RENDEREDAI_DECKARD_URL   # Required for auth register only
RENDEREDAI_API_KEY       # Alternative to interactive login
RENDEREDAI_BEARER_TOKEN  # Highest-priority auth override
```

The CLI loads `.env` automatically from the working directory via dotenvy.

## Auth Flow

Both `auth login` and `auth register` use a two-phase relay pattern designed for
agents (no localhost callback required). See the `rai-ast` skill for the full
step-by-step agent workflow.
